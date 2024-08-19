TARGET := iphone:clang:latest:15.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64e
THEOS_PACKAGE_SCHEME=rootless
THEOS_DEVICE_IP=192.168.1.10

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BadgeSync

BadgeSync_FILES = Tweak.xm
BadgeSync_CFLAGS = -fobjc-arc
BadgeSync_EXTRA_FRAMEWORKS += Cephei AltList

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += BadgeSyncPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk
