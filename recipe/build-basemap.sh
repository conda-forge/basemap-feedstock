#! /bin/bash

echo "========================================================================"
echo "Building ${PKG_NAME}"
echo ""

# Ensure our GEOS will be used.
export GEOS_DIR="${PREFIX}"

# Temporary workaround when cross-compiling.
# if [ "${CONDA_BUILD_CROSS_COMPILATION}" = "1" -a "${PKG_NAME}" = "basemap" ]; then
#     rm ${BUILD_PREFIX}/bin/python
#     ln -sf ${PREFIX}/bin/python ${BUILD_PREFIX}/bin/python
# fi

case "${PKG_NAME}" in
    basemap)
        # rm -f packages/basemap/pyproject.toml
        ${PYTHON} -m pip install --no-deps --ignore-installed -vvv packages/basemap
    ;;
    basemap-data)
        ${PYTHON} -m pip install --no-deps --ignore-installed -vvv packages/basemap_data
    ;;
    basemap-data-hires)
        ${PYTHON} -m pip install --no-deps --ignore-installed -vvv packages/basemap_data_hires
    ;;
    *)
        echo "No build instructions for ${PKG_NAME}"
        exit 1
    ;;
esac
