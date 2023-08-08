###############################################################################
## apollo/modules/task_manager/Makefile
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

SUBDIRS := common

## sub modules
src := $(shell find . -maxdepth 1 -type f -name '*.cc')
obj := $(src:.cc=.o)

common_dir := common
common_src := $(shell find $(common_dir) -maxdepth 1 -type f -name '*.cc')
common_obj := $(common_src:.cc=.o)

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC) $(EXTERN_LIB_BOOST_INC) $(EXTERN_LIB_OSQP_INC)
COMPONENT_INC += $(EXTERN_LIB_JSON_INC) $(EXTERN_LIB_EIGEN_INC)

## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
#COMPONENT_INC += -O0 -g

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon


COM_SHARED_LIB_NAMES = task_manager_component

## for component.so
task_manager_component_src := $(src) $(common_src)
task_manager_component_obj := $(obj) $(common_obj)

####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/task_manager/conf/* -t $(INSTALL_DIR)/modules/task_manager/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/task_manager/dag/* -t $(INSTALL_DIR)/modules/task_manager/dag

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/

	@$(MKDIR) $(INTERNAL_CONF_DIR)/task_manager
	@cp -dpRf $(TOP_DIR)/modules/task_manager/conf/* $(INTERNAL_CONF_DIR)/task_manager

	@$(MKDIR) $(INTERNAL_DAG_DIR)/task_manager
	@cp -dpRf $(TOP_DIR)/modules/task_manager/dag/*.dag $(INTERNAL_DAG_DIR)/task_manager

####################################################################
## for test
####################################################################
all_self_tests:

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/task_manager
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/task_manager/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES



include $(TOP_DIR)/ambabuild/rules.mk
