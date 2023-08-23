###############################################################################
## config.mk
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

MAKE_PRINT		=	@

##choose chip platform
CVCHIP := CHIP_CV6

##build in lychee
ENABLE_LYCHEE := y

##Cross compile
ifeq ($(ENABLE_LYCHEE), y)
ENABLE_CROSS_COMPILE := n
else
ENABLE_CROSS_COMPILE := y
endif
CROSS_COMPILE_TARGET_ARCH := AARCH64
CROSS_COMPILE_HOST_ARCH := X86_64

ifeq ($(ENABLE_CROSS_COMPILE), y)
ifeq ($(CROSS_COMPILE_TARGET_ARCH), AARCH64)

ifneq ($(strip $(AARCH64_CROSS_COMPILE)),)
CROSS_COMPILE := $(AARCH64_CROSS_COMPILE)
else
CROSS_COMPILE := "aarch64-linux-gnu-"
endif

ifneq ($(strip $(AARCH64_TOOLCHAIN_PATH)),)
TOOLCHAIN_PATH := $(AARCH64_TOOLCHAIN_PATH)
else
##TOOLCHAIN_PATH := /usr/local/cortex-a76-2022.04-gcc11.2-linux5.15/bin
TOOLCHAIN_PATH := /usr/local/cortex-a76-2022.08-gcc12.1-linux5.15/bin
endif

TARGRT_CPU_ARCH_NAME := armv8-a
TARGRT_CPU_ARCH_VER_NAME := armv8.2

endif
endif


##debug
BUILD_CONFIG_DEBUG := n

##CPU arch and option
BUILD_CONFIG_CPU_ARCH_X86 := n
BUILD_CONFIG_CPU_ARCH_X64 := n
BUILD_CONFIG_CPU_OPT_SSE := n
BUILD_CONFIG_CPU_OPT_AVX := n
BUILD_CONFIG_CPU_OPT_AVX2 := n
BUILD_CONFIG_CPU_ARCH_ARMV7 := n
BUILD_CONFIG_CPU_ARCH_ARMV8 := y
BUILD_CONFIG_CPU_OPT_NEON := y

##OS typs
BUILD_CONGIG_OS_LINUX := y
BUILD_CONGIG_OS_QNX := n
BUILD_CONGIG_OS_THREADX := n
BUILD_CONGIG_OS_AMRTOS := n
BUILD_CONGIG_OS_WINDOWS := n
BUILD_CONGIG_OS_ANDROID := n
BUILD_CONGIG_OS_IOS := n

##OS abstraction layer
BUILD_CONFIG_OSAL_PTHREAD := y
BUILD_CONFIG_OSAL_STDIO := y
BUILD_CONFIG_OSAL_STDLIB := y

##DSP related
BUILD_CONGIG_DSP_AMBA_S5L := n
BUILD_CONGIG_DSP_AMBA_S6Lm := n
BUILD_CONGIG_DSP_AMBA_CV2x := n
BUILD_CONGIG_DSP_AMBA_CV5x := y
BUILD_CONGIG_DSP_AMBA_CV3x := n

##CV framework
BUILD_CONGIG_CV_FLEXDAG := y
BUILD_CONGIG_CV_CAVALRY := n

##SW depenancy related
BUILD_CONFIG_SWDEP_CYCLONE_DDS := y
BUILD_CONFIG_SWDEP_FAST_DDS := n

##cyber enhancement
BUILD_CONFIG_CYBER_NEW_SCHEDULER := n
BUILD_CONFIG_CYBER_NEW_TIME_CLOCK := n
BUILD_CONFIG_CYBER_NEW_LOG := n
BUILD_CONFIG_CYBER_NEW_DATA_COMPRESSION := n

##apollo modules
BUILD_CONFIG_MODULE_CONTROL := y
BUILD_CONFIG_MODULE_DREAMVIEWER := y
BUILD_CONFIG_MODULE_DRIVERS := y
BUILD_CONFIG_MODULE_GUARDIAN := y
BUILD_CONFIG_MODULE_LOCALIZATION := y
BUILD_CONFIG_MODULE_MAP := y
BUILD_CONFIG_MODULE_MONITOR := y
BUILD_CONFIG_MODULE_PLANNING := y
BUILD_CONFIG_MODULE_PERCEPTION := y
BUILD_CONFIG_MODULE_ROUTING := y
BUILD_CONFIG_MODULE_STORYTELLING := y
BUILD_CONFIG_MODULE_TASK_MANAGER := y
BUILD_CONFIG_MODULE_TRANSFORM := y
BUILD_CONFIG_MODULE_V2X := n

