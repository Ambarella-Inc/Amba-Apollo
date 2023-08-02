###############################################################################
## apollo/cyber/python/internal/Makefile
##
## History:
##    2023/06/20 - [Yu Yang] Created file
##
## Copyright (C) 2023 Ambarella International LP
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

include ../../../ambabuild/prerequisites.mk

include $(TOP_DIR)/ambabuild/config.mk
include $(TOP_DIR)/ambabuild/extern_lib.mk

COMPONENT_SRC := $(shell find . -maxdepth 1 -type f -name '*.cc')
COMPONENT_OBJ := $(COMPONENT_SRC:.cc=.o)

####################################################################
## FLAGS
####################################################################
COMPONENT_INC := $(EXTERN_LIB_GLOG_INC) $(EXTERN_LIB_GFLAGS_INC) $(EXTERN_LIB_PROTOBUF_INC)
COMPONENT_INC += $(EXTERN_LIB_FASTCDR_INC) $(EXTERN_LIB_FASTRTPS_INC) $(EXTERN_LIB_PYTHON_INC)
## for test
COMPONENT_INC += $(EXTERN_LIB_GTEST_INC)

COMPONENT_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
COMPONENT_LDFLAG += $(EXTERN_LIB_PYTHON_LIB)
COMPONENT_LDFLAG += -latomic
ifeq ($(ENABLE_LYCHEE), y)
COMPONENT_LDFLAG += -ltinyxml2 -lpython3.11 -lpython3
endif
COMPONENT_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber

## for component.so
SHARED_LIB_NAMES = _cyber_wrapper \
                   _cyber_record_wrapper \
                   _cyber_time_wrapper \
                   _cyber_timer_wrapper \
                   _cyber_parameter_wrapper

_cyber_wrapper_src := py_cyber.cc
_cyber_wrapper_obj := py_cyber.o

_cyber_record_wrapper_src := py_record.cc
_cyber_record_wrapper_obj := py_record.o

_cyber_time_wrapper_src := py_time.cc
_cyber_time_wrapper_obj := py_time.o
_cyber_timer_wrapper_src := py_timer.cc
_cyber_timer_wrapper_obj := py_timer.o

_cyber_parameter_wrapper_src := py_parameter.cc
_cyber_parameter_wrapper_obj := py_parameter.o

####################################################################
## for test
####################################################################

all_self_tests:py_cyber_test py_record_test

## for py_cyber_test
py_cyber_test_obj := $(OBJ_DIR)/cyber/python/internal/py_cyber_test.o
py_cyber_test: _cyber_wrapper
	$(call MAKE_SELF_TEST, $(py_cyber_test_obj), \
	-L$(INTERNAL_LIB_DIR) -l_cyber_wrapper)

## for py_record_test
py_record_test_obj := $(OBJ_DIR)/cyber/python/internal/py_record_test.o
py_record_test: _cyber_wrapper
	$(call MAKE_SELF_TEST, $(py_record_test_obj), \
	-L$(INTERNAL_LIB_DIR) -l_cyber_record_wrapper)

TEST_LDFLAG := $(EXTERN_LIB_FASTCDR_LIB) $(EXTERN_LIB_FASTRTPS_LIB) $(EXTERN_LIB_OPENSSL_LIB)
TEST_LDFLAG += $(EXTERN_LIB_PROTOBUF_LIB) $(EXTERN_LIB_GFLAGS_LIB) $(EXTERN_LIB_GLOG_LIB)
TEST_LDFLAG += $(EXTERN_LIB_GTEST_LIB) $(EXTERN_LIB_UTILS_LINUX_LIBS_LIB)
TEST_LDFLAG += $(EXTERN_LIB_ZLIB_LIB) $(EXTERN_LIB_PYTHON_LIB)
TEST_LDFLAG += -L$(INTERNAL_LIB_DIR) -lproto -lcyber
TEST_LDFLAG += -latomic -lm
ifeq ($(ENABLE_LYCHEE), y)
COMPONENT_LDFLAG += -ltinyxml2 -lpython3.11 -lpython3
endif

define MAKE_SELF_TEST
	@echo "  compiling self test: $@ ..."
	@$(MKDIR) $(INTERNAL_BIN_DIR)/cyber
	@$(CXX) $(CPPFLAGS) -o $(INTERNAL_BIN_DIR)/cyber/$@ \
		$(1) \
		$(TEST_LDFLAG) $(2)
endef

include $(TOP_DIR)/ambabuild/rules.mk

