PORTNAME=	gnustep-base
DISTVERSION=	g20250526
CATEGORIES=	lang devel gnustep

MAINTAINER=	jpm820@proton.me
COMMENT=	NgSTEP Foundation library
WWW=		http://github.com/ngstep/

LICENSE=	GPLv3 LGPL3
LICENSE_COMB=	multi

LIB_DEPENDS=	libffi.so:devel/libffi \
		libcurl.so:ftp/curl \
		libgcrypt.so:security/libgcrypt \
		libgmp.so:math/gmp

GNUSTEP_PREFIX=	/

RUN_DEPENDS=	${GNUSTEP_PREFIX}/System/Library/Makefiles/GNUstep.sh:devel/gnustep-make

USES=		pkgconfig iconv gnome gnustep
USE_GNOME=	libxml2 libxslt
USE_GNUSTEP=	build
USE_LDCONFIG=	${GNUSTEP_SYSTEM_LIBRARIES}

GNU_CONFIGURE=	yes

STAGEHEADER=	${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Headers

CONFIGURE_ARGS=	--disable-procfs \
		--with-installation-domain=SYSTEM
CONFIGURE_ENV=	OBJCFLAGS='-fobjc-runtime=gnustep-2.0 -fblocks' \
		ac_cv_header_bfd_h=no ac_cv_lib_bfd_bfd_openr=no

PLIST_SUB=	BASEVERSION=${DISTVERSION:R}

OPTIONS_DEFINE=		ICU GNUTLS
OPTIONS_RADIO=		ZEROCONF
OPTIONS_RADIO_ZEROCONF=	AVAHI MDNS
OPTIONS_DEFAULT=	ICU GNUTLS AVAHI
OPTIONS_SUB=		yes

ZEROCONF_DESC=		Zeroconf (Bonjour) support
AVAHI_DESC=		Zeroconf via Avahi (preferred)
MDNS_DESC=		Zeroconf via mDNSResponder

ICU_LIB_DEPENDS=	libicuuc.so:devel/icu
ICU_CONFIGURE_OFF=	--disable-icu

GNUTLS_LIB_DEPENDS=	libgnutls.so:security/gnutls
GNUTLS_CONFIGURE_OFF=	--disable-tls

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MAVAHI}
LIB_DEPENDS+=		libavahi-client.so:net/avahi-app
CONFIGURE_ARGS+=	--with-zeroconf-api=avahi
.elif ${PORT_OPTIONS:MMDNS}
LIB_DEPENDS+=		libdns_sd.so:net/mDNSResponder
CONFIGURE_ARGS+=	--with-zeroconf-api=mdns
.else
CONFIGURE_ARGS+=	--disable-zeroconf
.endif

PLIST_FILES=	# empty

.include <bsd.port.mk>