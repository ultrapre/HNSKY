unit hns_Ugot;
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
 baseunix,
 LCLIntf,{for selectobject, invalidaterect}
 {$endif}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,strutils;


type

  { Tmove_to }

  Tmove_to = class(TForm)
    rightascension1: TEdit;
    declination1: TEdit;
    ok_button1: TBItBtN;
    cancel_button1: TBItBtN;
    Westbutton1: TBItBtN;
    Zenithbutton1: TBItBtN;
    Eastbutton1: TBItBtN;
    Southbutton1: TBItBtN;
    Northbutton1: TBItBtN;
    Bevel1: TBevel;
    zoomnew1: TEdit;
    right_ascension_symbol1: TLabel;
    Declination_symbol1: TLabel;
    View_height: TLabel;
    Equinoxasset: TLabel;
    position_line1: TEdit;
    help_movemenu: TLabel;
    procedure declination1Change(Sender: TObject);
    procedure ok_button1Click(Sender: TObject);
    procedure cancel_button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Northbutton1Click(Sender: TObject);
    procedure rightascension1Change(Sender: TObject);
    procedure Southbutton1Click(Sender: TObject);
    procedure Westbutton1Click(Sender: TObject);
    procedure Eastbutton1Click(Sender: TObject);
    procedure Zenithbutton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure position_line1Change(Sender: TObject);
    procedure help_movemenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  move_to: Tmove_to;

implementation

uses hns_main, hns_Uast,  hns_Upla, hns_unon;

{$IFDEF fpc}
  {$R *.lfm}
{$ELSE} {delphi}
  {$R *.DFM}
{$ENDIF}

var
  ra_radians, dec_radians : double;
  errorRA,errorDec : boolean;

procedure ra_text_to_radians(inp :string; var ra : double; var errorRA :boolean); {convert ra in text to double in radians}
var
  rah,ram,ras,plusmin :double;
  position1,position2,position3,error1,error2,error3:integer;
