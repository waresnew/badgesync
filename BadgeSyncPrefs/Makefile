TARGET := iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BadgeSyncPrefs

BadgeSyncPrefs_FILES = BGSRootListController.m
BadgeSyncPrefs_FRAMEWORKS = UIKit
BadgeSyncPrefs_PRIVATE_FRAMEWORKS = Preferences
BadgeSyncPrefs_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
BadgeSyncPrefs_INSTALL_PATH = /Library/PreferenceBundles
BadgeSyncPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
