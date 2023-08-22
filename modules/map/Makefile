###############################################################################
## apollo/modules/map/Makefile
##
## History:
##    2022/12/07 - [Yang Yu] Created file
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

SUBDIRS := hdmap pnc_map relative_map

## sub modules
hdmap_dir := hdmap
hdmap_src := $(shell find $(hdmap_dir) -maxdepth 3 -type f -name '*.cc' -not -name '*test.cc')
hdmap_obj := $(hdmap_src:.cc=.o)
#$(info $(hdmap_obj))

pnc_map_dir := pnc_map
pnc_map_src := $(shell find $(pnc_map_dir) -maxdepth 3 -type f -name '*.cc' -not -name '*test.cc')
pnc_map_obj := $(pnc_map_src:.cc=.o)

relative_map_dir := relative_map relative_map/common relative_map/proto
relative_map_src := $(shell find $(relative_map_dir) -maxdepth 1 -type f -name '*.cc' -not -name '*test.cc')
relative_map_obj := $(relative_map_src:.cc=.o)

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC) $(EXTERN_LIB_ABSL_INC)
COMPONENT_INC += $(EXTERN_LIB_EIGEN_INC) $(EXTERN_LIB_PROJ_INC) $(EXTERN_LIB_TINYXML_INC) $(EXTERN_LIB_JSON_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
#COMPONENT_INC += -O0 -g

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_TINYXML_LIB) $(EXTERN_LIB_PROJ_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon

SHARED_LIB_NAMES = hdmap_lib pnc_map_lib

COM_SHARED_LIB_NAMES = relative_map_component

## for component.so
hdmap_lib_src := $(hdmap_src)
hdmap_lib_obj := $(hdmap_obj)

pnc_map_lib_src := $(pnc_map_src)
pnc_map_lib_obj := $(pnc_map_obj)

relative_map_component_src := $(relative_map_src)
relative_map_component_obj := $(relative_map_obj)

####################################################################
## install needed libs
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0644 -D $(INTERNAL_LIB_DIR)/* -t $(INSTALL_LIB_DIR)
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_PROJ_DIR)/lib/*.a $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_TINYXML_DIR)/lib/*.a $(INSTALL_LIB_DIR)
endif
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/map/* -t $(INSTALL_BIN_DIR)/map
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/map/relative_map/conf/* -t $(INSTALL_DIR)/modules/map/relative_map/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/map/relative_map/dag/*.dag -t $(INSTALL_DIR)/modules/map/relative_map/dag

	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/map/data/demo/*  -t $(INSTALL_DIR)/modules/map/data/demo
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/map/data/borregas_ave/*  -t $(INSTALL_DIR)/modules/map/data/borregas_ave
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/map/hdmap/test-data/* -t $(INSTALL_DIR)/modules/map/hdmap/test-data
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/map/pnc_map/testdata/* -t $(INSTALL_DIR)/modules/map/pnc_map/testdata
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/map/relative_map/testdata/multi_lane_map/* -t $(INSTALL_DIR)/modules/map/relative_map/testdata/multi_lane_map

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_PROJ_DIR)/lib/*.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_TINYXML_DIR)/lib/*.a $(INSTALL_DIR)/usr/lib/
endif
	@$(MKDIR) $(INTERNAL_CONF_DIR)/map/relative_map
	@cp -dpRf $(TOP_DIR)/modules/map/relative_map/conf/* $(INTERNAL_CONF_DIR)/map/relative_map

	@$(MKDIR) $(INTERNAL_DAG_DIR)/map/relative_map
	@cp -dpRf $(TOP_DIR)/modules/map/relative_map/dag/*.dag $(INTERNAL_DAG_DIR)/map/relative_map


####################################################################
## for test
####################################################################
all_self_tests: hdmap_map_test path_test navigation_lane_test

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_TINYXML_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROJ_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/map
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/map/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES

hdmap_map_test_obj := $(OBJ_DIR)/modules/map/hdmap/hdmap_common_test.o $(OBJ_DIR)/modules/map/hdmap/hdmap_impl_test.o

hdmap_map_test: hdmap_lib
	$(call MAKE_SELF_TEST, $(hdmap_map_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lhdmap_lib)

pnc_map_test_obj := $(OBJ_DIR)/modules/map/pnc_map/pnc_map_test.o

pnc_map_test: hdmap_lib pnc_map_lib
	$(call MAKE_SELF_TEST, $(pnc_map_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lhdmap_lib -lpnc_map_lib)

path_test_obj := $(OBJ_DIR)/modules/map/pnc_map/path_test.o

path_test: hdmap_lib pnc_map_lib
	$(call MAKE_SELF_TEST, $(path_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lhdmap_lib -lpnc_map_lib)

navigation_lane_test_obj := $(OBJ_DIR)/modules/map/relative_map/navigation_lane_test.o
navigation_lane_test: relative_map_component
	$(call MAKE_SELF_TEST, $(navigation_lane_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lrelative_map_component)



include $(TOP_DIR)/ambabuild/rules.mk
