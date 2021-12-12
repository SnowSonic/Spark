{==============================================================================
  ____                   _
 / ___| _ __   __ _ _ __| | __
 \___ \| '_ \ / _` | '__| |/ /
  ___) | |_) | (_| | |  |   <
 |____/| .__/ \__,_|_|  |_|\_\
       |_|  Game Library™

Copyright © 2021 tinyBigGAMES™ LLC
All Rights Reserved.

Website: https://tinybiggames.com
Email  : support@tinybiggames.com

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software in
   a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

2. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

3. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in
   the documentation and/or other materials provided with the
   distribution.

4. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived
   from this software without specific prior written permission.

5. All video, audio, graphics and other content accessed through the
   software in this distro is the property of the applicable content owner
   and may be protected by applicable copyright law. This License gives
   Customer no rights to such content, and Company disclaims any liability
   for misuse of content.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
============================================================================= }

unit uBitmap;

interface

uses
  Spark;

const
  cWindowWidth      = 960;
  cWindowHeight     = 540;
  cWindowTitle      = 'Spark Bitmap';
  cWindowFullscreen = False;
  cFontSize         = 16;
  cArchive          = 'Data.arc';
  cScrollSpeed      = 30;
  cActionStr: array[0..3] of string = ('Align Bitmap', 'Tiled Bitmap', 'ColorKey Transparent Bitmap', 'Native Transparent Bitmap');

type
  { TExample }
  TExample = class(TGame)
  protected
    FWindowClearColor: TColor;
    FFont: Int64;
    FBmp: array[0..4] of Int64;
    FAction: Integer;
    FScrollPos: TVector;
  public
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnClearFrame; override;
    procedure OnUpdateFrame(aDeltaTime: Double); override;
    procedure OnRenderFrame; override;
    procedure OnRenderHUD; override;
    procedure OnShowFrame; override;
  end;

{ Routines }
procedure RunExample;

implementation

{ Routines }
procedure RunExample;
begin
  RunGame(TExample);
end;

{ TExample }
procedure TExample.OnStartup;
begin
  Mount(cArchive, '', True);
  FWindowClearColor := DARKSLATEBROWN;
  OpenWindow(cWindowWidth, cWindowHeight, cWindowTitle, cWindowFullscreen);
  FFont := LoadFont(cFontSize);

  FBmp[0] := LoadBitmap('arc/bitmaps/sprites/square00.png', @COLORKEY);
  FBmp[1] := LoadBitmap('arc/bitmaps/backgrounds/nebula2.png', nil);
  FBmp[2] := LoadBitmap('arc/bitmaps/sprites/circle00.png', nil);
  FBmp[3] := LoadBitmap('arc/bitmaps/sprites/circle00.png', @COLORKEY);
  FBmp[4] := LoadBitmap('arc/bitmaps/sprites/alphacheese.png', nil);

  FScrollPos.Assign(0, 0);
  FAction := 0;
end;

procedure TExample.OnShutdown;
begin
  UnloadAllBitmaps;
  UnloadFont(FFont);
  UnMount(cArchive);
end;

procedure TExample.OnClearFrame;
begin
  ClearWindow(FWindowClearColor);
end;

procedure TExample.OnUpdateFrame(aDeltaTime: Double);
begin
  if KeyboardPressed(KEY_ESCAPE) then
    SetTerminated(True);

  if KeyboardPressed(KEY_F10) then
    ToggleFullscreenWindow;

  if KeyboardPressed(KEY_1) then
    FAction := 0;

  if KeyboardPressed(KEY_2) then
    FAction := 1;

  if KeyboardPressed(KEY_3) then
    FAction := 2;

  if KeyboardPressed(KEY_4) then
    FAction := 3;


  case FAction of
    0: // align bitmap
    begin

    end;

    1: // tiled bitmap
    begin
      FScrollPos.Y := FScrollPos.Y + (cScrollSpeed * aDeltaTime);
    end;

    2: // colorkey transparent bitmap
    begin

    end;

    3: // native transparent bitmap
    begin

    end;
  end;

end;

