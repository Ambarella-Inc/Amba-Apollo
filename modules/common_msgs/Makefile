###############################################################################
## apollo/modules/common_msgs/Makefile
##
## History:
##    2023/08/09 - [Yang Yu] Created file
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
SUBDIRS := amba_msgs \
audio_msgs \
basic_msgs \
chassis_msgs \
config_msgs \
control_msgs \
dreamview_msgs \
drivers_msgs \
guardian_msgs \
localization_msgs \
map_msgs \
monitor_msgs \
perception_msgs \
planning_msgs \
prediction_msgs \
routing_msgs \
sensor_msgs \
simulation_msgs \
storytelling_msgs \
task_manager_msgs \
transform_msgs \
v2x_msgs


src := $(shell find ./ -name '*.cc')
obj := $(src:.cc=.o)

COMPONENT_SRC := $(src)
COMPONENT_OBJ := $(obj)

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_PROTOBUF_LIB)

SHARED_LIB_NAMES = common_msgs

## for component.so
common_msgs_src := $(COMPONENT_SRC)
common_msgs_obj := $(COMPONENT_OBJ)

all_self_tests:

####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_LIB_DIR)/* -t $(INSTALL_LIB_DIR)


include $(TOP_DIR)/ambabuild/rules.mk