begin

  inp:= stringreplace(inp, ',', '.',[rfReplaceAll]);
  inp:= stringreplace(inp, ':', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, 'h', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, 'm', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, 's', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, #39, ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, '"', ' ',[rfReplaceAll]);

  inp:= stringreplace(inp, '  ', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, '  ', ' ',[rfReplaceAll]);

  inp:=trim(inp)+' ';
  if pos('-',inp)>0 then plusmin:=-1 else plusmin:=1;

  position1:=pos(' ',inp);
  val(copy(inp,1,position1-1),rah,error1);

  position2:=posex(' ',inp,position1+1);
  if position2-position1>1 then {ram available}
  begin
    val(copy(inp,position1+1,position2-position1-1),ram,error2);

    {ram found try ras}
    position3:=posex(' ',inp,position2+1);
    if position3-position2>1 then val( copy(inp,position2+1,position3-position2-1),ras,error3)
       else begin ras:=0;error3:=0;end;
  end
  else
    begin ram:=0;error2:=0; ras:=0; error3:=0; end;

  ra:=plusmin*(abs(rah)+ram/60+ras/3600)*pi/12;
  errorRA:=((error1<>0) or (error2>1) or (error3<>0) or (ra>2*pi));
end;

procedure dec_text_to_radians(inp :string; var dec : double; var errorDEC :boolean); {convert dec in text to double in radians}
var
  decd,decm,decs :double;
  position1,position2,position3,error1,error2,error3,plusmin:integer ;
begin
  inp:= stringreplace(inp, ',', '.',[rfReplaceAll]);
  inp:= stringreplace(inp, ':', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, 'd', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, 'm', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, 's', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, #39, ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, '"', ' ',[rfReplaceAll]);

  inp:= stringreplace(inp, '°', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, '  ', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, '  ', ' ',[rfReplaceAll]);
  inp:= stringreplace(inp, '+ ', '',[rfReplaceAll]);{for between 0 and +10 degrees declination}
  inp:= stringreplace(inp, '- ', '-',[rfReplaceAll]);{for between 0 and -10 degrees declination}
  inp:=trim(inp)+' ';
  if pos('-',inp)>0 then plusmin:=-1 else plusmin:=1;



  position1:=pos(' ',inp);
  val(copy(inp,1,position1-1),decd,error1);


  position2:=posex(' ',inp,position1+1);
  if position2-position1>1 then {decm available}
  begin
    val(copy(inp,position1+1,position2-position1-1),decm,error2);

    {decm found try decs}
    position3:=posex(' ',inp,position2+1);
    if position3-position2>1 then val( copy(inp,position2+1,position3-position2-1),decs,error3)
       else begin decs:=0;error3:=0;end;
  end
  else
    begin decm:=0;error2:=0;decs:=0; error3:=0; end;

  dec:=plusmin*(abs(decd)+decm/60+decs/3600)*pi/180;
  errorDEC:=((error1<>0) or (error2>1) or (error3<>0));
end;


procedure Tmove_to.ok_button1Click(Sender: TObject);
var
  zoom_new    :double;
  err         : integer;

begin
  if ((errorRa) or (errorDec))  then exit;{continue till no error}

  val(zoomnew1.text,zoom_new,err);
  if zoom_new<1 then zoom_new:=1;
  if err=0 then zoom:=((field_factor)/zoom_new) else exit;

  move_to.visible:=false;  {hide window}
  mainwindow.setfocus;

  if equinox<>2000 then
  begin
     if equinox=1950 then ep(1950,2000,ra_radians, dec_radians,telescope_ra,telescope_dec){convert to 2000} {reverse as other ep call !!!}
     else {equinox<=1}
     ep(2000+(julian_UT-2451545.0)/365.25,2000,ra_radians, dec_radians,telescope_ra,telescope_dec);{convert to 2000} {reverse as other ep call !!!}
  end
  else begin telescope_ra:=ra_radians; telescope_dec:=dec_radians; end;{equinox 2000}

  ra_az(telescope_ra,telescope_dec,latitude,0,wtime2,{var} viewx,viewy); {move sphere to center object}

  missedupdate:=2; {rewrite window}
  paint_sky;

end;

procedure Tmove_to.declination1Change(Sender: TObject);
var
   errorDEC : boolean;
begin
  dec_text_to_radians(declination1.text,dec_radians,errorDEC); {convert dec in text to double in radians}
  if (errorDEC) then move_to.declination1.color:=clred else move_to.declination1.color:=cldefault;
end;

procedure Tmove_to.position_line1Change(Sender: TObject);
var
  data0, data1  :string;
  pos1,pos2,pos3,pos4,pos5,pos6,fout,i :integer;
begin
 {Simbad sirius    06 45 08.917 -16 42 58.02      }
 {Orion   5h 35.4m; Declination_symbol1: 5o 27′ south    }
 {http://www.rochesterastronomy.org/supernova.html#2020ue
  R.A. = 00h52m33s.814, Decl. = +80°39'37".93 }

  data0:=position_line1.Text;
  data0:=StringReplace(data0,'s.','.',[]); {for 00h52m33s.814}
  data0:=StringReplace(data0,'".','.',[]); {for +80°39'37".93}
  data0:=StringReplace(data0,'R.A.','',[]); {remove dots from ra}
  data0:=StringReplace(data0,'Decl.','',[]);{remove dots from decl}
  data1:='';

  for I := 1 to length(data0) do
  begin
    if (((ord(data0[i])>=48) and (ord(data0[i])<=57)) or (data0[i]='.') or   (data0[i]='-')) then   data1:=data1+data0[i] else data1:=data1+' ';{replace all char by space except for numbers and dot}
  end;
  repeat  {remove all double spaces}
    i:=pos('  ',data1);
    if i>0 then delete(data1,i,1);
  until i=0;;

  while ((length(data1)>=1) and (data1[1]=' ')) do {remove spaces in the front for pos1 detectie}
                                     delete(data1,1,1);
  while ((length(data1)>=1) and (data1[length(data1)]=' ')) do {remove spaces in the end since VAL( can't cope with them}
                                     delete(data1,length(data1),1);
  pos1:=pos(' ',data1);  if pos1=0 then exit;
  pos2:=posEX(' ',data1,pos1+1); if pos2=0 then pos2:=length(data1)+1;
  pos3:=posEX(' ',data1,pos2+1); if pos3=0 then pos3:=length(data1)+1;
  pos4:=posEX(' ',data1,pos3+1); if pos4=0 then pos4:=length(data1)+1;
  pos5:=posEX(' ',data1,pos4+1); if pos5=0 then pos5:=length(data1)+1;
  pos6:=posEX(' ',data1,pos5+1); if pos6=0 then pos6:=length(data1)+1;

  if pos5<>pos6  then {6 string position}
  begin
    move_to.rightascension1.text:=copy(data1,1, pos3);
    move_to.declination1.text:=copy(data1,pos3+1,99);
  end
  else
  begin {4 string position}
    move_to.rightascension1.text:=copy(data1,1, pos2);
    move_to.declination1.text:=copy(data1,pos2+1,99);
   end;
end;

procedure Tmove_to.cancel_button1Click(Sender: TObject);
begin
  move_to.visible:=false;
  mainwindow.setfocus;
end;

procedure Tmove_to.FormActivate(Sender: TObject);
var
  h,m          :integer;
  ra3,dec3     :double;
  s            : string;
begin

  if equinox<>2000 then
  begin
    if equinox=1950 then ep(2000,1950,telescope_ra,telescope_dec,ra3,dec3) {convert to 1950}
    else {equinox<=1}
    ep(2000,2000+(julian_UT-2451545.0)/365.25,telescope_ra,telescope_dec,ra3,dec3); {convert to actual}
  end
  else begin ra3:=telescope_ra; dec3:=telescope_dec; end;{equinox 2000}

  rightascension1.text:=prepare_ra(ra3);
  declination1.text:=prepare_dec(dec3);

  str((field_factor)/zoom:4:1,s);
  zoomnew1.text:=s;

  ActiveControl:=rightascension1;{set on rightascension1 hours}
end;

procedure Tmove_to.FormDeactivate(Sender: TObject);
begin
  mainwindow.setfocus;
end;


procedure Tmove_to.help_movemenuClick(Sender: TObject);
begin
  open_file_with_parameters(help_path,'#goto_menu');
end;

procedure Tmove_to.Northbutton1Click(Sender: TObject);
begin
  northtop:=0; {does not work well with north up}
  zoom:=1;
  viewy:=0.8;
  viewx:=0;
  mainwindow.setfocus;
  missedupdate:=2; {rewrite window}
  paint_sky;
end;

procedure Tmove_to.rightascension1Change(Sender: TObject);
var
  errorRA : boolean;
begin  ra_text_to_radians(rightascension1.text,ra_radians,errorRA); {convert ra in text to double in radians}
  if errorRA then rightascension1.color:=clred else rightascension1.color:=cldefault;
end;

procedure Tmove_to.Southbutton1Click(Sender: TObject);
begin
  northtop:=0; {does not work well with north up}
  zoom:=1;
  viewy:=0.8;
  viewx:=pi;
  mainwindow.setfocus;
  missedupdate:=2; {rewrite window}
  paint_sky;
end;

procedure Tmove_to.Westbutton1Click(Sender: TObject);
begin
  northtop:=0; {does not work well with north up}
  zoom:=1;
  viewy:=0.8;
  viewx:=pi*3/2;
  mainwindow.setfocus;
  missedupdate:=2; {rewrite window}
  paint_sky;
end;

procedure Tmove_to.Eastbutton1Click(Sender: TObject);
begin
  northtop:=0; {does not work well with north up}
  zoom:=1;
  viewy:=0.8;
  viewx:=pi/2;
  mainwindow.setfocus;
  missedupdate:=2; {rewrite window}
  paint_sky;
end;

procedure Tmove_to.Zenithbutton1Click(Sender: TObject);
begin
  northtop:=0; {does not work well with north up}
  zoom:=0.9/(pi/2);
  viewy:=pi/2;
  if north=1 then begin viewx:=pi;end
            else  begin viewx:=0; end;
  mainwindow.setfocus;
  missedupdate:=2; {rewrite window}
  paint_sky;
end;

procedure Tmove_to.FormCreate(Sender: TObject);
begin
  if language_mode<>0 then load_goto;{language module}
  position:=podesigned;{otherwise positioning doesn't work in FPC}
  move_to.top:=gotomenutop;
  move_to.left:=gotomenuleft;

end;

end.
