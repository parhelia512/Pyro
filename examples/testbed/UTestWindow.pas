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

unit UTestWindow;

interface

uses
  System.SysUtils,
  Pyro,
  UCommon;

procedure TestWindow01();

implementation

procedure TestWindow01();
const
  CFalseTrue: array[False..True] of string = ('no focus', 'has focus');
var
  LWindow: TPyWindow;
  LTexture: TPyTexture;
  LFont: TPyFont;
  LPos: TPyPoint;
  LHudPos: TPyPoint;
begin
  LWindow := TPyWindow.Create();

  LWindow.Open('Pyro: Window #01');

  LFont := TPyFont.Create();
  LFont.Load(LWindow, 10);

  LTexture := TPyTexture.Create();
  LTexture.LoadFromZipFile(CZipFilename, 'res/images/pyro.png');
  LTexture.SetPos(LWindow.GetVirtualSize().w/2, LWindow.GetVirtualSize().h/2);
  LTexture.SetScale(0.5);

  LPos.x := 0;
  LPos.y := 25;

  PyUtils.AsyncRun('Task #01',
  // background task
  procedure
  var
    i: Cardinal;
  begin
    PyConsole.SetTitle('Pyro: Background Task');
    for i := 1 to 1000000 do
    begin
      PyConsole.PrintLn(PyCSIDim+'%d', [i]);
      if PyUtils.AsyncShouldTerminate('Task #01') then
      begin
        PyConsole.PrintLn('Terminating task...');
        Exit;
      end;
    end;
  end,
  // forground task
  procedure
  begin
    PyConsole.PrintLn(PyCSIBlink+PyCSIFGCyan+'Background task done!');
  end);

  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(PyKEY_ESCAPE, isWasReleased) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(PyKEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      if LWindow.GetMouseButton(PyMOUSE_BUTTON_RIGHT, isWasReleased) then
        LWindow.SetShouldClose(True);


      LPos.x := LPos.x + 3.0;
      if LPos.x > LWindow.GetVirtualSize().w + 25 then
        LPos.x := -25;

      LWindow.StartDrawing();

        LWindow.Clear(PyDARKSLATEBROWN);

        LTexture.Draw(LWindow);

        LWindow.DrawFilledRect(LPos.x, LPos.y, 50, 50, PyRED, 0);

        LHudPos := PyMath.Point(3, 3);

        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, '%d fps', [LWindow.GetFrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, PyUtils.HudTextItem('Quit', 'ESC'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, PyUtils.HudTextItem('F11', 'Toggle fullscreen'));

        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyORANGE, haLeft, PyUtils.HudTextItem('Mouse Wheel','x:%3.2f, y:%3.2f', 20, ' '), [LWindow.GetMouseWheel().x, LWindow.GetMouseWheel().y]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyORANGE, haLeft, PyUtils.HudTextItem('Mouse Pos', 'x:%3.2f, y:%3.2f', 20, ' '), [LWindow.GetMousePos().x, LWindow.GetMousePos().y]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyORANGE, haLeft, PyUtils.HudTextItem('Window', '%s', 20, ' '), [CFalseTrue[LWindow.HasFocus()]]);

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  PyUtils.AsyncWaitForAllToTerminate();

  LTexture.Free();
  LFont.Free();
  LWindow.Free();

end;

end.
