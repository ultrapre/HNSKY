unit hns_Uobj;
{Copyright (C) 1997,2019 by Han Kleijn, www.hnsky.org
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
  Windows, {for messagebox}
  {$endif}
  {$ifdef unix}
  LCLIntf,{for selectobject, invalidaterect}
  {$endif}
  {Messages,} SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, Menus;

type

  { TobjectmenDeepsky level 1.hndu }

  { Tobjectmenu }

  Tobjectmenu = class(TForm)
    deepskyleveltrackbar1: TTrackBar;
    fitsonoff1: TCheckBox;
    Label_level1: TLabel;
    star_coloring1: TCheckBox;
    star_combo1: TComboBox;
    ok_button1: TBitBtn;
    StarGroupBox1: TGroupBox;
    densitylabel: TLabel;
    boldnesslabel: TLabel;
    boldTrackBar1: TTrackBar;
    densityTrackBar1: TTrackBar;
    nameallstars1: TCheckBox;
    starsonoff1: TCheckBox;
    maxmagn1: TEdit;
    UpDown1: TUpDown;
    help_objectmenu: TLabel;
    check_external1: TCheckBox;
    stars_external1: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    nametillTrackBar1: TTrackBar;
    Label_namet: TLabel;
    Label_maxm: TLabel;
    deepmagTrackBar1: TTrackBar;
    Planetsonoff1: TCheckBox;
    asteroidsonoff1: TCheckBox;
    cometsonoff1: TCheckBox;
    min_size1: TComboBox;
    Label_mins: TLabel;
    Label_type: TLabel;
    filter1: TComboBox;
    deepsky_combobox1: TComboBox;
    supl1: TComboBox;
    supl2: TComboBox;
    supl3: TComboBox;
    supl4: TComboBox;
    supl5: TComboBox;
    fitsbright1: TTrackBar;
    fitsback1: TTrackBar;
    suppl1: TCheckBox;
    suppl2: TCheckBox;
    suppl3: TCheckBox;
    suppl4: TCheckBox;
    suppl5: TCheckBox;

    deepsky_check1: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    neo_only1: TCheckBox;
    toast_check1: TCheckBox;
    toast_combobox1: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    procedure deepskyleveltrackbar1Change(Sender: TObject);
    procedure fitsback1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fitsback1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure fitsbright1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fitsbright1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure star_coloring1Click(Sender: TObject);
    procedure fitsonoff1Click(Sender: TObject);
    procedure ok_button1Click(Sender: TObject);
    procedure boldTrackBar1Change(Sender: TObject);
    procedure densityTrackBar1Change(Sender: TObject);
    procedure nameallstars1Click(Sender: TObject);
    procedure deepmagTrackBar1Change(Sender: TObject);
    procedure nametillTrackBar1Change(Sender: TObject);
    procedure supl1DblClick(Sender: TObject);
     procedure suppl2Click(Sender: TObject);
    procedure suppl1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure star_combo1Change(Sender: TObject);
    procedure starsonoff1Click(Sender: TObject);
    procedure maxmagn1Exit(Sender: TObject);
    procedure supl1Change(Sender: TObject);
    procedure supl2Change(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure cometsonoff1Click(Sender: TObject);
    procedure asteroidsonoffclick(Sender: TObject);
    procedure Planetsonoff1Click(Sender: TObject);
    procedure Filter1exit(Sender: TObject);
    procedure suplDropDown(Sender: TObject);
    procedure star_combo1DropDown(Sender: TObject);
    procedure deepsky_combobox1Change(Sender: TObject);
    procedure deepsky_check1Click(Sender: TObject);
    procedure deepsky_combobox1Exit(Sender: TObject);
    procedure supl1Exit(Sender: TObject);
    procedure supl2Exit(Sender: TObject);
    procedure star_combo1Exit(Sender: TObject);
    procedure help_objectmenuClick(Sender: TObject);
    procedure stars_external1Change(Sender: TObject);
    procedure suppl3Click(Sender: TObject);
    procedure suppl4Click(Sender: TObject);
    procedure suppl5Click(Sender: TObject);
    procedure supl3Change(Sender: TObject);
    procedure supl4Change(Sender: TObject);
    procedure supl5Change(Sender: TObject);
    procedure supl3Exit(Sender: TObject);
    procedure supl4Exit(Sender: TObject);
    procedure supl5Exit(Sender: TObject);
    procedure neo_only1Click(Sender: TObject);
    procedure toast_combobox1Change(Sender: TObject);
    procedure toast_check1Click(Sender: TObject);
    procedure StarGroupBox1MouseEnter(Sender: TObject);
    procedure fitsonoffClick1(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  objectmenu: Tobjectmenu;

implementation

uses hns_main, hns_Utim, {hns_Uedi,} hns_Unon, hns_Ucen, hns_U290;
{$IFDEF fpc}
  {$R *.lfm}
{$ELSE} {delphi}
  {$R *.DFM}
{$ENDIF}
var
  objectmenu_painting :boolean;{painting ongoing}

procedure Tobjectmenu.ok_button1Click(Sender: TObject);
begin
  objectmenu.hide;
  mainwindow.setfocus;
end;


procedure Tobjectmenu.fitsonoff1Click(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}
  if  objectmenu.fitsonoff1.checked then
  begin
    fits_insert:=1;
    missedupdate:=1;
  end
  else
  begin
    fits_insert:=0;
    missedupdate:=2;
  end;
  fitsback1.enabled:=fits_insert<>0;
  fitsbright1.enabled:=fits_insert<>0;

  paint_sky; {rewrite window}
end;



procedure Tobjectmenu.star_coloring1Click(Sender: TObject);
begin
  if star_coloring1.checked then star_colouring:=1 else star_colouring:=0;

  missedupdate:=2;
  paint_sky;{rewrite window}
end;



procedure change_fits_background;
begin
  if dss_background<>objectmenu.fitsback1.position then {this prevent double paint}
  begin
    dss_background:=objectmenu.fitsback1.position;
    missedupdate:=2;
    paint_sky;
  end;
end;

procedure change_fits_brightness;
begin
  if dss_brightness<>objectmenu.fitsbright1.position then
  begin
    dss_brightness:=objectmenu.fitsbright1.position;
    missedupdate:=2;
    paint_sky;
  end;
end;
procedure Tobjectmenu.fitsback1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_fits_background;
end;

procedure Tobjectmenu.deepskyleveltrackbar1Change(Sender: TObject);
var
  olddeepsky_level : integer;
begin
  olddeepsky_level:=deepsky_level;
  if deepsky_level=deepskyleveltrackbar1.position then exit;
  deepsky_level:=deepskyleveltrackbar1.position;
  if objectmenu_painting then exit;{prevent paint_sky}
  if olddeepsky_level>deepsky_level then missedupdate:=2 else missedupdate:=1;
  paint_sky;
end;

procedure Tobjectmenu.fitsback1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  change_fits_background;
end;


procedure Tobjectmenu.fitsbright1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_fits_brightness;
end;

procedure Tobjectmenu.fitsbright1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  change_fits_brightness;
end;

function getsupname(ins:string): string;{extract name without extension}
begin
   ins:={lowercase}(ExtractFileName(ins));
   getsupname:=copy(ins,1,length(ins)-4);
   {extractname for case file is loaded in editor}
end;

procedure Tobjectmenu.FormShow(Sender: TObject);
var S:string[5];
begin {updates required after paint}
  {here, so name from editor can be taken over.}
  objectmenu_painting:=true;

  if min_size_deep>0 then str(min_size_deep/10:2:1,S)
  else
  begin
    if min_size_deep=0 then S:=''
    else S:='auto';{-1, auto}
  end;

  objectmenu.min_size1.text:=S;

  filter1.text:=filtertype;

  objectmenu.suppl1.checked:=suppl1_activated<>0;
  objectmenu.suppl2.checked:=suppl2_activated<>0;
  objectmenu.suppl3.checked:=suppl3_activated<>0;
  objectmenu.suppl4.checked:=suppl4_activated<>0;
  objectmenu.suppl5.checked:=suppl5_activated<>0;
  stars_external1.ItemIndex:=stars_external_index-1;{which external database is selected}

  update_button_hints;{copy mainmenu hints and objectmenu hints to buttons}

  try {prevent runtime error if weird .hns is loaded}
    boldtrackbar1.position:=(bold);
    densitytrackbar1.position:=round(density);
    deepmagtrackbar1.position:=deep;
    deepskyleveltrackbar1.position:=deepsky_level;
    nametilltrackbar1.position:=naming;
    fitsbright1.position:=dss_brightness;
    fitsback1.position:=dss_background;{dss background and brightness}
    updown1.position:=round(limitmagn*10);
  except;
  end;

  str(limitmagn:2:1,S);
  objectmenu.maxmagn1.text:=S;

  {namest=0 bright stars only}
  {namest=1 external stars only}
  {namest=2 all stars}
  if namest=1 then nameallstars1.state:=cbgrayed
  else
  if namest=2 then nameallstars1.state:=cbchecked
  else
  nameallstars1.state:=cbUnchecked;

  stars_external1.ItemIndex:=stars_external_index-1;
  stars_external1.hint:=stars_external_hint[stars_external_index];

  if ((stardatabase_selected>0) and (stardatabase_selected<290)) then check_external1.checked:=true;

  if asteroids_activated=2 then asteroidsonoff1.state:=cbgrayed {all}
  else
  if asteroids_activated=1 then asteroidsonoff1.state:=cbchecked{auto}
  else
  asteroidsonoff1.state:=cbUnchecked;

  if comets_activated=2 then cometsonoff1.state:=cbgrayed {all}
  else
  if comets_activated=1 then cometsonoff1.state:=cbchecked{auto}
  else
  cometsonoff1.state:=cbUnchecked;


  objectmenu.planetsonoff1.checked:=planets_activated<>0;

  deepsky_check1.checked:=deep_database<>0;
  toast_check1.checked:=toast_activated<>0;

  starsonoff1.checked:=stars_activated<>0;
  star_coloring1.checked:=star_colouring<>0;

  deepsky_combobox1.text:=name_deep;
  star_combo1.text:=uppercase(copy(name_star,1,3));
  toast_combobox1.text:=getsupname(name_toast);

  supl1.text:=getsupname(name_supl1);
  supl2.text:=getsupname(name_supl2);
  supl3.text:=getsupname(name_supl3);
  supl4.text:=getsupname(name_supl4);
  supl5.text:=getsupname(name_supl5);

  if ((supplstring1.count<=1) and (length(name_supl1)>4)) {no error if blank} then supl1.color:=clred else begin supl1.color:=objectmenu.color;supl1.parentfont:=true;end;
  if ((supplstring2.count<=1) and (length(name_supl2)>4)) {no error if blank} then supl2.color:=clred else begin supl2.color:=objectmenu.color;supl2.parentfont:=true;end;
  if ((supplstring3.count<=1) and (length(name_supl3)>4)) {no error if blank} then supl3.color:=clred else begin supl3.color:=objectmenu.color;supl3.parentfont:=true;end;
  if ((supplstring4.count<=1) and (length(name_supl4)>4)) {no error if blank} then supl4.color:=clred else begin supl4.color:=objectmenu.color;supl4.parentfont:=true;end;
  if ((supplstring5.count<=1) and (length(name_supl5)>4)) {no error if blank} then supl5.color:=clred else begin supl5.color:=objectmenu.color;supl5.parentfont:=true;end;


  if ((png.height<1) and (length(name_toast)>4)) {no error if blank} then toast_combobox1.color:=clred else toast_combobox1.color:=objectmenu.color;{take current color including nightvision colors}

  if  deepstring.count<=1 then deepsky_combobox1.color:=clred else deepsky_combobox1.color:=objectmenu.color;{take current color including nightvision colors}

  if  database2=not_available then star_combo1.color:=clred else star_combo1.color:=objectmenu.color;{take current color including nightvision colors}

//  if boldtrackbar1.enabled then objectmenu.activecontrol:=boldtrackbar1;{trick, only to make trackbar red in night vision mode.}
//  if densitytrackbar1.enabled then objectmenu.activecontrol:=densitytrackbar1;{enable check required if grayed, otherwise error GSC}

  objectmenu.fitsonoff1.checked:=fits_insert<>0;
  fitsback1.enabled:=fits_insert<>0;
  fitsbright1.enabled:=fits_insert<>0;

  {$ifdef mswindows}
 // objectmenu.ActiveControl:=ok_button1;{Linux doesn't like and stops all edit input}
  {$else} {Linux}
  {$endif}

  objectmenu.suppl2.checked:=suppl2_activated<>0;{supplement 2 can be activated by home key, mark mouse position.}

  deepsky_combobox1.hint:=deepstring.strings[0];

  supl1.hint:=copy(supplstring1.strings[0],2,length(supplstring1.strings[0])-1);
  supl2.hint:=copy(supplstring2.strings[0],2,length(supplstring2.strings[0])-1);
  supl3.hint:=copy(supplstring3.strings[0],2,length(supplstring3.strings[0])-1);
  supl4.hint:=copy(supplstring4.strings[0],2,length(supplstring4.strings[0])-1);
  supl5.hint:=copy(supplstring5.strings[0],2,length(supplstring5.strings[0])-1);

  objectmenu_painting:=false; {painting is finished}

//  star_combo1.color:=objectmenu.color;

end;



procedure Tobjectmenu.boldTrackBar1Change(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}
  if boldtrackbar1.position<bold then missedupdate:=2 else missedupdate:=1;
  bold:=boldtrackbar1.position;
  paint_sky;
end;

procedure Tobjectmenu.densityTrackBar1Change(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}

  if densitytrackbar1.position<density then missedupdate:=2 else missedupdate:=1;
  density:=densitytrackbar1.position;
  paint_sky;{do not paint if objectmenu is shown}
{  hint is written in mouse entering Tobjectmenu.StarGroupBox1MouseEnter}
end;


procedure Tobjectmenu.nameallstars1Click(Sender: TObject);

begin
  if objectmenu_painting then exit;{prevent paint_sky}

  if nameallstars1.state=cbgrayed  then  namest:=1  else
  if nameallstars1.state=cbchecked  then  namest:=2 else
  namest:=0;
  if namest<>2 then missedupdate:=2 {clear + update}
               else missedupdate:=1;{update}

  {namest=0 bright stars only}
  {namest=1 external stars only}
  {namest=2 all stars}

  paint_sky; {update menu always false or true otherwise no checked symbol}
end;
procedure Tobjectmenu.stars_external1Change(Sender: TObject);
begin
   if check_external1.Checked=false then
  begin
    if pos('.290',name_star)<>0 then stardatabase_selected:=290 else stardatabase_selected:=0;
  end
  else
  begin
    stardatabase_selected:=stars_external1.ItemIndex+1;
    stars_external_index:=stardatabase_selected;
  end;
  {0 .dat star database}
  {32 .290 star database}
  {1,2,3,4, GSC, UCAC4....}
  stars_external1.hint:=stars_external_hint[stars_external1.ItemIndex+1];

  if objectmenu_painting then exit;{prevent paint_sky}
  missedupdate:=2;paint_sky; {rewrite window}
  {center windows==>} invalidaterect(center_on.handle,nil,false); {update search window}
end;



procedure Tobjectmenu.deepmagTrackBar1Change(Sender: TObject);
var olddeep2 : integer;
begin
  olddeep2:=deep;
  deep:=deepmagTrackBar1.position;
  if deep=deepmagTrackBar1.max then deep:=9999 {not 999 since zoom/3 is added}
  else
  if deep=deepmagTrackBar1.min then  deep:=-100; {-10 name none deepsky !, switch off function}
  if deep<naming then begin naming:=deep;nametillTrackBar1.position:=naming;end;

  if objectmenu_painting  then exit;
  if olddeep2>deep  then missedupdate:=2 else  missedupdate:=1;
  paint_sky;
end;

procedure Tobjectmenu.nametillTrackBar1Change(Sender: TObject);
var oldnaming2 : integer;
begin
  oldnaming2:=naming;
  if naming=nametillTrackBar1.position then exit;

  naming:=nametillTrackBar1.position;;
  if naming=nametillTrackBar1.Max then naming:=9999 {not 999 since zoom/3 is added}
  else
  if naming=nametillTrackBar1.Min then  naming:=-1000; {No names including the sun=-270}
  if deep<naming then begin deep:=naming;deepmagTrackBar1.position:=deep;end;

  if objectmenu_painting then exit;{prevent paint_sky}
  if oldnaming2>naming then missedupdate:=2 else missedupdate:=1;
  paint_sky;
end;

procedure Tobjectmenu.supl1DblClick(Sender: TObject);
begin
  mainwindow.SupplementeditorClick(Sender);
  supl1.text:=getsupname(name_supl1);
  supl2.text:=getsupname(name_supl2);
  supl3.text:=getsupname(name_supl3);
  supl4.text:=getsupname(name_supl4);
  supl5.text:=getsupname(name_supl5);
end;

procedure Tobjectmenu.neo_only1Click(Sender: TObject);
begin
  if neo_only1.checked then
  begin
    missedupdate:=2;
  end
  else
  begin
    missedupdate:=1;
  end;
  paint_sky; {rewrite window}
end;

procedure Tobjectmenu.suppl1Click(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}
  if objectmenu.suppl1.checked then
  begin
    suppl1_activated:=1;
    missedupdate:=1;
  end
  else
  begin
    suppl1_activated:=0;
    missedupdate:=2;
  end;
  paint_sky; {rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}
end;

procedure Tobjectmenu.suppl2Click(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}
  if objectmenu.suppl2.checked then
  begin
     suppl2_activated:=1;
     missedupdate:=1;
  end
  else
  begin
    suppl2_activated:=0;
    missedupdate:=2;
  end;
  paint_sky; {rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}
end;

procedure Tobjectmenu.suppl3Click(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}
  if objectmenu.suppl3.checked then
  begin
     suppl3_activated:=1;
     missedupdate:=1;
  end
  else
  begin
    suppl3_activated:=0;
    missedupdate:=2;
  end;
  paint_sky; {rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}

end;

procedure Tobjectmenu.suppl4Click(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}
  if objectmenu.suppl4.checked then
  begin
     suppl4_activated:=1;
     missedupdate:=1;
  end
  else
  begin
    suppl4_activated:=0;
    missedupdate:=2;
  end;
  paint_sky; {rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}

end;

procedure Tobjectmenu.suppl5Click(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}
  if objectmenu.suppl5.checked then
  begin
     suppl5_activated:=1;
     missedupdate:=1;
  end
  else
  begin
    suppl5_activated:=0;
    missedupdate:=2;
  end;
  paint_sky; {rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}
end;

procedure Tobjectmenu.toast_check1Click(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}
  if objectmenu.toast_check1.checked then
  begin
     toast_activated:=1;
     missedupdate:=1;
  end
  else
  begin
    toast_activated:=0;
    missedupdate:=2;
  end;
 paint_sky; {rewrite window}
end;


procedure Tobjectmenu.FormCreate(Sender: TObject);
begin
//  objectmenu.color:=clred;
  if language_mode<>0 then load_object;

  position:=podesigned;{otherwise positioning doesn't work in FPC}
  objectmenu.top:=objectmenutop;
  objectmenu.left:=objectmenuleft;
end;

procedure add_files_combobox;{add files to star comboboxes}
var
  SearchRec: TSearchRec;
  s        : string;
begin
  with objectmenu do
  begin
    star_combo1.items.clear;
    star_combo1.items.add('');{2016, add blank in star database list}

    if FindFirst(application_Path+'*_hsky.dat', faAnyFile, SearchRec)=0 then
    begin
      repeat
        s:=uppercase(copy(searchrec.name,1,3));
        star_combo1.items.add(s);
      until FindNext(SearchRec) <> 0;
    end;
    FindClose(SearchRec);

    if FindFirst(application_Path+'*0101.290', faAnyFile, SearchRec)=0 then
    begin
      repeat
        s:=uppercase(copy(searchrec.name,1,3))+#32;
        star_combo1.items.add(s);
      until FindNext(SearchRec) <> 0;
    end;
    FindClose(SearchRec);
  end;
end;


procedure Tobjectmenu.star_combo1Change(Sender: TObject);
begin
  if length(star_combo1.text)=0 then
  begin
    name_star:='';
  end
  else
  if pos(' ',star_combo1.text)=0 then
  begin
    name_star:= lowercase(star_combo1.text)+'_hsky.dat';
    if check_external1.Checked=false then stardatabase_selected:=0;
  end
  else
  begin
    name_star:=lowercase(copy(star_combo1.text,1,3))+'_0101.290';
    if check_external1.Checked=false then stardatabase_selected:=290;
  end;
  star_combo1.color:=objectmenu.color;{take current color including nightvision colors};{file exist, so normal color, clear old red if any}

  missedupdate:=2;
  paint_sky; {rewrite window}
end;


procedure Tobjectmenu.starsonoff1Click(Sender: TObject);
begin
  if starsonoff1.checked=true then
    begin
      stars_activated:=1;
      star_combo1.Enabled:=true;
      stars_external1.Enabled:=true;
      missedupdate:=1;
    end
    else
    begin
      stars_activated:=0;
      star_combo1.Enabled:=false;
      stars_external1.Enabled:=false;
      missedupdate:=2;
    end;
  paint_sky;{rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}
  
end;

procedure Tobjectmenu.maxmagn1Exit(Sender: TObject);
var
   new  :real;
   error:integer;
begin

   val(maxmagn1.text,new,error);
   if error=0 then
   begin
     if  new<limitmagn then missedupdate:=2 else missedupdate:=1;
     limitmagn:=new;
     updown1.position:=round(new*10);
     paint_sky; {rewrite window}
   end;
end;
procedure Tobjectmenu.deepsky_combobox1Change(Sender: TObject);
begin
  name_deep:=deepsky_combobox1.text+'.hnd';
  loaddeep; {name changed, reload now}
  deepsky_combobox1.hint:=deepstring.strings[0];
  deepsky_combobox1.color:=objectmenu.color;{take current color including nightvision colors};{file exist, so normal color, clear old red if any}
  deepsky_check1.checked:=deepsky_combobox1.text<>'';
  {if deepsky_check1.checked then}
  missedupdate:=2;
  paint_sky; {rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}
end;

procedure Tobjectmenu.supl1Change(Sender: TObject);
begin
    name_supl1:=supl1.text+'.sup';
    loadsupplement1;{name changed, reload now}
    supl1.hint:=copy(supplstring1.strings[0],2,length(supplstring1.strings[0])-1);
    supl1.color:=objectmenu.color;{take current color including nightvision colors};{file exist, so normal color, clear old red if any}
    suppl1.Checked:=supl1.text<>'';
    {if objectmenu.suppl1.checked then }
    missedupdate:=2;
    paint_sky; {rewrite window}
end;

procedure Tobjectmenu.supl2Change(Sender: TObject);
begin
    name_supl2:=supl2.text+'.sup';
    loadsupplement2;{name changed, reload now}
    supl2.hint:=copy(supplstring2.strings[0],2,length(supplstring2.strings[0])-1);{update hint and remove first ";"}
    supl2.color:=objectmenu.color;{take current color including nightvision colors};{file exist, so normal color, clear old red if any}
    suppl2.Checked:=supl2.text<>'';
    {if objectmenu.suppl2.checked then }
    missedupdate:=2;
    paint_sky; {rewrite window}
end;



procedure Tobjectmenu.supl3Change(Sender: TObject);
begin
    name_supl3:=supl3.text+'.sup';
    loadsupplement3;{name changed, reload now}
    supl3.hint:=copy(supplstring3.strings[0],2,length(supplstring3.strings[0])-1);{update hint and remove first ";"}
    supl3.color:=objectmenu.color;{take current color including nightvision colors};{file exist, so normal color, clear old red if any}
    suppl3.Checked:=supl3.text<>'';
    missedupdate:=2;
    paint_sky; {rewrite window}
end;

procedure Tobjectmenu.supl3Exit(Sender: TObject);
begin
  if supl3.text='' then
  begin
    supl3Change(Sender);{clear supplement contains}
  end;
end;

procedure Tobjectmenu.supl4Change(Sender: TObject);
begin
    name_supl4:=supl4.text+'.sup';
    loadsupplement4;{name changed, reload now}
    supl4.hint:=copy(supplstring4.strings[0],2,length(supplstring4.strings[0])-1);{update hint and remove first ";"}
    supl4.color:=objectmenu.color;{take current color including nightvision colors};{file exist, so normal color, clear old red if any}
    suppl4.Checked:=supl4.text<>'';
    missedupdate:=2;
    paint_sky; {rewrite window}
end;

procedure Tobjectmenu.supl4Exit(Sender: TObject);
begin
  if supl4.text='' then
  begin
    supl4Change(Sender);{clear supplement contains}
  end;
end;

procedure Tobjectmenu.supl5Change(Sender: TObject);
begin
   name_supl5:=supl5.text+'.sup';
   loadsupplement5;{name changed, reload now}
   supl5.hint:=copy(supplstring5.strings[0],2,length(supplstring5.strings[0])-1);{update hint and remove first ";"}
   supl5.color:=objectmenu.color;{take current color including nightvision colors};{file exist, so normal color, clear old red if any}
   suppl5.Checked:=supl5.text<>'';
   missedupdate:=2;
   paint_sky; {rewrite window}
end;

procedure Tobjectmenu.toast_combobox1Change(Sender: TObject);
begin
   name_toast:=toast_combobox1.text+'.png';
   loadtoast;
   toast_combobox1.color:=objectmenu.color;{take current color including nightvision colors};{file exist, so normal color, clear old red if any}
   toast_check1.Checked:=toast_combobox1.text<>'';
   missedupdate:=2;
   paint_sky; {rewrite window}
end;

procedure Tobjectmenu.supl5Exit(Sender: TObject);
begin
  if supl5.text='' then
  begin
    supl5Change(Sender);{clear supplement contains}
  end;
end;

procedure Tobjectmenu.UpDown1Click(Sender: TObject; Button: TUDBtnType);
var  old: real;
      s : string[5];
begin
  old:=limitmagn;
  limitmagn:=updown1.position/10;
  str(limitmagn:2:1,s);
  maxmagn1.text:=s;
  if old>limitmagn then missedupdate:=2 else missedupdate:=1; {rewrite window}
  paint_sky; {rewrite window always due to toggle}
end;




procedure Tobjectmenu.cometsonoff1Click(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}

  if objectmenu.cometsonoff1.state=cbgrayed then comets_activated:=2 {all}
  else
  if objectmenu.cometsonoff1.state=cbchecked then comets_activated:=1 {auto}
  else
  comets_activated:=0;

  if comets_activated<>2 then missedupdate:=2 {clear + update}
                         else missedupdate:=1;{update}

  {comets_activated=0 off}
  {comets_activated=1 auto}
  {comets_activated=2 all}

  paint_sky; {rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}
end;

procedure Tobjectmenu.asteroidsonoffclick(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}

  if objectmenu.asteroidsonoff1.state=cbgrayed then asteroids_activated:=2 {all}
  else
  if objectmenu.asteroidsonoff1.state=cbchecked then asteroids_activated:=1 {auto}
  else
  asteroids_activated:=0;

  if asteroids_activated<>2 then missedupdate:=2 {clear + update}
                            else missedupdate:=1;{update}

  {asteroids_activated=0 off}
  {asteroids_activated=1 auto}
  {asteroids_activated=2 all}

  paint_sky; {rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}


end;

procedure Tobjectmenu.Planetsonoff1Click(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}
  if objectmenu.planetsonoff1.checked then
  begin
    planets_activated:=1;
    missedupdate:=1;
  end
  else
  begin
    planets_activated:=0;
    missedupdate:=2;
  end;
  paint_sky; {rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}
end;
procedure Tobjectmenu.StarGroupBox1MouseEnter(Sender: TObject);
begin
  densitytrackbar1.hint:=floattostr(densitytrackbar1.position);{Show value in hint}
end;

procedure Tobjectmenu.Filter1exit(Sender: TObject);
var
   new  :real;
   error:integer;
begin
   val(min_size1.text,new,error);
   if ((length(min_size1.text)>0){emphty} and (error<>0)) then
   begin
     min_size1.text:='auto';
     min_size_deep:=-1;
   end
   else
   min_size_deep:=new*10;
   filtertype:=StringReplace(filter1.text, ' ', '',[rfReplaceAll{, rfIgnoreCase}]);{remove spaces}
   filtertype:=uppercase(copy(filtertype,1,2));{filter1 function, only first two letters are used later}
   missedupdate:=2; {rewrite window}
   paint_sky;
end;


procedure Tobjectmenu.fitsonoffClick1(Sender: TObject);
begin
  if  objectmenu.fitsonoff1.checked then
  begin
    fits_insert:=1;
    missedupdate:=1;
  end
  else
  begin
    fits_insert:=0;
    missedupdate:=2;
  end;
  paint_sky;
end;

procedure Tobjectmenu.suplDropDown(Sender: TObject);
var
  SearchRec: TSearchRec;
  ss       : string;
const
    CB_SETDROPPEDWIDTH = 352;

begin
  if (Sender is TComboBox) then
    with (Sender as TComboBox) do
  begin
    items.clear;
    items.add('');{add blank}
    if sender=deepsky_combobox1 then ss:=application_path+'*.hnd'
    else
    if sender=toast_combobox1 then ss:=application_path+'*toast*.png'
    else
    ss:=documents_path+'*.sup';
    if FindFirst(ss, faAnyFile, SearchRec)=0 then
    begin
      repeat
        items.add(getsupname(searchrec.name));
       {$ifdef mswindows}
       {begin adjust width automatically}
       if (objectmenu.Canvas.TextWidth(searchrec.name)> ItemWidth) then
       ItemWidth:= objectmenu.Canvas.TextWidth((searchrec.name));{adjust dropdown with if required}
       Perform(CB_SETDROPPEDWIDTH, ItemWidth, 0);
       {end adjust width automatically}
       {$else} {unix}
       tcombobox(sender).ItemWidth:=objectmenu.Canvas.TextWidth((searchrec.name));{works only second time};
       {$endif}
      until FindNext(SearchRec) <> 0;
    end;
    FindClose(SearchRec);
  end;
end;

procedure Tobjectmenu.star_combo1DropDown(Sender: TObject);
begin
  add_files_combobox;{add files to star comboboxes}

end;


procedure Tobjectmenu.deepsky_check1Click(Sender: TObject);
begin
  if objectmenu_painting then exit;{prevent paint_sky}

  if deepsky_check1.checked then
  begin
    deep_database:=1;
    missedupdate:=1;
  end
  else
  begin
    deep_database:=0;
    missedupdate:=2;
  end;
  paint_sky; {rewrite window}
  invalidaterect(center_on.handle,nil,false); {update search window}
end;

procedure Tobjectmenu.deepsky_combobox1Exit(Sender: TObject);
begin
  if deepsky_combobox1.text='' then
  begin
    deepsky_combobox1Change(Sender);{clear deepsky contains}
  end;
end;

procedure Tobjectmenu.supl1Exit(Sender: TObject);
begin
  if supl1.text='' then
  begin
    supl1Change(Sender);{clear supplement contains}
  end;

end;

procedure Tobjectmenu.supl2Exit(Sender: TObject);
begin
  if supl2.text='' then
  begin
    supl2Change(Sender);{clear supplement contains}
  end;
end;

procedure Tobjectmenu.star_combo1Exit(Sender: TObject);
begin
  if star_combo1.text='' then
  begin
    star_combo1Change(Sender);{clear contains}
  end;
end;

procedure Tobjectmenu.help_objectmenuClick(Sender: TObject);
begin
   open_file_with_parameters(help_path,'#object_menu');
end;



end.


