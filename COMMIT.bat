@ECHO off

@REM todo : get dynamically
SET version=1.0.1

SET /p msg=Commit message for version %version%:

git pull

git add .

git commit -m "%msg%"

git push

git tag -d %version%

git push origin :refs/tags/%version%

git tag -a %version% -m "version %version%"

git push origin %version%