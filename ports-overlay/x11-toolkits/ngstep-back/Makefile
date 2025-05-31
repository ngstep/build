PORTNAME=	ngstep-back
DISTVERSION=	20250531
CATEGORIES=	x11-toolkits gnustep

MAINTAINER=	jpm820@proton.me
COMMENT=	NgSTEP GUI backend
WWW=		https://github.com/ngstep/

LICENSE_COMB=	multi
LICENSE=	GPLv3 LGPL3

LIB_DEPENDS+=	libgif.so:graphics/giflib \
		libtiff.so:graphics/tiff \
		libXft.so:x11-fonts/libXft \
		libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2 \
		libcairo.so:graphics/cairo

USES=		gl ngstep jpeg pkgconfig xorg
USE_GNUSTEP=	base gui build
USE_XORG=	xft xrender xmu xext x11 xcursor xfixes xmu
USE_GL=	gl

USE_GITHUB=	yes
GH_ACCOUNT=	ngstep
GH_TAGNAME= 895528d

GNU_CONFIGURE=	yes

.include <bsd.port.mk>
