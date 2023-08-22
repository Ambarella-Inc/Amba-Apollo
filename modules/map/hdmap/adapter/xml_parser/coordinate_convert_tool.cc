/* Copyright 2017 The Apollo Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=========================================================================*/
#include "modules/map/hdmap/adapter/xml_parser/coordinate_convert_tool.h"

#include "glog/logging.h"

namespace apollo {
namespace hdmap {
namespace adapter {

CoordinateConvertTool::CoordinateConvertTool()
#if PROJ_VERSION_MAJOR<8
    : pj_from_(nullptr), pj_to_(nullptr) {}
#else
    : pj_conv_(nullptr) {}
#endif

CoordinateConvertTool::~CoordinateConvertTool() {
#if PROJ_VERSION_MAJOR<8
  if (pj_from_) {
    pj_free(pj_from_);
    pj_from_ = nullptr;
  }

  if (pj_to_) {
    pj_free(pj_to_);
    pj_to_ = nullptr;
  }
#else
  if (pj_conv_) {
    proj_destroy(pj_conv_);
    pj_conv_ = nullptr;
  }
#endif
}

CoordinateConvertTool* CoordinateConvertTool::GetInstance() {
  static CoordinateConvertTool instance;
  return &instance;
}

Status CoordinateConvertTool::SetConvertParam(const std::string& source_param,
                                              const std::string& dst_param) {
  source_convert_param_ = source_param;
  dst_convert_param_ = dst_param;
#if PROJ_VERSION_MAJOR<8
  if (pj_from_) {
    pj_free(pj_from_);
    pj_from_ = nullptr;
  }

  if (pj_to_) {
    pj_free(pj_to_);
    pj_to_ = nullptr;
  }

  if (!(pj_from_ = pj_init_plus(source_convert_param_.c_str()))) {
    std::string err_msg = "Fail to pj_init_plus " + source_convert_param_;
    return Status(apollo::common::ErrorCode::HDMAP_DATA_ERROR, err_msg);
  }

  if (!(pj_to_ = pj_init_plus(dst_convert_param_.c_str()))) {
    std::string err_msg = "Fail to pj_init_plus " + dst_convert_param_;
    pj_free(pj_from_);
    pj_from_ = nullptr;
    return Status(apollo::common::ErrorCode::HDMAP_DATA_ERROR, err_msg);
  }
#else
  if (pj_conv_) {
    proj_destroy(pj_conv_);
    pj_conv_ = nullptr;
  }
  if (!(pj_conv_ = proj_create_crs_to_crs(PJ_DEFAULT_CTX, source_convert_param_.c_str(), dst_convert_param_.c_str(), NULL)))
  {
    std::string err_msg = "Fail to pj_init from :" + source_convert_param_ + "to :" + dst_convert_param_;
    return Status(apollo::common::ErrorCode::HDMAP_DATA_ERROR, err_msg);
  }
#endif
  return Status::OK();
}

Status CoordinateConvertTool::CoordiateConvert(const double longitude,
                                               const double latitude,
                                               const double height_ellipsoid,
                                               double* utm_x, double* utm_y,
                                               double* utm_z) {
  CHECK_NOTNULL(utm_x);
  CHECK_NOTNULL(utm_y);
  CHECK_NOTNULL(utm_z);
#if PROJ_VERSION_MAJOR<8
  if (!pj_from_ || !pj_to_) {
    std::string err_msg = "no transform param";
    return Status(apollo::common::ErrorCode::HDMAP_DATA_ERROR, err_msg);
  }

  double gps_longitude = longitude;
  double gps_latitude = latitude;
  double gps_alt = height_ellipsoid;

  if (pj_is_latlong(pj_from_)) {
    gps_longitude *= DEG_TO_RAD;
    gps_latitude *= DEG_TO_RAD;
    gps_alt = height_ellipsoid;
  }

  if (0 != pj_transform(pj_from_, pj_to_, 1, 1, &gps_longitude, &gps_latitude,
                        &gps_alt)) {
    std::string err_msg = "fail to transform coordinate";
    return Status(apollo::common::ErrorCode::HDMAP_DATA_ERROR, err_msg);
  }

  if (pj_is_latlong(pj_to_)) {
    gps_longitude *= RAD_TO_DEG;
    gps_latitude *= RAD_TO_DEG;
  }

  *utm_x = gps_longitude;
  *utm_y = gps_latitude;
  *utm_z = gps_alt;
#else
  from_ = {{0}};
  to_ = {{0}};
  if (!pj_conv_){
    std::string err_msg = "no transform param";
    return Status(apollo::common::ErrorCode::HDMAP_DATA_ERROR, err_msg);
  }

  from_.lpz.lam = longitude;
  from_.lpz.phi = latitude;
  from_.lpz.z = height_ellipsoid;
  to_ = proj_trans(pj_conv_, PJ_FWD, from_);

  if (to_.v == nullptr){
    std::string err_msg = "fail to transform coordinate";
    return Status(apollo::common::ErrorCode::HDMAP_DATA_ERROR, err_msg);
  }

  *utm_x = to_.xyz.x;
  *utm_y = to_.xyz.y;
  *utm_z = to_.xyz.z;
#endif
  return Status::OK();
}

}  // namespace adapter
}  // namespace hdmap
}  // namespace apollo
