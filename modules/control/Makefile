###############################################################################
## apollo/modules/control/Makefile
##
## History:
##    2022/12/05 - [Yang Yu] Created file
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

SUBDIRS := common controller submodules tools proto

## source files and object files
src := control_component.cc
obj := $(src:%.cc=%.o)

## sub modules
common_src := common/control_gflags.cc common/hysteresis_filter.cc common/interpolation_1d.cc common/interpolation_2d.cc common/leadlag_controller.cc \
              common/mrac_controller.cc common/pid_controller.cc common/pid_BC_controller.cc common/pid_IC_controller.cc common/trajectory_analyzer.cc
common_obj := $(common_src:common/%.cc=common/%.o)

controller_src := controller/lat_controller.cc controller/lon_controller.cc \
                  controller/mpc_controller.cc controller/controller_agent.cc
controller_obj := $(controller_src:controller/%.cc=controller/%.o)

submodules_src := submodules/preprocessor_submodule.cc submodules/mpc_controller_submodule.cc \
                  submodules/lat_lon_controller_submodule.cc submodules/postprocessor_submodule.cc
submodules_obj := $(submodules_src:submodules/%.cc=submodules/%.o)

proto_src := $(shell find proto -name '*.cc')
proto_obj := $(proto_src:.cc=.o)

#tools_src := tools/control_tester.cc tools/pad_terminal.cc
#tools_obj := $(tools_src:tools/%.cc=tools/%.o)

COMPONENT_SRC := $(src) $(common_src) $(controller_src) $(submodules_src) $(proto_src) control_component_test.cc
COMPONENT_OBJ := $(obj) $(common_obj) $(controller_obj) $(submodules_obj) $(proto_obj) control_component_test.o

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC) $(EXTERN_LIB_BOOST_INC) $(EXTERN_LIB_OSQP_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
#COMPONENT_INC += -O0 -g

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon
#COMPONENT_LDFLAG += -L$(INTERNAL_COM_LIB_DIR) -lstatic_transform_component

COM_SHARED_LIB_NAMES = control_component

## for component.so
control_component_src := $(src) $(common_src) $(controller_src) $(submodules_src) $(proto_src)
control_component_obj := $(obj) $(common_obj) $(controller_obj) $(submodules_obj) $(proto_obj)

####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_LIB_DIR)/* -t $(INSTALL_LIB_DIR)
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_LIB_DIR)
endif
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/control/* -t $(INSTALL_BIN_DIR)/control
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/control/conf/* -t $(INSTALL_DIR)/modules/control/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/control/dag/* -t $(INSTALL_DIR)/modules/control/dag
	@$(MKDIR) $(INSTALL_DIR)/modules/control/testdata
	cp -dpRf $(TOP_DIR)/modules/control/testdata/* $(INSTALL_DIR)/modules/control/testdata

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/

	@$(MKDIR) $(INTERNAL_CONF_DIR)/control
	@cp -dpRf $(TOP_DIR)/modules/control/conf/* $(INTERNAL_CONF_DIR)/control

	@$(MKDIR) $(INTERNAL_DAG_DIR)/control
	@cp -dpRf $(TOP_DIR)/modules/control/dag/*.dag $(INTERNAL_DAG_DIR)/control

####################################################################
## for test
####################################################################
all_self_tests: mpc_controller_test lat_controller_test lon_controller_test control_component_test \
                control_tester pad_terminal

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/control
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/control/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES

mpc_controller_test_obj := $(OBJ_DIR)/modules/control/controller/mpc_controller_test.o

mpc_controller_test: control_component
	$(call MAKE_SELF_TEST, $(mpc_controller_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcontrol_component)

lat_controller_test_obj := $(OBJ_DIR)/modules/control/controller/lat_controller_test.o

lat_controller_test: control_component
	$(call MAKE_SELF_TEST, $(lat_controller_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcontrol_component)

lon_controller_test_obj := $(OBJ_DIR)/modules/control/controller/lon_controller_test.o

lon_controller_test: control_component
	$(call MAKE_SELF_TEST, $(lon_controller_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcontrol_component)

control_component_test_obj := $(OBJ_DIR)/modules/control/control_component_test.o

control_component_test: control_component
	$(call MAKE_SELF_TEST, $(control_component_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcontrol_component)

control_tester_obj := $(OBJ_DIR)/modules/control/tools/control_tester.o

control_tester: control_component
	$(call MAKE_SELF_TEST, $(control_tester_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcontrol_component)

pad_terminal_obj := $(OBJ_DIR)/modules/control/tools/pad_terminal.o

pad_terminal: control_component
	$(call MAKE_SELF_TEST, $(pad_terminal_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcontrol_component)

include $(TOP_DIR)/ambabuild/rules.mk