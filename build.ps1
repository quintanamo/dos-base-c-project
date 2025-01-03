# Set up OpenWatcom environment variables
$env:WATCOM = "C:\WATCOM"
$env:PATH = "$env:WATCOM\binnt;$env:WATCOM\binw;$env:PATH"
$env:INCLUDE = "$env:WATCOM\h;$env:WATCOM\h\dos"
$env:LIB = "$env:WATCOM\lib386;$env:WATCOM\lib386\dos"

# Create bin and obj folders if they do not exist
if (-not (Test-Path "./bin")) {
    New-Item "./bin" -ItemType Directory
}
if (-not (Test-Path "./obj")) {
    New-Item "./obj" -ItemType Directory
}

# Locate all .c files in the src folder
$sourceFolder = ".\src" # Folder containing your source files
$outputFolder = ".\bin" # Desired output folder
$outputFileName = "program.exe" # Desired output file name
$objFolder = ".\obj" # Folder for .obj files

# Get all .c files in the source folder
$sourceFiles = Get-ChildItem -Path $sourceFolder -Filter *.c | ForEach-Object { $_.FullName }

if (-not $sourceFiles) {
    Write-Host "No .c files found in $sourceFolder. Exiting."
    exit
}

# Create the compile command
# List all .c files separated by spaces
$sourceFileList = $sourceFiles -join " "
$compileCommand = "wcl -bt=dos $sourceFileList"

# Execute the compile command
Write-Host "Compiling the following source files for DOS:"
$sourceFiles | ForEach-Object { Write-Host $_ }
Invoke-Expression $compileCommand

# Identify and handle the output executable
$potentialExecutables = Get-ChildItem -Path "." -Filter *.exe
if ($potentialExecutables.Count -eq 1) {
    # Single executable file found
    $generatedExe = $potentialExecutables[0].FullName
    Move-Item -Path $generatedExe -Destination (Join-Path -Path $outputFolder -ChildPath $outputFileName) -Force
    Write-Host "Compilation successful. Output moved to: $(Join-Path -Path $outputFolder -ChildPath $outputFileName)"
} elseif ($potentialExecutables.Count -gt 1) {
    Write-Host "Multiple .exe files detected. Unable to determine which is the output file."
} else {
    Write-Host "Compilation failed. No executable file found."
}

# Move all .obj files to the obj folder
$objFiles = Get-ChildItem -Path "." -Filter *.obj
if ($objFiles) {
    Write-Host "Moving .obj files to $objFolder..."
    foreach ($objFile in $objFiles) {
        Move-Item -Path $objFile.FullName -Destination $objFolder -Force
    }
    Write-Host "All .obj files moved successfully."
}
