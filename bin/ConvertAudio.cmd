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
@TITLE ConvertVideo
echo Converting audio to Pyro compatible format....
echo(
ffmpeg.exe -i "%s" -ar 48000 -vn -c:a libvorbis -b:a 64k "%s" -loglevel quiet -stats -y