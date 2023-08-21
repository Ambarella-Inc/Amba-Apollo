###############################################################################
## apollo/cyber/Makefile
##
## History:
##    2022/08/04 - [Zhi He] Created file
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

.PHONY : all install
default: all

include ../ambabuild/prerequisites.mk

include $(TOP_DIR)/ambabuild/config.mk
include $(TOP_DIR)/ambabuild/extern_lib.mk
include $(TOP_DIR)/ambabuild/cvapi_lib.mk

####################################################################
## for cyberRT library 
####################################################################

SUBDIRS := base blocker class_loader common component croutine data event examples io logger mainboard message node
SUBDIRS += parameter proto record scheduler service_discovery sysmo task time timer transport tools/cyber_monitor tools/cyber_recorder

## source files and object files
src := binary.cc cyber.cc init.cc state.cc
obj := $(src:%.cc=%.o)

## sub modules
blocker_src := blocker/blocker_manager.cc
blocker_obj := $(blocker_src:blocker/%.cc=blocker/%.o)

class_loader_src := class_loader/class_loader.cc class_loader/class_loader_manager.cc
class_loader_src += class_loader/shared_library/shared_library.cc
#class_loader_src += class_loader/test/plugin1.cc class_loader/test/plugin2.cc class_loader/shared_library/sample.cc
class_loader_src += class_loader/utility/class_factory.cc class_loader/utility/class_loader_utility.cc
class_loader_obj := $(class_loader_src:class_loader/%.cc=class_loader/%.o)

common_src := common/file.cc common/global_data.cc
common_obj := $(common_src:common/%.cc=common/%.o)

component_src := component/timer_component.cc
component_obj := $(component_src:component/%.cc=component/%.o)

croutine_src := croutine/croutine.cc croutine/detail/routine_context.cc
croutine_obj := $(croutine_src:croutine/%.cc=croutine/%.o)
croutine_src += croutine/detail/swap_aarch64.S
croutine_obj += croutine/detail/swap_aarch64.o

event_src := event/perf_event_cache.cc
event_obj := $(event_src:event/%.cc=event/%.o)

examples_src := examples/talker.cc examples/listener.cc examples/paramserver.cc examples/service.cc examples/record.cc
examples_src += examples/proto/examples.pb.cc
examples_obj := $(examples_src:examples/%.cc=examples/%.o)

io_src := io/poll_handler.cc io/poller.cc io/session.cc
io_obj := $(io_src:io/%.cc=io/%.o)

logger_src := logger/async_logger.cc logger/log_file_object.cc logger/logger_util.cc logger/logger.cc
logger_obj := $(logger_src:logger/%.cc=logger/%.o)

mainboard_src := mainboard/mainboard.cc mainboard/module_argument.cc mainboard/module_controller.cc
mainboard_obj := $(mainboard_src:mainboard/%.cc=mainboard/%.o)

message_src := message/protobuf_factory.cc
message_obj := $(message_src:message/%.cc=message/%.o)

node_src := node/node.cc
node_obj := $(node_src:node/%.cc=node/%.o)

parameter_src := parameter/parameter.cc parameter/parameter_client.cc parameter/parameter_server.cc
parameter_obj := $(parameter_src:parameter/%.cc=parameter/%.o)

proto_src := proto/choreography_conf.pb.cc proto/classic_conf.pb.cc proto/clock.pb.cc proto/component_conf.pb.cc
proto_src += proto/cyber_conf.pb.cc proto/dag_conf.pb.cc proto/parameter.pb.cc proto/perf_conf.pb.cc proto/proto_desc.pb.cc
proto_src += proto/qos_profile.pb.cc proto/record.pb.cc proto/role_attributes.pb.cc proto/run_mode_conf.pb.cc
proto_src += proto/scheduler_conf.pb.cc proto/topology_change.pb.cc proto/transport_conf.pb.cc proto/unit_test.pb.cc
proto_obj := $(proto_src:proto/%.cc=proto/%.o)

record_src := record/header_builder.cc record/record_reader.cc record/record_viewer.cc record/record_writer.cc
record_src += record/file/record_file_base.cc record/file/record_file_reader.cc record/file/record_file_writer.cc
record_obj := $(record_src:record/%.cc=record/%.o)

