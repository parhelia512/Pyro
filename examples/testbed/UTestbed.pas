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
  UTestIO,
  UTestWindow;

procedure RunTests();

implementation

type
  TExamples = (
    exTestZipFileIO01,
    exTestWindow01
  );

procedure RunTests();
var
  LExample: TExamples;
begin
  try
    LExample := exTestZipFileIO01;

    case LExample of
      exTestZipFileIO01: TestZipFileIO01();
      exTestWindow01   : TestWindow01();
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
