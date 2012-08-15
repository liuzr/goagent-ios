APPS = goagent-ios goagent-widget
DEB_ID = org.goagent.local.ios
PKG_ROOT = deb-pkg-root
DEVICE_IP=10.64.80.104
VERSION = $(shell grep Version $(PKG_ROOT)/DEBIAN/control | cut -d ":" -f2 | tr -d " ")
DEB_NAME = $(DEB_ID)_$(VERSION)_iphoneos-arm.deb 

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
	dpkg -b $(PKG_ROOT) $(PKG_ROOT)/$(DEB_NAME)	

deploy: 
	ssh -p 22 root\@$(DEVICE_IP) "dpkg -r /$(DEB_ID)" ; \
	scp $(PKG_ROOT)/$(DEB_NAME) root\@$(DEVICE_IP):/ ; \
	ssh -p 22 root\@$(DEVICE_IP) "dpkg -i /$(DEB_NAME)" ; \
	ssh -p 22 root\@$(DEVICE_IP) "killall -9 SpringBoard" ; \

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
