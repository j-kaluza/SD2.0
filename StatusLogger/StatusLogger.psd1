@{
    RootModule        = 'StatusLogger.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'a5e20a60-49da-4dce-9bb3-32e916213c11'
    Author            = 'Jerôme Kaluza'
    CompanyName       = 'Croix-Rouge de Belgique'
    Description       = 'Logger avancé en classe PS5+ avec JSON, pipeline, niveaux globaux, rotation et NerdFonts.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @('Write-Status')
    CmdletsToExport   = @()
    VariablesToExport = '*'
    AliasesToExport   = '*'
    DscResourcesToExport = @()
}