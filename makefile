CFLAGS += -I./include -I$(SYSROOT)/usr/include -Wall -Wextra
LDFLAGS += -lm

SRCS=$(wildcard *.c)

OBJS=$(SRCS:.c=.o)

.PHONY: all

all: libcomplex.a libcomplex.so

libcomplex.a: $(OBJS)
	$(AR) $(ARFLAGS) $@ $^
	$(RANLIB) $@

libcomplex.so: libcomplex.a
	$(CC) -shared -Xlinker -soname=$@ -o $@ -Wl,-whole-archive $^ -Wl,-no-whole-archive $(LDFLAGS)

.PHONY: clean

clean:
	rm -f $(OBJS) libcomplex.a libcomplex.so

install:
	@echo "installing..."
	@echo ""
	mkdir -p $(SYSROOT)/usr/lib
	install -m 644 -p libcomplex.so libcomplex.a $(SYSROOT)/usr/lib
	install -m 644 -p include/complex.h $(SYSROOT)/usr/include
