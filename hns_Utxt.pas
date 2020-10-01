unit hns_Utxt;
{Copyright (C) 1997,2018 by Han Kleijn, www.hnsky.org
 email: han.k.. at...hnsky.org

{This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
}
interface

uses
{$ifdef mswindows}
//Windows,
{$endif}
{$ifdef unix}
baseunix,
{$endif}
//Messages,
SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
StdCtrls, Buttons, Menus, ComCtrls, clipbrd, strutils;

type

  { TSearch_results }

  TSearch_results = class(TForm)
    Copy2: TMenuItem;
    Cut2: TMenuItem;
    find1: TButton;
    find2: TLabel;
    findtext1: TEdit;
    ImageList_edit: TImageList;
    N1: TMenuItem;
    N2: TMenuItem;
    Paste2: TMenuItem;
    PopupMenu1: TPopupMenu;
    memo1: Tmemo;{lazurus}
    search2: TMenuItem;
    select_all2: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure find1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Cut2Click(Sender: TObject);
    procedure Copy2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure Paste2Click(Sender: TObject);
    procedure search2Click(Sender: TObject);
    procedure select_all2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Search_results: TSearch_results;

implementation
uses hns_main,
     hns_Uedi, hns_Unon; {for EM_SCROLL factoren}

{$R *.lfm}


procedure TSearch_results.FormCreate(Sender: TObject);
begin
  memo1.text:= foundstring1.text;
end;

procedure TSearch_results.find1Click(Sender: TObject);
var
  FoundAt         : LongInt;

begin
  memo1.SelStart :=memo1.SelStart+1;

  if findtext1.text<>'' then
  begin
    FoundAt := posex(uppercase(findtext1.text), UpperCase(memo1.Text),memo1.selStart+1);
    if FoundAt >0 then
    begin
      SetFocus;
      memo1.SelStart := FoundAt-1;
      memo1.SelLength := Length(findtext1.text);
      memo1.SetFocus;
    end
    else
    begin {start from beginning}
      memo1.SelLength := 0;
      memo1.selStart:= 0;
    end;
  end;
end;


procedure TSearch_results.Cut2Click(Sender: TObject);
begin
  memo1.CutToClipboard;
end;

ProcedurE TSearch_results.Copy2Click(SendEr: TObjEct);
beGin
  memo1.CopyToClIpboard;
end;

procedure TSearch_results.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#27 then if search_results.visible then search_results.visible:=false; // else edit2.Exit1Click(nil);
end;

procedure TSearch_results.FormShow(Sender: TObject);
begin
  if language_mode<>0 then load_search_results;
end;

procedure TSearch_results.Paste2Click(Sender: TObject);
begin
  memo1.PasteFromClipboard;
end;

procedure TSearch_results.search2Click(Sender: TObject);
begin
  toolbar1.Visible:=true;
  findtext1.SetFocus;
  if findtext1.text='' then findtext1.text:=copy(memo1.Text,memo1.SelStart+1,memo1.Sellength);
end;


procedure TSearch_results.select_all2Click(Sender: TObject);
begin
  memo1.selectall;
end;

end.

