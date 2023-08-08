###############################################################################
## apollo/modules/monitor/Makefile
##
## History:
##    2022/12/02 - [Yang Yu] Created file
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

SUBDIRS := common hardware software

## source files and object files
src := monitor.cc
obj := $(src:%.cc=%.o)

## sub modules
common_src := common/recurrent_runner.cc common/monitor_manager.cc
common_obj := $(common_src:common/%.cc=common/%.o)

hardware_src := hardware/gps_monitor.cc hardware/resource_monitor.cc hardware/esdcan_monitor.cc hardware/socket_can_monitor.cc
hardware_obj := $(hardware_src:hardware/%.cc=hardware/%.o)

software_src := software/process_monitor.cc software/module_monitor.cc software/camera_monitor.cc software/channel_monitor.cc software/localization_monitor.cc \
                software/functional_safety_monitor.cc software/summary_monitor.cc software/recorder_monitor.cc software/latency_monitor.cc
software_obj := $(software_src:software/%.cc=software/%.o)

COMPONENT_SRC := $(src) $(common_src) $(hardware_src) $(software_src)
COMPONENT_OBJ := $(obj) $(common_obj) $(hardware_obj) $(software_obj)

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC) $(EXTERN_LIB_BOOST_INC)
## for test
COMPONENT_INC += -O0 -g
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon -ldreamview_backend
COMPONENT_LDFLAG += -L$(INTERNAL_COM_LIB_DIR) -lstatic_transform_component

COM_SHARED_LIB_NAMES = monitor

## for component.so
monitor_src := $(src) $(common_src) $(hardware_src) $(software_src)
monitor_obj := $(obj) $(common_obj) $(hardware_obj) $(software_obj)

####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/monitor/* -t $(INSTALL_BIN_DIR)/monitor
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/monitor/dag/*.dag -t $(INSTALL_DIR)/modules/monitor/dag

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
endif
	@$(MKDIR) $(INTERNAL_DAG_DIR)/monitor
	@cp -dpRf $(TOP_DIR)/modules/monitor/dag/*.dag $(INTERNAL_DAG_DIR)/monitor

####################################################################
## for test
####################################################################
all_self_tests: recurrent_runner_test

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_TINYXML_LIB)
TEST_LDFLAG += $(EXTERN_LIB_TF2_LIB) $(EXTERN_LIB_PROJ_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += $(EXTERN_LIB_YAML_LIB) $(EXTERN_LIB_CIVETWEB_LIB) $(EXTERN_LIB_TBB_LIB) $(EXTERN_LIB_OPENCV_LIB) $(EXTERN_LIB_JPEG_LIB) $(EXTERN_LIB_PNG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PCL_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon -lhdmap_lib -lpnc_map_lib
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/monitor
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/monitor/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES

recurrent_runner_test_obj := $(OBJ_DIR)/modules/monitor/common/recurrent_runner_test.o

recurrent_runner_test: monitor
	$(call MAKE_SELF_TEST, $(recurrent_runner_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lmonitor -lstatic_transform_component \
	-L$(INTERNAL_LIB_DIR) -ldreamview_backend)


include $(TOP_DIR)/ambabuild/rules.mk