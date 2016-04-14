REM NagPush by Uri Kalish
REM This code tries to pull-rebase-push until it succeeds, while sleeping for X seconds between failed attempts.
REM Ideal for pushing to soon-to-melt frozen branches while enjoying Sushi for lunch.
REM Please configure the PERSONALIZED SETTINGS section below:

setlocal

REM ********** PERSONALIZED SETTINGS - START
set localGitRepositoryPath=C:\QC\Views\Git\mqm
set secondsToWaitBetweenAttempts=300
REM ********** PERSONALIZED SETTINGS - END

set codeVersion=1.0.1
set echoPrefix=NagPush:
set counter=0;
@echo off
color 0f
cls
@echo ----------------------------
@echo NagPush v%codeVersion% by Uri Kalish
@echo ----------------------------
echo %echoPrefix% Changing directory to %localGitRepositoryPath%...
cd %localGitRepositoryPath%
echo %echoPrefix% CD OK

:loopstart
@echo ----------------------------
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
color 0c
goto :pushend
:pushsuccess
color 0a
echo %echoPrefix% Push OK
goto :end
:pushend

:wait
timeout /t %secondsToWaitBetweenAttempts% 

:loopend
goto :loopstart

:end
pause
