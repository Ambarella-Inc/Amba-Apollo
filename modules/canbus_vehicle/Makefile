###############################################################################
## apollo/modules/canbus_vehicle/Makefile
##
## History:
##    2023/01/04 - [Yang Yu] Created file
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

SUBDIRS := lincoln lexus

## sub modules

lincoln_dir := lincoln #lincoln/protocol
lincoln_src := $(shell find $(lincoln_dir) -maxdepth 2 -type f -name '*.cc' -not -name '*test.cc')
#lincoln_src += ../common_msgs/chassis_msgs/chassis.pb.cc ../canbus/vehicle/abstract_vehicle_factory.cc
lincoln_obj := $(lincoln_src:.cc=.o)

lexus_dir := lexus
lexus_src := $(shell find $(lexus_dir) -maxdepth 2 -type f -name '*.cc' -not -name '*test.cc')
lexus_obj := $(lexus_src:.cc=.o)

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC) $(EXTERN_LIB_BOOST_INC) $(EXTERN_LIB_OSQP_INC)
## for test
#COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
#COMPONENT_INC += -O0 -g

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon -ldriver
#COMPONENT_LDFLAG += -L$(INTERNAL_COM_LIB_DIR) -lcanbus_component

SHARED_LIB_NAMES = lincoln_vehicle_factory_lib lexus_vehicle_factory_lib

COM_SHARED_LIB_NAMES =

## for component.so
lincoln_vehicle_factory_lib_src := $(lincoln_src)
lincoln_vehicle_factory_lib_obj := $(lincoln_obj)

lexus_vehicle_factory_lib_src := $(lexus_src)
lexus_vehicle_factory_lib_obj := $(lexus_obj)

####################################################################
## install needed libs
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_LIB_DIR)/* -t $(INSTALL_LIB_DIR)
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_LIB_DIR)
endif
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/canbus_vehicle/* -t $(INSTALL_BIN_DIR)/canbus_vehicle

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/

####################################################################
## for test
####################################################################
all_self_tests: lexus_vehicle_factory_test lexus_controller_test

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon -ldriver
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/canbus_vehicle
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/canbus_vehicle/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES

lexus_vehicle_factory_test_obj := $(OBJ_DIR)/modules/canbus_vehicle/lexus/lexus_vehicle_factory_test.o

lexus_vehicle_factory_test: lexus_vehicle_factory_lib
	$(call MAKE_SELF_TEST, $(lexus_vehicle_factory_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcanbus_component -llexus_vehicle_factory_lib)

lexus_controller_test_obj := $(OBJ_DIR)/modules/canbus_vehicle/lexus/lexus_controller_test.o

lexus_controller_test: lexus_vehicle_factory_lib
	$(call MAKE_SELF_TEST, $(lexus_controller_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcanbus_component -llexus_vehicle_factory_lib)

lincoln_controller_test_obj := $(OBJ_DIR)/modules/canbus_vehicle/lincoln/lincoln_controller_test.o

lincoln_controller_test: lincoln_vehicle_factory_lib
	$(call MAKE_SELF_TEST, $(lincoln_controller_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lcanbus_component -llincoln_vehicle_factory_lib)




include $(TOP_DIR)/ambabuild/rules.mk
