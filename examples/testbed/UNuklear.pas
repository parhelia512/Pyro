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

unit UNuklear;

interface

uses
  WinApi.Windows,
  System.SysUtils,
  System.Classes,
  Pyro,
  UCommon;

procedure Nuklear01();

implementation

procedure Nuklear01();
type
  TDifficulty = (EASY, HARD);
var
  LWindow: TPyWindow;
  LPos: TPyPoint;
  LNkCtx: Pnk_context;
  LNkAtlas: Pnk_font_atlas;
  LNkRect: nk_rect;
  LMousePos: TPyPoint;
  LDifficult: TDifficulty;
  LPropertyValue: Integer;
  LNkBkgrnd: nk_colorf;
  LNkFont: Pnk_font;
  LResStream: TResourceStream;
begin
  LNkBkgrnd.r := 0.10;
  LNkBkgrnd.g := 0.18;
  LNkBkgrnd.b := 0.24;
  LNkBkgrnd.a := 1.0;
  LDifficult := EASY;
  LPropertyValue := 20;

  LPos.x := 0;
  LPos.y := 25;

  LWindow := TPyWindow.Init('Pyro: Nuklear #01');

  LNkCtx := nk_glfw3_init(LWindow.Handle, NK_GLFW3_INSTALL_CALLBACKS);
  nk_glfw3_font_stash_begin(@LNkAtlas);
  //font := nk_font_atlas_add_from_file(atlas, 'res/font/default.ttf', 14*1.5, nil);
  LResStream := TResourceStream.Create(HInstance, 'db1184eec13447cb8cceb28a1052bd96', RT_RCDATA);
  LNkFont := nk_font_atlas_add_from_memory(LNkAtlas, LResStream.Memory, LResStream.Size, 14 * LWindow.GetScale.w , nil);
  LResStream.Free();
  nk_glfw3_font_stash_end();
  nk_style_load_all_cursors(LNkCtx, @LNkAtlas.cursors);
  nk_style_set_font(LNkCtx, @LNkFont.handle);

  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(PyKEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(PyKEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      if LWindow.GetMouseButton(PyMOUSE_BUTTON_RIGHT, isWasReleased) then
        LWindow.SetShouldClose(True);


      LPos.x := LPos.x + 3.0;
      if LPos.x > LWindow.GetVirtualSize().w + 25 then
        LPos.x := -25;

      LMousePos := LWindow.GetMousePos();
      nk_glfw3_new_frame(LMousePos.x, LMousePos.y);
      LNkRect := nk_rect_rtn(50, 50, 230, 250);
      if nk_begin(LNkCtx, 'Demo', LNkRect, NK_WINDOW_BORDER or NK_WINDOW_MOVABLE or NK_WINDOW_SCALABLE or NK_WINDOW_MINIMIZABLE or NK_WINDOW_TITLE) = nk_true then
      begin
        nk_layout_row_static(LNkCtx, 30, 80, 1);
        if nk_button_label(LNkCtx, 'button') = nk_true then
          WriteLn('button pressed');

        nk_layout_row_dynamic(LNkCtx, 30, 2);
        if nk_option_label(LNkCtx, 'easy', nk_bool(LDifficult = EASY)) = nk_true then
          LDifficult := EASY;
        if nk_option_label(LNkCtx, 'hard', nk_bool(LDifficult = HARD)) = nk_true then
          LDifficult := HARD;

        nk_layout_row_dynamic(LNkCtx, 25, 1);
        nk_property_int(LNkCtx, 'Compression:', 0, @LPropertyValue, 100, 10, 1);

        nk_layout_row_dynamic(LNkCtx, 20, 1);
        nk_label(LNkCtx, 'background:', NK_TEXT_LEFT);
        nk_layout_row_dynamic(LNkCtx, 25, 1);
        if nk_combo_begin_color(LNkCtx, nk_rgb_cf(LNkBkgrnd), nk_vec2_rtn(nk_widget_width(LNkCtx), 400)) = nk_true then
        begin
          nk_layout_row_dynamic(LNkCtx, 120, 1);
          LNkBkgrnd := nk_color_picker(LNkCtx, LNkBkgrnd, NK_RGBA);
          nk_layout_row_dynamic(LNkCtx, 25, 1);
          LNkBkgrnd.r := nk_propertyf(LNkCtx, '#R:', 0, LNkBkgrnd.r, 1.0, 0.01, 0.005);
          LNkBkgrnd.g := nk_propertyf(LNkCtx, '#G:', 0, LNkBkgrnd.g, 1.0, 0.01, 0.005);
          LNkBkgrnd.b := nk_propertyf(LNkCtx, '#B:', 0, LNkBkgrnd.b, 1.0, 0.01, 0.005);
          LNkBkgrnd.a := nk_propertyf(LNkCtx, '#A:', 0, LNkBkgrnd.a, 1.0, 0.01, 0.005);
          nk_combo_end(LNkCtx);
        end;
      end;
      nk_end(LNkCtx);


      LWindow.StartDrawing();

        LWindow.Clear(TPyColor(LNkBkgrnd));

        LWindow.DrawFilledRect(LPos.x, LPos.y, 50, 50, PyRED, 0);

        glDisable(GL_POLYGON_SMOOTH);
        nk_glfw3_render(NK_ANTI_ALIASING_ON, LWindow.GetVirtualSize().w, LWindow.GetVirtualSize().h);
        glEnable(GL_POLYGON_SMOOTH);

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  nk_glfw3_shutdown();

  LWindow.Free();
end;


end.
