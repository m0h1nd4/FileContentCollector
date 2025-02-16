```markdown
# Output Files PowerShell Script

This PowerShell script (`output-files.ps1`) recursively searches for files with a specified extension in a given directory and outputs each file's full path and its content. This can be combined with `Set-Clipboard` to copy the information of all files at once.

## Usage

Run the script by specifying the directory and the file extension:

```powershell
.\output-files.ps1 <DirectoryPath> <FileExtension> | Set-Clipboard
```

For example:

```powershell
.\output-files.ps1 "E:\directory\nextdir" "py" | Set-Clipboard
```

**Note:** If you provide the file extension without a dot (e.g., `py`), the script will automatically prepend a dot to match the file extension correctly.

## Features

- **Recursive Search:** The script searches through all subdirectories of the specified directory.
- **Comprehensive Output:** For every matching file, the script outputs:
    - The full file name (including its path)
    - A separator line
    - The file's content
- **Error Handling:**
    - If the specified directory does not exist, the script will report an error and exit.
    - Errors encountered when reading individual files are reported, but the script continues processing the remaining files.
- **Inline Documentation:** The script includes help comments that explain its usage and functionality.

## Requirements

- PowerShell 5.0 or later.
- Appropriate permissions to access and read files from the target directory.

## Script Execution Policy

If you encounter an error about script execution being disabled, here are two options to run the script:

### Temporarily Bypass the Execution Policy

You can run the script with a temporary bypass by launching PowerShell with the `-ExecutionPolicy Bypass` parameter. For example, from a command prompt or Run dialog:

```powershell
powershell -ExecutionPolicy Bypass -File .\output-files.ps1 D:\Programmieren\Python\portscanner "py"
```

### Change the Execution Policy Permanently (Requires Administrator Privileges)

Open an elevated PowerShell prompt (run as Administrator) and execute:

```powershell
Set-ExecutionPolicy RemoteSigned
```

This will allow you to run local scripts that are not digitally signed while still protecting against scripts downloaded from the Internet.

## 

This script is provided as-is without any warranty. Use it at your own risk.
