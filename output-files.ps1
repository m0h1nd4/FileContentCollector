<#
.SYNOPSIS
    Recursively outputs the full file name and content of files matching a given extension.

.DESCRIPTION
    This script searches the specified directory (and its subdirectories) for files with the given extension.
    For each file found, it outputs the file's full path and then its content.
    This is useful for piping the output to Set-Clipboard so that you can copy all file information in one go.

.PARAMETER Path
    The root directory to search in. Must be a valid directory path.

.PARAMETER Extension
    The file extension to search for. You can provide it with or without a leading dot.
    Example: "py" or ".py"

.EXAMPLE
    .\output-files.ps1 "E:\directory\nextdir" "py" | Set-Clipboard

    This command will search for all files ending with ".py" under E:\directory\nextdir (including subdirectories)
    and copy their full path and content to the clipboard.

.NOTES
    Author: m0h1nd4
    Date: 2025-02-16
    Version: 1.0
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Provide the directory path to search in.")]
    [string]$Path,

    [Parameter(Mandatory = $true, Position = 1, HelpMessage = "Provide the file extension (e.g., 'py' or '.py').")]
    [string]$Extension
)

# Check if the provided directory exists
if (-not (Test-Path -Path $Path -PathType Container)) {
    Write-Error "The directory '$Path' does not exist."
    exit 1
}

# Ensure the extension starts with a dot
if ($Extension[0] -ne '.') {
    $Extension = '.' + $Extension
}

try {
    # Retrieve all files recursively matching the extension
    $files = Get-ChildItem -Path $Path -Recurse -File -Filter "*$Extension" -ErrorAction Stop
}
catch {
    Write-Error "Failed to retrieve files from '$Path'. Error details: $_"
    exit 1
}

# Check if any files were found
if ($files.Count -eq 0) {
    Write-Output "No files with the extension '$Extension' were found in '$Path'."
    exit 0
}

# Loop through each file and output the file name and its content
foreach ($file in $files) {
    Write-Output "File name: $($file.FullName)"
    Write-Output "--------------------------------------"
    try {
        # Output the content of the file
        Get-Content -Path $file.FullName -ErrorAction Stop | ForEach-Object { Write-Output $_ }
    }
    catch {
        Write-Error "Error reading file '$($file.FullName)'. Error details: $_"
    }
    # Add a blank line to separate output between files
    Write-Output ""
}
