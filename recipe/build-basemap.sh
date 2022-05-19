#!/bin/bash

echo "===================================================================================================="
echo "Building $PKG_NAME"
echo ""

export GEOS_DIR=$PREFIX

case $PKG_NAME in

    basemap)
        rm -f packages/basemap/pyproject.toml
        $PYTHON -m pip install packages/basemap --no-deps --ignore-installed -vvv
        ;;

    basemap-data)
        $PYTHON -m pip install packages/basemap_data --no-deps --ignore-installed -vvv
        ;;

    basemap-data-hires)
        $PYTHON -m pip install packages/basemap_data_hires --no-deps --ignore-installed -vvv
        ;;

    *)
        echo "No build instructions for $PKG_NAME"
        exit 1
        ;;

esac
