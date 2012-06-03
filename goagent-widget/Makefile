export THEOS_DEVICE_IP=192.168.3.101

include theos/makefiles/common.mk

BUNDLE_NAME = goagentwidget
goagentwidget_FILES = goagentwidgetController.m
goagentwidget_INSTALL_PATH = /Library/WeeLoader/Plugins
goagentwidget_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
