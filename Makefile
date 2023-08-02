###############################################################################
## apollo/Makefile
##
## History:
##    2022/08/08 - [Zhi He] Created file
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

.PHONY: all gen_proto cyber
.PHONY: clean clean_cyber

default: all

include ./ambabuild/prerequisites.mk
include $(TOP_DIR)/ambabuild/config.mk
include $(TOP_DIR)/ambabuild/extern_lib.mk


# make libproto.so first
all: proto
	@$(MAKE) cyber
	@$(MAKE) module_common
	@$(MAKE) module_amba_cam
	@$(MAKE) module_app_openod
	@$(MAKE) module_app_openseg
	@$(MAKE) module_bridge
	@$(MAKE) module_canbus
	@$(MAKE) module_canbus_vehicle
	@$(MAKE) module_control
	@$(MAKE) module_drivers
	@$(MAKE) module_guardian
	@$(MAKE) module_localization
	@$(MAKE) module_map
	@$(MAKE) module_planning
	@$(MAKE) module_routing
	@$(MAKE) module_storytelling
	@$(MAKE) module_task_manager
	@$(MAKE) module_transform

install_cyber: cyber
	@$(MAKE) -C cyber install -s

clean: clean_proto \
     clean_cyber \
     clean_module_amba_cam \
     clean_module_app_openod \
     clean_module_app_openseg \
     clean_module_bridge \
     clean_module_canbus \
     clean_module_canbus_vehicle \
     clean_module_common \
     clean_module_control \
     clean_module_drivers \
     clean_module_guardian \
     clean_module_localization \
     clean_module_map \
     clean_module_planning \
     clean_module_routing \
     clean_module_storytelling \
     clean_module_task_manager \
     clean_module_transform
	@$(RM) out

####################################################################
## compile (almost) all protos into one lib
####################################################################
PROTO_PATH :=
ifeq ($(ENABLE_LYCHEE), y)
PROTOC := /usr/bin/protoc
else
PROTOC := ../base_library/prebuilt/x86_x64/protobuf-3.14.0/bin/protoc
endif

PROTO_FILES := $(shell find ./cyber -maxdepth 5 -type f -name '*.proto')
PROTO_FILES += $(shell find ./modules -maxdepth 9 -type f -name '*.proto' -not -path '*canbus_vehicle*')# -not -path '*chassis_msgs*'
#$(info $(PROTO_FILES))
PROTO_HEADERS := $(PROTO_FILES:%.proto=%.pb.h)

PROTO_SRC := $(PROTO_HEADERS:%.h=%.cc)

COMPONENT_SRC := $(PROTO_SRC)
COMPONENT_OBJ := $(COMPONENT_SRC:.cc=.o)


####################################################################
## FLAGS
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_GLOG_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_PROTOBUF_LIB)

SHARED_LIB_NAMES = proto

proto_obj := $(COMPONENT_OBJ)

%.pb.h: %.proto
	@echo "  proto generate: $< -> $@"
	@$(PROTOC) -I./ --cpp_out=./ $<

gen_proto: $(PROTO_HEADERS)

py_proto_dir:
	@$(MKDIR) py_proto

