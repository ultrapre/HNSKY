unit hns_alpaca; {Client for ASCOM ALPACA communication}

{Copyright (C) 2016,2018 by Han Kleijn, www.hnsky.org
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
  Classes, SysUtils,
  strutils,
  strings,
  {$ifdef mswindows}
  {$else} {unix}
  {$endif}
  hns_main,hns_Uast;

const
  alpaca_connected : boolean=false;
  Alpaca_port           : string='11111';
  Alpaca_address        : string='127.0.0.1' ;
  alpaca_telescope      : string='0' ;

   alpaca_ra            : double=0;
   alpaca_dec           : double=0;

function alpaca_read(s:string):string;
procedure alpaca_get_radec;
procedure alpaca_put_generic(command: string; ra,dec : double);{slewToCoordinatesasync, slewtocoordinates or synctocoordinates}
procedure alpaca_get_tracking;{get tracking status}
procedure alpaca_put_string(command,value1: string);{put for tracking=true/false, abort,findhome, park}
procedure alpaca_get_athome;{mount at home position}
procedure alpaca_get_atpark;{mount in park position}
procedure alpaca_get_canslew; {slew possible but not feedback of position at the same time}
procedure alpaca_get_canslewasync;{async slew possible, live feed back Ra/DEC}
procedure alpaca_get_equatorialsystem; {equinox of telescope}

implementation

function floattostr3(x:double):string;{no spaces in string}
begin
  str(x:0:6,result);
end;

function alpaca_read(s:string):string; {read alpaca message}
var
   b,e, err1,err2,tid,bool_value: integer;
   ss    :string;
   value : double;
begin
  {"Value":0.48790888091360546,"ClientTransactionID":0,"ServerTransactionID":85,"ErrorNumber":0,"ErrorMessage":"","DriverException":null}
  bool_value:=0;{assume no boolean}
  err1:=0; {for boolean values}
  ss:='Value":';
  b:=posex(ss,s,1);
  if b=0 then exit;
  inc(b,length(ss));
  e:=posex(',',s,b);
  ss:=copy(s,b,e-b);
  if ss='true' then bool_value:=+1
  else
  if ss='false' then bool_value:=-1
  else
  val(ss,value,err1);

  ss:='ClientTransactionID":';
  b:=posex(ss,s,1);
  if b=0 then exit;{need the id to identify}
  inc(b,length(ss));
  e:=posex(',',s,b);
  ss:=copy(s,b,e-b);
  val(ss,tid,err2);


  ss:='ErrorMessage":"';
  b:=posex(ss,s,1);
  if b>0 then
  begin
    inc(b,length(ss));
    e:=posex('"',s,b); {different end}
    ss:=copy(s,b,e-b);
    if length(ss)>0 then
    begin
       mainwindow.statusbar1.caption:=ss;
       mainwindow.error_message1.visible:=true;
       mainwindow.error_message1.caption:=ss;
    end;
  end;

  if ((err1=0) and (err2=0)) then
  begin
    if tid=8265 then alpaca_ra:=value; {R=char(82), A=char(65)}
    if tid=6869 then alpaca_dec:=value;{D=char(68), E=char(69)}
    if tid=8482 then {tracking?}
    begin
      if bool_value=+1 then mainwindow.tracking1.checked:=true;
      if bool_value=-1 then mainwindow.tracking1.checked:=false;
    end;
    if tid=8065 then {atpark?}
    begin
      if bool_value=+1 then mainwindow.park1.checked:=true;
      if bool_value=-1 then mainwindow.park1.checked:=false;
    end;
    if tid=7279 then {athome?}
    begin
      if bool_value=+1 then mainwindow.home1.checked:=true;
      if bool_value=-1 then mainwindow.home1.checked:=false;
    end;
    if tid=6583 then {async slew possible, live feed back Ra/DEC}
    begin
      if bool_value=+1 then Ascom_mount_capability:=2;
      if bool_value=-1 then Ascom_mount_capability:=0;
    end;
    if tid=6783 then {slew possible but not feedback of position at the same time}
    begin
      if bool_value=+1 then Ascom_mount_capability:=1;
      if bool_value=-1 then Ascom_mount_capability:=0;
    end;

    if tid=6981 then {equatorialsystem}
    begin
      case round(value) of
         0 : equinox_telescope:=0;    {equOther	0	Custom or unknown equinox and/or reference frame.}
         1 : equinox_telescope:=0;    {equLocalTopocentric	1	Local topocentric; this is the most common for amateur telescopes.}
         2 : equinox_telescope:=2000; {equJ2000	2	J2000 equator/equinox, ICRS reference frame.}
         3 : equinox_telescope:=2050; {equJ2050	3	J2050 equator/equinox, ICRS reference frame.}
         4 : equinox_telescope:=1950; {equB1950	4	B1950 equinox, FK4 reference frame.}
         else
           equinox_telescope:=0;
      end;
    end;

  end;
end;

procedure alpaca_get_radec;
begin
  alpaca_send_http_get('rightascension?clientid=7&clienttransactionid=8265');{HNSKY specific transactions numbers R=char(82), A=char(65)}
  alpaca_send_http_get('declination?clientid=7&clienttransactionid=6869');{HNSKY specific transactions D=char(68), E=char(69)}
end;

procedure alpaca_put_generic(command: string; ra,dec : double);{slewToCoordinatesAsync, slewtocoordinates or synctocoordinates}
begin
  alpaca_send_http_put(command,'RightAscension='+floattostr3(ra)+'&Declination='+floattostr3(dec)+'&ClientID=7&ClientTransactionID=100');
end;

procedure alpaca_get_generic(command : string);{generic GET command for abortslew, park, home}
begin
  alpaca_send_http_get(command+'?clientid=7&clienttransactionid=9999');
end;

procedure alpaca_get_tracking;{get tracking}
begin
  alpaca_send_http_get('tracking?clientid=7&clienttransactionid=8482');{HNSKY specific transactions T=char(84), E=char(82)}
end;

procedure alpaca_get_atpark;{mount in park position}
begin
  alpaca_send_http_get('atpark?clientid=7&clienttransactionid=8065');{HNSKY specific transactions P=char(80), A=char(65)}
end;
procedure alpaca_get_athome;{mount at home position}
begin
  alpaca_send_http_get('athome?clientid=7&clienttransactionid=7279');{HNSKY specific transactions H=char(72), O=char(79)}
end;

procedure alpaca_get_canslewasync;{async slew possible, live feed back Ra/DEC}
begin
  alpaca_send_http_get('canslewasync?clientid=7&clienttransactionid=6583');{HNSKY specific transactions A=#65, S=#83}
end;
procedure alpaca_get_canslew; {slew possible but not feedback of position at the same time}
begin
  alpaca_send_http_get('canslew?clientid=7&clienttransactionid=6783');{HNSKY specific transactions C=#67, S=#83}
end;

procedure alpaca_get_equatorialsystem; {equinox of telescope}
begin
  alpaca_send_http_get('equatorialsystem?clientid=7&clienttransactionid=6981');{HNSKY specific transactions E=#69, Q=#81}
end;


procedure alpaca_put_string(command,value1: string);{put for tracking=true or false, abort,findhome, park}
begin
  if length(value1)>0 then value1:=value1+'&';
  alpaca_send_http_put(command,value1+'ClientID=7&ClientTransactionID=9999');{true or false}
end;



end.

