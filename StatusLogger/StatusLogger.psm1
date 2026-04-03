# ================================
# MODULE COMPLET StatusLogger.psm1
# ================================

class StatusLogger {

    static [string] $GlobalLevel = "Info"       # Default
    static [string] $LogFile = $null
    static [int]    $MaxLogSizeMB = 5
    static [bool]   $UseNerdFont = $false
    static [bool]   $JsonMode = $false

    StatusLogger () {}

    static [void] SetLevel([string]$Level) {
        $valid = "Silent","Error","Warning","Info","Debug","Verbose"
        if ($valid -notcontains $Level) {
            throw "Niveau invalide. Utilise : $($valid -join ', ')"
        }
        [StatusLogger]::GlobalLevel = $Level
    }

    static [void] SetLogFile([string]$Path) {
        [StatusLogger]::LogFile = $Path
    }

    static [void] EnableJsonMode([bool]$On) {
        [StatusLogger]::JsonMode = $On
    }

    static [bool] ShouldLog([string]$Type) {
        $order = @{
            Silent  = 0
            Error   = 1
            Warning = 2
            Info    = 3
            Debug   = 4
            Verbose = 5
        }
        return $order[$Type] -le $order[[StatusLogger]::GlobalLevel]
    }

    static [string] GetIcon([string]$Type) {

        if ([StatusLogger]::UseNerdFont) {
            $icons = @{
                Success = ""
                Error   = ""
                Warning = ""
                Info    = ""
                Debug   = ""
                Verbose = ""
                Silent  = ""
            }
        }
        else {
            $icons = @{
                Success = "✅"
                Error   = "❌"
                Warning = "⚠️"
                Info    = "ℹ️"
                Debug   = "🐞"
                Verbose = "🔍"
                Silent  = ""
            }
        }

        return $icons[$Type]
    }

    static [string] GetColor([string]$Type) {
        $colors = @{
            Success = "Green"
            Error   = "Red"
            Warning = "Yellow"
            Info    = "Cyan"
            Debug   = "Magenta"
            Verbose = "Gray"
            Silent  = "White"
        }

        return $colors[$Type]
    }

    static [string] ToJson([string]$Type, [string]$Message) {
        return @{
            timestamp = (Get-Date).ToString("o")
            type      = $Type
            message   = $Message
            hostname  = $env:COMPUTERNAME
        } | ConvertTo-Json -Compress
    }

    static [void] RotateLogs([string]$Path) {
        if (Test-Path $Path) {
            $sizeMB = (Get-Item $Path).Length / 1MB
            if ($sizeMB -ge [StatusLogger]::MaxLogSizeMB) {
                Move-Item $Path "$Path.bak" -Force
            }
        }
    }

    static [void] Write(
        [string]$Type,
        [string]$Message
    ) {

        if (-not [StatusLogger]::ShouldLog($Type)) {
            return
        }

        $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        $icon  = [StatusLogger]::GetIcon($Type)
        $color = [StatusLogger]::GetColor($Type)

        if ([StatusLogger]::JsonMode) {
            $formatted = [StatusLogger]::ToJson($Type, $Message)
        }
        else {
            $formatted = "$timestamp [$Type] $icon $Message"
        }

        # Sortie PowerShell
        switch ($Type) {
            "Verbose" { Write-Verbose $formatted }
            "Debug"   { Write-Debug   $formatted }
            "Silent"  { return }
            default   { Write-Host $formatted -ForegroundColor $color }
        }

        # Logging fichier
        if ([StatusLogger]::LogFile) {

            $dir = Split-Path [StatusLogger]::LogFile
            if (-not (Test-Path $dir)) {
                New-Item -ItemType Directory -Path $dir | Out-Null
            }

            [StatusLogger]::RotateLogs([StatusLogger]::LogFile)

            Add-Content -Path [StatusLogger]::LogFile -Value $formatted
        }
    }
}


# ================================
# Wrapper Write-Status
# Pipeline compatible
# ================================
# .EXAMPLE
#   "Message 1","Message 2" | Write-Status -Type Warning
#   Affiche chaque message avec le niveau Warning et l'icône correspondante via Pipeline.
# .EXAMPLE
#  Write-Status "Démarrage OK" -Type Success
#  Affiche "Démarrage OK" avec le niveau Success et l'icône correspondante.
# .EXAMPLE
#  [StatusLogger]::SetLevel("Warning")
#  Write-Status "Info ignorée" -Type Info
#  Définit le niveau global à Warning, donc les messages de niveau Info ne seront pas affichés.
# .EXAMPLE
#  [StatusLogger]::EnableJsonMode($true)
#  Write-Status "Message JSON" -Type Info
#  Active le mode JSON, donc les messages seront formatés en JSON au lieu du format classique.
# .EXAMPLE
#  [StatusLogger]::SetLogFile("C:\Logs\app.log")
#  Write-Status "Erreur survenue" -Type Error
#  ``
#  Définit un fichier de log, donc les messages seront également écrits dans ce fichier avec rotation automatique.
# .EXAMPLE
#  [StatusLogger]::UseNerdFont = $true
#  Write-Status "Action terminée" -Type Success
#  Active les icônes NerdFont, donc les messages de succès afficheront une icône différente si la police supporte les NerdFonts.
function Write-Status {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string]$Message,

        [ValidateSet("Success","Error","Warning","Info","Debug","Verbose","Silent")]
        [string]$Type = "Info"
    )
    begin {}
    process {
        [StatusLogger]::Write($Type, $Message)
    }
    end {}
}

Export-ModuleMember -Function Write-Status -Class StatusLogger