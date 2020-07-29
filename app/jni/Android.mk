LOCAL_PATH := $(call my-dir)

###########################
#
# SDL shared library
#
###########################

include $(CLEAR_VARS)

LOCAL_MODULE := SDL2

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)

LOCAL_SRC_FILES := \
	$(subst $(LOCAL_PATH)/,, \
	$(wildcard $(LOCAL_PATH)/src/*.c) \
	$(wildcard $(LOCAL_PATH)/src/audio/*.c) \
	$(wildcard $(LOCAL_PATH)/src/audio/android/*.c) \
	$(wildcard $(LOCAL_PATH)/src/audio/dummy/*.c) \
	$(wildcard $(LOCAL_PATH)/src/audio/openslES/*.c) \
	$(LOCAL_PATH)/src/atomic/SDL_atomic.c.arm \
	$(LOCAL_PATH)/src/atomic/SDL_spinlock.c.arm \
	$(wildcard $(LOCAL_PATH)/src/core/android/*.c) \
	$(wildcard $(LOCAL_PATH)/src/cpuinfo/*.c) \
	$(wildcard $(LOCAL_PATH)/src/dynapi/*.c) \
	$(wildcard $(LOCAL_PATH)/src/events/*.c) \
	$(wildcard $(LOCAL_PATH)/src/file/*.c) \
	$(wildcard $(LOCAL_PATH)/src/haptic/*.c) \
	$(wildcard $(LOCAL_PATH)/src/haptic/android/*.c) \
	$(wildcard $(LOCAL_PATH)/src/joystick/*.c) \
	$(wildcard $(LOCAL_PATH)/src/joystick/android/*.c) \
	$(wildcard $(LOCAL_PATH)/src/joystick/hidapi/*.c) \
	$(wildcard $(LOCAL_PATH)/src/loadso/dlopen/*.c) \
	$(wildcard $(LOCAL_PATH)/src/power/*.c) \
	$(wildcard $(LOCAL_PATH)/src/power/android/*.c) \
	$(wildcard $(LOCAL_PATH)/src/filesystem/android/*.c) \
	$(wildcard $(LOCAL_PATH)/src/sensor/*.c) \
	$(wildcard $(LOCAL_PATH)/src/sensor/android/*.c) \
	$(wildcard $(LOCAL_PATH)/src/render/*.c) \
	$(wildcard $(LOCAL_PATH)/src/render/*/*.c) \
	$(wildcard $(LOCAL_PATH)/src/stdlib/*.c) \
	$(wildcard $(LOCAL_PATH)/src/thread/*.c) \
	$(wildcard $(LOCAL_PATH)/src/thread/pthread/*.c) \
	$(wildcard $(LOCAL_PATH)/src/timer/*.c) \
	$(wildcard $(LOCAL_PATH)/src/timer/unix/*.c) \
	$(wildcard $(LOCAL_PATH)/src/video/*.c) \
	$(wildcard $(LOCAL_PATH)/src/video/android/*.c) \
	$(wildcard $(LOCAL_PATH)/src/video/yuv2rgb/*.c) \
	$(wildcard $(LOCAL_PATH)/src/test/*.c))

LOCAL_SHARED_LIBRARIES := hidapi

LOCAL_CFLAGS += -DGL_GLEXT_PROTOTYPES
LOCAL_CFLAGS += \
	-Wall -Wextra \
	-Wdocumentation \
	-Wdocumentation-unknown-command \
	-Wmissing-prototypes \
	-Wunreachable-code-break \
	-Wunneeded-internal-declaration \
	-Wmissing-variable-declarations \
	-Wfloat-conversion \
	-Wshorten-64-to-32 \
	-Wunreachable-code-return \
	-Wshift-sign-overflow \
	-Wstrict-prototypes \
	-Wkeyword-macro \


# Warnings we haven't fixed (yet)
LOCAL_CFLAGS += -Wno-unused-parameter -Wno-sign-compare
 

LOCAL_LDLIBS := -ldl -lGLESv1_CM -lGLESv2 -lOpenSLES -llog -landroid

ifeq ($(NDK_DEBUG),1)
    cmd-strip :=
endif

LOCAL_STATIC_LIBRARIES := cpufeatures

include $(BUILD_SHARED_LIBRARY)

###########################
#
# SDL static library
#
###########################

LOCAL_MODULE := SDL2_static

LOCAL_MODULE_FILENAME := libSDL2

LOCAL_LDLIBS := 
LOCAL_EXPORT_LDLIBS := -ldl -lGLESv1_CM -lGLESv2 -llog -landroid

include $(BUILD_STATIC_LIBRARY)

###########################
#
# SDL main static library
#
###########################

include $(CLEAR_VARS)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

LOCAL_MODULE := SDL2_main

LOCAL_MODULE_FILENAME := libSDL2main

include $(BUILD_STATIC_LIBRARY)

###########################
#
# hidapi library
#
###########################

include $(CLEAR_VARS)

LOCAL_CPPFLAGS += -std=c++11

LOCAL_SRC_FILES := src/hidapi/android/hid.cpp

LOCAL_MODULE := libhidapi
LOCAL_LDLIBS := -llog

include $(BUILD_SHARED_LIBRARY)




#### ffmpeg ####

include $(CLEAR_VARS)
LOCAL_MODULE    := libavcodec
LOCAL_SRC_FILES := $(LOCAL_PATH)/libavcodec.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := libavfilter
LOCAL_SRC_FILES := $(LOCAL_PATH)/libavfilter.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := libavformat
LOCAL_SRC_FILES := $(LOCAL_PATH)/libavformat.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := libavutil
LOCAL_SRC_FILES := $(LOCAL_PATH)/libavutil.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := libswresample
LOCAL_SRC_FILES := $(LOCAL_PATH)/libswresample.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := libswscale
LOCAL_SRC_FILES := $(LOCAL_PATH)/libswscale.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := libavdevice
LOCAL_SRC_FILES := $(LOCAL_PATH)/libavdevice.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := libpostproc
LOCAL_SRC_FILES := $(LOCAL_PATH)/libpostproc.a
include $(PREBUILT_STATIC_LIBRARY)




###libSDL2main###

include $(CLEAR_VARS)

LOCAL_MODULE := SDL2main

SDL_PATH := ./

LOCAL_C_INCLUDES := $(LOCAL_PATH)/$(SDL_PATH)/include

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH) \

# Add your application source files here...
LOCAL_SRC_FILES := $(SDL_PATH)/src/main/android/SDL_android_main.c \
	$(SDL_PATH)/simplest_showbmp.c


LOCAL_SHARED_LIBRARIES := SDL2

LOCAL_LDLIBS := -lGLESv1_CM -lGLESv2 -llog -lz

#顺序很重要
LOCAL_STATIC_LIBRARIES := libavformat libavfilter libavcodec libavutil libswresample libavdevice  libpostproc libswscale


LOCAL_LDFLAGS += -Wl,--gc-sections

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/cpufeatures)

