PORTNAME=	ngstep-make
DISTVERSION=	20250526
CATEGORIES=	devel gnustep

MAINTAINER=	jpm820@proton.me
COMMENT=	NgSTEP makefile package
WWW=		http://github.com/ngstep/

LICENSE=	GPLv3
CONFLICTS=	gnustep-make

USES=		ngstep objc
GNU_CONFIGURE=	yes
GNUSTEP_PREFIX=	/

USE_GITHUB=	yes
GH_ACCOUNT=	ngstep
GH_TAGNAME= 0661986

MAKE_FLAGS=	OPTFLAG="${CFLAGS}"
CONFIGURE_ENV+=	INSTALL_PROGRAM="${INSTALL} -c" INSTALL_DATA="${INSTALL} -c"
MAKE_ENV+=	NGSTEP_INSTALLATION_DOMAIN=SYSTEM

CONFIGURE_ARGS+= \
		--with-config-file=/System/Library/Preferences/GNUstep.conf \
		--with-layout=ngstep \
		--with-library-combo=ng-gnu-gnu

GNU_CONFIGURE_PREFIX= ${GNUSTEP_PREFIX}
NO_ARCH=	yes

.include <bsd.port.mk>
