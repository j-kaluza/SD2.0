<p align="center">
    <img src="https://github.com/j-kaluza/SD2.0/blob/main/StatusLogger/logo.png" width="200" />
</p>
# StatusLogger 🔥
Module PowerShell avancé pour logs avancés

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell)
![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-success)
![StatusLogger](https://img.shields.io/badge/StatusLogger-v1.0.0-purple)
![Terminal](https://img.shields.io/badge/Windows-Terminal-black).
<!-- ![StatusLogger Logo](https://github.com/j-kaluza/SD2.0/blob/main/StatusLogger/logo.png) -->

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
```
## ✅ 2. Installation manuelle
Télécharger :
* https://raw.githubusercontent.com/j-kaluza/SD2.0/main/StatusLogger/StatusLogger.psm1
* https://raw.githubusercontent.com/j-kaluza/SD2.0/main/StatusLogger/StatusLogger.psd1

Puis placer les fichiers dans C:\Users\\<Vous>\Documents\PowerShell\Modules\StatusLogger\ et lancer la commande 
```Powershell
Import-Module StatusLogger
```
# 📘 Exemples d'utilisation
Voici plusieurs scénarios illustrant les capacités du module StatusLogger, du plus simple au plus avancé.

## ✅ 1. Exemple simple — Messages de statut colorés
```powershell
Write-Status "Démarrage du service OK" -Type Success
Write-Status "Échec de la connexion à la base SQL" -Type Error
Write-Status "Espace disque faible" -Type Warning
Write-Status "Chargement de la configuration..." -Type Info
```
## ✅ 2. Icônes NerdFonts
```powershell
:UseNerdFont = $true
Write-Status "Compilation terminée" -Type Success
```
## ✅ 3. Pipeline support
```powershell
"Étape 1","Étape 2","Étape 3" | Write-Status -Type Info
```
## ✅ 4. Logging + rotation automatique
```powershell
:SetLogFile("C:\Logs\deploy.log")
Write-Status "Déploiement démarré" -Type Info
```
## ✅ 5. Mode JSON pour SIEM / ELK / Splunk
```powershell
:EnableJsonMode($true)
:SetLogFile("C:\Logs\audit.json")
Write-Status "Connexion utilisateur" -Type Info
```
## ✅ 6. Niveaux globaux (filtrage automatique)
```powershell
:SetLevel("Warning")

Write-Status "Non affiché" -Type Info
Write-Status "Alerte : espace disque faible" -Type Warning
Write-Status "Erreur critique" -Type Error
```
## ✅ 7. Verbose & Debug natifs PowerShell
```powershell
Write-Status "Analyse détaillée" -Type Verbose -Verbose
Write-Status "Variable interne : X = 42" -Type Debug -Debug
```
## ✅ 8. Scénario complet
```powershell
Import-Module StatusLogger
:SetLevel("Debug")
:SetLogFile("C:\Logs\deploy.json")
:EnableJsonMode($true)
:UseNerdFont = $true

Write-Status "Initialisation…" -Type Info
try {
    Write-Status "Téléchargement en cours…" -Type Verbose -Verbose
    Write-Status "Fichiers récupérés" -Type Success

    Start-Service "MonService" -ErrorAction Stop
    Write-Status "Service démarré avec succès" -Type Success
}
catch {
    Write-Status "Erreur : $($_.Exception.Message)" -Type Error
}

Write-Status "Fin du script" -Type Info
```
## ✅ 9. Logging silencieux
```powershell
Write-Status "Log invisible mais écrit dans le fichier" -Type Silent
```
# 🧩 Architecture du module
```
SD2.0/
 └── StatusLogger/
       ├── StatusLogger.psm1
       ├── StatusLogger.psd1
       └── logo.png
```

# ✅ Compatibilité

|Fonction               |Support |
|----------------------|:--------:|
|Windows PowerShell 5.1 |✅ |
|PowerShell 7+ (Core) |✅ | 
|Windows Terminal |✅ | 
|Linux/macOS |✅ |
|Unicode / Emojis |✅ |
|NerdFonts |✅ |
|JSON SIEM |✅ |
|Rotation logs |✅ |
|Pipeline |✅  |

# ✅ Licence
Utilisation libre.

# ✨ Auteur
Développé par Jerome Kaluza
