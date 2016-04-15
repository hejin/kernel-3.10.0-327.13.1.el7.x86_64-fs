SUBDIRS = cifs

.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS)

clean: RULE = clean
install: RULE = install
uninstall: RULE = uninstall

all clean install uninstall: $(SUBDIRS)

$(SUBDIRS): 
	$(MAKE) -C $@ $(RULE)
