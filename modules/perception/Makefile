###############################################################################
## apollo/modules/perception/Makefile
##
## History:
##    2023/02/02 - [Yang Yu] Created file
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

SUBDIRS := base common lib radar

## sub modules
base_dir := base
base_src := $(shell find $(base_dir) -maxdepth 3 -type f -name '*.cc' -not -name '*test.cc')
base_obj := $(base_src:.cc=.o)
#$(info $(hdmap_obj))

####################################################################
## FLAGS
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC) $(EXTERN_LIB_EIGEN_INC) $(EXTERN_LIB_TF2_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC) $(EXTERN_LIB_BOOST_INC) $(EXTERN_LIB_JSON_INC) $(EXTERN_LIB_CIVETWEB_INC) $(EXTERN_LIB_OPENCV_INC)
COMPONENT_INC += $(EXTERN_LIB_PCL_INC)

## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)
COMPONENT_INC += -O0 -g

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_TINYXML_LIB) $(EXTERN_LIB_PROJ_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_CIVETWEB_LIB) $(EXTERN_LIB_TBB_LIB) $(EXTERN_LIB_OPENCV_LIB) $(EXTERN_LIB_JPEG_LIB) $(EXTERN_LIB_PNG_LIB) $(EXTERN_LIB_PCL_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon -lhdmap_lib

SHARED_LIB_NAMES = dreamview_backend

COM_SHARED_LIB_NAMES = 

## for component.so
dreamview_backend_src := $(backend_src)
dreamview_backend_obj := $(backend_obj)

####################################################################
## install needed libs
####################################################################

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_BOOST_DIR)/lib/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_OSQP_DIR)/lib/*.so $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_PROJ_DIR)/lib/*.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_TINYXML_DIR)/lib/*.a $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_PCL_DIR)/lib/*.so* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_CIVETWEB_DIR)/lib/*.so* $(INSTALL_DIR)/usr/lib/


	@$(MKDIR) $(INTERNAL_CONF_DIR)/dreamview
	@cp -dpRf $(TOP_DIR)/modules/dreamview/conf/* $(INTERNAL_CONF_DIR)/dreamview

####################################################################
## for test
####################################################################
all_self_tests: dreamview_main websocket_handler_test hmi_worker_test vehicle_manager_test sim_control_test simulation_world_service_test

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_BOOST_LIB) $(EXTERN_LIB_ABSL_LIB) $(EXTERN_LIB_TINYXML_LIB)
TEST_LDFLAG += $(EXTERN_LIB_TF2_LIB) $(EXTERN_LIB_PROJ_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_SQL_LIB) $(EXTERN_LIB_OSQP_LIB)
TEST_LDFLAG += $(EXTERN_LIB_YAML_LIB) $(EXTERN_LIB_CIVETWEB_LIB) $(EXTERN_LIB_TBB_LIB) $(EXTERN_LIB_OPENCV_LIB) $(EXTERN_LIB_JPEG_LIB) $(EXTERN_LIB_PNG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PCL_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lcommon_msgs -lcyber -lcommon -lhdmap_lib -lpnc_map_lib
TEST_LDFLAG += -latomic

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

#EXECUTABLE_FILES

dreamview_main_obj := $(OBJ_DIR)/modules/dreamview/main.o

dreamview_main: dreamview_backend
	$(call MAKE_SELF_TEST, $(dreamview_main_obj), \
	-L$(INTERNAL_COM_LIB_DIR) -lstatic_transform_component \
	-L$(INTERNAL_LIB_DIR) -ldreamview_backend)






include $(TOP_DIR)/ambabuild/rules.mk
