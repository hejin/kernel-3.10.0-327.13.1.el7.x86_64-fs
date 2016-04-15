# kernel-3.10.0-327.13.1.el7.x86_64-fs
slightly modified linux cifs kernel module

INSTALL:
1. rmmod the original cifs kernel module
2. insmod cifs.ko  CIFSMaxBufSize=130048 cifs_min_rcv=64 cifs_min_small=256