scheduler_src := scheduler/processor.cc scheduler/processor_context.cc scheduler/scheduler.cc scheduler/scheduler_factory.cc
scheduler_src += scheduler/common/pin_thread.cc
scheduler_src += scheduler/policy/scheduler_choreography.cc scheduler/policy/scheduler_classic.cc scheduler/policy/choreography_context.cc scheduler/policy/classic_context.cc
scheduler_obj := $(scheduler_src:scheduler/%.cc=scheduler/%.o)

service_discovery_src := service_discovery/topology_manager.cc
service_discovery_src += service_discovery/communication/participant_listener.cc service_discovery/communication/subscriber_listener.cc
service_discovery_src += service_discovery/container/graph.cc service_discovery/container/multi_value_warehouse.cc service_discovery/container/single_value_warehouse.cc
service_discovery_src += service_discovery/role/role.cc
service_discovery_src += service_discovery/specific_manager/manager.cc service_discovery/specific_manager/channel_manager.cc
service_discovery_src += service_discovery/specific_manager/node_manager.cc service_discovery/specific_manager/service_manager.cc
service_discovery_obj := $(service_discovery_src:service_discovery/%.cc=service_discovery/%.o)

sysmo_src := sysmo/sysmo.cc
sysmo_obj := $(sysmo_src:sysmo/%.cc=sysmo/%.o)

task_src := task/task_manager.cc
task_obj := $(task_src:task/%.cc=task/%.o)

time_src := time/time.cc time/rate.cc time/duration.cc time/clock.cc
time_obj := $(time_src:time/%.cc=time/%.o)

timer_src := timer/timer.cc timer/timing_wheel.cc
timer_obj := $(timer_src:timer/%.cc=timer/%.o)

transport_src := transport/transport.cc
transport_src += transport/common/endpoint.cc transport/common/identity.cc
transport_src += transport/dispatcher/dispatcher.cc transport/dispatcher/intra_dispatcher.cc transport/dispatcher/rtps_dispatcher.cc transport/dispatcher/shm_dispatcher.cc
transport_src += transport/message/message_info.cc
transport_src += transport/qos/qos_profile_conf.cc
transport_src += transport/rtps/attributes_filler.cc transport/rtps/sub_listener.cc transport/rtps/participant.cc
transport_src += transport/rtps/underlay_message.cc transport/rtps/underlay_message_type.cc
transport_src += transport/shm/block.cc transport/shm/condition_notifier.cc transport/shm/multicast_notifier.cc transport/shm/notifier_factory.cc
transport_src += transport/shm/readable_info.cc transport/shm/xsi_segment.cc transport/shm/posix_segment.cc transport/shm/segment.cc transport/shm/segment_factory.cc
transport_src += transport/shm/shm_conf.cc transport/shm/state.cc
transport_obj := $(transport_src:transport/%.cc=transport/%.o)


monitor_dir := tools/cyber_monitor
monitor_src := $(shell find $(monitor_dir) -maxdepth 1 -type f -name '*.cc')
monitor_obj := $(monitor_src:.cc=.o)

recorder_dir := tools/cyber_recorder
recorder_src := $(shell find $(recorder_dir) -maxdepth 2 -type f -name '*.cc')
recorder_obj := $(recorder_src:.cc=.o)

LIB_CYBER_SRC := $(src) \
    $(blocker_src) \
    $(class_loader_src) \
    $(common_src) \
    $(component_src) \
    $(croutine_src) \
    $(event_src) \
    $(io_src) \
    $(logger_src) \
    $(message_src) \
    $(node_src) \
    $(proto_src) \
    $(parameter_src) \
    $(record_src) \
    $(scheduler_src) \
    $(service_discovery_src) \
    $(sysmo_src) \
    $(task_src) \
    $(time_src) \
    $(timer_src) \
    $(transport_src)

