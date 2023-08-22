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

#add sub modules here and it can auto make
SUBMODULES := common_msgs common bridge transform drivers canbus canbus_vehicle control guardian\
              localization map planning routing storytelling task_manager dreamview monitor
#SUBMODULES += amba_cam amba_openod amba_openseg

# make cyber first
all: cyber

install: install_cyber

clean: clean_cyber
	@$(RM) out

# declare necessary dependencies between modules
all_common: cyber all_common_msgs
all_bridge: all_common
all_transform: all_common
all_drivers: all_common
all_canbus: all_drivers
all_canbus_vehicle: all_canbus
all_control: all_common
all_guardian: all_common
all_localization: all_transform
all_map: all_common
all_planning: all_map
all_routing: all_map
all_dreamview: all_map
all_monitor: all_dreamview

####################################################################
## proto files generate and clean
####################################################################

ifeq ($(ENABLE_LYCHEE), y)
PROTOC := /usr/bin/protoc
else
PROTOC := ../base_library/prebuilt/x86_x64/protobuf-3.14.0/bin/protoc
endif

PROTO_FILES := $(shell find ./cyber -maxdepth 5 -type f -name '*.proto')
PROTO_FILES += $(shell find ./modules -maxdepth 9 -type f -name '*.proto')# -not -path '*canbus_vehicle*' -not -path '*chassis_msgs*'
#$(info $(PROTO_FILES))
PROTO_HEADERS := $(PROTO_FILES:%.proto=%.pb.h)
PROTO_SRC := $(PROTO_HEADERS:%.h=%.cc)

%.pb.h: %.proto
	@echo "  proto generate: $< -> $@"
	@$(PROTOC) -I./ --cpp_out=./ $<

# generate all *pb.h and *pb.cc
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
## for cyber make, install and clean 
####################################################################

cyber:
	@echo " compile cyber rt"
	@$(MAKE) -C cyber --no-print-directory
	@$(MAKE) -C cyber all_self_tests --no-print-directory
	@$(MAKE) -C cyber all_example_tests --no-print-directory

install_cyber:
	@$(MAKE) -C cyber install -s

clean_cyber:
	@echo " clean cyber rt"
	@$(MAKE) -C cyber clean --no-print-directory



include $(TOP_DIR)/ambabuild/rules.mk