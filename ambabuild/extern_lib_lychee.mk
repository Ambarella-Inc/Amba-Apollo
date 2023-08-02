###############################################################################
## extern_lib_lychee.mk
##
## History:
##    2023/07/03 - [Yang Yu] Created file
##
## Copyright (C) 2022 Ambarella International LP
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
##################################################################################


APOLLO_OSS_DIR := /opt/apollo/oss

##fastcdr-1.0.7-prebuilt
EXTERN_LIB_FASTCDR_DIR = $(APOLLO_OSS_DIR)/fast-cdr
EXTERN_LIB_FASTCDR_INC = -I$(EXTERN_LIB_FASTCDR_DIR)/include
EXTERN_LIB_FASTCDR_LIB = -L$(EXTERN_LIB_FASTCDR_DIR)/lib -lfastcdr

##fastrtps-1.5.0-prebuilt
EXTERN_LIB_FASTRTPS_DIR = $(APOLLO_OSS_DIR)/fast-rtps
EXTERN_LIB_FASTRTPS_INC = -I$(EXTERN_LIB_FASTRTPS_DIR)/include
EXTERN_LIB_FASTRTPS_LIB = -L$(EXTERN_LIB_FASTRTPS_DIR)/lib -lfastrtps

##glog-0.4.0
EXTERN_LIB_GLOG_DIR =
EXTERN_LIB_GLOG_INC =
EXTERN_LIB_GLOG_LIB = -lglog

##gflags-2.2.2
EXTERN_LIB_GFLAGS_DIR =
EXTERN_LIB_GFLAGS_INC =
EXTERN_LIB_GFLAGS_LIB = -lgflags

##protobufshared
EXTERN_LIB_PROTOBUF_DIR =
EXTERN_LIB_PROTOBUF_INC =
EXTERN_LIB_PROTOBUF_LIB = -lprotobuf#-lprotobuf-lite -lprotoc -lprotobuf

##fastdds-2.7.1
EXTERN_LIB_FASTDDS_DIR =
EXTERN_LIB_FASTDDS_INC =
EXTERN_LIB_FASTDDS_LIB =

##utils-linux-libs
EXTERN_LIB_UTILS_LINUX_LIBS_DIR =
EXTERN_LIB_UTILS_LINUX_LIBS_INC =
EXTERN_LIB_UTILS_LINUX_LIBS_LIB = -luuid #-lblkid -lfdisk -lmount -lsmartcols

##gtest-1.10.0
EXTERN_LIB_GTEST_DIR =
EXTERN_LIB_GTEST_INC =
EXTERN_LIB_GTEST_LIB = -lgtest -lgmock -lgtest_main -lgmock_main

##openssl-1.1.1g
EXTERN_LIB_OPENSSL_DIR =
EXTERN_LIB_OPENSSL_INC =
EXTERN_LIB_OPENSSL_LIB = -lcrypto -lssl


## abseil-20230125.3
EXTERN_LIB_ABSL_DIR = $(APOLLO_OSS_DIR)/abseil-cpp
EXTERN_LIB_ABSL_INC = -I$(EXTERN_LIB_ABSL_DIR)/include
EXTERN_LIB_ABSL_LIB = -L$(EXTERN_LIB_ABSL_DIR)/lib64 -labsl_base -labsl_int128 -labsl_throw_delegate -labsl_spinlock_wait -labsl_raw_logging_internal -labsl_log_severity -labsl_strings_internal -labsl_strings
## eigen3
EXTERN_LIB_EIGEN_DIR =
EXTERN_LIB_EIGEN_INC = -I /usr/include/eigen3

##zlib-1.1.12
EXTERN_LIB_ZLIB_DIR :=
EXTERN_LIB_ZLIB_INC =
EXTERN_LIB_ZLIB_LIB =

## sqlite3
EXTERN_LIB_SQL_DIR =
EXTERN_LIB_SQL_INC =
EXTERN_LIB_SQL_LIB = -lsqlite3

## tf2
EXTERN_LIB_TF2_DIR = $(APOLLO_OSS_DIR)/tf2
EXTERN_LIB_TF2_INC = -I$(EXTERN_LIB_TF2_DIR)/include
EXTERN_LIB_TF2_LIB = -L$(EXTERN_LIB_TF2_DIR)/lib -ltf2

## boost-1.74.0
EXTERN_LIB_BOOST_DIR =
EXTERN_LIB_BOOST_INC =
EXTERN_LIB_BOOST_LIB = -lboost_chrono -lboost_date_time -lboost_atomic -lboost_thread -lboost_system -lboost_filesystem

