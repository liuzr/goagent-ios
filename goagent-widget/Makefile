export THEOS_DEVICE_IP=192.168.3.103

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk

BUNDLE_NAME = goagentwidget
goagentwidget_FILES = goagentwidgetController.m
goagentwidget_INSTALL_PATH = /Library/WeeLoader/Plugins
goagentwidget_FRAMEWORKS = UIKit CoreGraphics

custom-install: all
	cp -Rf _/Library ../deb-pkg-root/

after-install::
	install.exec "killall -9 SpringBoard"
