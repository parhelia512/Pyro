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

unit UImGui;

interface

uses
  WinApi.Windows,
  System.SysUtils,
  System.Classes,
  Pyro,
  UCommon;

procedure ImGui01();

implementation

procedure ImGui01();
var
  LWindow: TPyWindow;
  LFont: TPyFont;
  LPos: TPyPoint;
  LHudPos: TPyPoint;
  LIo: PImGuiIO;
  LShowDemoWindow: Boolean;
  LShowAnotherWindow: Boolean;
  LClearColor: ImVec4;
  LSliderValue: Single;
  LCounter: Integer;
  LImVec2: ImVec2;
  customFont: PImFont;
  LResStream: TResourceStream;
begin
  LShowDemoWindow := True;
  LShowAnotherWindow := False;
  LSliderValue := 0.0;
  LCounter := 0;

  TPyColor(LClearColor).FromFloat(0.45, 0.55, 0.60, 1.00);

  LWindow := TPyWindow.Init('Pyro: ImGui #01');

  LWindow.SetSizeLimits(Round(LWindow.GetVirtualSize().w), Round(LWindow.GetVirtualSize().h), PyDONT_CARE, PyDONT_CARE);

  LFont := TPyFont.Init(LWindow, 10);

  LPos.x := 0;
  LPos.y := 25+25;

  igCreateContext(nil);

  LIo := igGetIO();
  LIo.ConfigFlags := LIo.ConfigFlags or ImGuiConfigFlags_NavEnableKeyboard; // Enable Keyboard Controls
  LIo.ConfigFlags := LIo.ConfigFlags or ImGuiConfigFlags_NavEnableGamepad;  // Enable Gamepad Controls
  LIo.ConfigFlags := LIo.ConfigFlags or ImGuiConfigFlags_DockingEnable;     // Enable Docking

  // Load custom font - default pyro font
  LResStream := TResourceStream.Create(HInstance, 'db1184eec13447cb8cceb28a1052bd96', RT_RCDATA);
  customFont := ImFontAtlas_AddFontFromMemoryTTF(LIo.Fonts, LResStream.Memory, LResStream.Size, 13*LWindow.GetScale().w, nil, nil);
  customFont.ConfigData.FontDataOwnedByAtlas := False;
  LResStream.Free();

  igStyleColorsDark(nil);

  ImGui_ImplGlfw_InitForOpenGL(LWindow.Handle, true);
  ImGui_ImplOpenGL2_Init();


  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(PyKEY_ESCAPE, isWasReleased) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(PyKEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      if LWindow.GetMouseButton(PyMOUSE_BUTTON_RIGHT, isWasReleased) then
        LWindow.SetShouldClose(True);

      // Start the Dear ImGui frame
      ImGui_ImplOpenGL2_NewFrame();
      ImGui_ImplGlfw_NewFrame();
      igNewFrame();

      ImGui_ImplGlfw_CursorPosCallback(LWindow.Handle, LWindow.GetMousePos().x, LWindow.GetMousePos().y);

      if LShowDemoWindow then
        igShowDemoWindow(@LShowDemoWindow);

      igBegin('Hello, world!', nil, ImGuiWindowFlags_AlwaysAutoResize);
      igText('This is some useful text.');
      igCheckbox('Demo Window', @LShowDemoWindow);
      igCheckbox('Another Window', @LShowAnotherWindow);
      igSliderFloat('float', @LSliderValue, 0.0, 1.0, '%.3f', ImGuiSliderFlags_None);
      igColorEdit3('clear color', @LClearColor, ImGuiColorEditFlags_None);

      LImVec2.x := 0;
      LImVec2.y := 0;
      if igButton('Button', LImVec2) then
        Inc(LCounter);
      igSameLine(0, -1);
      igText(PyUtils.AsUTF8('counter = %d', [LCounter]));
      igText(PyUtils.AsUTF8('Application average %.3f ms/frame (%.1f FPS)', [1000.0 / LIo.Framerate, LIo.Framerate]));
      igEnd();

      if LShowAnotherWindow then
      begin
        igBegin('Another Window', @LShowAnotherWindow, ImGuiWindowFlags_AlwaysAutoResize);
        igText('Hello from another window!');
        LImVec2.x := 0;
        LImVec2.y := 0;

        if igButton('Close Me', LImVec2) then
          LShowAnotherWindow := False;
        igEnd();
      end;

      LPos.x := LPos.x + 3.0;
      if LPos.x > LWindow.GetVirtualSize().w + 25 then
        LPos.x := -25;

      LWindow.StartDrawing();

        LWindow.Clear(TPyColor(LClearColor));

        LWindow.DrawFilledRect(LPos.x, LPos.y, 50, 50, PyRED, 0);

        igRender();
        ImGui_ImplOpenGL2_RenderDrawData(igGetDrawData(), LWindow.GetVirtualSize().w, LWindow.GetVirtualSize().h);

        LHudPos := PyMath.Point(3, 20);

        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, '%d fps', [LWindow.GetFrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, PyUtils.HudTextItem('Quit', 'ESC'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, PyUtils.HudTextItem('F11', 'Toggle fullscreen'));

      LWindow.EndDrawing();

    LWindow.EndFrame();

  end;

  ImGui_ImplOpenGL2_Shutdown();
  ImGui_ImplGlfw_Shutdown();
  ImFontAtlas_Clear(LIo.Fonts);
  igDestroyContext(nil);

  LFont.Free();
  LWindow.Free();
end;


end.
