unit hns_Ucen;
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
   SysUtils,
 {$endif}
   {$ifdef unix}
   baseunix,
   sysutils,{uppcase}
   LCLIntf,{for selectobject, invalidaterect}
{$endif}
 Forms, StdCtrls, Buttons, strUtils, controls, classes, graphics, Menus;
    {$IFDEF fpc}
    {$else}  {delphi}
    {$endif}
type

  { Tcenter_on }

  Tcenter_on = class(TForm)
    autozoom1: TCheckBox;
    center1: TCheckBox;
    slewto1: TCheckBox;
    deepsky2: TBitBtn;
    deepsky3: TBitBtn;
    search_simbad1: TBitBtn;
    go_to1: TBItBtN;
    constellations1: TBItBtN;
    abb1: TBItBtN;
    brightstars1: TBItBtN;
    comets1: TBItBtN;
    ListBox1: TListBox;
    planets1: TBItBtN;
    edit1: Tedit;
    Cancel1: TBItBtN;
    asteroids1: TBItBtN;
    Supp1: TBItBtN;
    Supp2: TBItBtN;
    supp3: TBItBtN;
    supp4: TBItBtN;
    supp5: TBItBtN;
    deepsky1: TBItBtN;
    help_searchmenu: TLabel;
    procedure Cancel1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure go_to1Click(Sender: TObject);
    procedure constellations1Click(Sender: TObject);
    procedure abb1Click(Sender: TObject);
    procedure brightstars1Click(Sender: TObject);
    procedure comets1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1KeyPress(Sender: TObject; var Key: char);
    procedure planets1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edit1KeyPress(Sender: TObject; var Key: Char);
    procedure edit1DblClick(Sender: TObject);
    procedure asteroids1Click(Sender: TObject);
    procedure search_simbad1Click(Sender: TObject);
    procedure SuppClick(Sender: TObject);
    procedure deepsky1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure help_searchmenuClick(Sender: TObject);
//    function FormHelp(Command: Word; Data: NativeInt;var CallHelp: Boolean): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  center_on: Tcenter_on;

const
      deepsky_string: string='Deep-sky';
      deep1         : string='Deep-1';
      deep2         : string='Deep-2';
      deep3         : string='Deep-3';


implementation

uses hns_main, hns_Ucon, hns_unon, hns_Uobj;

{$IFDEF fpc}
  {$R *.lfm}
{$ELSE} {delphi}
  {$R *.DFM}
{$ENDIF}

const supplement :integer=1;
var
  store_short: array[0..4] of tshortcut;{for storing short cuts}

procedure Tcenter_on.Cancel1Click(Sender: TObject);
begin
  {!! important set borderstyle of form at bsdialog. Then background is recovered by windows !!!}
  center_on.visible:=false;  {hide window}
  mainwindow.setfocus;
end;


procedure Tcenter_on.FormShow(Sender: TObject);
begin
  Edit1.SelectAll; {extra select all}
  center1.checked:=auto_center;
  autozoom1.checked:=auto_zoom;
  slewto1.checked:=slewto;
end;

function prepare_filter(inp3:string):string;{make filter string from string in combobox}
begin
  result:='';
  result:=StringReplace(uppercase(inp3), ' ', '',[rfReplaceAll]);{replace all space and make upcase}
  result:=StringReplace(result, '*', '',[rfReplaceAll]);{remove wildchard}
end;

procedure filter_combobox(buf2: string);
var
    temporary : tstrings;
    k         : integer;
begin
  temporary:= Tstringlist.Create;
  temporary.text:='';{clearbuffer}
  for k:=0 to center_on.listbox1.Items.Count-1 do
  begin
    if pos(buf2,uppercase(center_on.listbox1.Items[k]))<>0 then
                 temporary.add(center_on.listbox1.Items[k]);
  end;
  center_on.listbox1.items.text:=temporary.text;
  temporary.free;
end;
procedure Tcenter_on.go_to1Click(Sender: TObject);
{var height: string;}
var i,j     :  integer;
    c1,c2   :  array[0..21] of char;
