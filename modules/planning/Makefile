###############################################################################
## apollo/modules/planning/Makefile
##
## History:
##    2022/12/09 - [Yang Yu] Created file
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

SUBDIRS := common constraint_checker lattice learning_based math navi/decider pipeline planner traffic_rules tuning scenarios
SUBDIRS += open_space reference_line tasks

src := $(shell find -maxdepth 1 -name '*.cc')
obj := $(src:.cc=.o)

## sub modules
common_src := $(shell find common -type f -name '*.cc' -not -name '*test.cc' -not -name '*gflags.cc')
common_obj := $(common_src:.cc=.o)
#$(info $(hdmap_obj))

constraint_checker_src := $(shell find constraint_checker -type f -name '*.cc' -not -name '*test.cc')
constraint_checker_obj := $(constraint_checker_src:.cc=.o)

lattice_src := $(shell find lattice -type f -name '*.cc' -not -name '*test.cc')
lattice_obj := $(lattice_src:.cc=.o)

learning_based_src := $(shell find learning_based/img_feature_renderer -type f -name '*.cc' -not -name '*test.cc')
learning_based_obj := $(learning_based_src:.cc=.o)

math_src := $(shell find math -type f -name '*.cc' -not -name '*test.cc')
math_obj := $(math_src:.cc=.o)

navi/decider_src := $(shell find navi/decider -type f -name '*.cc' -not -name '*test.cc')
navi/decider_obj := $(navi/decider_src:.cc=.o)

pipeline_src := $(shell find pipeline -type f -name '*.cc' -not -name '*test.cc')
pipeline_obj := $(pipeline_src:.cc=.o)

planner_src := $(shell find planner -type f -name '*.cc' -not -name '*test.cc')
planner_obj := $(planner_src:.cc=.o)

traffic_rules_src := $(shell find traffic_rules -type f -name '*.cc' -not -name '*test.cc')
traffic_rules_obj := $(traffic_rules_src:.cc=.o)

tuning_src := $(shell find tuning -type f -name '*.cc' -not -name '*test.cc')
tuning_obj := $(tuning_src:.cc=.o)

scenarios_src := $(shell find scenarios -type f -name '*.cc' -not -name '*test.cc')
scenarios_obj := $(scenarios_src:.cc=.o)

open_space_src := $(shell find open_space -type f -name '*.cc' -not -name '*test.cc')
open_space_obj := $(open_space_src:.cc=.o)

reference_line_src := $(shell find reference_line -type f -name '*.cc' -not -name '*test.cc' -not -name '*util.cc')
reference_line_obj := $(reference_line_src:.cc=.o)

tasks_src := $(shell find tasks -type f -name '*.cc' -not -name '*test.cc' -not -name '*learning*.cc')
tasks_obj := $(tasks_src:.cc=.o)

COMPONENT_SRC := $(src)
COMPONENT_OBJ := $(obj)

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC) $(EXTERN_LIB_ABSL_INC)
COMPONENT_INC += $(EXTERN_LIB_EIGEN_INC) $(EXTERN_LIB_BOOST_INC) $(EXTERN_LIB_OPENCV_INC)
COMPONENT_INC += $(EXTERN_LIB_OSQP_INC) $(EXTERN_LIB_ADOLC_INC) $(EXTERN_LIB_IPOPT_INC) $(EXTERN_LIB_ADRSS_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
#COMPONENT_INC += -O0 -g

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_TBB_LIB) $(EXTERN_LIB_OPENCV_LIB) $(EXTERN_LIB_JPEG_LIB) $(EXTERN_LIB_PNG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OSQP_LIB) $(EXTERN_LIB_ADOLC_LIB) $(EXTERN_LIB_IPOPT_LIB) $(EXTERN_LIB_ADRSS_LIB)

COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon -lhdmap_lib -lpnc_map_lib

COM_SHARED_LIB_NAMES = planning_component

## for component.so

planning_component_src := $(src) $(common_src) $(constraint_checker_src) $(lattice_src) $(learning_based_src) $(math_src) $(navi/decider_src) $(planner_src) \
                          $(traffic_rules_src) $(tuning_src) $(scenarios_src) $(open_space_src) $(reference_line_src) $(tasks_src)
