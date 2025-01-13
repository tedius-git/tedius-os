# Inicializar módulos y variables de entorno de manera más eficiente
$ErrorActionPreference = 'SilentlyContinue'

# Configuración FZF - Movida al inicio para evitar retrasos en la configuración del entorno
$env:FZF_DEFAULT_OPTS="--color=fg:#cdd6f4,bg:-1,hl:#f5c2e7,fg+:#f5e0dc,bg+:-1,hl+:#f5c2e7,info:#89b4fa,prompt:#f5c2e7,pointer:#f38ba8,marker:#f38ba8,spinner:#f38ba8,header:#89b4fa"

# Inicializar módulos críticos primero
$modules = @(
    @{Name='Terminal-Icons'; Command={Import-Module Terminal-Icons}}
)

# Función para cargar módulos de manera asíncrona
function Initialize-ModulesAsync {
    foreach ($module in $modules) {
        Start-Job -ScriptBlock $module.Command | Out-Null
    }
}

function Invoke-Starship-TransientFunction {
  &starship module character
}

Invoke-Expression (&starship init powershell)

Enable-TransientPrompt

$ENV:STARSHIP_CONFIG = "$HOME\.starship\typecraft.toml"

$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

# Configuración de PSReadLine
Set-PSReadLineKeyHandler -Chord "Ctrl+n" -Function ForwardWord
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# Configuración de búsqueda inversa con FZF
Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    
    $history = Get-Content (Get-PSReadLineOption).HistorySavePath -ErrorAction SilentlyContinue
    if ($history) {
        $command = $history | Select-Object -Unique | 
                   Where-Object { $_ -ne '' } |
                   Sort-Object -Unique |
                   fzf --height 40% --reverse --query "$line"
        
        if ($command) {
            [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
        }
    }
}

# Inicializar zoxide
Invoke-Expression (& {
    $script = (zoxide init --cmd cd powershell)
    if ($script) { $script | Out-String }
})

# Remover alias ls de manera segura
if (Test-Path Alias:ls) {
    Remove-Item Alias:ls -Force
}

# Definir funciones de manera más eficiente
function ls { eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions }
function vim { nvim $args }
Set-Alias cat bat
Set-Alias debian wsl --distribution debian --user tedius

# Función zim optimizada
function zim {
    param([Parameter(ValueFromRemainingArguments=$true)][string[]]$query)
    
    $dir = if ($query) {
        zoxide query $query
    } else {
        $selected = zoxide query -l | Out-String | fzf --preview 'eza --tree --level=1 --color=always {}'
        if ($selected) { $selected.Trim() }
    }
    
    if ($dir) {
        Set-Location $dir
        nvim .
    }
}

# Función fim simplificada
function fim {
    $file = fzf --preview="bat --color=always {}"
    if ($file) { nvim $file }
}

# Función batview optimizada
function batview {
    param([string]$file)
    if (-not $file) { $file = fzf }
    bat $file
}

# Función y optimizada
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    try {
        yazi $args --cwd-file="$tmp"
        $cwd = Get-Content -Path $tmp
        if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
            Set-Location -LiteralPath $cwd
        }
    }
    finally {
        Remove-Item -Path $tmp -ErrorAction SilentlyContinue
    }
}

# Función para typst
function run-typ {
    param ([Parameter(Mandatory=$true)][string]$FileName)
    
    if (-not (Test-Path $FileName) -or $FileName -notmatch "\.typ$") {
        Write-Error "Archivo no encontrado o extensión incorrecta."
        return
    }
    
    typst compile $FileName
    $pdfProcess = Start-Process "$([System.IO.Path]::GetFileNameWithoutExtension($FileName)).pdf" -PassThru
    
    try {
        typst watch $FileName
    }
    finally {
        if (!$pdfProcess.HasExited) {
            Stop-Process $pdfProcess.Id -Force
        }
    }
}

# Alias simple para fastfetch
function ff { fastfetch }

# Iniciar carga de módulos en segundo plano
Initialize-ModulesAsync
