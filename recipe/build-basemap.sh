#! /bin/sh

echo "======================================================================="
echo "Building ${PKG_NAME}"
echo ""

# Avoid TOML files for now.
rm -f packages/basemap/pyproject.toml

# Ensure our GEOS library will be used.
export GEOS_DIR=${PREFIX}

# Override Python if building noarch on a cross-compiling environment.
case ${PKG_NAME} in
    basemap-data|basemap-data-hires)
        if [ "${CONDA_BUILD_CROSS_COMPILATION}" = "1" ]; then
            ln -sf ${PREFIX}/bin/python ${BUILD_PREFIX}/bin/python
        fi
    ;;
esac

# Proceed based on the `basemap-split` subpackages.
case ${PKG_NAME} in
    basemap|basemap-data|basemap-data-hires)
        pkgdir="packages/$(echo ${PKG_NAME} | tr - _)"
        ${PYTHON} -m pip install -vvv --ignore-installed --no-deps ${pkgdir}
        ;;
    *)
        echo "No build instructions for ${PKG_NAME}"
        exit 1
        ;;
esac
