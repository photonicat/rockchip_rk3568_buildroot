ifeq ($(BR2_PACKAGE_ISP2_IPC),y)
ISP2_IPC_SITE = $(TOPDIR)/../external/isp2-ipc
ISP2_IPC_SITE_METHOD = local
ISP2_IPC_INSTALL_STAGING = YES
ISP2_IPC_DEPENDENCIES = libglib2
ISP2_IPC_TARGET_INSTALL_DIR = $(TARGET_DIR)

ifeq ($(BR2_PACKAGE_RK_OEM), y)
ifneq ($(BR2_PACKAGE_THUNDERBOOT), y)
ifneq ($(BR2_PACKPAG_ISP2_IPC_FORCE_INSTALL_TO_ROOTFS), y)
 ISP2_IPC_INSTALL_TARGET_OPTS = DESTDIR=$(BR2_PACKAGE_RK_OEM_INSTALL_TARGET_DIR) install/fast
 ISP2_IPC_DEPENDENCIES += rk_oem
 ISP2_IPC_TARGET_INSTALL_DIR = $(BR2_PACKAGE_RK_OEM_INSTALL_TARGET_DIR)
 ISP2_IPC_CONF_OPTS += -DCONFIG_OEM=1
endif
endif
endif

ifeq ($(BR2_PACKPAG_ISP2_IPC_FORCE_INSTALL_TO_ROOTFS), y)
 ISP2_IPC_CONF_OPTS += -DSYS_START=1
else
 ISP2_IPC_CONF_OPTS += -DSYS_START=0
endif

ifeq ($(BR2_PACKPAG_ISP2_IPC_CALL_FUNC), y)
 ISP2_IPC_CONF_OPTS += -DCONFIG_CALLFUNC=1
else
 ISP2_IPC_CONF_OPTS += -DCONFIG_CALLFUNC=0
endif

ifeq ($(BR2_PACKAGE_ISP2_IPC_DBUS), y)
 ISP2_IPC_CONF_OPTS += -DCONFIG_DBUS=1
 ISP2_IPC_DEPENDENCIES += dbus
endif

ifeq ($(BR2_PACKAGE_ISP2_IPC_DBSERVER), y)
 ISP2_IPC_CONF_OPTS += -DCONFIG_DBSERVER=1
 ISP2_IPC_DEPENDENCIES += libIPCProtocol
endif

ifeq ($(BR2_PACKAGE_ISP2_IPC_MINILOGGER), y)
    ISP2_IPC_CONF_OPTS += -DENABLE_MINILOGGER=ON
    ISP2_IPC_DEPENDENCIES += minilogger
else
    ISP2_IPC_CONF_OPTS += -DENABLE_MINILOGGER=OFF
endif

ifeq ($(BR2_PACKAGE_MEDIASERVER), y)
    ISP2_IPC_CONF_OPTS += -DENABLE_MEDIASERVER=ON
else
    ISP2_IPC_CONF_OPTS += -DENABLE_MEDIASERVER=OFF
endif

endif
$(eval $(cmake-package))
