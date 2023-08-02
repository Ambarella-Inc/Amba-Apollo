###############################################################################
## extern_lib_cross.mk
##
## History:
##    2022/08/01 - [Zhi He] Created file
##    2023/07/18 - [Yang Yu] Renamed file
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

BASE_LIBRIRY_DIR := $(AUTO_MW_DIR)/base_library/prebuilt/$(TARGRT_CPU_ARCH_VER_NAME)
FAST_DDS_DIR := $(AUTO_MW_DIR)/base_communication/FastDDS/$(TARGRT_CPU_ARCH_VER_NAME)

##python3.8
EXTERN_LIB_PYTHON_DIR = $(BASE_LIBRIRY_DIR)/python3
EXTERN_LIB_PYTHON_INC = -I$(EXTERN_LIB_PYTHON_DIR)/include/python3.8
EXTERN_LIB_PYTHON_LIB = -L$(EXTERN_LIB_PYTHON_DIR)/usr/lib -lpython3.8 -lpython3

##glog-0.4.0
EXTERN_LIB_GLOG_DIR = $(BASE_LIBRIRY_DIR)/glog-0.4.0
EXTERN_LIB_GLOG_INC = -I$(EXTERN_LIB_GLOG_DIR)/include
EXTERN_LIB_GLOG_LIB = -L$(EXTERN_LIB_GLOG_DIR)/usr/lib -lglog

##gflags-2.2.2
EXTERN_LIB_GFLAGS_DIR = $(BASE_LIBRIRY_DIR)/gflags-2.2.2-new
EXTERN_LIB_GFLAGS_INC = -I$(EXTERN_LIB_GFLAGS_DIR)/include
EXTERN_LIB_GFLAGS_LIB = -L$(EXTERN_LIB_GFLAGS_DIR)/usr/lib -lgflags

##protobufshared
EXTERN_LIB_PROTOBUF_DIR = $(BASE_LIBRIRY_DIR)/protobuf-3.14.0-so
EXTERN_LIB_PROTOBUF_INC = -I$(EXTERN_LIB_PROTOBUF_DIR)/include
EXTERN_LIB_PROTOBUF_LIB = -L$(EXTERN_LIB_PROTOBUF_DIR)/lib -lprotobuf#-lprotobuf-lite -lprotoc -lprotobuf

##fastcdr-1.0.7-prebuilt
EXTERN_LIB_FASTCDR_DIR = $(FAST_DDS_DIR)/fastcdr-1.0.7-prebuilt
EXTERN_LIB_FASTCDR_INC = -I$(EXTERN_LIB_FASTCDR_DIR)/include
EXTERN_LIB_FASTCDR_LIB = -L$(EXTERN_LIB_FASTCDR_DIR)/lib -lfastcdr

##fastrtps-1.5.0-prebuilt
EXTERN_LIB_FASTRTPS_DIR = $(FAST_DDS_DIR)/fastrtps-1.5.0-prebuilt
EXTERN_LIB_FASTRTPS_INC = -I$(EXTERN_LIB_FASTRTPS_DIR)/include
EXTERN_LIB_FASTRTPS_LIB = -L$(EXTERN_LIB_FASTRTPS_DIR)/lib -lfastrtps

##fastdds-2.7.1
EXTERN_LIB_FASTDDS_DIR = $(FAST_DDS_DIR)/fastdds-2.7.1
EXTERN_LIB_FASTDDS_INC = -I$(EXTERN_LIB_FASTDDS_DIR)/include
EXTERN_LIB_FASTDDS_LIB = -L$(EXTERN_LIB_FASTDDS_DIR)/lib -lfastrtps

##utils-linux-libs
EXTERN_LIB_UTILS_LINUX_LIBS_DIR = $(BASE_LIBRIRY_DIR)/util-linux-libs-1.1.0
EXTERN_LIB_UTILS_LINUX_LIBS_INC = -I$(EXTERN_LIB_UTILS_LINUX_LIBS_DIR)/include
EXTERN_LIB_UTILS_LINUX_LIBS_LIB = -L$(EXTERN_LIB_UTILS_LINUX_LIBS_DIR)/usr/lib -lblkid -lfdisk -lmount -lsmartcols -luuid

##gtest-1.10.0
EXTERN_LIB_GTEST_DIR = $(BASE_LIBRIRY_DIR)/gtest-1.10.0
EXTERN_LIB_GTEST_INC = -I$(EXTERN_LIB_GTEST_DIR)/include
EXTERN_LIB_GTEST_LIB = -L$(EXTERN_LIB_GTEST_DIR)/lib -lgtest -lgmock -lgtest_main -lgmock_main

