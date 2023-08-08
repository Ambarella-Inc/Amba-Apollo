###############################################################################
## apollo/modules/guardian/Makefile
##
## History:
##    2022/12/02 - [Yang Yu] Created file
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

## source files and object files
src := guardian_component.cc
obj := $(src:%.cc=%.o)

COMPONENT_SRC := $(src)
COMPONENT_OBJ := $(obj)

####################################################################
## FLAGS 
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC)
COMPONENT_INC += $(EXTERN_LIB_ABSL_INC)
## for test
COMPONENT_INC += -O0 -g
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_OPENSSL_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_ABSL_LIB)
COMPONENT_LDFLAG += -latomic
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber -lcommon


## for component.so
COM_SHARED_LIB_NAMES = guardian_component

guardian_component_src := $(src)
guardian_component_obj := $(obj)

####################################################################
## install
####################################################################
install:
	$(INSTALL) -m 0644 -D $(INTERNAL_COM_LIB_DIR)/* -t $(INSTALL_COM_LIB_DIR)
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/guardian/conf/* -t $(INSTALL_DIR)/modules/guardian/conf
	$(INSTALL) -m 0644 -D $(TOP_DIR)/modules/guardian/dag/* -t $(INSTALL_DIR)/modules/guardian/dag

install_dep_libs:
	@$(MKDIR) $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(INTERNAL_LIB_DIR)/* $(INSTALL_DIR)/usr/lib/
	@cp -dpRf $(EXTERN_LIB_ABSL_DIR)/lib/libabsl.a $(INSTALL_DIR)/usr/lib/

	@$(MKDIR) $(INTERNAL_CONF_DIR)/guardian
	@cp -dpRf $(TOP_DIR)/modules/guardian/conf/* $(INTERNAL_CONF_DIR)/guardian

	@$(MKDIR) $(INTERNAL_DAG_DIR)/guardian
	@cp -dpRf $(TOP_DIR)/modules/guardian/dag/*.dag $(INTERNAL_DAG_DIR)/guardian


include $(TOP_DIR)/ambabuild/rules.mk