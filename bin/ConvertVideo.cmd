:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                             ___                                         ::
::                            | _ \_  _ _ _ ___                            ::
::                            |  _/ || | '_/ _ \                           ::
::                            |_|  \_, |_| \___/                           ::
::                                 |__/                                    ::
::                               Game Library™                             ::
::                                                                         ::
::               Copyright © 2024-present tinyBigGAMES™ LLC                ::
::                        All Rights Reserved.                             ::
::                                                                         ::
::                  https://github.com/tinyBigGAMES/Pyro                   ::
::                                                                         ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
cd /d "%~dp0"
@TITLE ConvertAudio
echo Converting video to Pyro compatible format....
echo(
rem ffmpeg.exe -i "%1" -c:v mpeg1video -q:v 11 -b:v 11055k -b:a 384k -maxrate 22110k -bufsize 22110k -c:a mp2 -format mpeg "%2" -loglevel quiet -stats -y
rem ffmpeg -i "%1" -c:v mpeg1video -q:v 0 -c:a mp2 -format mpeg "%2" -loglevel quiet -stats -y
rem ffmpeg -i "%1" -c:v mpeg1video -q:v 11 -c:a mp2 -format mpeg "%2" -y
ffmpeg -i "%1" -c:v mpeg1video -q:v 11 -b:v 1500k -c:a mp2 -format mpeg "%2" -y

