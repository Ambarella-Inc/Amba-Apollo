###############################################################################
## cvapi_lib.mk
##
## History:
##    2023/03/16 - [Yang Yu] Created file
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


##cvapi

LINUX_PATH := $(SDK_DIR)/output/ambalinux

# all the header you need if you want to build target with ambacv
# for ambacv, all the header you need can be found under sdk9/output/cv3/host/aarch64-buildroot-linux-gnu/sysroot/usr/include
CV_API_INC := -I$(LINUX_PATH)/host/aarch64-buildroot-linux-gnu/sysroot/usr/include  \
              -I$(LINUX_PATH)/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/ambacv  \
              -I$(LINUX_PATH)/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/ambacv/cvapi


# all the libraries you need for ambacv,
# the libraries can be found under sdk9/output/cv3/build/ambacv-1.0/build/bin/lib
CV_API_LIB := -L$(LINUX_PATH)/build/ambacv-1.0/build/bin/lib/cvlib/AmbaCV_Flexidag -lAmbaCV_Flexidag \
              -L$(LINUX_PATH)/build/ambacv-1.0/build/bin/lib -lambadag \
              -L$(LINUX_PATH)/build/ambamal-1.0 -lambamal \
              -L$(LINUX_PATH)/build/amba_examples-1.0/AmbaFlexidagIO -lambaflexidagio

CV_COMMON_INC := -I$(LINUX_PATH)/build/ambacv-1.0/cv_common/inc/

OPENCV4_INC := -I$(LINUX_PATH)/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/opencv4

OPENCV4_LIB := -L$(LINUX_PATH)/build/libpng-1.6.37/.libs -lpng16 \
               -L$(LINUX_PATH)/build/jpeg-turbo-2.1.2 -ljpeg \
               -L$(LINUX_PATH)/build/opencv4-4.5.5/buildroot-build/lib -lopencv_core -lopencv_imgcodecs -lopencv_imgproc \

# no use now
#a linker script generator, you can find it in pkg/ambacv/cv_common/build
LDS_GEN   = $(TOP_DIR)/ambabuild/lds_gen.sh
APP_LSR   = $(TOP_DIR)/ambabuild/linker.lds

#.PHONY: $(LOCAL_TARGET)

$(LOCAL_TARGET): $(LOCAL_MODULE)
#generate linker script with lds_gen.sh
	@./$(LDS_GEN) $(LD) $(APP_LSR)
#gcc make target
	$(CC) $(LOCAL_SRCS)  $(LOCAL_CFLAGS) -o $(LOCAL_TARGET)  $(LOCAL_LDFLAGS)  $(LFLAGS) -T $(APP_LSR)
	@echo "Build $@ Done."
clean:
	@rm -rf $(LOCAL_TARGET)