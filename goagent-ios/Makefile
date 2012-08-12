DSTROOT=../deb-pkg-root

PROJECT=goagent-ios.xcodeproj
TARGETS=goagent-ios
XCODEBUILD=/usr/bin/xcodebuild 
CONFIGURATION=Release

.PHONY: all
all: goagent-ios	

.PHONY: $(TARGETS)
$(TARGETS):
	@echo "*** building $@"
	$(XCODEBUILD) -project $(PROJECT) -configuration $(CONFIGURATION) -target $@ build
	
.PHONY: clean
clean:
	@for i in $(TARGETS); do \
	echo "*** cleaning $$i"; \
	$(XCODEBUILD) -project $(PROJECT) -configuration $(CONFIGURATION) -target $$i clean; \
	done

.PHONY: custom-install
custom-install: $(TARGETS)
	@for i in $(TARGETS); do \
	echo "*** installing $$i"; \
	$(XCODEBUILD) DSTROOT=$(DSTROOT) -project $(PROJECT) -configuration $(CONFIGURATION) -target $$i install; \
	done

.PHONY: package
package:
	