gen_py_proto: py_proto_dir
	@$(shell find modules/ cyber/ -name "*.proto" \
      | grep -v canbus_vehicle \
      | xargs $(PROTOC) --python_out=py_proto)
	@$(shell find py_proto/* -type d -exec touch "{}/__init__.py" \;)

clean_proto_files:
	@echo " clean all proto"
	@$(shell find ./cyber -name "*.pb.cc" | xargs rm -f)
	@$(shell find ./cyber -name "*.pb.h" | xargs rm -f)
	@$(shell find ./modules -name "*.pb.cc" | xargs rm -f)
	@$(shell find ./modules -name "*.pb.h" | xargs rm -f)
	@$(RM) py_proto

####################################################################
## for sub modules make
####################################################################
proto: gen_proto

cyber: proto
	@echo " compile cyber rt"
	@$(MAKE) -C cyber --no-print-directory
	@$(MAKE) -C cyber all_self_tests --no-print-directory
	@$(MAKE) -C cyber all_example_tests --no-print-directory

module_amba_cam:
	@echo " compile modules/amba_cam"
	@$(MAKE) -C modules/amba_cam --no-print-directory
#	@$(MAKE) -C modules/amba_cam all_self_tests install_dep_libs --no-print-directory

module_app_openod:
	@echo " compile modules/app_openod"
	@$(MAKE) -C modules/app_openod --no-print-directory

module_app_openseg:
	@echo " compile modules/app_openseg"
	@$(MAKE) -C modules/app_openseg --no-print-directory

module_bridge:
	@echo " compile modules/bridge"
	@$(MAKE) -C modules/bridge --no-print-directory

module_canbus: module_drivers
	@echo " compile modules/canbus"
	@$(MAKE) -C modules/canbus --no-print-directory

module_canbus_vehicle:
	@echo " compile modules/canbus_vehicle"
	@$(MAKE) -C modules/canbus_vehicle --no-print-directory

module_common:
	@echo " compile modules/common"
	@$(MAKE) -C modules/common --no-print-directory

module_control:
	@echo " compile modules/control"
	@$(MAKE) -C modules/control --no-print-directory

module_drivers:
	@echo " compile modules/drivers"
	@$(MAKE) -C modules/drivers --no-print-directory

module_guardian:
	@echo " compile modules/guardian"
	@$(MAKE) -C modules/guardian --no-print-directory

module_localization: module_transform
	@echo " compile modules/localization"
	@$(MAKE) -C modules/localization --no-print-directory

module_map:
	@echo " compile modules/map"
	@$(MAKE) -C modules/map --no-print-directory

module_planning: module_map
	@echo " compile modules/planning"
	@$(MAKE) -C modules/planning --no-print-directory

module_routing: module_map
	@echo " compile modules/routing"
	@$(MAKE) -C modules/routing --no-print-directory

module_storytelling:
	@echo " compile modules/storytelling"
	@$(MAKE) -C modules/storytelling --no-print-directory

module_task_manager:
	@echo " compile modules/task_manager"
	@$(MAKE) -C modules/task_manager --no-print-directory

module_transform: module_common
	@echo " compile modules/transform"
	@$(MAKE) -C modules/transform --no-print-directory

####################################################################
## for sub modules clean
####################################################################
clean_cyber:
	@echo " clean cyber rt"
	@$(MAKE) -C cyber clean --no-print-directory

clean_module_amba_cam:
	@echo " clean modules/amba_cam"
	@$(MAKE) -C modules/amba_cam clean --no-print-directory

clean_module_app_openod:
	@echo " clean modules/app_openod"
	@$(MAKE) -C modules/app_openod clean --no-print-directory

clean_module_app_openseg:
	@echo " clean modules/app_openseg"
	@$(MAKE) -C modules/app_openseg clean --no-print-directory

clean_module_bridge:
	@echo " clean modules/bridge"
	@$(MAKE) -C modules/bridge clean --no-print-directory

clean_module_canbus:
	@echo " clean modules/canbus"
	@$(MAKE) -C modules/canbus clean --no-print-directory

clean_module_canbus_vehicle:
	@echo " clean modules/canbus_vehicle"
	@$(MAKE) -C modules/canbus_vehicle clean --no-print-directory

clean_module_common:
	@echo " clean modules/common"
	@$(MAKE) -C modules/common clean --no-print-directory

clean_module_control:
	@echo " clean modules/control"
	@$(MAKE) -C modules/control clean --no-print-directory

clean_module_drivers:
	@echo " clean modules/drivers"
	@$(MAKE) -C modules/drivers clean --no-print-directory

clean_module_guardian:
	@echo " clean modules/guardian"
	@$(MAKE) -C modules/guardian clean --no-print-directory

clean_module_localization:
	@echo " clean modules/localization"
	@$(MAKE) -C modules/localization clean --no-print-directory

clean_module_map:
	@echo " clean modules/map"
	@$(MAKE) -C modules/map clean --no-print-directory

clean_module_planning:
	@echo " clean modules/planning"
	@$(MAKE) -C modules/planning clean --no-print-directory

clean_module_routing:
	@echo " clean modules/routing"
	@$(MAKE) -C modules/routing clean --no-print-directory

clean_module_storytelling:
	@echo " clean modules/storytelling"
	@$(MAKE) -C modules/storytelling clean --no-print-directory

clean_module_task_manager:
	@echo " clean modules/task_manager"
	@$(MAKE) -C modules/task_manager clean --no-print-directory

clean_module_transform:
	@echo " clean modules/transform"
	@$(MAKE) -C modules/transform clean --no-print-directory

include $(TOP_DIR)/ambabuild/rules.mk