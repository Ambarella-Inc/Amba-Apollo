###############################################################################
## rules.mk
##
## History:
##    2022/08/01 - [Zhi He] Created file
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


######################################################################
# Component defined variables
######################################################################
# for modules of apollo 
SUBMODULES       ?=
# If Component has sub directories
SUBDIRS          ?=
# unit test dir
UNIT_TEST_DIR    ?=
# If component generates shared libraries
SHARED_LIB_NAMES ?=
# If component generates shared libraries for test only
COM_SHARED_LIB_NAMES ?=
# If component generates static libraries
STATIC_LIB_NAMES ?=
# If component generates executables
EXECUTABLE_FILES ?=
# Component's source files
COMPONENT_SRC    ?=
# Component's object files
COMPONENT_OBJ    ?=
# Component's specific includes
COMPONENT_INC    ?=
# Component's specific defines
COMPONENT_DEF    ?=
# Component's specific ld flags
COMPONENT_LDFLAG ?=
# CyberRT's specific ld flags
CYBER_LDFLAG ?=
# AMBACV lib specific ld flags
AMBACV_LDFLAG ?=


MKDIR = mkdir -p
RM = rm -rf
CP = cp -a
MV = mv
LN = ln

INSTALL = install

C_OPT_FLAGS := -fPIC -fasynchronous-unwind-tables -fdiagnostics-color=auto \
    -march=armv8-a+crypto -mlittle-endian -mcpu=cortex-a76+crypto -march=armv8.2-a+crypto+fp16+rcpc+dotprod \
    -mtune=cortex-a76 -fstack-protector-strong -fstack-clash-protection #-fsanitize=thread -fPIE

CXX_ADDITIONAL_FLAGS := -fstrict-aliasing -Wstrict-aliasing -Wno-deprecated-declarations -fopenmp

CFLAGS   = $(C_OPT_FLAGS) $(COMPILE_FLAGS) $(COMPONENT_INC) $(COMPONENT_DEF)
CPPFLAGS = $(C_OPT_FLAGS) $(COMPILE_FLAGS) $(COMPONENT_INC) $(COMPONENT_DEF) $(CXX_ADDITIONAL_FLAGS)
LDFLAGS  = $(LINK_FLAGS) $(COMPONENT_LDFLAG) #-ltsan

TMPDIR := $(OBJ_DIR)/$(word 2, $(subst /$(UNIQUE_NAME_TAG)/, ,$(shell pwd)))

#for auto make
SUBMODULES_ALL = $(addprefix all_, $(SUBMODULES))
SUBDIRS_ALL   = $(addprefix all_, $(SUBDIRS))
OBJECTS_ALL   = $(addprefix $(TMPDIR)/, $(COMPONENT_OBJ))
UNIT_TEST_ALL   = $(addprefix all_, $(UNIT_TEST_DIR))

#for auto clean
SUBMODULES_CLEAN = $(addprefix clean_, $(SUBMODULES))
SUBDIRS_CLEAN = $(addprefix clean_, $(SUBDIRS))
UNIT_TEST_CLEAN   = $(addprefix clean_, $(UNIT_TEST_DIR))

#for auto install
SUBMODULES_INSTALL = $(addprefix install_, $(SUBMODULES))

.PHONY: $(SUBMODULES_ALL) $(SUBDIRS_ALL) $(UNIT_TEST_ALL) all cyber
.PHONY: $(SHARED_LIB_NAMES) $(STATIC_LIB_NAMES) $(EXECUTABLE_FILES)
.PHONY: $(SUBMODULES_CLEAN) $(SUBDIRS_CLEAN) $(UNIT_TEST_CLEAN) clean

.PHONY: $(addprefix clean_, $(SHARED_LIB_NAMES)) \
	$(addprefix clean_, $(STATIC_LIB_NAMES)) \
	$(addprefix clean_, $(EXECUTABLE_FILES))

######################################################################
# all
######################################################################
all: tmpdir $(SUBMODULES_ALL) $(SUBDIRS_ALL) $(UNIT_TEST_ALL) $(OBJECTS_ALL) $(STATIC_LIB_NAMES) \
	 $(SHARED_LIB_NAMES) $(COM_SHARED_LIB_NAMES) $(AMBA_COM_SHARED_LIB_NAMES) $(EXECUTABLE_FILES)

