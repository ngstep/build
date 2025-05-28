POUDRIERE_ETC= /zroot/ngstep-build/etc
SCRIPT_DIR= ${.CURDIR}
FUNCS= ${SCRIPT_DIR}/functions.sh

.SUFFIXES:
.SILENT:

ports:
	@sh -c ". ${FUNCS}; ports_target"

install:
	@sh -c ". ${FUNCS}; install_target"

iso:
	@sh -c ". ${FUNCS}; iso_target"

clean:
	@sh -c ". ${FUNCS}; clean_zfs"
