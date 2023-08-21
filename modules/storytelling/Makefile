###############################################################################
## apollo/modules/storytelling/Makefile
##
## History:
##    2023/01/05 - [Yang Yu] Created file
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

SUBDIRS := common story_tellers proto

## sub modules
src := $(shell find . -maxdepth 1 -type f -name '*.cc')
obj := $(src:.cc=.o)

common_dir := common
common_src := $(shell find $(common_dir) -maxdepth 1 -type f -name '*.cc')
common_obj := $(common_src:.cc=.o)

proto_src := $(shell find proto -name '*.cc')
proto_obj := $(proto_src:.cc=.o)

story_tellers_dir := story_tellers
story_tellers_src := $(shell find $(story_tellers_dir) -maxdepth 1 -type f -name '*.cc')
story_tellers_obj := $(story_tellers_src:.cc=.o)

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


COM_SHARED_LIB_NAMES = storytelling_component

## for component.so
storytelling_component_src := $(src) $(common_src) $(story_tellers_src) $(proto_src)
storytelling_component_obj := $(obj) $(common_obj) $(story_tellers_obj) $(proto_obj)

####################################################################
## install
####################################################################
install:
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_LIB_DIR)
endif
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
#$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/storytelling/* -t $(INSTALL_BIN_DIR)/storytelling
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/storytelling/conf/* -t $(INSTALL_DIR)/modules/storytelling/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/storytelling/dag/* -t $(INSTALL_DIR)/modules/storytelling/dag


install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/

	@$(MKDIR) $(INTERNAL_CONF_DIR)/storytelling
	@cp -dpRf $(TOP_DIR)/modules/storytelling/conf/* $(INTERNAL_CONF_DIR)/storytelling

	@$(MKDIR) $(INTERNAL_DAG_DIR)/storytelling
	@cp -dpRf $(TOP_DIR)/modules/storytelling/dag/*.dag $(INTERNAL_DAG_DIR)/storytelling

####################################################################
## for test
####################################################################
all_self_tests:

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/storytelling
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/storytelling/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES



include $(TOP_DIR)/ambabuild/rules.mk