tmpdir:
	@$(MKDIR) $(TMPDIR)

ifneq ($(strip $(SUBMODULES_ALL)),)
$(SUBMODULES_ALL):
	@echo "    [Build modules/$(subst all_,,$@)]:"
	@$(MAKE) -C modules/$(subst all_,,$@) default --no-print-directory
	@$(MAKE) -C modules/$(subst all_,,$@) all_self_tests --no-print-directory
endif

ifneq ($(strip $(SUBDIRS_ALL)),)
$(SUBDIRS_ALL):
	@echo "    [Build $(subst all_,,$@)]:"
	@$(MAKE) -C $(subst all_,,$@) default --no-print-directory
endif

ifneq ($(strip $(UNIT_TEST_ALL)),)
$(UNIT_TEST_ALL): $(SUBDIRS_ALL)
	@echo "    [Build $(subst all_,,$@)]:"
	@$(MAKE) -C $(subst all_,,$@) default --no-print-directory
endif

ifneq ($(strip $(SHARED_LIB_NAMES)),)
$(SHARED_LIB_NAMES): \
	$(foreach n, $(addsuffix _obj, $(SHARED_LIB_NAMES)), \
		$(addprefix $(TMPDIR)/, $($n)))
	@$(MKDIR) $(INTERNAL_LIB_DIR)/
	@$(CXX) -o $(INTERNAL_LIB_DIR)/lib$@.so \
		$(addprefix $(TMPDIR)/, $($@_obj)) \
		-shared -Wl,-soname,lib$@.so $(LDFLAGS)
#ifneq ($(BUILD_CONFIG_DEBUG), y)
#	@$(STRIP) --strip-unneeded \
#		$(INTERNAL_LIB_DIR)/lib$@.so
#endif
endif

ifneq ($(strip $(COM_SHARED_LIB_NAMES)),)
$(COM_SHARED_LIB_NAMES): \
	$(foreach n, $(addsuffix _obj, $(COM_SHARED_LIB_NAMES)), \
		$(addprefix $(TMPDIR)/, $($n)))
	@$(MKDIR) $(INTERNAL_COM_LIB_DIR)/
	@$(CXX) -o $(INTERNAL_COM_LIB_DIR)/lib$@.so \
		$(addprefix $(TMPDIR)/, $($@_obj)) \
		-shared -Wl,-soname,lib$@.so $(LDFLAGS)
#ifneq ($(BUILD_CONFIG_DEBUG), y)
#	@$(STRIP) --strip-unneeded \
#		$(INTERNAL_COM_LIB_DIR)/lib$@.so
#endif
endif

ifneq ($(strip $(AMBA_COM_SHARED_LIB_NAMES)),)
$(AMBA_COM_SHARED_LIB_NAMES): \
	$(foreach n, $(addsuffix _obj, $(AMBA_COM_SHARED_LIB_NAMES)), \
		$(addprefix $(TMPDIR)/, $($n)))
	@$(MKDIR) $(INTERNAL_COM_LIB_DIR)/
	@$(CXX) -o $(INTERNAL_COM_LIB_DIR)/lib$@.so \
		$(addprefix $(TMPDIR)/, $($@_obj)) \
		-shared -Wl,-soname,lib$@.so $(LDFLAGS) $(AMBACV_LDFLAG)
#ifneq ($(BUILD_CONFIG_DEBUG), y)
#	@$(STRIP) --strip-unneeded \
#		$(INTERNAL_COM_LIB_DIR)/lib$@.so
#endif
endif

ifneq ($(strip $(STATIC_LIB_NAMES)),)
$(STATIC_LIB_NAMES): \
	$(foreach n, $(addsuffix _obj, $(STATIC_LIB_NAMES)), \
		$(addprefix $(TMPDIR)/, $($n)))
	@$(MKDIR) $(INTERNAL_LIB_DIR)/
	@$(AR) rcus $(INTERNAL_LIB_DIR)/lib$@.a \
		$(addprefix $(TMPDIR)/, $($@_obj))
ifneq ($(BUILD_CONFIG_DEBUG), y)
	@$(STRIP) --strip-unneeded \
		$(INTERNAL_LIB_DIR)/lib$@.a
endif
endif

