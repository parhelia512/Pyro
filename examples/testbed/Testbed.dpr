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

program Testbed;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Pyro in '..\..\src\Pyro.pas',
  UTestbed in 'UTestbed.pas',
  UCommon in 'UCommon.pas',
  UIO in 'UIO.pas',
  UWindow in 'UWindow.pas',
  UVideo in 'UVideo.pas',
  USpine in 'USpine.pas',
  UAudio in 'UAudio.pas',
  UDatabase in 'UDatabase.pas',
  UImGui in 'UImGui.pas';

begin
  RunTests();
end.