## yaml-cpp-0.6.3
EXTERN_LIB_YAML_DIR =
EXTERN_LIB_YAML_INC =
EXTERN_LIB_YAML_LIB = -lyaml-cpp

## osqp-0.5.0
EXTERN_LIB_OSQP_DIR = $(APOLLO_OSS_DIR)/osqp
EXTERN_LIB_OSQP_INC = -I$(EXTERN_LIB_OSQP_DIR)/include
EXTERN_LIB_OSQP_LIB = -L$(EXTERN_LIB_OSQP_DIR)/lib64 -losqp

## tinyxml2
EXTERN_LIB_TINYXML_DIR =
EXTERN_LIB_TINYXML_INC =
EXTERN_LIB_TINYXML_LIB = -ltinyxml2

## proj-7.1.0
EXTERN_LIB_PROJ_DIR = $(APOLLO_OSS_DIR)/proj
EXTERN_LIB_PROJ_INC = -I$(EXTERN_LIB_PROJ_DIR)/include
EXTERN_LIB_PROJ_LIB = -L$(EXTERN_LIB_PROJ_DIR)/lib64 -lproj

## nlohmann-json-3.8.0
EXTERN_LIB_JSON_DIR = $(BASE_LIBRIRY_DIR)/nlohmann-json-3.8.0
EXTERN_LIB_JSON_INC = -I$(EXTERN_LIB_JSON_DIR)/include

## civetweb-1.11
EXTERN_LIB_CIVETWEB_DIR = $(APOLLO_OSS_DIR)/civetweb
EXTERN_LIB_CIVETWEB_INC = -I$(EXTERN_LIB_CIVETWEB_DIR)/include
EXTERN_LIB_CIVETWEB_LIB = -L$(EXTERN_LIB_CIVETWEB_DIR)/lib -lcivetweb -lcivetweb-cpp


## opencv
EXTERN_LIB_OPENCV_DIR =
EXTERN_LIB_OPENCV_INC = -I /usr/include/opencv4
EXTERN_LIB_OPENCV_LIB = -lopencv_core -lopencv_imgproc -lopencv_imgcodecs

## adolc-2.6.3
EXTERN_LIB_ADOLC_DIR = $(BASE_LIBRIRY_DIR)/adolc-2.6.3
EXTERN_LIB_ADOLC_INC = -I$(EXTERN_LIB_ADOLC_DIR)/include
EXTERN_LIB_ADOLC_LIB = -L$(EXTERN_LIB_ADOLC_DIR)/lib64 -ladolc

## ad_rss_lib-1.1.0
EXTERN_LIB_ADRSS_DIR = $(BASE_LIBRIRY_DIR)/ad_rss_lib-1.1.0
EXTERN_LIB_ADRSS_INC = -I$(EXTERN_LIB_ADRSS_DIR)/include
EXTERN_LIB_ADRSS_LIB = -L$(EXTERN_LIB_ADRSS_DIR)/lib -lad-rss

## Ipopt-3.13.0
EXTERN_LIB_IPOPT_DIR = $(BASE_LIBRIRY_DIR)/Ipopt-3.13.0
EXTERN_LIB_IPOPT_INC = -I$(EXTERN_LIB_IPOPT_DIR)/include
EXTERN_LIB_IPOPT_LIB = -L$(EXTERN_LIB_IPOPT_DIR)/lib -lipopt_full

## ncurses 5.9
EXTERN_LIB_NCURSES_DIR =
EXTERN_LIB_NCURSES_INC =
EXTERN_LIB_NCURSES_LIB = -lncurses


## pcl-1.12.0
EXTERN_LIB_PCL_DIR =
EXTERN_LIB_PCL_INC = -I /usr/include/pcl-1.12
EXTERN_LIB_PCL_LIB = -lflann -lflann_cpp -lpcl_common -lpcl_kdtree -lpcl_octree -lpcl_search -lpcl_sample_consensus -lpcl_filters

## openblas
EXTERN_LIB_OPENBLAS_DIR = $(BASE_LIBRIRY_DIR)/openblas
EXTERN_LIB_OPENBLAS_INC = -I$(EXTERN_LIB_OPENBLAS_DIR)/include/openblas
EXTERN_LIB_OPENBLAS_LIB = -L$(EXTERN_LIB_OPENBLAS_DIR)/usr/lib