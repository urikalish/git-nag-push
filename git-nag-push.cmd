REM GitNagPush by Uri Kalish
REM This cmd file will try to pull, rebase, and push until it succeeds, while sleeping for X minutes between failed attempts.
REM Ideal for pushing to soon-to-melt frozen branches while enjoying sushi for lunch.
REM Before the first use, please configure the PERSONALIZED SETTINGS section below:

setlocal

REM ********** PERSONALIZED SETTINGS - START
set localGitRepositoryPath=C:\QC\Views\Git\mqm
set minutesToWaitBetweenAttempts=5
REM ********** PERSONALIZED SETTINGS - END

set codeVersion=1.0.5
set echoPrefix=GitNagPush:
set counter=0;
@echo off
color 0f
cls
@echo -------------------------------
@echo GitNagPush v%codeVersion% by Uri Kalish
@echo -------------------------------
echo %echoPrefix% Changing directory to %localGitRepositoryPath%...
cd %localGitRepositoryPath%
echo %echoPrefix% CD OK
echo %echoPrefix% Minutes between attempts: %minutesToWaitBetweenAttempts%
set /a secondsToWaitBetweenAttempts=minutesToWaitBetweenAttempts*60

:loopstart
@echo -------------------------------
set /a counter=counter+1
echo %echoPrefix% Attempt #%counter%

:pull
echo %echoPrefix% Attempting Pull-Rebase...
git pull --rebase
if errorlevel 1 goto pullerror
goto pullsuccess
:pullerror
echo %echoPrefix% Pull ERROR
color 0c
goto :end
:pullsuccess
echo %echoPrefix% Pull OK
:pullend

:push
echo %echoPrefix% Attempting Push...
git push
if errorlevel 1 goto pusherror
goto pushsuccess
:pusherror
echo %echoPrefix% Push ERROR
color 0e
goto :pushend
:pushsuccess
color 0a
echo %echoPrefix% Push OK
goto :end
:pushend

:wait
echo Waiting for %minutesToWaitBetweenAttempts% minutes...
ping 127.0.0.1 -n %secondsToWaitBetweenAttempts% > nul

:loopend
goto :loopstart

:end
pause
