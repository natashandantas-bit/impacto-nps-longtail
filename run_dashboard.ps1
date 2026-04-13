$env:PYTHONUTF8 = '1'
$PYTHON = 'C:\Users\natashdantas\AppData\Local\Programs\Python\Python312\python.exe'
$GIT    = 'C:\Users\natashdantas\AppData\Local\Programs\Git\bin\git.exe'
$DIR    = 'C:\Users\natashdantas\Documents\nps-dashboard'
$LOG    = "$DIR\dashboard_log.txt"

"=== $(Get-Date) ===" >> $LOG

Set-Location $DIR

Write-Host "Gerando dashboard newbies..."
& $PYTHON "$DIR\generate_newbie_dashboard.py" *>> $LOG

Write-Host "Gerando dashboard segmentos..."
& $PYTHON "$DIR\generate_segment_dashboard.py" *>> $LOG

Write-Host "Gerando dashboard longtail consolidado..."
& $PYTHON "$DIR\generate_longtail_dashboard.py" *>> $LOG

Write-Host "Gerando dashboard por equipe..."
& $PYTHON "$DIR\generate_team_dashboard.py" *>> $LOG

Write-Host "Publicando no GitHub..."
& $GIT -C $DIR add newbie_dashboard.html nps_segment_dashboard.html nps_dashboard_longtail.html nps_dashboard_team.html *>> $LOG
& $GIT -C $DIR commit -m "Dashboards atualizados - $(Get-Date -Format 'dd/MM/yyyy HH:mm')" *>> $LOG
& $GIT -C $DIR push *>> $LOG

Write-Host "Concluido! Verifique dashboard_log.txt para detalhes."
"=== FIM $(Get-Date) ===" >> $LOG
