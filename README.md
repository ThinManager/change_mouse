# change_mouse
A script to change the mouse courser on an RDP session on a Windows RDS server. This is useful since mouse settings in Windows are made on a per-user basis.

## Usage

The code can be ran as a login script or similar so that the registry entries are changed to “Windows Black (Large)”.
 
## Console Output

```
PS C:\Projects\Change-MouseCursor> .\Change-MouseCursor.ps1

Please select only 1 option:
  -Check : Check the active settings
  -Change : Change to Windows Black Mouse Pointer
  -Default : Revert settings to Default
 
Exiting.
```
