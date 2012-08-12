APPS = goagent-ios goagent-widget
DEB_NAME = org.goagent.local.ios.deb
PKG_ROOT = deb-pkg-root
DEVICE_IP=192.168.3.101

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

package: install 
	echo "packaging $(DEB_NAME)"
	dpkg -b $(PKG_ROOT) $(PKG_ROOT)/$(DEB_NAME)	

deploy: package
	scp $(PKG_ROOT)/$(DEB_NAME) root\@$(DEVICE_IP):/
clean:
	@for i in $(APPS) ; do \
		echo "cleaning $$i" ; \
		make -C $$i clean || exit 1; \
		rm -rf $$PRJDIR/build ; \
	done
	echo "cleaning $(PKG_ROOT)"
	rm -Rf $(PKG_ROOT)/Applications
	rm -Rf $(PKG_ROOT)/Library
	rm -Rf $(PKG_ROOT)/$(DEB_NAME)