OBJ_DIR = $(OUT_DIR)/$(CROSS_COMPILE_TARGET_ARCH)/objs
INTERNAL_BIN_DIR = $(OUT_DIR)/$(CROSS_COMPILE_TARGET_ARCH)/binary
INTERNAL_LIB_DIR = $(OUT_DIR)/$(CROSS_COMPILE_TARGET_ARCH)/lib
INTERNAL_TAR_DIR = $(OUT_DIR)/$(CROSS_COMPILE_TARGET_ARCH)/tar
INTERNAL_INC_DIR = $(OUT_DIR)/$(CROSS_COMPILE_TARGET_ARCH)/include
## apollo compoment shared lib
INTERNAL_COM_LIB_DIR = $(OUT_DIR)/$(CROSS_COMPILE_TARGET_ARCH)/component

## install dir
INSTALL_DIR = $(OUT_DIR)/$(CROSS_COMPILE_TARGET_ARCH)/install/apollo
## bin
INSTALL_BIN_DIR = $(INSTALL_DIR)/bin
## includes
INSTALL_INC_DIR = $(INSTALL_DIR)/include
## libs
INSTALL_LIB_DIR = $(INSTALL_DIR)/lib
## components
INSTALL_COM_LIB_DIR = $(INSTALL_DIR)/component
##scripts
INSTALL_SCRIPTS_DIR = $(INSTALL_DIR)/scripts


COMPILE_FLAGS = -I$(TOP_DIR)
LINK_FLAGS = -ldl -lm -lpthread -lrt

ifeq ($(BUILD_CONFIG_DEBUG), y)
COMPILE_FLAGS += -g -O0
else
COMPILE_FLAGS += -O3
endif

ifeq ($(BUILD_CONGIG_OS_LINUX), y)
COMPILE_FLAGS += -DBUILD_OS_LINUX
endif

ifeq ($(BUILD_CONGIG_OS_QNX), y)
COMPILE_FLAGS += -DBUILD_OS_QNX
endif

ifeq ($(BUILD_CONGIG_OS_THREADX), y)
COMPILE_FLAGS += -DBUILD_OS_THREADX
endif

ifeq ($(BUILD_CONGIG_OS_AMRTOS), y)
COMPILE_FLAGS += -DBUILD_OS_AMRTOS
endif

ifeq ($(BUILD_CONGIG_OS_WINDOWS), y)
COMPILE_FLAGS += -DBUILD_OS_WINDOWS
endif

ifeq ($(BUILD_CONGIG_OS_ANDROID), y)
COMPILE_FLAGS += -DBUILD_OS_ANDROID
endif

ifeq ($(BUILD_CONGIG_OS_IOS), y)
COMPILE_FLAGS += -DBUILD_OS_IOS
endif

##for CV3 platform
COMPILE_FLAGS += -D$(CVCHIP)

######################################################################
# toolchain config
######################################################################
ifeq ($(ENABLE_CROSS_COMPILE), y)
CC     = $(TOOLCHAIN_PATH)/$(CROSS_COMPILE)gcc
CXX    = $(TOOLCHAIN_PATH)/$(CROSS_COMPILE)g++
GCC    = $(TOOLCHAIN_PATH)/$(CROSS_COMPILE)gcc
LD     = $(TOOLCHAIN_PATH)/$(CROSS_COMPILE)ld
AS     = $(TOOLCHAIN_PATH)/$(CROSS_COMPILE)as
AR     = $(TOOLCHAIN_PATH)/$(CROSS_COMPILE)ar
STRIP  = $(TOOLCHAIN_PATH)/$(CROSS_COMPILE)strip
RANLIB = $(TOOLCHAIN_PATH)/$(CROSS_COMPILE)ranlib
else
CC     = gcc
CXX    = g++
GCC    = gcc
LD     = ld
AS     = as
AR     = ar
STRIP  = strip
RANLIB = ranlib
endif

export COMPILE_FLAGS
export LINK_FLAGS

