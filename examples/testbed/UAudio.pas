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

unit UAudio;

interface

uses
  System.SysUtils,
  Pyro,
  UCommon;

procedure Audio01();

implementation

procedure Audio01();
var
  LWindow: TPyWindow;
  LFont: TPyFont;
  LPos: TPyPoint;
  LHudPos: TPyPoint;
begin
  LWindow := TPyWindow.Create();

  LWindow.Open('Pyro: Audio #01');

  LFont := TPyFont.Create();
  LFont.Load(LWindow, 10);

  if not PyAudio.Open() then
  begin
    PyConsole.PrintLn('Failed to open audio');
  end;

  PyAudio.PlayMusicFromZipFile(CZipFilename, 'res/music/song01.ogg', 1.0, True);

  LPos.x := 0;
  LPos.y := 25;

  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(PyKEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(PyKEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      LPos.x := LPos.x + 3.0;
      if LPos.x > LWindow.GetVirtualSize().w + 25 then
        LPos.x := -25;

      LWindow.StartDrawing();

        LWindow.Clear(PyDARKSLATEBROWN);

        LWindow.DrawFilledRect(LPos.x, LPos.y, 50, 50, PyRED, 0);

        LHudPos := PyMath.Point(3, 3);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyGREEN, haLeft, '%d fps', [LWindow.GetFrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyGREEN, haLeft, PyUtils.HudTextItem('ESC', 'Quit'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyGREEN, haLeft, PyUtils.HudTextItem('F11', 'Toggle fullscreen'));

        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyORANGE, haLeft, PyUtils.HudTextItem('Mouse Wheel','x:%3.2f, y:%3.2f', 20, ' '), [LWindow.GetMouseWheel().x, LWindow.GetMouseWheel().y]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyORANGE, haLeft, PyUtils.HudTextItem('Mouse Pos', 'x:%3.2f, y:%3.2f', 20, ' '), [LWindow.GetMousePos().x, LWindow.GetMousePos().y]);


      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  PyAudio.Close();

  LFont.Free();

  LWindow.Free();

end;

end.
