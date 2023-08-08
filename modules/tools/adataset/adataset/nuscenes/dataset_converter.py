#!/usr/bin/env python3

###############################################################################
# Copyright 2022 The Apollo Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################
'''Generate apollo record file by nuscenes raw sensor data.'''

import os
import logging
import numpy as np

from cyber_record.record import Record
from record_msg.builder import (
  ImageBuilder,
  PointCloudBuilder,
  LocalizationBuilder,
  TransformBuilder)
from adataset.nuscenes.nuscenes import NuScenesSchema, NuScenesHelper, NuScenes
from adataset.nuscenes.geometry import Quaternion


LOCALIZATION_TOPIC = '/apollo/localization/pose'
TF_TOPIC= '/tf'


# Need to convert to apollo coordinate system, for nuscenes is 90 degrees
LIDAR_TRANSFORM = np.array([[ 0.0020333, 0.9997041, 0.0242417, 0.9437130],
                            [-0.9999805, 0.0021757,-0.0058486, 0.0000000],
                            [-0.0058997,-0.0242294, 0.9996890, 1.8402300],
                            [ 0.0000000, 0.0000000, 0.0000000, 1.0000000]])

def dataset_to_record(nuscenes, record_root_path):
  """Construct record message and save it as record

  Args:
      nuscenes (_type_): nuscenes(one scene)
      record_root_path (str): record file saved path
  """
  image_builder = ImageBuilder()
  pc_builder = PointCloudBuilder(dim=5)
  localization_builder = LocalizationBuilder()
  transform_builder = TransformBuilder()

  record_file_name = "{}.record".format(nuscenes.scene_token)
  record_file_path = os.path.join(record_root_path, record_file_name)

  with Record(record_file_path, mode='w') as record:
    for c, f, ego_pose, calibrated_sensor, t in nuscenes:
      logging.debug("{}, {}, {}, {}".format(c, f, ego_pose, t))
      pb_msg = None
      if c.startswith('CAM'):
        pb_msg = image_builder.build(f, 'camera', 'rgb8', t/1e6)
        channel_name = "/apollo/sensor/camera/{}/image".format(c)
      elif c.startswith('LIDAR'):
        pb_msg = pc_builder.build_nuscenes(f, 'velodyne', t/1e6, LIDAR_TRANSFORM)
        channel_name = "/apollo/sensor/{}/compensator/PointCloud2".format(c)

      if pb_msg:
        record.write(channel_name, pb_msg, t*1000)

      rotation = ego_pose['rotation']
      quat = Quaternion(rotation[0], rotation[1], rotation[2], rotation[3])
      heading = quat.to_euler().yaw

      ego_pose_t = ego_pose['timestamp']
      pb_msg = localization_builder.build(
        ego_pose['translation'], ego_pose['rotation'], heading, ego_pose_t/1e6)
      if pb_msg:
        record.write(LOCALIZATION_TOPIC, pb_msg, ego_pose_t*1000)

      pb_msg = transform_builder.build('world', 'localization',
        ego_pose['translation'], ego_pose['rotation'], ego_pose_t/1e6)
      if pb_msg:
        record.write(TF_TOPIC, pb_msg, ego_pose_t*1000)

def convert_dataset(dataset_path, record_path):
  """Generate apollo record file by nuscenes dataset

  Args:
      dataset_path (str): nuscenes dataset path
      record_path (str): record file saved path
  """
  nuscenes_schema = NuScenesSchema(dataroot=dataset_path)
  n_helper = NuScenesHelper(nuscenes_schema)

  for scene_token in nuscenes_schema.scene.keys():
    print("Start to convert scene: {}, Pls wait!".format(scene_token))
    nuscenes = NuScenes(n_helper, scene_token)
    dataset_to_record(nuscenes, record_path)
  print("Success! Records saved in '{}'".format(record_path))
