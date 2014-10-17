################################################################################
# Linux AUFS3 filesystem
#
# Patch the linux kernel with AUFS3 filesystem
################################################################################

ifeq ($(BR2_LINUX_KERNEL_EXT_AUFS),y)
# Add dependency to AUFS3 (user-space) which provide kernel patches
LINUX_DEPENDENCIES += aufs

# Prepare kernel patch
define AUFS_PREPARE_KERNEL_PATCHES
	support/scripts/apply-patches.sh $(LINUX_DIR) $(AUFS_DIR)
endef

define AUFS_PREPARE_KERNEL_FILES
	cp -r $(AUFS_DIR)/Documentation $(LINUX_DIR) ; \
	cp -r $(AUFS_DIR)/fs $(LINUX_DIR) ; \
	cp -r $(AUFS_DIR)/include/uapi/linux/aufs_type.h \
		$(LINUX_DIR)/include/uapi/linux/
	echo "header-y += aufs_type.h" >> \
		$(LINUX_DIR)/include/uapi/linux/Kbuild
endef

LINUX_POST_EXTRACT_HOOKS += AUFS_PREPARE_KERNEL_FILES
LINUX_PRE_PATCH_HOOKS += AUFS_PREPARE_KERNEL_PATCHES

endif #BR2_LINUX_KERNEL_EXT_AUFS
