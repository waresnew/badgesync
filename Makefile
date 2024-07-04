TARGET := iphone:clang:latest:15.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64e
THEOS_PACKAGE_SCHEME=rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BadgeSync

BadgeSync_FILES = Tweak.xm
BadgeSync_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
