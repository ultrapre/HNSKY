unit hns_Usol;
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
  Windows, {for messagebox}
  {$endif}
  {$ifdef unix}
  baseunix,
  {$endif}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type

  { Tplanetform }

  Tplanetform = class(TForm)
    ok_button: TButton;
    to_clipboard: TButton;
    bevel_time: TBevel;
    bevel_planet: TBevel;
    Bevel_main: TBevel;
    help_planetmenu: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormPaint(Sender: TObject);
    procedure ok_buttonClick(Sender: TObject);
    procedure to_clipboardClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure help_planetmenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  planetform: Tplanetform;
const
  Visibility_planets_title: string= 'Visibility of planets in the night starting ';


implementation

uses hns_main, hns_Uast,hns_Upla, hns_Unon;

{$IFDEF fpc}
  {$R *.lfm}
{$ELSE} {delphi}
  {$R *.DFM}
{$ENDIF}
procedure solartonight;

var   time,planetx        :integer;
      azimuth2,altitude2  : double;
      julian_day,wtime3   : double;
var
    rec : trect;
    sunbright    : array[0..49] of tcolor;
    planetname  :string;
    distl,distt,distt24,
    stepV,stepH          :integer;
begin
  distl:=planetform.bevel_main.left+4;{distance left}
  distt:=planetform.bevel_planet.top;
  distt24:=planetform.bevel_time.top;

  stepV:=round(planetform.bevel_planet.height/8);
  stepH:=round(planetform.bevel_main.width/(50));{about 9}


  planetform.caption:=Visibility_planets_title+': '+copy(today2,1,10);
  planetform.canvas.brush.color:=clBtnFace;
  textout_center_aligned(planetform.canvas,trunc(1*stepH)+distl,distt24,'18');
  textout_center_aligned(planetform.canvas,trunc(9*stepH)+distl,distt24,'20');
  textout_center_aligned(planetform.canvas,trunc(17*stepH)+distl,distt24,'22');
  textout_center_aligned(planetform.canvas,trunc(25*stepH)+distl,distt24,'24');
  textout_center_aligned(planetform.canvas,trunc(33*stepH)+distl,distt24,'02');
  textout_center_aligned(planetform.canvas,trunc(41*stepH)+distl,distt24,'04');
  textout_center_aligned(planetform.canvas,trunc(49*stepH)+distl,distt24,'06');

  planetform.canvas.textout(planetform.bevel_planet.left+4,distt24,copy(today2,3,8));


  planetx:=0;
  repeat
  inc(planetx);

  case planetx of 1: begin end; {sun}
                  2: begin planetname:=moon_string;end; {moon, ra2/dec2 later because moon moves fast}
                  3: begin planet(1,0 {equinox date},julian_ET,ra2,dec2,mag,length2,delta,phase,phi);planetname:=mercury_string;end;
                  4: begin planet(2,0 {equinox date},julian_ET,ra2,dec2,mag,length2,delta,phase,phi);planetname:=venus_string;end;
                  5: begin planet(4,0 {equinox date},julian_ET,ra2,dec2,mag,length2,delta,phase,phi);planetname:=mars_string;end;
                  6: begin planet(5,0 {equinox date},julian_ET,ra2,dec2,mag,length2,delta,phase,phi);planetname:=jupiter_string;end;
                  7: begin planet(6,0 {equinox date},julian_ET,ra2,dec2,mag,length2,delta,phase,phi);planetname:=saturn_string;end;
                  8: begin planet(7,0 {equinox date},julian_ET,ra2,dec2,mag,length2,delta,phase,phi);planetname:=Uranus_string;end;
            else {9} begin planet(8,0 {equinox date},julian_ET,ra2,dec2,mag,length2,delta,phase,phi);planetname:=Neptune_string;end;
    end;{case}
  if planetx<>1 then
  begin
    planetform.canvas.brush.color:=clBtnFace;
    planetform.canvas.textout(planetform.bevel_planet.left+4,distt+round((planetx-2)*stepV),planetname);
  end;


  for time:=0 to 49  do    {do from 17:45 till 06:15 hours}
  begin
    julian_day:=julian_calc(year2,month2,day2,18+{17.75+1/8 +} time/4-(timezone+daylight_saving),0,0);
    wtime3:=limit_radialen((-longitude*pi/180) + siderealtime2000 +(julian_day-2451545 ) * earth_angular_velocity,2*pi);
    if planetx<=2 then
    begin
      planet(0,0 {equinox date},julian_day,ra2,dec2,mag,length2,delta,phase,phi);{always calculate sun and T=julian in procedure planet. mod 30-12-2000}
      if planetx=2 then planet(10,0 {equinox date},julian_day,ra2,dec2,mag,length2,delta,phase,phi);{moon}
    end;

    ra_az(ra2,dec2,reallatitude,0,wtime3, azimuth2,altitude2);

    if planetx<=2 then altitude2:=altitude2 +(length2/(2*3600))*(pi/180);{sun moon not center but top}
    if apparent_horizon<>0 then altitude2:=altitude_apparent(altitude2);
                       {refraction at atmosphere, max 34 minutes near horizon}
    if planetx=1 then
    begin
      if altitude2>0 then sunbright[time]:=$00eeeeee
      else
      if (altitude2<pi*-18/180) then sunbright[time]:=clblack {sun 18 degrees below horizon, real dark}
      else sunbright[time]:=clgray;
    end
    else
    begin
      if altitude2<=0 then planetform.canvas.brush.color:=sunbright[time]
      else  planetform.canvas.brush.color:=($0000eeee or sunbright[time]);

      with rec do {draw graphic}
      begin
        left:=planetform.bevel_main.left+4+round(time*stepH);
        right:=left+stepH-2;
        top:= round(distt*1.1)+round((planetx-2)*stepV);
        bottom:=top+stepV-2;
      end;
      planetform.canvas.FillRect(Rec);
    end;
  end;
  until planetx>=9;
end;
procedure Tplanetform.FormPaint(Sender: TObject);
begin
  solartonight;
end;

procedure Tplanetform.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#27 then ok_buttonClick(nil);{close form, set form key preview on}
end;

procedure Tplanetform.ok_buttonClick(Sender: TObject);
begin
  planetform.close;   {normal this form is not loaded}
  mainwindow.setfocus;
end;

procedure Tplanetform.to_clipboardClick(Sender: TObject);
begin
  Copytoclipboard(planetform);
end;

procedure Tplanetform.FormActivate(Sender: TObject);
begin
  if language_mode<>0 then load_planet;{language module}
end;

procedure Tplanetform.help_planetmenuClick(Sender: TObject);
begin
  open_file_with_parameters(help_path,'#planet_visibility');
end;

end.





