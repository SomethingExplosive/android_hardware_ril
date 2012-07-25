# Copyright 2006 The Android Open Source Project

ifneq ($(BOARD_PROVIDES_LIBRIL),true)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    ril.cpp \
    ril_event.cpp

LOCAL_SHARED_LIBRARIES := \
    libutils \
    libbinder \
    libcutils \
    libhardware_legacy

LOCAL_CFLAGS :=
ifdef BOARD_USE_NEW_LIBRIL_HTC
    LOCAL_CFLAGS += -DNEW_LIBRIL_HTC
endif

LOCAL_MODULE:= libril

LOCAL_LDLIBS += -lpthread

ifeq ($(BOARD_USES_LEGACY_RIL),true)
LOCAL_CFLAGS += -DLEGACY_RIL
endif

include $(BUILD_SHARED_LIBRARY)


# For RdoServD which needs a static library
# =========================================
ifneq ($(ANDROID_BIONIC_TRANSITION),)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    ril.cpp

LOCAL_STATIC_LIBRARIES := \
    libutils_static \
    libcutils

LOCAL_CFLAGS :=

LOCAL_MODULE:= libril_static

LOCAL_LDLIBS += -lpthread

include $(BUILD_STATIC_LIBRARY)
endif # ANDROID_BIONIC_TRANSITION
endif # BOARD_PROVIDES_LIBRIL
