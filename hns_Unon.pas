unit hns_Unon;
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

uses classes, {for tstrings}
  {$ifdef mswindows}

  {$ELSE} {unix}
    Baseunix,
  {$endif}

  {$IFDEF fpc}
   LCLType,
   LCLProc, {texttoshortcut}
  {$else}
   Windows, {for messagebox}
  {$ENDIF}
   menus, inifiles, Forms, Dialogs,sysutils, {stringreplace}
   hns_main,hns_Ucen,hns_Ugot,hns_Utim,hns_Uobj,hns_Usol,hns_Uset,hns_Udrk,hns_Uedi, hns_Uani, hns_Uinp, hns_Utxt, hns_Upla;

const
    language_mode: integer=1; {load language modules}
var
  labelstring: TmemIniFile; {will contain the non-english labels}


procedure load_main;
procedure load_popup_mainmenu;
procedure load_popup;
procedure load_center;
procedure load_time;
procedure load_object;
procedure load_goto;
procedure load_sett;
procedure load_dark;
procedure load_planet;
procedure load_edit;
procedure load_search_results;
procedure load_general;
procedure load_animation;
procedure load_suppl_edit;


implementation

function wrap(inp :string):string;{wrapped hints text by adding return character}
var  i,j: integer;
    ch: char;
const
  wrap_at=40; {length of one line}
