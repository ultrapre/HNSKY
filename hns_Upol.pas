unit hns_Upol;
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
  Windows,
  {$endif}
  {$ifdef unix}
  baseunix,
  LCLIntf,{for selectobject}
  {$endif}
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,math;

type

  { TPolarscope }

  TPolarscope = class(TForm)
    Polarscopetimer: TTimer;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Polarscope: TPolarscope;

implementation

uses hns_main, hns_Uast, hns_Usol, hns_Uprs;

var
  oldviewx, oldviewy,oldzoom,oldwtime2,oldwtime2actual  : double;
  oldflipv, oldfliph, oldNORTH, oldgrid, oldlinks2, oldyear2, oldmonth2,oldday2,oldhour2, oldmin2,
  oldnortharrow, oldnorthtop,oldimage_overlap

  :integer;

{$IFDEF fpc}
  {$R *.lfm}
{$ELSE} {delphi}
  {$R *.DFM}
{$ENDIF}

procedure TPolarscope.FormPaint(Sender: TObject);
var
  dia,southF,p1,p2,p3,p4,p5,p6,i : integer;
  rax, decx,x,y,ramean,decmean, polaris_angle : double;

const
    dec_polaris2019 =  pi*((89+20/60+43/3600)/180);{polaris J2019 at 89:20:43}

    ra_polaris2000  =  pi*(2+31/60+51.9/3600)/12;
    dec_polaris2000 =  pi*((89+15/60+51/3600)/180);{polaris J2000 at 89:15:51}

begin
  getdatetime(true,false);

  if reallatitude>0 then southF:=1 else southF:=-1;

  wtime2:=wtime2actual;{important same}
  Precession(julian_ET,2451545.0{J2000},0,southf*pi/2,ramean,decmean);{Convert celestial pole to J2000.  long term precession function in hns_Uprs}
  ra_az(ramean,decmean,reallatitude,0,wtime2, viewx,viewy);   {realaltitude to ignore northup}

  RRW:=polarscope.clientrect; {get dimensions window}

  missedupdate:=2; {clear canvas}
  mainwindow.maakplaatje(polarscope.canvas,true);

  {plot circle}
  selectobject(polarscope.canvas.handle,pen1);
  for dia:=0 to 24 do {plot circle }
  begin
    rax:=dia*(pi/12); decx:=southF*dec_polaris2019;{diameter of circle in polarscope designed for 2019}
    Precession(julian_ET,2451545.0{J2000},rax,decx,ramean,decmean);{Convert celestial pole to J2000.  long term precession function in hns_Uprs}
    if dia=0 then plot_pixel_sphere(polarscope.canvas,ramean,decmean,-2,$FFFFFF,0,0) {-2 is move action to polaris Jdate}
    else
    plot_pixel_sphere(polarscope.canvas,ramean,decmean,-1,$FFFFFF,0,0); {-1 is line draw action}
  end;


  selectfont3(polarscope.canvas);
  setTextColor(polarscope.canvas.handle,colors[28]);
  RRW:=polarscope.clientrect; {get dimensions window again since it could be modiified by a paint main window}

  p5:=round(rrw.right/2);
  p6:=round(rrw.bottom/2);
  if reallatitude>0 then begin p1:=20; p2:=rrw.bottom-font_height2-5;    p3:=rrw.right-20; p4:=10; end
                    else begin p1:=rrw.bottom-font_height2-15; p2:=5;    p3:=10; p4:=rrw.right-20;  end;

  textout_center_aligned(polarscope.canvas,p5,p1,'N');
  textout_center_aligned(polarscope.canvas,p5,p2,'S');
  textout_center_aligned(polarscope.canvas,p3,p6,'W');
  textout_center_aligned(polarscope.canvas,p4,p6,'E');

  {plot some scale lines}
  Canvas.Pen.Color := $404040;
  for i:=0 to 11 do
  begin
    rotate(i*(pi/6),60,0,x,y);{rotate a vector point, angle seen from y-axis, counter clockwise}
    polarscope.canvas.moveto(p5+round(x),p6+round(y));
    polarscope.canvas.lineto(p5+round(x*1.3),p6+round(y*1.3));
  end;

  selectfont2(polarscope.canvas);

  {indicate polaris in hours}
  if southf>0 then
  begin
    plot_pixel_sphere(polarscope.canvas,ra_polaris2000,dec_polaris2000,-2,$FFFFFF,0,0); {-2 is move action to polaris Jdate}
    polaris_angle:=arctan2(x9-p5,p6-y9);{angle seen from Y axis of polaris position. Used to calculate hour angle}
    setTextColor(polarscope.canvas.handle,colors[1]);
    textout_center_aligned(polarscope.canvas,p5,rrw.bottom-60,prepare_ra2(fnmodulo(0.5*polaris_angle,pi)) );{display angle in 12:00 hour system}
  end;
  textout_right_aligned(polarscope.canvas,rrw.right-20,p1,today2);
end;

procedure TPolarscope.FormCreate(Sender: TObject);
begin
   oldviewx:=viewx;
   oldviewy:=viewy;
   oldflipv:=flipv;
   oldfliph:=fliph;
   oldzoom:=zoom;
   oldyear2:=year2;
   oldmonth2:=month2;
   oldday2:=day2;
   oldhour2:=hour2;
   oldmin2:=min2;
   oldnorth:=north;
   oldnortharrow:=northarrow;
   oldnorthtop:=northtop;
   oldgrid:=grid;
   oldwtime2:=wtime2;
   oldwtime2actual:=wtime2actual;
   oldimage_overlap:=image_overlap;

   flipv:=-1;
   fliph:=-1;
   northarrow:=0;
   zoom:=20;
   northtop:=0;
   grid:=0;
   image_overlap:=0;

   missedupdate:=0;

end;

procedure TPolarscope.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   viewx:=oldviewx;
   viewy:=oldviewy;
   flipv:=oldflipv;
   fliph:=oldfliph;
   zoom:=oldzoom;
   north:=oldnorth;
   grid:=oldgrid;
   wtime2:=oldwtime2;
   wtime2actual:=oldwtime2actual;


   year2:=oldyear2;
   month2:=oldmonth2;
   day2:=oldday2;
   hour2:=oldhour2;
   min2:=oldmin2;
   northarrow:=oldnortharrow;
   northtop:=oldnorthtop;
   image_overlap:=oldimage_overlap;

   missedupdate:=-9; {rewrite window, special -9 version to restore some variables, see below}
   invalidaterect(mainwindow.handle,nil,false);{sinviewx and others willd be modified by maakplaatje used in polarview, so recalculate}

end;

end.
