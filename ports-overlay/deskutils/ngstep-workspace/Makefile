PORTNAME=	ngstep-workspace
DISTVERSION=	20250531
CATEGORIES=	deskutils gnustep

MAINTAINER=	jpm820@proton.me
COMMENT=	NgSTEP workspace manager
WWW=		https://github.com/ngstep/

LICENSE=	GPLv2

USE_GITHUB=	yes
GH_ACCOUNT=	ngstep
GH_TAGNAME=	c4a91ea

USES=		ngstep
USE_NGSTEP=	back build
USE_LDCONFIG=	${GNUSTEP_SYSTEM_LIBRARIES}

GNU_CONFIGURE=	yes

pre-configure:
	${RM} -r ${WRKSRC}/GWMetadata

.include <bsd.port.mk>