procedure TExample.OnRenderFrame;
begin
  case FAction of
    0: // align bitmap
    begin
      var LCenterPos: TVector;
      LCenterPos.Assign(cWindowWidth/2, cWindowHeight/2);

      DrawLine(LCenterPos.X, 0, LCenterPos.X, cWindowHeight, YELLOW, 1);
      DrawLine(0, LCenterPos.Y, cWindowWidth,  LCenterPos.Y, YELLOW, 1);

      DrawBitmap(FBmp[0], LCenterPos.X, LCenterPos.Y, 1, 0, WHITE, haCenter, vaCenter);
      PrintText(FFont, LCenterPos.X, LCenterPos.Y+25, DARKGREEN, haCenter, 'center-center', []);

      DrawLine(0, LCenterPos.Y-128, cWindowWidth,  LCenterPos.Y-128, YELLOW, 1);

      DrawBitmap(FBmp[0], LCenterPos.X, LCenterPos.Y-128, 1, 0, WHITE, haLeft, vaTop);
      PrintText(FFont, LCenterPos.X+34, LCenterPos.Y-(128-6), DARKGREEN, haLeft, 'left-top', []);

      DrawBitmap(FBmp[0], LCenterPos.X, LCenterPos.Y-128, 1, 0, WHITE, haLeft, vaBottom);
      PrintText(FFont, LCenterPos.X+34, LCenterPos.Y-(128+25), DARKGREEN, haLeft, 'left-bottom', []);

      DrawLine(0, LCenterPos.Y+128, cWindowWidth,  LCenterPos.Y+128, YELLOW, 1);
      DrawBitmap(FBmp[0], LCenterPos.X, LCenterPos.Y+128, 1, 0, WHITE, haRight, vaTop);
      PrintText(FFont, LCenterPos.X+4, LCenterPos.Y+(128+6), DARKGREEN, haLeft, 'right-top', []);

      DrawBitmap(FBmp[0], LCenterPos.X, LCenterPos.Y+128, 1, 0, WHITE, haRight, vaBottom);
      PrintText(FFont, LCenterPos.X+4, LCenterPos.Y+(128-27), DARKGREEN, haLeft, 'right-bottom', []);
    end;

    1: // tiled bitmap
    begin
      DrawTiledBitmap(FBmp[1], FScrollPos.X, FScrollPos.Y);
    end;

    2: // colorkey transparent bitmap
    begin
      var LCenterPos: TVector;
      LCenterPos.Assign(cWindowWidth/2, cWindowHeight/2);

      var LSize: TVector;
      GetBitmapSize(FBmp[2], LSize);

      DrawBitmap(FBmp[2], LCenterPos.X, LCenterPos.Y-LSize.Y, 1.0, 0.0, WHITE, haCenter, vaCenter);
      DrawBitmap(FBmp[3], LCenterPos.X, LCenterPos.Y+LSize.Y, 1.0, 0.0, WHITE, haCenter, vaCenter);

      PrintText(FFont, LCenterPos.X, LCenterPos.Y-(LSize.Y/2), DARKORANGE, haCenter, 'without colorkey', []);
      PrintText(FFont, LCenterPos.X, LCenterPos.Y+(LSize.Y*1.5), DARKORANGE, haCenter, 'with colorkey', []);
    end;

    3: // native transparent bitmap
    begin
      DrawBitmap(FBmp[4], cWindowWidth/2, cWindowHeight/2, 1, 0, WHITE, haCenter, vaCenter);
      var LSize: TVector;
      GetBitmapSize(FBmp[4], LSize);
      PrintText(FFont, cWindowWidth/2, (cWindowHeight/2)+(LSize.Y/3.5), DARKORANGE, haCenter, 'Native transparency', []);
    end;
  end;
end;

procedure TExample.OnRenderHUD;
begin
  HudPos(3, 3);
  HudText(FFont, WHITE,  haLeft, 'fps %d', [GetFrameRate]);
  HudText(FFont, GREEN,  haLeft, HudTextItem('ESC', 'Quit'), []);
  HudText(FFont, GREEN,  haLeft, HudTextItem('F10', 'Toggle fullscreen'), []);
  HudText(FFont, GREEN,  haLeft, HudTextItem('1-4', 'Bitmap Action'), []);
  HudText(FFont, ORANGE, haLeft, HudTextItem('Action:', '%s', ' '), [cActionStr[FAction]]);
end;

procedure TExample.OnShowFrame;
begin
  ShowWindow;
end;



end.
