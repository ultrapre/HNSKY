unit hns_Utim;
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
  LCLIntf,{for selectobject, invalidaterect}
  {$endif}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, ExtDlgs, Calendar, DateTimePicker;
type

  { TSettime }

  TSettime = class(TForm)
    CalendarDialog1: TCalendarDialog;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Date_label1: TLabel;
    ok_button1: TBitBtn;
    ok_button2: TBitBtn;
    siderealtoolbutton2: TToolButton;
    time_label1: TLabel;
    live_update1: TToggleBox;
    UT_label1: TLabel;
    day1: TUpDown;
    dayedit1: TEdit;
    DeltaT_correction2: TCheckBox;
    followtime_toolButton1: TToolButton;
    help_timemenu1: TLabel;
    ImageList_date: TImageList;
    JD_edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    midnight_ToolButton1: TToolButton;
    month1: TUpDown;
    monthedit1: TEdit;
    now_toolButton1: TToolButton;
    PageControl1: TPageControl;
    TabSheet_time1: TTabSheet;
    Tab_JD1: TTabSheet;
    Bevel1_for_alignment_toolbar1_when_DPI_changes: TBevel;
    ToolBar1: TToolBar;
    year1: TUpDown;
    yearedit1: TEdit;

    procedure DateTimePicker1CloseUp(Sender: TObject);
    procedure DateTimePicker1DropDown(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure ok_button1Click(Sender: TObject);
    procedure monthedit1Change(Sender: TObject);
    procedure dayedit1Change(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure siderealtoolbutton2Click(Sender: TObject);
    procedure yearedit1Change(Sender: TObject);
    procedure hourseditChange(Sender: TObject);
    procedure minuteseditChange(Sender: TObject);
    procedure dayedit1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure help_timemenu1Click(Sender: TObject);
    procedure now_toolButton1Click(Sender: TObject);
    procedure midnight_ToolButton1Click(Sender: TObject);
    procedure followtime_toolButton1Click(Sender: TObject);
    procedure JD_edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Settime: TSettime;
const
   deltaT_correction:string='ΔT correction';

implementation

uses  hns_main, hns_Unon, hns_Uast;

{$IFDEF fpc}
  {$R *.lfm}
{$ELSE} {delphi}
  {$R *.DFM}
{$ENDIF}

procedure update_tab(tab_nr:integer);{update one of the two tab's based on the other}
var
  jul:string;
  jd7: double;
  JD_based_year,JD_based_month,JD_based_day,JD_based_HH,JD_based_MM,JD_based_SS, error:integer;
  hh,mm,ss,ms :word;
begin
 if tab_nr=0 then {from tab 1 (JD) to tab 0 (time)}
 begin
   val_local(settime.JD_edit1.text,JD7,error);
   if error=0 then
        JdToDate_integers(JD7+(timezone+daylight_saving)/24,JD_based_year,JD_based_month,JD_based_day,JD_based_HH,JD_based_MM,JD_based_SS);
   settime.year1.position:=JD_based_year;
   settime.month1.position:=JD_based_month;
   settime.day1.position:=JD_based_day;

   settime.DateTimePicker2.time:=encodetime(JD_based_HH,JD_based_MM,JD_based_SS,0);
  end
  else
  if tab_nr=1 then {from tab 0 (time) to tab 1 (JD) }
  begin {from first to second tab }
    decodetime(settime.DateTimePicker2.time,hh,mm,ss,ms);
    JD7:=julian_calc(settime.year1.position,settime.month1.position,settime.day1.position,hh-(timezone+daylight_saving),mm,ss); {##### calculate julian day1, revised 2017}
    str_local(jd7,7,5,jul);
    settime.JD_edit1.Text:=jul;

//    settime.DeltaT_correction1.Caption:=deltaT_correction+'='+prepare_time(delta_T(jd7));
//    settime.DeltaT_correction1.checked:=Time_Reference[1]='U';{UTC}
  end;
end;

procedure update_time_mainwindow;
var
  hh,mm,ss,ms :word;
begin
 with settime do
 begin
   if DeltaT_correction2.checked then Time_Reference:='UTC' else Time_Reference:='TDT';
   if followtime_toolButton1.down=false then
   begin
     actualtime:=false;{for case called other then pulldown menu}
     if PageControl1.tabIndex=1 then {JD menu visible, update tabindex 0}
       update_tab(0);
 //year2:=year1.position;{doesn't work for negative value, bug?}
     year2:=strtoint(yearedit1.text);
     if year2<-32768 then year2:=-32768;
     if year2>32767 then year2:=32767;

     month2:=month1.position;
     day2:=day1.position;

     decodetime(settime.DateTimePicker2.time,hh,mm,ss,ms);

     hour2:=hh;
     min2:=mm;
     sec2:=ss;

     getdatetime(false,false);
//     wtime2:=wtime2actual; {removed 2018 2015, set world straight up if no function key F3, F4, ... are pressed}
     missedupdate:=2;
     paint_sky;

   end;
 end;
end;

procedure TSettime.ok_button1Click(Sender: TObject);
begin
  settime.visible:=false;  {hide window}
  mainwindow.setfocus;

  update_time_mainwindow;
end;

procedure TSettime.DateTimePicker1CloseUp(Sender: TObject);
var y,m,d:word;
begin
  followtime_toolButton1.down:=false; {no actual time}
  decodedate(settime.DateTimePicker1.Date,y,m,d);
  settime.year1.position:=y;
  settime.month1.position:=m;
  settime.day1.position:=d;

  if live_update1.checked=true then
     update_time_mainwindow;
end;

procedure TSettime.DateTimePicker1DropDown(Sender: TObject);
begin
  settime.DateTimePicker1.Date := EncodeDate(settime.year1.position,settime.month1.position,settime.day1.position);
end;

procedure TSettime.FormActivate(Sender: TObject);
var
   jul : STRING;
begin
  {tab 0}
  if settime.PageControl1.ActivePageIndex=0 then ActiveControl:=yearedit1;{set focus on year1}

  str_local(julian_UT,7,5,jul);
  settime.JD_edit1.Text:=jul;

  {The remainder is updated by TSettime.JD_edit1Change}

  {tab 0}
   update_tab(0); {update tab 0 from tab 1}

  {gen}
  {move to mainwindow.update_menu}
//  followtime_toolButton1.down:=actualtime; {update tool button}
//  siderealtoolbutton2.down:=sidereal<>0
end;

procedure TSettime.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#27 {esc} then {leave form without action, keypreview of form should on}
  begin
    settime.visible:=false;  {hide window}
    mainwindow.setfocus;
  end;
end;

procedure TSettime.followtime_toolButton1Click(Sender: TObject);
begin
  live_update1.checked:=false;
  mainwindow.Usesystemtime1Click(Sender);
//  Settime.formshow(Sender);{update edits}
  Settime.formactivate(Sender);{update edits}
end;

procedure TSettime.midnight_ToolButton1Click(Sender: TObject);
begin
  live_update1.checked:=false;
  mainwindow.Tonight1Click(Sender);
  //  Settime.formshow(Sender);{update edits}
    Settime.formactivate(Sender);{update edits}
end;

procedure TSettime.now_toolButton1Click(Sender: TObject);
begin
 live_update1.checked:=false;
  mainwindow.NowF9Click(Sender);
  //  Settime.formshow(Sender);{update edits}
  Settime.formactivate(Sender);{update edits}
end;

procedure update_datetimepicker;
begin
  if ((settime.year1.position>1752) and (settime.year1.position<=9999)) then {no date outside this range possible}
  begin
    settime.datetimepicker1.enabled:=true;
    settime.DateTimePicker1.Date := EncodeDate(settime.year1.position,settime.month1.position,settime.day1.position);
  end
  else
  settime.datetimepicker1.enabled:=false;
end;


procedure TSettime.monthedit1Change(Sender: TObject);
begin
  followtime_toolButton1.down:=false; {no actual time}
  checkleapyear(year1.position);
  if (day1.position>days[month1.position]) then day1.position:=days[month1.position];
  update_datetimepicker;
  if live_update1.checked=true then
     update_time_mainwindow;

end;

procedure TSettime.dayedit1Change(Sender: TObject);
begin
  followtime_toolButton1.down:=false; {no actual time}
  checkleapyear(year1.position);
  if (day1.position>days[month1.position]) then day1.position:=days[month1.position];
  update_datetimepicker;
  if live_update1.checked=true then
     update_time_mainwindow;
end;


procedure TSettime.PageControl1Change(Sender: TObject);
begin
  update_tab(PageControl1.tabIndex); {update the correct tab}
end;

procedure TSettime.siderealtoolbutton2Click(Sender: TObject);
begin
  mainwindow.Sidereal1Click(nil);
  siderealtoolbutton2.down:=sidereal<>0
end;

procedure TSettime.yearedit1Change(Sender: TObject);
var i :integer;
begin
  followtime_toolButton1.down:=false; {no actual time}
  checkleapyear(year1.position);
  i:=year1.position;
  if (day1.position>days[month1.position]) then day1.position:=days[month1.position];
  update_datetimepicker;
  if live_update1.checked=true then
     update_time_mainwindow;
end;

procedure TSettime.hourseditChange(Sender: TObject);
begin
  followtime_toolButton1.down:=false; {no actual time}
//  if ((hours.position>23) and (minutes.position<>0)) then  hours.position:=23;
end;

procedure TSettime.minuteseditChange(Sender: TObject);
begin
  followtime_toolButton1.down:=false; {no actual time}
end;

procedure TSettime.dayedit1Exit(Sender: TObject);
var  x :double;
     error :integer;
     s    :string;
     hh,mm,ss :word;
begin
  if ((pos('.',dayedit1.text)>0) or (pos(',',dayedit1.text)>0)) then {decimalseperator in text}
  begin
    val_local(dayedit1.text,x,error);
    str(trunc(x),s);
    dayedit1.text:=s;

    x:=24*frac(x)+0.5/3600;{add 1/2 seconds for rounding}

    hh:=trunc(x);
    mm:=trunc(60*(x-hh));
    ss:=trunc(60*(60*(x-hh)-mm));
    settime.DateTimePicker2.time:=encodetime(hh,mm,ss,0);
  end;
end;

procedure TSettime.JD_edit1Change(Sender: TObject);
var
  JD7  : double;
  error1 : integer;
begin
  val_local(JD_edit1.text,JD7,error1);
  if JD7>+13688960.5 then JD7:=+13688960.5;{year1 32767}
  if JD7<-10247454.5 then JD7:=-10247454.5;{year1 -32768}
  settime.ut_label1.caption:=JdToDate(JD7);
  settime.DeltaT_correction2.Caption:=deltaT_correction+'='+prepare_time(delta_T(jd7));
end;

procedure TSettime.FormCreate(Sender: TObject);
begin
  if language_mode<>0 then load_time;
  position:=podesigned;{otherwise positioning doesn't work in FPC}
  settime.top:=datemenutop;
  settime.left:=datemenuleft;

  {toolbar1 is not following DPI settings. Fix it by invisible bevel to measure_position_for_toolbar1.left}
  toolbar1.left:=Bevel1_for_alignment_toolbar1_when_DPI_changes.Left;

end;

procedure TSettime.help_timemenu1Click(Sender: TObject);
begin
    open_file_with_parameters(help_path,'#set_time');
end;

end.

















