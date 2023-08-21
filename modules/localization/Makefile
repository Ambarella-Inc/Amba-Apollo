###############################################################################
## apollo/modules/bridge/Makefile
##
## History:
##    2022/11/09 - [Yang Yu] Created file
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
SUBDIRS += rtk

## sub modules
common_src := common/localization_gflags.cc
common_obj := $(common_src:common/%.cc=common/%.o)

proto_src := $(shell find proto -name '*.cc')
proto_obj := $(proto_src:.cc=.o)

rtk_src := rtk/rtk_localization.cc rtk/rtk_localization_component.cc
rtk_obj := $(rtk_src:rtk/%.cc=rtk/%.o)

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
COMPONENT_LDFLAG += -L$(INTERNAL_COM_LIB_DIR) -lstatic_transform_component

COM_SHARED_LIB_NAMES = rtk_localization_component

## for component.so
rtk_localization_component_src := $(rtk_src) $(common_src) $(proto_src)
rtk_localization_component_obj := $(rtk_obj) $(common_obj) $(proto_obj)

####################################################################
## install
####################################################################
install:
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_YAML_DIR)/lib/*so* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_TF2_DIR)/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_LIB_DIR)
endif
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/localization/* -t $(INSTALL_BIN_DIR)/localization
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/localization/conf/* -t $(INSTALL_DIR)/modules/localization/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/localization/dag/*.dag -t $(INSTALL_DIR)/modules/localization/dag
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/localization/testdata/* -t $(INSTALL_DIR)/modules/localization/testdata

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_YAML_DIR)/lib/*so* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_TF2_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
endif
	@$(MKDIR) $(INTERNAL_CONF_DIR)/localization
	@cp -dpRf $(TOP_DIR)/modules/localization/conf/* $(INTERNAL_CONF_DIR)/localization

	@$(MKDIR) $(INTERNAL_DAG_DIR)/localization
	@cp -dpRf $(TOP_DIR)/modules/localization/dag/*.dag $(INTERNAL_DAG_DIR)/localization

####################################################################
## for test
####################################################################
all_self_tests: rtk_localization_test

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_YAML_LIB) $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_OSQP_LIB) $(EXTERN_LIB_TF2_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/localization
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/localization/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES

rtk_localization_test_obj := $(OBJ_DIR)/modules/localization/rtk/rtk_localization_test.o

rtk_localization_test: rtk_localization_component
	$(call MAKE_SELF_TEST, $(rtk_localization_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lrtk_localization_component \
	-L$(INTERNAL_COM_LIB_DIR) -lstatic_transform_component)


include $(TOP_DIR)/ambabuild/rules.mk