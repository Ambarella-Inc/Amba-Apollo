###############################################################################
## apollo/modules/transform/Makefile
##
## History:
##    2022/11/14 - [Yang Yu] Created file
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

src := buffer.cc transform_broadcaster.cc static_transform_component.cc
obj := $(src:%.cc=%.o)

test_src := static_transform_component_test.cc
test_obj := $(test_src:%.cc=%.o)

COMPONENT_SRC := $(src) $(test_src)
COMPONENT_OBJ := $(obj) $(test_obj)

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC)
COMPONENT_INC += $(EXTERN_LIB_BOOST_INC) $(EXTERN_LIB_TF2_INC) $(EXTERN_LIB_YAML_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_TF2_LIB) $(EXTERN_LIB_YAML_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon

COM_SHARED_LIB_NAMES = static_transform_component

## for component.so
static_transform_component_src := $(src)
static_transform_component_obj := $(obj)


####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/transform/* -t $(INSTALL_BIN_DIR)/transform
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/transform/conf/* -t $(INSTALL_DIR)/modules/transform/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/transform/dag/*.dag -t $(INSTALL_DIR)/modules/transform/dag



install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_YAML_DIR)/lib/*so* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_TF2_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
endif
	@$(MKDIR) $(INTERNAL_CONF_DIR)/transform
	@cp -dpRf $(TOP_DIR)/modules/transform/conf/* $(INTERNAL_CONF_DIR)/transform

	@$(MKDIR) $(INTERNAL_DAG_DIR)/transform
	@cp -dpRf $(TOP_DIR)/modules/transform/dag/*.dag $(INTERNAL_DAG_DIR)/transform

####################################################################
## for test
####################################################################

all_self_tests: static_transform_component_test

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_YAML_LIB) $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB) $(EXTERN_LIB_TF2_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/transform
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/transform/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

##  for static_transform_component_test
static_transform_component_test_obj := $(OBJ_DIR)/modules/transform/$(test_obj)
static_transform_component_test :static_transform_component
	$(call MAKE_SELF_TEST, $(static_transform_component_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lstatic_transform_component)


include $(TOP_DIR)/ambabuild/rules.mk