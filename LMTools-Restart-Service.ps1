# Ajusta estas rutas/valores
$lmutil = "C:\FlexLM\lmutil.exe"
$licFile = "C:\FlexLM\license.lic"
$service = "Flexlm Service 1"

function Test-LicenseServerUp {
    param(
        [string]$Lmutil,
        [string]$LicFile
    )

    try {
        $out = & $Lmutil lmstat -a -c $LicFile 2>&1 | Out-String
        return ($LASTEXITCODE -eq 0 -and $out -match "license server UP|Users of|Vendor daemon status")
    }
    catch {
        Write-Verbose "Error comprobando el estado del servidor de licencias: $_"
        return $false
    }
}

try {
    Write-Host "1) Deteniendo servidor de licencias (lmdown forzado)..."
    & $lmutil lmdown -c $licFile -q -force

    Write-Host "2) Esperando a que realmente caiga..."
    $timeout = (Get-Date).AddMinutes(2)
    do {
        Start-Sleep -Seconds 2
        $up = Test-LicenseServerUp -Lmutil $lmutil -LicFile $licFile
    } while ($up -and (Get-Date) -lt $timeout)

    if ($up) {
        throw "El servidor no terminó de parar dentro del tiempo esperado."
    }

    Write-Host "3) Arrancando servicio Windows... ($service)"
    Start-Service -Name $service

    Write-Host "4) Esperando a que levante..."
    $timeout = (Get-Date).AddMinutes(2)
    do {
        Start-Sleep -Seconds 2
        $up = Test-LicenseServerUp -Lmutil $lmutil -LicFile $licFile
    } while (-not $up -and (Get-Date) -lt $timeout)

    if (-not $up) {
        throw "El servidor no arrancó correctamente dentro del tiempo esperado."
    }

    Write-Host "5) Reread license file..."
    & $lmutil lmreread -c $licFile

    Write-Host "6) Status query final..."
    & $lmutil lmstat -a -c $licFile

    Write-Host "Operación completada correctamente." -ForegroundColor Green
}
catch {
    Write-Host "ERROR: $_" -ForegroundColor Red
    exit 1
}