begin
  if (  ((listbox1.itemindex)<0) and (pos('*',edit1.text)=0) ) then listbox1.Items.Add(edit1.text);{add last item to list if not from list}

  auto_center:=center1.checked;
  auto_zoom:=autozoom1.checked;
  slewto:=slewto1.checked;

  if length(edit1.text)>0 then
  begin
    goto_str:=StringReplace(uppercase(edit1.text), ' ', '',[rfReplaceAll]);{remove spaces, note save replace for UTF8, otherwise use UTF8Copy(upedit,i,1))}

    if  pos('*',goto_str)>0  then
    begin
      goto_str:=StringReplace(goto_str, '*', '',[rfReplaceAll]);{remove wildchard}
      filter_combobox(goto_str);
      exit;
    end;
    j:=-1;
    i:=-1;
    repeat
      inc(i);
      strpcopy(c1,Constname[i]);
      strpcopy(c2,Constshortname[i]);
      if ((comparetext(goto_str,C1)=0) or
          (comparetext(goto_str,c2)=0))  then
      begin
        j:=i;
        ra_const :=Constpos[j,0]*pi*2/24000;
        dec_const:=Constpos[j,1]*pi/18000;
       {use ra_const, dec because ra2 and dec2 are spoiled by mousemove}
         action2:=2;
        if auto_zoom then begin zoom:=5;constellat:=1;{constellation on} end;
        naam2:=edit1.text;
      end;
    until ((i=88) or (j<>-1));

    if J=-1 then
    begin {normal search action}
      action2:=1; {find action in hns_main at Tmainwindow.FormPaint}
    end;
  end;{edit.text length>0}

  mainwindow.setfocus;

  if sender<>nil then {no double click, hide search windoww}
    center_on.visible:=false;  {hide window}

  if ((auto_center) and (slewto=false) and (mainwindow.connect_telescope1.Checked)) then
             mainwindow.tracktelescope1.checked:=false;{allow to go to the object}

  missedupdate:=1;
  paint_sky;{rewrite window}
end;

procedure Tcenter_on.constellations1Click(Sender: TObject);
var i:integer;
begin
  listbox1.Clear; { empty the list of any old values }
  with  listbox1.Items do
  begin
    for i:=0 to 88 do Add(Constname[i]);
  end;
 ActiveControl:=listbox1;{set focus on listbox1 text window}
end;

procedure Tcenter_on.abb1Click(Sender: TObject);
var i:integer;
begin
  listbox1.Clear; { empty the list of any old values }
  with  listbox1.Items do
  begin
    for i:=0 to 88 do Add(Constshortname[i]);
  end;
  ActiveControl:=listbox1;{set focus on listbox1 text window}
end;

procedure Tcenter_on.brightstars1Click(Sender: TObject);
var i:integer;
    filterstr: string;

begin
  filterstr:=prepare_filter(edit1.text);
  listbox1.Clear; { empty the list of any old values }
  with  listbox1.Items do
  begin
    for i:=0 to 67 do
      if  ((length(filterstr)=0) or (pos(filterstr,uppercase(Bright_star_name[i]))>0)) then  Add(Bright_star_name[i]);
  end;
  edit1.text:='';{clear filtering}
  ActiveControl:=listbox1;{set focus on listbox1 text window}
end;
procedure Tcenter_on.asteroids1Click(Sender: TObject);
var
  i,x,y    : integer;
  regel    : string;
  name9    : array[0..255] of widechar;
  filterstr: string;
  oldCursor : TCursor;
