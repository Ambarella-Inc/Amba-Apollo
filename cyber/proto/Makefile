###############################################################################
## apollo/cyber/proto/Makefile
##
## History:
##    2022/09/15 - [Zhi He] Created file
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

COMPONENT_SRC := choreography_conf.pb.cc classic_conf.pb.cc clock.pb.cc component_conf.pb.cc
COMPONENT_SRC += cyber_conf.pb.cc dag_conf.pb.cc parameter.pb.cc perf_conf.pb.cc proto_desc.pb.cc
COMPONENT_SRC += qos_profile.pb.cc record.pb.cc role_attributes.pb.cc run_mode_conf.pb.cc
COMPONENT_SRC += scheduler_conf.pb.cc topology_change.pb.cc transport_conf.pb.cc unit_test.pb.cc
COMPONENT_OBJ := $(COMPONENT_SRC:.cc=.o)

COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB)

cyber_proto_src = $(COMPONENT_SRC)
cyber_proto_obj = $(cyber_proto_src:.cc=.o)

include $(TOP_DIR)/ambabuild/rules.mk

