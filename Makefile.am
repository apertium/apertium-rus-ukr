VERSION=0.0.1
LANG1=ru
LANG2=uk
PREFIX1=$(LANG1)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)
PREFVAR1=#none
PREFVAR2=noyo-

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON = $(PREFIX1).automorf.bin $(PREFIX1).autobil.bin $(PREFIX1).autogen.bin \
     $(PREFIX1).autopgen.bin $(PREFIX2).automorf.bin $(PREFIX2).autobil.bin \
     $(PREFIX2).autogen.bin $(PREFIX2).autopgen.bin $(PREFIX1).lextormono.bin $(PREFIX2).lextormono.bin \
     $(PREFIX1).lextorbil.bin $(PREFIX2).lextorbil.bin \
     $(PREFIX1).t1x.bin $(PREFIX1).t2x.bin $(PREFIX1).t3x.bin \
     $(PREFIX1)-poly.autobil.bin $(PREFIX2)-poly.autobil.bin empty.bin \
     $(PREFIX2).t1x.bin $(PREFIX2).t2x.bin $(PREFIX2).t3x.bin modes

TARGETS = $(TARGETS_COMMON) \
	  $(BASENAME).$(LANG1)-lextor.dix $(BASENAME).$(LANG2)-lextor.dix \
	  $(BASENAME).$(PREFIX1)-lextor.dix $(BASENAME).$(PREFIX2)-lextor.dix 

.deps/$(PREFVAR1)$(LANG1).dix: $(BASENAME).$(LANG1).dix
	if [ ! -d .deps ]; then mkdir .deps; fi
	@xsltproc --stringparam lang yo --stringparam side left filter.xsl $(BASENAME).$(LANG1).dix > $@
	
.deps/$(PREFVAR2)$(LANG2).dix: $(BASENAME).$(LANG1).dix
	if [ ! -d .deps ]; then mkdir .deps; fi
	@xsltproc --stringparam lang no-yo --stringparam side left filter.xsl $(BASENAME).$(LANG1).dix > $@

$(PREFIX1).automorf.bin: .deps/$(PREFVAR1)$(LANG1).dix $(BASENAME).$(LANG1).acx
	apertium-validate-dictionary .deps/$(PREFVAR1)$(LANG1).dix
	lt-comp lr .deps/$(PREFVAR1)$(LANG1).dix $@ $(BASENAME).$(LANG1).acx

$(PREFIX1).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
#	xsltproc translate-to-default-equivalent.xsl $(BASENAME).$(PREFIX1).dix >tmp$(PREFIX1).autobil.dix
#	lt-comp lr tmp$(PREFIX1).autobil.dix $@
#	rm tmp$(PREFIX1).autobil.dix
	lt-comp lr $(BASENAME).$(PREFIX1).dix $@

$(PREFIX1).autogen.bin: $(BASENAME).$(LANG2).dix
	apertium-validate-dictionary $(BASENAME).$(LANG2).dix
	lt-comp rl $(BASENAME).$(LANG2).dix $@

$(PREFIX1).autopgen.bin: $(BASENAME).post-$(LANG2).dix
	apertium-validate-dictionary $(BASENAME).post-$(LANG2).dix
	lt-comp lr $(BASENAME).post-$(LANG2).dix $@

$(PREFIX2).automorf.bin: $(BASENAME).$(LANG2).dix $(BASENAME).$(LANG2).acx
	apertium-validate-acx $(BASENAME).$(LANG2).acx
	apertium-validate-dictionary $(BASENAME).$(LANG2).dix
	lt-comp lr $(BASENAME).$(LANG2).dix $@ $(BASENAME).$(LANG2).acx

$(PREFIX2).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp rl $< $@

$(PREFIX2).autogen.bin: .deps/$(PREFVAR1)$(LANG1).dix
	lt-comp rl .deps/$(PREFVAR1)$(LANG1).dix $@

$(PREFVAR2)$(PREFIX2).autogen.bin: .deps/$(PREFVAR2)$(LANG1).dix
	lt-comp rl .deps/$(PREFVAR2)$(LANG1).dix $@

$(PREFIX2).autopgen.bin: $(BASENAME).post-$(LANG1).dix
	apertium-validate-dictionary $(BASENAME).post-$(LANG1).dix
	lt-comp lr $(BASENAME).post-$(LANG1).dix $@

$(BASENAME).$(LANG1)-lextor.dix: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
	apertium-gen-lextormono rl $(BASENAME).$(PREFIX1).dix $@

$(BASENAME).$(LANG2)-lextor.dix: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
	apertium-gen-lextormono lr $(BASENAME).$(PREFIX1).dix $@

$(PREFIX1).lextormono.bin: $(BASENAME).$(LANG1)-lextor.dix
	lt-comp lr $(BASENAME).$(LANG1)-lextor.dix $@

