<p align="center">
    <img src="StatusLogger.png" width="200" />
</p>
# StatusLogger 🔥
Module PowerShell avancé pour logs professionnels

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell)
![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-success)
![StatusLogger](https://img.shields.io/badge/StatusLogger-v1.0.0-purple)
![StatusLogger Logo](https://github.com/j-kaluza/SD2.0/main/StatusLogger/logo.png)

`StatusLogger` est un module PowerShell avancé basé sur une **classe PowerShell v5+**, conçu pour fournir un système de logging complet, clair, lisible et robuste.

Il inclut :

✅ Icônes Unicode ou NerdFonts  
✅ Couleurs automatiques selon le niveau  
✅ Verbose / Debug / Silent  
✅ Logging dans fichiers texte ou JSON  
✅ Rotation automatique des logs  
✅ Pipeline support  
✅ Niveaux configurables globalement  
✅ Format JSON compatible SIEM  
✅ Module propre, basé sur classes  
✅ Compatible PowerShell 5.1 & 7+  

---

# 📦 Installation

## ✅ 1. Installation automatique (recommandée)

Le script ci-dessous crée le module dans :

📁 `Documents\PowerShell\Modules\StatusLogger`

```powershell
$ModulePath = "$HOME\Documents\PowerShell\Modules\StatusLogger"

if (-not (Test-Path $ModulePath)) {
    New-Item -ItemType Directory -Path $ModulePath | Out-Null
}

Invoke-WebRequest `
    -Uri "https://raw.githubusercontent.com/j-kaluza/SD2.0/main/StatusLogger/StatusLogger.psm1" `
    -OutFile "$ModulePath\StatusLogger.psm1"

Invoke-WebRequest `
    -Uri "https://raw.githubusercontent.com/j-kaluza/SD2.0/main/StatusLogger/StatusLogger.psd1" `
    -OutFile "$ModulePath\StatusLogger.psd1"

Import-Module StatusLogger -Force

Write-Host "✅ Module StatusLogger installé et chargé !" -ForegroundColor Green

## ✅ 2. Installation manuelle
Télécharger :
* https://raw.githubusercontent.com/j-kaluza/SD2.0/main/StatusLogger/StatusLogger.psm1
* https://raw.githubusercontent.com/j-kaluza/SD2.0/main/StatusLogger/StatusLogger.psd1

Puis placer les fichiers dans C:\Users\<Vous>\Documents\PowerShell\Modules\StatusLogger\ et lancer la commande Import-Module StatusLogger