##openssl-1.1.1g
EXTERN_LIB_OPENSSL_DIR = $(BASE_LIBRIRY_DIR)/openssl-1.1.1g
EXTERN_LIB_OPENSSL_INC = -I$(EXTERN_LIB_OPENSSL_DIR)/include
EXTERN_LIB_OPENSSL_LIB = -L$(EXTERN_LIB_OPENSSL_DIR) -lcrypto -lssl

## abseil-20200225.2
EXTERN_LIB_ABSL_DIR = $(BASE_LIBRIRY_DIR)/abseil-20200225.2
EXTERN_LIB_ABSL_INC = -I$(EXTERN_LIB_ABSL_DIR)/include
EXTERN_LIB_ABSL_LIB = -L$(EXTERN_LIB_ABSL_DIR)/lib -labsl

## eigen3
EXTERN_LIB_EIGEN_DIR = $(BASE_LIBRIRY_DIR)/eigen
EXTERN_LIB_EIGEN_INC = -I$(EXTERN_LIB_EIGEN_DIR)/include/eigen3
#EXTERN_LIB_EIGEN_LIB = -L$(EXTERN_LIB_EIGEN_DIR)/urs/lib

##zlib-1.1.12
EXTERN_LIB_ZLIB_DIR := $(BASE_LIBRIRY_DIR)/zlib-1.1.12
EXTERN_LIB_ZLIB_INC = -I$(EXTERN_LIB_ZLIB_DIR)/include
EXTERN_LIB_ZLIB_LIB = -L$(EXTERN_LIB_ZLIB_DIR)/usr/lib -lz

## sqlite3
EXTERN_LIB_SQL_DIR = $(BASE_LIBRIRY_DIR)/sqlite
EXTERN_LIB_SQL_INC = -I$(EXTERN_LIB_SQL_DIR)/include
EXTERN_LIB_SQL_LIB = -L$(EXTERN_LIB_SQL_DIR)/usr/lib -lsqlite3

## tf2
EXTERN_LIB_TF2_DIR = $(BASE_LIBRIRY_DIR)/tf2
EXTERN_LIB_TF2_INC = -I$(EXTERN_LIB_TF2_DIR)/include
EXTERN_LIB_TF2_LIB = -L$(EXTERN_LIB_TF2_DIR)/lib -ltf2

## boost-1.74.0
EXTERN_LIB_BOOST_DIR = $(BASE_LIBRIRY_DIR)/boost-1.74.0
EXTERN_LIB_BOOST_INC = -I$(EXTERN_LIB_BOOST_DIR)/include
EXTERN_LIB_BOOST_LIB = -L$(EXTERN_LIB_BOOST_DIR)/lib -lboost_chrono -lboost_date_time -lboost_atomic -lboost_thread -lboost_system -lboost_filesystem

## yaml-cpp-0.6.3
EXTERN_LIB_YAML_DIR = $(BASE_LIBRIRY_DIR)/yaml-0.6.3
EXTERN_LIB_YAML_INC = -I$(EXTERN_LIB_YAML_DIR)/include
EXTERN_LIB_YAML_LIB = -L$(EXTERN_LIB_YAML_DIR)/lib -lyaml-cpp

## osqp-0.5.0
EXTERN_LIB_OSQP_DIR = $(BASE_LIBRIRY_DIR)/osqp-0.5.0
EXTERN_LIB_OSQP_INC = -I$(EXTERN_LIB_OSQP_DIR)/include
EXTERN_LIB_OSQP_LIB = -L$(EXTERN_LIB_OSQP_DIR)/lib -losqp

## tinyxml2
EXTERN_LIB_TINYXML_DIR = $(BASE_LIBRIRY_DIR)/tinyxml2
EXTERN_LIB_TINYXML_INC = -I$(EXTERN_LIB_TINYXML_DIR)/include
EXTERN_LIB_TINYXML_LIB = -L$(EXTERN_LIB_TINYXML_DIR)/lib -ltinyxml2

## nghttp2
EXTERN_LIB_NGHTTP2_DIR = $(BASE_LIBRIRY_DIR)/libnghttp2
EXTERN_LIB_NGHTTP2_INC = -I$(EXTERN_LIB_NGHTTP2_DIR)/include
EXTERN_LIB_NGHTTP2_LIB = -L$(EXTERN_LIB_NGHTTP2_DIR)/usr/lib -lnghttp2

## unistring
EXTERN_LIB_UNISTRING_DIR = $(BASE_LIBRIRY_DIR)/libunistring
EXTERN_LIB_UNISTRING_INC = -I$(EXTERN_LIB_UNISTRING_DIR)/include
EXTERN_LIB_UNISTRING_LIB = -L$(EXTERN_LIB_UNISTRING_DIR)/usr/lib -lunistring

## idn2
EXTERN_LIB_IDN2_DIR = $(BASE_LIBRIRY_DIR)/libidn2
EXTERN_LIB_IDN2_INC = -I$(EXTERN_LIB_IDN2_DIR)/include
EXTERN_LIB_IDN2_LIB = -L$(EXTERN_LIB_IDN2_DIR)/usr/lib -lidn2

