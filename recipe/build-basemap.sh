#! /bin/sh

echo "======================================================================="
echo "Started ${PKG_NAME} build"
echo ""

# Avoid TOML files for now.
rm -f packages/basemap/pyproject.toml

# Ensure our GEOS library will be used.
export GEOS_DIR=${PREFIX}

# Override Python if building noarch on a cross-compiling environment.
PYTHON_ORIG="${PYTHON}"
case ${PKG_NAME} in
    basemap)
        if [ "${CONDA_BUILD_CROSS_COMPILATION}" = "1" ]; then
            export PYTHON=${PREFIX}/bin/python
        fi
    ;;
    basemap-data|basemap-data-hires)
        if [ "${CONDA_BUILD_CROSS_COMPILATION}" = "1" ]; then
            export PYTHON=${BUILD_PREFIX}/bin/python
        fi
    ;;
esac

echo "PYTHON: ${PYTHON}"
${PYTHON} -V --version
echo "BUILD_PREFIX: ${BUILD_PREFIX}"
ls -la ${BUILD_PREFIX}
echo "PREFIX: ${PREFIX}"
ls -la ${PREFIX}

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

export PYTHON="${PYTHON_ORIG}"
echo "PYTHON: ${PYTHON}"
echo "BUILD_PREFIX: ${BUILD_PREFIX}"
ls -la ${BUILD_PREFIX}
echo "PREFIX: ${PREFIX}"
ls -la ${PREFIX}

echo ""
echo "Finished ${PKG_NAME} build"
echo "======================================================================="
