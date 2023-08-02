###############################################################################
## prerequisites.mk
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

UNIQUE_NAME_TAG ?= apollo
TMP_STR := $(subst /$(UNIQUE_NAME_TAG), ,$(shell pwd))
#$(info $(TMP_STR))

ifeq ($(words /$(TMP_STR)), 1)
PRJ_PATH ?= $(word 1, /$(TMP_STR))
else
ifeq ($(words /$(TMP_STR)), 2)
PRJ_PATH ?= $(word 1, /$(TMP_STR))
else
$(error there are multiple "apollo" in full path name)
endif
endif

TOP_DIR := $(PRJ_PATH)/$(UNIQUE_NAME_TAG)
OUT_DIR := $(TOP_DIR)/out
AMB_DIR := $(PRJ_PATH)/..
SDK_DIR := $(PRJ_PATH)/../..
AUTO_MW_DIR := $(PRJ_PATH)

SOC_VISION_DIR := $(SDK_DIR)/../cv3_rtos/rtos/cortex_a/soc/vision
#$(info $(SOC_VISION_DIR))

export TOP_DIR
export OUT_DIR
export AMB_DIR
export SDK_DIR
export AUTO_MW_DIR
export SOC_VISION_DIR