## ssh2
EXTERN_LIB_SSH2_DIR = $(BASE_LIBRIRY_DIR)/libssh2
EXTERN_LIB_SSH2_INC = -I$(EXTERN_LIB_SSH2_DIR)/include
EXTERN_LIB_SSH2_LIB = -L$(EXTERN_LIB_SSH2_DIR)/usr/lib -lssh2

## curl
EXTERN_LIB_CURL_DIR = $(BASE_LIBRIRY_DIR)/curl
EXTERN_LIB_CURL_INC = -I$(EXTERN_LIB_CURL_DIR)/include
EXTERN_LIB_CURL_LIB = -L$(EXTERN_LIB_CURL_DIR)/usr/lib -lcurl

## proj-7.1.0-static
EXTERN_LIB_PROJ_DIR = $(BASE_LIBRIRY_DIR)/proj-7.1.0-static
EXTERN_LIB_PROJ_INC = -I$(EXTERN_LIB_PROJ_DIR)/include
EXTERN_LIB_PROJ_LIB = -L$(EXTERN_LIB_PROJ_DIR)/lib -lproj

## nlohmann-json-3.8.0
EXTERN_LIB_JSON_DIR = $(BASE_LIBRIRY_DIR)/nlohmann-json-3.8.0
EXTERN_LIB_JSON_INC = -I$(EXTERN_LIB_JSON_DIR)/include

## civetweb-1.11
EXTERN_LIB_CIVETWEB_DIR = $(BASE_LIBRIRY_DIR)/civetweb-1.11
EXTERN_LIB_CIVETWEB_INC = -I$(EXTERN_LIB_CIVETWEB_DIR)/include
EXTERN_LIB_CIVETWEB_LIB = -L$(EXTERN_LIB_CIVETWEB_DIR)/lib -lcivetweb -lcivetweb-cpp

## tbb
EXTERN_LIB_TBB_DIR = $(BASE_LIBRIRY_DIR)/tbb
EXTERN_LIB_TBB_INC = -I$(EXTERN_LIB_TBB_DIR)/include
EXTERN_LIB_TBB_LIB = -L$(EXTERN_LIB_TBB_DIR)/usr/lib -ltbb

## libjpeg-turbo
EXTERN_LIB_JPEG_DIR = $(BASE_LIBRIRY_DIR)/libjpeg-turbo
EXTERN_LIB_JPEG_INC = -I$(EXTERN_LIB_JPEG_DIR)/include
EXTERN_LIB_JPEG_LIB = -L$(EXTERN_LIB_JPEG_DIR)/usr/lib -ljpeg

## libpng
EXTERN_LIB_PNG_DIR = $(BASE_LIBRIRY_DIR)/libpng
EXTERN_LIB_PNG_INC = -I$(EXTERN_LIB_PNG_DIR)/include
EXTERN_LIB_PNG_LIB = -L$(EXTERN_LIB_PNG_DIR)/usr/lib -lpng

## opencv
EXTERN_LIB_OPENCV_DIR = $(BASE_LIBRIRY_DIR)/opencv
EXTERN_LIB_OPENCV_INC = -I$(EXTERN_LIB_OPENCV_DIR)/include
EXTERN_LIB_OPENCV_LIB = -L$(EXTERN_LIB_OPENCV_DIR)/usr/lib -lopencv_core -lopencv_imgproc -lopencv_imgcodecs

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
EXTERN_LIB_NCURSES_DIR = $(BASE_LIBRIRY_DIR)/ncurses
EXTERN_LIB_NCURSES_INC = -I$(EXTERN_LIB_NCURSES_DIR)/include
EXTERN_LIB_NCURSES_LIB = -L$(EXTERN_LIB_NCURSES_DIR)/usr/lib -lncurses


## pcl-1.12.0
EXTERN_LIB_PCL_DIR = $(BASE_LIBRIRY_DIR)/pcl-1.12.0
EXTERN_LIB_PCL_INC = -I$(EXTERN_LIB_PCL_DIR)/include/pcl-1.12
EXTERN_LIB_PCL_LIB = -L$(EXTERN_LIB_PCL_DIR)/lib -lflann -lflann_cpp -lpcl_common -lpcl_kdtree -lpcl_octree -lpcl_search -lpcl_sample_consensus -lpcl_filters

## openblas
EXTERN_LIB_OPENBLAS_DIR = $(BASE_LIBRIRY_DIR)/openblas
EXTERN_LIB_OPENBLAS_INC = -I$(EXTERN_LIB_OPENBLAS_DIR)/include/openblas
EXTERN_LIB_OPENBLAS_LIB = -L$(EXTERN_LIB_OPENBLAS_DIR)/usr/lib