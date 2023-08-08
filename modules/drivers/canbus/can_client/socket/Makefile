###############################################################################
## apollo/modules/drivers/canbus/can_client/socket/Makefile
##
## History:
##    2022/12/06 - [Yang Yu] Created file
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

default: all

include ../../../../../ambabuild/prerequisites.mk

include $(TOP_DIR)/ambabuild/config.mk
include $(TOP_DIR)/ambabuild/extern_lib.mk

COMPONENT_SRC := socket_can_client_raw.cc socket_can_client_raw_test.cc

COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
COMPONENT_LDFLAG := $(EXTERN_LIB_GTEST_LIB)

include $(TOP_DIR)/ambabuild/rules.mk
