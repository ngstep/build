PORTNAME=	ngstep-make
DISTVERSION=	g20250526
CATEGORIES=	devel gnustep

MAINTAINER=	pkgdemonteam@gmail.combo
COMMENT=	NgSTEP makefile package
WWW=		http://github.com/ngstep/

LICENSE=	GPLv3

USES=		gnustep objc shebangfix
GNU_CONFIGURE=	yes
SHEBANG_FILES=	bake_debian_files.sh

USE_GITHUB=	yes
GH_ACCOUNT=	ngstep
GH_TAGNAME= 0661986

MAKE_FLAGS=	OPTFLAG="${CFLAGS}"
CONFIGURE_ENV+=	INSTALL_PROGRAM="${INSTALL} -c" INSTALL_DATA="${INSTALL} -c"
CONFIGURE_ARGS+=	--with-thread-lib=-pthread \
			--with-config-file=${GNUSTEP_PREFIX}/GNUstep.conf \
			--with-layout=gnustep \
			--enable-objc-nonfragile-abi \
			--enable-native-objc-exceptions \
			--with-library-combo=ng-gnu-gnu
GNU_CONFIGURE_PREFIX=	${GNUSTEP_PREFIX}
NO_ARCH=	yes

post-install:
	${LN} -s Library/Makefiles ${STAGEDIR}${GNUSTEP_PREFIX}/System/
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Applications
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/ApplicationSupport
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Bundles
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/ColorPickers
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Colors
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/DocTemplates
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Documentation/info
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Documentation/man
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Documentation/Developer
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Documentation/User
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Fonts
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Frameworks
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Headers
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Images
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/KeyBindings
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Libraries/Java
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Libraries/Resources
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/PostScript
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Services
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Library/Sounds
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Tools/Java
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/System/Tools/Resources
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/Local/Applications
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/Local/Library/ApplicationSupport
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/Local/Library/Bundles
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/Local/Library/Documentation
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/Local/Library/Frameworks
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/Local/Library/Headers
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/Local/Library/Libraries
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/Local/Library/Preferences
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/Local/Library/Services
	-${MKDIR} ${STAGEDIR}${GNUSTEP_PREFIX}/Local/Tools/Resources

.include <bsd.port.mk>
