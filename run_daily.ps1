$env:PYTHONUTF8 = '1'
$PYTHON = 'C:\Users\natashdantas\AppData\Local\Programs\Python\Python312\python.exe'
$DIR    = 'C:\Users\natashdantas\Documents\nps-dashboard'
$LOG    = "$DIR\dashboard_log.txt"

"=== DIARIO $(Get-Date) ===" >> $LOG

Set-Location $DIR

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " ATUALIZACAO DIARIA" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/2] Gerando Dashboard Newbies BR Vendedores..." -ForegroundColor Yellow
& $PYTHON "$DIR\generate_newbie_dashboard.py" *>> $LOG
if ($LASTEXITCODE -eq 0) { Write-Host "      OK" -ForegroundColor Green } else { Write-Host "      ERRO - verifique dashboard_log.txt" -ForegroundColor Red }

Write-Host "[2/2] Gerando NPS por Equipe Longtail BR..." -ForegroundColor Yellow
& $PYTHON "$DIR\generate_team_dashboard.py" *>> $LOG
if ($LASTEXITCODE -eq 0) { Write-Host "      OK" -ForegroundColor Green } else { Write-Host "      ERRO - verifique dashboard_log.txt" -ForegroundColor Red }

Write-Host ""
Write-Host "Publicando no GitHub..." -ForegroundColor Yellow
$DATA = Get-Date -Format "yyyy-MM-dd HH:mm"
git -C $DIR add newbie_dashboard.html nps_dashboard_team.html index.html 2>> $LOG
git -C $DIR commit -m "chore: atualizacao diaria $DATA" 2>> $LOG
git -C $DIR push origin HEAD 2>> $LOG
if ($LASTEXITCODE -eq 0) { Write-Host "      Publicado com sucesso!" -ForegroundColor Green } else { Write-Host "      Erro no push - verifique dashboard_log.txt" -ForegroundColor Red }

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " CONCLUIDO! Dashboards atualizados:" -ForegroundColor Cyan
Write-Host " - https://natashandantas-bit.github.io/impacto-nps-longtail/newbie_dashboard.html" -ForegroundColor White
Write-Host " - https://natashandantas-bit.github.io/impacto-nps-longtail/nps_dashboard_team.html" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

"=== FIM DIARIO $(Get-Date) ===" >> $LOG

Read-Host "Pressione Enter para fechar"
