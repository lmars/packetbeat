BIN_PATH?=/usr/bin
CONF_PATH?=/etc/packetbeat
VERSION?=0.1.0
ARCH?=$(shell uname -m)

packetbeat:
	go build

.PHONY: install
install: packetbeat
	install -D packetbeat $(DESTDIR)/$(BIN_PATH)/packetbeat
	install -D packetbeat.conf $(DESTDIR)/$(CONF_PATH)/packetbeat.conf

.PHONY: dist
dist: packetbeat
	mkdir packetbeat-$(VERSION)
	cp packetbeat packetbeat-$(VERSION)/
	cp packetbeat.conf packetbeat-$(VERSION)/
	tar czvf packetbeat-$(VERSION)-$(ARCH).tar.gz packetbeat-$(VERSION)

.PHONY: gofmt
gofmt:
	gofmt -w -tabs=false -tabwidth=4 *.go

.PHONY: clean
clean:
	rm packetbeat || true
	rm -r packetbeat-$(VERSION) || true
