###############################################################################
## apollo/modules/common/Makefile
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

SUBDIRS := adapters configs filters kv_db latency_recorder monitor_log util math
SUBDIRS += vehicle_state vehicle_model
## sub modules
adapters_src := adapters/adapter_gflags.cc adapters/proto/adapter_config.pb.cc
adapters_obj := $(adapters_src:adapters/%.cc=adapters/%.o)

configs_src := configs/config_gflags.cc configs/vehicle_config_helper.cc
configs_obj := $(configs_src:configs/%.cc=configs/%.o)

filters_src := filters/digital_filter.cc filters/mean_filter.cc filters/digital_filter_coefficients.cc
filters_obj := $(filters_src:filters/%.cc=filters/%.o)

kv_db_src := kv_db/kv_db.cc
kv_db_obj := $(kv_db_src:kv_db/%.cc=kv_db/%.o)

latency_recorder_src := latency_recorder/latency_recorder.cc latency_recorder/proto/latency_record.pb.cc
latency_recorder_obj := $(latency_recorder_src:latency_recorder/%.cc=latency_recorder/%.o)

monitor_log_src := monitor_log/monitor_logger.cc monitor_log/monitor_log_buffer.cc
monitor_log_obj := $(monitor_log_src:monitor_log/%.cc=monitor_log/%.o)

util_src := util/util.cc util/string_util.cc util/perf_util.cc util/json_util.cc
util_obj := $(util_src:util/%.cc=util/%.o)

math_src := math/math_utils.cc math/vec2d.cc math/aabox2d.cc math/box2d.cc math/line_segment2d.cc math/polygon2d.cc math/sin_table.cc math/angle.cc \
            math/matrix_operations.cc math/path_matcher.cc math/search.cc math/linear_interpolation.cc \
            math/cartesian_frenet_conversion.cc math/integral.cc math/linear_quadratic_regulator.cc math/qp_solver/qp_solver.cc math/mpc_osqp.cc
math_obj := $(math_src:math/%.cc=math/%.o)

vehicle_state_src := vehicle_state/vehicle_state_provider.cc vehicle_state/proto/vehicle_state.pb.cc
vehicle_state_obj := $(vehicle_state_src:vehicle_state/%.cc=vehicle_state/%.o)

vehicle_model_src := vehicle_model/vehicle_model.cc vehicle_model/proto/vehicle_model_config.pb.cc
vehicle_model_obj := $(vehicle_model_src:vehicle_model/%.cc=vehicle_model/%.o)

## for gflags in other modules
add_flags_src := #../localization/common/localization_gflags.cc ../planning/common/planning_gflags.cc
add_flags_obj := #../localization/common/localization_gflags.o ../planning/common/planning_gflags.o

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC) $(EXTERN_LIB_SQL_INC) $(EXTERN_LIB_EIGEN_INC) $(EXTERN_LIB_OSQP_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_SQL_LIB) $(EXTERN_LIB_OSQP_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber


SHARED_LIB_NAMES = common

## for component.so
common_src := $(adapters_src) $(configs_src) $(filters_src) $(kv_db_src) $(latency_recorder_src) \
              $(monitor_log_src) $(util_src) $(math_src) $(vehicle_state_src) $(vehicle_model_src) $(add_flags_src)

common_obj := $(adapters_obj) $(configs_obj) $(filters_obj) $(kv_db_obj) $(latency_recorder_obj) \
              $(monitor_log_obj) $(util_obj) $(math_obj) $(vehicle_state_obj) $(vehicle_model_obj) $(add_flags_obj)

####################################################################
## install needed libs
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_LIB_DIR)/* -t $(INSTALL_LIB_DIR)
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_ZLIB_DIR)/usr/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_SQL_DIR)/usr/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/* $(INSTALL_LIB_DIR)
endif
	$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/common/* -t $(INSTALL_BIN_DIR)/common
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/common/data/* -t $(INSTALL_DIR)/modules/common/data


install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ZLIB_DIR)/usr/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_SQL_DIR)/usr/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
endif
####################################################################
## for test
####################################################################
all_self_tests: vehicle_config_helper_test monitor_log_buffer_test


TEST_LDFLAG := -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon
TEST_LDFLAG += $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/common
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/common/$@ \
		$(1) \
		$(TEST_LDFLAG)
endef

#EXECUTABLE_FILES =

## for vehicle_config_helper_test
vehicle_config_helper_test_obj := $(OBJ_DIR)/modules/common/configs/vehicle_config_helper_test.o
#vehicle_config_helper_test_obj += $(OBJ_DIR)/modules/localization/proto/pose.pb.o
vehicle_config_helper_test: common
	$(call MAKE_SELF_TEST, $(vehicle_config_helper_test_obj))


## for monitor_log_buffer_test
monitor_log_buffer_test_obj := $(OBJ_DIR)/modules/common/monitor_log/monitor_log_buffer_test.o
#monitor_log_buffer_test_obj += $(OBJ_DIR)/modules/localization/proto/pose.pb.o
monitor_log_buffer_test: common
	$(call MAKE_SELF_TEST, $(monitor_log_buffer_test_obj))


include $(TOP_DIR)/ambabuild/rules.mk