@echo off

SET url=https://planning-XXXXXXX.pbcs.us2.oraclecloud.com
SET domain=XXXXXXX
SET user=XXX@XX.com
SET password="C:\XXXXXX\encrypt.epw"
SET NumberOfBackups=10
SET SnapshotName=Artifact Snapshot

rem EPM Automate commands
::CD /D %~dp0

call epmautomate login %user% %password% %url% %domain%
IF %ERRORLEVEL% NEQ 0 goto :ERROR

call epmautomate downloadfile "%SnapshotName%"
IF %ERRORLEVEL% NEQ 0 goto :ERROR

call epmautomate logout
IF %ERRORLEVEL% NEQ 0 goto :ERROR

move /y *.zip "C:\Oracle\EPM Automate\Application Snapshot\Archive"
move /y *.log "C:\Oracle\EPM Automate\Application Snapshot\Logs"

Set Timestamp=%date:~4,2%_%date:~7,2%_%date:~10,4%_%time:~1,1%%time:~3,2%%
ren "C:\Oracle\EPM Automate\Application Snapshot\Archive\%SnapshotName%.zip" "%SnapshotName%_%Timestamp%.zip"

SET Count=0
FOR %%A IN ("C:\Oracle\EPM Automate\Application Snapshot\Archive\%SnapshotName%*.*") DO SET /A Count += 1
IF %Count% gtr %NumberOfBackups% FOR %%A IN ("C:\Oracle\EPM Automate\Application Snapshot\Archive\%SnapshotName%*.*") DO del "%%A" && GOTO EOF

:EOF

echo Scheduled Task Completed successfully
exit /b %errorlevel%
:ERROR

echo Failed with error #%errorlevel%.
exit /b %errorlevel%


