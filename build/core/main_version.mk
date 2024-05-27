# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# OrionOS System Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.orion.build.version=$(LINEAGE_VERSION) \
    ro.orion.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.orion.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(ORION_VERSION) \
    ro.orionlegal.url=https://crdroid.net/legal.php \
    ro.orion.maintainer=$(ORION_MAINTAINER) \
    ro.orion.build.variant=$(ORION_BUILD_VARIANT) \
    ro.orion.release.type=$(ORION_BUILD_TYPE)

# LineageOS Platform SDK Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)
