###############################################################################
## extern_lib.mk
##
## History:
##    2022/08/01 - [Zhi He] Created file
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

OSS_DIR := $(AMB_DIR)/prebuild/oss/$(TARGRT_CPU_ARCH_NAME)

##glog
EXTERN_LIB_GLOG_DIR = $(OSS_DIR)/glog
EXTERN_LIB_GLOG_INC = -I$(EXTERN_LIB_GLOG_DIR)/include
EXTERN_LIB_GLOG_LIB = -L$(EXTERN_LIB_GLOG_DIR)/usr/lib -lglog

##gflags
EXTERN_LIB_GFLAGS_DIR = $(OSS_DIR)/gflags
EXTERN_LIB_GFLAGS_INC = -I$(EXTERN_LIB_GFLAGS_DIR)/include
EXTERN_LIB_GFLAGS_LIB = -L$(EXTERN_LIB_GFLAGS_DIR)/usr/lib -lgflags

##protobuf
EXTERN_LIB_PROTOBUF_DIR = $(TOP_DIR)/extern_lib/protobuf-3.14.0
EXTERN_LIB_PROTOBUF_INC = -I$(EXTERN_LIB_PROTOBUF_DIR)/include
EXTERN_LIB_PROTOBUF_LIB = -L$(EXTERN_LIB_PROTOBUF_DIR)/lib -lprotoc -lprotobuf-lite -lprotobuf

##fastcdr-1.0.24
EXTERN_LIB_FASTCDR_DIR = $(TOP_DIR)/extern_lib/fastcdr-1.0.24
EXTERN_LIB_FASTCDR_INC = -I$(EXTERN_LIB_FASTCDR_DIR)/include
EXTERN_LIB_FASTCDR_LIB = -L$(EXTERN_LIB_FASTCDR_DIR)/lib -lfastcdr

##fastrtps-1.5.0-patched
EXTERN_LIB_FASTRTPS_DIR = $(TOP_DIR)/extern_lib/fastrtps-1.5.0-patched
EXTERN_LIB_FASTRTPS_INC = -I$(EXTERN_LIB_FASTRTPS_DIR)/include
EXTERN_LIB_FASTRTPS_LIB = -L$(EXTERN_LIB_FASTRTPS_DIR) -lfastrtps

##fastdds-2.7.1
EXTERN_LIB_FASTDDS_DIR = $(TOP_DIR)/extern_lib/fastdds-2.7.1
EXTERN_LIB_FASTDDS_INC = -I$(EXTERN_LIB_FASTDDS_DIR)/include
EXTERN_LIB_FASTDDS_LIB = -L$(EXTERN_LIB_FASTDDS_DIR)/lib -lfastrtps

##utils-linux-libs
EXTERN_LIB_UTILS_LINUX_LIBS_DIR = $(OSS_DIR)/util-linux-libs
EXTERN_LIB_UTILS_LINUX_LIBS_INC = -I$(EXTERN_LIB_UTILS_LINUX_LIBS_DIR)/include
EXTERN_LIB_UTILS_LINUX_LIBS_LIB = -L$(EXTERN_LIB_UTILS_LINUX_LIBS_DIR)/usr/lib -lblkid -lfdisk -lmount -lsmartcols -luuid

##gtest-1.12.1
EXTERN_LIB_GTEST_DIR = $(TOP_DIR)/extern_lib/gtest-1.12.1
EXTERN_LIB_GTEST_INC = -I$(EXTERN_LIB_GTEST_DIR)/include
EXTERN_LIB_GTEST_LIB = -L$(EXTERN_LIB_GTEST_DIR)/lib -lgtest -lgmock -lgtest_main -lgmock_main

##openssl-1.1.1g
EXTERN_LIB_OPENSSL_DIR = $(TOP_DIR)/extern_lib/openssl-1.1.1g
EXTERN_LIB_OPENSSL_INC = -I$(EXTERN_LIB_OPENSSL_DIR)/include
EXTERN_LIB_OPENSSL_LIB = -L$(EXTERN_LIB_OPENSSL_DIR) -lcrypto -lssl

