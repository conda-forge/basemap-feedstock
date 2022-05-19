#!/bin/bash

echo "===================================================================================================="
echo "Building $PKG_NAME"
echo ""

case $PKG_NAME in

    basemap)
        rm -f packages/basemap/pyproject.toml
        python -m pip install packages/basemap --no-deps --ignore-installed -vvv
        ;;

    basemap-data)
        python -m pip install packages/basemap_data --no-deps --ignore-installed -vvv
        ;;

    basemap-data-hires)
        python -m pip install packages/basemap_data_hires --no-deps --ignore-installed -vvv
        ;;

    *)
        echo "No build instructions for $PKG_NAME"
        exit 1
        ;;

esac
