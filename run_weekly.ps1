$env:PYTHONUTF8 = '1'
$PYTHON = 'C:\Users\natashdantas\AppData\Local\Programs\Python\Python312\python.exe'
$DIR    = 'C:\Users\natashdantas\Documents\nps-dashboard'
$LOG    = "$DIR\dashboard_log.txt"

"=== SEMANAL $(Get-Date) ===" >> $LOG

Set-Location $DIR

Write-Host "========================================" -ForegroundColor Magenta
Write-Host " ATUALIZACAO SEMANAL" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

Write-Host "[1/2] Gerando NPS Longtail Brasil Consolidado..." -ForegroundColor Yellow
& $PYTHON "$DIR\generate_longtail_dashboard.py" *>> $LOG
if ($LASTEXITCODE -eq 0) { Write-Host "      OK" -ForegroundColor Green } else { Write-Host "      ERRO - verifique dashboard_log.txt" -ForegroundColor Red }

Write-Host "[2/2] Gerando NPS Sellers BR Comparativo por Segmento..." -ForegroundColor Yellow
& $PYTHON "$DIR\generate_segment_dashboard.py" *>> $LOG
if ($LASTEXITCODE -eq 0) { Write-Host "      OK" -ForegroundColor Green } else { Write-Host "      ERRO - verifique dashboard_log.txt" -ForegroundColor Red }

Write-Host ""
Write-Host "Publicando no Fury Object Storage..." -ForegroundColor Yellow
& $PYTHON "$DIR\upload_to_fury.py" weekly *>> $LOG
if ($LASTEXITCODE -eq 0) { Write-Host "      Publicado com sucesso!" -ForegroundColor Green } else { Write-Host "      Erro no upload - verifique dashboard_log.txt" -ForegroundColor Red }

Write-Host ""
Write-Host "========================================" -ForegroundColor Magenta
Write-Host " CONCLUIDO! Links atualizados:" -ForegroundColor Magenta
Write-Host " - nps_dashboard_longtail.html" -ForegroundColor White
Write-Host " - nps_segment_dashboard.html" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

"=== FIM SEMANAL $(Get-Date) ===" >> $LOG

Read-Host "Pressione Enter para fechar"
