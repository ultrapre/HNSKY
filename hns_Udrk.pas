unit hns_Udrk;
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
  {$IFDEF fpc}
   LCLIntf, {for getRcolor in Linux, in windows winapi does it. Unit is already declared in main}
  {$else}  {delphi}
  {$endif}
  {$ifdef mswindows}
  Windows, {for messagebox}
  {$endif}
  {$ifdef unix}
  baseunix,
  {$endif}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type

  { Tdarkform }

  Tdarkform = class(TForm)
    backward1: TLabel;
    ColorDialog1: TColorDialog;
    col_astro1: TLabel;
    col_civil_twilight1: TLabel;
    col_nautical1: TLabel;
    forward1: TLabel;
    nautical_end1: TEdit;
    ok: TButton;
    to_clipboard: TButton;
    Bevel_hour: TBevel;
    Bevel_day: TBevel;
    Bevel_main: TBevel;
    help_darkmenu: TLabel;
    procedure backward1Click(Sender: TObject);
    procedure col_astro1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure forward1Click(Sender: TObject);
    procedure okClick(Sender: TObject);
    procedure to_clipboardClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure help_darkmenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  darkform: Tdarkform;
const
  dark_skies_title: string= 'Moon & dark skies for next days starting:';
  friday          : string= 'Fr';
  nautical_end    : double=-18;
  astro_color  : integer=clgray;
  nautical_color  : integer=clgray;
  civil_color     : integer=clgray;


implementation

uses hns_main, hns_Uast,hns_Upla, hns_Unon;

{$IFDEF fpc}
  {$R *.lfm}
{$ELSE} {delphi}
  {$R *.DFM}
{$ENDIF}

const
   day_offset:integer=0;


function color_change_intensity(col1:tcolor; intensity1:byte {0..255}):tcolor;
var
   max1,R,G,B   : integer;
begin
  R:=getRvalue(col1);
  G:=getGvalue(col1);
  B:=getBvalue(col1);

  max1:=0;
  if R>max1 then max1:=R;
  if G>max1 then max1:=G;
  if B>max1 then max1:=B;

  R:=trunc(R*intensity1/max1); {make maximum intensity}
  G:=trunc(G*intensity1/max1);
  B:=trunc(B*intensity1/max1);

  result:=RGB(R,G,B);
end;

procedure Moonfornextdays;
var
      time,dayscount,moonint, skyint,mode1,dummy1,nauticalR,nauticalG,nauticalB,civil_twilightR,civil_twilightG,civil_twilightB,astroR,astroG,astroB, err, text_height7,y7,i :integer;
      azimuth2,altitude2,  altitude3, julian_day,wtime3, midday_julian    : double;
      rec : trect;

      distl:integer;{distance from left}
      distt:integer;{distance from top}
      distt24,stepV, stepH :integer;
