TARGET=xin
SRC=xin.oil
PREFIX ?= ~/.local/bin

VERSION=0.1

.PHONY: all release install uninstall clean


all: $(TARGET)
release: $(TARGET)-release
debug: $(TARGET)-debug

$(TARGET): $(SRC)
	cp $(SRC) $(TARGET)
	chmod +x $(TARGET)

$(TARGET)-release: $(SRC)
	$(CC) $(CFLAGS) $(CPPFLAGSREL) $(LDFLAGS) $(SRC) -o $(TARGET)
	tar -czvf $(TARGET)-$(VERSION).tar.gz $(TARGET)

install: $(TARGET)
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m755 $(TARGET) $(DESTDIR)$(PREFIX)/bin/$(TARGET)

uninstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/$(TARGET)

$(TARGET)-debug: $(SRC)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(SRC) -Og -o $@

clean:
	$(RM) $(TARGET)
	$(RM) $(TARGET)-$(VERSION).tar.gz