ifneq ($(strip $(STATIC_TAR_NAMES)),)
$(STATIC_TAR_NAMES): \
	$(foreach n, $(addsuffix _obj, $(STATIC_TAR_NAMES)), \
		$(addprefix $(TMPDIR)/, $($n)))
	@$(MKDIR) $(INTERNAL_TAR_DIR)/
	@$(AR) rcu $(INTERNAL_TAR_DIR)/lib$@.a \
		$(addprefix $(TMPDIR)/, $($@_obj))
endif

ifneq ($(strip $(EXECUTABLE_FILES)),)
$(EXECUTABLE_FILES): \
	$(foreach n, $(addsuffix _obj, $(EXECUTABLE_FILES)), \
		$(addprefix $(TMPDIR)/, $($n)))
	@$(MKDIR) $(INTERNAL_BIN_DIR)
	@$(CXX) -o $(INTERNAL_BIN_DIR)/$@ \
		$(addprefix $(TMPDIR)/, $($@_obj)) \
		$(LDFLAGS) $($@_ldflag)
ifneq ($(BUILD_CONFIG_DEBUG), y)
	@$(STRIP) --strip-unneeded $(INTERNAL_BIN_DIR)/$@
endif
endif

######################################################################
# clean
######################################################################
clean: $(SUBMODULES_CLEAN) $(SUBDIRS_CLEAN) $(UNIT_TEST_CLEAN) clean_all \
	$(addprefix clean_, $(SHARED_LIB_NAMES)) \
	$(addprefix clean_, $(STATIC_LIB_NAMES)) \
	$(addprefix clean_, $(EXECUTABLE_FILES))

ifneq ($(strip $(SUBMODULES_CLEAN)),)
$(SUBMODULES_CLEAN):
	@echo "    [Clean modules/$(subst clean_,,$@)]:"
	@$(MAKE) -C modules/$(subst clean_,,$@) clean --no-print-directory
endif

$(SUBDIRS_CLEAN):
	@echo "    [Clean $(subst clean_,,$@)]:"
	@$(MAKE) -C $(subst clean_,,$@) clean --no-print-directory

$(UNIT_TEST_CLEAN):
	@echo "    [Clean $(subst clean_,,$@)]:"
	@$(MAKE) -C $(subst clean_,,$@) clean --no-print-directory

ifneq ($(strip $(SHARED_LIB_NAMES)),)
$(addprefix clean_, $(SHARED_LIB_NAMES)):
	-@$(RM) $(INTERNAL_LIB_DIR)/lib$(word 2, $(subst _, ,$@)).so*
endif

ifneq ($(strip $(STATIC_LIB_NAMES)),)
$(addprefix clean_, $(STATIC_LIB_NAMES)):
	-@$(RM) $(INTERNAL_LIB_DIR)/lib$(word 2, $(subst _, ,$@)).a
endif

ifneq ($(strip $(EXECUTABLE_FILES)),)
$(addprefix clean_, $(EXECUTABLE_FILES)):
	-@$(RM) $(INTERNAL_BIN_DIR)/$(word 2, $(subst _, ,$@))
endif

clean_all:
	-@$(RM) $(TMPDIR)/*.o *.o $(TMPDIR)/*.d .*.d

######################################################################
# install
######################################################################
install: $(SUBMODULES_INSTALL)

ifneq ($(strip $(SUBMODULES_INSTALL)),)
$(SUBMODULES_INSTALL):
	@echo "    [Install modules/$(subst install_,,$@)]:"
	@$(MAKE) -C modules/$(subst install_,,$@) install --no-print-directory
endif

######################################################################
# compile
######################################################################
$(TMPDIR)/%.o: $(shell pwd)/%.cc
	@echo "      compiling $(shell basename $<)..."
	@$(MKDIR) $(dir $@)
	@$(CXX) $(CPPFLAGS) -c -MMD -o $@ $<

$(TMPDIR)/%.o: $(shell pwd)/%.c
	@echo "      compiling $(shell basename $<)..."
	@$(GCC) $(CFLAGS) -c -MMD -o $@ $<

$(TMPDIR)/%.o: $(shell pwd)/%.S
	@echo "      compiling $(shell basename $<)..."
	@$(GCC) $(CFLAGS) -c -MMD -o $@ $<

-include $(addprefix $(TMPDIR)/, $(COMPONENT_OBJ:.o=.d))
