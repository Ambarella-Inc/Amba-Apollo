export GLOG_alsologtostderr=1
export GLOG_colorlogtostderr=1
export GLOG_minloglevel=0
export sysmo_start=0
#export CYBER_PATH="/tmp/win/apollo/cyber/"
# for DEBUG log
#export GLOG_v=4


####################################################################
## internal tests
####################################################################
./atomic_hash_map_test
./atomic_rw_lock_test
./bounded_queue_test
./for_each_test
./unbounded_queue_test
./blocker_test
./cache_buffer_test
./message_header_test
./raw_message_test
./time_test
./duration_test

####################################################################
## self-tests which links to libcyber.so
####################################################################
./object_pool_test
./blocker_manager_test
./shared_library_test
./class_loader_test
./file_test log_test
./environment_test
./macros_test
./component_test
./timer_component_test
./data_visitor_test
./data_dispatcher_test
./channel_buffer_test
./all_latest_test
./async_logger_test
./log_file_object_test
./logger_util_test
./logger_test
./message_traits_test
./protobuf_factory_test
./node_channel_impl_test
./node_test
./reader_test
#./writer_reader_test
./writer_test
./parameter_test
./parameter_client_test
./parameter_server_test
./record_file_test
./record_file_integration_test
./record_reader_test
./record_viewer_test
./scheduler_test
./scheduler_classic_test
./scheduler_choreo_test
./processor_test pin_thread_test
./topology_manager_test
./graph_test
./multi_value_warehouse_test
./single_value_warehouse_test
./role_test
./channel_manager_test
./node_manager_test
./service_manager_test
./sysmo_test
./task_test
./clock_test
./timer_test
./transport_test
./intra_dispatcher_test
./shm_dispatcher_test
./rtps_dispatcher_test
./hybrid_transceiver_test
./rtps_test
./message_test
./message_info_test

## clean log files
rm -rf *INFO*