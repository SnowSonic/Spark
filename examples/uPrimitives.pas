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

unit uPrimitives;

interface

uses
  Spark;

const
  cWindowWidth      = 960;
  cWindowHeight     = 540;
  cWindowTitle      = 'Spark Primatives';
  cWindowFullscreen = False;
  cFontSize         = 16;
  cArchive          = 'Data.arc';

type
  { TExample }
  TExample = class(TGame)
  protected
    FWindowClearColor: TColor;
    FFont: Int64;
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
end;

procedure TExample.OnShutdown;
begin
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

end;

procedure TExample.OnRenderFrame;
begin
end;

procedure TExample.OnRenderHUD;
begin
  HudPos(3, 3);
  HudText(FFont, WHITE, haLeft, 'fps %d', [GetFrameRate]);
  HudText(FFont, GREEN, haLeft, HudTextItem('ESC', 'Quit'), []);
  HudText(FFont, GREEN, haLeft, HudTextItem('F10', 'Toggle fullscreen'), []);
end;

procedure TExample.OnShowFrame;
begin
  ShowWindow;
end;



end.
