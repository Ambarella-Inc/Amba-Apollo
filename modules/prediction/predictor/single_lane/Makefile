###############################################################################
## apollo/modules/prediction/predictor/single_lane/Makefile
##
## History:
##    2023/02/20 - [Yang Yu] Created file
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

include ../../../../ambabuild/prerequisites.mk

include $(TOP_DIR)/ambabuild/config.mk
include $(TOP_DIR)/ambabuild/extern_lib.mk

SUBDIRS :=

COMPONENT_SRC := $(shell find -maxdepth 1 -name '*.cc')
COMPONENT_OBJ := $(COMPONENT_SRC:.cc=.o)

COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC) $(EXTERN_LIB_EIGEN_INC) $(EXTERN_LIB_TF2_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC) $(EXTERN_LIB_BOOST_INC) $(EXTERN_LIB_JSON_INC) $(EXTERN_LIB_CIVETWEB_INC) $(EXTERN_LIB_YAML_INC)
COMPONENT_INC += $(EXTERN_LIB_PCL_INC) $(EXTERN_LIB_OPENCV_INC)

## for test
#COMPONENT_INC += -O0 -g
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
COMPONENT_LDFLAG := $(EXTERN_LIB_GTEST_LIB)

include $(TOP_DIR)/ambabuild/rules.mk
