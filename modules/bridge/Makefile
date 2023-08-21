###############################################################################
## apollo/modules/bridge/Makefile
##
## History:
##    2022/11/08 - [Yang Yu] Created file
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

SUBDIRS := common proto
SUBDIRS += test

## source files and object files
src := udp_bridge_sender_component.cc udp_bridge_receiver_component.cc udp_bridge_multi_receiver_component.cc
src += udp_bridge_component_test.cc
obj := $(src:%.cc=%.o)

## sub modules
common_src := common/bridge_buffer.cc common/bridge_gflags.cc common/util.cc common/bridge_header.cc
common_obj := $(common_src:common/%.cc=common/%.o)

proto_src := proto/udp_bridge_remote_info.pb.cc
proto_obj := $(proto_src:proto/%.cc=proto/%.o)

COMPONENT_SRC := $(src) $(common_src) $(proto_src)
COMPONENT_OBJ := $(obj) $(common_obj) $(proto_obj)

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC) $(EXTERN_LIB_SQL_INC) $(EXTERN_LIB_EIGEN_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_SQL_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon

SHARED_LIB_NAMES = udp_bridge

udp_bridge_src = $(common_src) $(proto_src)
udp_bridge_obj = $(common_obj) $(proto_obj)

COM_SHARED_LIB_NAMES = udp_bridge_sender_component udp_bridge_receiver_component udp_bridge_multi_receiver_component

## for component.so

udp_bridge_sender_component_src := udp_bridge_sender_component.cc $(udp_bridge_src)
udp_bridge_sender_component_obj := udp_bridge_sender_component.o $(udp_bridge_obj)

udp_bridge_receiver_component_src := udp_bridge_receiver_component.cc $(udp_bridge_src)
udp_bridge_receiver_component_obj := udp_bridge_receiver_component.o $(udp_bridge_obj)

udp_bridge_multi_receiver_component_src := udp_bridge_multi_receiver_component.cc $(udp_bridge_src)
udp_bridge_multi_receiver_component_obj := udp_bridge_multi_receiver_component.o $(udp_bridge_obj)

####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_LIB_DIR)/* -t $(INSTALL_LIB_DIR)
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_ZLIB_DIR)/usr/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_SQL_DIR)/usr/lib/* $(INSTALL_LIB_DIR)
endif
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/bridge/* -t $(INSTALL_BIN_DIR)/bridge
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/bridge/conf/* -t $(INSTALL_DIR)/modules/bridge/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/bridge/dag/* -t $(INSTALL_DIR)/modules/bridge/dag

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ZLIB_DIR)/usr/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_SQL_DIR)/usr/lib/* $(INSTALL_DIR)/usr/lib/

	@$(MKDIR) $(INTERNAL_CONF_DIR)/bridge
	@cp -dpRf $(TOP_DIR)/modules/bridge/conf/* $(INTERNAL_CONF_DIR)/bridge

	@$(MKDIR) $(INTERNAL_DAG_DIR)/bridge
	@cp -dpRf $(TOP_DIR)/modules/bridge/dag/*.dag $(INTERNAL_DAG_DIR)/bridge

####################################################################
## for test
####################################################################

all_self_tests: bridge_buffer_test bridge_proto_buf_test udp_bridge_component_test \
                bridge_sender_test bridge_receiver_test

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/bridge
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/bridge/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES = bridge_receiver_test bridge_sender_test

## for bridge_buffer_test
bridge_buffer_test_obj := $(OBJ_DIR)/modules/bridge/common/bridge_buffer_test.o

bridge_buffer_test: udp_bridge
	$(call MAKE_SELF_TEST, $(bridge_buffer_test_obj), \
	-L$(INTERNAL_LIB_DIR) -ludp_bridge)

## for bridge_proto_buf_test
bridge_proto_buf_test_obj := $(OBJ_DIR)/modules/bridge/common/bridge_proto_buf_test.o

bridge_proto_buf_test : udp_bridge
	$(call MAKE_SELF_TEST, $(bridge_proto_buf_test_obj), \
	-L$(INTERNAL_LIB_DIR) -ludp_bridge)

## for udp_bridge_component_test
udp_bridge_component_test_obj := $(OBJ_DIR)/modules/bridge/udp_bridge_component_test.o

udp_bridge_component_test: udp_bridge_sender_component
	$(call MAKE_SELF_TEST, $(udp_bridge_component_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -ludp_bridge_sender_component)


## for bridge_sender_test
bridge_sender_test_obj := $(OBJ_DIR)/modules/bridge/test/bridge_sender_test.o

bridge_sender_test: udp_bridge
	$(call MAKE_SELF_TEST, $(bridge_sender_test_obj), \
	-L$(INTERNAL_LIB_DIR) -ludp_bridge)

## for bridge_receiver_test
bridge_receiver_test_obj := $(OBJ_DIR)/modules/bridge/test/bridge_receiver_test.o

bridge_receiver_test: udp_bridge
	$(call MAKE_SELF_TEST, $(bridge_receiver_test_obj), \
	-L$(INTERNAL_LIB_DIR) -ludp_bridge)


include $(TOP_DIR)/ambabuild/rules.mk