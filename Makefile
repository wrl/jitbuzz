CC := clang
LD := $(CC)

OUTDIR := build
SRCDIR := src

CFLAGS  += -ggdb -Wall -Werror -std=c99 -pthread -I. -Ivendor/sljit/sljit_src -DSLJIT_CONFIG_AUTO=1
LDFLAGS += -pthread

TARGETS  = $(OUTDIR)/jitbuzz

JITBUZZ_OBJS = $(OUTDIR)/vendor/sljit/sljitLir.o

.PHONY: all clean

all: $(TARGETS)

clean:
	rm -rf $(OUTDIR)

$(OUTDIR):
	mkdir -p $@

$(OUTDIR)/vendor/sljit:
	mkdir -p $@

$(OUTDIR)/jitbuzz: $(OUTDIR)/jitbuzz.o $(JITBUZZ_OBJS)
	$(LD) $(CFLAGS) $(LDFLAGS) -o $@ $^

$(OUTDIR)/vendor/sljit/%.o: ./vendor/sljit/sljit_src/%.c | $(OUTDIR)/vendor/sljit
	$(CC) -c $(CFLAGS) -o $@ $^

$(OUTDIR)/%.o: $(SRCDIR)/%.c | $(OUTDIR)
	$(CC) -c $(CFLAGS) -o $@ $^
