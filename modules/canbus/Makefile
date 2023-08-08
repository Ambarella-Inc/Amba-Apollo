###############################################################################
## apollo/modules/canbus/Makefile
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

include ../../ambabuild/prerequisites.mk

include $(TOP_DIR)/ambabuild/config.mk
include $(TOP_DIR)/ambabuild/extern_lib.mk


####################################################################
## for module library 
####################################################################

SUBDIRS := common vehicle tools

## source files and object files
src := canbus_component.cc
obj := $(src:%.cc=%.o)

## sub modules
common_src := common/canbus_gflags.cc
common_obj := $(common_src:common/%.cc=common/%.o)

vehicle_src := vehicle/abstract_vehicle_factory.cc
vehicle_obj := $(vehicle_src:.cc=.o)
#$(info $(vehicle_obj))

proto_src := #../common_msgs/chassis_msgs/chassis.pb.cc ../common_msgs/chassis_msgs/chassis_detail.pb.cc
proto_obj := #$(proto_src:.cc=.o)

COMPONENT_SRC := $(src) $(common_src) $(proto_src) $(vehicle_src) canbus_test.cc
COMPONENT_OBJ := $(obj) $(common_obj) $(proto_obj) $(vehicle_obj) canbus_test.o

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC) $(EXTERN_LIB_BOOST_INC) $(EXTERN_LIB_OSQP_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
COMPONENT_INC += -O0 -g

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon -ldriver

COM_SHARED_LIB_NAMES = canbus_component

## for component.so
canbus_component_src := $(src) $(common_src) $(proto_src) $(vehicle_src)
canbus_component_obj := $(obj) $(common_obj) $(proto_obj) $(vehicle_obj)

####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/canbus/* -t $(INSTALL_BIN_DIR)/canbus
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/canbus/conf/* -t $(INSTALL_DIR)/modules/canbus/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/canbus/dag/* -t $(INSTALL_DIR)/modules/canbus/dag
	@$(MKDIR) $(INSTALL_DIR)/modules/canbus/testdata
	cp -dpRf $(TOP_DIR)/modules/canbus/testdata/* $(INSTALL_DIR)/modules/canbus/testdata

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/

	@$(MKDIR) $(INTERNAL_CONF_DIR)/canbus
	@cp -dpRf $(TOP_DIR)/modules/canbus/conf/* $(INTERNAL_CONF_DIR)/canbus

	@$(MKDIR) $(INTERNAL_DAG_DIR)/canbus
	@cp -dpRf $(TOP_DIR)/modules/canbus/dag/*.dag $(INTERNAL_DAG_DIR)/canbus

####################################################################
## for test
####################################################################
all_self_tests: canbus_test canbus_tester teleop

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon -ldriver
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/canbus
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/canbus/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES

canbus_test_obj := $(OBJ_DIR)/modules/canbus/canbus_test.o

canbus_test: canbus_component
	$(call MAKE_SELF_TEST, $(canbus_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcanbus_component)

canbus_tester_obj := $(OBJ_DIR)/modules/canbus/tools/canbus_tester.o

canbus_tester: canbus_component
	$(call MAKE_SELF_TEST, $(canbus_tester_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcanbus_component)

teleop_obj := $(OBJ_DIR)/modules/canbus/tools/teleop.o

teleop: canbus_component
	$(call MAKE_SELF_TEST, $(teleop_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcanbus_component)


include $(TOP_DIR)/ambabuild/rules.mk