begin {asteroids1}
  oldCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  filterstr:=prepare_filter(edit1.text);
  listbox1.Clear; { empty the list of any old values }
  with  listbox1.Items do
  for i:=0 to asteroidstring.count-1 do
  begin
    regel:=asteroidstring.strings[i];
    if pos(';',regel)=0 then
    begin
      x:=1;
      Y:=0;
      while ((x<=length(regel)) and (regel[x]<>'|')) do
      begin
       if regel[x]<>' ' then  begin name9[y]:=regel[x];inc(y);  end;{no spaces}
       inc(x);
      end;
      name9[y]:=ansichar(#0);{set length correct}
      if  ((length(filterstr)=0) or (pos(filterstr,uppercase(name9))>0)) then  Add(name9);
    end;
  end;
  edit1.text:='';{clear filtering}
  ActiveControl:=listbox1;{set focus on listbox1 text window}
  Screen.Cursor := oldCursor;
end;

function extract_string(search,inp : string; len:integer) :string;
begin
  result:=trim(copy(inp, pos(search, inp)+length(search),len));
end;

procedure Tcenter_on.search_simbad1Click(Sender: TObject);
var
  position,regel,request,mag_str,obj,name,name2,obj_type,brightness  : string;
  magnitude,size:double;
  error2,c1,c2,counter   : integer;
begin
// Flux V : 6.25 [~] D 2012AJ....144..126D
// Angular size: 1.8600 1.8600   0 (~)  D 2008MNRAS.389.1924F

  request:='https://simbad.u-strasbg.fr/simbad/sim-id?Ident='+StringReplace(edit1.text,' ', '_',[rfReplaceAll])+'&outputmode=list&output.format=ascii';{replace space by underscore for internet request in Linux}

  if DownloadFile(request,cache_path+'simbad_query.txt') then
  begin
    search_simbad1.font.color:=cldefault;{internet connection. Clear any red color=error}
    with catalogstring do
    begin
      try
      LoadFromFile(cache_path+'simbad_query.txt');{load from file }
      except;{no file available}
        clear;
        exit;
      end;
      if catalogstring.count<10 then {Simbad can't find the object}
      begin
        edit1.text:=edit1.text+'?';
        exit;
      end;
      position:=extract_string('Coordinates(ICRS,ep=J2000,eq=2000): ',catalogstring.text,50);//05 37 38.6854231  +21 08 33.158804 (Opt ) A [0.72 0.50 90] 2007A&A...474..653V
      position:=stringReplace(position,'  ', ',',[rfReplaceAll]);
      position:=stringReplace(position,' ', ',',[rfReplaceAll]);
      c1:=0;
      counter:=0;
      repeat {get 6 position values plus an extra comma}
        C1:=posex(',',position,c1+1);
        inc(counter);
      until ((counter>5) or (c1=0));
      position:=copy(position,1,c1);

      val(extract_string('Flux V : ',catalogstring.text,5),magnitude,error2);
      if mag<>0 then mag_str:=inttostr(round(magnitude*10)) else mag_str:='';

      val(extract_string('Angular size: ',catalogstring.text,5),size,error2);

      obj:=extract_string('Object ',catalogstring.text,34);
      c1:=pos('---',obj);
      name:=trim(copy(obj,1,c1-1));
      c2:=posex('---',obj,c1+3);
      c1:=c1+3;
      obj_type:=trim(copy(obj,c1,c2-c1));
      obj_type:=StringReplace(obj_type,'*', '★',[rfReplaceAll]);{replace  asterisk with real star}

      if pos('*',name)>0 then brightness:='' {make star E.g. fw peg}
      else
      begin
        if size=0 then brightness:='-98' {make label. Eg. Abell13}
      else
        brightness:='999'; {deepsky object}
      end;

      name:=StringReplace(name,'V* ', '',[rfReplaceAll]);{replace variable star with nothing}
      name:=StringReplace(name,' ', '_',[rfReplaceAll]);

      name2:=StringReplace(catalogstring.strings[2],' ', '_',[rfReplaceAll]);


      regel:=position+
             mag_str+','+ {magnitude}
             name+'/'+name2 {orginal search name}+','+
             obj_type+','+ {type}
             brightness+','+
             inttostr(round(size*10)); {size};// Angular size: 1.8600 1.8600   0 (~)  D 2008MNRAS.389.1924F

      supplstring2.add(regel);{add to supplement2}
      suppl2_activated:=1;{active supplement 2}
      if length(name_supl2)<5 then name_supl2:='Simbad.sup';

      edit1.text:=name2;
      go_to1Click(nil);{goto after double click}
    end;
  end
  else
    search_simbad1.font.color:=clred;
end;

procedure Tcenter_on.comets1Click(Sender: TObject);
var
  i,x,y    : integer;
  regel    : string;
  name9    : array[0..255] of widechar;
  filterstr: string;
  oldCursor : TCursor;
begin {comets1}
  oldCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  filterstr:=prepare_filter(edit1.text);
  listbox1.Clear; { empty the list of any old values }
  with  listbox1.Items do
  for i:=0 to cometstring.count-1 do
  begin
    regel:=cometstring.strings[i];
    if pos(';',regel)=0 then
    begin
      x:=1;
      Y:=0;
      while ((x<=length(regel)) and (regel[x]<>'|')) do
      begin
       if regel[x]<>' ' then  begin name9[y]:=regel[x];inc(y);  end;{no spaces}
       inc(x);
      end;
      name9[y]:=ansichar(#0);{set length correct}
      if  ((length(filterstr)=0) or (pos(filterstr,uppercase(name9))>0)) then  Add(name9);
    end;
  end;
  edit1.text:='';{clear filtering}
  ActiveControl:=listbox1;{set focus on listbox1 text window}
  Screen.Cursor := oldCursor;
end;

procedure Tcenter_on.ListBox1Click(Sender: TObject);
begin
  if  (listbox1.itemindex)>=0 then {prevent error if nothing is selected}
  edit1.text:=listbox1.Items[listbox1.itemindex];{copy selection to edit }
end;

procedure Tcenter_on.ListBox1DblClick(Sender: TObject);
begin
  if  (listbox1.itemindex)>=0 then {prevent error if nothing is selected}
  begin
    edit1.text:=listbox1.Items[listbox1.itemindex];{copy selection to edit }
    go_to1Click(nil);{goto after double click}
  end;
end;

procedure Tcenter_on.ListBox1KeyPress(Sender: TObject; var Key: char);
begin
  if key=#27 {esc  } then cancel1Click(Sender); {leave form}
  if key=#13 {enter} then go_to1Click(Sender); {leave form}
end;

procedure Tcenter_on.planets1Click(Sender: TObject);
begin
  listbox1.Clear; { empty the list of any old values }
  with  listbox1.Items do
  begin
    Add((Sun_string));
    Add((moon_string));
    Add((mercury_string));
    Add((venus_string));
    Add((mars_string));
    Add((jupiter_string));
    Add((saturn_string));
    Add((uranus_string));
    Add((neptune_string));
    Add((pluto_string));

    Add(Triton_string);

    Add(Ariel_string);
    Add(Umbriel_string);
    Add(Titania_string);
    Add(Oberon_string );

    Add(Mimas_string);
    Add(Enceladus_string);
    Add(Tethys_string );
    Add(Dione_string);
    Add(Rhea_string );
    Add(Titan_string);
    Add(Hyperion_string);
    Add(Iapetus_string);

   Add(IO_string   );
   Add(Europa_string );
   Add(Ganymede_string);
   Add(Callisto_string);

   Add(Phobos_string);
   Add(Deimos_string);
 end;
 ActiveControl:=listbox1;{set focus on listbox1 text window}
end;

procedure Tcenter_on.FormActivate(Sender: TObject);
begin
  store_short[0]:=mainwindow.zenith1.shortcut;{disabled hidden submenu in mainmenu for hot key North, S, E, W for case only single letters are used such as N}
  store_short[1]:=mainwindow.north1.shortcut;{disabled hidden submenu in mainmenu for hot key North, S, E, W for case only single letters are used such as N}
  store_short[2]:=mainwindow.south1.shortcut;{disabled hidden submenu in mainmenu for hot key North, S, E, W for case only single letters are used such as N}
  store_short[3]:=mainwindow.east1.shortcut;{disabled hidden submenu in mainmenu for hot key North, S, E, W for case only single letters are used such as N}
  store_short[4]:=mainwindow.west1.shortcut;{disabled hidden submenu in mainmenu for hot key North, S, E, W for case only single letters are used such as N}
  mainwindow.zenith1.shortcut:=0;
  mainwindow.north1.shortcut:=0;
  mainwindow.south1.shortcut:=0;
  mainwindow.east1.shortcut:=0;
  mainwindow.west1.shortcut:=0;

  listbox1.hint:=edit1.hint; {copy de non-english hint};
  ActiveControl:=edit1;{set focus on listbox1 text window}
end;

procedure Tcenter_on.edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 {enter} then go_to1Click(Sender); {leave form}
  if key=#27 {esc  } then cancel1Click(Sender); {leave form}

end;

procedure Tcenter_on.edit1DblClick(Sender: TObject);
begin
   go_to1Click(nil);{goto after double click}
end;

procedure Tcenter_on.SuppClick(Sender: TObject);
var
  i,x,kommas,backsl1, backsl2, counts : integer;
  data1,s1,s2,s3,v                   : string;
  filterstr                          : string;
  oldCursor : TCursor;
begin  {suppl}
  oldCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  filterstr:=prepare_filter(edit1.text);
  if sender=supp1 then supplement:=1 else
  if sender=supp2 then supplement:=2 else
  if sender=supp3 then supplement:=3 else
  if sender=supp4 then supplement:=4 else
  if sender=supp5 then supplement:=5;


  filterstr:=prepare_filter(edit1.text);{prepare filterstring}
  listbox1.Clear; { empty the list of any old values }
  case supplement of 1:   counts:=supplstring1.count-1;
                     2:   counts:=supplstring2.count-1;
                     3:   counts:=supplstring3.count-1;
                     4:   counts:=supplstring4.count-1;
                     5:   counts:=supplstring5.count-1;
                     else counts:=0; {not an existing supplement}
                     end; {case}
  with  listbox1.Items do
  for i:=0 to counts do
  begin
    case supplement of 1:   v:=supplstring1.strings[i];
                       2:   v:=supplstring2.strings[i];
                       3:   v:=supplstring3.strings[i];
                       4:   v:=supplstring4.strings[i];
                       5:   v:=supplstring5.strings[i];
                       else v:='';
                       end; {case}

    if ((length(v)>0) and (';'<>copy(v,1,1))) then {no comments and not empthy}
    begin
      x:=1;
      kommas:=0;
      data1:='';
      s1:='';  s2:='';   s3:='';
      repeat
        if v[x]=',' then inc(kommas);
        inc(x);
      until ((kommas=7) or (x>length(v))); {skip first 7 kommas}
      while ((x<=length(v)) and (v[x]<>',')) do
      begin
       if v[x]<>' ' then begin data1:=data1+v[x]; end;{no spaces}
       inc(x);
      end;

      backsl1:=pos('/',data1);
      if backsl1=0 then s1:=data1
      else
      begin
        s1:=copy(data1,1,backsl1-1);
        backsl2:=posEX('/',data1,backsl1+2);     { could also use LastDelimiter}
        if backsl2=0 then s2:=copy(data1,backsl1+1,length(data1)-backsl1+1)
        else
        begin
          s2:=copy(data1,backsl1+1,backsl2-backsl1-1);
          s3:=copy(data1,backsl2+1,length(data1)-backsl2+1);
        end;
      end;
      if ((length(s1)>0)  and (((length(filterstr)=0) or (pos(filterstr,uppercase(s1))>0)))) then Add(s1);
      if ((length(s2)>0)  and (((length(filterstr)=0) or (pos(filterstr,uppercase(s2))>0)))) then Add(s2);
      if ((length(s3)>0)  and (((length(filterstr)=0) or (pos(filterstr,uppercase(s3))>0)))) then Add(s3);

    end;
  end;
  supplement:=1; {always as start position}
  edit1.text:='';{clear filtering}
  ActiveControl:=listbox1;{set focus on listbox1 text window}
  Screen.Cursor := oldCursor;
end;

procedure Tcenter_on.deepsky1Click(Sender: TObject);
var
    filterstr:string;
    oldCursor : TCursor;
    maxlinepos   : integer;
 begin
  oldCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  filterstr:=prepare_filter(edit1.text);

  listbox1.Clear; { empty the list of any old values }
  mag2:=0; {is compared with deep for maximum magnitude, should be set low before starting}
  linepos :=2;
  mode:=5;
  deep:=99999999;
  if sender=deepsky1 then maxlinepos:=position_deep2 {search until begin second section}
  else
  if sender=deepsky2 then maxlinepos:=position_deep3  {search until begin third section}
  else
  maxlinepos:=999999999;
  repeat
    read_deepsky('T');{deepsky1 database search, text mode}
    if ((length(filterstr)=0) or (pos(filterstr,uppercase(naam2))>0)) then  listbox1.Items.Add(naam2);
    if ((length(naam3)>0)  and (((length(filterstr)=0) or (pos(filterstr,uppercase(naam3))>0)))) then listbox1.Items.Add(naam3);
    if ((length(naam4)>0)  and (((length(filterstr)=0) or (pos(filterstr,uppercase(naam4))>0)))) then listbox1.Items.Add(naam4);
  until ((mode>5) or (linepos>=maxlinepos));
  edit1.text:='';{clear filtering}
  ActiveControl:=listbox1;{set focus on listbox1 text window}
  Screen.Cursor := oldCursor;
end;

procedure Tcenter_on.FormCreate(Sender: TObject);
begin
  if language_mode<>0 then load_center;
  position:=podesigned;{otherwise positioning doesn't work in FPC}
  center_on.top:=searchmenutop;
  center_on.left:=searchmenuleft;
end;

procedure Tcenter_on.FormDeactivate(Sender: TObject);
begin
  mainwindow.zenith1.shortcut:=store_short[0];{enable hidden submenu in mainmenu for hot key North, S, E, W for case only single letters are used such as N}
  mainwindow.north1.shortcut:=store_short[1];
  mainwindow.south1.shortcut:=store_short[2];
  mainwindow.east1.shortcut:=store_short[3];
  mainwindow.west1.shortcut:=store_short[4];
end;

//function Tcenter_on.FormHelp(Command: Word; Data: NativeInt; var CallHelp: Boolean): Boolean;
//begin
//  CallHelp :=  false; // True; - to execute the default OnHelp event handler
//  open_file_with_parameters(help_path,'#searching');
//end;

procedure Tcenter_on.FormPaint(Sender: TObject);
begin
  if ((center_on.slewto1.checked) and (mainwindow.connect_telescope1.Checked)) then go_to1.glyphshowmode:=gsmApplication {show telescope glyph}
                                                                     else go_to1.glyphshowmode:=gsmnever;

//  if ((mainwindow.tracktelescope1.checked) and (mainwindow.connect_telescope1.Checked)) then go_to1.glyphshowmode:=gsmApplication {show telescope glyph}
//                                                                                       else go_to1.glyphshowmode:=gsmnever;

 supp1.enabled:=suppl1_activated<>0;
 supp2.enabled:=suppl2_activated<>0;
 supp3.enabled:=suppl3_activated<>0;
 supp4.enabled:=suppl4_activated<>0;
 supp5.enabled:=suppl5_activated<>0;
 asteroids1.enabled:=asteroids_activated<>0;
 comets1.enabled:=comets_activated<>0;
// planets1.enabled:=planets_activated<>0;{removed 2019}

 brightstars1.enabled:=((stars_activated<>0) and ((stardatabase_displayed=0) or (stardatabase_displayed=290)));
// deepsky1.enabled:=deep_database<>0;{removed 2019}

 deepsky1.caption:=Deepsky_string+'1';

 supp1.hint:=objectmenu.supl1.hint;{2015-11}
 supp2.hint:=objectmenu.supl2.hint;
 supp3.hint:=objectmenu.supl3.hint;
 supp4.hint:=objectmenu.supl4.hint;
 supp5.hint:=objectmenu.supl5.hint;
end;

procedure Tcenter_on.help_searchmenuClick(Sender: TObject);
begin
  open_file_with_parameters(help_path,'#searching');
end;

end.
