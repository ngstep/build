# Handle NgSTEP related ports
#
# Feature:	ngstep
# Usage:	USES=ngstep
#
# Defined specific dependencies under USE_NGSTEP
# Expected arguments for USE_NGSTEP:
#
# base:		depends on the ngstep-base port
# gui:		depends on the ngstep-gui port
# back:		depends on the ngstep-back port
# build:	prepare the build dependencies for a regular NgSTEP port
#

.if !defined(_INCLUDE_USES_NGSTEP_MK)
_INCLUDE_USES_NGSTEP_MK=	yes
.include "${USESDIR}/gmake.mk"

GNUSTEP_PREFIX?=	/
DEFAULT_LIBVERSION?=	0.0.1

GNUSTEP_SYSTEM_ROOT=		${GNUSTEP_PREFIX}/System
GNUSTEP_MAKEFILES=		${GNUSTEP_SYSTEM_ROOT}/Library/Makefiles
GNUSTEP_SYSTEM_LIBRARIES=	${GNUSTEP_SYSTEM_ROOT}/Library/Libraries
GNUSTEP_SYSTEM_TOOLS=		${GNUSTEP_SYSTEM_ROOT}/Library//Tools

GNUSTEP_LOCAL_ROOT=	${GNUSTEP_PREFIX}/Local
GNUSTEP_LOCAL_LIBRARIES=	${GNUSTEP_LOCAL_ROOT}/Library/Libraries
GNUSTEP_LOCAL_TOOLS=		${GNUSTEP_LOCAL_ROOT}/Library//Tools

LIB_DIRS+=	${GNUSTEP_SYSTEM_LIBRARIES} \
		${GNUSTEP_LOCAL_LIBRARIES}

.  for a in CFLAGS CPPFLAGS CXXFLAGS OBJCCFLAGS OBJCFLAGS LDFLAGS
MAKE_ENV+=	ADDITIONAL_${a}="${ADDITIONAL_${a}} ${${a}}"
.  endfor
.  for a in FLAGS INCLUDE_DIRS LIB_DIRS
MAKE_ENV+=	ADDITIONAL_${a}="${ADDITIONAL_${a}}"
.  endfor
MAKE_ARGS+=messages=yes
# BFD ld can't link Objective-C programs for some reason.  Most things are fine
# with LLD, but the things that don't (e.g. sope) need gold.
.  if defined(LLD_UNSAFE)
MAKE_ARGS+=LDFLAGS='-fuse-ld=gold'
BUILD_DEPENDS+=         ${LOCALBASE}/bin/ld.gold:devel/binutils
.  else
MAKE_ARGS+=LDFLAGS='-fuse-ld=${OBJC_LLD}'
.  endif

MAKEFILE=	GNUmakefile
#MAKE_ENV+=	GNUSTEP_CONFIG_FILE=${PORTSDIR}/devel/ngstep-make/files/GNUstep.conf
GNU_CONFIGURE_PREFIX=	${GNUSTEP_PREFIX}

.  if ${MACHINE_ARCH} == "i386"
GNU_ARCH=	ix86
.  else
GNU_ARCH=	${MACHINE_ARCH}
.  endif

PLIST_SUB+=	GNU_ARCH=${GNU_ARCH} VERSION=${PORTVERSION}
PLIST_SUB+=	MAJORVERSION=${PORTVERSION:C/([0-9]).*/\1/1}
PLIST_SUB+=	LIBVERSION=${DEFAULT_LIBVERSION}
PLIST_SUB+=	MAJORLIBVERSION=${DEFAULT_LIBVERSION:C/([0-9]).*/\1/1}

.  if defined(USE_NGSTEP)
.    if ${USE_NGSTEP:Mbase}
LIB_DEPENDS+=	libgnustep-base.so:lang/ngstep-base
.    endif

.    if ${USE_NGSTEP:Mbuild}
PATH:=	${GNUSTEP_SYSTEM_TOOLS}:${GNUSTEP_LOCAL_TOOLS}:${PATH}
MAKE_ENV+=	PATH="${PATH}" GNUSTEP_MAKEFILES="${GNUSTEP_MAKEFILES}"
# All GNUstep things installed from ports should be in the System domain.
# Things installed from source can then freely live in the Local domain without
# conflicts.
MAKE_ENV+=	GNUSTEP_INSTALLATION_DOMAIN=SYSTEM
CONFIGURE_ENV+=	PATH="${PATH}" GNUSTEP_MAKEFILES="${GNUSTEP_MAKEFILES}"
BUILD_DEPENDS+=	ngstep-make>0:devel/ngstep-make
.include "${USESDIR}/objc.mk"
.    endif

.    if ${USE_NGSTEP:Mgui}
LIB_DEPENDS+=	libgnustep-gui.so:x11-toolkits/ngstep-gui
.    endif

.    if ${USE_NGSTEP:Mback}
BUILD_DEPENDS+=	ngstep-back>0:x11-toolkits/ngstep-back
RUN_DEPENDS+=	ngstep-back>0:x11-toolkits/ngstep-back
.    endif

.  endif

.endif
