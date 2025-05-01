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
## Disclaimer

Rockwell Automation maintains these repositories as a convenience to you and other users. Rockwell Automation reserves the right at any time and for any reason to refuse access, to edit, or remove content from this Repository. You acknowledge and agree to accept sole responsibility and liability for any Repository content posted, transmitted, downloaded, or used by you. Rockwell Automation has no obligation to monitor or update Repository content

The examples provided are to be used as a reference for building your own application and should not be used in production as-is. It is recommended to adapt the example code based on your project/needs while observing the highest quality and safety standards.

The following list, while not inclusive, are pieces of software that require a paid license or subcription to run in production:

    ThinManager
    ThinManager Logix PinPoint
    FactoryTalk® Optix
    FactoryTalk® View SE
