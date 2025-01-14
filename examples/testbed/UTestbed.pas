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
  UAudio,
  UDatabase,
  UImGui;

procedure RunTests();

implementation

type
  TMenuOption = record
    Title: string;
    Pause: Boolean;
    Action: TProc;
  end;

var
  MenuOptions: array of TMenuOption;

// Procedure to Add a Menu Option
procedure AddMenuOption(const ATitle: string; const AAction: TProc; const APause: Boolean=False);
begin
  SetLength(MenuOptions, Length(MenuOptions) + 1);
  MenuOptions[High(MenuOptions)].Title := ATitle;
  MenuOptions[High(MenuOptions)].Action := AAction;
  MenuOptions[High(MenuOptions)].Pause := APause;
end;

procedure ShowMenu;
var
  SelectedIndex, Columns, Rows, TotalItems: Integer;
  Key: Integer;

  // Local function to handle menu-specific key input
  function ReadMenuKey: Integer;
  var
    LInputRecord: TInputRecord;
    LEventsRead: DWORD;
  begin
    repeat
      ReadConsoleInput(GetStdHandle(STD_INPUT_HANDLE), LInputRecord, 1, LEventsRead);
      if (LInputRecord.EventType = KEY_EVENT) and LInputRecord.Event.KeyEvent.bKeyDown then
      begin
        case LInputRecord.Event.KeyEvent.wVirtualKeyCode of
          VK_UP: Exit(1);    // Arrow Up
          VK_DOWN: Exit(2);  // Arrow Down
          VK_LEFT: Exit(3);  // Arrow Left
          VK_RIGHT: Exit(4); // Arrow Right
          VK_RETURN: Exit(5); // Enter
          VK_ESCAPE: Exit(6); // Escape
        else
          Exit(0); // Unsupported key
        end;
      end;
    until False;
  end;

  // Display the menu
  procedure DisplayMenu;
  var
    Row, Col, Index: Integer;
  begin
    PyConsole.SetTitle('Pyro Game Library');
    PyConsole.ClearScreen();
    PyConsole.PrintLn(PyCSIFGCyan+'Main Menu');
    PyConsole.PrintLn('-----------------------');

    for Row := 0 to Rows - 1 do
    begin
      for Col := 0 to Columns - 1 do
      begin
        Index := Col * Rows + Row; // Calculate the menu index for the current row/column
        if Index < TotalItems then
        begin
          if Index = SelectedIndex then
          begin
            PyConsole.SetBackgroundColor(PyCSIBGBrightBlue);
            PyConsole.SetForegroundColor(PyCSIFGBrightWhite);
            PyConsole.Print(Format('> %s ', [MenuOptions[Index].Title.PadRight(20)])); // Highlighted
            PyConsole.ResetTextFormat();
          end
          else
          begin
            PyConsole.Print(Format('  %s ', [MenuOptions[Index].Title.PadRight(20)])); // Normal
          end;
        end
        else
        begin
          PyConsole.Print(''.PadRight(22)); // Print empty padding for unused cells
        end;
      end;
      PyConsole.PrintLn(); // Move to the next row
    end;

    PyConsole.PrintLn('-----------------------');
    PyConsole.PrintLn('Use '+PyCSIFGYellow+'↑/↓/←/→ '+PyCSIResetForeground+'to navigate');
    PyConsole.PrintLn(PyCSIFGYellow+'Enter'+PyCSIResetForeground+' to select, '+PyCSIFGYellow+'ESC '+PyCSIResetForeground+'to exit');
  end;

begin
  SelectedIndex := 0;
  TotalItems := Length(MenuOptions);

  // Calculate columns and rows dynamically
  Columns := 1; // Set the desired number of columns
  Rows := (TotalItems + Columns - 1) div Columns; // Calculate the number of rows needed


  PyConsole.SetCursorVisible(False);
  repeat
    DisplayMenu;

    // Handle Key Input
    Key := ReadMenuKey();
    case Key of
      6: Break; // ESC to exit
      5: // Enter key
        begin
          PyConsole.SetCursorVisible(True);
          PyConsole.ClearScreen();
          MenuOptions[SelectedIndex].Action();
          if MenuOptions[SelectedIndex].Pause then
            PyConsole.Pause(True, PyCSIFGYellow, 'Press any key to return to the menu...');
          PyConsole.SetCursorVisible(False);
        end;
      1: // Arrow Up
        begin
          if SelectedIndex mod Rows > 0 then
            Dec(SelectedIndex);
        end;
      2: // Arrow Down
        begin
          if SelectedIndex mod Rows < Rows - 1 then
            Inc(SelectedIndex);
        end;
      3: // Arrow Left
        begin
          if SelectedIndex >= Rows then
            Dec(SelectedIndex, Rows);
        end;
      4: // Arrow Right
        begin
          if SelectedIndex + Rows < TotalItems then
            Inc(SelectedIndex, Rows);
        end;
    end;
  until False;

  PyConsole.SetCursorVisible(True);
end;

procedure RunTests();
begin
  AddMenuOption('ZipFileIO #1', ZipFileIO01, True);
  AddMenuOption('Window #01', Window01);
  AddMenuOption('Window #02', Window02);
  AddMenuOption('Spine #01', Spine01);
  AddMenuOption('Nuklear #01', Nuklear01);
  AddMenuOption('Audio #01', Audio01);
  AddMenuOption('Video #01', Video01);
  AddMenuOption('Video #02', Video02);
  AddMenuOption('Remote Db #01', RemoteDb01, True);
  AddMenuOption('ImGui #01', ImGui01);
  ShowMenu();
end;

end.