planning_component_obj := $(obj) $(common_obj) $(constraint_checker_obj) $(lattice_obj) $(learning_based_obj) $(math_obj) $(navi/decider_obj) $(planner_obj) \
                          $(traffic_rules_obj) $(tuning_obj) $(scenarios_obj) $(open_space_obj) $(reference_line_obj) $(tasks_obj)

####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/planning/* -t $(INSTALL_BIN_DIR)/planning
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/planning/conf/*.txt -t $(INSTALL_DIR)/modules/planning/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/planning/conf/*.conf -t $(INSTALL_DIR)/modules/planning/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/planning/conf/scenario/* -t $(INSTALL_DIR)/modules/planning/conf/scenario
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/planning/dag/* -t $(INSTALL_DIR)/modules/planning/dag
	@$(MKDIR) $(INSTALL_DIR)/modules/planning/testdata
	cp -dpRf $(TOP_DIR)/modules/planning/testdata/* $(INSTALL_DIR)/modules/planning/testdata


install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_PROJ_DIR)/lib/*.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_TINYXML_DIR)/lib/*.a $(INSTALL_DIR)/usr/lib/

	@cp -dpRf $(EXTERN_LIB_TBB_DIR)/usr/lib/*.so* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OPENCV_DIR)/usr/lib/*.so* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_JPEG_DIR)/usr/lib/*.so* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_PNG_DIR)/usr/lib/*.so* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ADOLC_DIR)/lib64/*.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ADRSS_DIR)/lib/*.so* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_IPOPT_DIR)/lib/libipopt_full.a $(INSTALL_DIR)/usr/lib/


	@$(MKDIR) $(INTERNAL_CONF_DIR)/planning
	@cp -dpRf $(TOP_DIR)/modules/planning/conf/* $(INTERNAL_CONF_DIR)/planning

	@$(MKDIR) $(INTERNAL_DAG_DIR)/planning
	@cp -dpRf $(TOP_DIR)/modules/planning/dag/*.dag $(INTERNAL_DAG_DIR)/planning

####################################################################
## for test
####################################################################
all_self_tests: lane_follow_scenario_test discrete_points_reference_line_smoother_test \
qp_spline_reference_line_smoother_test spiral_reference_line_smoother_test publishable_trajectory_test

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_TINYXML_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROJ_LIB) $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB) $(EXTERN_LIB_TBB_LIB) $(EXTERN_LIB_OPENCV_LIB) $(EXTERN_LIB_JPEG_LIB) $(EXTERN_LIB_PNG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_OSQP_LIB) $(EXTERN_LIB_ADOLC_LIB) $(EXTERN_LIB_IPOPT_LIB) $(EXTERN_LIB_ADRSS_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon -lhdmap_lib -lpnc_map_lib
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/planning
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/planning/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES

lane_follow_scenario_test_obj := $(OBJ_DIR)/modules/planning/scenarios/lane_follow/lane_follow_scenario_test.o

lane_follow_scenario_test: planning_component
	$(call MAKE_SELF_TEST, $(lane_follow_scenario_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lplanning_component)

discrete_points_reference_line_smoother_test_obj := $(OBJ_DIR)/modules/planning/reference_line/discrete_points_reference_line_smoother_test.o

discrete_points_reference_line_smoother_test: planning_component
	$(call MAKE_SELF_TEST, $(discrete_points_reference_line_smoother_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lplanning_component)


spiral_reference_line_smoother_test_obj := $(OBJ_DIR)/modules/planning/reference_line/spiral_reference_line_smoother_test.o
spiral_reference_line_smoother_test: planning_component
	$(call MAKE_SELF_TEST, $(spiral_reference_line_smoother_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lplanning_component)

qp_spline_reference_line_smoother_test_obj := $(OBJ_DIR)/modules/planning/reference_line/qp_spline_reference_line_smoother_test.o
qp_spline_reference_line_smoother_test: planning_component
	$(call MAKE_SELF_TEST, $(qp_spline_reference_line_smoother_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lplanning_component)

publishable_trajectory_test_obj := $(OBJ_DIR)/modules/planning/common/trajectory/publishable_trajectory_test.o

publishable_trajectory_test: planning_component
	$(call MAKE_SELF_TEST, $(publishable_trajectory_test_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lplanning_component)



include $(TOP_DIR)/ambabuild/rules.mk