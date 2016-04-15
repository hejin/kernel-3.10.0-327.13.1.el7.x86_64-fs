#
# Makefile for Linux CIFS VFS client 
#
obj-$(CONFIG_CIFS) += cifs.o

cifs-y := cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o inode.o \
	  link.o misc.o netmisc.o smbencrypt.o transport.o asn1.o \
	  cifs_unicode.o nterr.o xattr.o cifsencrypt.o \
	  readdir.o ioctl.o sess.o export.o smb1ops.o winucase.o

cifs-$(CONFIG_CIFS_ACL) += cifsacl.o

cifs-$(CONFIG_CIFS_UPCALL) += cifs_spnego.o

cifs-$(CONFIG_CIFS_DFS_UPCALL) += dns_resolve.o cifs_dfs_ref.o

cifs-$(CONFIG_CIFS_FSCACHE) += fscache.o cache.o

cifs-$(CONFIG_CIFS_SMB2) += smb2ops.o smb2maperror.o smb2transport.o \
			    smb2misc.o smb2pdu.o smb2inode.o smb2file.o
#
## Only support external build, and does not support kernel build.
#
#
# Description for external build begins here
#

KVER := $(shell uname -r)
KSRC := /lib/modules/$(KVER)/build
MDIR := /lib/modules/$(KVER)/kernel/fs/cifs/
PWD := $(shell pwd)

PREINC := #-I$(PWD)/../../include
#CFLAGS += -Wall

default: 
	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) BUILD_DIR=$(PWD) \
        NOSTDINC_FLAGS=$(PREINC) modules

install: 
	unload install -d $(MDIR) 
	install -m 644 -c $(addsuffix .ko,$(list-m)) $(MDIR) 
	/sbin/depmod $(KVER) -A
uninstall: unload 
	rm -rf $(addprefix $(MDIR),$(addsuffix .ko,$(list-m))) 
	/sbin/depmod $(KVER) -A

load: 
	modprobe $(list-m)

unload: 
	@test "`uname -r`" != "$(KVER)" || \ 
	if [ -n "`mount -t $(list-m)`" ]; then \ 
		echo "Unmount $(list-m) first."; false; \ 
	elif (/sbin/lsmod | grep -e ^$(list-m)' ') > /dev/null; then /sbin/rmmod $(list-m); \ 
	if [ $$? != 0 ]; then echo "failed to unload $(list-m)"; false; \ 
	else echo "unloaded $(list-m)"; fi \ 
	fi \

clean: 
	rm -f *.mod.c *.mod *.o *.ko .*.cmd .*.flags *.lst *~ .#* 
	rm -f modules.order Module.symvers 
	rm -rf .tmp_versions .$(obj-m:.o=)*
