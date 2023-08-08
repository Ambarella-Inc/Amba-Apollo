###############################################################################
## apollo/modules/drivers/Makefile
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

SUBDIRS := canbus

## sub modules

canbus_dir := $(shell find canbus -maxdepth 1 -type d)
canbus_dir += canbus/can_client/fake canbus/can_client/socket #canbus/can_client/hermes_can
canbus_src := $(foreach dir,$(canbus_dir),$(wildcard $(dir)/*.cc))
#canbus_obj := $(canbus_src:%.cc=%.o)
#$(info $(canbus_src))
canbus_obj := canbus/sensor_gflags.o canbus/can_client/can_client_factory.o canbus/common/byte.o canbus/can_client/fake/fake_can_client.o \
              canbus/can_client/socket/socket_can_client_raw.o #canbus/can_client/hermes_can/hermes_can_client.o 

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
#COMPONENT_INC += -O0 -g

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon

SHARED_LIB_NAMES = driver

## for component.so
driver_src := $(canbus_src)
driver_obj := $(canbus_obj)

####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_LIB_DIR)/* -t $(INSTALL_LIB_DIR)
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/drivers/* -t $(INSTALL_BIN_DIR)/drivers

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/

####################################################################
## for test
####################################################################
all_self_tests: byte_test can_sender_test can_receiver_test message_manager_test protocol_data_test can_client_tool

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon -ldriver
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/drivers
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/drivers/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES

byte_test_obj := $(OBJ_DIR)/modules/drivers/canbus/common/byte_test.o

byte_test: driver
	$(call MAKE_SELF_TEST, $(byte_test_obj))

can_sender_test_obj := $(OBJ_DIR)/modules/drivers/canbus/can_comm/can_sender_test.o

can_sender_test: driver
	$(call MAKE_SELF_TEST, $(can_sender_test_obj))

can_receiver_test_obj := $(OBJ_DIR)/modules/drivers/canbus/can_comm/can_receiver_test.o

can_receiver_test: driver
	$(call MAKE_SELF_TEST, $(can_receiver_test_obj))

message_manager_test_obj := $(OBJ_DIR)/modules/drivers/canbus/can_comm/message_manager_test.o

message_manager_test: driver
	$(call MAKE_SELF_TEST, $(message_manager_test_obj))

protocol_data_test_obj := $(OBJ_DIR)/modules/drivers/canbus/can_comm/protocol_data_test.o

protocol_data_test: driver
	$(call MAKE_SELF_TEST, $(protocol_data_test_obj),)

can_client_tool := $(OBJ_DIR)/modules/drivers/canbus/can_client/can_client_tool.o

can_client_tool: driver
	$(call MAKE_SELF_TEST, $(can_client_tool))



include $(TOP_DIR)/ambabuild/rules.mk