$(PREFIX2).lextormono.bin: $(BASENAME).$(LANG2)-lextor.dix
	lt-comp lr $(BASENAME).$(LANG2)-lextor.dix $@

$(PREFIX1).t1x.bin: $(BASENAME).$(PREFIX1).t1x
	apertium-validate-transfer $(BASENAME).$(PREFIX1).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t1x $@

$(PREFIX1).t2x.bin: $(BASENAME).$(PREFIX1).t2x
	apertium-validate-interchunk $(BASENAME).$(PREFIX1).t2x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t2x $@

$(PREFIX1).t3x.bin: $(BASENAME).$(PREFIX1).t3x
	apertium-validate-postchunk $(BASENAME).$(PREFIX1).t3x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t3x $@

$(PREFIX2).t1x.bin: $(BASENAME).$(PREFIX2).t1x
	apertium-validate-transfer $(BASENAME).$(PREFIX2).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t1x $@

$(PREFIX2).t2x.bin: $(BASENAME).$(PREFIX2).t2x
	apertium-validate-interchunk $(BASENAME).$(PREFIX2).t2x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t2x $@

$(PREFIX2).t3x.bin: $(BASENAME).$(PREFIX2).t3x
	apertium-validate-postchunk $(BASENAME).$(PREFIX2).t3x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t3x $@

empty.bin: empty.t1x
	apertium-validate-transfer empty.t1x
	apertium-preprocess-transfer empty.t1x $@

EXTRA_DIST=$(BASENAME).$(LANG1).metadix $(BASENAME).$(PREFIX1).dix \
	   $(BASENAME).post-$(LANG1).dix $(BASENAME).post-$(LANG2).dix \
	   $(BASENAME).$(LANG2).dix $(BASENAME).$(LANG1).tsx \
	   $(BASENAME).$(LANG2).tsx empty.t1x \
	   $(PREFIX1).prob $(PREFIX2).prob \
	   filter.xsl filter.sh \
	   $(PREFIX1)-supervised.make $(PREFIX1)-unsupervised.make \
	   $(PREFIX2)-supervised.make $(PREFIX2)-unsupervised.make \
	   $(LANG1)-tagger-data/README $(LANG2)-tagger-data/README \
	   $(BASENAME).$(PREFIX1).t1x $(BASENAME).$(PREFIX1).t2x \
	   $(BASENAME).$(PREFIX1).t3x $(BASENAME).$(PREFIX2).t1x \
	   $(BASENAME).$(PREFIX2).t2x $(BASENAME).$(PREFIX2).t3x \
           $(BASENAME).$(LANG1).acx $(BASENAME).$(LANG2).acx \
	   modes.xml

apertium_ru_uk_DATA=$(PREFIX1).automorf.bin $(PREFIX2).automorf.bin \
		    $(PREFIX1).autobil.bin $(PREFIX2).autobil.bin \
		    $(PREFIX1).autogen.bin $(PREFIX2).autogen.bin \
		    $(PREFIX1).autopgen.bin $(PREFIX2).autopgen.bin \
		    $(PREFIX1).prob $(PREFIX2).prob \
		    $(PREFIX1).t1x.bin $(PREFIX1).t2x.bin $(PREFIX1).t3x.bin \
		    $(PREFIX2).t1x.bin $(PREFIX2).t2x.bin $(PREFIX2).t3x.bin \
		    $(PREFIX1).mode $(PREFIX2).mode 

apertium_ru_ukdir=$(prefix)/share/apertium/apertium-$(PREFIX1)/
apertium_ru_modesdir=$(prefix)/share/apertium/modes/

$(PREFIX1).mode: modes.xml
	apertium-gen-modes modes.xml

$(PREFIX2).mode: modes.xml
	apertium-gen-modes modes.xml

modes: modes.xml
	apertium-gen-modes modes.xml

install-data-local:
	apertium-gen-modes modes.xml apertium-$(PREFIX1)
	test -d $(DESTDIR)$(apertium_en_modesdir) || mkdir $(DESTDIR)$(apertium_en_modesdir)
	$(INSTALL_DATA) $(PREFIX1).mode $(DESTDIR)$(apertium_en_modesdir)
	$(INSTALL_DATA) $(PREFIX2).mode $(DESTDIR)$(apertium_en_modesdir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t1x $(BASENAME).$(PREFIX1).t2x $(DESTDIR)$(apertium_en_cadir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t3x $(BASENAME).$(PREFIX2).t1x $(DESTDIR)$(apertium_en_cadir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX2).t2x $(BASENAME).$(PREFIX2).t3x $(DESTDIR)$(apertium_en_cadir)


CLEANFILES = -rf $(TARGETS) modes

