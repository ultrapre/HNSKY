unit hns_Uani; {form_animation menu}
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
   lclintf, {for settextcolor}
   {$endif}
   Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ComCtrls, StdCtrls, Buttons, ExtCtrls, {Spin, Mask,} Menus,
   math;

type

  { Tform_animation }

  Tform_animation = class(TForm)
    moon_eclipse_with1: TLabel;
    sidereal_animationmenu1: TSpeedButton;
    time_step: TGroupBox;
    object_to_follow: TGroupBox;
    planetary_ComboBox: TComboBox;
    followstars: TRadioButton;
    Follow_none: TRadioButton;
    lock_on_name: TCheckBox;
    backwards_one: TButton;
    forwards_one: TButton;
    unit_comboBox: TComboBox;
    stepsize2: TEdit;
    close_button: TButton;
    help_animation: TLabel;
    plus_one: TButton;
    plus_ten: TButton;
    minus_one: TButton;
    minus_ten: TButton;
    minus_2356: TButton;
    plus_2356: TButton;
    eclipse: TGroupBox;
    eclipsebackwards: TButton;
    eclipseforwards: TButton;
    Solar_eclipse1: TRadioButton;
    Lunar_eclipse1: TRadioButton;
    Planetary_tracks: TCheckBox;
    moon_tracks: TCheckBox;
    lengthmove: TLabel;
    number_of_steps: TEdit;
    forwards_many: TButton;
    stop_button: TBitBtn;
    backwards_many: TButton;
    continuous: TCheckBox;
    ProgressBar1: TProgressBar;
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure forwardmanyclick(Sender: TObject);
    procedure close_buttonClick(Sender: TObject);
    procedure help_animationClick(Sender: TObject);
    procedure update_variables(Sender: TObject);
    procedure lock_on_nameClick(Sender: TObject);
    procedure Planetary_tracksClick(Sender: TObject);
    procedure plus_oneClick(Sender: TObject);
    procedure plus_tenClick(Sender: TObject);
    procedure minus_oneClick(Sender: TObject);
    procedure minus_tenClick(Sender: TObject);
    procedure minus_2356Click(Sender: TObject);
    procedure plus_2356Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eclipsefind(Sender: TObject);
    procedure Solar_eclipse1Click(Sender: TObject);
    procedure planetary_ComboBoxChange(Sender: TObject);
    procedure forwards_oneClick(Sender: TObject);
    procedure followstarsClick(Sender: TObject);
    procedure unit_comboBoxDropDown(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_animation: Tform_animation;

const
  step_size    : double=1.0;
  step_unit    : integer=1; {minutes}
  nr_of_steps  : double=30;{step length}
  animation_running : integer=0; {0=stopped, 1 = pause, 2= running}


procedure plot_solartracks(canvas2:tcanvas);
procedure plot_solarmove(canvas2:tcanvas);

implementation

Uses  hns_main, hns_Uast, hns_Upla, hns_Unon;

{$IFDEF fpc}
  {$R *.lfm}
{$ELSE} {delphi}
  {$R *.DFM}
{$ENDIF}

const
  factors1     : array[0..8] of double=
                       ((1/(24*60*60)),{seconds}
                        (1/(24*60)),{minutes}
                        (1/24),{hour}
                        ((23+56/60+4/3600)/24),{Sidereal day}
                        (1),{day}
                        (27.212220),{Draconic month}
                        (27.321661),{Sidereal month}
                        (29.530587981),{Synodic month}
                        (365.2421897)  {Tropical year}
                        );

var
  fast_forward_pressed, fast_backwards_pressed,stop_pressed,oldactualtime  : boolean;
  oldjulian,animation_counter,oldviewx,oldviewy : double;

procedure find_solar_eclipse(forward2: integer);
var
    ra3, dec3, separ10,separ1,separ2,stepper,stepper10,stepper1,stepper2,dia_sun,dia_moon : double;
begin
  actualtime:=false; {otherwise in maakplaatje time is read}
  mainwindow.Cursor:=crnormalcursor2; {wait cursor}
  missedupdate:=0;
  stepper:=1; {one day}
  repeat {2015, animate/movie clear old, using bitmap and then canvas}
    Application.ProcessMessages;
    inctime2(forward2*stepper);
    planet(0,2000,julian_ET,ra2,dec2,mag,dia_sun,delta,phase,phi);{alway calculate sun position, otherwise problems}
    planet(10,2000,julian_ET,ra3,dec3,mag,dia_moon,delta,phase,phi);
    ang_sep(ra2,dec2,ra3,dec3,separ10);{calculate angular distance Sun Moon}

    planet(1,2000,julian_ET,ra3,dec3,mag,length2,delta,phase,phi);
    if phase>10 then begin stepper1:=4; separ1:=99; end {at least 10 days to go, ignore when behind Sun}
    else
    begin

      ang_sep(ra2,dec2,ra3,dec3,separ1);{calculate angular distance Sun Mercury, ignore when behind sun equals phase above 50}
      stepper1:=(separ1-((dia_moon)*0.99*0.5/3600)*pi/180)*(1.3 {degrees per day} )/(2*pi); {Mercury at 14 degrees from Sun can reach Sun in 10 days}
    end;

    planet(2,2000,julian_ET,ra3,dec3,mag,length2,delta,phase,phi);
    if phase>10 then begin stepper2:=9; separ2:=99; end  {at least 18 day to go, ignore when behind Sun}
    else
    begin
      ang_sep(ra2,dec2,ra3,dec3,separ2);{calculate angular distance Sun Venus, ignore when behind sun equals phase above 50}
      stepper2:=(separ2-((dia_moon)*0.99*0.5/3600)*pi/180)*(1.3 {degrees per day} )/(2*pi); { Venus at 25 degrees from Sun can reach Sun in 18 days, so 1.3 degrees per day  }
    end;

    stepper10:=(separ10-((dia_sun+dia_moon)*0.99*0.5/3600)*pi/180)*(13 {13 degrees per day} )/(2*pi); {moon takes more then 27 days to go around, about 14 degrees per day.}

    stepper:=min(stepper1,stepper2);{take shortest angular distance}
    stepper:=min(stepper,stepper10);{take shortest angular distance}

    stepper:=max(stepper,1/(24*3600));{minimum step one minute, take largest value}

    ra_az(ra3,dec3,reallatitude,0, wtime2actual,azimuth2,altitude2); {new 19-12-2000, for current date !!}
  until (
        ((altitude2>0) and {above horizon}
        (
          (separ10*180*60/pi<=(dia_sun+dia_moon)/120) or
          (abs(separ1)*180*60/pi <= dia_sun*1.03/120) or
          (separ2*180*60/pi <= dia_sun*1.03/120) or
          (julian_UT>2543220 {year 2250}) or
          (julian_UT<2360235 {year 1750}))) or
          (missedupdate<>0) {or  (hns_keypressed)});

  missedupdate:=2;
  if sidereal=0 then wtime2:=wtime2actual;
  ra_az( ra2,dec2,latitude,0,wtime2,{var} viewx,viewy); {move sphere to center object}
//  mainwindow.maakplaatje(bitmap2.canvas); {see before if persistent2<>0 used_canvas:=mainwindow.Canvas (direct canvas) else used_canvas:=bitmap2.canvas(indirect canvas)}
//  mainwindow.Canvas.Draw(0, 0, Bitmap2);{simple repaint canvas, restore fast using bitmap copy}
//  mainwindow.Canvas.CopyRect(rrw,Bitmap2.Canvas,rect(image_overlap,image_overlap,image_overlap+rrw.right,image_overlap+rrw.bottom));{This is twice faster then mainwindow.image1.repaint !!!!!}
  paint_sky;

  mainwindow.Cursor:=crnormalcursor;{normal}

end;

procedure find_lunar_eclipse(forward2: integer);
var
    ra3,dec3,ra2_moon, dec2_moon,separ, separX,stepper,separ_S,
    dia_sun,dia_moon,  umbra, penumbra,ra2_sun,dec2_sun,moon_phase : double;
    i, close_planet: integer;
begin
  actualtime:=false; {otherwise in maakplaatje time is read}
  mainwindow.Cursor:=crnormalcursor2; {wait cursor}
  missedupdate:=0;

  stepper:=1; {one day}
  repeat {2015, animate/movie clear old, using bitmap and then canvas}

    Application.ProcessMessages;
    inctime2(forward2*stepper);

    planet(0,2000,julian_ET,ra2_sun,dec2_sun,mag,dia_sun,delta,phase,phi);{alway calculate sun position, otherwise problems}
    planet(10,2000,julian_ET,ra2_moon,dec2_moon,mag,dia_moon,delta,moon_phase,phi);
    ra_az(ra2_moon,dec2_moon,reallatitude,0, wtime2actual,azimuth2,altitude2); {new 19-12-2000, for current date !!}


    planet(3,2000,julian_ET,ra3,dec3,mag,umbra,delta,penumbra,phi);{calculate earth shadow position in or exclusief parallax}
    if moon_phase>99.8 then
     begin
       ang_sep(ra3,dec3,ra2_moon,dec2_moon,separ_S);{calculate angular distance shadow and moon}
     end
     else
     ang_sep(ra2_sun+pi,-dec2_sun,ra2_moon,dec2_moon,separ_S);{calculate angular distance opposite Sun and moon}

    separ:=99999;
    for I:=1 to 8 do {Mars to Neptune}
    begin
       if I<>3 then {skip earth here}
       begin
         planet(I,2000,julian_ET,ra3,dec3,mag,length2,delta,phase,phi);{calculate earth shadow position in or exclusief parallax}
       end
       else {Aldebaran star}
       begin ra3:=(4+35/60+55.3/3600)*pi/12; dec3:=(16+30/60+30/3600)*pi/180;end;

       ang_sep(ra3,dec3,ra2_moon,dec2_moon,separX);{calculate angular distance}
       if separ>separX then begin separ:=separX; close_planet:=I; end;{take smallest distance}


    end;

    if separ>separ_S then begin separ:=separ_S; close_planet:=33;{shadow} end;{take smallest distance}
    stepper:=(separ-((dia_sun+dia_moon)*0.99*0.5/3600)*pi/180)*(13 {13 degrees per day} )/(2*pi); {moon takes more then 27 days to go around, about 14 degrees per day.}
    stepper:=max(stepper,1/(24*3600));{minimum step one minute}
  until (
        ((altitude2 - apparent_horizon>0) and {0  degrees above horizon}
        (
        (separ_S*180*60/pi<=(dia_moon+umbra*dia_moon)/120 ) or {distance moon/umbra, diameter umbra in moon diameters}
         (separ *180*60/pi<=(dia_moon)*1.03/120 ) or {distance moon/umbra, diameter umbra in moon diameters}

        (julian_UT>2543220 {year 2250})   or
        (julian_UT<2360235 {year 1750}))) or (missedupdate<>0) {or  (hns_keypressed)});


//  selectfont2(canvas2);
//  SetTextAlign(canvas2.handle,ta_right or ta_baseline);
//  SetTextColor(canvas2.handle,colors[1]);
//  setbkmode(canvas2.handle,Opaque);
//  s:=double_to_string_4digit_max(altitude2*180/pi);
//  s2:=prepare_ra2(ra2_moon);
//  s3:=prepare_dec2(dec2_moon);
//  canvas2.textout(400,400,s+ '               '+s2+ '               '+s3);


  if sidereal=0 then wtime2:=wtime2actual;
  ra_az( ra2_moon,dec2_moon,latitude,0,wtime2,{var} viewx,viewy); {move sphere to center object with WTIME2, not WTIME2ACTUAL}
  missedupdate:=2;
  paint_sky;

  mainwindow.Cursor:=crnormalcursor;{normal}

  case close_planet of
   1: form_animation.moon_eclipse_with1.caption:=Mercury_string;
   2: form_animation.moon_eclipse_with1.caption:=Venus_string;
   3: form_animation.moon_eclipse_with1.caption:='Aldebaran';
   4: form_animation.moon_eclipse_with1.caption:=Mars_string;
   5: form_animation.moon_eclipse_with1.caption:=Jupiter_string;
   6: form_animation.moon_eclipse_with1.caption:=saturn_string;
   7: form_animation.moon_eclipse_with1.caption:=uranus_string;
   8: form_animation.moon_eclipse_with1.caption:=Neptune_string;
   33:form_animation.moon_eclipse_with1.caption:='Lunar eclipse';
   end;

end;

procedure plot_solartracks(canvas2:tcanvas);
var oldnaming                       : integer;
    oldactualtime                   : boolean;
    ber2,ber3                        : string;
begin
  if animation_running<=0 then
  begin
    oldjulian:=julian_UT; {do nut update if already running without tracks and pauzed}
    oldactualtime:=actualtime;
  end
  else
  begin
    julian_UT:=oldjulian; {use julian from pauzed plot_solarmove}
  end;
  animation_running:=2;
  oldnaming:=naming;{to allow surpressing naming}
  naming:=-99999;
  actualtime:=false; {otherwise in maakplaatje time is read}
   animation_counter:=0;

  selectfont2(canvas2);
  SetBkColor(canvas2.handle, colors[0] {000000});
  settextcolor(canvas2.handle,colors[1]);

  ber2:=double_to_string_4digit_max(step_size*nr_of_steps*factors1[step_unit])+' '+days_plot_string;
  ber3:=double_to_string_4digit_max(step_size*factors1[step_unit]);


  textout_right_aligned(canvas2,image_overlap+rrw.right-round(font_width2*1.725),image_overlap+round(rrw.top+(mainwindow.date_and_time1.top*2+mainwindow.date_and_time1.height)),ber2); {give plot length}
  missedupdate:=0;

  repeat
    Application.ProcessMessages;
    animation_counter:=animation_counter+1;
    inctime2(step_size*factors1[step_unit]);
    mainwindow.statusbar1.caption:=ber2+', '+inttostr(trunc(animation_counter))+' x ' + ber3 ;{tell where we are}

    Application.ProcessMessages;{clear all messages such as many mouse moves otherswise the application hangs !!!!!}
    if planets_activated<>0 then plot_PLANETS2(false,canvas2){planets}
       else planet(0,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);{alway calculate sun position, otherwise problems}
    if comets_activated<>0 then plot_COMETS(canvas2);
    if asteroids_activated<>0 then plot_ASTEROIDS(canvas2);
    if ((planets_activated<>0) and (plot_moon_movement<>0)) then plot_PLANETS2(true,canvas2);{the moon}
    form_animation.progressbar1.position:=trunc(100*(abs(animation_counter)/nr_of_steps));


  until ((abs(animation_counter)>=nr_of_steps) or (missedupdate<>0) {or  (hns_keypressed)});
  julian_UT:=oldjulian;{ back to original time}
  animation_running:=0;
  inctime2(0);{reconstruct date with this instruction using only julian date}
  naming:=oldnaming;{back to normal naming}
  actualtime:=oldactualtime;
end;


procedure plot_solarmove(canvas2:tcanvas);
var ber2, ber3  : string;
    store1      : boolean;
begin
  if animation_running=0 then
  begin
    oldjulian:=julian_UT;
    oldviewx:=viewx;
    oldviewy:=viewy;
    oldactualtime:=actualtime;
    animation_counter:=0;
    actualtime:=false; {otherwise in maakplaatje time is read}
    fast_forward_pressed:=false;
    fast_backwards_pressed:=false;
    animation_running:=2;
  end;

  store1:=mainwindow.toolbar2.Visible;{store mainmenu settings}
  mainwindow.toolbar2.Visible:=false;{hide flickering maninmenu}

  selectfont2(canvas2);
  SetTextColor(canvas2.handle,colors[1]);{required after selection new font}
  ber2:=double_to_string_4digit_max(step_size*nr_of_steps*factors1[step_unit])+' '+days_plot_string;
  ber3:=double_to_string_4digit_max(step_size*factors1[step_unit]);

  repeat {2015, animate/movie clear old, using bitmap and then canvas}
    animation_counter:=animation_counter+1;
    mainwindow.statusbar1.caption:=ber2+', '+inttostr(trunc(animation_counter))+' x '+ber3;{tell where we are}
    inctime2(step_size*factors1[step_unit]);
    missedupdate:=2;{wipe previous plot}
    paint_sky;

    form_animation.progressbar1.position:=trunc(100*(abs(animation_counter)/nr_of_steps));

    Application.ProcessMessages;{clear all messages such as many mouse moves otherswise the application hangs !!!!!}

    if ((stop_pressed) and (animation_running=1)) then  animation_running:=0 {stop}
    else
    if   stop_pressed then  animation_running:=1{pause}
    else
    if ((fast_forward_pressed) or (fast_backwards_pressed)) then animation_running:=1{pauze}
    else
    if  ((abs(animation_counter)>=nr_of_steps) {or (missedupdate<>0)} or (year2>9899) or (year2<=100)) then animation_running:=-1{expired}
    else
    if form_animation.visible=false then animation_running:=-2 {stop when form_animation is not visible}
    else
    animation_running:=2;


    if animation_running<=0 then {stop form_animation}
    begin
      julian_UT:=oldjulian;{ back to original time}
      inctime2(0);{reconstruct date with this instruction using only julian date}
      actualtime:=oldactualtime;
      viewx:=oldviewx;
      viewy:=oldviewy; {move to old position}

      if ((form_animation.continuous.checked=false) or (animation_running=-2){=form_animation.visible=false}) then
      begin
        animation_running:=0;
        missedupdate:=2;{wipe previous plot}
        paint_sky; {new plot}
      end
      else
      begin
        animation_counter:=0;
        animation_running:=2;{keep on running}
      end;
    end;{stop form_animation}
  until animation_running<>2;

  mainwindow.toolbar2.Visible:=store1;{recover mainmenu};

end;

procedure Tform_animation.forwardmanyclick(Sender: TObject);
begin
  fast_forward_pressed:=sender=forwards_many;
  fast_backwards_pressed:=sender=backwards_many;
  stop_pressed:=sender=stop_button;

  if animation_running<2 then {stopped or pauze}
  begin
    actualtime:=false;{can't do this with actual time is on}
    update_variables(nil);
    locknaam2:=form_animation.planetary_combobox.text;

    if (sender=backwards_many) then step_size:=-abs(step_size) else step_size:=abs(step_size);
    if tracks2<>0 then
    begin
      done_tracks:=false;{allow plotting tracks in the end of maakplaatje}
      locknaam2:='';{otherwise strange things happen}
      missedupdate:=3;
      paint_sky;
    end {rewrite window}
    else
    begin
      fast_forward_pressed:=false;
      fast_backwards_pressed:=false;
      plot_solarmove(mainwindow.image1.Canvas);
    end;
  end;
  mainwindow.SetFocus;{active control back to mainwindow}
end;

procedure Tform_animation.FormShow(Sender: TObject);
begin
   unit_comboBox.itemindex:=step_unit;

   form_animation.number_of_steps.text:=double_to_string_4digit_max(nr_of_steps);
   form_animation.stepsize2.text:= double_to_string_4digit_max(step_size);
   form_animation.moon_tracks.checked:=plot_moon_movement<>0;
   form_animation.planetary_tracks.checked:=tracks2<>0;
   followstars.checked:=sidereal<>0;
   follow_none.checked:=followstars.checked=false;
   sidereal_animationmenu1.down:=sidereal<>0;{update glyph, groupindex should be <>0, allowup:=true}
   Solar_eclipse1.checked:=find_solareclipse<>0;
   mainwindow.SetFocus;{active control back to mainwindow}

   moon_eclipse_with1.caption:='';
end;

procedure Tform_animation.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#27 then {leave form, keypreview of form should on}
     form_animation.close_buttonClick(nil);
end;

procedure Tform_animation.forwards_oneClick(Sender: TObject);
var
  old_animation_running:integer;
begin
  mainwindow.SetFocus;{active control back to mainwindow}
  if (sender=backwards_one) then step_size:=-abs(step_size) else step_size:=abs(step_size);

  old_animation_running:=animation_running;{backup}
  animation_running:=1;{pause, this only to allow update date time canvas in planetary mode using canvas_field_message}

  inctime2(factors1[step_unit]*step_size);
  missedupdate:=2;
  paint_sky; {rewrite window}

  animation_running:=old_animation_running;{restore old setting}
end;


procedure Tform_animation.eclipsefind(Sender: TObject);
begin
  screen.cursor:=crHourglass;
  Application.ProcessMessages ;
  planets_activated:=1;{always on}
  form_animation.Lock_on_name.Checked:=false; {always otherwise it lock on locknaam during painting}
  sidereal:=1;{ in case the time + and - buttons are used to findout contact times}
  moon_eclipse_with1.caption:='';

  if sender=eclipseforwardS then
     begin
     if solar_eclipse1.checked then
       begin
         fits_insert:=0;{allow to see the moon}
         find_solar_eclipse(1);
       end
       else
       find_lunar_eclipse(1);
     end
     else
     begin
     if solar_eclipse1.checked then
       begin
        fits_insert:=0;  {allow to see the moon}
        find_solar_eclipse(-1);
       end
       else
       find_lunar_eclipse(-1);
     end;
  screen.cursor:=crdefault;
  Application.ProcessMessages ;
  mainwindow.SetFocus;{active control back to mainwindow}
end;

procedure Tform_animation.followstarsClick(Sender: TObject);
begin
  if followstars.checked then sidereal:=1 else sidereal:=0;
  mainwindow.Sidereal1.checked:=sidereal<>0;
  sidereal_animationmenu1.down:=sidereal<>0;{updateglyph, groupindex should be <>0, allowup:=true}

  if sidereal=0 then
  begin
   missedupdate:=2;
   {wtime2 is following wtime2actual and updated}
    wtime2:=wtime2actual;{update already wtime2}
  end
  else
  begin
    missedupdate:=1;
    {wtime2 is frozen. wtime2actual is updated}
  end;
  paint_sky;
end;


procedure Tform_animation.help_animationClick(Sender: TObject);
begin
  open_file_with_parameters(help_path,'#animation');
end;

procedure Tform_animation.lock_on_nameClick(Sender: TObject);
begin
  if Lock_on_name.Checked then
  begin
    locknaam2:=planetary_combobox.Text;
  end
  else
  begin
    {wtime2 will now suddenly follow wtime2actual so move viewx, viewy to cope in advance}
    wtime2:=wtime2actual;
    ra_az( telescope_ra,telescope_dec,latitude,0,wtime2actual,{var} viewx,viewy); {move sphere to center object}

  end;
  follow_none.enabled:=lock_on_name.checked=false;
  followstars.enabled:=lock_on_name.checked=false;
  sidereal_animationmenu1.enabled:=lock_on_name.checked=false;{update glyph, groupindex should be <>0, allowup:=true}

  missedupdate:=2;{clear also lock=raDEC}
  paint_sky; {rewrite window}
end;

procedure Tform_animation.minus_2356Click(Sender: TObject);
begin
  actualtime:=false;{can't do this with actual time is on}
  inctime2(-(23/24 +56/(24*60) +4/(24*3600)) );
  mainwindow.SetFocus;{active control back to mainwindow}
  missedupdate:=2;paint_sky; {rewrite window}
end;
procedure Tform_animation.plus_2356Click(Sender: TObject);
begin
  actualtime:=false;{can't do this with actual time is on}
  inctime2(+(23/24 +56/(24*60) +4/(24*3600)) );
  mainwindow.SetFocus;{active control back to mainwindow}
  missedupdate:=2;paint_sky; {rewrite window}
end;

procedure Tform_animation.minus_oneClick(Sender: TObject);
begin
  actualtime:=false;{can't do this with actual time is on}
  inctime2(-1/(24*60));
  mainwindow.SetFocus;{active control back to mainwindow}
  missedupdate:=2;paint_sky; {rewrite window}
end;

procedure Tform_animation.minus_tenClick(Sender: TObject);
begin
  actualtime:=false;{can't do this with actual time is on}
  inctime2(-10/(24*60));
  mainwindow.SetFocus;{active control back to mainwindow}
  missedupdate:=3;paint_sky; {rewrite window}
end;

procedure Tform_animation.close_buttonClick(Sender: TObject);
begin
  form_animation.update_variables(Sender);
  form_animation.visible:=false;  {hide window}
  mainwindow.setfocus;
end;


procedure Tform_animation.plus_oneClick(Sender: TObject);
begin
  actualtime:=false;{can't do this with actual time is on}
  inctime2(1/(24*60));
  mainwindow.SetFocus;{active control back to mainwindow}
  missedupdate:=3;paint_sky; {rewrite window}
end;

procedure Tform_animation.plus_tenClick(Sender: TObject);
begin
  actualtime:=false;{can't do this with actual time is on}
  inctime2(10/(24*60));
  mainwindow.SetFocus;{active control back to mainwindow}
  missedupdate:=3;paint_sky; {rewrite window}
end;

procedure Tform_animation.planetary_ComboBoxChange(Sender: TObject);
begin
  if Lock_on_name.Checked then
       locknaam2:=planetary_combobox.Text;
end;

procedure Tform_animation.Solar_eclipse1Click(Sender: TObject);
begin

  if solar_eclipse1.checked then find_solareclipse:=1 else find_solareclipse:=0;
  mainwindow.SetFocus;{active control back to mainwindow}
end;

procedure Tform_animation.Planetary_tracksClick(Sender: TObject);
begin
  lock_on_name.enabled:=planetary_tracks.Checked=false;
  if planetary_tracks.Checked then lock_on_name.checked:=false;
  planetary_combobox.enabled:=planetary_tracks.Checked=false;
  moon_tracks.enabled:=planetary_tracks.Checked=true;
  continuous.enabled:=planetary_tracks.Checked=false;
  planetary_tracks.enabled:=continuous.Checked=false;
  mainwindow.SetFocus;{active control back to mainwindow}

end;


procedure Tform_animation.unit_comboBoxDropDown(Sender: TObject);
begin
  {$ifdef mswindows}
  SendMessage(unit_ComboBox.Handle, CB_SETDROPPEDWIDTH, Canvas.TextWidth('Draconic month')+8, 0);{adjust width to largest width}
  {$endif}
end;

procedure Tform_animation.update_variables(Sender: TObject);
var  err      :integer;
begin
  if form_animation.moon_tracks.checked then plot_moon_movement:=1 else plot_moon_movement:=0;
  if form_animation.planetary_tracks.checked then tracks2:=1 else tracks2:=0;
  val(form_animation.stepsize2.text,step_size,err); step_size:=minmax(step_size,0.0001,999999);
  val(form_animation.number_of_steps.text,nr_of_steps,err);
  step_unit:=unit_comboBox.itemindex;
  follow_none.enabled:=lock_on_name.checked=false;
  followstars.enabled:=lock_on_name.checked=false;
  sidereal_animationmenu1.down:=lock_on_name.checked=false;{update glyph, groupindex should be <>0, allowup:=true}
  mainwindow.SetFocus;{active control back to mainwindow}

end;

procedure Tform_animation.FormCreate(Sender: TObject);
begin
  if language_mode<>0 then load_animation;
  form_animation.top:=animationtop;
  form_animation.left:=animationleft;

  {$ifdef mswindows}
  {$else} {unix}
   planetary_ComboBox.autodropdown:=false;{required to enable manual entry. Bug Linux version?}
  {$endif}

  {in tmainwindow.update_menu: settime.followtime_toolButton.down:=actualtime;} {update tool button}
end;


end.
