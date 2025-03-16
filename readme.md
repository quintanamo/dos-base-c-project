# Base C Project for DOS
A simple base project for writing C and C++ programs for DOS using the OpenWatcom v2 fork.  Running the build.ps1 PowerShell Script will compile all of the C files in the src/ directory on Windows.  The build.sh bash script will compile all C and C++ files in the src/ directory on Linux-based operating systems.  Both will output executables to the /bin folder.  The .gitignore file is already set up to ignore the bin/, obj/, err/, and .vscode/ directories.

## Requirements
- Installation of OpenWatcom (for compiling for DOS)
    - Powershell script targets "C:\WATCOM" by default (C only right now)
    - Bash script targets "usr/bin/watcom/ by default (C and C++)
- PowerShell Scripts enabled (for building on Windows)

## Scripts
- build.sh:  Builds all C/C++ files inside the src/ directory
- run.sh:  Runs DosBox and mounts the bin/ directory as the C: drive

### Notes
On Linux-based operating systems, you may notice Visual Studio Code giving an error for included libraries.  To fix this, add a file called "c_cpp_properties.json" inside the .vscode folder in root (create it if it doesn't exist already) and paste the following JSON into it:
```json
{
    "configurations": [
        {
            "name": "Watcom MS-DOS",
            "includePath": [
                "${workspaceFolder}/**",
                "/usr/bin/watcom/h"
            ],
            "defines": [
                "__WATCOMC__",   // Makes sure Watcom-specific macros work
                "DOS"
            ],
            "compilerPath": "/usr/bin/watcom/binl/wcc",
            "cStandard": "c89",
            "cppStandard": "c++98",
            "intelliSenseMode": "gcc-x86"
        }
    ],
    "version": 4
}
```