begin
  setlength(result,length(inp)); {fastest solution}
  j:=0;
  for i:=1 to length(inp) do
  begin
    ch:=inp[i];
    if ch=';' then{forced wrap by ";}
    begin
      result[i]:=#13; {add return}
      j:=i;{reset line length counter at current position}
    end
    else
    if ((i-j>wrap_at) and (ch=' ')) then
    begin
       result[i]:=#13; {add return}
       j:=i;{reset line length counter at current position}
    end
    else
      result[i]:=ch
  end;
end;

procedure load_general;
begin
  with labelstring do
  begin
  about_title:=ReadString('general','about_title','?');

  about_message1:=ReadString('general','about_message1','?');
  about_message2:=ReadString('general','about_message2','?');
  about_message3:=ReadString('general','about_message3','?');
  about_message4:=ReadString('general','about_message4','');
  about_message5:=ReadString('general','about_message5','');

  about_editor1:=ReadString('general','about_editor1','?');
  about_editor2:=ReadString('general','about_editor2','?');
  about_editor3:=ReadString('general','about_editor3','?');
  about_editor4:=ReadString('general','about_editor4','?');

  About_edit:=ReadString('general','about_edit','?');
  Lines_file:=ReadString('general','lines_file','?');
  Size_file:=ReadString('general','size_file','?');
  deepsky_file:=ReadString('general','deepsky_file','?');
  error_string:=ReadString('general','error_string','?');
  not_found:=ReadString('general','not_found','?');
  not_available:=ReadString('general','not_available','?');
  click_to_copy_string :=ReadString('general','click_to_copy_string','?');


  new_user_title:=ReadString('general','new_user_title','?');
  new_user1:=ReadString('general','new_user1','?');
  new_user2:=ReadString('general','new_user2','?');
  new_user3:=ReadString('general','new_user3','?');


  selected_databases:=ReadString('general','selected_databases','?');

  disabled_mess:=ReadString('general','disabled_mess','?');

  No_syntax_errors_found:=ReadString('general','no_syntax_err','?');
  Check_out:=ReadString('general','check_out','?');


  Field_string    :=ReadString('general','field_string','?');
  RA_string       :=ReadString('general','ra_string','?');
  DEC_string      :=ReadString('general','dec_string','?');
  app_string      :=ReadString('general','app_string','?');
  mean_string     :=ReadString('general','mean_string','?');
  Name_string     :=ReadString('general','name_string','?');
  Magn_string     :=ReadString('general','magn_string','?');
  Size_string     :=ReadString('general','size_string','?');
  Size2_string    :=ReadString('general','size2_string','?');
  Type_string     :=ReadString('general','type_string','?');
  Az_string       :=ReadString('general','az_string','?');
  Alt_string      :=ReadString('general','alt_string','?');
  Rise_string     :=ReadString('general','rise_string','?');
  meridian_string :=ReadString('general','meridian_string','?');{2018 Meridian:}
  Set_string      :=ReadString('general','set_string','?');
  above_string    :=ReadString('general','above_string','?');
  below_string    :=ReadString('general','below_string','?');
  Phase_string    :=ReadString('general','phase_string','?');
  Ringopn_string  :=ReadString('general','ringopn_string','?');
  Dist_string     :=ReadString('general','dist_string','?');
  Sun_dist_string :=ReadString('general','sun_dist_string','?');
  Brightn_string  :=ReadString('general','brightn_string','?');
  Spectral_string :=ReadString('general','spectral_string','?');
  open_status_title:=ReadString('general','open_status_title','?');
  open_event_title :=ReadString('general','open_event_title','?');
  save_status_title:=ReadString('general','save_status_title','?');
  open_fits_title:=ReadString('general','open_fits_title','?');{223}

  sun_string     :=ReadString('general','sun_string','?');
  moon_string    :=ReadString('general','moon_string','?');
  moon_string2   :=ReadString('general','moon_string2','?');
  Mercury_string :=ReadString('general','mercury_string','?');
  Mercury_hint   :=ReadString('general','mercury_hint','?');
  Venus_string   :=ReadString('general','venus_string','?');
  Venus_hint     :=ReadString('general','venus_hint','?');
  Mars_string    :=ReadString('general','mars_string','?');
  Mars_hint      :=ReadString('general','mars_hint','?');
  Jupiter_string :=ReadString('general','jupiter_string','?');

  Jupiter_hint   :=ReadString('general','jupiter_hint','?');
  Saturn_string  :=ReadString('general','saturn_string','?');
  Saturn_hint    :=ReadString('general','saturn_hint','?');
  Uranus_string  :=ReadString('general','uranus_string','?');
  Uranus_hint    :=ReadString('general','uranus_hint','?');
  Neptune_string :=ReadString('general','neptune_string','?');
  Neptune_hint   :=ReadString('general','neptune_hint','?');
  Pluto_string   :=ReadString('general','pluto_string','?');
  Pluto_hint     :=ReadString('general','pluto_hint','?');

  Moon_of_string  :=ReadString('general','moon_of_string','?');

  Triton_string  :=ReadString('general','triton_string','?');

  Ariel_string   :=ReadString('general','ariel_string','?');
  Umbriel_string :=ReadString('general','umbriel_string','?');
  Titania_string :=ReadString('general','titania_string','?');
  Oberon_string  :=ReadString('general','oberon_string','?');

  Mimas_string   :=ReadString('general','mimas_string','?');
  Enceladus_string :=ReadString('general','enceladus_string','?');
  Tethys_string  :=ReadString('general','tethys_string','?');
  Dione_string   :=ReadString('general','dione_string','?');
  Rhea_string    :=ReadString('general','rhea_string','?');
  Titan_string   :=ReadString('general','titan_string','?');
  Hyperion_string:=ReadString('general','hyperion_string','?');
  Iapetus_string :=ReadString('general','iapetus_string','?');

  IO_string      :=ReadString('general','io_string','?');
  Europa_string  :=ReadString('general','europa_string','?');
  Ganymede_string:=ReadString('general','ganymede_string','?');
  Callisto_string:=ReadString('general','callisto_string','?');

  Phobos_string  :=ReadString('general','phobos_string','?');
  Deimos_string  :=ReadString('general','deimos_string','?');

  Asteroid_string :=ReadString('general','asteroid_string','?');
  Comet_string    :=ReadString('general','comet_string','?');
  Star_string     :=ReadString('general','star_string','?');
  Galaxy_string   :=ReadString('general','galaxy_string','?');
  Blend_string    :=ReadString('general','blend_string','?');
  Double_string   :=ReadString('general','double_string','?');
  non_Star_string :=ReadString('general','non_star_string','?');
  artifact_string :=ReadString('general','artifact_string','?');


  earth_shadow_string :=ReadString('general','earth_shadow_string','?');
  tracking_string :=ReadString('general','tracking_string','?');
  sidereal_string :=ReadString('general','sidereal_view','?');
  terrestrial_string :=ReadString('general','terrestrial_view','?');
  refresh_rate_string:=ReadString('general','refresh_rate','?');
  to_go_right:=ReadString('general','to_go_right','?');;
  to_go_left:=ReadString('general','to_go_left','?');;
  to_go_up:=ReadString('general','to_go_up','?');;
  to_go_down:=ReadString('general','to_go_down','?');;

  limiting_magn:=ReadString('general','limiting_magn','?');
  days_plot_string:=ReadString('general','days_plot_string','?');
  searching_string:=ReadString('general','searching_string','?');
  arcsec_hour_string:=ReadString('general','arcsec_hour_string','?');
  tcp_conn_accept_string:=ReadString('general','tcp_conn_accept_string','?');
  tcp_conn_lost_string:=ReadString('general','tcp_conn_lost_string','?');
  tcp_online_string:=ReadString('general','tcp_online_string','?');
  tcp_offline_string:=ReadString('general','tcp_offline_string','?');
  end;
end;


procedure load_main;
var s :string;
begin
  with labelstring do
begin
   s:=ReadString('system', 'module_standard', '?');

   if s='?' then
   BEGIN
     language_mode:=0; {disable, otherwise everywhere ?}
     exit;
   end;
   if s<>'4121' then
      application.messagebox(pchar('Your language module is not up to date !!!'+#10+#13+#10+#13+'The language module is in a single *.INI file. Download and replace the language module *.INI manually.'),'update required !',MB_ICONWARNING+MB_OK);

  s:=ReadString('system', 'help_path', '?');
  {$ifdef mswindows}
  if s<>'?'  then  help_path:=StringReplace(s, '/', pathdelim,[rfReplaceAll]);
  {$ELSE} {unix}
  if s<>'?'  then  help_path:=StringReplace(s, '\', pathdelim,[rfReplaceAll]);{universal solution}
  {$endif}


  mainwindow.Filetoolbutton.caption:=(readstring('mainmenu','fileC','?'));
  mainwindow.Filetoolbutton.hint:=wrap(ReadString('mainmenu','fileh','?'));
  mainwindow.Savesettings1.caption:=(readstring('mainmenu','savesettingsC','?'));
  mainwindow.Savesettings1.hint:=wrap(ReadString('mainmenu','savesettingsh','?'));
  mainwindow.Saveas1.caption:=(readstring('mainmenu','saveasC','?'));
  mainwindow.Saveas1.hint:=wrap(ReadString('mainmenu','saveash','?'));
  mainwindow.Load1.caption:=(readstring('mainmenu','loadC','?'));
  mainwindow.Load1.hint:=wrap(ReadString('mainmenu','loadH','?'));
  mainwindow.loadevent1.caption:=(readstring('mainmenu','loadeventC','?'));
  mainwindow.loadevent1.hint:=wrap(ReadString('mainmenu','loadeventH','?'));

  mainwindow.load_fits1.caption:=(readstring('mainmenu','loadfitsC','?'));
  mainwindow.load_fits1.hint:=wrap(readstring('mainmenu','loadfitsH','?'));

  mainwindow.settings1.caption:=(readstring('mainmenu','settingsC','?'));
  mainwindow.settings1.hint:=wrap(ReadString('mainmenu','settingsH','?'));
  mainwindow.Asteroiddataeditor.caption:=(readstring('mainmenu','asteroideditorC','?'));
  mainwindow.Asteroiddataeditor.hint:=wrap(ReadString('mainmenu','asteroideditorh','?'));
  mainwindow.cometdataeditor.caption:=(readstring('mainmenu','cometeditorC','?'));
  mainwindow.cometdataeditor.hint:=wrap(ReadString('mainmenu','cometeditorh','?'));
  mainwindow.Supplement1editor.caption:=(readstring('mainmenu','supplement1editorC','?'));
  mainwindow.Supplement1editor.hint:=wrap(ReadString('mainmenu','supplement1editorH','?'));
  mainwindow.Supplement2editor.caption:=(readstring('mainmenu','supplement2editorC','?'));
  mainwindow.Supplement2editor.hint:=wrap(ReadString('mainmenu','supplement2editorH','?'));
  mainwindow.Supplement3editor.caption:=(readstring('mainmenu','supplement3editorC','?'));
  mainwindow.Supplement3editor.hint:=wrap(ReadString('mainmenu','supplement3editorH','?'));
  mainwindow.Supplement4editor.caption:=(readstring('mainmenu','supplement4editorC','?'));
  mainwindow.Supplement4editor.hint:=wrap(ReadString('mainmenu','supplement4editorH','?'));
  mainwindow.Supplement5editor.caption:=(readstring('mainmenu','supplement5editorC','?'));
  mainwindow.Supplement5editor.hint:=wrap(ReadString('mainmenu','supplement5editorH','?'));


  mainwindow.Copywindowtoclipboard1.caption:=(readstring('mainmenu','copywindowtoclipboardC','?'));
  mainwindow.Copywindowtoclipboard1.hint:=wrap(ReadString('mainmenu','copywindowtoclipboardh','?'));
  mainwindow.Printwindowwhitesky1.caption:=(readstring('mainmenu','printwindowwhiteskyC','?'));
  mainwindow.Printwindowwhitesky1.hint:=wrap(ReadString('mainmenu','printwindowwhiteskyh','?'));
  mainwindow.Printwindowblacksky1.caption:=(readstring('mainmenu','printwindowblackskyC','?'));
  mainwindow.Printwindowblacksky1.hint:=wrap(ReadString('mainmenu','printwindowblackskyh','?'));
  mainwindow.Deleteonlinecache1.caption:=(readstring('mainmenu','deletecacheC','?'));
  mainwindow.Deleteonlinecache1.hint:=wrap(ReadString('mainmenu','deletecacheH','?'));
  Delete_question_string:=(ReadString('mainmenu','deletecacheQ','?'));

  mainwindow.Exit1.caption:=(readstring('mainmenu','exitC','?'));
  mainwindow.Exit1.hint:=wrap(ReadString('mainmenu','exith','?'));
  mainwindow.Searchtoolbutton.caption:=(readstring('mainmenu','searchC','?'));
  mainwindow.Searchtoolbutton.hint:=wrap(ReadString('mainmenu','searchh','?'));
  mainwindow.INtoolbutton.caption:=(readstring('mainmenu','inC','?'));
  mainwindow.INtoolbutton.hint:=wrap(ReadString('mainmenu','inH','?'));
  mainwindow.OUTtoolbutton.caption:=(readstring('mainmenu','outC','?'));
  mainwindow.OUTtoolbutton.hint:=wrap(ReadString('mainmenu','outH','?'));
  mainwindow.Resettoolbutton.caption:=(readstring('mainmenu','resetC','?'));
  mainwindow.Resettoolbutton.hint:=wrap(ReadString('mainmenu','reseth','?'));
  mainwindow.Screentoolbutton.caption:=(readstring('mainmenu','screenC','?'));
  mainwindow.Screentoolbutton.hint:=wrap(ReadString('mainmenu','screenH','?'));
  mainwindow.GotoRADEC1.caption:=(readstring('mainmenu','gotoradecC','?'));
  mainwindow.GotoRADEC1.hint:=wrap(ReadString('mainmenu','gotoradecH','?'));
  mainwindow.Fliphorizontal1.caption:=(readstring('mainmenu','fliphorizontalC','?'));
  mainwindow.Fliphorizontal1.hint:=wrap(ReadString('mainmenu','fliphorizontalh','?'));
  mainwindow.Flipvertical1.caption:=(readstring('mainmenu','flipverticalC','?'));
  mainwindow.Flipvertical1.hint:=wrap(ReadString('mainmenu','flipverticalh','?'));
  mainwindow.Northabove1.caption:=(readstring('mainmenu','northaboveC','?'));
  mainwindow.Northabove1.hint:=wrap(ReadString('mainmenu','northaboveh','?'));
  mainwindow.sidereal1.caption:=(readstring('mainmenu','siderealC','?'));
  mainwindow.sidereal1.hint:=wrap(ReadString('mainmenu','siderealH','?'));


  mainwindow.animation1.caption:=(readstring('mainmenu','animationC','?'));
  mainwindow.animation1.hint:=wrap(ReadString('mainmenu','animationH','?'));
  mainwindow.GridRADEC1.caption:=(readstring('mainmenu','grid_checkC','?'));
  mainwindow.GridRADEC1.hint:=wrap(ReadString('mainmenu','grid_checkh','?'));
  mainwindow.GridAZAlt1.caption:=(readstring('mainmenu','altitudeC','?'));
  mainwindow.GridAZAlt1.hint:=wrap(ReadString('mainmenu','altitudeh','?'));
  mainwindow.Constellations1.caption:=(readstring('mainmenu','constellationsC','?'));
  mainwindow.Constellations1.hint:=wrap(ReadString('mainmenu','constellationsH','?'));
  mainwindow.Boundaries1.caption:=(readstring('mainmenu','boundariesC','?'));
  mainwindow.Boundaries1.hint:=wrap(ReadString('mainmenu','boundariesH','?'));
  mainwindow.Milkyway1.caption:=(readstring('mainmenu','milkywayC','?'));
  mainwindow.Milkyway1.hint:=wrap(ReadString('mainmenu','milkywayH','?'));
  mainwindow.Earth1.caption:=(readstring('mainmenu','earthC','?'));
  mainwindow.Earth1.hint:=wrap(ReadString('mainmenu','earthH','?'));
  mainwindow.Showmoonorbits1.caption:=(readstring('mainmenu','showmoonorbitsC','?'));
  mainwindow.Showmoonorbits1.hint:=wrap(ReadString('mainmenu','showmoonorbitsh','?'));
  mainwindow.Deepskycontoursonly1.caption:=(readstring('mainmenu','deepskycontoursonlyC','?'));
  mainwindow.Deepskycontoursonly1.hint:=wrap(ReadString('mainmenu','deepskycontoursonlyH','?'));
  mainwindow.InsertFITSimage1.caption:=(readstring('mainmenu','insertFITSimageC','?'));
  mainwindow.InsertFITSimage1.hint:=wrap(ReadString('mainmenu','insertFITSimageH','?'));
//  mainwindow.Nightvisionmode1.caption:=(readstring('mainmenu','nightvisionmodeC','?'));
//  mainwindow.Nightvisionmode1.hint:=wrap(ReadString('mainmenu','nightvisionmodeh','?'));
  mainwindow.Instruments1.caption:=(readstring('mainmenu','instrumentsC','?'));
  mainwindow.Instruments1.hint:=wrap(ReadString('mainmenu','instrumentsh','?'));
   mainwindow.Crosshair1.caption:=(readstring('mainmenu','crosshairC','?'));
  mainwindow.Crosshair1.hint:=wrap(ReadString('mainmenu','crosshairh','?'));
  mainwindow.Pointingcircles1.caption:=(readstring('mainmenu','pointingcirclesC','?'));
  mainwindow.Pointingcircles1.hint:=wrap(ReadString('mainmenu','pointingcirclesh','?'));
  mainwindow.Objecthints1.caption:=(readstring('mainmenu','objecthintsC','?'));
  mainwindow.Objecthints1.hint:=wrap(ReadString('mainmenu','objecthintsh','?'));
  mainwindow.Starscale1.caption:=(readstring('mainmenu','starscaleC','?'));
  mainwindow.Starscale1.hint:=wrap(ReadString('mainmenu','starscaleh','?'));
  mainwindow.Showstatusbar1.caption:=(readstring('mainmenu','showstatusbarC','?'));
  mainwindow.Showstatusbar1.hint:=wrap(ReadString('mainmenu','showstatusbarh','?'));
  mainwindow.Showclock1.caption:=(readstring('mainmenu','showclockC','?'));
  mainwindow.Showclock1.hint:=wrap(ReadString('mainmenu','showclockh','?'));
  mainwindow.Northarrow1.caption:=(readstring('mainmenu','northarrowC','?'));
  mainwindow.Northarrow1.hint:=wrap(ReadString('mainmenu','northarrowh','?'));
  mainwindow.Image_north1.hint:=mainwindow.Northarrow1.hint;

  mainwindow.Orthographic_projection1.caption:=(readstring('mainmenu','orthographic_projectionC','?'));
  mainwindow.Orthographic_projection1.hint:=wrap(ReadString('mainmenu','orthographic_projectionH','?'));

  mainwindow.Azimuthalequidistant1.caption:=(readstring('mainmenu','equidistant_projectionC','?'));
  mainwindow.Azimuthalequidistant1.hint:=wrap(ReadString('mainmenu','equidistant_projectionH','?'));
  mainwindow.cylindrical1.caption:=(readstring('mainmenu','cylindrical_projectionC','?'));
  mainwindow.cylindrical1.hint:=wrap(ReadString('mainmenu','cylindrical_projectionH','?'));

  mainwindow.Foundobjectmarker1.caption:=(readstring('mainmenu','foundobjectmarkerC','?'));
  mainwindow.Foundobjectmarker1.hint:=wrap(ReadString('mainmenu','foundobjectmarkerh','?'));
  mainwindow.Twolinesnorthsouth1.caption:=(readstring('mainmenu','twolinesnorthsouthC','?'));
  mainwindow.Twolinesnorthsouth1.hint:=wrap(ReadString('mainmenu','twolinesnorthsouthh','?'));
  mainwindow.Pointingcirclemarker1.caption:=(readstring('mainmenu','pointingcirclemarkerC','?'));
  mainwindow.Pointingcirclemarker1.hint:=wrap(ReadString('mainmenu','pointingcirclemarkerh','?'));
  mainwindow.Nameofobjectmarker1.caption:=(readstring('mainmenu','nameofobjectmarkerC','?'));
  mainwindow.Nameofobjectmarker1.hint:=wrap(ReadString('mainmenu','nameofobjectmarkerh','?'));

  mainwindow.Dateandtimemarker1.caption:=(readstring('mainmenu','dateandtimemarkerC','?'));
  mainwindow.Dateandtimemarker1.hint:=wrap(ReadString('mainmenu','dateandtimemarkerH','?'));

  mainwindow.magnitudeofobjectmarker1.caption:=(readstring('mainmenu','magnofobjectmarkerC','?'));
  mainwindow.magnitudeofobjectmarker1.hint:=wrap(ReadString('mainmenu','magnofobjectmarkerh','?'));

  mainwindow.Objectinfotoclipboard1.caption:=(readstring('mainmenu','objectinfotoclipboardC','?'));
  mainwindow.Objectinfotoclipboard1.hint:=wrap(ReadString('mainmenu','objectinfotoclipboardh','?'));

  mainwindow.undoview1.caption:=(readstring('mainmenu','undoviewC','?'));
  mainwindow.undoview1.hint:=wrap(ReadString('mainmenu','undoviewh','?'));
  mainwindow.redoview1.caption:=(readstring('mainmenu','redoviewC','?'));
  mainwindow.redoview1.hint:=wrap(ReadString('mainmenu','redoviewh','?'));

  mainwindow.Drawsolarobjecttracks1.caption:=(readstring('mainmenu','drawsolartracksC','?'));
  mainwindow.Drawsolarobjecttracks1.hint:=wrap(ReadString('mainmenu','drawsolartracksH','?'));

  mainwindow.Objectstoolbutton.caption:=(readstring('mainmenu','objectsC','?'));
  mainwindow.Objectstoolbutton.hint:=wrap(ReadString('mainmenu','objectsh','?'));
  mainwindow.Datetoolbutton.caption:=(readstring('mainmenu','dateC','?'));
  mainwindow.Datetoolbutton.hint:=wrap(ReadString('mainmenu','dateh','?'));
  mainwindow.Usesystemtime1.caption:=(readstring('mainmenu','usesystemtimeC','?'));
  mainwindow.Usesystemtime1.hint:=wrap(ReadString('mainmenu','usesystemtimeh','?'));
  mainwindow.Tonight1.caption:=(readstring('mainmenu','tonightC','?'));
  mainwindow.Tonight1.hint:=wrap(ReadString('mainmenu','tonighth','?'));
  mainwindow.NowF9.caption:=(readstring('mainmenu','nowC','?'));
  mainwindow.NowF9.hint:=wrap(ReadString('mainmenu','nowh','?'));
  mainwindow.Enterdatetime1.caption:=(readstring('mainmenu','enterdatetimeC','?'));
  mainwindow.Enterdatetime1.hint:=wrap(ReadString('mainmenu','enterdatetimeh','?'));
  mainwindow.MinF3.caption:=(readstring('mainmenu','min_backwardC','?'));
  mainwindow.MinF3.hint:=wrap(ReadString('mainmenu','min_backwardh','?'));
  mainwindow.MinF4.caption:=(readstring('mainmenu','min_forwardC','?'));
  mainwindow.MinF4.hint:=wrap(ReadString('mainmenu','min_forwardh','?'));
  mainwindow.HourF5.caption:=(readstring('mainmenu','hour_backwardC','?'));
  mainwindow.HourF5.hint:=wrap(ReadString('mainmenu','hour_backwardh','?'));
  mainwindow.HourF6.caption:=(readstring('mainmenu','hour_forwardC','?'));
  mainwindow.HourF6.hint:=wrap(ReadString('mainmenu','hour_forwardh','?'));
  mainwindow.DayF7.caption:=(readstring('mainmenu','day_backwardC','?'));
  mainwindow.DayF7.hint:=wrap(ReadString('mainmenu','day_backwardh','?'));
  mainwindow.DayF8.caption:=(readstring('mainmenu','day_forwardC','?'));
  mainwindow.DayF8.hint:=wrap(ReadString('mainmenu','day_forwardh','?'));
  mainwindow.N2356F11.caption:=(readstring('mainmenu','2356_backwardC','?'));
  mainwindow.N2356F11.hint:=wrap(ReadString('mainmenu','2356_backwardh','?'));
  mainwindow.N2356F12.caption:=(readstring('mainmenu','2356_forwardC','?'));
  mainwindow.N2356F12.hint:=wrap(ReadString('mainmenu','2356_forwardh','?'));
  mainwindow.Helptoolbutton.caption:=(readstring('mainmenu','help_menuC','?'));
  mainwindow.Helptoolbutton.hint:=wrap(ReadString('mainmenu','help_menuH','?'));
  mainwindow.Help1.caption:=(readstring('mainmenu','helpC','?'));
  mainwindow.Help1.hint:=wrap(ReadString('mainmenu','helpH','?'));
  mainwindow.deepskyobservations1.caption:=(readstring('mainmenu','deephelpC','?'));
  mainwindow.deepskyobservations1.hint:=wrap(ReadString('mainmenu','deephelph','?'));
  mainwindow.Darknights1.caption:=(readstring('mainmenu','darknightsC','?'));
  mainwindow.Darknights1.hint:=wrap(ReadString('mainmenu','darknightsH','?'));
  mainwindow.Solarsystemtonight1.caption:=(readstring('mainmenu','solarsystemtonightC','?'));
  mainwindow.Solarsystemtonight1.hint:=wrap(ReadString('mainmenu','solarsystemtonightH','?'));

  polarview:=(ReadString('mainmenu','PolarscopeviewC','?'));;{is also used in popup window created  later}
  mainwindow.Polarscopeview1.caption:=polarview;

  mainwindow.Polarscopeview1.hint:=wrap(ReadString('mainmenu','PolarscopeviewH','?'));
  mainwindow.Databases1.caption:=(readstring('mainmenu','databasesC','?'));
  mainwindow.Databases1.hint:=wrap(ReadString('mainmenu','databasesh','?'));
  mainwindow.About1.caption:=(readstring('mainmenu','aboutC','?'));
  mainwindow.About1.hint:=wrap(ReadString('mainmenu','abouth','?'));

  mainwindow.toolbutton_menu.hint:=wrap(ReadString('mainmenu','toolbutton_menuH','?'));


 {short cuts}
  mainwindow.Savesettings1.shortcut:=TextToShortCut(ReadString('shortcuts','savesettingsS','?'));
  mainwindow.Load1.shortcut:=TextToShortCut(ReadString('shortcuts','loadS','?'));
  mainwindow.loadevent1.shortcut:=TextToShortCut(ReadString('shortcuts','loadeventS','?'));

  mainwindow.load_fits1.shortcut:=TextToShortCut(ReadString('shortcuts','loadfitsS','?'));

  mainwindow.settings1.shortcut:=TextToShortCut(ReadString('shortcuts','settingsS','?'));
  mainwindow.Asteroiddataeditor.shortcut:=TextToShortCut(ReadString('shortcuts','asteroideditorS','?'));
  mainwindow.cometdataeditor.shortcut:=TextToShortCut(ReadString('shortcuts','cometeditorS','?'));
  mainwindow.Supplement1editor.shortcut:=TextToShortCut(ReadString('shortcuts','supplement1editorS','?'));
  mainwindow.Supplement2editor.shortcut:=TextToShortCut(ReadString('shortcuts','supplement2editorS','?'));
  mainwindow.Supplement3editor.shortcut:=TextToShortCut(ReadString('shortcuts','supplement3editorS','?'));
  mainwindow.Supplement4editor.shortcut:=TextToShortCut(ReadString('shortcuts','supplement4editorS','?'));
  mainwindow.Supplement5editor.shortcut:=TextToShortCut(ReadString('shortcuts','supplement5editorS','?'));
  mainwindow.undoview1.shortcut:=TextToShortCut(ReadString('shortcuts','undoviewS','?'));
  mainwindow.redoview1.shortcut:=TextToShortCut(ReadString('shortcuts','redoviewS','?'));
  mainwindow.Exit1.shortcut:=TextToShortCut(ReadString('shortcuts','exitS','?'));
  mainwindow.Search1.shortcut:=TextToShortCut(ReadString('shortcuts','searchS','?'));
  mainwindow.IN1.shortcut:=TextToShortCut(ReadString('shortcuts','inS','?'));
  mainwindow.OUT1.shortcut:=TextToShortCut(ReadString('shortcuts','outS','?'));
  mainwindow.Reset1.shortcut:=TextToShortCut(ReadString('shortcuts','resetS','?'));
  mainwindow.GotoRADEC1.shortcut:=TextToShortCut(ReadString('shortcuts','gotoRADECS','?'));
  mainwindow.Fliphorizontal1.shortcut:=TextToShortCut(ReadString('shortcuts','fliphorizontalS','?'));
  mainwindow.Flipvertical1.shortcut:=TextToShortCut(ReadString('shortcuts','flipverticalS','?'));
  mainwindow.Northabove1.shortcut:=TextToShortCut(ReadString('shortcuts','northaboveS','?'));
  mainwindow.GridRADEC1.shortcut:=TextToShortCut(ReadString('shortcuts','grid_checkS','?'));
  mainwindow.GridAZAlt1.shortcut:=TextToShortCut(ReadString('shortcuts','altitudeS','?'));
  mainwindow.Constellations1.shortcut:=TextToShortCut(ReadString('shortcuts','constellationsS','?'));
  mainwindow.Boundaries1.shortcut:=TextToShortCut(ReadString('shortcuts','boundariesS','?'));
  mainwindow.Deepskycontoursonly1.shortcut:=TextToShortCut(ReadString('shortcuts','deepskycontoursonlyS','?'));
  mainwindow.InsertFITSimage1.shortcut:=TextToShortCut(ReadString('shortcuts','insertFITSimageS','?'));
//  mainwindow.Nightvisionmode1.shortcut:=TextToShortCut(ReadString('shortcuts','nightvisionmodeS','?'));
  mainwindow.Crosshair1.shortcut:=TextToShortCut(ReadString('shortcuts','crosshairS','?'));
  mainwindow.Pointingcircles1.shortcut:=TextToShortCut(ReadString('shortcuts','pointingcirclesS','?'));
  mainwindow.Drawsolarobjecttracks1.shortcut:=TextToShortCut(ReadString('shortcuts','drawsolartracksS','?'));
  mainwindow.add_label1.shortcut:=TextToShortCut(ReadString('shortcuts','add_labelS','?'));{existing shortcuts}

  mainwindow.Measuringframe1.shortcut:=TextToShortCut(ReadString('shortcuts','measuringframeS','?'));
  mainwindow.Pointingcirclemarker1.shortcut:=TextToShortCut(ReadString('shortcuts','pointingcirclemarkerS','?'));
  mainwindow.Nameofobjectmarker1.shortcut:=TextToShortCut(ReadString('shortcuts','nameofobjectmarkerS','?'));
  mainwindow.Magnitudeofobjectmarker1.shortcut:=TextToShortCut(ReadString('shortcuts','magnofobjectmarkerS','?'));

  mainwindow.connect_telescope1.shortcut:=TextToShortCut(ReadString('shortcuts','telescope_connectS','?'));
  mainwindow.Printwindowwhitesky1.shortcut:=TextToShortCut(ReadString('shortcuts','printwindowwhiteskyS','?'));

  mainwindow.sidereal1.shortcut:=TextToShortCut(ReadString('shortcuts','siderealS','?'));

  mainwindow.Objects1.shortcut:=TextToShortCut(ReadString('shortcuts','objectsS','?'));
  mainwindow.Usesystemtime1.shortcut:=TextToShortCut(ReadString('shortcuts','usesystemtimeS','?'));
  mainwindow.Tonight1.shortcut:=TextToShortCut(ReadString('shortcuts','tonightS','?'));
  mainwindow.NowF9.shortcut:=TextToShortCut(ReadString('shortcuts','nowS','?'));
  mainwindow.Enterdatetime1.shortcut:=TextToShortCut(ReadString('shortcuts','enterdatetimeS','?'));
  mainwindow.MinF3.shortcut:=TextToShortCut(ReadString('shortcuts','min_backwardS','?'));
  mainwindow.MinF4.shortcut:=TextToShortCut(ReadString('shortcuts','min_forwardS','?'));
  mainwindow.HourF5.shortcut:=TextToShortCut(ReadString('shortcuts','hour_backwardS','?'));
  mainwindow.HourF6.shortcut:=TextToShortCut(ReadString('shortcuts','hour_forwardS','?'));
  mainwindow.DayF7.shortcut:=TextToShortCut(ReadString('shortcuts','day_backwardS','?'));
  mainwindow.DayF8.shortcut:=TextToShortCut(ReadString('shortcuts','day_forwardS','?'));
  mainwindow.N2356F11.shortcut:=TextToShortCut(ReadString('shortcuts','2356_backwardS','?'));
  mainwindow.N2356F12.shortcut:=TextToShortCut(ReadString('shortcuts','2356_forwardS','?'));
  mainwindow.deepskyobservations1.shortcut:=TextToShortCut(ReadString('shortcuts','deephelpS','?'));
  mainwindow.Darknights1.shortcut:=TextToShortCut(ReadString('shortcuts','darknightsS','?'));
  mainwindow.Solarsystemtonight1.shortcut:=TextToShortCut(ReadString('shortcuts','solarsystemtonightS','?'));
  mainwindow.zenith1.shortcut:=TextToShortCut(ReadString('shortcuts','zenithS','?'));
  mainwindow.north1.shortcut:=TextToShortCut(ReadString('shortcuts','northS','?'));
  mainwindow.south1.shortcut:=TextToShortCut(ReadString('shortcuts','southS','?'));
  mainwindow.east1.shortcut:=TextToShortCut(ReadString('shortcuts','eastS','?'));
  mainwindow.west1.shortcut:=TextToShortCut(ReadString('shortcuts','westS','?'));

  end;
end;

Procedure load_popup_mainmenu;
begin
  with labelstring do
  begin
    Mainwindow.menu_color.caption:=(readstring('popup_mainmenu','menu_colorC','?'));
    Mainwindow.menu_color.hint:=wrap(ReadString('popup_mainmenu','menu_colorH','?'));

    Mainwindow.hide_text.caption:=(readstring('popup_mainmenu','hide_textC','?'));
    Mainwindow.hide_text.hint:=wrap(ReadString('popup_mainmenu','hide_textH','?'));

    Mainwindow.hide_icons.caption:=(readstring('popup_mainmenu','hide_iconsC','?'));
    Mainwindow.hide_icons.hint:=wrap(ReadString('popup_mainmenu','hide_iconsH','?'));

    Mainwindow.hide_menu.caption:=(readstring('popup_mainmenu','Hide_menuC','?'));
    Mainwindow.hide_menu.hint:=wrap(ReadString('popup_mainmenu','hide_menuH','?'));
  end;
end;


Procedure load_popup;
begin
  with labelstring do
  begin
    Mainwindow.GetDSSimagefrominternet1.caption:=(readstring('popup','get_DSS_imageC','?'));
    Mainwindow.GetDSSimagefrominternet1.hint:=wrap(ReadString('popup','get_DSS_imageH','?'));

    Mainwindow.Get_Skyview1.hint:=wrap(ReadString('popup','get_dss_skyH','?'));
    Mainwindow.Get_eso1.hint:=wrap(ReadString('popup','get_dss_esoH','?'));
    Mainwindow.Get_mast1.hint:=wrap(ReadString('popup','get_dss_mastH','?'));


    Mainwindow.Centreon1.caption:=(readstring('popup','centreonC','?'));
    Mainwindow.Centreon1.hint:=wrap(ReadString('popup','centreonH','?'));

    Mainwindow.Searchbyposition1.caption:=(readstring('popup','online_queryC','?'));
    Mainwindow.Searchbyposition1.hint:=wrap(ReadString('popup','online_queryH','?'));
    Mainwindow.simbad1.hint:=wrap(ReadString('popup','simbad_queryH','?'));
    Mainwindow.hyperleda1.hint:=wrap(ReadString('popup','hyperleda_queryH','?'));
    Mainwindow.ned1.hint:=wrap(ReadString('popup','ned_queryH','?'));
    Mainwindow.internal1.hint:=wrap(ReadString('popup','internal_queryH','?'));

    mainwindow.bandpassmenu1.caption:=(readstring('popup','bandpassC','?'));
    mainwindow.dss2_red1.caption:=(readstring('popup','dss2rC','?'));
    mainwindow.dss2_blue1.caption:=(readstring('popup','dss2bC','?'));
    mainwindow.dss2_infrared1.caption:=(readstring('popup','dss2iC','?'));
    mainwindow.dss_red1.caption:=(readstring('popup','dss1rC','?'));
    mainwindow.dss_blue1.caption:=(readstring('popup','dss1bC','?'));

    Mainwindow.Cleardownload1.caption:=(readstring('popup','clear_downloadC','?'));
    Mainwindow.Cleardownload1.hint:=wrap(ReadString('popup','clear_downloadH','?'));

    Mainwindow.clearvisibledownload1.caption:=(readstring('popup','clear_download_visibleC','?'));
    Mainwindow.clearvisibledownload1.hint:=wrap(ReadString('popup','clear_download_visibleH','?'));



    delete_question_string_dss:=(ReadString('popup','delete_allQ','?'));


    Mainwindow.clearvisibledownload1.caption:=(readstring('popup','clear_visible_downloadC','?'));
    Mainwindow.clearvisibledownload1.hint:=wrap(ReadString('popup','clear_visible_downloadH','?'));

    mainwindow.Measuringframe1.caption:=(readstring('popup','measuring_frameC','?')); {existing main menu}
    mainwindow.Measuringframe1.hint:=wrap(ReadString('popup','measuring_frameH','?'));    {existing mainmenu}

    Mainwindow.Markerslines1.caption:=(readstring('popup','marker_linesC','?'));
    Mainwindow.Markerslines1.hint:=wrap(ReadString('popup','marker_linesH','?'));

    Mainwindow.Linestart1.caption:=(readstring('popup','line_draw_radecC','?'));
    Mainwindow.Linestart1.hint:=wrap(ReadString('popup','line_draw_radecH','?'));

    Mainwindow.LinestartAZALT1.caption:=(readstring('popup','line_draw_azaltC','?'));
    Mainwindow.LinestartAZALT1.hint:=wrap(ReadString('popup','line_draw_azaltH','?'));

    Mainwindow.movelines1.caption:=(readstring('popup','move_linesC','?'));
    Mainwindow.movelines1.hint:=wrap(ReadString('popup','move_linesH','?'));

    Mainwindow.insertlines1.caption:=(readstring('popup','insert_linesC','?'));
    Mainwindow.insertlines1.hint:=wrap(ReadString('popup','insert_linesH','?'));

    Mainwindow.removelines1.caption:=(readstring('popup','remove_linesC','?'));
    Mainwindow.removelines1.hint:=wrap(ReadString('popup','remove_linesH','?'));

    Mainwindow.colorchange1.caption:=(readstring('popup','color_change_linesC','?'));
    Mainwindow.colorchange1.hint:=wrap(ReadString('popup','color_change_linesH','?'));

    Mainwindow.hidelines1.caption:=(readstring('popup','hide_linesC','?'));
    Mainwindow.hidelines1.hint:=wrap(ReadString('popup','hide_linesH','?'));

    Mainwindow.Deletelastpoint1.caption:=(readstring('popup','delete_last_line_pointC','?'));
    Mainwindow.deletelastpoint1.hint:=wrap(ReadString('popup','delete_last_line_pointH','?'));


    mainwindow.add_label1.caption:=(readstring('popup','add_labelC','?'));{2018 Add label or rectangle}
    mainwindow.add_label1.hint:=wrap(ReadString('popup','add_labelH','?'));   {2018 Add label to supplement 2. If measuring frame is on then add rectangle to supplement 2.}

    mainwindow.editobject1.caption:=(readstring('popup','edit_objectC','?'));
    mainwindow.editobject1.hint:=wrap(ReadString('popup','edit_objectH','?'));


    Mainwindow.Clearmarkers2.caption:=(readstring('popup','clear_markersC','?'));
    Mainwindow.Clearmarkers2.hint:=wrap(ReadString('popup','clear_markersH','?'));
    Mainwindow.Clearmarkers1.caption:=Mainwindow.Clearmarkers2.caption;{main menu}
    Mainwindow.Clearmarkers1.hint:=Mainwindow.Clearmarkers2.hint;

    Mainwindow.exportviaserver1.caption:=(readstring('popup','export_via_serverC','?'));
    Mainwindow.exportviaserver1.hint:=wrap(ReadString('popup','export_via_serverH','?'));

    Mainwindow.mouseposition1.caption:=(readstring('popup','mouse_positionC','?'));
    Mainwindow.mouseposition1.hint:=wrap(ReadString('popup','mouse_positionrH','?'));

    Mainwindow.export_frames_via_server1.caption:=(readstring('popup','all_framesC','?'));
    Mainwindow.export_frames_via_server1.hint:=wrap(ReadString('popup','all_framesH','?'));


    mainwindow.telescope1.caption:=(readstring('popup','telescopeC','?'));
    mainwindow.telescope1.hint:=wrap(ReadString('popup','telescopeH','?'));
    telescopeTekst:=ReadString('popup','telescopeC','?');

    Mainwindow.Telescopetomouseposition1.caption:=(readstring('popup','telescope_to_mouse_positionC','?'));
    Mainwindow.Telescopetomouseposition1.hint:=wrap(ReadString('popup','telescope_to_mouse_positionH','?'));
    mainwindow.telescope_synctomouse1.caption:=(readstring('popup','telescope_synctomouseC','?'));
    mainwindow.telescope_synctomouse1.hint:=wrap(ReadString('popup','telescope_synctomouseh','?'));
    mainwindow.telescope_abort1.caption:=(readstring('popup','telescope_abortC','?'));
    mainwindow.telescope_abort1.hint:=wrap(ReadString('popup','telescope_abortH','?'));



    mainwindow.Followsolarobject1.caption:=(readstring('popup','follow_solar_objectC','?'));
    follow_string:=ReadString('popup','follow_solar_object2C','?');
    mainwindow.Followsolarobject1.hint:=wrap(ReadString('popup','follow_solar_objectH','?'));

    mainwindow.tracktelescope1.caption:=(readstring('popup','track_telescopeC','?'));
    mainwindow.tracktelescope1.hint:=wrap(ReadString('popup','track_telescopeH','?'));

    mainwindow.indi_client1.caption:=(readstring('popup','indi_clientC','?'));
    mainwindow.indi_client1.hint:=wrap(ReadString('popup','indi_clientH','?'));

    mainwindow.connect_telescope1.caption:=(readstring('popup','telescope_connectC','?'));
    mainwindow.connect_telescope1.hint:=wrap(ReadString('popup','telescope_connectH','?'));

    mainwindow.park_unpark1.caption:=(readstring('popup','telescope_park_unparkC','?'));
    mainwindow.park_unpark1.hint:=wrap(ReadString('popup','telescope_park_unparkH','?'));
    mainwindow.park1.caption:=(readstring('popup','telescope_parkC','?'));
    mainwindow.park1.hint:=wrap(ReadString('popup','telescope_parkH','?'));
    mainwindow.home1.caption:=(readstring('popup','telescope_moveC','?'));
    mainwindow.home1.hint:=wrap(ReadString('popup','telescope_moveH','?'));
    mainwindow.tracking1.caption:=(readstring('popup','telescope_trackingC','?'));
    mainwindow.tracking1.hint:=wrap(ReadString('popup','telescope_trackingH','?'));
    mainwindow.setpark1.caption:=(readstring('popup','telescope_set_parkC','?'));
    mainwindow.setpark1.hint:=wrap(ReadString('popup','telescope_set_parkH','?'));
  end;
end;


procedure load_center;

begin
  with labelstring do
  begin
  center_on.caption:=(readstring('search','center_onC','?'));
  center_on.hint:=wrap(ReadString('search','center_onH','?'));
  center_on.go_to1.caption:=(readstring('search','go_toC','?'));
  center_on.go_to1.hint:=wrap(ReadString('search','go_toH','?'));
  center_on.help_searchmenu.hint:=wrap(ReadString('search','helpH','?'));
  center_on.constellations1.caption:=(readstring('search','constellationsC','?'));
  center_on.constellations1.hint:=wrap(ReadString('search','constellationsH','?'));
  center_on.abb1.caption:=(readstring('search','abbC','?'));
  center_on.abb1.hint:=wrap(ReadString('search','abbH','?'));
  center_on.brightstars1.caption:=(readstring('search','brightstarsC','?'));
  center_on.brightstars1.hint:=wrap(ReadString('search','brightstarsH','?'));
  center_on.comets1.caption:=(readstring('search','cometsC','?'));
  center_on.comets1.hint:=wrap(ReadString('search','cometsH','?'));
  center_on.planets1.caption:=(readstring('search','planetsC','?'));
  center_on.planets1.hint:=wrap(ReadString('search','planetsH','?'));
  center_on.center1.caption:=(readstring('search','centerC','?'));
  center_on.center1.hint:=wrap(ReadString('search','centerH','?'));
  center_on.slewto1.caption:=(readstring('search','slew_toC','?'));
  center_on.slewto1.hint:=wrap(ReadString('search','slew_toH','?'));
  center_on.edit1.hint:=wrap(ReadString('search','comboBox1H','?'));
  center_on.Cancel1.caption:=(readstring('search','cancelC','?'));
  center_on.Cancel1.hint:=wrap(ReadString('search','cancelH','?'));
  center_on.asteroids1.caption:=(readstring('search','asteroidsC','?'));
  center_on.asteroids1.hint:=wrap(ReadString('search','asteroidsH','?'));
  center_on.autozoom1.hint:=wrap(ReadString('search','autozoomH','?'));
  center_on.autozoom1.caption:=(readstring('search','autozoomC','?'));
  center_on.Supp1.caption:=(readstring('search','supp1C','?'));
  center_on.deepsky1.hint:=wrap(ReadString('search','deepskyH','?'));
  center_on.deepsky2.hint:=center_on.deepsky1.hint;
  center_on.deepsky3.hint:=center_on.deepsky1.hint;

  center_on.search_simbad1.hint:=wrap(ReadString('search','simbadH','?'));

  deepsky_string:=ReadString('search','deepsky','?');
  deep1:=ReadString('search','deep-1','?');
  deep2:=ReadString('search','deep-2','?');
  deep3:=ReadString('search','deep-3','?');
  end;
end;


procedure load_object;

begin
  with labelstring do
  begin
  objectmenu.caption:=(readstring('objects','object_title','?'));
  objectmenu.ok_button1.caption:=(readstring('objects','ok_buttonC','?'));
  objectmenu.ok_button1.hint:=wrap(ReadString('objects','ok_buttonH','?'));
  objectmenu.help_objectmenu.hint:=wrap(ReadString('objects','helpH','?'));

  objectmenu.StarGroupBox1.caption:=(readstring('objects','starGroupBox1C','?'));
  objectmenu.densitylabel.caption:=(readstring('objects','densitylabelC','?'));
  objectmenu.densitylabel.hint:=wrap(ReadString('objects','densitylabelH','?'));
  objectmenu.boldnesslabel.caption:=(readstring('objects','boldnesslabelC','?'));
  objectmenu.boldnesslabel.hint:=wrap(ReadString('objects','boldnesslabelH','?'));

  objectmenu.star_coloring1.caption:=(readstring('objects','star_coloringC','?'));
  objectmenu.star_coloring1.hint:=wrap(ReadString('objects','star_coloringH','?'));
  objectmenu.nameallstars1.caption:=(readstring('objects','nameallstarsC','?'));
  objectmenu.nameallstars1.hint:=wrap(ReadString('objects','nameallstarsH','?'));
  objectmenu.starsonoff1.caption:=(readstring('objects','stars_checkC','?'));
  objectmenu.starsonoff1.hint:=wrap(ReadString('objects','stars_checkH','?'));
  objectmenu.maxmagn1.hint:=wrap(ReadString('objects','maxmagnH','?'));

  objectmenu.check_external1.hint:=(readstring('objects','external_checkH','?'));

  objectmenu.stars_external1.items[0]:=ReadString('objects','UCACC','?');
  stars_external_hint[1]:=ReadString('objects','UCACH','?');

  objectmenu.stars_external1.items[1]:=ReadString('objects','UCAConlineC','?');
  stars_external_hint[2]:=ReadString('objects','UCAConlineH','?');

  objectmenu.stars_external1.items[2]:=ReadString('objects','NOMADonlineC','?');
  stars_external_hint[3]:=ReadString('objects','NOMADonlineH','?');

  objectmenu.stars_external1.items[3]:=ReadString('objects','URATonlineC','?');
  stars_external_hint[4]:=ReadString('objects','URATonlineH','?');

  objectmenu.stars_external1.items[4]:=ReadString('objects','GAIAonlineC','?');
  stars_external_hint[5]:=ReadString('objects','GAIAonlineH','?');

  objectmenu.stars_external1.items[5]:=ReadString('objects','PPMXLonlineC','?');
  stars_external_hint[6]:=ReadString('objects','PPMXLonlineH','?');




//  UCAConlineC=UCAC4 (online)
//  UCAConlineH=UCAC4 online catalogue from http://vizier.u-strasbg.fr/doc/asu-summary.htx
//  NOMADonlineC=NOMAD (online)
//  NOMADonlineH=NOMAD online catalogue from http://vizier.u-strasbg.fr/doc/asu-summary.htx
//  URATonlineC=URAT (online)
//  URATonlineH=URAT online catalogue from http://vizier.u-strasbg.fr/doc/asu-summary.htx
//  GaiaonlineC=Gaia (online)
//  GaiaonlineC=Gaia online catalogue from http://vizier.u-strasbg.fr/doc/asu-summary.htx
//  PPMXLonlineC=PPMXL (online)
//  PPMXLolineC=PPMXL online catalogue from http://vizier.u-strasbg.fr/doc/asu-summary.htx


  objectmenu.TabSheet1.caption:=(readstring('objects','deepskygroupboxC','?'));
  objectmenu.Label_maxm.caption:=(readstring('objects','label_maxmC','?'));
  objectmenu.Label_maxm.hint:=wrap(ReadString('objects','label_maxmH','?'));
  objectmenu.Label_namet.caption:=(readstring('objects','label_nametC','?'));
  objectmenu.Label_namet.hint:=wrap(ReadString('objects','label_nametH','?'));
//  objectmenu.label_none.caption:=(readstring('objects','label_noneC','?'));
//  objectmenu.Label_all.caption:=(readstring('objects','label_allC','?'));
  objectmenu.Label_mins.caption:=(readstring('objects','label_minsC','?'));
  objectmenu.Label_type.caption:=(readstring('objects','label_typeC','?'));
  objectmenu.fitsonoff1.caption:=(readstring('objects','label_imagesC','?'));

  objectmenu.deepmagTrackBar1.hint:=wrap(ReadString('objects','deepmagtrackbarH','?'));
  objectmenu.nametilltrackBar1.hint:=wrap(ReadString('objects','nametilltrackbarH','?'));
  objectmenu.label_level1.caption:=(ReadString('objects','levelC','?'));
  objectmenu.deepskyleveltrackbar1.hint:=wrap(ReadString('objects','deepskyleveltrackbarH','?'));

  objectmenu.deepsky_check1.hint:=wrap(ReadString('objects','deepH','?'));
  objectmenu.suppl1.hint:=wrap(ReadString('objects','suppl_checkH','?'));
  objectmenu.suppl2.hint:=objectmenu.suppl1.hint;
  objectmenu.suppl3.hint:=objectmenu.suppl1.hint;
  objectmenu.suppl4.hint:=objectmenu.suppl1.hint;
  objectmenu.suppl5.hint:=objectmenu.suppl1.hint;

  objectmenu.asteroidsonoff1.caption:=(readstring('objects','asteroids_checkC','?'));
  objectmenu.asteroidsonoff1.hint:=wrap(ReadString('objects','asteroids_checkH','?'));
  objectmenu.cometsonoff1.caption:=(readstring('objects','comets_checkC','?'));
  objectmenu.cometsonoff1.hint:=wrap(ReadString('objects','comets_checkH','?'));
  objectmenu.Planetsonoff1.caption:=(readstring('objects','planets_checkC','?'));
  objectmenu.Planetsonoff1.hint:=wrap(ReadString('objects','planets_checkH','?'));
  objectmenu.fitsonoff1.Hint:=mainwindow.InsertFITSimage1.hint; {loaded earlier}

  objectmenu.min_size1.hint:=wrap(ReadString('objects','min_sizeH','?'));
  objectmenu.Filter1.hint:=wrap(ReadString('objects','filterH','?'));
  objectmenu.fitsbright1.hint:=wrap(ReadString('objects','fitsbrightH','?'));
  objectmenu.fitsback1.hint:=wrap(ReadString('objects','fitsbackH','?'));
  objectmenu.toast_combobox1.hint:=wrap(ReadString('objects','toastH','?'));
  objectmenu.toast_check1.hint:=wrap(ReadString('objects','toast_checkH','?'));
  objectmenu.neo_only1.caption:=(readstring('objects','neoC','?'));
  objectmenu.neo_only1.hint:=wrap(ReadString('objects','neoH','?'));
  end;
end;

procedure load_time;
begin
  with labelstring do
  begin
    settime.caption:=(readstring('time','set_time_title','?'));

    settime.OK_button1.caption:=(readstring('time','ok_buttonC','?'));
    settime.OK_button1.hint:=wrap(ReadString('time','ok_buttonH','?'));
    settime.help_timemenu1.hint:=wrap(ReadString('time','helpH','?'));

    settime.OK_button2.caption:=settime.OK_button1.caption;
    settime.OK_button2.hint:= settime.OK_button1.hint;

    settime.yearedit1.hint:=wrap(ReadString('time','yeareditH','?'));
    settime.monthedit1.hint:=wrap(ReadString('time','montheditH','?'));
    settime.dayedit1.hint:=wrap(ReadString('time','dayeditH','?'));

    settime.DateTimePicker1.hint:=wrap(ReadString('time','date_editH','?'));
    settime.DateTimePicker2.hint:=wrap(ReadString('time','time_editH','?'));
    settime.date_label1.caption:=(readstring('time','date_labelC','?'));
    settime.time_label1.caption:=(readstring('time','time_labelC','?'));

    settime.jd_edit1.hint:=wrap(ReadString('time','jdeditH','?'));
    settime.ut_label1.hint:=wrap(ReadString('time','ut_labelH','?'));
    deltaT_correction:=ReadString('settings','delta_t_correctionC','?');{under group settings}
    settime.deltaT_correction2.hint:=wrap(ReadString('settings','delta_t_correctionH','?'));{under group settings}
    settime.live_update1.hint:=wrap(ReadString('time','live_updateH','?'));
  end;
  Settime.now_toolButton1.hint:=mainwindow.NowF9.hint;
  Settime.followtime_toolButton1.hint:=mainwindow.Usesystemtime1.hint;
  Settime.midnight_ToolButton1.hint:=mainwindow.Tonight1.hint;
  settime.siderealtoolbutton2.hint:=mainwindow.sidereal1.hint;
end;

procedure load_goto;
begin
  with labelstring do
  begin
  move_to.caption:=(readstring('move','go_to_title','?'));
  move_to.Bevel1.hint:=wrap(ReadString('move','bevel1H','?'));
  move_to.right_ascension_symbol1.caption:=(readstring('move','right_ascensionC','?'));
  move_to.rightascension1.hint:=wrap(ReadString('move','right_ascensionH','?'));
  move_to.declination_symbol1.caption:=(readstring('move','declinationC','?'));
  move_to.declination1.hint:=wrap(ReadString('move','declinationH','?'));
  move_to.Equinoxasset.caption:=(readstring('move','equinoxassetC','?'));
  move_to.Ok_button1.caption:=(readstring('move','ok_buttonC','?'));
  move_to.Ok_button1.hint:=wrap(ReadString('move','ok_buttonH','?'));
  move_to.help_movemenu.hint:=wrap(ReadString('move','helpH','?'));

  move_to.Cancel_button1.caption:=(readstring('move','cancel_buttonC','?'));
  move_to.Cancel_button1.hint:=wrap(ReadString('move','cancel_buttonH','?'));
  move_to.Westbutton1.caption:=(readstring('move','westbuttonC','?'));
  move_to.Westbutton1.hint:=wrap(ReadString('move','westbuttonH','?'));
  move_to.Zenithbutton1.caption:=(readstring('move','zenithbuttonC','?'));
  move_to.Zenithbutton1.hint:=wrap(ReadString('move','zenithbuttonH','?'));
  move_to.Eastbutton1.caption:=(readstring('move','eastbuttonC','?'));
  move_to.Eastbutton1.hint:=wrap(ReadString('move','eastbuttonH','?'));
  move_to.Southbutton1.caption:=(readstring('move','southbuttonC','?'));
  move_to.Southbutton1.hint:=wrap(ReadString('move','southbuttonH','?'));
  move_to.Northbutton1.caption:=(readstring('move','northbuttonC','?'));
  move_to.Northbutton1.hint:=wrap(ReadString('move','northbuttonH','?'));
  move_to.zoomnew1.hint:=wrap(ReadString('move','zoomnewH','?'));
  move_to.View_height.caption:=(readstring('move','view_heightC','?'));
  move_to.position_line1.hint:=wrap(ReadString('move','position_lineH','?'));
  end;
end;

procedure load_sett;
var  help_label,help_color,s :string;
begin
  with labelstring do
  begin
  settings.help_settings.hint:=wrap(ReadString('settings','helpH','?'));

  settings.caption:=(readstring('settings','settings_title','?'));
  settings.Settings_tab.caption:=(readstring('settings','settings_tabC','?'));
  settings.grp_longitude.caption:=(readstring('settings','grp_longitudeC','?'));
  settings.grp_longitude.hint:=wrap(ReadString('settings','grp_longitudeH','?'));
  settings.west2.caption:=(readstring('settings','westC','?'));
  settings.east2.caption:=(readstring('settings','eastC','?'));
  settings.grp_latitude.caption:=(readstring('settings','grp_latitudeC','?'));
  settings.grp_latitude.hint:=wrap(ReadString('settings','grp_latitudeH','?'));
  settings.North2.caption:=(readstring('settings','northC','?'));
  settings.south2.caption:=(readstring('settings','southC','?'));
  settings.grp_location.caption:=(readstring('settings','grp_locationC','?'));{223}
  settings.parallax.caption:=(readstring('settings','parallaxC','?'));
  settings.parallax.hint:=wrap(ReadString('settings','parallaxH','?'));
  settings.refraction.caption:=(readstring('settings','refractionC','?'));
  settings.refraction.hint:=wrap(ReadString('settings','refractionH','?'));
  settings.timezone_shape.hint:=wrap(ReadString('settings','time_zone_lineH','?'));
  settings.grp_timezone.caption:=(readstring('settings','grp_timezoneC','?'));
  settings.time_zone1.hint:=wrap(ReadString('settings','time_zoneH','?'));
  settings.dayl_saving1.caption:=(readstring('settings','dayl_savingC','?'));
  settings.dayl_saving1.hint:=wrap(ReadString('settings','dayl_savingH','?'));
  deltaT_correction:=ReadString('settings','delta_t_correctionC','?');{under group settings}
  settings.deltaT_correction1.hint:=wrap(ReadString('settings','delta_t_correctionH','?'));{under group settings}

  s:=ReadString('settings','mean_equinox_of_dateC','?');
  settings.equinox_map.items[1]:=s;
  settings.equinox_telescope2.items[1]:=s;
  settings.equinox_map.items[2]:=ReadString('settings','apparent_coordinatesC','?');
  settings.equinox_map.items[3]:=ReadString('settings','galacticC','?');

  settings.grp_screen.caption:=(readstring('settings','grp_screenC','?'));
  settings.frequencyof.caption:=(readstring('settings','frequencyofC','?'));
  settings.frequencyof.hint:=wrap(ReadString('settings','frequencyofH','?'));

  settings.supdate.hint:=wrap(ReadString('settings','supdateH','?'));

  settings.grp_mouse1.caption:=(readstring('settings','grp_mouseC','?'));
  settings.mousewheelreverse1.caption:=(readstring('settings','mouse_wheel_ReverseC','?'));
  settings.mousewheelreverse1.hint:=wrap(ReadString('settings','mouse_wheel_ReverseH','?'));


  settings.grp_moon_and_horizon.caption:=(readstring('settings','grp_moon_and_horizonC','?'));
  settings.Mooncoversstars1.caption:=(readstring('settings','moon_covers_StarsC','?'));
  settings.MooncoversStars1.hint:=wrap(ReadString('settings','moon_covers_StarsH','?'));
  settings.Earthcoversstars1.caption:=(readstring('settings','earth_covers_StarsC','?'));
  settings.EarthcoversStars1.hint:=wrap(ReadString('settings','earth_covers_StarsH','?'));


  settings.grp_pointing.caption:=(readstring('settings','grp_pointingC','?'));
  settings.grp_pointing.hint:=wrap(ReadString('settings','grp_pointingH','?'));
  settings.telrad01.hint:=wrap(ReadString('settings','telrad01H','?'));
  settings.telrad05.hint:=wrap(ReadString('settings','telrad05H','?'));

  settings.grp_equinox.caption:=(readstring('settings','grp_equinoxC','?'));
  settings.grp_equinox.hint:=wrap(ReadString('settings','grp_equinoxH','?'));

  settings.equinoxtelescope.caption:=(readstring('settings','e_telescopeC','?'));
  settings.equinoxmap.caption:=(readstring('settings','e_mapC','?'));

  settings.equinox_map.hint:=wrap(ReadString('settings','e_mapH','?'));
  settings.equinox_telescope2.hint:=wrap(ReadString('settings','e_telescopeH','?'));

  settings.Azimuth_degrees1.caption:=(readstring('settings','azimuth_degreesC','?'));
  settings.Azimuth_degrees1.hint:=wrap(ReadString('settings','azimuth_degreesH','?'));

  settings.grp_usno.caption:=(readstring('settings','grp_usnoC','?'));
  settings.grp_usno.hint:=wrap(ReadString('settings','grp_usnoH','?'));
  settings.UCACpath.hint:=wrap(ReadString('settings','ucacpathH','?'));

  settings.grp_language_file.caption:=(readstring('settings','grp_languageC','?'));
  settings.grp_language_file.hint:=wrap(ReadString('settings','grp_languageH','?'));

  settings.grp_measuring.caption:=(readstring('settings','grp_measuringC','?'));
  settings.grp_measuring.hint:=wrap(ReadString('settings','grp_measuringH','?'));
  settings.width_label.caption:=(readstring('settings','width_labelC','?'));
  settings.height_label.caption:=(readstring('settings','height_labelC','?'));
  settings.width.hint:=wrap(ReadString('settings','widthH','?'));
  settings.height.hint:=wrap(ReadString('settings','heightH','?'));
  settings.grp_fits.caption:=(readstring('settings','grp_fitsC','?'));
  settings.grp_fits.hint:=wrap(ReadString('settings','grp_fitsH','?'));
  settings.path_label.caption:=(readstring('settings','path_labelC','?'));
  settings.dssmask.hint:=wrap(ReadString('settings','dssmaskH','?'));
  settings.EarlyFITS.caption:=(readstring('settings','early_FITSC','?'));
  settings.EarlyFITS.hint:=wrap(ReadString('settings','early_FITSH','?'));

  settings.DE430_on1.hint:=wrap(ReadString('settings','de_checkH','?'));
  settings.DE430_file1.hint:=wrap(ReadString('settings','de_file1H','?'));
  settings.DE431_file1.hint:=wrap(ReadString('settings','de_file2H','?'));
  settings.de430info.hint:=wrap(ReadString('settings','help_deH','?'));


  settings.grp_documents_path.caption:=(readstring('settings','grp_documents_pathC','?'));
  settings.grp_documents_path.hint:=wrap(ReadString('settings','grp_documents_pathH','?'));

  settings.grs_offset3.caption:=wrap(ReadString('settings','grs_offsetC','?'));
  settings.grs_offset2.hint:=wrap(ReadString('settings','grs_offsetH','?'));
  settings.jupiter_groupbox1.caption:=Jupiter_string;

  settings.show_plot_time1.caption:=(readstring('settings','show_plot_timeC','?'));
  settings.show_plot_time1.hint:=(readstring('settings','show_plot_timeH','?'));


  settings.Colors_tab.caption:=(readstring('settings','colors_tabC','?'));
  settings.click_on.caption:=(readstring('settings','click_onC','?'));
  settings.font_sizes.caption:=(readstring('settings','font_sizesC','?'));
  settings.font_setting.hint:=wrap(ReadString('settings','font_settingH','?'));
  settings.colorpanel.hint:=wrap(ReadString('settings','colorpanelH','?'));
  settings.col8.caption:=(readstring('settings','col8C','?'));

  help_label:=ReadString('settings','col8H','?');
  help_color:=ReadString('settings','col7H','?');

  settings.col8.hint:=help_label;
  settings.col7.hint:=help_color;

  settings.bright_limit.hint:=wrap(ReadString('settings','bright_limitH','?'));
  settings.medium_limit.hint:=wrap(ReadString('settings','medium_limitH','?'));

  settings.col9.caption:=(readstring('settings','col9C','?'));
  settings.col9.hint:=help_label;
  settings.col10.caption:=(readstring('settings','col10C','?'));
  settings.col10.hint:=help_label;
  settings.col37.caption:=(readstring('settings','col12C','?'));
  settings.col37.hint:=help_label;
  settings.col36.caption:=(readstring('settings','col36C','?'));
  settings.col36.hint:=help_label;
  settings.col38.caption:=(readstring('settings','col13C','?'));
  settings.col38.hint:=help_label;
  settings.col35.caption:=(readstring('settings','col35C','?'));
  settings.col35.hint:=help_label;
  settings.col17.hint:=help_color;
  settings.col11.hint:=help_color;
  settings.col31.hint:=help_color;
  settings.col31line.hint:=help_color;
  settings.col28.caption:=(readstring('settings','col28C','?'));
  settings.col28.hint:=help_color;
  settings.col28line.hint:=help_color;
  settings.col20.caption:=(readstring('settings','col20C','?'));
  settings.col20.hint:=help_color;
  settings.col20line.hint:=help_color;
  settings.col19.caption:=(readstring('settings','col19C','?'));
  settings.col19.hint:=help_color;
  settings.col19line.hint:=help_color;
  settings.col40.caption:=(readstring('settings','col40C','?'));
  settings.col40.hint:=help_color;
  settings.col40line.hint:=help_color;
  settings.col16.caption:=(readstring('settings','col16C','?'));
  settings.col16.hint:=help_label;
  settings.col18.caption:=(readstring('settings','col18C','?'));
  settings.col18.hint:=help_label;
  settings.col6.hint:=help_color;
  settings.col5.hint:=help_color;
  settings.col26.caption:=(readstring('settings','col26C','?'));
  settings.col26.hint:=help_label;
  settings.col21.caption:=(readstring('settings','col21C','?'));
  settings.col21.hint:=help_label;
  settings.col12.hint:=help_color;
  settings.col33.hint:=help_color;
  settings.col39.hint:=help_color;
  settings.col1.hint:=help_color;
  settings.col15.hint:=help_color;
  settings.col13.hint:=help_color;
  settings.col32.hint:=help_color;
  settings.col34.hint:=help_color;
  settings.col4.hint:=help_color;
  settings.col3.hint:=help_color;
  settings.col2.hint:=help_color;
  settings.col14.caption:=(readstring('settings','col14C','?'));
  settings.col14.hint:=help_color;
  settings.col14line.hint:=help_color;
  settings.col27.caption:=(readstring('settings','col27C','?'));
  settings.col27.hint:=help_color;
  settings.col25.caption:=(readstring('settings','col25C','?'));
  settings.col25.hint:=help_color;
  settings.col29.caption:=(readstring('settings','col29C','?'));
  settings.col29.hint:=help_label;
  settings.gemini.caption:=(readstring('settings','geminiC','?'));
  settings.gemini.hint:=help_color;
  settings.moon.caption:=(readstring('settings','moonC','?'));
  settings.moon.hint:=wrap(ReadString('settings','font_settingH','?'));{2013}

  settings.col24.caption:=(readstring('settings','col24C','?'));
  settings.col24.hint:=help_label;
  settings.col30b.caption:=(readstring('settings','col30C','?'));
  settings.col30.hint:=wrap(ReadString('settings','col30h','?'));
  settings.col30b.hint:=settings.col30.hint;
  settings.reset_to_default.caption:=(readstring('settings','reset_to_defaultC','?'));
  settings.reset_to_default.hint:=wrap(ReadString('settings','reset_to_defaultH','?'));

//  settings.cursor_normal.caption:=(readstring('settings','cursor_normalC','?'));
//  settings.cursor_normal.hint:=wrap(ReadString('settings','cursor_normalH','?'));
//  settings.cursor_special.caption:=(readstring('settings','cursor_specialC','?'));
//  settings.cursor_special.hint:=wrap(ReadString('settings','cursor_specialH','?'));

  settings.inverse_colors.caption:=(readstring('settings','inverse_colorsC','?'));
  settings.inverse_colors.hint:=wrap(ReadString('settings','inverse_colorsH','?'));
  sure_string:=ReadString('settings','sure_string','?');
  settings.applybutton1.caption:=(readstring('settings','applybuttonC','?'));
  settings.applybutton1.hint:=wrap(ReadString('settings','applybuttonH','?'));
  settings.cancelbutton1.caption:=(readstring('settings','cancelbuttonC','?'));
  settings.cancelbutton1.hint:=wrap(ReadString('settings','cancelbuttonH','?'));
  settings.applysave1.caption:=(readstring('settings','applysaveC','?'));
  settings.applysave1.hint:=wrap(ReadString('settings','applysaveH','?'));

  settings.internet_tab.caption:=(readstring('settings','internet_tabC','?'));

  settings.dss1.caption:=(readstring('settings','dssC','?'));
  settings.dss1.hint:=wrap(ReadString('settings','dssH','?'));

  settings.internetskyviewwide.hint:=wrap(ReadString('settings','internet_fitsskywideH','?'));
  settings.internetskyview.hint:=wrap(ReadString('settings','internet_fitsskyH','?'));
  settings.interneteso.hint:=wrap(ReadString('settings','internet_fitsesoH','?'));
  settings.internetmast.hint:=wrap(ReadString('settings','internet_fitsmastH','?'));

  settings.GroupBox_stars1.caption:=(readstring('settings','internet_star_serverC','?'));
  settings.vizier_server1.hint:=wrap(ReadString('settings','internet_star_serverH','?'));

  settings.searchby1.caption:=(readstring('settings','searchbyC','?'));
  settings.searchby1.hint:=wrap(ReadString('settings','searchbyH','?'));

  settings.internetsimbad.hint:=wrap(ReadString('settings','internet_simbadH','?'));
  settings.internetleda.hint:=wrap(ReadString('settings','internet_ledaH','?'));
  settings.internetned.hint:=wrap(ReadString('settings','internet_nedH','?'));

  settings.location_tab.caption:=(readstring('settings','location_tabC','?'));{223}

  settings.update_tab.caption:=(readstring('settings','update_tabC','?'));{2013}

  settings.internetasteroid1.hint:=wrap(ReadString('settings','asteroid_linkH','?'));
  settings.internetcomet1.hint:=wrap(ReadString('settings','comet_linkH','?'));

  settings.up_to_number1.caption:=(readstring('settings','up_to_numberC','?'));
  settings.up_to_magn1.caption:=(readstring('settings','up_to_magnC','?'));

  settings.max_nr_asteroids1.hint:=(readstring('settings','up_to_numberH','?'));
  settings.max_magn_asteroids1.hint:=(readstring('settings','up_to_magnH','?'));


  settings.button_asteroid_update1.caption:=(readstring('settings','asteroidbuttonC','?'));
  settings.button_comet_update1.caption:=(readstring('settings','cometbuttonC','?'));

  settings.telescope_tab1.caption:=(readstring('settings','telescope_tabC','?'));

  settings.Ascom_radiobutton1.caption:=(readstring('settings','ascomC','?'));
  settings.Ascom_radiobutton1.hint:=wrap(ReadString('settings','ascomH','?'));

  settings.alpaca_radiobutton1.caption:=(readstring('settings','alpacaC','?'));
  settings.alpaca_radiobutton1.hint:=wrap(ReadString('settings','alpacaH','?'));
  settings.alpaca_groupBox1.caption:=(readstring('settings','alpaca_group_boxC','?'));
  settings.alpaca_adress1.hint:=wrap(ReadString('settings','alpaca_addressH','?'));
  settings.alpaca_port1.hint:=wrap(ReadString('settings','alpaca_portH','?'));

  settings.alpaca_port_number1.caption:=(ReadString('settings','alpaca_port_numberC','?'));
  settings.alpaca_telescope2.caption:=(ReadString('settings','apaca_telescopeC','?'));
  settings.alpaca_telescope1.hint:=wrap(ReadString('settings','alpaca_telescopeH','?'));


  settings.indi_radiobutton1.caption:=(readstring('settings','indiC','?'));
  settings.indi_radiobutton1.hint:=wrap(ReadString('settings','indiH','?'));

  settings.indi_groupbox1.caption:=(readstring('settings','indi_group_boxC','?'));

  settings.indi_address1.caption:=(readstring('settings','indi_addressC','?'));
  settings.indi_address1.hint:=wrap(ReadString('settings','indi_addressH','?'));
  settings.indi_host_address1.hint:=settings.indi_address1.hint;

  settings.indi_port_number1.caption:=(readstring('settings','indi_port_numberC','?'));
  settings.indi_port_number1.hint:=wrap(ReadString('settings','indi_port_numberH','?'));
  settings.indi_port1.hint:=settings.indi_port_number1.hint;

  settings.connect_server_Button1.caption:=(readstring('settings','connect_server_ButtonC','?'));
  settings.connect_server_Button1.hint:=wrap(ReadString('settings','connect_server_ButtonH','?'));

  settings.disconnect_server_button1.caption:=(readstring('settings','disconnect_server_buttonC','?'));
  settings.disconnect_server_button1.hint:=wrap(ReadString('settings','disconnect_server_buttonH','?'));

  settings.select_telescope_name1.caption:=(readstring('settings','select_telescope_nameC','?'));
  settings.select_telescope_name1.hint:=wrap(ReadString('settings','select_telescope_nameH','?'));
  settings.telescope_name_select1.hint:=settings.select_telescope_name1.hint;

  settings.connect_telescope_button1.caption:=(readstring('settings','connect_telescope_buttonC','?'));
  settings.connect_telescope_button1.hint:=wrap(ReadString('settings','connect_telescope_buttonC','?'));

  settings.disconnect_telescope_button1.caption:=(readstring('settings','disconnect_telescope_buttonC','?'));
  settings.disconnect_telescope_button1.hint:=wrap(ReadString('settings','disconnect_telescope_buttonH','?'));

  settings.show_indi_client_button1 .caption:=(readstring('settings','show_indi_client_buttonC','?'));
  settings.show_indi_client_button1 .hint:=wrap(ReadString('settings','show_indi_client_buttonH','?'));

  {remove labels outstanding!!}
//  indi.show_full_indi_communication1.caption:=(readstring('settings','show_full_indi_communicationC','?'));
//  indi.show_full_indi_communication1.hint:=wrap(ReadString('settings','show_full_indi_communicationH','?'));

  settings.server_tab1.caption:=(readstring('settings','server_tabC','?'));

  settings.server_title1.caption:=(readstring('settings','server_titleC','?'));

  settings.server_checkbox1.caption:=(readstring('settings','server_checkboxC','?'));
  settings.server_checkbox1.hint:=wrap(ReadString('settings','server_checkboxH','?'));

  settings.server_host_address1.caption:=(readstring('settings','server_host_addressC','?'));
  settings.server_host_address1.hint:=wrap(ReadString('settings','server_host_addressH','?'));
  settings.server_host_address_edit1.hint:=settings.server_host_address1.hint;

  settings.server_port2.caption:=(readstring('settings','server_portC','?'));
  settings.server_port2.hint:=wrap(ReadString('settings','server_portH','?'));
  settings.server_port1.hint:=settings.server_port2.hint;

  end;
end;

procedure load_dark;
begin
  with labelstring do
  begin
    darkform.Bevel_hour.hint:=wrap(ReadString('dark','bevel_hourH','?'));
    darkform.Bevel_day.hint:=wrap(ReadString('dark','bevel_dayH','?'));
    darkform.Bevel_main.hint:=wrap(ReadString('dark','bevel_mainH','?'));
    darkform.ok.caption:=(readstring('dark','ok_buttonC','?'));
    darkform.ok.hint:=wrap(ReadString('dark','ok_buttonH','?'));
    darkform.help_darkmenu.hint:=wrap(ReadString('dark','helpH','?'));

    darkform.to_clipboard.caption:=(readstring('dark','to_clipboardC','?'));
    darkform.to_clipboard.hint:=wrap(ReadString('dark','to_clipboardH','?'));
    friday:=ReadString('dark','friday','?');
    dark_skies_title:=ReadString('dark','dark_skies_title','?');

    darkform.col_civil_twilight1.caption:=(readstring('dark','civil_twilightC','?'));
    darkform.col_civil_twilight1.hint:=wrap(ReadString('dark','civil_twilightH','?'));

    darkform.col_nautical1.caption:=(readstring('dark','nautical_twilightC','?'));
    darkform.col_nautical1.hint:=wrap(ReadString('dark','nautical_twilightH','?'));

    darkform.col_astro1.caption:=(readstring('dark','astronomical_twilightC','?'));
    darkform.col_astro1.hint:=wrap(ReadString('dark','astronomical_twilightH','?'));

    darkform.nautical_end1.hint:=wrap(ReadString('dark','nautical_endH','?'));

    darkform.backward1.hint:=wrap(ReadString('dark','day_backH','?'));
    darkform.forward1.hint:=wrap(ReadString('dark','day_fwdH','?'));
  end;
end;

procedure load_planet;
begin
  with labelstring do
  begin
  planetform.Bevel_time.hint:=wrap(ReadString('solar','bevel_timeH','?'));
  planetform.Bevel_planet.hint:=wrap(ReadString('solar','bevel_planetH','?'));
  planetform.Bevel_main.hint:=wrap(ReadString('solar','bevel_mainH','?'));
  planetform.ok_button.caption:=(readstring('solar','ok_buttonC','?'));
  planetform.ok_button.hint:=wrap(ReadString('solar','ok_buttonH','?'));
  planetform.help_planetmenu.hint:=wrap(ReadString('solar','helpH','?'));

  planetform.to_clipboard.caption:=(readstring('solar','to_clipboardC','?'));
  planetform.to_clipboard.hint:=wrap(ReadString('solar','to_clipboardH','?'));

  Visibility_planets_title:=ReadString('solar','visibility_planets_title','?');
  end;
end;

procedure load_edit;
begin
  with labelstring do
  begin
  edit2.caption:=(readstring('edit','edit_title','?'));
  edit2.File1.caption:=(readstring('edit','fileC','?'));
  edit2.Save1.caption:=(readstring('edit','saveC','?'));
  edit2.Saveas1.caption:=(readstring('edit','saveasC','?'));
  edit2.Load1.caption:=(readstring('edit','loadC','?'));
  edit2.Exit1.caption:=(readstring('edit','exitC','?'));
  edit2.Edit1.caption:=(readstring('edit','editC','?'));
  edit2.Cut1.caption:=(readstring('edit','cutC','?'));
  edit2.Cut2.caption:=edit2.Cut1.caption; {for popup menu}
  edit2.Copy1.caption:=(readstring('edit','copyC','?'));
  edit2.Copy2.caption:=edit2.Copy1.caption; {for popup menu}
  edit2.Paste1.caption:=(readstring('edit','pastC','?'));
  edit2.Paste2.caption:=edit2.Paste1.caption;  {for popup menu}
  edit2.Undo1.caption:=(readstring('edit','undoC','?'));
  edit2.Selectall1.caption:=(readstring('edit','selectallC','?'));
  edit2.Selectall2.caption:=edit2.Selectall1.caption;
  edit2.Checksyntax1.caption:=(readstring('edit','checksyntaxC','?'));
  edit2.Search1.caption:=(readstring('edit','searchC','?'));

  edit2.find1.caption:=(readstring('edit','findC','?'));
    edit2.find2.caption:=striphotkey(edit2.find1.caption);
  edit2.replace1.caption:=(readstring('edit','replaceC','?'));
    edit2.replace2.caption:=striphotkey(edit2.replace1.caption);
  edit2.replace_all1.caption:=(readstring('edit','replace_allC','?'));


  edit2.tools1.caption:=(readstring('edit','toolsC','?'));
  edit2.Numericalintegration1.caption:=(readstring('edit','Numerical_integrationC','?'));
  edit2.Numericalintegration1.hint:=wrap(ReadString('edit','Numerical_integrationH','?'));
  edit2.Updatefrominternet1.caption:=(readstring('edit','Update_from_internetC','?'));
  edit2.Updatefrominternet1.hint:=wrap(ReadString('edit','Update_from_internetH','?'));
  edit2.JPLOrbitalelementsconversion1.caption:=(readstring('edit','Paste_JPL_orbital_elementsC','?'));
  edit2.JPLOrbitalelementsconversion1.hint:=wrap(ReadString('edit','Paste_JPL_orbital_elementsH','?'));

  edit2.Paste_supplement_lines1.caption:=(readstring('edit','paste_objectsC','?'));
  edit2.Paste_supplement_lines1.hint:=wrap(ReadString('edit','paste_objectsH','?'));

  edit2.Paste_supplement_labels1.caption:=(readstring('edit','paste_labelsC','?'));
  edit2.Paste_supplement_labels1.hint:=wrap(ReadString('edit','paste_labelsH','?'));


  edit2.Font1.caption:=(readstring('edit','fontC','?'));
  edit2.About1.caption:=(readstring('edit','aboutC','?'));
  end;
end;

procedure load_search_results;
begin
  with labelstring do
  begin   {use translations form edit2}
    search_results.Cut2.caption:=(readstring('edit','cutC','?'));
    search_results.Copy2.caption:=(readstring('edit','copyC','?'));
    search_results.Paste2.caption:=(readstring('edit','pastC','?'));
    search_results.Select_all2.caption:=(readstring('edit','selectallC','?'));
    search_results.Search2.caption:=(readstring('edit','searchC','?'));
  end;
end;
procedure load_animation;
begin
  with labelstring do
  begin

    form_animation.caption:=(readstring('animation','animation_title','?'));

    form_animation.object_to_follow.caption:=(readstring('animation','object_to_followC','?'));
    form_animation.followstars.caption:=(readstring('animation','starsC','?'));
    form_animation.followstars.hint:=wrap(ReadString('animation','starsH','?'));
    form_animation.follow_none.caption:=(readstring('animation','noneC','?'));
    form_animation.follow_none.hint:=wrap(ReadString('animation','noneH','?'));
    form_animation.lock_on_name.caption:=(readstring('animation','planetaryC','?'));
    form_animation.lock_on_name.hint:=wrap(ReadString('animation','planetaryH','?'));
    form_animation.planetary_comboBox.hint:=wrap(ReadString('animation','planetary_comboboxH','?'));


    form_animation.time_step.caption:=(readstring('animation','time_stepC','?'));
    form_animation.minus_2356.hint:=wrap(ReadString('animation','minus_2356H','?'));
    form_animation.minus_ten.hint:=wrap(ReadString('animation','minus_tenH','?'));
    form_animation.minus_one.hint:=wrap(ReadString('animation','minus_oneH','?'));
    form_animation.plus_2356.hint:=wrap(ReadString('animation','plus_2356H','?'));
    form_animation.plus_ten.hint:=wrap(ReadString('animation','plus_tenH','?'));
    form_animation.plus_one.hint:=wrap(ReadString('animation','plus_oneH','?'));
    form_animation.backwards_one.hint:=wrap(ReadString('animation','backwards_oneH','?'));
    form_animation.forwards_one.hint:=wrap(ReadString('animation','forwards_oneH','?'));
    form_animation.stepsize2.hint:=wrap(ReadString('animation','stepsizeH','?'));
    form_animation.unit_combobox.hint:=wrap(ReadString('animation','unit_comboboxH','?'));

    form_animation.unit_combobox.items[0]:=ReadString('animation','unit0','?'); {second}
    form_animation.unit_combobox.items[1]:=ReadString('animation','unit1','?'); {minute}
    form_animation.unit_combobox.items[2]:=ReadString('animation','unit2','?'); {hour}
    form_animation.unit_combobox.items[3]:=ReadString('animation','unit3','?');
    form_animation.unit_combobox.items[4]:=ReadString('animation','unit4','?');
    form_animation.unit_combobox.items[5]:=ReadString('animation','unit5','?');
    form_animation.unit_combobox.items[6]:=ReadString('animation','unit6','?');
    form_animation.unit_combobox.items[7]:=ReadString('animation','unit7','?');
    form_animation.unit_combobox.items[8]:=ReadString('animation','unit8','?');

    form_animation.backwards_many.hint:=wrap(ReadString('animation','backwards_manyH','?'));
    form_animation.forwards_many.hint:=wrap(ReadString('animation','forward_manyH','?'));
    form_animation.stop_button.hint:=wrap(ReadString('animation','stop_buttonH','?'));
    form_animation.number_of_steps.hint:=wrap(ReadString('animation','number_of_stepsH','?'));
    form_animation.continuous.caption:=(readstring('animation','continuousC','?'));
    form_animation.continuous.hint:=wrap(ReadString('animation','continuousH','?'));
    form_animation.planetary_tracks.caption:=(readstring('animation','planetary_tracksC','?'));
    form_animation.planetary_tracks.hint:=wrap(ReadString('animation','planetary_tracksH','?'));
    form_animation.moon_tracks.caption:=(readstring('animation','moon_tracksC','?'));
    form_animation.moon_tracks.hint:=wrap(ReadString('animation','moon_tracksH','?'));

    form_animation.eclipse.caption:=(readstring('animation','eclipseC','?'));
    form_animation.eclipsebackwards.hint:=wrap(ReadString('animation','eclipsebackwardsH','?'));
    form_animation.eclipseforwards.hint:=wrap(ReadString('animation','eclipseforwardsH','?'));
    form_animation.solar_eclipse1.caption:=(readstring('animation','solarC','?'));
    form_animation.lunar_eclipse1.caption:=(readstring('animation','lunarC','?'));
    form_animation.close_button.caption:=(readstring('animation','close_buttonC','?'));
    form_animation.close_button.hint:=wrap(ReadString('animation','close_buttonH','?'));
    form_animation.help_animation.hint:=wrap(ReadString('animation','helpH','?'));
  end;
end;

procedure load_suppl_edit;
begin
  with labelstring do
  begin
    edit_supplement_entry.ok_button1.caption:=(readstring('suppl_edit','ok_buttonC','?'));
    edit_supplement_entry.ok_button1.hint:=wrap(ReadString('suppl_edit','ok_buttonH','?'));
    save_suppl_string:=ReadString('suppl_edit','save_buttonC','?');
    edit_supplement_entry.save_button1.hint:=wrap(ReadString('suppl_edit','save_buttonH','?'));
    edit_supplement_entry.cancel_button1.caption:=(readstring('suppl_edit','cancel_buttonC','?'));
    edit_supplement_entry.cancel_button1.hint:=wrap(ReadString('suppl_edit','cancel_buttonH','?'));
    edit_supplement_entry.remove_button1.caption:=(readstring('suppl_edit','remove_buttonC','?'));
    edit_supplement_entry.remove_button1.hint:=wrap(ReadString('suppl_edit','remove_buttonH','?'));

    edit_supplement_entry.edit_name1.hint:=wrap(ReadString('suppl_edit','name_editH','?'));
    edit_supplement_entry.edit_magn1.hint:=wrap(ReadString('suppl_edit','magn_editH','?'));
    edit_supplement_entry.edit_type1.hint:=wrap(ReadString('suppl_edit','type_editH','?'));
    edit_supplement_entry.edit_brightness1.hint:=wrap(ReadString('suppl_edit','brightness_editH','?'));
    edit_supplement_entry.edit_length1.hint:=wrap(ReadString('suppl_edit','length_editH','?'));
    edit_supplement_entry.edit_width1.hint:=wrap(ReadString('suppl_edit','width_editH','?'));
    edit_supplement_entry.edit_pa1.hint:=wrap(ReadString('suppl_edit','pa_editH','?'));
  end;
end;

begin
end.