LIB_CYBER_OBJ := $(obj) \
    $(blocker_obj) \
    $(class_loader_obj) \
    $(common_obj) \
    $(component_obj) \
    $(croutine_obj) \
    $(event_obj) \
    $(io_obj) \
    $(logger_obj) \
    $(message_obj) \
    $(node_obj) \
    $(parameter_obj) \
    $(proto_obj) \
    $(record_obj) \
    $(scheduler_obj) \
    $(service_discovery_obj) \
    $(sysmo_obj) \
    $(task_obj) \
    $(time_obj) \
    $(timer_obj) \
    $(transport_obj)

COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC) $(CV_API_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += -latomic
ifeq ($(ENABLE_LYCHEE), y)
COMPONENT_LDFLAG += -ltinyxml2
endif

AMBACV_LDFLAG := $(CV_API_LIB)


STATIC_LIB_NAMES =
## cyber library
SHARED_LIB_NAMES = cyber

## for cyber.so
cyber_src := $(LIB_CYBER_SRC)
cyber_obj := $(LIB_CYBER_OBJ)

####################################################################
##  test library
####################################################################

COM_SHARED_LIB_NAMES = plugin1 plugin2 sample common_component_example timer_component_example

## for plugin1.so
plugin1_src := class_loader/test/plugin1.cc
plugin1_obj := class_loader/test/plugin1.o

## for plugin2.so
plugin2_src := class_loader/test/plugin2.cc
plugin2_obj := class_loader/test/plugin2.o

## for sample.so
sample_src := class_loader/shared_library/sample.cc
sample_obj := class_loader/shared_library/sample.o

## for common_component_example.so (should with -O0)
common_component_example_src := examples/common_component_example/common_component_example.cc examples/proto/examples.pb.cc
common_component_example_obj := examples/common_component_example/common_component_example.o examples/proto/examples.pb.o

## for timer_component_example.so
timer_component_example_src := examples/timer_component_example/timer_component_example.cc examples/proto/examples.pb.cc
timer_component_example_obj := examples/timer_component_example/timer_component_example.o examples/proto/examples.pb.o


####################################################################
##  AmbaCV related component library
####################################################################
AMBA_COM_SHARED_LIB_NAMES = #ambacv_component_example

## for ambacv_component_example.so
ambacv_component_example_src :=
ambacv_component_example_obj := examples/ambacv_component_example/FlexidagRun.o \
                                examples/ambacv_component_example/ambacv_component_example.o \
								examples/proto/examples.pb.o

####################################################################
## internal tests
####################################################################
EXECUTABLE_FILES = atomic_hash_map_test atomic_rw_lock_test bounded_queue_test \
                   for_each_test signal_test unbounded_queue_test blocker_test cache_buffer_test \
                   message_header_test raw_message_test time_test duration_test

## for atomic hash map test
atomic_hash_map_test_obj := base/atomic_hash_map_test.o

## for atomic rw lock test
atomic_rw_lock_test_obj := base/atomic_rw_lock_test.o

## for bounded queue test
bounded_queue_test_obj := base/bounded_queue_test.o

## for for_each test
for_each_test_obj := base/for_each_test.o

## for signal test
signal_test_obj := base/signal_test.o

## for unbounded_queue test
unbounded_queue_test_obj := base/unbounded_queue_test.o

## for blocker test
blocker_test_obj := blocker/blocker_test.o proto/unit_test.pb.o

## for cache_buffer test
cache_buffer_test_obj := data/cache_buffer_test.o

## for message_header test
message_header_test_obj := message/message_header_test.o

## for raw_message_test
raw_message_test_obj := message/raw_message_test.o

## for time_test
time_test_obj := time/time_test.o time/time.o time/duration.o

## for duration_test
duration_test_obj := time/duration_test.o time/time.o time/duration.o

include $(TOP_DIR)/ambabuild/rules.mk

####################################################################
## install
####################################################################

install:
	@$(INSTALL) -m 0644 -D $(INTERNAL_LIB_DIR)/* -t $(INSTALL_LIB_DIR)
##if you don't build in lychee, install needed extern libs
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_FASTCDR_DIR)/lib/libfastcdr.so* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_FASTRTPS_DIR)/lib/libfastrtps.so* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_GLOG_DIR)/usr/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_GFLAGS_DIR)/usr/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_PROTOBUF_DIR)/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_UTILS_LINUX_LIBS_DIR)/usr/lib/* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_GTEST_DIR)/lib/*.so $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_OPENSSL_DIR)/lib* $(INSTALL_LIB_DIR)
	@cp -dpRf $(EXTERN_LIB_NCURSES_DIR)/usr/lib/* $(INSTALL_LIB_DIR)
endif
	@$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	@$(INSTALL) -m 0755 -D $(INTERNAL_BIN_DIR)/cyber/* -t $(INSTALL_BIN_DIR)/cyber
	@$(INSTALL) -m 0755  $(INTERNAL_BIN_DIR)/cyber/mainboard_test $(INSTALL_BIN_DIR)/mainboard
	@$(INSTALL) -m 0755  $(INTERNAL_BIN_DIR)/cyber/cyber_monitor $(INSTALL_BIN_DIR)/cyber_monitor
	@$(INSTALL) -m 0755  $(INTERNAL_BIN_DIR)/cyber/cyber_recorder $(INSTALL_BIN_DIR)/cyber_recorder
	@$(INSTALL) -m 0755 -D $(TOP_DIR)/for_test/cyber_self_test.sh $(INSTALL_BIN_DIR)/cyber
	@$(INSTALL) -m 0644 -D $(TOP_DIR)/cyber/conf/* -t $(INSTALL_DIR)/cyber/conf
	@$(INSTALL) -m 0644 -D $(TOP_DIR)/cyber/examples/common_component_example/*.dag -t $(INSTALL_DIR)/cyber/dag
	@$(INSTALL) -m 0644 -D $(TOP_DIR)/cyber/examples/timer_component_example/*.dag -t $(INSTALL_DIR)/cyber/dag
	@$(INSTALL) -m 0755 -D $(TOP_DIR)/for_test/* -t $(INSTALL_SCRIPTS_DIR)

## this rule will not be used!
install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
ifeq ($(ENABLE_LYCHEE), n)
	@cp -dpRf $(EXTERN_LIB_FASTCDR_DIR)/lib/libfastcdr.so* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_FASTRTPS_DIR)/lib/libfastrtps.so* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_GLOG_DIR)/usr/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_GFLAGS_DIR)/usr/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_PROTOBUF_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_UTILS_LINUX_LIBS_DIR)/usr/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_GTEST_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/
endif
##@cp -dpRf $(EXTERN_LIB_OPENSSL_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(TOP_DIR)/for_test/set_test_env.sh $(INSTALL_DIR)/

####################################################################
## below is self-tests which links to libcyber.so
####################################################################

all_self_tests: object_pool_test blocker_manager_test shared_library_test class_loader_test file_test log_test environment_test macros_test \
                component_test timer_component_test data_visitor_test data_dispatcher_test channel_buffer_test all_latest_test \
                async_logger_test log_file_object_test logger_util_test logger_test message_traits_test protobuf_factory_test \
                node_channel_impl_test node_test reader_test writer_reader_test writer_test parameter_test parameter_client_test parameter_server_test \
                record_file_test record_file_integration_test record_reader_test record_viewer_test \
                scheduler_test scheduler_classic_test scheduler_choreo_test processor_test pin_thread_test \
                topology_manager_test graph_test multi_value_warehouse_test single_value_warehouse_test role_test \
                channel_manager_test node_manager_test service_manager_test sysmo_test task_test clock_test timer_test \
                transport_test intra_dispatcher_test shm_dispatcher_test rtps_dispatcher_test hybrid_transceiver_test rtps_test \
                message_test message_info_test

all_example_tests: cyber_monitor cyber_recorder mainboard_test \
                   channel_test_writer channel_prediction_writer talker_test listener_test service_test paramserver_test

## below are for which links to cyber rt

TEST_LDFLAG := -L$(INTERNAL_LIB_DIR) -lcyber
TEST_LDFLAG += $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += -latomic
ifeq ($(ENABLE_LYCHEE), y)
TEST_LDFLAG += -ltinyxml2
endif

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/cyber
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/cyber/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef


## for UT_FlexidagRun

UT_FlexidagRun_obj := $(OBJ_DIR)/cyber/examples/ambacv_component_example/UT_FlexidagRun.o
UT_FlexidagRun:
	$(call MAKE_SELF_TEST, $(UT_FlexidagRun_obj) $(CV_API_LIB))


## for ambacv_test data_provider

data_provider_obj := $(OBJ_DIR)/cyber/examples/ambacv_component_example/data_provider.o
data_provider_obj += $(OBJ_DIR)/cyber/examples/proto/examples.pb.o
data_provider: cyber
	$(call MAKE_SELF_TEST, $(data_provider_obj))

## for mainboard
mainboard_test_obj := $(OBJ_DIR)/cyber/mainboard/mainboard.o
mainboard_test_obj += $(OBJ_DIR)/cyber/mainboard/module_argument.o
mainboard_test_obj += $(OBJ_DIR)/cyber/mainboard/module_controller.o
mainboard_test: cyber
	$(call MAKE_SELF_TEST, $(mainboard_test_obj))

## for cyber_monitor
cyber_monitor_obj := $(addprefix $(OBJ_DIR)/cyber/, $(monitor_obj))
cyber_monitor: cyber
	$(call MAKE_SELF_TEST, $(cyber_monitor_obj) $(EXTERN_LIB_NCURSES_LIB))

## for cyber_recorder
cyber_recorder_obj := $(addprefix $(OBJ_DIR)/cyber/, $(recorder_obj))
cyber_recorder: cyber
	$(call MAKE_SELF_TEST, $(cyber_recorder_obj))

## for service_test

service_test_obj := $(OBJ_DIR)/cyber/examples/service.o
service_test_obj += $(OBJ_DIR)/cyber/examples/proto/examples.pb.o
service_test: cyber
	$(call MAKE_SELF_TEST, $(service_test_obj))

## for paramserver_test

paramserver_test_obj := $(OBJ_DIR)/cyber/examples/paramserver.o
paramserver_test: cyber
	$(call MAKE_SELF_TEST, $(paramserver_test_obj))

## for talker_test

talker_test_obj := $(OBJ_DIR)/cyber/examples/talker.o
talker_test_obj += $(OBJ_DIR)/cyber/examples/proto/examples.pb.o
talker_test: cyber
	$(call MAKE_SELF_TEST, $(talker_test_obj))

## for listener_test (should with -O0)

listener_test_obj := $(OBJ_DIR)/cyber/examples/listener.o
listener_test_obj += $(OBJ_DIR)/cyber/examples/proto/examples.pb.o
listener_test: cyber
	$(call MAKE_SELF_TEST, $(listener_test_obj))


## for channel_test_writer

channel_test_writer_obj := $(OBJ_DIR)/cyber/examples/common_component_example/channel_test_writer.o
channel_test_writer_obj += $(OBJ_DIR)/cyber/examples/proto/examples.pb.o
channel_test_writer: cyber
	$(call MAKE_SELF_TEST, $(channel_test_writer_obj))

## for channel_prediction_writer

channel_prediction_writer_obj := $(OBJ_DIR)/cyber/examples/common_component_example/channel_prediction_writer.o
channel_prediction_writer_obj += $(OBJ_DIR)/cyber/examples/proto/examples.pb.o
channel_prediction_writer: cyber
	$(call MAKE_SELF_TEST, $(channel_prediction_writer_obj))

## for object_pool test

object_pool_test_obj := $(OBJ_DIR)/cyber/base/object_pool_test.o
object_pool_test: cyber
	$(call MAKE_SELF_TEST, $(object_pool_test_obj))

## for blocker_manager test

blocker_manager_test_obj := $(OBJ_DIR)/cyber/blocker/blocker_manager_test.o
blocker_manager_test: cyber
	$(call MAKE_SELF_TEST, $(blocker_manager_test_obj))

## for class_loader test

class_loader_test_obj := $(OBJ_DIR)/cyber/class_loader/class_loader_test.o
class_loader_test: cyber
	$(call MAKE_SELF_TEST, $(class_loader_test_obj))

## for shared_library_test

shared_library_test_obj := $(OBJ_DIR)/cyber/class_loader/shared_library/shared_library_test.o
shared_library_test: cyber
	$(call MAKE_SELF_TEST, $(shared_library_test_obj))

## for file test

file_test_obj := $(OBJ_DIR)/cyber/common/file_test.o
file_test: cyber
	$(call MAKE_SELF_TEST, $(file_test_obj))

## for log test

log_test_obj := $(OBJ_DIR)/cyber/common/log_test.o
log_test: cyber
	$(call MAKE_SELF_TEST, $(log_test_obj))

## for environment test

environment_test_obj := $(OBJ_DIR)/cyber/common/environment_test.o
environment_test: cyber
	$(call MAKE_SELF_TEST, $(environment_test_obj))

## for macros test

macros_test_obj := $(OBJ_DIR)/cyber/common/macros_test.o
macros_test: cyber
	$(call MAKE_SELF_TEST, $(macros_test_obj))

## for component test

component_test_obj := $(OBJ_DIR)/cyber/component/component_test.o
component_test: cyber
	$(call MAKE_SELF_TEST, $(component_test_obj))

## for timer_component test NOT PASS

timer_component_test_obj := $(OBJ_DIR)/cyber/component/timer_component_test.o
timer_component_test: cyber
	$(call MAKE_SELF_TEST, $(timer_component_test_obj))

## for croutine test

croutine_test_obj := $(OBJ_DIR)/cyber/croutine/croutine_test.o
croutine_test: cyber
	$(call MAKE_SELF_TEST, $(croutine_test_obj))

## for data_visitor test

data_visitor_test_obj := $(OBJ_DIR)/cyber/data/data_visitor_test.o
data_visitor_test: cyber
	$(call MAKE_SELF_TEST, $(data_visitor_test_obj))

## for data_dispatcher test

data_dispatcher_test_obj := $(OBJ_DIR)/cyber/data/data_dispatcher_test.o
data_dispatcher_test: cyber
	$(call MAKE_SELF_TEST, $(data_dispatcher_test_obj))

## for channel_buffer test

channel_buffer_test_obj := $(OBJ_DIR)/cyber/data/channel_buffer_test.o
channel_buffer_test: cyber
	$(call MAKE_SELF_TEST, $(channel_buffer_test_obj))

## for all_latest_test

all_latest_test_obj := $(OBJ_DIR)/cyber/data/fusion/all_latest_test.o
all_latest_test: cyber
	$(call MAKE_SELF_TEST, $(all_latest_test_obj))

## for logger test

logger_test_obj := $(OBJ_DIR)/cyber/logger/logger_test.o
logger_test: cyber
	$(call MAKE_SELF_TEST, $(logger_test_obj))

## for async_logger test

async_logger_test_obj := $(OBJ_DIR)/cyber/logger/async_logger_test.o
async_logger_test: cyber
	$(call MAKE_SELF_TEST, $(async_logger_test_obj))

## for log_file_object test

log_file_object_test_obj := $(OBJ_DIR)/cyber/logger/log_file_object_test.o
log_file_object_test: cyber
	$(call MAKE_SELF_TEST, $(log_file_object_test_obj))

## for logger_util test

logger_util_test_obj := $(OBJ_DIR)/cyber/logger/logger_util_test.o
logger_util_test: cyber
	$(call MAKE_SELF_TEST, $(logger_util_test_obj))

## for message_traits test

message_traits_test_obj := $(OBJ_DIR)/cyber/message/message_traits_test.o
message_traits_test: cyber
	$(call MAKE_SELF_TEST, $(message_traits_test_obj))

## for protobuf_factory_test

protobuf_factory_test_obj := $(OBJ_DIR)/cyber/message/protobuf_factory_test.o
protobuf_factory_test: cyber
	$(call MAKE_SELF_TEST, $(protobuf_factory_test_obj))

## for node_channel_impl_test

node_channel_impl_test_obj := $(OBJ_DIR)/cyber/node/node_channel_impl_test.o
node_channel_impl_test: cyber
	$(call MAKE_SELF_TEST, $(node_channel_impl_test_obj))

## for node_test

node_test_obj := $(OBJ_DIR)/cyber/node/node_test.o
node_test: cyber
	$(call MAKE_SELF_TEST, $(node_test_obj))

## for reader_test

reader_test_obj := $(OBJ_DIR)/cyber/node/reader_test.o
reader_test: cyber
	$(call MAKE_SELF_TEST, $(reader_test_obj))

## for writer_reader_test (should with -O0)

writer_reader_test_obj := $(OBJ_DIR)/cyber/node/writer_reader_test.o
writer_reader_test: cyber
	$(call MAKE_SELF_TEST, $(writer_reader_test_obj))

## for writer_test

writer_test_obj := $(OBJ_DIR)/cyber/node/writer_test.o
writer_test: cyber
	$(call MAKE_SELF_TEST, $(writer_test_obj))

## for parameter_test

parameter_test_obj := $(OBJ_DIR)/cyber/parameter/parameter_test.o
parameter_test: cyber
	$(call MAKE_SELF_TEST, $(parameter_test_obj))

## for parameter_client_test

parameter_client_test_obj := $(OBJ_DIR)/cyber/parameter/parameter_client_test.o
parameter_client_test: cyber
	$(call MAKE_SELF_TEST, $(parameter_client_test_obj))

## for parameter_server_test

parameter_server_test_obj := $(OBJ_DIR)/cyber/parameter/parameter_server_test.o
parameter_server_test: cyber
	$(call MAKE_SELF_TEST, $(parameter_server_test_obj))

## for file/record_file_test

record_file_test_obj := $(OBJ_DIR)/cyber/record/file/record_file_test.o
record_file_test: cyber
	$(call MAKE_SELF_TEST, $(record_file_test_obj))

## for file/record_file_integration_test

record_file_integration_test_obj := $(OBJ_DIR)/cyber/record/file/record_file_integration_test.o
record_file_integration_test: cyber
	$(call MAKE_SELF_TEST, $(record_file_integration_test_obj))

## for record_reader_test

record_reader_test_obj := $(OBJ_DIR)/cyber/record/record_reader_test.o
record_reader_test: cyber
	$(call MAKE_SELF_TEST, $(record_reader_test_obj))

## for record_viewer_test

record_viewer_test_obj := $(OBJ_DIR)/cyber/record/record_viewer_test.o
record_viewer_test: cyber
	$(call MAKE_SELF_TEST, $(record_viewer_test_obj))

## for scheduler_test

scheduler_test_obj := $(OBJ_DIR)/cyber/scheduler/scheduler_test.o
scheduler_test: cyber
	$(call MAKE_SELF_TEST, $(scheduler_test_obj))

## for scheduler_classic_test

scheduler_classic_test_obj := $(OBJ_DIR)/cyber/scheduler/scheduler_classic_test.o
scheduler_classic_test: cyber
	$(call MAKE_SELF_TEST, $(scheduler_classic_test_obj))

## for scheduler_choreo_test

scheduler_choreo_test_obj := $(OBJ_DIR)/cyber/scheduler/scheduler_choreo_test.o
scheduler_choreo_test: cyber
	$(call MAKE_SELF_TEST, $(scheduler_choreo_test_obj))

## for processor_test

processor_test_obj := $(OBJ_DIR)/cyber/scheduler/processor_test.o
processor_test: cyber
	$(call MAKE_SELF_TEST, $(processor_test_obj))

## for pin_thread_test

pin_thread_test_obj := $(OBJ_DIR)/cyber/scheduler/common/pin_thread_test.o
pin_thread_test: cyber
	$(call MAKE_SELF_TEST, $(pin_thread_test_obj))

## for sysmo_test

sysmo_test_obj := $(OBJ_DIR)/cyber/sysmo/sysmo_test.o
sysmo_test: cyber
	$(call MAKE_SELF_TEST, $(sysmo_test_obj))

## for topology_manager_test

topology_manager_test_obj := $(OBJ_DIR)/cyber/service_discovery/topology_manager_test.o
topology_manager_test: cyber
	$(call MAKE_SELF_TEST, $(topology_manager_test_obj))

## for graph_test

graph_test_obj := $(OBJ_DIR)/cyber/service_discovery/container/graph_test.o
graph_test: cyber
	$(call MAKE_SELF_TEST, $(graph_test_obj))

## for multi_value_warehouse_test

multi_value_warehouse_test_obj := $(OBJ_DIR)/cyber/service_discovery/container/multi_value_warehouse_test.o
multi_value_warehouse_test: cyber
	$(call MAKE_SELF_TEST, $(multi_value_warehouse_test_obj))

## for single_value_warehouse_test

single_value_warehouse_test_obj := $(OBJ_DIR)/cyber/service_discovery/container/single_value_warehouse_test.o
single_value_warehouse_test: cyber
	$(call MAKE_SELF_TEST, $(single_value_warehouse_test_obj))

## for role_test

role_test_obj := $(OBJ_DIR)/cyber/service_discovery/role/role_test.o
role_test: cyber
	$(call MAKE_SELF_TEST, $(role_test_obj))

## for channel_manager_test

channel_manager_test_obj := $(OBJ_DIR)/cyber/service_discovery/specific_manager/channel_manager_test.o
channel_manager_test: cyber
	$(call MAKE_SELF_TEST, $(channel_manager_test_obj))

## for node_manager_test

node_manager_test_obj := $(OBJ_DIR)/cyber/service_discovery/specific_manager/node_manager_test.o
node_manager_test: cyber
	$(call MAKE_SELF_TEST, $(node_manager_test_obj))

## for service_manager_test

service_manager_test_obj := $(OBJ_DIR)/cyber/service_discovery/specific_manager/service_manager_test.o
service_manager_test: cyber
	$(call MAKE_SELF_TEST, $(service_manager_test_obj))

## for task_test

task_test_obj := $(OBJ_DIR)/cyber/task/task_test.o
task_test: cyber
	$(call MAKE_SELF_TEST, $(task_test_obj))

## for clock_test

clock_test_obj := $(OBJ_DIR)/cyber/time/clock_test.o
clock_test: cyber
	$(call MAKE_SELF_TEST, $(clock_test_obj))

## for timer_test

timer_test_obj := $(OBJ_DIR)/cyber/timer/timer_test.o
timer_test: cyber
	$(call MAKE_SELF_TEST, $(timer_test_obj))

## for transport_test

transport_test_obj := $(OBJ_DIR)/cyber/transport/transport_test.o
transport_test: cyber
	$(call MAKE_SELF_TEST, $(transport_test_obj))

## for intra_dispatcher_test shm_dispatcher_test rtps_dispatcher_test hybrid_transceiver_test rtps_test message_test message_info_test

intra_dispatcher_test_obj := $(OBJ_DIR)/cyber/transport/dispatcher/intra_dispatcher_test.o
intra_dispatcher_test: cyber
	$(call MAKE_SELF_TEST, $(intra_dispatcher_test_obj))

## for shm_dispatcher_test

shm_dispatcher_test_obj := $(OBJ_DIR)/cyber/transport/dispatcher/shm_dispatcher_test.o
shm_dispatcher_test: cyber
	$(call MAKE_SELF_TEST, $(shm_dispatcher_test_obj))

## for rtps_dispatcher_test

rtps_dispatcher_test_obj := $(OBJ_DIR)/cyber/transport/dispatcher/rtps_dispatcher_test.o
rtps_dispatcher_test: cyber
	$(call MAKE_SELF_TEST, $(rtps_dispatcher_test_obj))

## for hybrid_transceiver_test

hybrid_transceiver_test_obj := $(OBJ_DIR)/cyber/transport/integration_test/hybrid_transceiver_test.o
hybrid_transceiver_test: cyber
	$(call MAKE_SELF_TEST, $(hybrid_transceiver_test_obj))

## for rtps_test

rtps_test_obj := $(OBJ_DIR)/cyber/transport/rtps/rtps_test.o
rtps_test: cyber
	$(call MAKE_SELF_TEST, $(rtps_test_obj))

## for message_test

message_test_obj := $(OBJ_DIR)/cyber/transport/message/message_test.o
message_test: cyber
	$(call MAKE_SELF_TEST, $(message_test_obj))

## for message_info_test

message_info_test_obj := $(OBJ_DIR)/cyber/transport/message/message_info_test.o
message_info_test: cyber
	$(call MAKE_SELF_TEST, $(message_info_test_obj))