begin

   distl:=darkform.bevel_main.left+4;{distance left}
   distt:=darkform.bevel_day.top+1;
   distt24:=darkform.bevel_hour.top+1;

   stepV:=round(darkform.bevel_day.height/31.5);{about 15}
   stepH:=round(darkform.bevel_main.width/(50));{about 9}


  darkform.caption:=dark_skies_title+'  '+copy(JdToDate_2(julian_UT+day_offset-0.001{get correct date at 24 hours}+(timezone+daylight_saving)/24),1,10);

  darkform.canvas.brush.color:=clBtnFace;{mod 2006 may}
  textout_center_aligned(darkform.canvas,trunc(1*steph)+distl,distt24,'18');
  textout_center_aligned(darkform.canvas,trunc(9*steph)+distl,distt24,'20');
  textout_center_aligned(darkform.canvas,trunc(17*steph)+distl,distt24,'22');
  textout_center_aligned(darkform.canvas,trunc(25*steph)+distl,distt24,'24');
  textout_center_aligned(darkform.canvas,trunc(33*steph)+distl,distt24,'02');
  textout_center_aligned(darkform.canvas,trunc(41*steph)+distl,distt24,'04');
  textout_center_aligned(darkform.canvas,trunc(49*steph)+distl,distt24,'06');

  darkform.Canvas.Pen.Color:=clblack;

  for i:=0  to 12 do
  begin  {make markers for each hour}
    darkform.canvas.moveTo(trunc(-1+(1+i*4)*steph)+distl,darkform.bevel_hour.top+darkform.bevel_hour.height-6);
    darkform.canvas.LineTo(trunc(-1+(1+i*4)*steph)+distl,darkform.bevel_hour.top+darkform.bevel_hour.height);
  end;


  dayscount:=0;

  dummy1:=color_change_intensity(darkform.col_astro1.color,255);
  astroR:=getRvalue(dummy1);
  astroG:=getGvalue(dummy1);
  astroB:=getBvalue(dummy1);

  dummy1:=color_change_intensity(darkform.col_nautical1.color,255);
  nauticalR:=getRvalue(dummy1);
  nauticalG:=getGvalue(dummy1);
  nauticalB:=getBvalue(dummy1);

  dummy1:=color_change_intensity(darkform.col_civil_twilight1.color,255);
  civil_twilightR:=getRvalue(dummy1);
  civil_twilightG:=getGvalue(dummy1);
  civil_twilightB:=getBvalue(dummy1);

  val_local(darkform.nautical_end1.text, nautical_end,err);

  text_height7:=round(darkform.canvas.Textheight('F'));

  repeat
    darkform.canvas.brush.color:=clBtnFace;
    midday_julian:=julian_calc(year2,month2,day2,12 -(timezone+daylight_saving),0,0)+dayscount+day_offset;
    y7:= distt+round(dayscount*stepV);
    darkform.canvas.FillRect(Rect(darkform.bevel_day.left+1,
                                  y7,
                                  darkform.bevel_day.left+darkform.bevel_day.width-2,
                                  y7+ text_height7) );{wipe first, line by line for flicker free scrolling}

    darkform.canvas.textout(darkform.bevel_day.left+round(darkform.canvas.TextWidth(friday+'   '))+3,y7,JdToDate_3(midday_julian));
    if round(7.00*frac((midday_julian)/7))=4 then
       darkform.canvas.textout(darkform.bevel_day.left+4,y7,friday);


    for time:=0 to 49  do    {do from 17:45 till 06:15 hours}
    begin
      julian_day:=dayscount+day_offset+julian_calc(year2,month2,day2,17.75+1/8{middle of the rect}+time/4-(timezone+daylight_saving),0,0);

      wtime3:=limit_radialen((-longitude*pi/180) + siderealtime2000 +(julian_day-2451545 ) * earth_angular_velocity,2*pi);


      planet(0,0 {equinox date},julian_day,ra2,dec2,mag,length2,delta,phase,phi);
      ra_az(ra2,dec2,reallatitude,0,wtime3, azimuth2,altitude3);

      {no correction for limb and apparant required for twilight calculation:]
      {http://astro.ukho.gov.uk/nao/miscellanea/twilight/ The beginning of morning astronomical twilight and the end of evening astronomical twilight occur when the zenith distance of the centre of the Sun's disk is 108°.}
      {http://aa.usno.navy.mil/faq/docs/RST_defs.php  Astronomical twilight is defined to begin in the morning, and to end in the evening when the center of the Sun is geometrically 18 degrees below the horizon. }

      if altitude3>-2*pi/180 then {apply sun set correction for limb and apparent if above -2 degrees}
      begin
        altitude3:=altitude3 +(length2/(2*3600))*(pi/180);{sun moon not center but top}
        if apparent_horizon<>0 then altitude3:=altitude3 - apparent_horizon; {add --34=+34 minutes correction apparent horizon}
      end;
      {else twilight calculation, no correction for limb and apparent}

      planet(10,0 {equinox date},julian_day,ra2,dec2,mag,length2,delta,phase,phi);
      ra_az(ra2,dec2,reallatitude,0,wtime3, azimuth2,altitude2);

      if altitude2>-2*pi/180 then {apply sun set correction for limb and apparent if above -2 degrees}
      begin
        altitude2:=altitude2 +(length2/(2*3600))*(pi/180);{sun moon not center but top}
        if apparent_horizon<>0 then altitude2:=altitude2 -apparent_horizon; {add --34=+34 minutes correction apparent horizon}
      end;
      {else twilight calculation, no correction for limb and apparent}

      if altitude3>=0 then darkform.canvas.brush.color:=$00eeeeee  {sun above horizon}
      else
      begin
                     skyint:=round(11+altitude3*7*180/(pi*18));{intensity sky background}
                     if altitude3<pi*-18/180 then skyint:=0;{sun 18 degrees below horizon, real dark}

                     if altitude2<=0 then {moon below horizon}
                     begin
                       if altitude3<nautical_end*pi/180 then darkform.canvas.brush.color:=$000000
                       else
                       if altitude3<-12*pi/180 then darkform.canvas.brush.color:=rgb( round(astroR*skyint/16),
                                                                                      round(astroG*skyint/16),
                                                                                      round(astroB*skyint/16) )
                       else
                       if altitude3<-6*pi/180 then darkform.canvas.brush.color:=rgb( round(nauticalR*skyint/16),
                                                                                     round(nauticalG*skyint/16),
                                                                                     round(nauticalB*skyint/16) )
                       else
                                                   darkform.canvas.brush.color:=rgb(  round(civil_twilightR*skyint/16),
                                                                                      round(civil_twilightG*skyint/16),
                                                                                      round(civil_twilightB*skyint/16) )

                     end
                     else
                     begin {moon visible}
                       moonint:=round(8+ phase*7/100);
                     darkform.canvas.brush.color:=$001010*moonint;{intensity moon}
                     end
      end;


      //darkform.canvas.brush.color:=$001010;

      with rec do {draw graphic}
      begin
        left:=darkform.bevel_main.left+4+round(time*stepH);
        right:=left+stepH-1;
        top:= distt+round(dayscount*stepV);
        bottom:=top+stepV-1;
      end;
      darkform.canvas.FillRect(Rec);
    end;{time}

    inc(dayscount);

  until dayscount>30;
end;


procedure Tdarkform.FormPaint(Sender: TObject);
begin
  Moonfornextdays;
end;

procedure Tdarkform.FormShow(Sender: TObject);
begin
  nautical_end1.text:=floattostrF_local(nautical_end,0,1);{degrees below horizon}

  col_astro1.color:=astro_color;
  col_civil_twilight1.color:=civil_color;
  col_nautical1.color:=nautical_color;
end;

procedure scroll(inp1:integer);
begin
  inc(day_offset,inp1);
  Moonfornextdays;
  {$ifdef mswindows}
  {$endif}
  {$ifdef unix}
  invalidaterect(darkform.handle,nil,false);{required in Linux for refresh screen}
  {$endif}
end;

procedure Tdarkform.forward1Click(Sender: TObject);
begin
    scroll(+1);
end;

procedure Tdarkform.backward1Click(Sender: TObject);
begin
  scroll(-1);
end;

procedure Tdarkform.col_astro1Click(Sender: TObject);
begin
 if darkform.ColorDialog1.execute then
  begin
    if sender=darkform.col_nautical1 then col_nautical1.color:= color_change_intensity(darkform.ColorDialog1.color,128)
    else
    if sender=darkform.col_civil_twilight1 then col_civil_twilight1.color:= color_change_intensity(darkform.ColorDialog1.color,128)
    else col_astro1.color:= color_change_intensity(darkform.ColorDialog1.color,128);

     Moonfornextdays;
  end;
end;

procedure Tdarkform.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#27 then  okClick(nil);{close form, set form key preview on}
end;


procedure Tdarkform.okClick(Sender: TObject);
var err: integer;
begin
  val_local(nautical_end1.text,nautical_end,err);{degrees below horizon}

  civil_color:=col_civil_twilight1.color;
  astro_color:=col_astro1.color;
  nautical_color:=col_nautical1.color;

  darkform.close;   {normal this form is not loaded}
  mainwindow.setfocus;
end;

procedure Tdarkform.to_clipboardClick(Sender: TObject);
begin
  Copytoclipboard(darkform);
end;

procedure Tdarkform.FormActivate(Sender: TObject);
begin
  if language_mode<>0 then load_dark;{language module}
  day_offset:=0;{reset scroll offset}

end;

procedure Tdarkform.help_darkmenuClick(Sender: TObject);
begin
  open_file_with_parameters(help_path,'#dark_nights');
end;

end.
