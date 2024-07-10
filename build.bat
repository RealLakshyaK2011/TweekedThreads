@echo off

set BuildProgram="Ninja"

cmake -G %BuildProgram% -B build

echo.
echo.
echo.
echo.
echo =========================Building with %BuildProgram% Builder=========================

cmake --build build