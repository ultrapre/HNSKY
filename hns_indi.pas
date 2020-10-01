unit hns_indi;
{Copyright (C) 2017,2018 by Han Kleijn, www.hnsky.org
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
  lNetComponents, lNet,FileUtil,
  {$else}  {delphi}
  {$endif}
  Classes, SysUtils,  Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Buttons, ExtCtrls, strutils,
  hns_main,hns_Uset;


type

  { Tindi }

  Tindi = class(TForm)
    connect_indi_server_btn1: TBitBtn;
    indi_client: TLTCPComponent;
    Memo1: TMemo;
    no_indi_devices_available1: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    show_full_indi_communication1: TCheckBox;
    all_device_communication1: TCheckBox;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    telescope_name_select2: TComboBox;
    procedure connect_indi_server_btn1Click(Sender: TObject);
    procedure all_device_communication1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure indi_clientConnect(aSocket: TLSocket);
    procedure indi_clientDisconnect(aSocket: TLSocket);
    procedure indi_clientError(const msg: string; aSocket: TLSocket);
    procedure indi_clientReceive(aSocket: TLSocket);
    procedure telescope_name_select2Change(Sender: TObject);
  private
    { private declarations }
    procedure WhatToDo(Sender: TObject);
    procedure WhatToDo_number(Sender: TObject);
  public
    { public declarations }
  end;

procedure analyse_indi_message(s:string);
procedure update_indi_menu(s:string);

procedure disconnect_indi_server;
procedure connect_indi_device(device1:string);{connect INDI telescope device}
procedure INDI_disconnect_device(device1:string);{diconnect INDI telescope device}
procedure sendmessage2(s:string);{send message to the server}

function extract_level_2(vector, s:string;start1:integer; var name1,label1,status1 : string):integer;{extract  <defSwitch name="DOME_CW" label="Open"> Off </defSwitch>  <defSwitch name="DOME_CCW" label="Close"> Off  </defSwitch> switches }
function extract_level_1(vector, s:string; var device1,name1,label1,group1,state1,perm1,rule1,message1 : string):integer;{extract '<defSwitchVector device="RollOff Simulator" name="DOME_MOTION" label="Motion" group="Main Control" state="Ok" perm="rw" rule="AtMostOne" timeout="60" timestamp="2016-06-27T10:16:10">    <defSwitch name="DOME_CW" label="Open">Off    </defSwitch>    <defSwitch name="DOME_CCW" label="Close">Off    </defSwitch></defSwitchVector><defSwitch name="DOME_CW" label="Open"> Off </defSwitch>  <defSwitch name="DOME_CCW" label="Close"> Off  </defSwitch> switches' }

const
    maxtabs=20;
    maxobjects=15*maxtabs;

    ra_indi_telescope_hours     : double=0; {for INDI cursor}
    dec_indi_telescope_degrees  : double=0;
    az_indi_telescope_degrees   : double=0; {for INDI cursor}
    alt_indi_telescope_degrees  : double=0;
    equinox_indi    : double=0;

    nr_of_tabs : integer=0;
    nr_of_live_label_components : integer=0;
    nr_of_live_bitbtn_components : integer=0;
    nr_of_labels : integer=0;
    nr_of_shapes : integer=0;
    nr_of_edits  : integer=0;
    counter1     : integer=0; {for making edit names}

    connect_during_creation :integer=2;{connect to server during startup in two steps. First server, then telescope }

    device_of_interest  : string='';

    all_device_communication: boolean=false;{show communication of all devices}



var
  indi: Tindi;
  indi_devices     : array[0..maxtabs] of string;
  indi_groups      : array[0..maxtabs] of string;
  indi_tabs        : array[0..maxtabs] of Ttabsheet;
  indi_button_top  : array[0..maxtabs] of integer; {where is place for a button}
  indi_live_label_components  :  array[0..maxobjects] of Tcomponent;{save the component which needs updating }
  indi_live_bitbtn_components :  array[0..maxobjects] of Tcomponent;{save the component which needs updating }
  indi_labels                 :  array[0..maxobjects] of string;{keep track of labels created}
  indi_live_shapes                 :  array[0..maxobjects] of Tcomponent;{keep track of shapes created}
  indi_edit_components   :  array[0..maxobjects] of Tcomponent;{save the component which needs updating }
 // indi_devices : tstrings;
var
  live_ra    : tlabel;


implementation

{$R *.lfm}

{ Tindi }

function clean_name(s:string):shortstring;{remove charactors which cant be used for name}
  var
    i, Count: Integer;
  begin
    SetLength(Result, Length(s));
    Count := 0;
    if length(s)=0 then
    beep;
    for i := 1 to Length(s) do begin
      if (
           ((s[i] >= #65) and (s[i] <= #90)) or   {A..Z}
           ((s[i] >= #97) and (s[i] <= #122)) or  {a..z}
           ((s[i] >= #48) and (s[i] <= #57))  or  {0..9}
           ((s[i] = '_'))

           ) then
      begin
        inc(Count);
        Result[Count] := s[i];
      end;

    end;
    SetLength(Result, Count);
end;

procedure sendmessage2(s:string);{send message to the server}
begin
  indi.indi_client.SendMessage(s);
  if indi.show_full_indi_communication1.checked then indi.memo1.lines.add('HNSKY:'+s);
end;

procedure INDI_disconnect_device(device1:string);{disconnect INDI telescope device}
begin
  sendmessage2('<newSwitchVector  device="'+device1+'" name="CONNECTION"><oneSwitch name="CONNECT">Off</oneSwitch><oneSwitch name="DISCONNECT">On</oneSwitch> </newSwitchVector>'); {connect to telescope}

end;

procedure free_all_tabs;{remove all tabs and buttons in the bulk way}
var  i :integer;
begin
  for I := indi.pagecontrol1.PageCount-1 downto 0 do
        indi.pagecontrol1.Pages[i].Free;
  nr_of_tabs :=0;
  nr_of_live_label_components :=0;
  nr_of_live_bitbtn_components :=0;
  nr_of_labels :=0;
  nr_of_shapes :=0;
  nr_of_edits  :=0;
  counter1     :=0; {for making edit names}
  indi.no_indi_devices_available1.visible:=true;{ no devices available, show this one}
end;

procedure disconnect_indi_server;
begin
  if indi_telescope_connected then INDI_disconnect_device(indi_telescope_name);{disconnect INDI telescope device}
  sleep(100);{give some time to process}
  update_telescope_menu(false);
  indi.indi_client.Disconnect(true);{disconnect server}
  indi_server_connected:=false; {to be sure, disconnected event doesn't happen}
  indi_server_connecting:=false;

  free_all_tabs;{remove all tabs and buttons in the bulk way}

  indi.connect_indi_server_btn1.visible:=true;
  indi.no_indi_devices_available1.visible:=false;{no devices available but first connect the server}
  indi_telescope_connected:=false; {to be sure, disconnected event doesn't happen}
  if assigned(settings){form existing} then
     settings.FormPaint(nil);{paint for updating connect/disconnect colors }
end;

procedure connect_indi_device(device1:string);
begin
  sendmessage2('<newSwitchVector  device="'+device1+'" name="CONNECTION">  <oneSwitch name="CONNECT">On</oneSwitch> </newSwitchVector>'); {connect to telescope}
end;

procedure request_indi_properties;{get properties for menu update}
begin
  sendmessage2('<getProperties version="1.7"></getProperties>');{get server info}
end;

procedure Tindi.indi_clientConnect(aSocket: TLSocket);
begin
  indi_server_connected:=true; {really connected now}
  connect_indi_server_btn1.visible:=false;
  indi.no_indi_devices_available1.Visible:=true; {no devices available yet}
  request_indi_Properties;
//  message_canvas(links,round(font_height2*11*1.2),clwhite,' INDI <->       ');
  canvas_object_message(' INDI <->',colors[25]);
  if Assigned(settings) {existing} then
                  settings.FormPaint(nil);{paint for updating connect/disconnect colors }
end;

procedure Tindi.connect_indi_server_btn1Click(Sender: TObject);
begin
   indi_server_connecting := INDI_client.Connect(indi_server_address,strtoint(indi_Port));{localhost, 7624}
end;

procedure Tindi.all_device_communication1Change(Sender: TObject);
begin
  all_device_communication:=all_device_communication1.checked;
end;

procedure Tindi.FormCreate(Sender: TObject);
begin
  telescope_name_select2.text:=INDI_telescope_name;{is this allowed}
end;



procedure Tindi.indi_clientDisconnect(aSocket: TLSocket);
begin
  indi_server_connected:=false;
    indi_telescope_connected:=false;
  update_telescope_menu(false);{update menu}
  canvas_object_message(' INDI <-/  /->',colors[1]);
  if assigned(settings){form existing} then settings.FormPaint(nil);{paint for updating connect/disconnect colors }
  free_all_tabs;
end;

procedure Tindi.indi_clientError(const msg: string; aSocket: TLSocket);
begin
  if (( telescope_interface='I') and (mainwindow.connect_telescope1.checked=true)) then
  begin
    canvas_object_message(' INDI '+error_string,clred);
    update_telescope_menu(false);{update menu}
  end;
end;


function extract_indi_switches(device1,member,onoffword,s:string; out device_connected:boolean): boolean;{out=Output only parameter, is only updated if device1 data is found}
{ <defSwitchVector device='ASCOM Simulator Telescope' name='CONNECTION' label='Connection' group='Main Control' state='Ok' perm='rw' rule='OneOfMany' timeout='0' timestamp='2016-06-10T12:48:01.8'>
     <defSwitch name='CONNECT' label='Connect'>On</defSwitch>
     <defSwitch name='DISCONNECT' label='Disconnect'>Off</defSwitch>
</defSwitchVector>}
var
   start1, i,j,k,l,end1  : integer;
begin
  start1:=1;
  end1:=1;
  result:=false;{assume no extraction result}
  repeat
    start1:=posex('<defSwitchVector',s,start1);{could <defSwitchVector (wINDI)  or <setSwitchVector   (library 1.2.0}
    if start1>0 then  {switch vector}
    begin
      start1:=start1+length('<defSwitchVector');
      end1:=posex('</SwitchVector',s,start1); {end search}
      if end1>start1 then
      begin
        i:=posex(device1,s,start1);{indi_telescope_name or indi_dome_name}
        if i>0 then {correct telescope?, device=indi_telescope_name}
        begin
          j:=posex(member,s,start1+length(device1));{member could "CONNECT" or "SHUTTER_OPEN", start looking for word 'On'}
          if j>0 then {now analyse detect info}
          begin
            k:=posex('</',s,j+length(member));{end search area looking for member=On, Off }
            l:=posex(onoffword,s,j+length(member));{where is the word On or Off}
            device_connected:=((l>j)and (l<k));{word On found after "CONNECT" and before end </ }
            result:=true;{status extracted}
          end;
        end;{telescope or dome}
      end;
    end;
  until ((start1=0) or (end1=0));

end;

procedure Tindi.indi_clientReceive(aSocket: TLSocket);
var
  s                          : string;
  old_status                 : boolean;
begin
  aSocket.GetMessage(s);
  s:= delchars(s,#10);
  s:=StringReplace(s, #39, '"',[rfReplaceAll]); {replace single apostrophe by double apostrophe }

  if show_full_indi_communication1.checked then indi.Memo1.lines.add ('SERVER:'+s);
  old_status:=indi_telescope_connected;

  analyse_indi_message(s); {decode all the XML}

  if  old_status<>indi_telescope_connected then {status change, update}
   begin
      update_telescope_menu(indi_telescope_connected); {update telescope menu}
      if assigned(settings){form existing} then settings.FormPaint(nil);{paint for updating connect/disconnect colors }

      if indi_telescope_connected then
         sendmessage2('<newSwitchVector  device="'+indi_telescope_name+'" name="CONFIG_PROCESS"><oneSwitch name="CONFIG_LOAD">On</oneSwitch></newSwitchVector>') {load settings}
      else {disconnected, clear all tabs}
      begin
        free_all_tabs;{destroy all menus, the brute way}
        request_indi_properties;{ask server for an update and therefore start to rebuild}
      end;
   end;

end;



procedure Tindi.telescope_name_select2Change(Sender: TObject);
begin
  free_all_tabs;{destroy all menus, the brute way}
  telescope_name_select2.items.clear; {remove devices list, allow update}
  request_indi_properties;{ask server for an update and therefore start to rebuild}
end;

procedure Tindi.WhatToDo(Sender: TObject);{send new switch value to server}
var
  hint:string;
begin
  hint:=TControl(Sender).hint;
  if pos('☑',TControl(Sender).caption)>0 then {toggle function stored in caption?}
     hint:=stringreplace(hint,'On','Off',[rfreplaceall]);
  if pos('☐',TControl(Sender).caption)>0 then {toggle function stored in caption?}
        hint:=stringreplace(hint,'Off','on',[rfreplaceall]);

    sendmessage2(hint);{total instruction}
//  ShowMessage('Sender is: '+ TControl(Sender).Name+',  Hint:'+ TControl(Sender).hint);
end;
procedure Tindi.WhatToDo_number(Sender: TObject); {send new numeric value to server}
var
   hint1,component_name,value1: string;
   komma1,komma2,tel :integer;
begin
  hint1:=TControl(Sender).hint;
  repeat
    komma1:=pos('@',hint1);{find markers}
    komma2:=pos('#',hint1);{find markers}
    component_name:=copy(hint1,komma1+1,komma2-komma1-1);
    value1:='';
    for tel:=0 to nr_of_edits-1 Do
    begin
      if  component_name=indi_edit_components[tel].Name then {find component to take value from}
        value1:=(indi_edit_components[tel] as tedit).text;
    end;
    delete(hint1,komma1,komma2-komma1+1);
    insert(value1,hint1,komma1);

  until komma2=0; {all analog values added}

  sendmessage2(hint1);{total instruction}
//  ShowMessage(hint1);

end;


//<setNumberVector device='ASCOM Simulator Telescope' name='EQUATORIAL_EOD_COORD' state='Ok' timeout='60' timestamp='2016-06-28T15:54:04.7'>
//<oneNumber name='RA'>8.35452158704044</oneNumber>
//<oneNumber name='DEC'>0</oneNumber>
//</setNumberVector>

//<setSwitchVector device="DomeSim Dome" name="DOME_SHUTTER" state="Busy" timeout="0" timestamp="2016-06-29T15:40:03.2" message="Closing...">'#10'
// <oneSwitch name="OPEN">Off</oneSwitch>
// <oneSwitch name="CLOSE">On</oneSwitch>
//</setSwitchVector>


//<setNumberVector device='ASCOM Simulator Telescope' name='EQUATORIAL_EOD_COORD' state='Ok' timeout='60' timestamp='2016-06-28T15:54:04.7'>
//<oneNumber name='RA'>8.35452158704044</oneNumber>
//<oneNumber name='DEC'>0</oneNumber>
//</setNumberVector>

//<defNumberVector device='ASCOM Simulator Telescope' name='EQUATORIAL_EOD_COORD' label='Equatorial coordinates' group='Main Control' state='Ok' perm='rw' timeout='0' timestamp='2016-06-28T15:53:49.9'>
//<defNumber name='RA' label='RA' format='%11.9m' min='0' max='24' step='0'>0</defNumber>
//<defNumber name='DEC' label='Dec' format='%11.9m' min='-180' max='180' step='0'>0</defNumber>
//</defNumberVector>

//<defTextVector device="RollOff Simulator" name="DEVICE_PORT" label="Ports" group="Options" state="Idle" perm="rw" timeout="0" timestamp="2016-06-29T17:55:53">
//    <defText name="PORT" label="Port">/dev/ttyUSB0    </defText>
//  </defTextVector>

{ <defSwitchVector device='ASCOM Simulator Telescope' name='CONNECTION' label='Connection' group='Main Control' state='Ok' perm='rw' rule='OneOfMany' timeout='0' timestamp='2016-06-10T12:48:01.8'>
     <defSwitch name='CONNECT' label='Connect'>On</defSwitch>
     <defSwitch name='DISCONNECT' label='Disconnect'>Off</defSwitch>
</defSwitchVector>}


//<message device="EQMod Mount" timestamp="2016-07-03T11:15:07" message="Can not change park position while slewing or already parked..."/>

function extract_message(vector,s:string;start1:integer; var device1,timestamp1,message1: string):integer;{extract message,<message device="EQMod Mount" timestamp="2016-07-03T11:15:07" message="Can not change park position while slewing or already parked..."/>}
var
  i,j,k,end1,length_vector : integer;
begin
  result:=0;

  start1:=posex('<'+vector+' ',s,start1);{'<message '}
  if start1>0 then
  begin
    length_vector:=length(vector);
    start1:=start1+2+length(vector);{begin search}
    end1:=posex('</'+vector+'>',s,start1); {end search}
    if end1=0 then begin end1:=posex('/>',s,start1);length_vector:=-1 end;   {try empty-element tag  />}
    if end1>start1 then
    begin
      i:=posex('device=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('device=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        device1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;
      i:=posex('timestamp=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('timestamp=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        timestamp1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;

      i:=posex('message=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('message=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        message1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;
      result:=end1+3+ length_vector;{'</'+vector+'>' or  />}
    end;
  end;{start>1}
end;



function extract_level_2(vector, s:string;start1:integer; var name1,label1,status1 : string):integer;{extract  <defSwitch name="DOME_CW" label="Open"> Off </defSwitch>  <defSwitch name="DOME_CCW" label="Close"> Off  </defSwitch> switches }
var
  i,j,k,l,end1,length_vector,end_intermediate : integer;
begin
  result:=0;
  start1:=posex('<'+vector+' ',s,start1);{defSwitch or oneSwitch with space to deviate from devSwitchVector}
  if start1>0 then
  begin



    length_vector:=length(vector);
    start1:=start1+2+length(vector);{begin search}
    end1:=posex('</'+vector+'>',s,start1); {end search}
    if end1=0 then begin end1:=posex('/>',s,start1);length_vector:=-1 end;   {try empty-element tag  />}
    if end1>start1 then
    begin

      {  <defText name="UTC" label="UTC Time"/>    }
      {  <defSwitch name='CONNECT' label='Connect'>On</defSwitch> }
      i:=posex('name=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('name=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        name1:=clean_name(copy(s,j,k-j)); {remove charactors which can't be used for name}
      end;
      {  <defTextVector device="Telescope Simulator" name="TIME_UTC" label="UTC" group="Site Management" state="Idle" perm="rw" timeout="60" timestamp="2016-07-05T09:12:43">    <defText name="UTC" label="UTC Time"/>    <defText name="OFFSET" label="UTC Offset"/></defTextVector>    }
      {  <defSwitch name='CONNECT' label='Connect'>On</defSwitch> }
      {   <oneSwitch name="CONNECT">On    </oneSwitch>    <oneSwitch name="DISCONNECT">Off    </oneSwitch></setSwitchVector>'}
      {find now status}
      end_intermediate:=posex('/'+vector+'>',s,k+length('"'));
      if end_intermediate=0 then end_intermediate:=posex('/>',s,k+length('"'));{try empty-element tag  />}
      j:=posex('>',s,k+length('"'))+length('>');{start}
      k:=posex('<',s,j);{end}
      if ((j<end_intermediate) and (k<end_intermediate)) then {within the range not somewhere far away in a different part}
      status1:=trim(copy(s,j,k-j));{On, Off}

      i:=posex('label=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('label=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        label1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;
      result:=end1+3+ length_vector;{'</'+vector+'>' or  />}
    end;
  end;{start>1}
end;

function extract_level_1(vector, s:string; var device1,name1,label1,group1,state1,perm1,rule1,message1 : string):integer;{extract '<defSwitchVector device="RollOff Simulator" name="DOME_MOTION" label="Motion" group="Main Control" state="Ok" perm="rw" rule="AtMostOne" timeout="60" timestamp="2016-06-27T10:16:10">    <defSwitch name="DOME_CW" label="Open">Off    </defSwitch>    <defSwitch name="DOME_CCW" label="Close">Off    </defSwitch></defSwitchVector><defSwitch name="DOME_CW" label="Open"> Off </defSwitch>  <defSwitch name="DOME_CCW" label="Close"> Off  </defSwitch> switches' }
var
  start1,i,j,k,end1 : integer;
begin
  result:=0;
  start1:=pos('<'+vector+' ',s);{defSwitchVector or defNumberVector or defTextVector}
  if start1>0 then
   begin
    start1:=start1+2+length(vector);{begin search}
    end1:=posex('</'+vector+'>',s,start1); {end search}
    if end1>start1 then
    begin
      i:=posex('device=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('device=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        device1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;
      i:=posex('name=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('name=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        name1:=clean_name(copy(s,j,k-j));{remove charactors which can't be used for name}
      end;

      i:=posex('label=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('label=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        label1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;
      i:=posex('group=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('group=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        group1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;
      i:=posex('state=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('state=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        state1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;
      i:=posex('perm=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('perm=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        perm1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;
      i:=posex('rule=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('rule=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        rule1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;
      i:=posex('message=',s,start1);
      if ((i>0) and (i<end1)) then
      begin
        i:=i+length('message=');
        j:=posex('"',s,i);inc(j,1); {find begin};
        k:=posex('"',s,j); {find end};
        message1:=trim(copy(s,j,k-j)); {remove spaces and crlf}
      end;
      result:=end1+3+length(vector);{adapt end to correct end}
    end;
  end;{start>1}
end;

procedure update_shapes(component_name1,state1:string);{update shape color depending on state}
var
    component_name: string;
    tel           : integer;
begin
  component_name:='sh'+component_name1;
  for tel:=0 to nr_of_shapes-1 Do
  begin
    if  component_name=indi_live_shapes[tel].Name then
     begin
      if state1='Ok' then begin (indi_live_shapes[tel] as tshape).brush.color:=clGreen; end
      else
      if state1='Idle' then begin (indi_live_shapes[tel] as tshape).brush.color:=clsilver; end
      else
      if state1='Busy' then begin (indi_live_shapes[tel] as tshape).brush.color:=clYellow; end
      else
      if state1='Alert' then begin (indi_live_shapes[tel] as tshape).brush.color:=clred; end
      else
      begin (indi_live_shapes[tel] as tshape).brush.color:=clblack; end;
     end;
  end;
end;

procedure update_indi_menu(s:string);
var
  start0,end0,start1,tel,error1,mode                                                                  : integer;
  s2,device1,device_short,name1,name2,label1,status1,component_name,state1,label_main,group1,perm1,
  time1,message1,rule1  : string;
  x :  double;
begin
  mode:=1;
  repeat {until s is fully read}
  {update now switches}
    device1:='';
    name1:='';
    state1:='';
    end0:=0;
    rule1:='';
    message1:='';
    case mode of 1: begin {update switches}
                      start0:=pos('setSwitchVector',s);
                      if start0<>0 then end0:=extract_level_1('setSwitchVector',s,device1,name1,label_main,group1,state1,perm1,rule1,message1);
                      if end0<>0 then
                    //  if ((end0<>0) and (device1=indi.telescope_name_select2.text)) then {usefull message of the correct device}
                      begin
                        if device1=indi.telescope_name_select2.text then {correct device}
                        begin

                          start1:=start0+length('setSwitchVector');{after setSwitchVector}
                          device_short:=stringreplace(device1,' ','',[rfreplaceall]);
                          device_short:=stringreplace(device_short,'-','',[rfreplaceall]);{component names can't contain minus signs}
                          update_shapes(device_short+name1,state1);{update shape color depending on the state}
                          s2:=copy(s,1,end0);
                          repeat
                            status1:='';
                            start1:=extract_level_2('oneSwitch',s2,start1,name2,label1,status1);{extract level 2 and return end position}
                            if start1<> 0 then
                            begin  {update menu}
                              {----------------------------------}
                              if ((device1=indi_telescope_name) and (name1='CONNECTION') and (name2='CONNECT')) then {connected?}
                                                                                         indi_telescope_connected:=status1='On';
                              if ((device1=indi_telescope_name) and (name1='TELESCOPE_PARK') and (name2='PARK')) then {connected?}
                                                       mainwindow.park1.checked:=status1='On';

                              component_name:='bs'+device_short+name1+name2;
                              for tel:=0 to nr_of_live_bitbtn_components-1 Do
                              begin
                                if  component_name=indi_live_bitbtn_components[tel].Name then
                                begin
                                  //dummy:=(indi_live_bitbtn_components[tel] as tbitbtn).caption;
                                  if status1='Off' then
                                  begin
                                    (indi_live_bitbtn_components[tel] as tbitbtn).font.color:=cldefault; (indi_live_bitbtn_components[tel] as tbitbtn).font.style:=[];
                                    (indi_live_bitbtn_components[tel] as tbitbtn).caption:=  stringreplace((indi_live_bitbtn_components[tel] as tbitbtn).caption,'☑','☐',[rfreplaceall]);
                                  end
                                  else
                                  if status1='On' then
                                  begin
                                    (indi_live_bitbtn_components[tel] as tbitbtn).font.color:=cldefault; (indi_live_bitbtn_components[tel] as tbitbtn).font.style:=[fsbold,fsunderline,fsitalic];
                                    (indi_live_bitbtn_components[tel] as tbitbtn).caption:=  stringreplace((indi_live_bitbtn_components[tel] as tbitbtn).caption,'☐','☑',[rfreplaceall]);
                                  end
                                  else
                                  begin
                                   (indi_live_bitbtn_components[tel] as tbitbtn).font.color:=clsilver; (indi_live_bitbtn_components[tel] as tbitbtn).font.style:=[];
                                  end;
                                end;
                              end;
                              {----------------------------------}
                            end;
                           until start1=0;
                         end;{correct device}
                         delete(s,start0,end0-start0); {read, dispose}
                       end;
                    end;{1}
                 2: begin {update analog labels}
                      start0:=pos('setNumberVector',s);
                      if start0<>0 then end0:=extract_level_1('setNumberVector',s,device1,name1,label_main,group1,state1,perm1,rule1,message1);
                      if end0<>0 then
                      begin
                        if device1=indi.telescope_name_select2.text then {correct device}
                        begin
                          start1:=start0+length('setNumberVector');{after setSwitchVector}
                          device_short:=stringreplace(device1,' ','',[rfreplaceall]);
                          device_short:=stringreplace(device_short,'-','',[rfreplaceall]);{component names can't contain minus signs}
                          update_shapes(device_short+name1,state1);{update shape color depending on the state}
                          s2:=copy(s,1,end0);
                          start1:=length('setNumberVector');{after setNumberVector}
                          repeat
                            status1:='';
                            start1:=extract_level_2('oneNumber',s2,start1,name2,label1,status1);{extract level 2 and return end position}
                            if start1<> 0 then
                            begin  {update position and menu}
                              {----------------------------------}
                              if device1=indi_telescope_name then {update telescope position}
                              begin
                                val(status1,x,error1);
                                if error1=0 then
                                begin
                                  if name2='RA' then ra_indi_telescope_hours:=x
                                  else
                                  if name2='DEC' then dec_indi_telescope_degrees:=x;

                                  if name1='EQUATORIAL_EOD_COORD' then equinox_indi:=0; {equinox of date}
                                  if name1='EQUATORIAL_COORD' then  equinox_indi:=2000; {equinox 2000}
                                end;
                              end;  {update position}
                              component_name:='ln'+device_short+name1+name2;
                              for tel:=0 to nr_of_live_label_components-1 Do
                              begin
                                 if  component_name=indi_live_label_components[tel].Name then
                                (indi_live_label_components[tel] as tlabel).caption:=copy(status1,1,12);{limit char 12}
                              end;{update menu}
                              {----------------------------------}
                            end;
                          until start1=0;
                        end; {correct device}
                        delete(s,start0,end0-start0); {read, dispose}
                       end;
                     end;{2}
                  3: begin {update live text labels}
                       start0:=pos('setTextVector',s);
                       if start0<>0 then  end0:=extract_level_1('setTextVector',s,device1,name1,label_main,group1,state1,perm1,rule1,message1);
                       if end0<>0 then
                       begin
                         if device1=indi.telescope_name_select2.text then {correct device}
                         begin
                           start1:=start0+length('setTextVector');{after setSwitchVector}
                           device_short:=stringreplace(device1,' ','',[rfreplaceall]);
                           device_short:=stringreplace(device_short,'-','',[rfreplaceall]);{component names can't contain minus signs}
                           update_shapes(device_short+name1,state1);{update shape color depending on the state}
                           s2:=copy(s,1,end0);
                           start1:=length('newTextVector');{after setTextVector}
                           repeat
                             status1:='';
                             start1:=extract_level_2('oneText',s2,start1,name2,label1,status1);
                             if start1<> 0 then
                             begin  {update menu}
                              {----------------------------------}
                               component_name:='lt'+device_short+name1+name2;
                               for tel:=0 to nr_of_live_label_components-1 Do
                               begin
                                 if  component_name=indi_live_label_components[tel].Name then  (indi_live_label_components[tel] as tlabel).caption:=status1;
                               end;
                               {end; update menu}
                               {----------------------------------}
                             end;
                           until start1=0;

                         end; {correct device}
                        delete(s,start0,end0-start0); {read, dispose}
                       end;
                    end;{3}
                4: begin {update live lights}
                     start0:=pos('setLightVector',s);
                     if start0<>0 then  end0:=extract_level_1('setLightVector',s,device1,name1,label_main,group1,state1,perm1,rule1,message1);
                     if end0<>0 then
                     begin
                       if device1=indi.telescope_name_select2.text then {correct device}
                       begin
                         start1:=start0+length('setLightVector');{after setSwitchVector}
                         device_short:=stringreplace(device1,' ','',[rfreplaceall]);
                         device_short:=stringreplace(device_short,'-','',[rfreplaceall]);{component names can't contain minus signs}
                         update_shapes(device_short+name1,state1);{update shape color depending on the state}
                         s2:=copy(s,1,end0);
                         start1:=length('newLightVector');{after setTextVector}
                         repeat
                           status1:='';
                           start1:=extract_level_2('oneLight',s2,start1,name2,label1,status1);
                           if start1<> 0 then
                           begin  {update menu}
                             {----------------------------------}
                             update_shapes(device_short+name1+name2,status1);{update shape color depending on the state}
                             {end; update menu}
                             {----------------------------------}
                           end;
                         until start1=0;
                       end;{correct device}
                       delete(s,start0,end0-start0); {read, dispose}
                     end;
                   end;{4}
                 5:begin {messages}
                     time1:='';
                     message1:='';
                     start0:=pos('<message ',s);
                     if start0<>0 then
                         end0:=extract_message('message',s,start0, device1,time1,message1);
                     if end0<>0 then
                     begin
                        if ((all_device_communication) or (device1=indi.telescope_name_select2.text))  then {all or the device of interest}
                         mainwindow.statusbar1.caption:=message1+ '  ('+device1+', '+time1+')';{give status}
                       delete(s,start0,end0-start0); {read, dispose}
                     end;
                   end;{5}
                   6:begin {<delProperty device="Telescope Simulator"/> }
                       time1:='';
                       message1:='';
                       start0:=pos('<delProperty ',s);
                       if start0<>0 then
                           end0:=extract_message('delProperty',s,start0, device1,time1,message1);
                       if end0<>0 then
                         if device1=indi.telescope_name_select2.text then {correct device}
                         begin
                           {----------------------------------}

                           if pos('FOCUS_MODE',s)>0 then exit; {bug fix LX90 driver and LX200GPS sends stupid instruction delProperty focus_mode after request indi properties}

                           free_all_tabs;{remove all tabs and buttons in the bulk way}
                           s:=''; {dispose everything, start fresh}
                           request_indi_properties;{rebuild complete menu}
                           start0:=0; {can leave immediately}
                           {----------------------------------}
                         end;
                     end;{6}

    end;{case}

    if message1<>'' then
      if  ((all_device_communication) or (device1=indi.telescope_name_select2.text))  then {all or the device of interest}
      begin
        indi.Memo1.lines.add (message1+'  ('+device1+', '+time1+')');{message from extract_level1}
         {activate scrolling memo1}
        indi.memo1.SelStart:=Length(indi.memo1.Lines.Text);
        indi.memo1.SelLength:=0;
      end;


    if ((start0<>0) and (end0=0)) then
    delete(s,start0,13);{missing end marker, remove start}

    if ((end0=0) or (start0=0)) then
    begin
      inc(mode);{go to next search}
      if mode>6 then exit;{leave}
    end;
  until  false;
end;

function find_label(name1:string):integer;
var
  tel :integer;
begin
  result:=-1;
  for tel:=0 to nr_of_labels-1 do
  begin
    if  name1=indi_labels[tel] then
     result:=tel;
  end;
end;

PROCEDURE analyse_indi_message(s:string);{is this label already used}
var
  TabSheet : TTabSheet;
  btn      : TBitBtn;
  labelx   : tlabel;
  editx    : tedit;
  shape1   : tshape;
  label_main,label1,status1,group1,state1,perm1, device1, name1,name2,s2,device_short,group_short,rule1,message1: string;
  i,start0,start1,end0,left1,tab_position,nr_edits,tabsize,extratab : integer;
  function newname: string;
  begin
    result:=inttostr(counter1);
    inc(counter1);
  end;
  procedure extract_defswitch;
  begin
    repeat  {extract devSwitch}
      label1:='';
      status1:='';
      start1:=extract_level_2('defSwitch',s2,start1,name2,label1,status1);
      if start1<> 0 then
      begin
        btn := TBitBtn.Create(nil); {create buttons}
        btn.parent:=indi_tabs[tab_position];
        btn.top := indi_button_top[tab_position];
        btn.Left :=left1;
        btn.height :=25;
        btn.Caption := label1;
        btn.name :='bs'+device_short+stringreplace(name1+name2,' ','',[rfreplaceall]);{Store in component name the device and name}
        btn.hint:='<newSwitchVector device="'+device1+'" name="'+name1+'"><oneSwitch name="'+name2+'">On</oneSwitch></newSwitchVector>'; {store action in hint}
        btn.showhint:=false; {do not show hint}
        btn.width:=110;
        indi_live_bitbtn_components[nr_of_live_bitbtn_components]:=btn;{store component for later updating}
        if nr_of_live_bitbtn_components<maxobjects then inc(nr_of_live_bitbtn_components);
        if status1='Off' then begin btn.font.color:=cldefault; btn.font.style:=[];if rule1='AnyOfMany' then btn.Caption := btn.caption+' ☐';   end
        else
        if status1='On' then begin btn.font.color:=cldefault; btn.font.style:=[fsbold,fsunderline,fsitalic];if rule1='AnyOfMany' then btn.Caption := btn.caption+' ☑';  end
        else
        begin btn.font.color:=clsilver; btn.font.style:=[]; end;
        btn.OnClick := indi.WhatToDo;
        inc(left1,tabsize);{cope with 2,3 4 buttons}
     end;
    until start1=0;
  end;
  procedure extract_defnumber;
  begin
    start1:=16;{after defNumberVector}
    nr_edits:=0;
    repeat  {extract defNumber}
      label1:='';
      status1:='';
      start1:=extract_level_2('defNumber',s2,start1,name2,label1,status1);{extract level 2 and return end position}
      if start1<> 0 then
      begin
        labelx:= Tlabel.Create(nil); {create main label}
        labelx.parent:=indi_tabs[tab_position];
        labelx.top := indi_button_top[tab_position]+5;
        labelx.Left :=left1;
        labelx.autosize:=true;
        labelx.Caption :=label1;

        labelx:= Tlabel.Create(nil); {create live data label}
        labelx.parent:=indi_tabs[tab_position];
        labelx.top := indi_button_top[tab_position]+5;
        labelx.Left :=left1+tabsize   { +tabsize};
        labelx.autosize:=false;{otherwise right justify doesnt work}
        labelx.width:=tabsize-20;{=100. Otherwise right justify doesnt work}
        labelx.alignment:=tarightJustify;{allows more space if long main labels where used and live data is not overwritten}
        labelx.name :='ln'+device_short+stringreplace(name1+name2,' ','',[rfreplaceall]);{Store in component name the device and name}
        labelx.caption:=copy(status1,1,8);
        indi_live_label_components[nr_of_live_label_components]:=labelx;
        if nr_of_live_label_components<maxobjects {protection against error 201} then inc(nr_of_live_label_components);

        if perm1='rw' then
        begin
          editx:= Tedit.Create(nil); {create main label}
          editx.parent:=indi_tabs[tab_position];
          editx.top := indi_button_top[tab_position]+5;
          editx.Left :=left1+tabsize+tabsize;
          editx.width :=110;
          editx.name:='en'+newname;{create unique name }
          editx.caption:=copy(status1,1,8);
          indi_edit_components[nr_of_edits]:=editx;{store for later}
          if nr_of_edits<maxobjects {protection against error 201} then inc(nr_of_edits);
          inc(nr_edits);


          if nr_edits=1 then {make only once the set button for both RA, DEC}
          begin
            btn := TBitBtn.Create(nil); {create buttons}
            btn.parent:=indi_tabs[tab_position];
            btn.top := indi_button_top[tab_position]+5;
            btn.Left :=left1+tabsize+tabsize+tabsize;
            btn.height :=25;
            btn.Caption :='Set';  {set button}
          {<newNumberVector  device="ASCOM Simulator Telescope"  name="EQUATORIAL_EOD_COORD"><oneNumber    name="RA">   13  </oneNumber>  <oneNumber    name="DEC">   13  </oneNumber></newNumberVector>}
            btn.hint:='<newNumberVector device="'+device1+'" name="'+name1+'"><oneNumber name="'+name2+'">@'+editx.name+'#</oneNumber>';{store device name in hint, update later value between @#}
            btn.width:=40;
            btn.showhint:=false; {do not show hint}
            btn.OnClick := indi.WhatToDo_number;
          end
          else {add second ord third analog value to hint}
            btn.hint:=btn.hint+'<oneNumber name="'+name2+'">@'+editx.name+'#</oneNumber>';{store device name in hint, update later value between @#}
        end;
        inc(indi_button_top[tab_position],30); {every analog value on new row}
      end;{start1<>0}
    until start1=0;
    if nr_edits<>0 then  btn.hint:=btn.hint+'</newNumberVector>'; {finalize instruction stored in btn hint}
  end;

  procedure extract_deftext;
  begin
    start1:=16;{after defTextVector}
    nr_edits:=0;{nuber of edits for set button}
    repeat  {extract devText}
      label1:='';
      status1:='';
      start1:=extract_level_2('defText',s2,start1,name2,label1,status1);
      if start1<> 0 then
      begin
        labelx:= Tlabel.Create(nil); {create main label}
        labelx.parent:=indi_tabs[tab_position];
        labelx.top := indi_button_top[tab_position]+5;
        labelx.Left :=left1;
        labelx.autosize:=true;
        labelx.Caption :=label1;

        labelx:= Tlabel.Create(nil); {create live data label}
        labelx.parent:=indi_tabs[tab_position];
        labelx.top := indi_button_top[tab_position]+5;
        labelx.Left :=left1+tabsize;
        labelx.autosize:=true;
        labelx.name :='lt'+device_short+stringreplace(name1+name2,' ','',[rfreplaceall]);{Store in component name the device and name}
        labelx.caption:=status1;
        indi_live_label_components[nr_of_live_label_components]:=labelx;
        if nr_of_live_label_components<maxobjects {protection against error 201} then inc(nr_of_live_label_components);

        if perm1='rw' then
        begin
          editx:= Tedit.Create(nil); {create main label}
          editx.parent:=indi_tabs[tab_position];
          editx.top := indi_button_top[tab_position]+5;
          editx.Left :=left1+tabsize+tabsize;
          editx.width :=110;
          editx.name:='et'+newname;{create unique name }
          editx.caption:=status1;
          indi_edit_components[nr_of_edits]:=editx;{store for later}
          if nr_of_edits<maxobjects {protection against error 201} then inc(nr_of_edits);{total}
          inc(nr_edits);{edits for set button}


          if nr_edits=1 then {make only once the set button for both or more values}
          begin
            btn := TBitBtn.Create(nil); {create buttons}
            btn.parent:=indi_tabs[tab_position];
            btn.top := indi_button_top[tab_position];
            btn.Left :=left1+tabsize+tabsize+tabsize;
            btn.height :=25;
            btn.Caption :='Set';  {set button, only one for the group}
          //<newTextVector device="Telescope Simulator" name="DEVICE_PORT"><oneText name="PORT">/indistarter</oneText></newTextVector>
            btn.hint:='<newTextVector device="'+device1+'" name="'+name1+'"><oneText name="'+name2+'">@'+editx.name+'#</oneText>';{store device name in hint, update later value between @#}
            btn.width:=40;
            btn.showhint:=false; {do not show hint}
            with indi do
              btn.OnClick := indi.WhatToDo_number;
          end
          else {add second ord third analog value to hint}
            btn.hint:=btn.hint+'<oneText name="'+name2+'">@'+editx.name+'#</oneText>';{store device name in hint, update later value between @#}
        end;
        inc(indi_button_top[tab_position],30); {every text value on new row}
      end;{start1<>0}
    until start1=0;
    if nr_edits<>0 then  btn.hint:=btn.hint+'</newTextVector>'; {finalize instruction stored in btn hint}

  end;{deftext}

  procedure extract_deflight;
  begin
    start1:=16;{after defLightVector}
    repeat  {extract devLight}
      label1:='';
      status1:='';
      start1:=extract_level_2('defLight',s2,start1,name2,label1,status1);
      if start1<> 0 then
      begin
        labelx:= Tlabel.Create(nil); {create main label}
        labelx.parent:=indi_tabs[tab_position];
        labelx.top := indi_button_top[tab_position]+5;
        labelx.Left :=left1;
        labelx.autosize:=true;
        labelx.Caption :=label1;

        shape1:= Tshape.Create(nil); {create live shape}
        shape1.parent:=indi_tabs[tab_position];
        shape1.top := indi_button_top[tab_position]+5;
        shape1.Left :=left1+tabsize;;
        shape1.Width:=12;
        shape1.height:=12;
        shape1.name:='sh'+device_short+name1+name2;{store name for later updating}
        indi_live_shapes[nr_of_shapes]:=shape1;
        inc(nr_of_shapes);
        if status1='Ok' then shape1.brush.color:=clgreen
        else
        if status1='Idle' then shape1.brush.color:=clsilver
        else
        if status1='Busy' then shape1.brush.color:=clYellow
        else
        if status1='Alert' then shape1.brush.color:=clred
        else  shape1.brush.color:=clblack;
      end;{start1<>0}
      inc(indi_button_top[tab_position],30); {every text value on new row}
    until start1=0;
  end;{deflight}

begin
  mode:=1;
  repeat
    label_main:='';
    group1:='';
    state1:='';
    perm1:='';
    tabsize:=120;
    rule1:='';
    message1:='';
    end0:=0;{for case none is found}
    case mode of 1: begin
                      start0:=pos('<defSwitchVector',s); {switches}
                      if start0 <>0 then
                      end0:=extract_level_1('defSwitchVector',s,device1,name1,label_main,group1,state1,perm1,rule1,message1);
                    end;
                 2: begin
                      start0:=pos('<defNumberVector',s); {numbers}
                      if start0 <>0 then end0:=extract_level_1('defNumberVector',s,device1,name1,label_main,group1,state1,perm1,rule1,message1);
                    end;
                 3: begin
                      start0:=pos('<defTextVector',s);  {texts}
                      if start0 <>0 then  end0:=extract_level_1('defTextVector',s,device1,name1,label_main,group1,state1,perm1,rule1,message1);
                    end;
                 4: begin
                      start0:=pos('<defLightVector',s); {lights}
                      if start0 <>0 then
                      end0:=extract_level_1('defLightVector',s,device1,name1,label_main,group1,state1,perm1,rule1,message1);
                    end;
    end;{case}

    if message1<>'' then
    if  ((all_device_communication) or (device1=indi.telescope_name_select2.text))  then {all or the device of interest}
    begin
      indi.Memo1.lines.add (message1);{message from extract_level1}
      {activate scrolling memo1}
      indi.memo1.SelStart:=Length(indi.memo1.Lines.Text);
      indi.memo1.SelLength:=0;
    end;

    if ((start0<>0) and (end0=0)) then
       delete(s,start0,13){missing end marker, remove start}
    else
    if ((end0=0) or (start0=0)) then
    begin
      inc(mode);{go to next search}
      if mode>4 then
      begin
        if length(s)>40 then update_indi_menu(s); {use live data to update}
        exit;{leave}
      end;
    end
    else
    if ((start0<>0) and  (end0<>0)) then {found something readable}
    begin {start making menu}
      s2:=copy(s,start0,end0-start0);
      delete(s,start0,end0-start0); {in S2, delete this part}

      if pos(device1,indi.telescope_name_select2.items.text)=0 then {new device, no doubleringen}
         indi.telescope_name_select2.items.add(device1);

      if device1=indi.telescope_name_select2.text  then {the device of interest}
      begin
        device_short:=stringreplace(device1,' ','',[rfreplaceall]);
        device_short:=stringreplace(device_short,'-','',[rfreplaceall]);{component names can't contain minus signs}
        group_short:=stringreplace(group1,' ','',[rfreplaceall]);
        tab_position:=nr_of_tabs;
        for i:=0 to nr_of_tabs-1 do {TAB existing?}
        begin
          if ((indi_devices[i]=device_short) and (indi_groups[i]=group_short)) then tab_position:=i;{which tab are we putting buttons}
        end;
        if ((end0<>0) and (tab_position=nr_of_tabs) and (nr_of_tabs<maxtabs){limit}) {new device and group, then make new tab}
        then
        begin  {create tabs}
          TabSheet := TTabSheet.Create(indi.PageControl1);
          TabSheet.Caption := group1{+' ('+stringreplace(device1,' ','',[rfreplaceall])+')'};
          TabSheet.PageControl := indi.PageControl1;
          indi_button_top[nr_of_tabs]:=5; {where is place for a button, start from 30}
          indi_devices[nr_of_tabs]:=device_short;{store device name}
          indi_groups[nr_of_tabs]:=group_short;{store group name}
          indi_tabs[nr_of_tabs]:=tabsheet;{store tobject}
          inc(nr_of_tabs);
          indi.no_indi_devices_available1.visible:=false;{ devices are available, hide this one}

        end;

        if ((end0<>0) and (find_label(Device_Short+group_short+name1)=-1) {existing?}) then {extract switch vector}
        begin
          left1:=210;
          start1:=13;{after defSwitchVector}

          shape1:= Tshape.Create(nil); {create main label}
          shape1.parent:=indi_tabs[tab_position];
          shape1.top := indi_button_top[tab_position]+5;
          shape1.Left :=5;
          shape1.Width:=12;
          shape1.height:=12;
          shape1.name:='sh'+device_Short+name1;{store name for later updating}
          indi_live_shapes[nr_of_shapes]:=shape1;
          if nr_of_shapes<maxobjects {protection against error 201} then inc(nr_of_shapes);
          if state1='Ok' then shape1.brush.color:=clwhite
          else
          if state1='Idle' then shape1.brush.color:=clsilver
          else
          if state1='Busy' then shape1.brush.color:=clgray
          else
          shape1.brush.color:=clblack;

          labelx:= Tlabel.Create(nil); {create main label}
          labelx.parent:=indi_tabs[tab_position];
          labelx.top := indi_button_top[tab_position]+5;
          labelx.Left :=25;
          labelx.autosize:=false;
          labelx.Width:=175;
          labelx.height:=100;
          labelx.wordwrap:=true;
          labelx.Caption :=label_main;
          labelx.hint := label_main;
          labelx.showhint:=true;
          indi_labels[nr_of_labels]:=device_Short+group_short+name1;{remember is this is already made to prevent duplicates}
          if nr_of_labels<maxobjects {protection against error 201} then inc(nr_of_labels);

          case mode of 1:extract_defswitch;{build menu switches}
                       2:extract_defnumber;{build menu}
                       3:extract_deftext;  {build menu}
                       4:extract_deflight; {build menu}

          end;{case}
          inc(indi_button_top[tab_position],30); {new button row for next button}
        end;{non existing label, make it}
      end;{device of interest}
    end;{start making menu}
  until false; {jump out with exit;}
end;

end.

