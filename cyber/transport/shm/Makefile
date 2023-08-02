###############################################################################
## apollo/cyber/transport/shm/Makefile
##
## History:
##    2022/09/13 - [Yu Yang] Created file
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

include ../../../ambabuild/prerequisites.mk

include $(TOP_DIR)/ambabuild/config.mk
include $(TOP_DIR)/ambabuild/extern_lib.mk

COMPONENT_SRC := block.cc condition_notifier.cc multicast_notifier.cc notifier_factory.cc readable_info.cc \
                 xsi_segment.cc posix_segment.cc segment.cc segment_factory.cc \
                 shm_conf.cc state.cc
COMPONENT_SRC += condition_notifier_test.cc
COMPONENT_OBJ := $(COMPONENT_SRC:.cc=.o)

COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)

## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
COMPONENT_LDFLAG := $(EXTERN_LIB_GTEST_LIB)

cyber_transport_shm_src = $(COMPONENT_SRC)
cyber_transport_shm_obj = $(COMPONENT_OBJ)

include $(TOP_DIR)/ambabuild/rules.mk

