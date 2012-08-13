APPS = goagent-ios goagent-widget
DEB_NAME = org.goagent.local.ios
PKG_ROOT = deb-pkg-root
DEVICE_IP=10.64.81.40
VERSION = $(shell grep Version $(PKG_ROOT)/DEBIAN/control | cut -d ":" -f2 | tr -d " ")
.PHONY : $(APPS)

all: build_apps

build_apps:
	@for i in $(APPS) ; do \
		echo "building [$$i]" ; \
		make -C $$i || exit 1; \
	done

install: all
	@for i in $(APPS) ; do \
		echo "install [$$i] to output dir" ; \
		make -C $$i custom-install || exit 1; \
	done

package: 
	echo "packaging $(DEB_NAME)"
	dpkg -b $(PKG_ROOT) $(PKG_ROOT)/$(DEB_NAME)_$(VERSION)_iphoneos-arm.deb	

deploy: 
	scp $(PKG_ROOT)/$(DEB_NAME)_$(VERSION)_iphoneos-arm.deb root\@$(DEVICE_IP):/
clean:
	@for i in $(APPS) ; do \
		echo "cleaning $$i" ; \
		make -C $$i clean || exit 1; \
		rm -rf $$PRJDIR/build ; \
	done
	echo "cleaning $(PKG_ROOT)"
	rm -Rf $(PKG_ROOT)/Applications
	rm -Rf $(PKG_ROOT)/Library
	rm -Rf $(PKG_ROOT)/*.deb
