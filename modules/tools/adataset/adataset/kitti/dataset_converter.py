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
'''Generate apollo record file by kitti raw sensor data.'''

import logging
import numpy as np

from cyber_record.record import Record
from record_msg.builder import (
  ImageBuilder,
  PointCloudBuilder,
  LocalizationBuilder,
  TransformBuilder)
from adataset.kitti.kitti import KITTISchema, KITTI
from adataset.kitti.geometry import Quaternion


LOCALIZATION_TOPIC = '/apollo/localization/pose'
TF_TOPIC= '/tf'


# Need to convert to apollo coordinate system
imu_to_velo = np.array(
    [[ 9.999976e-01, 7.553071e-04,-2.035826e-03,-8.086759e-01],
     [-7.854027e-04, 9.998898e-01,-1.482298e-02, 3.195559e-01],
     [ 2.024406e-03, 1.482454e-02, 9.998881e-01,-7.997231e-01],
     [ 0.0000000, 0.0000000, 0.0000000, 1.0000000]])

kitti_to_apollo = np.array([[ 0.0000000, 1.0000000, 0.0000000, 0.0000000],
                            [-1.0000000, 0.0000000, 0.0000000, 0.0000000],
                            [ 0.0000000, 0.0000000, 1.0000000, 0.0000000],
                            [ 0.0000000, 0.0000000, 0.0000000, 1.0000000]])

LIDAR_TRANSFORM = np.matmul(np.linalg.inv(imu_to_velo), kitti_to_apollo)

def dataset_to_record(kitti, record_root_path):
  """Construct record message and save it as record

  Args:
      kitti (_type_): kitti
      record_root_path (str): record file saved path
  """
  image_builder = ImageBuilder()
  pc_builder = PointCloudBuilder()
  localization_builder = LocalizationBuilder()
  transform_builder = TransformBuilder()

  with Record(record_root_path, mode='w') as record:
    for msg in kitti:
      c, f, ego_pose, t = msg.channel, msg.file_path, msg.ego_pose, msg.timestamp
      logging.debug("{}, {}, {}, {}".format(c, f, ego_pose, t))
      pb_msg = None
      # There're mix gray and rgb image files, so we just choose rgb image
      if c == 'image_02' or c == 'image_03':
        # KITTI image types: 'gray', 'bgr8'
        pb_msg = image_builder.build(f, 'camera', 'bgr8', t)
        channel_name = "/apollo/sensor/camera/{}/image".format(c)
      elif c.startswith('velodyne'):
        pb_msg = pc_builder.build_nuscenes(f, 'velodyne', t, LIDAR_TRANSFORM)
        channel_name = "/apollo/sensor/{}/compensator/PointCloud2".format(c)

      if pb_msg:
        record.write(channel_name, pb_msg, int(t*1e9))

      if ego_pose:
        rotation = ego_pose.rotation
        quat = Quaternion(rotation[0], rotation[1], rotation[2], rotation[3])
        heading = quat.to_euler().yaw

        pb_msg = localization_builder.build(
          ego_pose.translation, ego_pose.rotation, heading, t)
        if pb_msg:
          record.write(LOCALIZATION_TOPIC, pb_msg, int(t*1e9))

        pb_msg = transform_builder.build('world', 'localization',
          ego_pose.translation, ego_pose.rotation, t)
        if pb_msg:
          record.write(TF_TOPIC, pb_msg, int(t*1e9))


def convert_dataset(dataset_path, record_path):
  """Generate apollo record file by KITTI dataset

  Args:
      dataset_path (str): KITTI dataset path
      record_path (str): record file saved path
  """
  kitti_schema = KITTISchema(dataroot=dataset_path)
  kitti = KITTI(kitti_schema)

  print("Start to convert scene, Pls wait!")
  dataset_to_record(kitti, record_path)
  print("Success! Records saved in '{}'".format(record_path))
