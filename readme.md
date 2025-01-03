# Base C Project for DOS
A simple base project for writing C programs for DOS.  Running the build.ps1 PowerShell Script will compile all of the C files in the src/ directory and output an exe (program.exe) in the bin/ directory that can be ran in DOS.  The .gitignore file is already set up to ignore the bin/, obj/, and .vscode/ directories.

## Requirements
- Installation of OpenWatcom (for compiling for DOS)
    - Build script targets "C:\WATCOM" by default
- PowerShell Scripts enabled (for building)