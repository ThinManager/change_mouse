<#
.Synopsis
    Change-MouseCursor.ps1
    This script makes changes to the registry to remove 
        the default 'Aero Mouse Pointer' settings and 
        change it to the 'Windows Black Mouse Pointer' settings.
#>
Param (
    # Check - output what the current settings are
    [Parameter(Mandatory = $false)]
    [switch]
    $Check,
    # Change - apply registry changes to use the 'Windows Black Mouse Pointer'
    [Parameter(Mandatory = $false)]
    [switch]
    $Change,
    # Default - revert to the default settings of Windows 2016 entries as captured from a new server
    [Parameter(Mandatory = $false)]
    [switch]
    $Default
)


########################################
# Functions
# --------------------------------------

Function Check-Status {
    # Write the current status of the machine to console
    if (((Get-ItemPropertyValue -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Desktop' -Name 'UserPreferencesMask' -ea SilentlyContinue) -join ',') -eq (([byte[]](0x9e, 0x3e, 0x03, 0x80, 0x12, 0x00, 0x00, 0x00)) -join ',')) {  
        Write-Host "Desktop Defaults are set."
    } 
    else { 
        Write-Host "Desktop settings are modified."
    }

    if (
        (Get-ItemPropertyValue -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name '(default)' -ea SilentlyContinue) -eq 'Windows Black (large)'
    ) {
        Write-Host "Cursor is set to Windows Black."
    } 
    else {
        Write-Host "Cursor is set to Default Aero."
    }

    return
}

Function Restore-Cursor {
    # 
    if ((Test-Path -LiteralPath "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors") -ne $true) {  
        New-Item "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors" -force -ea SilentlyContinue | Out-Null
    }
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name '(default)' -Value '@main.cpl,-1020' -PropertyType String -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'AppStarting' -Value '%SystemRoot%\cursors\aero_working.ani' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Arrow' -Value '%SystemRoot%\cursors\aero_arrow.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Crosshair' -Value '' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Hand' -Value '%SystemRoot%\cursors\aero_link.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Help' -Value '%SystemRoot%\cursors\aero_helpsel.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'IBeam' -Value '' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'No' -Value '%SystemRoot%\cursors\aero_unavail.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'NWPen' -Value '%SystemRoot%\cursors\aero_pen.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Scheme Source' -Value 2 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'SizeAll' -Value '%SystemRoot%\cursors\aero_move.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'SizeNESW' -Value '%SystemRoot%\cursors\aero_nesw.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'SizeNS' -Value '%SystemRoot%\cursors\aero_ns.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'SizeNWSE' -Value '%SystemRoot%\cursors\aero_nwse.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'SizeWE' -Value '%SystemRoot%\cursors\aero_ew.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'UpArrow' -Value '%SystemRoot%\cursors\aero_up.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Wait' -Value '%SystemRoot%\cursors\aero_busy.ani' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null

    return
}

Function Update-Cursor {
    if ((Test-Path -LiteralPath "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors") -ne $true) {  
        New-Item "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors" -Force -ErrorAction SilentlyContinue | Out-Null
    }

    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'AppStarting' -Value '%SystemRoot%\cursors\wait_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Arrow' -Value '%SystemRoot%\cursors\arrow_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'ContactVisualization' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Crosshair' -Value '%SystemRoot%\cursors\cross_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'GestureVisualization' -Value 31 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Hand' -Value '' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Help' -Value '%SystemRoot%\cursors\help_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'IBeam' -Value '%SystemRoot%\cursors\beam_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'No' -Value '%SystemRoot%\cursors\no_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'NWPen' -Value '%SystemRoot%\cursors\pen_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Scheme Source' -Value 2 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'SizeAll' -Value '%SystemRoot%\cursors\move_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'SizeNESW' -Value '%SystemRoot%\cursors\size1_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'SizeNS' -Value '%SystemRoot%\cursors\size4_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'SizeNWSE' -Value '%SystemRoot%\cursors\size2_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'SizeWE' -Value '%SystemRoot%\cursors\size3_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'UpArrow' -Value '%SystemRoot%\cursors\up_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name 'Wait' -Value '%SystemRoot%\cursors\busy_rm.cur' -PropertyType ExpandString -Force -ea SilentlyContinue | Out-Null
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Cursors' -Name '(default)' -Value 'Windows Black (large)' -PropertyType String -Force -ea SilentlyContinue | Out-Null

    return
}


Function Restore-Desktop {
    if ((Test-Path -LiteralPath "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Desktop") -ne $true) {  
        New-Item "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Desktop" -force -ea SilentlyContinue  | Out-Null
    }

    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Desktop' -Name 'UserPreferencesMask' -Value ([byte[]](0x9e, 0x3e, 0x03, 0x80, 0x12, 0x00, 0x00, 0x00)) -PropertyType Binary -Force -ea SilentlyContinue | Out-Null

    return
}


Function Update-Desktop {
    if ((Test-Path -LiteralPath "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Desktop") -ne $true) {  
        New-Item "Registry::\HKEY_USERS\.DEFAULT\Control Panel\Desktop" -force -ea SilentlyContinue  | Out-Null
    }

    # This value turns off:
    #   * Slide open combo box
    #   * Fade or slide menus into view
    #   * Show shadows under mouse pointer
    #   * Fade or slide tooltips into view
    #   * Fade out menu items after clicking
    #   * Show shadows under windows
    #
    # default is 9e 3e 03 80 12 00 00 00
    New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\.DEFAULT\Control Panel\Desktop' -Name 'UserPreferencesMask' -Value ([byte[]](0x90, 0x12, 0x03, 0x80, 0x12, 0x00, 0x00, 0x00)) -PropertyType Binary -Force -ea SilentlyContinue | Out-Null

    return
}


########################################
# Main Program
# --------------------------------------

# Check if any switches were passed
$parmCount = 0
$parmCount = $parmCount + [int]($Check -eq $true)
$parmCount = $parmCount + [int]($Change -eq $true)
$parmCount = $parmCount + [int]($Default -eq $true)

if ($parmCount -ne 1) {
    # No switches were passed
    Write-Host "Please select only 1 option:"
    Write-Host "  -Check : Check the active settings"
    Write-Host "  -Change : Change to Windows Black Mouse Pointer"
    Write-Host "  -Default : Revert settings to Default"

}
else {
  
    Write-Host "Beginning process..."

    if ($Check) {
        Write-Host "Checking current system status..."
        Write-Host ""
        
        Check-Status
    }

    if ($Change) {
        Write-Host "Changing system to use Windows Black Mouse Pointer..."
        Write-Host ""
        Update-Desktop
        Update-Cursor

        Check-Status
    }

    if ($Default) {
        Write-Host "Reverting system to default Windows Aero Mouse Pointer..."
        Write-Host ""
        Restore-Desktop
        Restore-Cursor

        Check-Status
    }
}

Write-Host ""
Write-Host "Exiting."
Write-Host ""

exit

# End of script