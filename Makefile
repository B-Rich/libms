TARGETS:=libms.a
SRCS:=ms.c ms_mem_basics.c ms_rotate.c ms_bin.c ms_bin_seq.c ms_bin_map.c ms_conv.c ms_utils.c ms_counters.c
OBJS:=$(SRCS:%.c=%.c.o)
DEPS:=$(SRCS:%.c=%.c.d)
ALLDEPS=$(MAKEFILE_LIST_SANS_DEPS)
CFLAGS:=-Wall -Wextra -Wno-unused-parameter -O2 -g

CC:=gcc
AR:=ar
ARFLAGS:=cr
RANLIB:=ranlib
RM:=rm -f

all:

VALID_MAKECMDGOALS:=all $(TARGETS) %.c.d %.c.o clean
NONEED_DEP_MAKECMDGOALS:=clean

EXTRA_MAKECMDGOALS:=$(filter-out $(VALID_MAKECMDGOALS), $(MAKECMDGOALS))
ifneq '$(EXTRA_MAKECMDGOALS)' ''
  $(error No rule to make target `$(word 1, $(EXTRA_MAKECMDGOALS))')
else
  ifeq '$(filter-out $(NONEED_DEP_MAKECMDGOALS), $(MAKECMDGOALS))' '$(MAKECMDGOALS)'
    sinclude $(DEPS)
	else
    ifneq '$(words $(MAKECMDGOALS))' '1'
      $(error Specify only one target if you want to make target which needs no source code dependency)
    endif
  endif
endif

MAKEFILE_LIST_SANS_DEPS:=$(filter-out %.c.d, $(MAKEFILE_LIST))

COMPILE.c=$(CC) $(CFLAGS) $(EXTRACFLAGS) $(CPPFLAGS) $(EXTRACPPFLAGS) $(TARGET_ARCH) -c
COMPILE.d=$(CC) $(CFLAGS) $(EXTRACFLAGS) $(CPPFLAGS) $(EXTRACPPFLAGS) $(TARGET_ARCH) -M -MP -MT $<.o -MF $@

all: $(TARGETS)

libms.a: $(OBJS) $(ALLDEPS)
	$(AR) $(ARFLAGS) $@ $(OBJS)
	$(RANLIB) $@

%.c.o: %.c $(ALLDEPS)
	$(COMPILE.c) $(OUTPUT_OPTION) $<

%.c.d: %.c $(ALLDEPS)
	$(COMPILE.d) $<

.PHONY: clean
clean:
	$(RM) $(TARGETS)
	$(RM) $(OBJS)
	$(RM) $(DEPS)
