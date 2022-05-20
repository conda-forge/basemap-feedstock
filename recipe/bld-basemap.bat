ECHO "===================================================================================================="
ECHO "Building %PKG_NAME%"
ECHO ""

:: Ensure our geos will be used.
set GEOS_DIR=%LIBRARY_PREFIX%

:: Jump to the correct build section
if "%PKG_NAME%"=="basemap" GOTO CASE_basemap
if "%PKG_NAME%"=="basemap-data" GOTO CASE_basemap_data
if "%PKG_NAME%"=="tmp-basemap-data-hires" GOTO CASE_basemap_data_hires

ECHO "Unknown package: %PKG_NAME%"
EXIT 1


:CASE_basemap
  "%PYTHON%" -m pip install packages\basemap --no-deps --ignore-installed  -vvv
  IF errorlevel 1 EXIT 1
  GOTO CASE_end

:CASE_basemap_data
  "%PYTHON%" -m pip install packages\basemap_data --no-deps --ignore-installed  -vvv
  IF errorlevel 1 EXIT 1
  GOTO CASE_end

:CASE_basemap_data_hires
  "%PYTHON%" -m pip install packages\basemap_data_hires --no-deps --ignore-installed  -vvv
  IF errorlevel 1 EXIT 1
  GOTO CASE_end


:CASE_END
