###############################################################################
## apollo/modules/audio/Makefile
##
## History:
##    2022/11/08 - [Yang Yu] Created file
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

include ../../ambabuild/prerequisites.mk

include $(TOP_DIR)/ambabuild/config.mk
include $(TOP_DIR)/ambabuild/extern_lib.mk


####################################################################
## for module library 
####################################################################

SUBDIRS := common inference

## source files and object files
src := audio_component.cc
obj := $(src:%.cc=%.o)

## sub modules
common_src := common/audio_gflags.cc common/audio_info.cc common/message_process.cc
common_obj := $(common_src:common/%.cc=common/%.o)

inference_src := inference/moving_detection.cc inference/direction_detection.cc inference/siren_detection.cc
inference_obj := $(inference_src:inference/%.cc=inference/%.o)

COMPONENT_SRC := $(src) $(common_src) $(inference_src)
COMPONENT_OBJ := $(obj) $(common_obj) $(inference_obj)

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC) $(EXTERN_LIB_SQL_INC) $(EXTERN_LIB_EIGEN_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_SQL_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon


COM_SHARED_LIB_NAMES = audio_component

## for audio_component.so
audio_component_src := $(COMPONENT_SRC)
audio_component_obj := $(COMPONENT_OBJ)

include $(TOP_DIR)/ambabuild/rules.mk