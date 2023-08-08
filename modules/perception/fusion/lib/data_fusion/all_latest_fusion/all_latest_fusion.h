/******************************************************************************
 * Copyright 2022 The Apollo Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *****************************************************************************/

#pragma once

#include <mutex>
#include <string>
#include <vector>

#include "modules/perception/fusion/base/fusion_frame.h"
#include "modules/perception/pipeline/stage.h"


namespace apollo {
namespace perception {
namespace fusion {


class AllLatestFusion : public pipeline::Stage {
 public:
  using StageConfig = pipeline::StageConfig;
  using DataFrame = pipeline::DataFrame;

 public:
  AllLatestFusion() = default;
  ~AllLatestFusion() = default;

  bool Init(const StageConfig& stage_config) override;

  bool Process(DataFrame* data_frame) override;

  bool IsEnabled() const override { return enable_; }

  std::string Name() const override { return name_; }

 private:
  bool IsPublishSensor(const base::FrameConstPtr& sensor_frame) const;

 private:
  AllLatestFusionConfig all_latest_fusion_config_;

  std::mutex data_mutex_;
  std::mutex fuse_mutex_;

  // FusionParams params_;
  bool use_lidar_;
  bool use_radar_;
  bool use_camera_;

  std::string main_sensor_;
};


}  // namespace fusion
}  // namespace perception
}  // namespace apollo
