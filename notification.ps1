[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon
$objNotifyIcon.Icon = "C:\Program Files (x86)\Zim Desktop Wiki\zim.ico"
$objNotifyIcon.BalloonTipIcon = "Info"
$objNotifyIcon.BalloonTipText = "Proceso completado"
$objNotifyIcon.BalloonTipTitle = "Async Run"
$objNotifyIcon.Visible = $True
$objNotifyIcon.ShowBalloonTip(10000)
[void][System.Threading.Thread]::Sleep(10000)
$objNotifyIcon.Dispose()
