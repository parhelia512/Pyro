{===============================================================================
  ___
 | _ \_  _ _ _ ___
 |  _/ || | '_/ _ \
 |_|  \_, |_| \___/
      |__/
   Game Library™

 Copyright © 2024-present tinyBigGAMES™ LLC
 All Rights Reserved.

 https://github.com/tinyBigGAMES/Pyro
===============================================================================}

unit UTestbed;

interface

uses
  WinApi.Windows,
  System.SysUtils,
  Pyro,
  UCommon,
  UIO,
  UWindow,
  UVideo,
  UNuklear,
  USpine,
  UAudio;

procedure RunTests();

implementation

type
  TExamples = (
    exZipFileIO01,
    exWindow01,
    exWindow02,
    exVideo01,
    exNuklear01,
    exSpine01,
    exAudio01
  );

procedure RunTests();
var
  LExample: TExamples;
begin
  try
    LExample := exZipFileIO01;

    case LExample of
      exZipFileIO01: ZipFileIO01();
      exWindow01   : Window01();
      exWindow02   : Window02();
      exVideo01    : Video01();
      exNuklear01  : Nuklear01();
      exSpine01    : Spine01();
      exAudio01    : Audio01();
    end;

    PyConsole.Pause();
  except
    on E: Exception do
    begin
      MessageBox(0, PChar(Format('Error: %s', [E.Message])), 'Fatal Error', MB_ICONERROR);
    end;
  end;
end;

end.
