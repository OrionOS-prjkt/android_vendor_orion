PRODUCT_VERSION_MAJOR = 14
PRODUCT_VERSION_MINOR = 0

# Increase CR Version with each major release.
ORION_VERSION := Andromeda

# OOS maintainer flags
ORION_MAINTAINER ?= Unknown
ORION_MAINTAINER_LINK ?= https://t.me/OrionOS_prjkt

# Check Official
ifndef ORION_BUILD_TYPE
    ORION_BUILD_TYPE := UNOFFICIAL
endif

# Gapps
WITH_GMS := $(ORION_GAPPS)
ifeq ($(ORION_GAPPS),true)
ORION_BUILD_VARIANT := Gapps
$(call inherit-product-if-exists, vendor/gapps/common/common-vendor.mk)
PRODUCT_PACKAGES += OtaGapps
else
  PRODUCT_PACKAGES += OtaVanila
  ORION_BUILD_VARIANT := Vanilla
endif

# Internal version
LINEAGE_VERSION := OrionOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(ORION_VERSION)-$(LINEAGE_BUILD)-$(ORION_BUILD_TYPE)-$(ORION_BUILD_VARIANT)-$(shell date +%Y%m%d)

# Display version
LINEAGE_DISPLAY_VERSION := OrionOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(ORION_VERSION)-$(LINEAGE_BUILD)-$(ORION_BUILD_TYPE)-$(ORION_BUILD_VARIANT)

ORION_BUILD_INFO := $(LINEAGE_VERSION)
