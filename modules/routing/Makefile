###############################################################################
## apollo/modules/routing/Makefile
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

SUBDIRS := common core graph strategy tools topo_creator

src := routing.cc routing_component.cc
obj := $(src:.cc=.o)

## sub modules
common_src := common/routing_gflags.cc
common_obj := $(common_src:common/%.cc=common/%.o)

core_src := $(shell find core -type f -name '*.cc' -not -name '*test.cc')
core_obj := $(core_src:.cc=.o)
#$(info $(hdmap_obj))

graph_src := $(shell find graph -type f -name '*.cc' -not -name '*test.cc')
graph_obj := $(graph_src:.cc=.o)

strategy_src := strategy/a_star_strategy.cc
strategy_obj := $(strategy_src:.cc=.o)

topo_creator_src := $(shell find topo_creator -type f -name '*.cc' -not -name '*test.cc')
topo_creator_obj := $(topo_creator_src:.cc=.o)


####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC) $(EXTERN_LIB_ABSL_INC)
COMPONENT_INC += $(EXTERN_LIB_EIGEN_INC) $(EXTERN_LIB_PROJ_INC) $(EXTERN_LIB_TINYXML_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
COMPONENT_INC += -O0 -g

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_TINYXML_LIB) $(EXTERN_LIB_PROJ_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon -lhdmap_lib

COM_SHARED_LIB_NAMES = routing_component

## for component.so
routing_component_src := $(src) $(common_src) $(core_src) $(graph_src) $(strategy_src) $(topo_creator_src)
routing_component_obj := $(obj) $(common_obj) $(core_obj) $(graph_obj) $(strategy_obj) $(topo_creator_obj)

####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/routing/* -t $(INSTALL_BIN_DIR)/routing
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/routing/conf/* -t $(INSTALL_DIR)/modules/routing/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/routing/dag/* -t $(INSTALL_DIR)/modules/routing/dag
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/routing/tools/routing_tester/routing_test_new.pb.txt -t $(INSTALL_DIR)/modules/routing/testdata

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_PROJ_DIR)/lib/*.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_TINYXML_DIR)/lib/*.a $(INSTALL_DIR)/usr/lib/

	@$(MKDIR) $(INTERNAL_CONF_DIR)/routing
	@cp -dpRf $(TOP_DIR)/modules/routing/conf/* $(INTERNAL_CONF_DIR)/routing

	@$(MKDIR) $(INTERNAL_DAG_DIR)/routing
	@cp -dpRf $(TOP_DIR)/modules/routing/dag/*.dag $(INTERNAL_DAG_DIR)/routing

####################################################################
## for test
####################################################################
all_self_tests: routing_cast routing_dump routing_tester

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_TINYXML_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROJ_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon -lhdmap_lib
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/routing
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/routing/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES

routing_cast_obj := $(OBJ_DIR)/modules/routing/tools/routing_cast.o

routing_cast: routing_component
	$(call MAKE_SELF_TEST, $(routing_cast_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lrouting_component)

routing_dump_obj := $(OBJ_DIR)/modules/routing/tools/routing_dump.o

routing_dump: routing_component
	$(call MAKE_SELF_TEST, $(routing_dump_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lrouting_component)

routing_tester_obj := $(OBJ_DIR)/modules/routing/tools/routing_tester/routing_tester.o

routing_tester: routing_component
	$(call MAKE_SELF_TEST, $(routing_tester_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lrouting_component)

topo_creator_obj := $(OBJ_DIR)/modules/routing/topo_creator/topo_creator.o

topo_creator: routing_component
	$(call MAKE_SELF_TEST, $(topo_creator_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lrouting_component)




include $(TOP_DIR)/ambabuild/rules.mk
