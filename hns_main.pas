unit hns_main;
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
{$else} {unix}
{$endif}

{$ifdef mswindows}
 Windows,
 shellapi,
 URLMon,   {For downloading files}
// Registry,
 comobj,   {for ASCOM link}

 {$IFDEF fpc}{mswindows & FPC}
  HTMLHelp,
 {$else} {delphi}
 {$endif}
 {$else} {unix}
  LResources,  {for lazarus *.lrs file}
  process,
  LCLType, {for HDC type}
  dateutils,
 {$endif}

 {$IFDEF fpc}
  lNetComponents, lNet,
  LCLIntf,{for selectobject, openURL}
  LCLProc,
  PrintersDlgs,  {FPC/Lazarus, important add in project inspector required package Printer4lazarus !!, otherwise compiler error}
  FPImage,   {PNG image}
  GraphType, {fastbitmap}
  LCLversion,
 {$else}  {delphi}
  IOUtils,   {for TPath.GetDocumentsPath}
  pngimage,
  Vcl.ImgList, Vcl.ToolWin,

 {$endif}

  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus,inifiles,
  ExtCtrls, ComCtrls, Buttons,
  math,{for sincos}
  Variants,
  StrUtils, {AnsiStrings,} {for strpcopy, to get rid of depreciated strpcopy}
  clipbrd, {for copy to clipboard}
  printers, Types ;

type
  {Tmainwindow }
  Tmainwindow = class(TForm)
    About1: TMenuItem;
    add_label1: TMenuItem;
    alt_m2: Tstatictext;
    alt_m1: Tstatictext;
    flipped1: TStaticText;
    Animation1: TMenuItem;
    Asteroiddataeditor: TMenuItem;
    Azimuthalequidistant1: TMenuItem;
    Boundaries1: TMenuItem;
    Centreon1: TMenuItem;
    Cleardownload1: TMenuItem;
    Clearmarkers1: TMenuItem;
    Clearmarkers2: TMenuItem;
    Colorchange1: TMenuItem;
    cometdataeditor: TMenuItem;
    connect_telescope1: TMenuItem;
    Constellations1: TMenuItem;
    ControlBar1: TControlBar;
    ControlBar2: TControlBar;
    Copywindowtoclipboard1: TMenuItem;
    Crosshair1: TMenuItem;
    Cylindrical1: TMenuItem;
    Darknights1: TMenuItem;
    Databases1: TMenuItem;
    Date1: TMenuItem;
    Dateandtimemarker1: TMenuItem;
    date_and_time1: Tstatictext;
    az_m2: Tstatictext;
    az_m1: Tstatictext;
    DayF8: TMenuItem;
    DayF7: TMenuItem;
    dec_m2: Tstatictext;
    Deepskycontoursonly1: TMenuItem;
    deepskyobservations1: TMenuItem;
    Deletelastpoint1: TMenuItem;
    Deleteonlinecache1: TMenuItem;
    Drawsolarobjecttracks1: TMenuItem;
    Earth1: TMenuItem;
    East1: TMenuItem;
    editobject1: TMenuItem;
    Enterdatetime1: TMenuItem;
    error_message1: TLabel;
    Exit1: TMenuItem;
    mouseposition1: TMenuItem;
    File1: TMenuItem;
    Fliphorizontal1: TMenuItem;
    Flipvertical1: TMenuItem;
    Followsolarobject1: TMenuItem;
    Foundobjectmarker1: TMenuItem;
    GetDSSimagefrominternet1: TMenuItem;
    get_ESO1: TMenuItem;
    get_mast1: TMenuItem;
    Get_Skyview1: TMenuItem;
    GotoRADEC1: TMenuItem;
    GridAZAlt1: TMenuItem;
    GridRADEC1: TMenuItem;
    Helpmainmenu1: TMenuItem;
    Help1: TMenuItem;
    Hidden_main_menu1: TMenuItem;
    Hidden_move_to1: TMenuItem;
    hidelines1: TMenuItem;
    home1: TMenuItem;
    HourF5: TMenuItem;
    HourF6: TMenuItem;
    HyperLeda1: TMenuItem;
    ImageList32x32: TImageList;
    Image_starscale1: TImage;
    image_north1: TImage;
    Image_clock1: TImage;
    IN1: TMenuItem;
    indi_client1: TMenuItem;
    InsertFITSimage1: TMenuItem;
    Insertlines1: TMenuItem;
    Instruments1: TMenuItem;
    Internal1: TMenuItem;
    left10: TLabel;
    left9: TLabel;
    Linestart1: TMenuItem;
    LinestartAzALT1: TMenuItem;
    Load1: TMenuItem;
    loadevent1: TMenuItem;
    load_fits1: TMenuItem;
    alpaca1: TLTCPComponent;
    Magnitudeofobjectmarker1: TMenuItem;
    Markerslines1: TMenuItem;
    Measuringframe1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem12: TMenuItem;
    hyperleda_import1: TMenuItem;
    export_frames_via_server1: TMenuItem;
    exportviaserver1: TMenuItem;
    MenuItem3: TMenuItem;
    clearvisibledownload1: TMenuItem;
    bandpassmenu1: TMenuItem;
    dss2_red1: TMenuItem;
    dss_red1: TMenuItem;
    dss_blue1: TMenuItem;
    MenuItem6: TMenuItem;
    dss2_blue1: TMenuItem;
    dss2_infrared1: TMenuItem;
    MilkyWay1: TMenuItem;
    MinF3: TMenuItem;
    MinF4: TMenuItem;
    movelines1: TMenuItem;
    N13: TMenuItem;
    N2356F11: TMenuItem;
    N2356F12: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N48: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
    Nameofobjectmarker1: TMenuItem;
    Ned1: TMenuItem;
    North1: TMenuItem;
    Northabove1: TMenuItem;
    Northarrow1: TMenuItem;
    NowF9: TMenuItem;
    Objecthints1: TMenuItem;
    Objectinfotoclipboard1: TMenuItem;
    Objects1: TMenuItem;
    Orthographic_projection1: TMenuItem;
    OUT1: TMenuItem;
    panel_starscale1: TPanel;
    panel_north1: TPanel;
    Panel_clock1: TPanel;
    park1: TMenuItem;
    park_unpark1: TMenuItem;
    Pointingcirclemarker1: TMenuItem;
    Pointingcircles1: TMenuItem;
    Polarscopeview1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Printwindowblacksky1: TMenuItem;
    Printwindowwhitesky1: TMenuItem;
    ra_m2: Tstatictext;

    Image1: TImage;
    left8: tlabel;
    field1: Tstatictext;
    left1: Tstatictext;
    left2: Tstatictext;
    left3: tlabel;
    left4: tlabel;
    left5: tlabel;
    left6: tlabel;
    left7: tlabel;
    ltcp1: TLTCPComponent;
    Redoview1: TMenuItem;
    Removelines1: TMenuItem;
    Reset1: TMenuItem;
    right1: Tstatictext;
    right1c: Tstatictext;
    left1b: Tstatictext;
    right2: Tstatictext;
    right3: tlabel;
    right4: tlabel;
    right5: tlabel;
    right6: tlabel;
    right7: tlabel;
    right8: TLabel;
    right9: TLabel;
    Saveas1: TMenuItem;
    Savesettings1: TMenuItem;
    Screen1: TMenuItem;
    Search1: TMenuItem;
    Searchbyposition1: TMenuItem;
    setpark1: TMenuItem;
    settings1: TMenuItem;
    Showclock1: TMenuItem;
    Showmoonorbits1: TMenuItem;
    Showstatusbar1: TMenuItem;
    Sidereal1: TMenuItem;
    Simbad1: TMenuItem;
    Solarsystemtonight1: TMenuItem;
    South1: TMenuItem;
    Starscale1: TMenuItem;
    StatusBar1: Tpanel;
    Supplement1editor: TMenuItem;
    Supplement2editor: TMenuItem;
    Supplement3editor: TMenuItem;
    Supplement4editor: TMenuItem;
    Supplement5editor: TMenuItem;
    Telescope1: TMenuItem;
    Telescopetomouseposition1: TMenuItem;
    telescope_abort1: TMenuItem;
    telescope_synctomouse1: TMenuItem;
    Timer_delayed_start_server: TTimer;
    Tonight1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Timer1: TTimer;
    {$IFDEF fpc}
    PageSetupDialog1: TPageSetupDialog;
    PrintDialog1: TPrintDialog;
    {$ELSE} {delphi}
    {$ENDIF}
    ascom_timer: TTimer;
    ImageList16x16: TImageList;
    tracking1: TMenuItem;
    tracktelescope1: TMenuItem;
    Twolinesnorthsouth1: TMenuItem;
    Undoview1: TMenuItem;
    Usesystemtime1: TMenuItem;
    West1: TMenuItem;
    ToolBar2: TToolBar;
    Filetoolbutton: TToolButton;
    Searchtoolbutton: TToolButton;
    Intoolbutton: TToolButton;
    Outtoolbutton: TToolButton;
    Resettoolbutton: TToolButton;
    Screentoolbutton: TToolButton;
    Objectstoolbutton: TToolButton;
    Datetoolbutton: TToolButton;
    Helptoolbutton: TToolButton;
    Enterdatetimetoolbutton: TToolButton;
    GotoRADECToolButton: TToolButton;
    instrumentstoolbutton: TToolButton;
    Foundobjectmarkertoolbutton: TToolButton;
    undotoolbutton: TToolButton;
    Savesettingstoolbutton: TToolButton;
    telescope_aborttoolbutton: TToolButton;
    SettingstoolButton: TToolButton;
    deephlptoolbutton: TToolButton;
    Darknightstoolbutton: TToolButton;
    Solarsystemtonighttoolbutton: TToolButton;
    gridRAtoolButton: TToolButton;
    redoToolButton: TToolButton;
    fitstoolButton: TToolButton;
    ConstellationstoolButton: TToolButton;
    PopupMenu_menubar1: TPopupMenu;
    FlipH_onoff: TMenuItem;
    Settings_onoff: TMenuItem;
    Redo_onoff: TMenuItem;
    Undo_onoff: TMenuItem;
    Foundmarker_onoff: TMenuItem;
    Tools_onoff: TMenuItem;
    GotoRADEC_onoff: TMenuItem;
    Time_onoff: TMenuItem;
    Save_onoff: TMenuItem;
    Solarsystem_onoff: TMenuItem;
    Darknights_onoff: TMenuItem;
    deephlp_onoff: TMenuItem;
    GridRA_onoff: TMenuItem;
    Slew_onoff: TMenuItem;
    Fits_onoff: TMenuItem;
    Constellations_onoff: TMenuItem;
    fliphtoolbutton: TToolButton;
    flipvtoolbutton: TToolButton;
    Northabovetoolbutton: TToolButton;
    siderealtoolbutton: TToolButton;
    toolbutton_menu: TToolButton;
    Sidereal_onoff: TMenuItem;
    Northabove_onoff: TMenuItem;
    FlipV_onoff: TMenuItem;
    ToolButton1: TToolButton;
    gridAZToolButton: TToolButton;
    GridAZ_onoff: TMenuItem;
    menu_Color: TMenuItem;
    Hide_menu: TMenuItem;
    Hide_text: TMenuItem;
    Hide_icons: TMenuItem;
    ColorDialog0: TColorDialog;
    Milkywaytoolbutton: TToolButton;
    Milkyway_onoff: TMenuItem;
    Earthtoolbutton: TToolButton;
    earth_onoff: TMenuItem;
    animatetoolbutton: TToolButton;
    Animation_onoff: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Zenith1: TMenuItem;
    procedure alpaca1Connect(aSocket: TLSocket);
    procedure alpaca1Disconnect(aSocket: TLSocket);
    procedure alpaca1Error(const msg: string; aSocket: TLSocket);
    procedure alpaca1Receive(aSocket: TLSocket);
    procedure date_and_time1Click(Sender: TObject);
    procedure date_and_time1MouseEnter(Sender: TObject);
    procedure DayF7Click(Sender: TObject);
    procedure dss_blue1Click(Sender: TObject);
    procedure dss_red1Click(Sender: TObject);
    procedure dss2_blue1Click(Sender: TObject);
    procedure dss2_infrared1Click(Sender: TObject);
    procedure dss2_red1Click(Sender: TObject);
    procedure editobject1Click(Sender: TObject);
    procedure mouseposition1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure image_clock1click(Sender: TObject);
    procedure Image_clock1MouseEnter(Sender: TObject);
    procedure Image_north1Click(Sender: TObject);
    procedure Image_starscale1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure IN1Click(Sender: TObject);
    {$ifdef fpc}
    procedure indi_client1Click(Sender: TObject);
    procedure home1Click(Sender: TObject);
    procedure loadevent1Click(Sender: TObject);
    procedure export_frames_via_server1Click(Sender: TObject);
    procedure clearvisibledownload1Click(Sender: TObject);
    procedure movelines1Click(Sender: TObject);
    procedure OpenDialog1Close(Sender: TObject);
    {$else} {delphi}
    {$endif}
    procedure park1Click(Sender: TObject);
    procedure right1Click(Sender: TObject);
    procedure right7Click(Sender: TObject);
    procedure SaveDialog1Close(Sender: TObject);
    procedure setpark1Click(Sender: TObject);
    procedure OUT1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Printwindowblacksky1Click(Sender: TObject);
    procedure Printwindowwhitesky1Click(Sender: TObject);
    procedure Savesettings1Click(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure settings1Click(Sender: TObject);
    procedure Showstatusbar1Click(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure Enterdatetime1Click(Sender: TObject);
    procedure NowF9Click(Sender: TObject);
    procedure telescope_synctomouse1Click(Sender: TObject);
    procedure Timer_delayed_start_serverTimer(Sender: TObject);
    procedure tracking1Click(Sender: TObject);
    procedure Usesystemtime1Click(Sender: TObject);
    procedure Tonight1Click(Sender: TObject);
    procedure Fliphorizontal1click(Sender: TObject);
    procedure Flipvertical1Click(Sender: TObject);
    procedure Constellations1Click(Sender: TObject);
    procedure Boundaries1Click(Sender: TObject);
    procedure Showmoonorbits1Click(Sender: TObject);
    procedure Deepskycontoursonly1Click(Sender: TObject);
    procedure Orthographic_projection1Click(Sender: TObject);
    procedure Azimuthalequidistant1Click(Sender: TObject);
    procedure Copywindowtoclipboard1Click(Sender: TObject);
    procedure Databases1Click(Sender: TObject);
    procedure GotoRADEC1Click(Sender: TObject);
    procedure cometdataeditorClick(Sender: TObject);
    procedure AsteroiddataeditorClick(Sender: TObject);
    procedure GridRADEC1click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Showclock1Click(Sender: TObject);
    procedure SupplementeditorClick(Sender: TObject);
    procedure Objecthints1Click(Sender: TObject);
    procedure Objects1Click(Sender: TObject);
    procedure Measuringframe1Click(Sender: TObject);
    procedure deepskyobservations1Click(Sender: TObject);
    procedure Darknights1Click(Sender: TObject);
    procedure Pointingcircles1Click(Sender: TObject);
    procedure Twolinesnorthsouth1Click(Sender: TObject);
    procedure Pointingcirclemarker1Click(Sender: TObject);
    procedure Nameofobjectmarker1Click(Sender: TObject);
    procedure GridAZAlt1Click(Sender: TObject);
    procedure Objectinfotoclipboard1Click(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure Northabove1Click(Sender: TObject);
    procedure Starscale1Click(Sender: TObject);
    procedure Northarrow1Click(Sender: TObject);
    procedure InsertFITSimage1Click(Sender: TObject);

    procedure connect_telescope1Click(Sender: TObject);
    procedure import_from_ascom(Sender: TObject);

    procedure Enterdatetime1buttonClick(Sender: TObject);
    procedure zenith1Click(Sender: TObject);
    procedure north1Click(Sender: TObject);
    procedure South1Click(Sender: TObject);
    procedure east1Click(Sender: TObject);
    procedure West1Click(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure telescope_abort1Click(Sender: TObject);
    procedure MinF3Click(Sender: TObject);
    procedure MinF4Click(Sender: TObject);
    procedure HourF5Click(Sender: TObject);
    procedure HourF6Click(Sender: TObject);

    procedure DayF8Click(Sender: TObject);
    procedure N2356F11Click(Sender: TObject);
    procedure N2356F12Click(Sender: TObject);
    procedure SolarsystemtonightClick(Sender: TObject);
    procedure markmousepos(Sender: TObject);
    procedure Magnitudeofobjectmarker1Click(Sender: TObject);
    procedure load_fits1Click(Sender: TObject);
    procedure Dateandtimemarker1Click(Sender: TObject);
    procedure Clearmarkers1Click(Sender: TObject);
    procedure Centreon1Click(Sender: TObject);
    procedure Simbad1Click(Sender: TObject);
    procedure HyperLeda1Click(Sender: TObject);
    procedure Ned1Click(Sender: TObject);
    procedure get_ESO1Click(Sender: TObject);
    procedure Telescopetomouseposition1Click(Sender: TObject);
    procedure Linestart1Click(Sender: TObject);
    procedure LinestartAzALT1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Get_Skyview1Click(Sender: TObject);
    procedure Cleardownload1Click(Sender: TObject);
    procedure get_mast1Click(Sender: TObject);
    procedure tracktelescope1Click(Sender: TObject);
    procedure Followsolarobject1Click(Sender: TObject);
    procedure Sidereal1Click(Sender: TObject);
    procedure Polarscopeview1Click(Sender: TObject);
    procedure Deleteonlinecache1Click(Sender: TObject);
    procedure Undoview1Click(Sender: TObject);
    procedure Redoview1Click(Sender: TObject);
    procedure ToolBar2CustomDrawButton(Sender: TToolBar; Button: TToolButton;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure OnoffClick(Sender: TObject);
    procedure toolbutton_menuClick(Sender: TObject);
    procedure PopupMenu_menubar1Popup(Sender: TObject);
    procedure menu_ColorClick(Sender: TObject);
    procedure Cylindrical1Click(Sender: TObject);
    procedure Hide_menuClick(Sender: TObject);
    procedure Internal1Click(Sender: TObject);
    procedure Hide_textClick(Sender: TObject);
    procedure Earth1Click(Sender: TObject);
    procedure MilkyWay1Click(Sender: TObject);
    procedure Deletelastpoint1Click(Sender: TObject);
    procedure hidelines1Click(Sender: TObject);
    procedure Colorchange1Click(Sender: TObject);
    procedure Removelines1Click(Sender: TObject);
    procedure Insertlines1Click(Sender: TObject);
    procedure statusbar1MouseEnter(Sender: TObject);
    procedure statusbar1Click(Sender: TObject);
    function FormHelp(Command: Word; Data: NativeInt;
      var CallHelp: Boolean): Boolean;
    procedure Animation1Click(Sender: TObject);
    procedure Drawsolarobjecttracks1Click(Sender: TObject);
    procedure Crosshair1Click(Sender: TObject);
    procedure ToolBar2MouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);


   {$IFDEF fpc}
    procedure LTCPComponentConnect(aSocket: TLSocket);
    procedure LTCPComponentError(const msg: string; aSocket: TLSocket);
    procedure LTCPComponentAccept(aSocket: TLSocket);
    procedure LTCPComponentReceive(aSocket: TLSocket);
    procedure LTcpComponentDisconnect(aSocket: TLSocket);
   {$ELSE} {delphi}
   {$ENDIF}
    private { Private declarations }
    procedure SendToAll(const aMsg: string);
  public
    { Public declarations }
    procedure update_menu;
    procedure maakplaatje(canvas2:tcanvas;polarscope:boolean);
    procedure DisplayHint(Sender: TObject);

  end;


procedure paint_sky;{redraw the sky}
Procedure loaddeep; {for hns_uset}
procedure loadsupplement1;
procedure loadsupplement2;
procedure loadsupplement3;
procedure loadsupplement4;
procedure loadsupplement5;
procedure loadtoast;
procedure delete_penbrush;
procedure prepare_penbrush;
procedure setdefaultcolors;
procedure negative;
procedure Copytoclipboard(formX:Tform);{copy the canvas from a form to the clipboard}
procedure inverse_intensity_color(incolor:integer;var outcolor:integer);{keep color=hue but inverse intensity. By han Kleijn}
procedure selectfont1(dc:tcanvas);
procedure selectfont2(dc:tcanvas);
procedure selectfont3(dc:tcanvas);
procedure selectfont4opaque(dc:tcanvas;color1:integer);
procedure selectfont4transparent(dc:tcanvas;color1:integer);
procedure selectfontgreek(dc:tcanvas;color1:integer);

Procedure open_link(link:string);{Open link, openurl works with anchors}
Procedure open_file(link:string);{Open file. Doesn't work for parameters}
procedure open_file_with_parameters(filelink,parameters2:string);{does work for parameters}
procedure update_button_hints;{copy mainmenu hints and objectmenu hints to buttons}
procedure load_cursors;
function DownloadFile(SourceFile, DestFile: string): Boolean;{2013, download files from internet}
procedure loadcomet;{2013}
procedure loadasteroid;{2013}

Function double_to_string_4digit_max(w : double) : String;{to string with 4 decimals but remove last zeros}

procedure read_deepsky(searchmode:char);{deepsky database search}
procedure plot_pixel_sphere(dc:tcanvas; ras,decs : double;size,color2,ostyle,loadhint :integer);

procedure getdatetime(gtime,tonight:boolean);

procedure zoom_in(factor:double);
procedure zoom_out(factor:double);

procedure inctime2(step2:double);

procedure marker_telrad2(dc:tcanvas;ra11,dec11:double;font7:integer );
procedure marker_name2(dc:tcanvas;ra11,dec11:double;font7:integer;nam:string);

procedure write_info(dc:tcanvas{;schrijf:boolean});
function find_object(dc:tcanvas;searchmode:char):boolean;

procedure mouse_radec(dc:tcanvas;xm,ym: integer;var raok,decok:double); {find mouse position with sort routine}
procedure plot_earth(dc:tcanvas);
procedure plot_info(dc2:tcanvas);
procedure plot_grid(dc1:tcanvas);

procedure max_star_magnitude;
function select_primary_or_secondary_catalogue(stardatabase_selected2:integer):integer;{when to switch from primary to secondary star catalogue based on zoom and catalogue}
procedure plot_PLANETS2(moon:boolean;dc:tcanvas);{planets}
procedure plot_COMETS(dc:tcanvas);
procedure read_comet(searchmode:char);

procedure plot_ASTEROIDS(dc:tcanvas);
procedure read_asteroid(searchmode:char);{asteroid database search}

procedure plot_supplement(dc:tcanvas;sup:integer);
procedure read_supplement(searchmode:char;sup:integer);{supplement database search}
procedure plot_deepsky(dc:tcanvas);
procedure plot_star_scale; {plots magnitude index}
procedure plot_stars(dc:tcanvas);
procedure plot_stars_290(dc:tcanvas);

procedure PLOT_UCAC4STARS(dc:tcanvas);

procedure PLOT_onlineSTARS(dc:tcanvas);

function plot_fits(canvas2:tcanvas;filen:string): boolean;{load fits file}

Function Minmax(x,min2,max2:double):double;{Limit x to min and max}
procedure get_fits(canvas2:tcanvas; searchstr: string);
procedure textout_center_aligned(dc :tcanvas;x1,y1:integer;text1:string); {write text right aligned}
procedure textout_right_aligned(dc :tcanvas;x1,y1:integer;text1:string); {write text right aligned}

procedure export_to_telescope(ra5,dec5 :double); {export position to telescope}
procedure connect_telescope(Sender: TObject);{connect to telescope driver}
procedure update_telescope_menu(on1: boolean);
procedure canvas_object_message(question: string;color1:tcolor); {if nothing is found}
procedure canvas_field_message;{after screen refresh}

procedure canvas_error_message(text1:string);{error message to canvas}

function switch_server_onoff(on1: boolean):boolean; {server host for remote control via TCP/IP}

procedure alpaca_send_http_get(mess: string);{send a http GET to Alpaca}
procedure alpaca_send_http_put(mess,param: string);{send a http PUT to Alpaca}

procedure switch_alpaca_client_onoff(on1: boolean); {client on/off for Alpaca remote control http via TCP/IP}

function remove_rectangle(label_name:string) : string;{remove rectangle with name from suplement 2, if name is blank remove last rectangle}
function StripHotkey(const Text: string): string;{remove &}

procedure set_dds_bandpass_menu;


const
   {$IFDEF fpc}
     {PathDelim is standard available}
  help_path      : string='.'+PathDelim+'help'+PathDelim+'uk'+PathDelim+'hnsky.htm';
  path_ucac4     : string    =PathDelim+'ucac4'+PathDelim;
  dss_mask       : string    ='.'+PathDelim+'fits'+PathDelim+'*.fit*';
  extra_fits_file: string    ='';{allow one extra fits file outside the dss_path}
  de430_file     : string    ='lnxp2000p2050.430';
  de431_file     : string    ='lnxm13000p17000.431';


  {$else} {delphi}
  PathDelim: string='\';
  help_path  : string='.\help\uk\hnsky.htm';
  path_ucac4   : string    ='\ucac4\';
  dss_mask     : string    ='.\fits\*.fit*';
  {$endif}

  crnormalcursor :integer=70;
  crnormalcursor2:integer=71;
  crwaitCursor   :integer=72;
  crcursorright  :integer=73;
  crcursorleft   :integer=74;
  crcursorup     :integer=75;
  crcursordown   :integer=76;
  crcursor_draw  :integer=77;{drawing mode}
  crcursor_tel   :integer=87; {telescope point to option }
  crcursor_hand  :integer=88;


  internetlink      :string='';
  export_frames     : boolean=false;{mosaic frames}
  printing          : boolean=false;
  line_drawing_mode : boolean=false;
  showPlottime      : boolean=false;

  name_supl1     : string ='';{allow a little longer then 12 charactors example hns_sup1test.hns}
  name_supl2     : string ='';
  name_supl3     : string ='';
  name_supl4     : string ='';
  name_supl5     : string ='';
  name_toast     : string ='';
  name_com1      : string[12] ='hns_com1.cmt';
  name_ast1      : string[12] ='hns_ast1.ast';

  ascom_driver    : widestring ='ASCOM.Simulator.Telescope';
  Ascom_mount_capability:integer=0; {2= async slew, 1 slew, 0 no slew}

  INDI_telescope_name  : string ='';
  telescopeTekst : string ='telescope';
  telescope_interface: string='A'; {A=Ascom or I for INDI}
  INDI_server_address : string='localhost';
  INDI_port           : string='7624';
  indi_server_connecting  : boolean=false;{server connecting?}
  indi_server_connected  : boolean=false;{server connected?}
  indi_telescope_connected: boolean=false;{telescope connected?}
  SERVER_port           : string='7700';
  server_address        : string='localhost' ;
  server_on: boolean=true;

  timestep       : integer=5; {minute steps before update}
  northtop       : integer=0; {v3 0 2 on changed to1 instead of 0}
  old_northtop2  : integer=0;
  magscale       : integer=1;
  northarrow     : integer=1;
  cursorT        : integer=0;
  hide_mainmenu  : integer=1;{0 is hide, 1 is visible all the time. Use as multiplier in height calculation}
  hide_mainmenu_text  : integer=0;{1 is hide, 0 is visible all the time.}
  mouse_wheel_reverse : integer=0;
  moon_covers_stars : integer=1;
  earth_covers_stars : integer=1;
  azimuth_degrees: integer=0;{displaying degrees?}
  zoom_show_DSS  : integer= 4;{at wich zoom factor show deep sky, Adjusted by EarlyFITS}
  dss_bandpass   : integer=35; {dss2 red}

  z_length       = 21;
  z_buffer       : array[0..z_length,1..3] of single =(
                                                       (0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),
                                                       (0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,0,0)
                                                      );

    z_position     : integer=-1;
  bar_hint       : string=''; {short abbreviation buffer}
  disabled_mess : string=  'DISABLED: ';
  font_charset : integer=0; {Ansi_char}
  font_style : tFontStyles=[fsUnderline];
  font_name    : string='Arial';

  {$IFDEF unix}
  about_title  : string= 'About HNSKY for Linux:';
  {$ELSE}
  about_title  : string= 'About HNSKY for Windows:';
  {$ENDIF}

  about_message0 :string=
             'Hallo_Northern_SKY is © 1998, 2020 by Han Kleijn, license GPL3+, www.hnsky.org'+
     #13+#10+
     #13+#10+'Version 4.1.21, dated 2020-9-29';


  about_message1 :string=
     'Send a message if you like this free program.';
  about_message2 :string=
     'Feel free to distribute!';
  about_message3 :string=
     'Han.k@hnsky.org';
  about_message4 :string='';{spare in ini file}
  about_message5 :string='Current map time is';

  polarview: string='Polar alignment scope view';
  selected_databases :string= 'SELECTED DATABASES:';
  stardatabase_displayed_naam : string='';

  tip_of_day_header :string= 'Tip of every day';

  new_user_title : string= 'New user';
  new_user1 : string= 'To get correct results, it is important to enter your geographical location and time zone.';
  new_user2 : string= 'For this:';
  new_user3 : string= '1) Select menu FILE, submenu SETTINGS and enter your coordinates on earth and time zone.';
  new_user4 : string= '2) Select menu FILE and then submenu SAVE STATUS.';

  not_found    : string= 'not found !!';
  deepsky_file : string= 'Deepsky database file';
  error_string : string='Error';
  not_available: string='Not available !';

  open_status_title: string='Open status:';
  open_event_title : string='Open event:';
  open_fits_title : string='Open FITS image file';
  save_status_title: string='Save status as:';
  to_go_right: string='To go right, click on left mouse button.';
  to_go_left: string='To go left, click on left mouse button.';
  to_go_up: string='To go up, click on left mouse button.';
  to_go_down: string='To go down, click on left mouse button.';
  Limiting_magn:string='Limiting magnitude';
  days_plot_string:string='days plot';
  Delete_question_string:string='Are you sure you want to delete all cache of the online GAIA, UCAC4, Nomad and URAT catalog?';
  Delete_question_string_dss:string='Are you sure you want to delete all?';

  tcp_conn_accept_string:string='TCP/IP host: Connection accepted';
  tcp_conn_lost_string:string='TCP/IP host: Connection lost';
  tcp_online_string:string='TCP/IP host: Accepting connections';
  tcp_offline_string:string='TCP/IP host off line';
  searching_string:string='Searching for:';
  alpaca_conn_lost_string:string='Alpaca: <=//=>';
  alpaca_connection_string:string='Alpaca: <==>';
  alpaca_communication_counter : integer=0;

  linepoint_counter:integer=0;{number of point drawn}
  sep_width:double=0;
  sep_height:double=0;
  old_telescope_ra     : double=0;
  old_telescope_dec    : double=0;
  telescope_position  : string='';{ascom position}
  drive_status        : string='';{drive and  refresh status}
  polarscope_visible  : boolean=false;
  undo_used           : boolean=false;
  swipe_mode          : integer=0; {swiping}

  limitdeepbrightcolor=120; {this one is used to go back to default}
  limit_deep_bright_color   : integer= limitdeepbrightcolor; {color deepsky object bright up to this brightness}
  limitdeepmediumcolor=130; {this one is used to go back to default}
  limit_deep_medium_color   : integer=limitdeepmediumcolor;
  Click_to_copy_string      : string='<=click to copy into clipboard';
  star_colouring: integer=1;
  local_decimalseparator: char='.';

  inverse : boolean=false; {colors made inverse ???}
  searchmenutop:integer=100;
  searchmenuleft:integer=100;
  objectmenutop:integer=120; {position objectmenu, keep below ra/dec indication otherwise repaint, why ????}
  objectmenuleft:integer=1;
  stars_external_index:integer=1;{which external database is selected}
  datemenutop:integer=100;
  datemenuleft:integer=400;
  gotomenutop:integer=100;
  gotomenuleft:integer=200;
  animationtop:integer=300;
  animationleft:integer=1;

  ascomcursorcounter : integer=9;{blinker ascom cursor}
  done_tracks :boolean=true;

  year2  : integer=1900; {date variable. Give value to prevent run time error when starting without default.hns}
  overflow: boolean=false;
  zoom    : double=0.9/(pi/2);
  scrollsize =pi/12;
  bold     : integer=0;{variable for stars ticknes}
  naming: integer=90;{deepsky from wich mag*10 do they get names}
  deep     : integer=100;{how many deepsky is shown}
  deepsky_level: integer=1; {[1..3]}
  position_deep2: integer=999999999;
  position_deep3: integer=999999999;
  planetnr : integer=-1; {which planet is found}

  reallatitude : double =50;
  longitude: double   =0;
  timezone : double   =0;
  apparent_horizon : double= (- 34.5/60)*(pi/180);{34.5 minutes. this factor is used for exact horizon plotting}
  daylight_saving:integer=0;
  dst_auto: boolean=false;{day light saving on auto mode for USA and european timezones}
  Time_Reference : string='UTC';
  parallax2: integer=1; {correct parallax error ?}
  grid     : integer=1;
  boundaries:integer=-1;
  milkyway: integer=-1;
  earth   : integer= 0;
  constellat: integer=-1;

  flipv    : integer=1;
  fliph    : integer=1;
  NORTH    : integer=1;
  sidereal : integer=0;
  find_solareclipse: integer=0;
  viewx    : double=pi; {Zenith in equidistant}
  viewy    : double=pi/2;
  projection  :integer=1;
  missedupdate:integer=2;
  menu_changed : boolean=true;
  actualtime   : boolean=false;
  hour2 : integer=24;
  min2  : integer=0;
  viewch        : boolean=false;
  hns_keydown:integer=0;

  down_x: integer=0;{2018 move image1}
  down_y: integer=0;

  richting2: array[0..8] of string =('N','NE','E','SE','S','SW','W','NW','N');
  richting: array[0..16] of string{pchar} =('  N','NNE',' NE','ENE','  E','ESE',' SE','SSE','  S','SSW',' SW','WSW','  W','WNW',' NW','NNW','  N');

  found       : integer=0;
  telescope_follow_solar: integer=0; {if<>0 then telescope follows solar object}
  equinox     : integer = 2000;
  equinox_telescope  : integer = 0;
  de430_emphemeris:integer=0;{use or not}
  de430_loaded:boolean=false;

  cross       : integer=0;
  mframe      : integer=0;
  show_orbit  : integer=0;
  namest      : integer=1;{0 bright internal only, 1=external stars, 2 all}
  contour_only: integer=1;
  fits_insert : integer=0;
  action2      : integer=0;
  density      : double=0;  {density of stars on screen -50 to +50}
  statusbarfree: boolean=true;
  mousewheel_used:boolean=false;

  spectral : array[0..1,0..15] of ansichar=(('0','1','2','3','4','5','6','7','8','9','A','B','C','E','+',' '),
                                           ('O','B','A','F','G','K','M','R','N','S','C','W','P','Q','+',' '));
  deep_database  : integer=1;
  stardatabase_selected: integer=0;
  suppl1_activated:integer=0;
  suppl2_activated:integer=0;
  suppl3_activated:integer=0;
  suppl4_activated:integer=0;
  suppl5_activated:integer=0;
  toast_activated:integer=0;
  comets_activated:integer=1;
  asteroids_activated:integer=1;
  planets_activated:integer=1;
  plot_moon_movement: integer=1;
  tracks2           : integer=0;
  stars_activated: integer=1;
  fits_file_open    : integer=0;
  stardatabase_open : integer=0;
  name_deep         : string='deep_sky.hnd';
  name_star         : string='ppm_hsky.dat'; {name star database}
  vizier_server     : string='vizier.u-strasbg.fr'; {location online databases}

  sun_string     : string='Sun';
  moon_string    : string='Moon';
  moon_string2   : string='Luna';
  Mercury_string : string='Mercury';
  Mercury_hint   : string='Planet';
  Venus_string   : string='Venus';
  Venus_hint     : string='Planet';
  Mars_string    : string='Mars';
  Mars_hint      : string='The red planet';
  Jupiter_string : string='Jupiter';
  Jupiter_hint   : string='The largest planet of our solar system.';
  Saturn_string  : string='Saturn';
  Saturn_hint    : string='The planet with the famous rings.';
  Uranus_string  : string='Uranus';
  Uranus_hint    : string='Gas planet';
  Neptune_string : string='Neptune';
  Neptune_hint   : string='Gas planet';
  Pluto_string   : string='Pluto';
  Pluto_hint     : string='Kuiper belt object or very small planet.';

  Moon_of_string : string='Moon of';

  Charon_string  : string='Charon';
  Triton_string  : string='Triton';

  Ariel_string   : string='Ariel';
  Umbriel_string : string='Umbriel';
  Titania_string : string='Titania';
  Oberon_string  : string='Oberon';

  Mimas_string   : string='Mimas';
  Enceladus_string : string='Enceladus';
  Tethys_string  : string='Tethys';
  Dione_string   : string='Dione';
  Rhea_string    : string='Rhea';
  Titan_string   : string='Titan';
  Hyperion_string: string='Hyperion';
  Iapetus_string : string='Iapetus';

  IO_string      : string='Io';
  Europa_string  : string='Europa';
  Ganymede_string: string='Ganymede';
  Callisto_string: string='Callisto';

  Phobos_string  : string='Phobos';
  Deimos_string  : string='Deimos';

  Asteroid_string : string='Asteroid';
  Comet_string    : string='Comet';
  Star_string     : string='Star';
  Galaxy_string   : string='Galaxy';
  Blend_string    : string='Blend';
  Double_string   : string='Double *';

  non_Star_string : string='Non-star';
  artifact_string : string='Potential artifact';

  Field_string    : string='Field:';
  RA_string       : string='α:';
  DEC_string      : string='δ:';
  Az_string       : string='A:';{Az}
  Alt_string      : string='h:';{Alt}
  App_string      : string='app:'; {app position}
  mean_string     : string='mean:';{mean position}
  Name_string     : string='Name:';
  Magn_string     : string='Magn.:';
  Size_string     : string='Size:';
  Size2_string    : string='Size["]:';
  Type_string     : string='Type:';
  Rise_string     : string='↑';
  Set_string      : string='↓';
  above_string    : string='Always above horizon';
  below_string    : string='Always below horizon';
  Phase_string    : string='Phase [%]:';
  Ringopn_string  : string='Ringopn.:';
  Dist_string     : string='Dist. [au]:';
  Sun_dist_string : string='Sun_dist.:';
  Brightn_string  : string='Brightn.:';
  Spectral_string : string='Spectral:';
  earth_shadow_string : string='EARTH SHADOW';
  tracking_string : string='tracking';
  sidereal_string : string='sidereal view';
  terrestrial_string : string='terrestrial view';
  refresh_rate_string : string='refresh rate is';
  follow_string   :string='Follow';
  Meridian_string   :string='Meridian:';

  clock        : integer=1;
  hints        : integer=1;

  indexcounter:integer=0;  {for win95 hints of objects}
  buffersize          =12*1024;{win95 hints buffersize}

  frame_width  : double=60;{ccd frame}
  frame_height : double=40;
  frame_angle  : integer=90;{equivalent to PA deepsky}
  limitmagn    : double=20.0;
  min_size_deep: double=0;
  filtertype   : string='';
  telrad       : array[1..5] of double=(4,2,0.5,0,0);{telrad diameters}
  marker_telrad: integer=0; {found object marker type}
  marker_name  : integer=0; {found object marker type}

  dss_background: integer=0;{dss background and brightness}
  dss_brightness: integer=0;
  follownaam2   :  string=''; {telescope follows this object}
  locknaam2     :  string=''; {animation, follow this object}
  deepskyhelpnaam2 :  string='begin';{go to the begin deepsky.htm if no found  object has been put in this string}
  cut_position  :  integer=0;{line cut away}
  label_all_lines: boolean=false;
  stars_external_hint  : array[-1..6] of string=('',{-1 to prevent untracable compiler error if it jumps to default -1}
                                                 '',
                                                 'UCAC4 star catalogue, local copy.',
                                                 'UCAC4 online catalogue from http://vizier.u-strasbg.fr/doc/asu-summary.htx',
                                                 'NOMAD online catalogue from http://vizier.u-strasbg.fr/doc/asu-summary.htx',
                                                 'URAT online catalogue from http://vizier.u-strasbg.fr/doc/asu-summary.htx',
                                                 'GAIA online catalogue from http://vizier.u-strasbg.fr/doc/asu-summary.htx',
                                                 'PPMXL online catalogue from http://vizier.u-strasbg.fr/doc/asu-summary.htx');


  nr_markers             : integer=0;{number of telrads, names}
  markers_position       : integer=0;
  max_markers =25;
  old_day2:integer=0;{for time stamp solar objects}
  old_month2:integer=0;{for time stamp solar objects}
  old_naam2             :string{[100]}=' ';
  nr_records            : integer=0;{initialise with at least 0}
  found_mode            : integer=9999;{where was object found}

  star_size:array[-124..35] of byte=
  (100,100,100,100,100,100,100,100,100,100,
   66,66,66,66,66,66,66,66,66,66,
   50,50,50,50,50,50,50,50,50,50,
   25,25,25,25,25,25,25,25,25,25,
   19,19,19,19,19,19,19,19,19,19,
   15,15,15,15,15,15,15,15,15,15,
   12,12,12,12,12,12,12,12,12,12,
   09,09,09,09,09,09,09,09,09,09, {-55 -45}
   07,07,07,07,07,07,07,07,07,07, {-46 -35}
   06,06,06,06,06,06,06,06,06,06, {-36 -25}
   05,05,05,05,05,05,05,05,05,05, {-26 -15}
   04,04,04,04,04,04,04,04,04,04, {-16 -05}
   03,03,03,03,03,03,03,03,03,03, {-06  05}
   02,02,02,02,02,02,02,02,02,02,  {06  15}
   01,01,01,01,01,01,01,01,01,01,  {16  25}
   00,00,00,00,00,00,00,00,00,00); {26  35}

  field_factor=360*60/pi; //640*12*0.9;{for size of field and so on}
  telrad_factor=6/field_factor;

  jovian_moon_name : array[1..4] of string=('I','II','III','IV');
  jovian_moon_fits : array[1..4] of string=('map_io.fit','map_europa.fit','map_ganymede.fit','map_callisto.fit');
  grs_offset : integer=0;{offset grs, great red spot jupiter}

  found_ra2 : double=0;{for supplement edit, make zero for GET_TARGET requests}
  found_dec2: double=0;
  found_name: string='none'; {make something for GET_TARGET requests}

type
   image_array = array of array of array of single;
var
  img_loaded : image_array;  {for plot_fits}

  jovian_distance  : array[1..4] of double; {distance jovian moons=(6.0,6.1,6.2,6.3);}
  jovian_moon_sequence : array[1..4] of integer; {sequence of plot {=(1,2,3,4);}

  mainwindow: Tmainwindow;
  RRW :  trect; {onthoudt groote of window}
  pen0,pen1,pen_green,pen_blue, pen11,penNS,pen_horizon,pen_below_horizon,
  pen2,pen3,pen4, {deepsky}
  pen2_dotted,pen3_dotted,pen4_dotted, {deepsky OC}
  PENS,penmoons,pen_ecliptic,pen_milkyway,pen_bound,
  penplanet1,penplanet2,penplanet3,penplanet4,pencomet,penasteroid,pen_crosshair  : hpen;{thandle geeft problemen in fpc 64 bit}
  pen_dss, pen_dss_blue: array[0..255] of hpen;
  brush0,brushb,brushdeepsky2,brushdeepsky3,brushdeepsky4,brushdeepsky2G,brushdeepsky3G,brushdeepsky4G,
  brushmoons,brushgreen,brushred,brushplanet1,brushplanet2,brushplanet3,brushplanet4,brushCOMET,brushmainmenu : hbrush;
  brush_dss,brush_dss_blue: array[0..255] of Hbrush;

  colors :array [0..41] of integer; {object colors}
  colorsinverse :array [0..41] of integer; {object inversed colors}
  inverse_printing : boolean;
  links,
  line0_y,line1_y, north_xpos,north_ypos,north_leng,
  {riseset_height,}
  middle_x,middle_y,half_height,work_height,work_width :integer;

  meridian_pass, cometfile_age, asteroidfile_age, filename: string;

  Bitmap2  : TBitmap;{for fast repaint routine}
  {$IFDEF fpc}
  PNG: TPortableNetworkGraphic;{FPC}
  {$ELSE}
  PNG: TPNGObject;{Delphi for TOAST projection}
  {$ENDIF}

  julian_UT, julian_ET,old_julian_et, julian_local  : double; {julian day, julian day correct with delta_T to get dynamic time}
  equinox_date       :double; {epoch current date}
  TheFile_fits       : tfilestream;
  Reader_fits        : TReader;
  newtime,oldtime    : dword;

  f     : text;
  fromf : file;

  wtime2, wtime2actual,{ROTATION POSITION EARTH}
  ra2,dec2,azimuth2,altitude2,length2,mag,delta,sun_delta,
  planet_crota,mouse_ra, mouse_dec,  orientation2,width2,
  telescope_ra,telescope_dec,cos_telescope_dec,telescope_height,  telescope_width,phase,phi,
  planet_mag,planet_dia, dummy, sun_x9,sun_y9,
  pluto_ra, pluto_dec,neptune_ra, neptune_dec,uranus_ra, uranus_dec,saturn_ra,saturn_dec,jupiter_ra,jupiter_dec, mars_ra, mars_dec,
  app_horizon,ra_const,dec_const, chart_orientation, popupmouse_ra, popupmouse_dec,
  sin_latitude2,cos_latitude2,sin_viewx, cos_viewx, sin_viewy, cos_viewy,sin_latitude,cos_latitude,
  ra_celestial_pole,dec_celestial_pole                                                                  : double;

  mode, mx,my,mag2,brightn,bp_rp, boldfactor,  onlinefieldcounter, stardatabase_displayed,image_overlap            : integer;

  naam2,naam3, naam4                  : string;
  magn_text,ra_text,dec_text          : string;
  spectr,descrip2                     : string;
  type2                               : string;
  ucac4_info,tempstr                  : string;

  bufferold : packed record
                ddd      : array[0..100] of ansichar;
                center   : boolean;
                autozoom : boolean;
              end;

  goto_str          : string;
  auto_center       : boolean;
  auto_zoom         : boolean;
  slewto            : boolean;

  linepos, lineposcatalog   : integer;
  worldmap     : boolean; {is supplement worldmap}

  deepstring,cometstring ,asteroidstring,supplstring1,supplstring2,
  supplstring3,supplstring4,supplstring5, catalogstring,foundstring1 : Tstrings;
  editfile    : integer; {which file in editor}
  update_mag  : boolean; {update magnitude of asteroids at end of line due to change in date. See getdatatime and read asteroid procedure}
  dss_path,dss_search  : string;{fits path}
  documents_path       : string;{my documents of documents}
  cache_path           : string;{my documents of documents}
  application_path     : string;{application path}

  today2, today2_UTC   : string;
  month2, day2, dow    : integer; {date variables}
  sec2,         hund   : integer;  {hour sec ..}
  x9,y9: longint; {where plot pixel}
  zc   : integer; {in sight, within range of screen plot}
  file_open  :byte;
  latitude,latitude2   : double; {latitude in degrees and radialen}
  zoomh,zoomv          : double;
  new_user             : boolean;
  redrawing            : boolean; {busy with redrawing}
  found_descrip2,found_type2    :  string;{for line draw and supplement edit}
  found_mag2, found_brightn, found_length2, found_width2,found_orientation2 : double; {for supplement edit}


  index                : array[0..1,0..buffersize] of word;
  names                : array[0..buffersize] of string[12+14]; {for name hints and 2016 track dates +14=", 01-12  24:00"}
  magnitudes           : array[0..buffersize] of single;
  maxmag               : double;
  font_height1         : integer; {font1 size in pixels}
  font_height2         : integer; {font2 size in pixels}
  font_height3         : integer; {font2 size in pixels}
  font_height4         : integer; {font4 size in pixels}
  font_width4          : integer; {font4 size in pixels}
  font_height_greek    : integer;
  half_font_width_greek: integer;
  font_width2          : double; {average font width}
  square_x_step,square_y_step:integer;{for square potting of FITS}

  markers :            packed record
                          ra    : array[0..max_markers] of double;
                          dec   : array[0..max_markers] of double;
                          mode  : array[0..max_markers] of integer;{mode=0 no telrad, 1 telrad, -2 move to, 1 line  to}
                          font  : array[0..max_markers] of integer;
                          name  : array[0..max_markers] of string;
                        end;


implementation

{$IFDEF fpc}
  {$R *.lfm}
{$ELSE} {delphi}
  {$R *.lfm}
{$ENDIF}

{$R hns_cursors_fpc.res} {for cursors and icons, contains one multi icon with 16x16,32z32,48x48,64x64, make multi icon with green fish icon editor and add to RES using resource hacker}

uses
hns_Uast,hns_Ucon,hns_Upla,hns_Uset, hns_Utim, hns_Ugot, hns_Ucen, hns_Uobj,
hns_Usno,hns_Uedi, hns_Udrk, hns_Usol, hns_Unon, hns_Upol, hns_Utxt, hns_Uani, hns_fast,
hns_U290, hns_uDE, hns_Uprs, hns_Uinp
{$IFDEF fpc}
,hns_indi, hns_Userver, hns_alpaca
{$ELSE} {delphi}
{$ENDIF}

{$ifdef mswindows}
{$else} {unix}
,hns_Udownload
{$endif}
;

const
  sizing_factor=field_factor*20;  {360*60*2*10/pi}
  colorwritten2:int64=0;{for telescope_cursor erase, rewrite}
  if_below_return_view=3;

  {$ifdef mswindows}
   default_hns ='default.hns';
  {$else} {unix}
   default_hns ='default_hnsky.hns';
  {$endif}

   alpaca_connected: boolean=false;
var
   ascom_mount           : variant; {für ascom, telescope}

   {for mousemove}
   oldy,oldx,startx,starty,centerx,centery,size_pulled_rectangle,old_frame_angle  :integer;
   min_size2, viewx1,viewy1 :double;

   movept: tpoint;{for ascom telescope_cursor}
   oldmovept: tpoint;{for ascom telescope_cursor}
   oldorientation : double;{for telescope cursor}

   startTick  : DWord;{for timing/speed purposes}
   deltaticksS,deltaticksD,deltaticksA : DWord;

   fastbitmap1:tfastbitmap;{fast bitmap in unit hns_fast}

   Gmag, BPmag, RPmag: string[8]; {for online Gaia}
   magG, magBP, magRP: double;


procedure AngleTextOut_center_alligned(ACanvas: TCanvas; Angle:single; X1, Y1: Integer; Text1: string);{turned text}
var
  NewFontHandle,
  OldFontHandle: hFont;
  LogRec       : TLogFont;
  sin_angle,cos_angle: double;
begin
  GetObject(ACanvas.Font.Handle, SizeOf(LogRec), Addr(LogRec));
  LogRec.lfEscapement := round(Angle * 10*180/pi);
  LogRec.lfOrientation := LogRec.lfEscapement;
  NewFontHandle := CreateFontIndirect(LogRec);
  OldFontHandle := SelectObject(ACanvas.Handle, NewFontHandle);

 SinCos(angle,sin_angle,cos_angle);
 {$ifdef fpc}
  textout(Acanvas.handle,
         x1 +round((- Acanvas.TextWidth(text1)/2)*cos_angle - (Acanvas.Textheight(text1)/2)*sin_angle ) ,
         y1 +round((+ Acanvas.TextWidth(text1)/2)*sin_angle - (Acanvas.Textheight(text1)/2)*cos_angle ) ,
         pchar(text1),length(text1) );
 {$ELSE} {delphi}
  textout(Acanvas.handle,
         x1 +round((- Acanvas.TextWidth(text1)/2)*cos_angle + (Acanvas.Textheight(text1)/4)*sin_angle ) ,
         y1 +round((+ Acanvas.TextWidth(text1)/2)*sin_angle + (Acanvas.Textheight(text1)/4)*cos_angle ) ,
         pwidechar(text1),length(text1)); {unicode}
 {$endif}

  NewFontHandle := SelectObject(ACanvas.Handle, OldFontHandle);
  DeleteObject(NewFontHandle);
end;

procedure textout_right_aligned(dc :tcanvas;x1,y1:integer;text1:string); {write text right aligned}
begin
  dc.textout(x1- dc.TextWidth(text1),y1,text1);
end;

procedure textout_center_aligned(dc :tcanvas;x1,y1:integer;text1:string); {write text center aligned}
begin
  {$ifdef fpc}
  textout(dc.handle, x1-round(dc.TextWidth(text1)/2),y1,pchar(text1),length(text1));
  {$ELSE} {delphi}
  textout(dc.handle, x1-round(dc.TextWidth(text1)/2),y1,pwidechar(text1),length(text1)); {unicode}
  {$endif}
end;

procedure selectfont1(dc:tcanvas);
begin
  dc.font.name:=font_name;
  dc.font.size:=fontsize1; {fontsize1;}
  dc.font.style:=font_style;    // [fsUnderline];
  dc.font.charset:=font_charset;
  {$ifdef mswindows}
  SetTextAlign(dc.handle, ta_left or ta_top or TA_NOUPDATECP);{always, since Linux is doing this fixed}
  setbkmode(dc.handle,TRANSPARENT); {transparent}
  {$else} {Linux}
  dc.Brush.Style:=bsClear;{transparent style}
  {$endif}
  font_height1:=round(dc.Textheight('TYC:1234-12345-1')*0.9);{font size times 0.9 to get underscore at the correct place. Fonts coordinates are all top/left coordinates }
end;

procedure selectfont2(dc:tcanvas);
begin
  dc.font.name:=font_name;
  dc.font.size:=fontsize2;
  dc.font.style:=[];
  dc.font.charset:=font_charset;

  {$ifdef mswindows}
  SetTextAlign(dc.handle, ta_left or ta_top or TA_NOUPDATECP);{always, since Linux is doing this fixed}
  setbkmode(dc.handle,TRANSPARENT); {transparent}
  font_height2:=round(dc.Textheight('TYC'));
  font_width2:=round(dc.TextWidth('TYC')/3);
  {$else} {Linux}
  dc.Brush.Style:=bsClear;{transparent style}
  font_height2:=round(dc.Textheight('TYC')*1.1);
  font_width2:=round(dc.TextWidth('TYC')*1.1/3);
  {$endif}
end;

procedure selectfont3(dc:tcanvas);
begin
  dc.font.name:=font_name;
  dc.font.size:=fontsize3;
  dc.font.style:=[fsItalic];
  dc.font.charset:=font_charset;
  {$ifdef mswindows}
  SetTextAlign(dc.handle, ta_left or ta_top or TA_NOUPDATECP);
  setbkmode(dc.handle,TRANSPARENT); {transparent}
  {$else} {Linux}
  dc.Brush.Style:=bsClear;{transparent style}
  {$endif}
  font_height3:=round(dc.Textheight('NW'));
end;

procedure selectfont4transparent(dc:tcanvas;color1:integer);
begin
  dc.font.name:=font_name;
  dc.font.size:=round(fontsize2*3/4);
  dc.font.style:=[];
  dc.font.charset:=font_charset;
  {$ifdef mswindows}
  SetTextAlign(dc.handle, ta_left or ta_top or TA_NOUPDATECP);{always, since Linux is doing this fixed}
  setbkmode(dc.handle,TRANSPARENT); {transparent}
  {$else} {Linux}
  dc.Brush.Style:=bsClear;{transparent style}
  {$endif}
  font_height4:=round(dc.Textheight('59'));
  font_width4:=round(dc.TextWidth('59.0')/4);
  SetTextColor(dc.handle,color1);{required after selection new font}
end;

procedure selectfont4opaque(dc:tcanvas;color1:integer);
begin
  dc.font.name:=font_name;
  dc.font.size:=round(fontsize2*12/16);
  dc.font.style:=[];
  dc.font.charset:=font_charset;
  {$ifdef mswindows}
  SetTextAlign(dc.handle, ta_left or ta_top or TA_NOUPDATECP);{always, since Linix is doing this fixed}
  setbkmode(dc.handle,Opaque); {not transparent}
  {$else} {Linux}
  dc.Brush.Style:=bssolid;{opaque style}
  {$endif}
  font_height4:=round(dc.Textheight('59'));
  SetTextColor(dc.handle,color1);{required after selection new font}
end;

procedure selectfontgreek(dc:tcanvas;color1:integer);
begin
  dc.font.name:=font_name;
  dc.font.size:=round(fontsize3);
  dc.font.style:=[];
  dc.font.charset:=font_charset;
  {$ifdef mswindows}
  SetTextAlign(dc.handle, ta_left or ta_top or TA_NOUPDATECP);
  setbkmode(dc.handle,TRANSPARENT); {transparent}
  {$else} {Linux}
  dc.Brush.Style:=bsClear;{transparent style}
  {$endif}
  SetTextColor(dc.handle,color1);{required after selection new font}
  font_height_greek:=round(dc.Textheight('ß'));
  half_font_width_greek:=round(dc.TextWidth('ß')/2);
end;

procedure message_canvas(x,y,color1:integer;text1:string);{message to canvas for drawing}
begin
  selectfont3(mainwindow.image1.canvas);{transparant}
  settextcolor(mainwindow.image1.canvas.handle,color1);
  mainwindow.image1.canvas.textout(x,y,text1);;
end;

procedure canvas_error_message(text1:string);{error message to canvas}
begin
  mainwindow.error_message1.visible:=true;
  mainwindow.error_message1.caption:=mainwindow.error_message1.caption+text1+#13+#10; {add error message to the previouse message so all errors are shown}
end;

procedure get_time_zone;{call windows function}
{$ifdef mswindows}
var GTZI : cardinal ; TZI : TTimeZoneInformation ;
begin ;
  GTZI := GetTimeZoneInformation(TZI) ;
  if GTZI=TIME_ZONE_ID_INVALID then begin {TIME_ZONE_ID_INVALID} exit; end ;
  timezone:=-(tzi.bias+tzi.standardbias)/60;
  case GTZI of
    1 : daylight_saving:=0 ;
    2 : daylight_saving:=1 ;
  end;{case}
end;
{$ELSE} {Linux}
begin
  timezone:=0; {to be fixed later //look in :http://stackoverflow.com/questions/961953/time-zone-code-translation-from-windows-to-linux-in-freepascal}
  daylight_saving:=0;
end;
{$endif}

procedure check_new_user; {For linux this message not in ONpaint event since the messagebox will be grey.}
begin {default.hns not found or longitude=0 latitude=50 (in the sea)}
  new_user:=false;{First reset new_user otherwise two message due to repaint}
  get_time_zone;{set time zone based on windows settings}
  if MessageDlg(
      {$IFDEF fpc}
      new_user_title,
     {$ELSE} {delphi}
      new_user_title+':'+#13+#10+
     {$ENDIF}
      new_user1+#13+#10+#13+#10+#13+#10+
      new_user2+#13+#10+#13+#10+
      new_user3+#13+#10+
      new_user4,
      mtConfirmation,
      [mbYes, mbNo, mbIgnore],0) = mrYes
   then
   mainwindow.settings1Click(nil);
end;

Function Minmax(x,min2,max2:double):double;{Limit x to min and max}
var
  y: double;
begin
  if x<min2 then y:=min2
  else
  begin
    if x>max2 then y:=max2
    else y:=x;
  end;
  minmax:=y;
end;

Function double_to_string_4digit_max(w : double) : String;{to string with 4 decimals but remove last zeros when no fraction}
var
   s1 : String;
begin
   str(w:0:4,s1);
   if s1[length(s1)]='0' then delete(s1,length(s1),1);
   if s1[length(s1)]='0' then delete(s1,length(s1),1);
   if s1[length(s1)]='0' then delete(s1,length(s1),1);
   if s1[length(s1)]='0' then delete(s1,length(s1)-1,2);{remove '.0'}
   double_to_string_4digit_max:=s1;
end;

procedure getdatetime(gtime,tonight:boolean);
var
  mon,day,hou,mi,year3 : STRING;
  sep                  :widechar;
  {$ifdef mswindows}
  SystemTime: tSystemTime;
  {$endif}
  {$ifdef unix}
  {$endif}
begin
  update_mag:=true; {recalculate asteroid magnitude}
  if (gtime)  then {getDate(year2,m,d,dow)}
  begin
    {$ifdef mswindows}
    GetLocalTime(SystemTime);
    year2:=systemtime.wyear;
    month2:=systemtime.wmonth;
    day2:=systemtime.wday;
    hour2:=systemtime.whour;
    min2:=systemtime.wminute;
    sec2:=systemtime.wsecond;{2015}
    {$endif}
    {$ifdef unix}
     year2   := yearof( date );
     month2  := monthof( date);
     day2    := dayof( date );
     hour2   := hourof( time );
     min2    := minuteof( time );
     sec2    := secondof( time );
    {$endif}
  end;
  if tonight then
  begin
    min2:=0;
    sec2:=0; {important at startup because also gettime is called}
    if hour2>6 then hour2:=24 else hour2:=0;
  end;{stay at same day when still dark}

  if dst_auto then {known time zone, update if program is started or time is entered}
      if daylichtsaving(timezone>-1{Europe},year2,month2,day2+hour2/24+min2/(24*60)) then daylight_saving:=1 else daylight_saving:=0;

  str(year2:0,year3);

  mon:=leadingzero(month2);
  day:=leadingzero(day2);

  hou:=leadingzero(hour2);
  mi:=leadingzero(min2);

  if daylight_saving<>0 then sep:='.' {daylightsaving}  else sep:=':' {not daylight saving};
  today2:=(year3)+'-' +mon+('-')+day+'  '+hou+sep+mi;
  checkleapyear(year2);{for inc/dec time}

  calculate_julian(year2,month2,day2,hour2,min2,sec2);
  today2_UTC:=JdToDate(julian_UT);
  Update_theta_phi(julian_et);
  Precession(julian_ET,2451545.0{J2000},0,pi/2,ra_celestial_pole,dec_celestial_pole);{Convert celestial pole to J2000.  long term precession function in hns_Uprs}
end;

procedure zoom_in(factor:double);
begin
  if zoom<=200000 {8000} then
  begin
    if zoom <0.36 then zoom:=0.36*1.4
    else
    begin
      zoom:=zoom*factor {1.4};
      missedupdate:=2;
      paint_sky;
    end;
  end;
end;

procedure zoom_out(factor:double);
begin
   zoom:=zoom/factor;
   if zoom<0.36 then
   begin
      zoom:=0.36;
   end
   else
   begin
     missedupdate:=2;{no zoom, reached limits}
     paint_sky;
   end;
end;

procedure inctime2(step2:double);
begin
  if actualtime then exit;

  if dst_auto then begin if daylichtsaving(timezone>-1{Europe},year2,month2,day2+step2 +(hour2+min2/60-daylight_saving)/24) then daylight_saving:=1 else daylight_saving:=0;  end;
                                                                       {- daylight_saving to calc in winter time, gives also hyst.}

  JdToDate_integers(julian_UT+ (timezone+daylight_saving)/24 +step2 ,year2,month2,day2,hour2,min2,sec2);{Returns Julian Day}
  getdatetime(false,false); {recalculate wtime}
end;

procedure read_deepsky(searchmode:char);{deepsky database search}
var
  x,z,y      : integer;
  fout,fout2, backsl1, backsl2,length_regel,level : integer;
  regel, data1, type1      :  string;
  delta_ra,width2dummy : double;
  p2,p1: pchar;
  completed_level1,completed_level2 : boolean;
begin
  repeat {until fout is 0}

    {check if level is completed. The deepsky data base is split in three magnitude sorted sections }
    completed_level1:=((deepsky_level=1) and (linepos>=position_deep2));  {level 1 completed}
    completed_level2:=((deepsky_level=2) and (linepos>=position_deep3));  {level 2 completed}

    if (
       ( (searchmode<>'T') and ((completed_level1) or (completed_level2)) )
        or
       (linepos>=deepstring.count)
       )
    then
    begin
      inc(mode);{go to next step}
      exit;
    end;

    regel:=deepstring.strings[linepos]; {using regel,is faster then deepstring.strings[linepos]}
    inc(linepos);
    x:=1; z:=0; y:=0;

    P1 := Pointer(REGEL);
    length_regel:=length(regel);
    repeat

      {fast replacement for y:=posEx(',',regel,y+1); if y=0 then} {last field?}  {y:=length(regel)+1;}   {new fast routine nov 2015, use posEx rather then pos in Delphi}
      while ((y<length_regel) and (p1^<>',')) do
             begin inc(y); inc(p1,1) end;
      inc(y); inc(p1,1);

      {fast replacement for data1:=copy(regel,x,y-x);}
      SetLength(data1, y-x);
      if y<>x then {not empthy 2018}
      begin
        P2 := Pointer(regel);
        inc(P2, X-1);
        move(P2^,data1[1], y-x);

        while ((length(data1)>1) and (data1[length(data1)]=' ')) do {remove spaces in the end since VAL( can't cope with them}
                                      delete(data1,length(data1),1);
      end;{not empthy}
      x:=y;
      inc(z); {new data field}

      case z of 1: ra2:=valint32(data1,fout)*pi*2/864000;{10*60*60*24, so RA 00:00 00.1=1}
                          {valint32 takes 1 ms instead of 4ms}

                2: begin
                     dec2:=valint32(data1,fout)*pi*0.5/324000;{60*60*90, so DEC 00:00 01=1}
                     delta_ra:=abs(ra2-telescope_ra); if delta_ra>pi then delta_ra:=pi*2-delta_ra;

                     if ((searchmode<>'T') and {limit area range if magnitude is normal}
                                                  {If magnitude>1000 then text search in complete database}
                         {$ifdef mswindows}
                         (getinputstate=false) and {to be fixed for Linux}
                         {$ELSE} {}
                         {$endif}

                         ( sqr( delta_ra*cos_telescope_dec)  + sqr(dec2-telescope_dec)> sqr((1+work_width/(work_height))/zoom))){2018}

                         {calculate distance and skip when to far from centre screen }
                           then  fout:=99; {if true then outside screen,go quick to next line}

                   end;
                3: begin
                     mag2:=valint32(data1,fout2); {valint32 in hns_ast is faster then standard val}
                     if fout2<>0 then
                       mag2:=999
                     else
                       if ((mag2>deep-30/zoom) and (searchmode<>'T')) then
                       begin
                         if ((deepsky_level =2) and (linepos<position_deep2)) then linepos:=position_deep2 {go to second section deep sky database}
                         else
                         if ((deepsky_level>=3) and (linepos<position_deep3)) then linepos:=position_deep3 {go to third section deep sky database}
                         else
                         inc(mode);{go to next step}
                       end;
                   end;
                4: begin
                     naam2:='';{for case data1='';}
                     naam3:='';
                     naam4:='';
                     while (data1[1]=' ') do delete(data1,1,1); {remove spaces in front of the name, in practice faster then trimleft}
                     backsl1:=pos('/',data1);
                     if backsl1=0 then naam2:=data1
                     else
                     begin
                       naam2:=copy(data1,1,backsl1-1);
                       backsl2:=posEX('/',data1,backsl1+2);     { could also use LastDelimiter}
                       if backsl2=0 then naam3:=copy(data1,backsl1+1,length(data1)-backsl1+1)
                       else
                       begin
                         naam3:=copy(data1,backsl1+1,backsl2-backsl1-1);
                         naam4:=copy(data1,backsl2+1,length(data1)-backsl2+1);
                       end;
                     end;
                   end;
                5: begin
                     while ((length(data1)>0) and ( data1[1]=' ')) do delete(data1,1,1); {remove spaces in front of the name, in practice faster then trimleft}
                     spectr:=data1;
                     if ((filtertype<>'') and (filtertype<>copy(spectr,1,2))  and (searchmode<>'T')) then fout:=99;
                   end;
                6: begin
                     brightn:=valint32(data1,fout2);{valint32 in hns_ast is faster then standard val}
                     if brightn=0 then brightn:=999;
                   end;
                7: begin
                     val(data1,length2,fout2);{accept floating points}
                     if ((length2<min_size2) and (searchmode<>'T')) then fout:=99; ;end;{go to next object. 2018, for lowest setting accept object with size zero}
                8: begin
                     val(data1,width2,fout2);{accept floating points}
                     if ((brightn=999) and (mag2<>999)and (length2>=1) )  then {estimate surface brightness}
                        begin

                          type1:=copy(spectr,1,2);
                          if  ( ((type1='BN')) or
                                ((type1='PN')) or
                                ((type1='GX')) or
                                ((type1='GC'))) then {do this only for type of objectes and not for ASTER, OC...}
                          begin
                            if width2=0 then width2dummy:=length2 else width2dummy:=width2;
                            brightn:=round(10* ((mag2/10)+ln(length2*width2dummy*(pi/4)/100)*2.512/ln(10))); {surfbr:=m+2.512*log(surface), surface ellips is length*width*pi/4}
                          end;
                       end;
                   end;
                9: begin val(data1,orientation2,fout2);{accept floating points}
                          if fout2<>0 then orientation2:=999;{unknown} end;
                         {orientation 0 komt ook voor daarom if unknown=empthy equals 999}
       end;
       inc(x);
    until ((z>=9) or ((fout<>0) and (z>=3)) );
                     {always decode magnitude equals z=3 for limiting magnitude even if outside area}
  until ((fout=0) or (mode>11));  {when regel is not ok repeat until regel is ok.   }
end;

function online_catalog(catalog,options1,rastr,decstr,fieldw:string): boolean;  {Online routine,load stars from disk or request vizier and save on disk}
var
  namec   : string;
begin
  result:=true;
  namec:= cache_path+string(StringReplace(catalog, '/', '',[rfReplaceAll, rfIgnoreCase]) {string replace for Gaia}
                            +'-'+rastr+decstr)+'.txt';{filename, put  in cache directory}
  with catalogstring do
  begin
     try
     LoadFromFile(namec);	{ load from file }
     except;{no file available}
       clear;
       {http://vizier.u-strasbg.fr/viz-bin/asu-txt?-source=UCAC4&-out=UCAC4,RAJ2000,DEJ2000,pmRA,pmDE,f.mag,Vmag,a.mag&-c=101.0-18.0,bm=60x60}
       {http://vizier.u-strasbg.fr/doc/asu.html}
       internetlink:='http://'+vizier_server+'/viz-bin/asu-txt?-source='+catalog+options1+'&-c='+rastr+decstr+',bm='+fieldw; {60x60}
        if DownloadFile(internetlink,namec) then
       begin
       end
       else
       begin
         result:=false;
         ShowMessage('Error while downloading ' + internetlink);
         if fileExists(namec)=false then ShowMessage('Error file saving:'+namec+#10#13+'Check if path exist!');
       end;
       try
         LoadFromFile(namec);	{ load from file }
       except;
         result:=false;
         exit;
       end;
     end;
  end;
end;

procedure prepare_onlineUCAC4(field:integer);{field 1..9, fill the catalogstring with the star field from internet}
 var
     r1,d1,maxmagstr       : string;
     sgn                   : char;
     dec_rounded,ra_rounded: double;

  procedure prepare_file(rr,dd:integer);
  begin
    ra_rounded:=round(telescope_ra*180/pi);{rounded telescope position important to make fixed steps and saved files reusable}
    dec_rounded:=round(telescope_dec*180/pi);
    str(1000+fnmodulo(trunc(10* (0.96*rr/(0.000001+cos( dec_rounded*pi/180))+ra_rounded)  )/10 ,360):4:1,r1);{ignore "1" of 1000 later, just to add zero's, cos to make biggersteps  in RA at the pole}
                      {trunc (10*....)/10  to prevent 360 in str function due to 359,97}

    str(100+abs(dd+dec_rounded) :3:1,d1);
    if telescope_dec>=0 then sgn:='+'  else sgn:='-';
    str(limitmagn:0:1,maxmagstr);{limiting magnitude in string}


    if online_catalog('UCAC4','&-out=UCAC4,RAJ2000,DEJ2000,pmRA,pmDE,f.mag,Vmag,a.mag',string(r1[2]+r1[3]+r1[4]+r1[5]+r1[6]), string(sgn+d1[2]+d1[3]+d1[4]+d1[5]),'60x60&-out.max=1000000&f.mag=<'+maxmagstr)=false then exit; {exit if can't find or create catalog}

  end;{prepare}
begin
  case  field of   1:  if telescope_dec*180/pi>-89 then prepare_file(0 ,-1); {carefully around poles}
                   2:  prepare_file(0 , 0);
                   3:  if telescope_dec*180/pi<89 then prepare_file(0 ,+1);
                   4:  if telescope_dec*180/pi>-89 then prepare_file(-1,-1);
                   5:  prepare_file(-1, 0);
                   6:  if telescope_dec*180/pi<89 then prepare_file(-1,+1);
                   7:  if telescope_dec*180/pi>-89 then prepare_file(+1,-1);
                   8:  prepare_file(+1, 0);
                   9:  if telescope_dec*180/pi<89 then prepare_file(+1,+1);
                 end;{case}
end;

procedure prepare_file(catalog:ansichar;rr,dd:double);
 var
     r1,d1,maxmagstr         : string;
     sgn                     : char;
     dec_rounded,ra_rounded  : double;
begin
  ra_rounded:=round(2*telescope_ra*180/pi)/2;{round to half degrees!!,  rounded telescope position important to make fixed steps and saved files reusable}
  dec_rounded:=round(2*telescope_dec*180/pi)/2;{round to half degrees!!}
  str(1000+fnmodulo(trunc(10*(0.91*rr/(0.000001+cos( dec_rounded*pi/180))+ra_rounded))/10,360):4:1,r1);{ignore "1" of 1000 later, just to add zero's, cos to make biggersteps  in RA at the pole}
                    {trunc (10*....)/10  to prevent 360 in str function due to 359,97}
  str(100+abs(dd+dec_rounded) :3:1,d1);
  if telescope_dec>=0 then sgn:='+'  else sgn:='-';
  str(limitmagn:0:1,maxmagstr);{limiting magnitude in string}

  if catalog='G' {Gaia} then begin if online_catalog('I/345/Gaia2','&-out=Source,RA_ICRS,DE_ICRS,pmRA,pmDE,Gmag,BPmag,RPmag',string(r1[2]+r1[3]+r1[4]+r1[5]+r1[6]),string(sgn+d1[2]+d1[3]+d1[4]+d1[5]),'30x30&-out.max=1000000&BPmag=<'+maxmagstr)=false then exit; {exit if can't find or create catalog}end
                                                                                                                                                                {max size 20 x default 50.000=1000.000}
  else
  if catalog='U' {Urat} then begin if online_catalog('URAT','&-out=URAT1,RAJ2000,DEJ2000,pmRA,pmDE,f.mag',string(r1[2]+r1[3]+r1[4]+r1[5]+r1[6]),string(sgn+d1[2]+d1[3]+d1[4]+d1[5]),'30x30&-out.max=1000000&f.mag=<'+maxmagstr)=false then exit; {exit if can't find or create catalog}end
                                                                                                                                                                  {max size 20 x default 50.000=1000.000}
  else
  if catalog='N' {Nomad} then begin if online_catalog('NOMAD','&-out=NOMAD1,RAJ2000,DEJ2000,pmRA,pmDE,Vmag,Rmag',string(r1[2]+r1[3]+r1[4]+r1[5]+r1[6]),string(sgn+d1[2]+d1[3]+d1[4]+d1[5]),'30x30&-out.max=1000000&Vmag=<'+maxmagstr)=false then exit; {exit if can't find or create catalog}end
                                                                                                                                                                  {max size 20 x default 50.000=1000.000}
  else
  if catalog='P' {PPMXL} then begin
    if online_catalog('http://vizier.u-strasbg.fr/viz-bin/asu-txt?-source=','&-out=PPMXL,RAJ2000,DEJ2000,pmRA,pmDE,imag,r1mag,b1mag,b2mag',string(r1[2]+r1[3]+r1[4]+r1[5]+r1[6]),string(sgn+d1[2]+d1[3]+d1[4]+d1[5]),'30x30&-out.max=1000000&imag=<'+maxmagstr)=false then exit; {exit if can't find or create catalog}end

end;{prepare}

procedure prepare_online(catalog:ansichar;field:integer);{field 1..9, fill the catalogstring with the star field from internet}
begin
  case  field of   1:  if telescope_dec*180/pi>-89.5 then prepare_file (catalog,0 , -0.5); {carefully around poles}
                   2:                                     prepare_file (catalog,0 ,  0);
                   3:  if telescope_dec*180/pi<89.5  then prepare_file (catalog,0 ,  0.5);
                   4:  if telescope_dec*180/pi>-89.5 then prepare_file (catalog,-0.5,-0.5);
                   5:                                     prepare_file (catalog,-0.5, 0);
                   6:  if telescope_dec*180/pi<89.5  then prepare_file (catalog,-0.5,+0.5);
                   7:  if telescope_dec*180/pi>-89.5 then prepare_file (catalog,+0.5,-0.5);
                   8:                                     prepare_file (catalog,+0.5, 0);
                   9:  if telescope_dec*180/pi<89.5  then prepare_file (catalog,+0.5,+0.5);
                 end;{case}
end;

procedure read_UCAC4catalog(searchmode:char);{read UCAC4 textfile from Vizier}
var
  x,y : byte;
  fout,fout2: integer;
  regel,data1:  string[255];
  rr,magB,pmra,pmde,delta_ra : double;
  magA,magV,magF       : integer;
begin
  if onlinefieldcounter=0 then {init}
  begin
    inc(onlinefieldcounter);
    lineposcatalog:=39;
    prepare_onlineUCAC4(onlinefieldcounter);
  end;{load one of the 9 fields in catalogstring}

  repeat {until fout is 0}
    repeat
      if lineposcatalog+1>catalogstring.count then
      begin
        if onlinefieldcounter=9 then
        begin
          mode:=100;{end search}
          exit;
        end;
        inc(onlinefieldcounter);
        prepare_onlineUCAC4(onlinefieldcounter);{load one of the 9 fields in catalogstring}
        lineposcatalog:=39;
      end;
    until catalogstring.count>=lineposcatalog; {2016 extra protection against empthy files}

    regel:=ansistring(catalogstring.strings[lineposcatalog]);
    inc(lineposcatalog);
    fout:=0;

    y:=0;
    for x:=12 to 12+10 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
    val(string(data1),rr,fout);ra2:=rr*pi/180;

    y:=0;
    for x:=24 to 24+10 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
    val(data1,rr,fout);dec2:=rr*pi/180;

    delta_ra:=abs(ra2-telescope_ra); if delta_ra>pi then delta_ra:=pi*2-delta_ra;

     if ((fout<>0) and (searchmode<>'T') and
                         {$ifdef mswindows}
                         (getinputstate=false) and {to be fixed for Linux}
                         {$ELSE} {}
                         {$endif}
                         ( sqr( delta_ra*cos_telescope_dec)  + sqr(dec2-telescope_dec)> sqr((1+work_width/(work_height))/zoom))){2018}
                          {calculate distance and skip when to far from centre screen }
                           then  fout:=99; {if true then outside screen,go quick to next line}

    if fout=0 then
    begin
      naam2:=copy(regel,1,10);

      naam3:='';naam4:='';
      y:=0;
      for x:=54 to 54+5 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
      val(data1,magb,fout2);
      if fout2<>0 then magF:=999 else  magF:=round(magb*10);

      if length(regel)>=61+5 then {do not read rubbish behind end of regel}
      begin
        y:=0;
        for x:=61 to 61+5 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,magb,fout2);
        if fout2<>0 then magV:=999 else  magV:=round(magb*10);
      end
      else
      magV:=999;

      if length(regel)>=68+5 then {do not read rubbish behind end of regel}
      begin
        y:=0;
        for x:=68 to 68+5 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,magb,fout2);
        if fout2<>0 then magA:=999 else  magA:=round(magb*10);
      end
      else
      magA:=999;

      if magf<magV then mag2:=magf else mag2:=magV;
      if magA<mag2 then mag2:=magA;
      if mag2<maxmag then
      begin {bright enough}
        {proper motion correction}
        y:=0;
        for x:=45 to 45+7 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,pmde,fout2);
        if fout2=0 {if empthy, fout>0, do not further compute} then
        begin
           y:=0;
           for x:=36 to 36+7 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
           val(data1,pmra,fout2);
           if fout2=0 then {if empthy, fout=9, do not further compute}
           begin
              DEC2 {(epoch T)} := DEC2 + (pmDE * (equinox_date - 2000.0))*((pi/180)/3600000);  {DEC first  for next cosinus !!!!!}
              RA2  {(epoch T)} := RA2  + (pmRA / cos(dec2)*(equinox_date - 2000.0))*((pi/180)/3600000);
           end;
        end;
      end
      else fout:=99;{to faint}

    end;
  until ((fout=0) or (mode>99));  {when regel is not ok repeat until regel is ok.   }
end;

procedure read_NOMADcatalog(searchmode:char);{read NOMAD textfile from Vizier}
var
  x,y : byte;
  fout,fout2: integer;
  regel,data1:  string[255];
  delta_ra,rr,magN,pmra,pmde : double;
  magV,magR, magB: integer;

  begin
  if onlinefieldcounter=0 then {init}
  begin
    inc(onlinefieldcounter);
    lineposcatalog:=38;
    prepare_online('N',onlinefieldcounter);
  end;{load one of the 9 fields in catalogstring}

  repeat {until fout is 0}
    repeat
      if lineposcatalog+1>catalogstring.count then
      begin
        if onlinefieldcounter=9 then
        begin
          mode:=100;{end search}
          exit;
        end;
        inc(onlinefieldcounter);
        prepare_online('N',onlinefieldcounter);{load one of the 4 fields in catalogstring}
        lineposcatalog:=38;
      end;
    until catalogstring.count>=lineposcatalog; {2016 extra protection against empthy files}

    regel:=ansistring(catalogstring.strings[lineposcatalog]);
    if length(regel)>68 then begin mode:=101; ShowMessage('Old incompatible cache files found!! Delete all *.txt files in the FITS directory first !! Got to main menu FILE, DELETE  ONLINE  CACHE.');end;
    inc(lineposcatalog);
    fout:=0;

    y:=0;
    for x:=14 to 14+10 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
    val(data1,rr,fout);ra2:=rr*pi/180;

    y:=0;
    for x:=26 to 26+10 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
    val(data1,rr,fout);dec2:=rr*pi/180;

    delta_ra:=abs(ra2-telescope_ra); if delta_ra>pi then delta_ra:=pi*2-delta_ra;
    if ((fout=0) and (searchmode<>'T') and
                         {$ifdef mswindows}
                         (getinputstate=false) and {to be fixed for Linux}
                         {$ELSE} {}
                         {$endif}
                         (sqr( delta_ra*cos_telescope_dec)+sqr(dec2-telescope_dec)>sqr((1+work_width/(work_height))/zoom))){2018}
                          {calculate distance and skip when to far from centre screen }
                           then  fout:=99; {if true then outside screen,go quick to next line}
    if fout=0 then
    begin
      naam2:=copy(regel,1,10);

      naam3:='';naam4:='';
      y:=0;
      for x:=56 to 56+5 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
      val(data1,magN,fout2);
      if fout2<>0 then magV:=999 else  magV:=round(magN*10);

      if length(regel)>=63+5 then {do not read rubbish behind end of regel}
      begin
        y:=0;
        for x:=63 to 63+5 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,magN,fout2);
        if fout2<>0 then magR:=999 else  magR:=round(magN*10);
      end
      else magR:=999;

      if length(regel)>=70+5 then {do not read rubbish behind end of regel}
      begin
        y:=0;
        for x:=70 to 70+5 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,magN,fout2);
        if fout2<>0 then magB:=999 else  magB:=round(magN*10);
      end
      else magB:=999;

      if magV<>999 then mag2:=magV else mag2:=magR;
      if magB<Mag2 then mag2:=magB;

      if mag2<maxmag then
      begin {bright enough}
        {proper motion correction}
        y:=0;
        for x:=47 to 47+7 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,pmde,fout2);
        if fout2=0 then {if empthy, fout>0, do not further compute}
        begin
           y:=0;
           for x:=38 to 38+7 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
           val(data1,pmra,fout);
           if fout2=0 then {if empthy, fout>9, do not further compute}
           begin
             DEC2 {(epoch T)} := DEC2 + (pmDE * (equinox_date - 2000.0))*((pi/180)/3600000);  {DEC first  for next cosinus !!!}
             RA2  {(epoch T)} := RA2  + (pmRA / cos(dec2)*(equinox_date - 2000 ))*((pi/180)/3600000);
           end;
         end;
        {USNOB  1577-0164870=Ross 452=UCAC4 789-022180  FK4 coord. (ep=B1950 eq=1950) : 	11 56 45.77 +68 04 14.1}
        {alleen met epoch 2000 klopt  proper motion calculation and met dss_red1 van 1953, niet met epoch van uit  catalog }
      end
      else fout:=99;{to faint}
    end;
    {USNOB  1577-0164870=Ross 452=UCAC4 789-022180  FK4 coord. (ep=B1950 eq=1950) : 	11 56 45.77 +68 04 14.1}
    {alleen met epoch 2000 klopt  proper motion calculation and met dss_red1 van 1953, niet met epoch van uit  catalog }
 until ((fout=0) or (mode>99));  {when regel is not ok repeat until regel is ok.   }
end;

procedure read_PPMXLcatalog(searchmode:char);{read PPMXL textfile from Vizier}
var
  x,y : byte;
  fout,fout2: integer;
  regel,data1:  string[255];
  delta_ra,rr,magN,pmra,pmde : double;
  magi,magr1, magb1,magb2: integer;

  begin
  if onlinefieldcounter=0 then {init}
  begin
    inc(onlinefieldcounter);
    lineposcatalog:=38;
    prepare_online('P',onlinefieldcounter);
  end;{load one of the 9 fields in catalogstring}

  repeat {until fout is 0}
    repeat
      if lineposcatalog+1>catalogstring.count then
      begin
        if onlinefieldcounter=9 then
        begin
          mode:=100;{end search}
          exit;
        end;
        inc(onlinefieldcounter);
        prepare_online('P',onlinefieldcounter);{load one of the 4 fields in catalogstring}
        lineposcatalog:=38;
      end;
    until catalogstring.count>=lineposcatalog; {2016 extra protection against empthy files}

    regel:=ansistring(catalogstring.strings[lineposcatalog]);
    inc(lineposcatalog);
    fout:=0;

    y:=0;
    for x:=21 to 21+9 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
    val(data1,rr,fout);ra2:=rr*pi/180;

    y:=0;
    for x:=32 to 32+9 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
    val(data1,rr,fout);dec2:=rr*pi/180;

    delta_ra:=abs(ra2-telescope_ra); if delta_ra>pi then delta_ra:=pi*2-delta_ra;
    if ((fout=0) and (searchmode<>'T') and
                         {$ifdef mswindows}
                         (getinputstate=false) and {to be fixed for Linux}
                         {$ELSE} {}
                         {$endif}
                     //    (sqr((1-abs(telescope_dec)/(0.5*pi))*delta_ra)+sqr(dec2-telescope_dec)>sqr((1+work_width/(work_height))/zoom)))
                         (sqr( delta_ra*cos_telescope_dec)+sqr(dec2-telescope_dec)>sqr((1+work_width/(work_height))/zoom))){2018}
                          {calculate distance and skip when to far from centre screen }
                           then  fout:=99; {if true then outside screen,go quick to next line}


    if fout=0 then
    begin
      naam2:=copy(regel,1,19);
      naam3:='';naam4:='';
      if length(regel)>=61+4 then {do not read rubbish behind end of regel}
      begin
      y:=0;
      for x:=61 to 61+4 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
      val(data1,magN,fout2);
      if fout2<>0 then magi:=999 else  magi:=round(magN*10);
      end
      else magi:=999;

      if length(regel)>=67+4 then {do not read rubbish behind end of regel}
      begin
        y:=0;
        for x:=67 to 67+4 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,magN,fout2);
        if fout2<>0 then magr1:=999 else  magr1:=round(magN*10);
      end
      else magr1:=999;

      if length(regel)>=73+4 then {do not read rubbish behind end of regel}
      begin
        y:=0;
        for x:=73 to 73+4 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,magN,fout2);
        if fout2<>0 then magb1:=999 else  magb1:=round(magN*10);
      end
      else magb1:=999;

      if length(regel)>=79+4 then {do not read rubbish behind end of regel}
      begin
        y:=0;
        for x:=79 to 79+4 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,magN,fout2);
        if fout2<>0 then magb2:=999 else  magb2:=round(magN*10);
      end
      else magb2:=999;

      if magi<>999 then mag2:=magi else mag2:=magr1;
      if magb1<Mag2 then mag2:=magb1;
      if magb2<Mag2 then mag2:=magb2;

      if mag2<maxmag then
      begin {bright enough}
        {proper motion correction}
        y:=0;
        for x:=52 to 52+7 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,pmde,fout2);
        if fout2=0 then {if empthy, fout>0, do not further compute}
        begin
           y:=0;
           for x:=43 to 43+7 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
           val(data1,pmra,fout);
           if fout2=0 then {if empthy, fout>9, do not further compute}
           begin
             DEC2 {(epoch T)} := DEC2 + (pmDE * (equinox_date - 2000.0))*((pi/180)/3600000);  {DEC first  for next cosinus !!!}
             RA2  {(epoch T)} := RA2  + (pmRA / cos(dec2)*(equinox_date - 2000 ))*((pi/180)/3600000);
           end;
         end;
        {USNOB  1577-0164870=Ross 452=UCAC4 789-022180  FK4 coord. (ep=B1950 eq=1950) : 	11 56 45.77 +68 04 14.1}
        {alleen met epoch 2000 klopt  proper motion calculation and met dss_red1 van 1953, niet met epoch van uit  catalog }
      end
      else fout:=99;{to faint}
    end;
    {USNOB  1577-0164870=Ross 452=UCAC4 789-022180  FK4 coord. (ep=B1950 eq=1950) : 	11 56 45.77 +68 04 14.1}
    {alleen met epoch 2000 klopt  proper motion calculation and met dss_red1 van 1953, niet met epoch van uit  catalog }
//    UCAC4 pmRA=-465 pmDEC=-142
//    PPMXL pmRA=-462.9 pmDEC=-135.2
  until ((fout=0) or (mode>99));  {when regel is not ok repeat until regel is ok.   }
end;

procedure read_URATcatalog(searchmode:char);{read URAT textfile from Vizier}
var
  x,y : byte;
  fout,fout2: integer;
  regel,data1:  string[255];
  delta_ra,rr,magN,pmra,pmde : double;
begin
  if onlinefieldcounter=0 then {init}
  begin
    inc(onlinefieldcounter);
    lineposcatalog:=38;
    prepare_online('U',onlinefieldcounter);
  end;{load one of the 9 fields in catalogstring}

  repeat {until fout is 0}
    repeat
      if lineposcatalog+1>catalogstring.count then
      begin
        if onlinefieldcounter=9 then
        begin
          mode:=100;{end search}
          exit;
        end;
        inc(onlinefieldcounter);
        prepare_online('U',onlinefieldcounter);{load one of the 4 fields in catalogstring}
        lineposcatalog:=38;
      end;
    until catalogstring.count>=lineposcatalog; {2016 extra protection against empthy files}

    regel:=ansistring(catalogstring.strings[lineposcatalog]);
    inc(lineposcatalog);
    fout:=0;

    y:=0;
    for x:=12 to 12+10 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
    val(data1,rr,fout);ra2:=rr*pi/180;

    y:=0;
    for x:=24 to 24+10 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
    val(data1,rr,fout);dec2:=rr*pi/180;

    delta_ra:=abs(ra2-telescope_ra); if delta_ra>pi then delta_ra:=pi*2-delta_ra;
    if ((fout=0) and (searchmode<>'T') and
                      {$ifdef mswindows}
                      (getinputstate=false) and {to be fixed for Linux}
                      {$ELSE} {}
                      {$endif}
                   //    (sqr((1-abs(telescope_dec)/(0.5*pi))*delta_ra)+sqr(dec2-telescope_dec)>sqr((1+work_width/(work_height))/zoom)))
                       (sqr( delta_ra*cos_telescope_dec)+sqr(dec2-telescope_dec)>sqr((1+work_width/(work_height))/zoom))){2018}
                         {calculate distance and skip when to far from centre screen }
                       then
                         fout:=99; {if true then outside screen,go quick to next line}
    if fout=0 then
    begin
      naam2:=copy(regel,1,10);

      naam3:='';naam4:='';
      y:=0;
      for x:=50 to 50+5 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
      val(data1,magN,fout2);
      if fout2<>0 then mag2:=999 else  mag2:=round(magN*10);

      if mag2<maxmag then
      begin {bright enough}
        {proper motion correction}
        y:=0;
        for x:=43 to 47+5 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,pmde,fout2);
        if fout2=0 then {if empthy, fout>0, do not further compute}
        begin
           y:=0;
           for x:=36 to 38+5 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
           val(data1,pmra,fout);
           if fout2=0 then {if empthy, fout>9, do not further compute}
           begin
             DEC2 {(epoch T)} := DEC2 + (pmDE * (equinox_date - 2000.0))*((pi/180)/3600000);  {DEC first  for next cosinus !!!}
             RA2  {(epoch T)} := RA2  + (pmRA / cos(dec2)*(equinox_date - 2000 ))*((pi/180)/3600000);
           end;
         end;
      end
      else fout:=99;{to faint}
    end;
 until ((fout=0) or (mode>99)); {when regel is not ok repeat until regel is ok.   }
end;

procedure read_GAIAcatalog(searchmode:char);{read URAT textfile from Vizier}
var
  x,y : byte;
  fout,fout2,foutBP,foutRP,lengthR: integer;
  regel,data1:  string[255];
  delta_ra,rr,pmra,pmde : double;

begin
  if onlinefieldcounter=0 then {init}
  begin
    inc(onlinefieldcounter);
    lineposcatalog:=38;
    prepare_online('G',onlinefieldcounter);
  end;{load one of the 9 fields in catalogstring}

  repeat {until fout is 0}
    repeat
      if lineposcatalog+1>catalogstring.count then
      begin
        if onlinefieldcounter=9 then
        begin
          mode:=100;{end search}
          exit;
        end;
        inc(onlinefieldcounter);
        prepare_online('G',onlinefieldcounter);{load one of the 4 fields in catalogstring}
        lineposcatalog:=38;
      end;
    until catalogstring.count>=lineposcatalog; {2016 extra protection against empthy files}

    regel:=ansistring(catalogstring.strings[lineposcatalog]);
    lengthR:=length(regel);

    inc(lineposcatalog);
    fout:=0;

    y:=0;
    for x:=21 to 21+15-1 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
    val(data1,rr,fout);ra2:=rr*pi/180;

    y:=0;
    for x:=37 to 37+15-1 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
    val(data1,rr,fout);dec2:=rr*pi/180;

    delta_ra:=abs(ra2-telescope_ra); if delta_ra>pi then delta_ra:=pi*2-delta_ra;

    if ((fout=0) and (searchmode<>'T') and
                {$ifdef mswindows}
                (getinputstate=false) and {to be fixed for Linux}
                {$ELSE} {}
                {$endif}
                (sqr( delta_ra*cos_telescope_dec)+sqr(dec2-telescope_dec)>sqr((1+work_width/(work_height))/zoom))){2018}
                {calculate distance and skip when to far from centre screen }
                then
                fout:=99; {if true then outside screen,go quick to next line}
    if fout=0 then
    begin
      naam2:=copy(regel,1,19);
      naam3:='';naam4:='';
      y:=0;

      for x:=73 to 73+7-1 do begin inc(y); Gmag[Y]:=regel[x];end; setlength(Gmag,y);{set length correct}{magn}
      val(Gmag,magG,fout2);

      y:=0;
      for x:=81 to min(81+7-1,lengthR) do begin inc(y); BPmag[Y]:=regel[x];end; setlength(BPmag,y);{set length correct}{magn}
      val(BPmag,magBP,foutBP);

      y:=0;
      for x:=89 to min(89+7-1,lengthR) do begin inc(y); RPmag[Y]:=regel[x];end; setlength(RPmag,y);{set length correct}{magn}
      val(RPmag,magRP,foutRP);

      if foutBP=0 then mag2:=round(magBP*10)
      else
      if fout2=0 then  mag2:=round((magG+0.5)*10) {use Gmag but add 0.5}
      else
      mag2:=999;


      if mag2<maxmag then
      begin {bright enough}
        {proper motion correction}
        y:=0;
        for x:=63 to 63+9-1 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
        val(data1,pmde,fout2);
        if fout2=0 then {if empthy, fout>0, do not further compute}
        begin
           y:=0;
           for x:=53 to 53+9-1 do begin inc(y); data1[Y]:=regel[x];end; setlength(data1,y);{set length correct}
           val(data1,pmra,fout);
           if fout2=0 then {if empthy, fout>9, do not further compute}
           begin                                               {!!!!!! Gaia equinox 2015 !!!!!!!!!!!!!!!!!!!!!!!!!!!}
             DEC2 {(epoch T)} := DEC2 + (pmDE * (equinox_date - 2015.5))*((pi/180)/3600000);  {DEC first  for next cosinus !!!}
             RA2  {(epoch T)} := RA2  + (pmRA / cos(dec2)*(equinox_date - 2015.5 ))*((pi/180)/3600000);
           end;                                                {!!!!!! Gaia equinox 2015 !!!!!!!!!!!!!!!!!!!!!!!!!!!}
         end;
      end
      else fout:=99;{to faint}
    end;
 until ((fout=0) or (mode>99));  {when regel is not ok repeat until regel is ok.   }
end;

procedure read_comet(searchmode:char);{comet database search, improved 2015 unicode version}
var
  x,y,z, fout  :    integer;
  regel:  string;//[255];
  data1 : array[0..255] of widechar;
  c_year, c_month : integer;
  c_d,c_ecc,c_q,c_inc2,c_lan,c_aop,c_teqx0,c_g,c_k :double; {new comet var}
  skip                                             : boolean;

begin
  repeat {until mag is ok}
    repeat {until fout is 0}
      repeat
        if linepos+1>cometstring.count then
                     begin inc(mode);
                         mag:=999; {999=skip plotting of last comets when nothing plotted}
                         exit;
                     end;{end of tstrings}
        regel:=cometstring.strings[linepos];
        if ((linepos=0) and (length(regel)>=3) and (ord(regel[1])>128)) then delete(regel,1,3);{first three charactors should not be ther, bug FPC?}
        skip:=( (length(regel)<=20) or (regel[1]=';'));
        if skip then inc(linepos);
      until skip=false;

      x:=1; z:=0; fout:=0;
      repeat  {remove many spaces, 10 % faster routine when many spaces. Not used for supplements and deepsky database }
        Y:=0;
        while ((x<=length(regel)) and (regel[x]<>'|')) do {get ra}
        begin
           if regel[x]<>' ' then begin data1[Y]:=regel[x]; inc(y); end;{no spaces}
           inc(x);
        end;
        data1[y]:=ansichar(#0);
        inc(z); {new data field}
        case z of
               1: begin
                    naam2:=data1;naam3:='';
                  end;
               2: begin val(data1,c_teqx0,fout);end;{equinox}
               3: begin val(data1[0]+data1[1]+data1[2]+data1[3],c_YEAR,fout);{year}
                        if fout=0 then val(data1[4]+data1[5],c_month,fout);{month}
                        if fout=0 then val(copy(data1,7,y-6),c_d,fout);{dd.dddd or dd.ddd}
                  end;
               4: begin val(data1,c_q,fout);end;
               5: begin val(data1,c_ecc,fout);end;
               6: begin val(data1,c_aop,fout);end;
               7: begin val(data1,c_lan,fout);end;
               8: begin val(data1,c_inc2,fout);end;
               9: begin val(data1,c_g,fout);end;
              10: begin val(data1,c_k,fout);end;
              11: begin
                    naam3:=data1;
                  end;
              end;
              inc(x);
      until ((z>=11) or (fout<>0));

      if ((fout<>0) {including outside area} and (errors[0,1]=0)) then {error marking}
      begin
        errors[0,0]:=linepos;
        errors[0,1]:=z;
      end;

      inc(linepos);
    until (fout=0);  {when regel is not ok repeat until regel is ok.   }
    try {important compiler setting  "Do not stop on delphi exceptions"}
      comet(sun200_calculated,2000,julian_ET,c_year,c_month,c_d,c_ecc,c_q,c_inc2,c_lan,c_aop,c_teqx0,ra2,dec2,delta,sun_delta);
    except
      mainwindow.statusbar1.caption:=('With comet '+naam2+' floating point problems !');
    end;
    mag:=c_g+ ln(delta)*5/ln(10)+ c_k*ln(sun_delta)/ln(10) ;
                            {log(x) = ln(x)/ln(10)}
   {size some practical values : mag 7.5 ==> 15'
                                     8   ==>  5'
                                     9.5 ==>  5'
                                    11.5      2'
                                    10.7      3'
                                    13.0==>   2'
                                    13.5==>   1.5'
                           see S&W 1-98 seite 66
                                          }
    length2:=60*60*power(2.7,-0.3144*mag); {estimated using curve fitting in Excel.}
    if ((objectmenu.neo_only1.checked) and (delta>0.05)) then mag:=99999999;{skip none neo's}
  until ( (comets_activated=2) or ((mag*10<=deep-30/zoom) and (length2>=min_size2))   or (searchmode in ['T','P']));
end;

procedure read_asteroid(searchmode:char);{asteroid database search}
var
  x,y,z, fout : integer;
   regel       : string;
   data1 : array[0..255] of widechar;
  a_year,a_month:integer;
  a_d,a_ecc,a_a,a_inc2,a_lan,a_aop,a_teqx0,a_anm: double; {new comet var}
  c_q, c_epochdelta,diameter_A,degrees_to_perihelion     : double;
  skip                                                   : boolean;
const
  a_h                   : single =0;
  asteroid_slope_factor : single =0.15;
  Gauss_gravitational_constant: double=0.01720209895*180/pi;
begin     {read  one line of asteroidstring with enough magnitude}
  repeat {until mag is ok}
    repeat {until fout is 0}
     repeat
       if linepos>asteroidstring.count-1 then
         begin inc(mode);update_mag:=false; mag:=999; {999=skip plotting of last comets when nothing plotted} exit;end;{end of tstrings}
       regel:=asteroidstring.strings[linepos];
       if ((linepos=0) and (length(regel)>=3) and (ord(regel[1])>128)) then delete(regel,1,3);{first three charactors should not be ther, bug FPC?}
       if ((update_mag=false) and (length(regel)>=20)) then mag{X}:=(ord(regel[length(regel)-1])-65) + 0.1*(ord(regel[length(regel)])-48) else mag{X}:=0;{up to date magnitude}
         {note mag is expresses in A....Z}
       skip:=(((mag*10 {X}>deep) and (searchmode<>'T')) or (length(regel)<=20) or (regel[1]=';'));
       if skip then inc(linepos);
     until skip=false;
     x:=1; z:=0; fout:=0;
     repeat {remove many spaces, 10% faster routine when many spaces. Not used for supplements and deepsky database }
       Y:=0;
       while ((x<=length(regel)) and (regel[x]<>'|')) do {get ra}
       begin
         if regel[x]<>' ' then begin data1[Y]:=regel[x]; inc(y); end;{no spaces}
         inc(x);
       end;
       data1[y]:=ansichar(#0);
       inc(z); {new datafeld}
       case z of
               1: begin {names}
                    naam2:=data1;naam3:='';
                  end;
               2: begin
                       val(data1[0]+data1[1]+data1[2]+data1[3],a_YEAR,fout);{year, faster then copy(...}
                        if fout=0 then val(data1[4]+data1[5],a_month,fout);{month}
                        if fout=0 then val(data1[6]+data1[7]+data1[8]+data1[9]+data1[10]+data1[11],a_d,fout); end; {dd.ddd}
               3: begin val(data1,a_ecc,fout);end;{Eccentricity}
               4: begin val(data1,a_a,fout);end; {SemiMj Axis, (a)}
               5: begin val(data1,a_inc2,fout);end;{Inclination (i)}
               6: begin val(data1,a_lan,fout);end;
               7: begin val(data1,a_aop,fout);end;
               8: begin val(data1,a_teqx0,fout);end;{equinox}
               9: begin val(data1,a_anm,fout);end;
              10: begin val(data1,a_h,fout);end;
              11: begin val(data1,asteroid_slope_factor,fout);end;
       end;
       inc(x);
     until ((z>=11) or (fout<>0));

     if ((fout<>0) {including outside area} and (errors[1,1]=0)) then  {error marking}
       begin errors[1,0]:=linepos; errors[1,1]:=z;end;

     inc(linepos);
   until (fout=0);  {when regel is not ok repeat until regel is ok.   }

   try
    {convert to comet elements}
    c_q := a_a * ( 1 - a_ecc); {semi-minor axis (q) or perihelion}

    {find days to nearest perihelion date}
    if a_anm>180 then degrees_to_perihelion:=360-a_anm {future perihelion is nearer}
                 else degrees_to_perihelion:=-a_anm;   {past perihelion is nearer}

     c_epochdelta:=degrees_to_perihelion /(Gauss_gravitational_constant /( a_a * sqrt( a_a ) ));{days to nearest perihelion date}
     comet(sun200_calculated,2000,julian_ET,a_year,a_month,a_d+c_epochdelta,a_ecc,c_q,a_inc2,a_lan,a_aop,a_teqx0,ra2,dec2,delta,sun_delta);
   except
     mainwindow.statusbar1.caption:=('With asteroid '+naam2+' floating point problems !');
   end;


   diameter_A:=(1329/sqrt(0.15 {albedo}))* EXP(-0.2*a_h{absolute magnitude}*LN(10));{2013, estimated diameter in KM based on H=absolute  magnitude}  {power :=EXP(tweedevar*LN(eerstevar))}
                                                                                   {source http://www.physics.sfasu.edu/astro/asteroids/sizemagnitude.html, D:=(1329/sqrt(albedo))*10^-0.2*H}
   length2:=((1/delta)* diameter_A * (360*60*60/ (pi*2*AE)));{2013 diameter in acrsec} {ae has been fixed to the value 149597870.700 km as adopted by the International Astronomical Union in 2012}



   if update_mag then
   begin
     mag:=a_h+ ln(delta*sun_delta)*5/ln(10);  {log(x) = ln(x)/ln(10)}

     phase:=illum_comet; { Get phase comet. Only valid is comet routine is called first.}
     mag:=mag+asteroid_magn_comp(asteroid_slope_factor,phase);

   {slope factor =0.15
    angle object-sun-earth of 0   => 0   magnitude
                             5      0.42
                            10      0.65
                            15      0.83
                            20      1}


    setlength(regel,x+1);{set length such that 3 characters are available after data}
    regel[x-1]:='|';
    mag:=round(10*mag)/10;
    regel[x]:= char(trunc(mag)+65);{magnitude in A..Z scale equals 0..25};
    regel[x+1]:=char(round(10*frac(mag)+ord('0')));{magnitude  fraction equal 0.0 .. 0.9};

   // if mag>15 then asteroidstring.strings[linepos-1]:=';'+regel else
    asteroidstring.strings[linepos-1]:=regel;{magnitude in A0..Z9 scale}
  end;
  if ((objectmenu.neo_only1.checked) and (delta>0.05)) then mag:=99999999;{skip none neo's}

  until ((asteroids_activated=2) or (mag*10<=deep-30/zoom) or (searchmode in ['T','P']));
end;

{Asteroid Ceres(1) Epoch of elements: 1993 01 13.000
                  Eccent, (e)      : 0.0764401
                  SemiMj Axis, (a) : 2.7678
                  Mean Anomaly, (M): 184.1845

Calculate the semi-major axis (q) as follows:
   q = a * ( 1 - e) = 2.5562291
The mean anomaly (M) increases per day:
   n = 0.98560767 /( a * squareroot( a ) ) = 0.21404378   [degrees/day]
           note: 0.98560767 is a fixed conversion factor
           Gauss_gravitational_constant, 0.01720209895*180/pi
Then calculate the number of days till the mean anomaly reaches 360 degrees equals 0 degrees:
   (360-184.1845) / 0.21404378 = 819 days. The perihelion date is then 95-4-14
}

procedure read_supplement(searchmode:char;sup:integer);{supplement database search}
var
  x,y,z, fout,fout2,backsl1,backsl2                      :   integer;
  regel,data1 :  string;
  rash,rasm,rass,decsh,decsm,decss, delta_ra,magn        : double; {new comet var}
  skip,sign                                              : boolean;
begin
  repeat {until fout is 0}
    repeat
      case sup of 1: begin
                       if linepos+1>supplstring1.count then
                       begin
                       inc(mode);mag:=999; {999=skip plotting of last comets when nothing plotted}
                       exit;
                       end;{end of tstrings}
                       regel:=supplstring1.strings[linepos];
                     end;
                  2: begin
                       if linepos+1>supplstring2.count then
                       begin inc(mode);mag:=999; {999=skip plotting of last comets when nothing plotted} exit;end;{end of tstrings}
                       regel:=(supplstring2.strings[linepos]) {pack greek letters from unicode in one byte};
                     end;
                  3: begin
                       if linepos+1>supplstring3.count then
                       begin inc(mode);mag:=999; {999=skip plotting of last comets when nothing plotted} exit;end;{end of tstrings}
                       regel:=(supplstring3.strings[linepos]) {pack greek letters from unicode in one byte};
                     end;
                  4: begin
                       if linepos+1>supplstring4.count then
                       begin inc(mode);mag:=999; {999=skip plotting of last comets when nothing plotted} exit;end;{end of tstrings}
                       regel:=(supplstring4.strings[linepos]) {pack greek letters from unicode in one byte};
                     end;
                  5: begin
                       if linepos+1>supplstring5.count then
                       begin inc(mode);mag:=999; {999=skip plotting of last comets when nothing plotted} exit;end;{end of tstrings}
                       regel:=(supplstring5.strings[linepos]) {pack greek letters from unicode in one byte};
                     end;
                  end;
      if ((linepos=0) and  (length(regel)>=3) and (ord(regel[1])>128) ) then delete(regel,1,3);{first three charactors should not be there, bug FPC?}
      skip:=((length(regel)<=5) or (regel[1]=';'));
      if skip then inc(linepos);
    until skip=false;
    x:=1; z:=0; y:=0;fout:=0;
    repeat
      y:=posEX(',',regel,y+1);{new fast routine nov 2015, faster if not many space characters}
      if y=0 then {last field?}
               y:=length(regel)+1;
      data1:=copy(regel,x,y-x);
      while ((length(data1)>=1) and (data1[length(data1)]=' ')) do {remove spaces in the end since VAL( can't cope with them}
                                    delete(data1,length(data1),1);  {in practice faster then trimleft}

      x:=y;
      inc(z); {new data field}

     {RA[0..24.0],RAM[0..60.0],RAS[0..60.0],DEC[-90.0..90.0],DECM[0..60.0],DECS[0..60.0],mag[*10],name[ASCII],type[ASCII],brightness,length[min*10],width[min*10],orientation[degrees]}
     case z of
               1: begin if length(data1)>0 then val(data1,rash,fout) else rash:=0;end;
               2: begin if length(data1)>0 then val(data1,rasm,fout) else rasm:=0;end;
               3: begin if length(data1)>0 then val(data1,rass,fout) else rass:=0; ra2:=(rash+rasm/60+rass/3600)*pi/12;
                     if worldmap then ra2:=-ra2+wtime2+longitude*pi/180;{world map rotate and flip earth}
                  end;
               4: begin if length(data1)>0 then begin
                                                  val(data1,decsh,fout);
                                                  sign:=((decsh<0) or (data1[1]='-')); {fix minus zero  -00:19}
                                                end
                                                else decsh:=0;end;
               5: begin if length(data1)>0 then begin
                                                  val(data1,decsm,fout);
                                                  sign:=((decsm<0) or (sign)); {fix minus   00:-19}
                                                end
                                                else decsm:=0;end;
               6: begin if length(data1)>0 then val(data1,decss,fout) else decss:=0;
                        decsh:=abs(decsh)+abs(decsm/60)+abs(decss/3600);
                        if sign then decsh:= - decsh;{negative}
                        dec2:=decsh*pi/180;
                  end;
               7: begin val(data1,magn,fout2);if fout2<>0 then mag2:=999 else mag2:=round(magn);{do also real values}
                  end;
               8: begin {supplements names}
                    naam2:='';{for case data1='';}
                    naam3:='';
                    naam4:='';
                    while ((length(data1)>=1) and (data1[1]=' ')) do delete(data1,1,1); {remove spaces in front of the name, in practice faster then trimleft}
                    backsl1:=pos('/',data1);
                    if backsl1=0 then naam2:=data1
                    else
                    begin
                      naam2:=copy(data1,1,backsl1-1);
                      backsl2:=posEX('/',data1,backsl1+1);     { could also use LastDelimiter}
                      if backsl2=0 then naam3:=copy(data1,backsl1+1,length(data1)-backsl1+1)
                      else
                      begin
                        naam3:=copy(data1,backsl1+1,backsl2-backsl1-1);
                        naam4:=copy(data1,backsl2+1,length(data1)-backsl2+1);
                      end;
                    end;
                  end;
               9: begin
                    while ((length(data1)>=1) and (data1[1]=' ')) do delete(data1,1,1); {remove spaces in front of the name, in practice faster then trimleft}
                    spectr:=data1;
                  end;
              10: begin
                    val(data1,brightn,fout2);
                    if fout2<>0 then begin descrip2:=data1; brightn:=0;{star} end
                    else
                    begin
                      descrip2:='';{ if brightn=0 then brightn:=999;}
                    end;{valid brightness found}

                    if brightn>=0 then {no line mode, important otherwise line are filtered out}
                    begin
                      if searchmode<>'T' then {searchmode='L', line edit mode}
                      begin
                        if ((brightn>0){not a star} and (mag2>deep-30/zoom)) then  {to faint}  fout:=fout or $1000 {skip this deepsky one}
                        else
                        if ((brightn=0) and (mag2>maxmag)) then {too faint} fout:=fout or $1000 {skip this star}
                        else
                        begin {check position of star or deepsky object not already skipped}
                          delta_ra:=abs(ra2-telescope_ra); if delta_ra>pi then delta_ra:=pi*2-delta_ra;
                          if ((searchmode<>'T') and {limit area range if magnitude is normal}
                                                        {If magnitude>1000 then text search in complete database}
                         {$ifdef mswindows}
                         (getinputstate=false) and {to be fixed for Linux}
                         {$ELSE} {}
                         {$endif}
                         (sqr( delta_ra*cos_telescope_dec)+sqr(dec2-telescope_dec)>sqr((1+work_width/(work_height))/zoom)){2018}
                         {calculate distance and skip when to far from centre screen }
                          ) then
                          fout:=fout or $1000; {if true then outside screen,go quick to next line}
                        end;
                      end;
                    end{no line mode}
                    else
                    if ((brightn<=-3) and (brightn>=-5)) then {plot houses, trees near horizon}
                    begin
                      if apparent_horizon<>0 then dec2:=altitude_to_true(dec2); {apparent_altitude}
                      az_ra(ra2,dec2,reallatitude,0,wtime2actual,ra2,dec2);{plot house, trees horizon}
                      ep(equinox_date,2000,ra2,dec2,ra2,dec2); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}
                    end;
                  end;
              11: begin
                    val(data1,length2,fout2);
                    if ((brightn>0){no line mode or supplement star} and (searchmode<>'T'))  then
                    begin
                      if  (length2<min_size2)then fout:=99 {go to next object}
                      else
                      if ((filtertype<>'') and (filtertype<>copy(spectr,1,2))) then fout:=99;{filter object only if length>0}
                    end;
                  end;
              12: val(data1,width2,fout2);
              13: begin val(data1,orientation2,fout2);if fout2<>0 then orientation2:=999;{orientation 0 komt ook voor daarom if unknown=empthy equals 999}
                    if brightn<-100 then{xy info of moons}
                    begin
                      if ((orientation2-julian_et>=0) and (orientation2-julian_et<=1))  then {neptune moon within time window}
                      begin
                        if brightn=-900 then {pluto moon}
                        begin
                          ra2:=pluto_ra+length2*(pi/180)/3600;
                          dec2:=pluto_dec+width2*(pi/180)/3600;
                        end
                        else
                        if brightn=-800 then {neptune moon}
                        begin
                          ra2:=neptune_ra+length2*(pi/180)/3600;
                          dec2:=neptune_dec+width2*(pi/180)/3600;
                        end
                        else
                        if brightn=-700 then {uranus moon}
                        begin
                          ra2:=uranus_ra+length2*(pi/180)/3600;
                          dec2:=uranus_dec+width2*(pi/180)/3600;
                        end
                        else
                        if brightn=-600 then {saturn moon}
                        begin
                          ra2:=saturn_ra+length2*(pi/180)/3600;
                          dec2:=saturn_dec+width2*(pi/180)/3600;
                        end
                        else
                        if brightn=-500 then {jupiter moon}
                        begin
                          ra2:=jupiter_ra+length2*(pi/180)/3600;
                          dec2:=jupiter_dec+width2*(pi/180)/3600;
                        end
                        else
                        if brightn=-500 then {mars moon}
                        begin
                          ra2:=mars_ra+length2*(pi/180)/3600;
                          dec2:=mars_dec+width2*(pi/180)/3600;
                        end;

                        linepos:=99999999; {stop any further reading}
                      end
                      else fout:=fout or $1000;{mark as outside area}
                    end;
                  end;
       end;
       inc(x);


    until ((z>=13) or (fout<>0));

    if (((fout and $0FFF)<>0) {including outside area} and (errors[sup+1,1]=0){no error found yet}) then {error marking}
    begin
      errors[sup+1,0]:=linepos;
      errors[sup+1,1]:=z;
    end;
    inc(linepos);
  until (fout=0);  {when regel is not ok repeat until regel is ok.   }
end;

procedure plot_pixel_sphere(dc:tcanvas; ras,decs : double;size,color2,ostyle,loadhint:integer);
{the main plotting routine in this program                      }
{ras 0..2pi, decs -pi/2..pi/2 position                          }
{size of 0: setpixel(dc,x9,y9,color2);                          }
{  ,,   -1: lineto(dc,x9,y9);                                   }
{  ,,   -2: moveto(dc,x9,y9);                                   }
{  ,,  -99: exit; but calculate x9,y9 and zc                    }
{if style=1 then plot arc instead of filled ellipse             }
{ before calling routine set if required:                       }
{                               selectobject(dc,pen2);          }
{                               selectobject(dc,brushdeepsky2); }
var
      cy,vv,cx,cz,lc,ls,qx,qy,qz,tc,ts,ec,es,rr : double;
var   ao,aa,xc,yc:double;{real=double but compiler has to know for sincos function}
      poin: array[0..3] of tpoint;
begin
  if projection<>2 then
  begin  {Orthographic/Azimuthal Equidistant projection}
    SinCos(decs,cy,vv);
    SinCos(ras-wtime2,cz,cx);
    cx:=-cx*vv;
    cz:=-cz*vv;

    lc := -sin_latitude2; {-sin(latitude2), latitude2:=(90-latitude)*pi/180;;, already calculated once in maak_plaatje}
    ls :=  cos_latitude2;
    qx := cy * lc - cx * ls;
    qy := cx * lc + cy * ls;
    qz := cz;

    tc :=  sin_viewx; {sin(viewx); already calculated once in maak_plaatje}
    ts := -cos_viewx;

    cz := qz * tc - qx * ts;
    cx := qx * tc + qz * ts;
    cy := qy;

    ec := sin_viewy;{sin(viewy); already calculated once in maak_plaatje}
    es := cos_viewy;

    qy := cy * ec - cz * es;
    qz := cz * ec + cy * es;
    qx := cx;
    rr := SQRt(qx * qx + qz * qz );
    IF rr > 0 THEN
    begin
      aa := Arctan(qy / rr); {arctan is 30% faster then arctan2}
           IF ABS(qz) > ABS(qx) THEN {1010}
      begin {1020}
         ao := pi/2 -  ArctaN(qx / qz);
         IF qz < 0 THEN ao := ao - pi;
      end
      else
      begin
        ao :=  Arctan(qz / qx);
        IF qx < 0 THEN ao := ao + pi;
      end;
    end
    else
    begin
      aa := pi/2;
      IF qy < 0 THEN aa := -pi/2;
      ao := 0;
    end;

    {Orthographic or Azimuthal Equidistant (single circle)}
    if projection= 0 then  begin rr := sin(pi/2 + aa);if aa<0 then zc:=-1 else zc:=1;end {Orthographic}
                     else  begin rr :=(pi/2 - aa); if abs(rr)>3.0 then
                                                                   zc:=-1 else zc:=1;end;{Azimuthal Equidistant}
                                                        {abs(rr)3, limit field a little to prevent funnny lines}
      SinCos(ao,yc,xc);
      yc:=yc*rr;
      xc:=xc*rr;
   end {Orthographic/Azimuthal Equidistant projection}
   else

   begin  {cylindrical projection}
     if viewY>pi then viewY:=viewY-2*pi;{make negative viewY for range 180-360 degrees}
     sincos(decs,cx{sin(DEC)},cy{cos(DEC)});
     sincos(wtime2-ras,qx{sin(wtime2-RAS)},qy{cos(wtime2-RAS)});
     try
      {***** altitude calculation from RA&DEC, meeus new 12.5 *******}
       yc:=arcsin(SIN_latitude*cx + COS_latitude*cy*qy);
      {***** azimuth calculation from RA&DEC, meeus new 12.6 ****** }
       xc:=arctan2(qx, qy * sin_latitude - tan(decs)*cos_latitude);
     except
       {ignore floating point error outside builder}
     end;
     xc:=(xc-viewx-pi);
     yc:=(yc-viewY);

     while xc>+pi do xc:=xc-2*pi;
     while xc<-pi do xc:=xc+2*pi;

     zc:=1;{on sight, within range of screen plot}
     if xc>+(pi-0.1) then zc:=-1;{limit view for lines drawings}
     if xc<-(pi-0.1) then zc:=-1;
   end; {end cylindrical projection}

  x9:=round({middle_x}+ (half_height*xc*zoomv));
  y9:=round({middle_y}- (half_height*yc*zoomh));

  {here zc=-1 means out of sight}
  if ((abs(x9)>$2fff)or(abs(y9)>$2fff)) then zc:=-1;
  x9:=x9+middle_x;{2015 after out of sight detection with zc, move from centre coordinates to canvas coordinates}
  y9:=y9+middle_y;

    if zc>0 then {in sight}
    begin
       case size of
              {$ifdef mswindows}
                 0: setpixelV(dc.handle,x9,y9,abs(color2)); {note setpixelV is faster then setpixel}
                -1: lineto(dc.handle,x9,y9);
                -2: movetoEX(dc.handle,x9,y9,nil  );
               -99: ; {check now only hint}
              {$ELSE} {}
                 0: dc.pixels[x9,y9]:=abs(color2);
                -1: dc.lineto(x9,y9);
                -2: dc.MoveTo(x9,y9);
               -99: ; {check now only hint}
              {$endif}

       else
       begin
           if ((ostyle=0) or (size=1)) then dc.ellipse(x9-size,y9-size,x9+size,y9+size)  //ellipse(dc.handle,x9-size,y9-size,x9+size,y9+size)
           else
           if ostyle=1 then
             dc.arc(x9-size,y9-size,x9+size,y9+size,
                    x9-size,y9-size,x9-size,y9-size){draw empty circel without changing background . That means do not cover moon with hyades}
                    {2017, no longer required:+1 is a small correction for Linux where start and end point result in a 0 degrees rather 360 degrees as in mswindows, bug report,http://mantis.freepascal.org/view.php?id=30194}
           else
           if ostyle=2 then
           begin
             poin[0]:=Point(x9-square_x_step,y9+square_y_step);
             poin[1]:=Point(x9+square_y_step,y9+square_x_step);
             poin[2]:=Point(x9+square_x_step,y9-square_y_step);
             poin[3]:=Point(x9-square_y_step+1,y9-square_x_step);

            {$IFDEF fpc}
             dc.Polygon(poin,4)
            {$ELSE} {delphi}
             Polygon(dc.handle,poin,4)
             {$ENDIF}
           end;
       end;
     end; {case}
     {special win95 hint part to fill arrays with data}
     if ((loadhint<>0){active} and (indexcounter<=buffersize) and (x9>rrw.LEFT+image_overlap) and (x9<rrw.right+image_overlap) and (y9>rrw.top+image_overlap) and (y9<rrw.bottom+image_overlap)) then

            begin
              index[0,indexcounter]:=x9;index[1,indexcounter]:=y9;{store screen position}
//              StringToWideChar(naam2,names[indexcounter],sizeof(names[0])); {Delphi and FPC & Lazarus solution}
              names[indexcounter]:=naam2;
              magnitudes[indexcounter]:=mag2; {store magnitude}
              inc(indexcounter);
            end;
    end
    else movetoEX(dc.handle,x9 {and $FFFF},y9 {and $FFFF},nil);
end;

procedure plot_north_arrow(xpos, ypos,leng : integer);{arrow pointing north}
var   x,y,x2,y2   :double;
begin
  mainwindow.panel_north1.visible:=true;

  mainwindow.image_north1.canvas.brush.Color := Colors[0];{clear fill bitmap with background color}
  mainwindow.image_north1.canvas.fillrect(mainwindow.image_north1.clientrect); {wis canvas using current brush}

  mainwindow.panel_north1.left:=xpos;
  mainwindow.panel_north1.Top:=ypos;
  mainwindow.panel_north1.Width:=round(leng*2);
  mainwindow.panel_north1.height:=round(leng*2);
  mainwindow.image_north1.Picture.Bitmap.Width := mainwindow.image_north1.Width;
  mainwindow.image_north1.Picture.Bitmap.Height := mainwindow.image_north1.Height;

  selectobject(mainwindow.image_north1.canvas.handle,pen_green);


  rotate(chart_orientation,round(leng*0.75),0,x2,y2);
  {east line}
  mainwindow.image_north1.canvas.moveTo(round(leng-x2 + fliph*flipv*y2/2),round(leng-y2 - fliph*flipv*x2/2));
  mainwindow.image_north1.canvas.lineTo(round(leng-x2),round(leng-y2));
  {north line}
  mainwindow.image_north1.canvas.lineTo(round(leng+x2),round(leng+y2));

  {pointer}
  rotate(-30*pi/180+chart_orientation,round(leng/3),0,x,y);
  mainwindow.image_north1.canvas.lineTo(round(leng+x2-x),round(leng+y2-y));
  rotate(+30*pi/180+chart_orientation,round(leng/3),0,x,y);
  mainwindow.image_north1.canvas.lineTo(round(leng+x2-x),round(leng+y2-y));
  mainwindow.image_north1.canvas.lineTo(round(leng+x2),round(leng+y2));
end;

procedure marker_telrad2(dc:tcanvas;ra11,dec11:double;font7:integer);
var tel:integer;
    xxx: double;
begin
  case font7 of 1:begin  selectobject(dc.handle,pen_crosshair);{deepsky} end;
                2:begin  selectobject(dc.handle,pen3);{star} end;
                end;
  for tel:=1 to 5 do
  begin
    xxx:=telrad[tel]*(work_height)*zoom*5*telrad_factor;
    if xxx>5 then plot_pixel_sphere(dc,ra11,dec11,round(xxx),$FFFFFF,1,0);{draw arc without filling }
  end;{for}
end;
procedure marker_name2(dc:tcanvas;ra11,dec11:double;font7:integer;nam:string);
begin
  case font7 of 1:begin  selectfont1(dc); SetTextColor(dc.handle,colors[28]);{deepsky names} end;
                2:begin  selectfont1(dc); SetTextColor(dc.handle,colors[24]);{star names} end;{5 is for time, right allign and underscore}
                3:begin  selectfont4transparent(dc,colors[28]); {deepsky magnitude} end;
                4:begin  selectfont4transparent(dc,colors[24]); {star magnitude} end;
                5:begin  selectfont1(dc); SetTextColor(dc.handle,colors[24]);{time stamp} end;
                end;
  plot_pixel_sphere(dc,ra11,dec11,-2,$0,0,0);{find x9, y9 position}
  if zc<>-1 then {visible}
  begin
    if font7>=3 then                              {font of 1 deepskynames, 2 star names, 3 deepskymag, 4 star magnitude, 5 time stamp}
    begin
      textout_right_aligned(dc, x9-5, y9,nam);{deepskymagnitude, star magnitude, timestamp}
    end
    else
    begin
      // werkt niet op image1     textOut(dc.handle, x9+5, y9-font_height1,pchar(nam),length(nam));{deepsky,  star names}
      dc.textOut(x9+5, y9-font_height1,(nam));{deepsky,  star names}
    end;
  end;
end;

function remove_rectangle(label_name:string) : string;{remove rectangle with name from suplement 2, if name is blank remove last rectangle}
var
   i,j: integer;
begin
  result:='Not found!';
  if label_name='' then {remove last frame}
  begin
    if  ((supplstring2.count>=1)and (pos(',frame,',supplstring2[supplstring2.count-1])<>0)) then {REMOVE PREVIOUS FRAME}
    begin
      supplstring2.delete(supplstring2.count-1);
      dec(linepoint_counter);{for cltr+del last line object}
      result:='OK';
    end;
  end
  else
  begin  {find frame with label_name}
    j:=0;
    while j<supplstring2.count do
    begin
      if ((pos(','+label_name,supplstring2[j])<>0) and (pos(',frame,',supplstring2[j])<>0)) then {frame line found}
      begin
        supplstring2.delete(j);{remove the line from the frame}
        dec(linepoint_counter);{for cltr+del last line object}
        result:='OK';
        exit;
      end;
      inc(j);
    end;
  end;
end;

procedure plot_rectangle(dc:tcanvas; width1,height2,angle3,ra4,dec5 : double);{plot a CCD rectangle.}
var                     //width, height, angle, ra,dec,label
  xa,ya,xb,yb,ra_1,ra_2,ra_3,ra_4,dec_1,dec_2,dec_3,dec_4,x,y,z  : double;
begin
  {angle,x1,y1, x2,y2}
  width1:=width1*3600*180/pi;{radians to arc seconds}
  height2:=height2*3600*180/pi;{radians to arc seconds}

  angle3:=angle3-pi/2; {vertical frame is zero, so rotate 90 degrees}
  rotate(angle3,width1,+height2,xa,ya);{rotate a vector point of the rectangle}
  rotate(angle3,width1,-height2,xb,yb);{rotate a vector point of the rectangle}

  {make rotated rectangle created at position 0,0}
  ra_1:=+xa/2;
  dec_1:=+ya/2;
  ra_2:=+xb/2;
  dec_2:=+yb/2;

  ra_3:=-xa/2;
  dec_3:=-ya/2;
  ra_4:=-xb/2;
  dec_4:=-yb/2;
  {finished making rotated rectangle at position 0,0}

  standard_equatorial(ra4,dec5,ra_1,dec_1,1{scale one arc seconds},ra_1,dec_1);{CCD coordinates toRA, DEC}
  standard_equatorial(ra4,dec5,ra_2,dec_2,1{scale one arc seconds},ra_2,dec_2);
  standard_equatorial(ra4,dec5,ra_3,dec_3,1{scale one arc seconds},ra_3,dec_3);
  standard_equatorial(ra4,dec5,ra_4,dec_4,1{scale one arc seconds},ra_4,dec_4);

  plot_pixel_sphere(dc,ra_1, dec_1,-2,0,0,0); {-2 is move action}
  plot_pixel_sphere(dc,ra_2, dec_2,-1,0,0,0);  {line to}
  plot_pixel_sphere(dc,ra_3, dec_3,-1,0,0,0);
  plot_pixel_sphere(dc,ra_4, dec_4,-1,0,0,0);
  plot_pixel_sphere(dc,ra_1, dec_1,-1,0,0,0);

  plot_pixel_sphere(dc,ra4, dec5,-2,0,0,hints); {move to center for label and find function.}
end;

function limit_str(inp2:string;leng2:integer) :string;
var
  xl: integer;
begin
  if length(inp2)>leng2 then setlength(inp2,leng2);
  xl:=pos(';',inp2);{restrict length if seperation sign}
  if xl>0 then setlength(inp2,xl-1);
  if mode<>-3{comets} then {105P/SingerBrewster}
  begin
    xl:=pos('/',inp2);
    if xl>0 then setlength(inp2,xl-1);
  end;

  xl:=pos('/',inp2);
  if xl>0 then setlength(inp2,xl-1);
  xl:=pos('|',inp2);
  if xl>0 then setlength(inp2,xl-1);
  result:=inp2;
end;

var
   report_left : record
                   eq:string;{ equinox}
                   p3:string;
                   p4:string;
                   p5:string;
                   p6:string;
                   p7:string;
                   p8:string;
                   p9:string;
                 end;

   report_right : record
                   p1:string;
                   p2:string;
                   p3:string;
                   p4:string;
                   p5:string;
                   p6:string;
                   p7:string;
                   p8:string;
                   p9:string; {meridian}
                  geo:string;{ geo centric?}
                 end;
   report_azalt : record
                 field:string;
                    ra:string;
                   dec:string;
                    az:string;
                   alt:string;
               flipped:string;
                 end;

procedure canvas_report; {report after object is found}
var
   y,x,size2,position,rightp : integer;
begin
  x:=links;
  y:=line0_y;
  size2:=round(font_height2*1.2);

  {required for autozoom}
  with mainwindow.field1 do begin  height:=font_height2+2;width:=round(font_width2*length(report_azalt.field)); left:=x; top:=y; font.color:=colors[27];font.size:=fontsize2; caption:=report_azalt.field; end;{static text, update fontsize extra since parent font only does it during startup!!}

  {give report}   {constraints to prevent wordwrap in Linux}
  if report_left.eq<>'' then
  begin
    rightp:=18; {indicated non-standard equinox}
    with mainwindow.left1b do begin visible:=true;constraints.maxheight:=font_height2;height:=round(font_height2*0.8);width:=round(length(report_left.eq)*font_width2*0.85); font.size:=round(fontsize2*0.7);left:=x+round(mainwindow.left1.width*0.9); {round(fontsize2*length(ra_string))}; top:=y+size2*1+round(font_height2*0.3); font.color:=colors[27]; caption:=report_left.eq ; end;

  end
  else rightp:=16;

  with mainwindow.left3 do begin visible:=true;left:=x; top:=y+size2*3;font.color:=colors[25]; font.size:=fontsize2; caption:=report_left.p3; end;
  with mainwindow.left4 do begin visible:=true;left:=x; top:=y+size2*4;font.color:=colors[25]; font.size:=fontsize2; caption:=report_left.p4; end;

  with mainwindow.right1 do  begin  height:=font_height2+2;width:=round(10*font_width2); top:=y+size2*1; font.color:=colors[25]; font.size:=fontsize2; left:=x+round((rightp-10)*font_width2);caption:=report_right.p1;end;{ra}
  with mainwindow.right2 do  begin  height:=font_height2+2;width:=round(12*font_width2); top:=y+size2*2; font.color:=colors[25]; font.size:=fontsize2; left:=x+round((rightp-12)*font_width2);caption:=report_right.p2;end;{dec}

  if report_right.geo<>'' then
  with mainwindow.right1c do begin visible:=true;constraints.maxheight:=font_height2;{required,buggy behaviour} height:=round(font_height2*0.7);width:=round(length(report_right.geo)*font_width2*0.8);  top:=y+size2*1+round(font_height2*0.3);font.color:=colors[27]; font.size:=round(fontsize2*0.7); left:=x+round((rightp+0.5)*font_width2); alignment:=taleftjustify; caption:=report_right.geo;end;{geocentric}
  with mainwindow.right3 do  begin visible:=true;autosize:=false; height:=font_height2;width:=round(rightp*font_width2);left:=x; top:=y+size2*3;font.color:=colors[25]; font.size:=fontsize2; caption:=report_right.p3; end;{name}
  with mainwindow.right4 do  begin visible:=true;autosize:=false; height:=font_height2;width:=round(rightp*font_width2);left:=x; top:=y+size2*4;font.color:=colors[25]; font.size:=fontsize2; caption:=report_right.p4; end;{magnitude}

  {shift up if empthy lines}
  position:=size2*4;
  if report_right.p5<>'' then {skip empthy}
  begin
    inc(position,size2);
    with mainwindow.left5 do   begin visible:=true; ;left:=x; top:=y+position;font.color:=colors[25]; font.size:=fontsize2; caption:=report_left.p5; end;
    with mainwindow.right5 do  begin visible:=true; autosize:=false; height:=font_height2;width:=round(rightp*font_width2);left:=x; top:=y+position;font.color:=colors[25]; font.size:=fontsize2; caption:=report_right.p5; end;
  end
  else begin mainwindow.left5.visible:=false; mainwindow.right5.visible:=false;end;

  if report_right.p6<>'' then {skip empthy}
  begin
    inc(position,size2);
    with mainwindow.left6 do begin visible:=true;left:=x; top:=y+position;font.color:=colors[25]; font.size:=fontsize2; caption:=report_left.p6; end;
    with mainwindow.right6 do  begin visible:=true;autosize:=false; height:=font_height2;width:=round(rightp*font_width2);left:=x; top:=y+position;font.color:=colors[25]; font.size:=fontsize2; caption:=report_right.p6; end;
  end
  else begin mainwindow.left6.visible:=false; mainwindow.right6.visible:=false;end;
   ;
  if report_right.p7<>'' then {skip empthy}
  begin
    inc(position,size2);
    with mainwindow.left7 do begin visible:=true;left:=x; top:=y+position;font.color:=colors[25]; font.size:=fontsize2; caption:=report_left.p7; end;
    with mainwindow.right7 do  begin visible:=true;autosize:=false; height:=font_height2;width:=round(rightp*font_width2);left:=x; top:=y+position;font.color:=colors[25]; font.size:=fontsize2; caption:=report_right.p7; end;
  end
  else begin mainwindow.left7.visible:=false; mainwindow.right7.visible:=false;end;
    ;
  if report_right.p8<>'' then{skip empthy}
  begin
    inc(position,size2);
    with mainwindow.left8 do begin visible:=true;constraints.maxheight:=font_height2;left:=x; top:=y+position;font.color:=colors[25]; font.size:=fontsize2; caption:=report_left.p8; end;
    with mainwindow.right8 do  begin visible:=true;autosize:=false; height:=font_height2;width:=round(rightp*font_width2);left:=x; top:=y+position;font.color:=colors[25]; font.size:=fontsize2; caption:=report_right.p8; end;
  end
  else begin mainwindow.left8.visible:=false; mainwindow.right8.visible:=false;end;
    ;
  if report_right.p9<>'' then{skip empthy}
  begin
    inc(position,size2);
    with mainwindow.left9 do begin visible:=true;constraints.maxheight:=font_height2;left:=x; top:=y+position;font.color:=colors[25]; font.size:=fontsize2; caption:=report_left.p9; end;
    with mainwindow.right9 do  begin visible:=true;autosize:=false; height:=font_height2;width:=round(rightp*font_width2);left:=x; top:=y+position;font.color:=colors[25]; font.size:=fontsize2; caption:=report_right.p9; end;
  end
  else begin mainwindow.left9.visible:=false; mainwindow.right9.visible:=false;end;
   ;
  {azimuth, latitude}
  with mainwindow.az_m2  do begin constraints.maxheight:=font_height2+2;height:=font_height2+2;top:=y;font.color:=colors[25]; font.size:=fontsize2; width:=round(font_width2*6);  left:=x+round(font_width2*32)-width; caption:=report_azalt.az; end;
  with mainwindow.alt_m2 do begin constraints.maxheight:=font_height2+2;height:=font_height2+2;top:=y;font.color:=colors[25]; font.size:=fontsize2; width:=round(font_width2*6);  left:=x+round(font_width2*47)-width; caption:=report_azalt.alt;  end;
end;

procedure canvas_field_message;{after screen refresh}
var size2,x,y,y2 : integer;
begin
  x:=links;
  y:=line0_y;
  size2:=round(font_height2*1.2);
  with mainwindow.left1 do begin height:=font_height2+2;width:=round(font_width2*length(ra_string)); left:=x; top:=y+size2*1;font.size:=fontsize2; font.color:=colors[27]; caption:=ra_string; end;{statictext, buggy behaviour, update fontsize extra since parent font only does it during startup!!}
  with mainwindow.left1b do begin visible:=false; end;{statictext}
  with mainwindow.left2 do begin height:=font_height2+2;width:=round(font_width2*length(dec_string)); left:=x; top:=y+size2*2;font.size:=fontsize2; font.Color:=colors[27]; caption:=dec_string; end;{statictext, buggy behaviour, update fontsize extra since parent font only does it during startup!!}
  with mainwindow.left3 do begin visible:=false; end;
  with mainwindow.left4 do begin visible:=false; end;
  with mainwindow.left5 do begin visible:=false; end;
  with mainwindow.left6 do begin visible:=false; end;
  with mainwindow.left7 do begin visible:=false; end;
  with mainwindow.left8 do begin visible:=false; end;
  with mainwindow.left9 do begin visible:=false; end;

  with mainwindow.field1 do begin  height:=font_height2+2;width:=round(font_width2*length(report_azalt.field)); left:=x; top:=y; font.color:=colors[27];font.size:=fontsize2; caption:=report_azalt.field; end;{static text, update fontsize extra since parent font only does it during startup!!}
  with mainwindow.az_m1  do begin constraints.maxheight:=font_height2+2;left:=x+round(font_width2*23); top:=y;height:=font_height2+2;width:=round(length(az_string)*font_width2);font.color:=colors[27]; font.size:=fontsize2; caption:=az_string; end;
  with mainwindow.alt_m1 do begin constraints.maxheight:=font_height2+2;left:=x+round(font_width2*38); top:=y;height:=font_height2+2;width:=round(length(alt_string)*font_width2);font.color:=colors[27]; font.size:=fontsize2; caption:=alt_string; end;
  with mainwindow.az_m2  do begin constraints.maxheight:=font_height2+2;top:=y;height:=font_height2+2;width:=round(6*font_width2); font.color:=colors[27]; font.size:=fontsize2;left:=x+round(font_width2*32)-width; caption:=report_azalt.az;end;
  with mainwindow.alt_m2 do begin constraints.maxheight:=font_height2+2;top:=y;height:=font_height2+2;width:=round(6*font_width2);font.color:=colors[27]; font.size:=fontsize2; left:=x+round(font_width2*47)-width;caption:=report_azalt.alt;  end;
  with mainwindow.flipped1 do begin constraints.maxheight:=font_height2+2;left:=x+round(font_width2*53); top:=y;height:=font_height2+2;width:=round((1+length(report_azalt.flipped))*font_width2);font.color:=colors[27]; font.size:=fontsize2; caption:=report_azalt.flipped;end;

  with mainwindow.right1 do  begin constraints.maxheight:=font_height2+2;height:=font_height2+2;width:=round(9*0.8*font_width2); top:=y+size2*1+round(font_height2*0.2); font.color:=colors[27]; font.size:=round(fontsize2*0.8); caption:=report_right.p1;left:=x+round((15-9*0.8)*font_width2);end;{ra}{statictext}
  with mainwindow.right2 do  begin constraints.maxheight:=font_height2+2;height:=font_height2+2;width:=round(9*0.8*font_width2); top:=y+size2*2+round(font_height2*0.2); font.color:=colors[27]; font.size:=round(fontsize2*0.8); caption:=report_right.p2;left:=x+round((15-9*0.8)*font_width2);end;{dec}{statictext}
  with mainwindow.right1c do begin visible:=false; end;{geocentric}{statictext}
  with mainwindow.right3  do begin visible:=false; end;
  with mainwindow.right4  do begin visible:=false; end;
  with mainwindow.right5  do begin visible:=false; end;
  with mainwindow.right6  do begin visible:=false; end;
  with mainwindow.right7  do begin visible:=false; end;
  with mainwindow.right8  do begin visible:=false; end;
  with mainwindow.right9  do begin visible:=false; end;

  if work_width <mainwindow.toolbar2.width+font_width2*24     then y2:=y {move date down, not enough space}
                                                              else y2:=round(font_height2*(0.3+0*1.20));
  with mainwindow.date_and_time1 do begin {constraints.maxheight:=font_height2;}left:=rrw.right-round(font_width2*19);width:=round(font_width2*18); height:=round(font_height2)+2; top:=y2; font.color:=colors[27];font.size:=fontsize2; caption:=today2; end;{date and time}
end;

procedure canvas_object_message(question: string;color1:tcolor); {if no object is found}
var x,y,size2 : integer;
begin
  y:=links;
  x:=round(font_width2);
  report_right.p1:='';
  report_right.p2:='';
  canvas_field_message;{to clear screen}
  size2:=round(font_height2*1.2);
  with mainwindow.left4 do begin visible:=true; left:=x; top:=y+size2*4;font.color:=color1; font.size:=fontsize2; caption:=question; end;
end;

procedure canvas_mouse_pos;{write mouse position}
var x,y,size2 : integer;
begin
  x:=links;
  y:=line0_y;
  size2:=round(font_height2*1.2);{statictext}


  with mainwindow.az_m2  do begin constraints.maxheight:=font_height2+2;top:=y;height:=font_height2+2;font.color:=colors[27]; font.size:=fontsize2;  width:=round(font_width2*6); caption:=report_azalt.az; left:=x+round(font_width2*32)-width; end;{statictext}{static text, update fontsize extra since parent font only does it during startup!!}
  with mainwindow.alt_m2 do begin constraints.maxheight:=font_height2+2;top:=y; height:=font_height2+2;font.color:=colors[27]; font.size:=fontsize2; width:=round(font_width2*6); caption:=report_azalt.alt;left:=x+round(font_width2*47)-width; end;{statictext}
  with mainwindow.ra_m2  do begin visible:=true; constraints.maxheight:=font_height2+2;top:=y+size2*1;height:=font_height2+2;font.color:=colors[27]; font.size:=fontsize2;  width:=round(font_width2*9); caption:=report_azalt.ra; left:=x+round(font_width2*(30))-width; end;{statictext}
  with mainwindow.dec_m2 do begin visible:=true; constraints.maxheight:=font_height2+2;top:=y+size2*2;height:=font_height2+2;font.color:=colors[27]; font.size:=fontsize2;  width:=round(font_width2*9); caption:=report_azalt.dec;left:=x+round(font_width2*(30))-width; end;{statictext}
end;

procedure write_info(dc: tcanvas { ;schrijf:boolean } );
var
  azimuth2, altitude2: double;
  separ1, separ2: string; // array[0..4]   of ansichar;
  bericht2: string;
  bericht8: string;
  bericht9: string;
  posit, P6B, font7, i, error1: integer;
  skip_marker: boolean;
  ra_eq, dec_eq, xxx1, yyy1,magn_info,temperature: double;
begin
  report_right.p5 := '';
  report_right.p6 := '';
  report_right.p7 := '';
  report_right.p8 := '';
  report_right.p9 := '';
  report_left.p5 := ''; { }
  report_left.p6 := ''; { }
  report_left.p7 := ''; { }
  report_left.p8 := ''; { rise set time }
  report_left.p9 := ''; { meredian time }

  statusbarfree:=false;

  if mode >= 12 then {point objects}
  begin
    selectobject(dc.handle, pen3);
    length2 := 0;{point object, no compensation for size required}
  end
  else
  begin
    selectobject(dc.handle, pen11); { deepsky }
  end;

  if mainwindow.Twolinesnorthsouth1.checked then
  begin
    dc.textOut(0,0,'');{2018, bug? essential to get line drawing working in blank image1}
    //  mainwindow.canvas.textOut(100,100,'test11111111111111111111111111111111111111111111111111111');{2018, bug? essential to get line drawing working in blank image1}

    plot_pixel_sphere(dc, ra2, dec2 - (0.025) / zoom - length2 / 60000, -2, $0, 0, 0); { plot mark line }
    plot_pixel_sphere(dc, ra2, dec2 - (0.01) / zoom - length2 / 60000, -1, $0, 0, 0);
    plot_pixel_sphere(dc, ra2, dec2 + (0.025) / zoom + length2 / 60000, -2, $0, 0, 0);
    plot_pixel_sphere(dc, ra2, dec2 + (0.01) / zoom + length2 / 60000, -1, $0, 0, 0);
  end;

  { mode -3=comet, -1=asteroids,  1=suppl1, 3=suppl2,.. 9=suppl5,  11=deepsky, 12,13 ...stars }

  if ((brightn >= 0) or (brightn<-100)) then { <>-99, -98 supplement text label excludingr xy supplement planetary moons}
    report_left.p4 := magn_string;

  if mode <= 11
  then { not point objects======================================== }
  begin
    if length(naam2) <= 7 then
      report_left.p3 := name_string
    else
    begin
      report_right.p3 :=' ';{space to prevent scroll up in canvas_report }//   limit_str(naam2, 16); { write name right allign }
      report_left.p3 :=naam2;
    end;

    if ((mode >= -3) and (mode <= -1)) then
    begin
      report_left.p5 := dist_string;
      report_left.p6 := sun_dist_string;
      report_left.p7 := type_string;
    end
    else
    begin
      if brightn > 0 { >=-2 }
      then { do not give size houses or supplement stars }
      begin
        if ((length2 >= 10)) then
          report_left.p5 := size_string
        else
          report_left.p5 := size2_string;
      end;
    end;
    if ((mode >= 1)) then
    begin
      report_left.p6 := type_string;

      if (brightn > 0) { not a suppl star } then { xyz }
        report_left.p7 := brightn_string
      else
        report_left.p7 := limit_str(descrip2, 16);
    end
    else
      case mode of
        - 21, -18, -17, -4:report_left.p6 := phase_string; { mars, venus,mercu, moon }
        -35:report_left.p6 := ringopn_string;
      end; { case }
  end
  else
  begin { stars ============================================= }

    if ((stardatabase_displayed > 0) and (stardatabase_displayed < 32) or (mode = 100)) then {UCAC4,  NOMAD }
    begin
      report_left.p5 := type_string;
      if stardatabase_displayed = 3 then report_left.p3 := 'N: '
      else if stardatabase_displayed = 4 then report_left.p3 := 'UR: '
      else if stardatabase_displayed = 5 then report_left.p3 := 'Gaia'
      else if stardatabase_displayed = 6 then report_left.p3 := ''{PPMxl'}
      else report_left.p3 := 'U4:'; {1, 2 => UCAC4}
    end
    else
    { if stardatabase=0 then }
    begin
      if ((stardatabase_displayed = 0) and (mode < 100)) then  begin report_left.p5 := Spectral_string;  end;
      if length(type2) > 0 then
      begin
        if length(type2) <= 7 then
        begin
          dc.textout(links, P6B, name_string);
          report_left.p6 := name_string;
        end
        else
          report_left.p6 := type2;
        { write right allign direct the to long star name }
      end;
      error1 := length(naam2);
      if length(naam2) = 10 then
        val(copy(naam2, 5, 6), i, error1)
      else
        error1 := 99; { length 12 possibly UCAC4 star in tyc_H..dat file }
      if error1 = 0 then { UCAC4 in tyc_H..dat file }
        bericht2 := 'U4:'
      else { SAO, PPM or TYC star }
        bericht2 := uppercase(copy(name_star, 1, 3)) + ': '; { HIP, ... }
      report_left.p3 := bericht2;
    end;
  end;

  if ((brightn <= -3) and (brightn >= -5)) = false then { not a house }
  begin
    ep(2000, equinox_date, ra2, dec2, xxx1, yyy1);
    { new 19-12-2000, convert to actual ra,dec }
    if ((mode <= 5 + 6) and (mode >= -3))
    then { asteroids, comets, deepsky, supplement }
    begin
      report_left.p8 := riseset(planetnr, xxx1, yyy1);
      report_right.p8:= ' ';{give one space for sorting in label_write}
      if meridian_pass<>'' then begin  report_left.p9:=meridian_string; report_right.p9:=meridian_pass;end
                         else begin  report_left.p9:=''; report_right.p9:='';end
    end
    else
    begin
      report_left.p7 := riseset(planetnr, xxx1, yyy1);
      report_right.p7:= ' ';{give one space for sorting in label_write}
      if meridian_pass<>'' then begin  report_left.p8:=meridian_string; report_right.p8:=meridian_pass;end
                         else begin  report_left.p8:=''; report_right.p8:='';end
    end;
    ra_az(xxx1, yyy1, reallatitude, 0, wtime2actual, azimuth2, altitude2); {For current date !! }

    if apparent_horizon <> 0 then altitude2 := altitude_apparent(altitude2);
    { refraction at atmosphere, max 34 minutes near horizon }
  end;

  str(altitude2 * 180 / pi: 5: 1, bericht8 { height } );
  report_azalt.alt := bericht8;

  str(azimuth2 * 180 / pi: 5: 1, bericht8 { height } );
  report_azalt.az := bericht8; { give azimuth of object found }

  if ((mode > 11) or (length(naam2) <= 7)) then
  begin
    if length(naam2) <= 12 then
      report_right.p3 :=
        naam2 { write deepsky object only here when short else above right allign }
    else
    begin
      report_left.p3 := naam2; { GAIA long names }
      report_right.p3:='';
    end;
  end;
  if ((brightn >= 0) or (brightn<-100)) then { <>-99, -98 supplement text label excludingr xy supplement planetary moons}
  begin
    str(mag2 / 10: 6: 1, magn_text);
    report_right.p4 := magn_text;
  end
  else
  begin
    magn_text:=' - ';
    report_right.p4 := magn_text;
  end;

  if mode <= 5 + 6 then
  begin
    if ((mode >= -3) and (mode <= -1)) then { distance in au }
    begin
      { 2 digits mininum and below 0.10 three, below 0.01 four.....   max(2,trunc(ln(100/delta)/ln(10))) }
      str(delta: 6: max(2, trunc(ln(100 / delta) / ln(10))), bericht8);
      report_right.p5 := bericht8;; { distance comet to earth }
      str(sun_delta: 6: max(2, trunc(ln(100 / sun_delta) / ln(10))), bericht8);
      report_right.p6 := bericht8;; { distance comet to sun }
      report_right.p7 := type2;
    end
    else if brightn > 0 { =-2 }
    then { do not give size houses or supplement stars }
    begin
      begin
        if length2 >= 10 then
        begin { arc minutes }
          if length2 >= 100 then
          begin
            str(length2 / 10: 0: 0, bericht8);
            str(width2 / 10: 0: 0, bericht2);
          end
          else
          begin
            str(length2 / 10: 0: 1, bericht8);
            str(width2 / 10: 0: 1, bericht2);
          end
        end
        else
        begin
          if length2 * 60 / 10 >= 10 then
          begin
            str(length2 * 60 / 10: 0: 0, bericht8);
            str(width2 * 60 / 10: 0: 0, bericht2);
          end
          else
          begin
            str(length2 * 60 / 10: 0: 1, bericht8);
            str(width2 * 60 / 10: 0: 1, bericht2);
          end;
        end; { arc seconds }
        if width2 <> 0 then
        begin
          if length(bericht8) < 4 then
            bericht8 := bericht8 + ' x '
          else
            bericht8 := bericht8 + 'x';
          { LIMIT LENGTH FOR EXaMPLe: PK80-6.1 IS Size["]: 30.0 x 18.0 }
          bericht8 := bericht8 + bericht2;
        end;
      end;
      report_right.p5 := bericht8;
    end;
    if ((mode >= 1)) then { deepsky }
    begin
      posit := pos('/', spectr);
      if posit = 0 then posit := length(spectr)
      else dec(posit); { find seperation sign '/' }
      report_right.p6 := limit_str(spectr, posit);
      if (brightn > 0) then { xyz }
      begin
        str(brightn / 10: 6: 1, bericht8);
        report_right.p7 := bericht8;
      end;
      deepskyhelpnaam2 := uppercase(naam2);
      { for deepsky search in deepsky.htm }
      mainwindow.deepskyobservations1.caption := naam2;
    end
    else
      case mode of
        - 21, -18, -17, -4: { mars, venus,mercure, moon }
          begin
            str(phase: 5: 1, bericht8);
            report_right.p6 := bericht8;
          end;
        -35:
          begin
            str(ring_inc * 180 / pi: 4: 1, bericht8);
            report_right.p6 := bericht8;
          end; { ring saturn }
      end; { case }
  end
  else
  begin
    if stardatabase_displayed = 1 then { ucac4 classification }
    begin { UCAC4 clasification }
      if ((UCAC_leda_diameter <> 0) or (UCAC_X2M_diameter <> 0)) then spectr := Non_star_string
      else if UCAC_class = 0 then  spectr := Star_string { clean star }
      else  spectr := double_string; { double star or artifact }
      if UCAC_poor_PM <> 0 then  spectr := '*,poor PM';
    end
    else if (length(type2) <= 7) then report_right.p6 := type2;{else write before direct after name:}
    if stardatabase_displayed < 32 then report_right.p5 := spectr;
  end;
  { rrrrrrrrrrrrr }
  ra_eq := ra2;
  dec_eq := dec2;
  if equinox <> 2000 then
  begin
    if equinox <= 1 then
    begin { apparent position due to precession }
      Precession(2451545.0 { J2000 } , julian_ET, ra_eq, dec_eq, ra_eq, dec_eq);
      { long term precession function in hns_Uprs }
      if ((de430_emphemeris <> 0) and (type2 = 'P')) { planet in DE430 } then
      begin
        // ra_eq:=41.5472*pi/(180);{test sao382288 on 2028-11-13.19 nutation delta_ra=29.64" an delta_dec=6.526" Meeus2 page 141}
        // dec_eq:=49.3485*pi/(180);
        if equinox = 0 then
        begin { calculate from mean the apparent position }
          nutation_correction_equatorial(ra_eq, dec_eq);
          aberration_correction_equatorial(ra_eq, dec_eq); { aberration based on earth vectors. Only valid when DE430 is used }
        end;
      end
      else
      begin {classic}
        if equinox = 0 then nutation_aberration_correction_equatorial_classic(ra_eq, dec_eq);
        { calculate apparent pos, M&P page 208 }
      end;
    end
    else { B1950 }
      if equinox = 1950 then  ep(2000, 1950, ra_eq, dec_eq, ra_eq, dec_eq) { convert to 1950 } { no high accuracy precession for 1950 implemented because nobody will use it }
      else  EQU_GAL(ra_eq, dec_eq, ra_eq, dec_eq); { galactic coordinates }
  end; { {<>j2000 }

  if equinox <> 9999 then { not galactic }
  begin
    ra_text := prepare_ra(ra_eq);
    report_right.p1 := ra_text; { give RA writeinfo }
    dec_text := prepare_dec(dec_eq);
    report_right.p2 := dec_text; { give dec writeinfo }
  end
  else
  begin { galactic }
    str(ra_eq * 180 / pi: 0: 3, ra_text);
    report_right.p1 := ra_text; { give galactic longitude }
    str(dec_eq * 180 / pi: 0: 3, dec_text);
    report_right.p2 := dec_text; { give galactice latitude }
  end;

  if equinox = 1950 then begin report_left.eq := '1950' end
  else if equinox = 9999 then report_left.eq := 'gal'
  else if equinox = 0 then report_left.eq := app_string { apparent position }
  else if equinox = 1 then  report_left.eq := mean_string { mean position }
  else report_left.eq := '';

  if parallax2 <> 1 then report_right.geo := 'geoc.' { warn for no parallax correction }
  else report_right.geo := '';

  if length(naam3) <> 0 then separ1 := #9+' ' else separ1 := '';   {#9 does not work in FPC in Tpanel (statusbar)}
  if length(naam4) <> 0 then separ2 := #9+' '  else separ2 := '';
  bar_hint := naam2 + #9 + magn_text + #9 + ra_text + #9 + dec_text + #9 +' '+
    spectr + separ1 + naam3 + separ2 + naam4;
  if mainwindow.Objectinfotoclipboard1.checked then Clipboard.AsText := bar_hint + #13 + #10; { info to clipboard }

  { note this to the end otherwise colors wrong !! }
  if ((mode < 6 + 6)) then { do not display spectral of stars in status bar }
  begin
    if length(naam3) <> 0 then separ1 := ' / '    else  separ1 := '';
    if length(naam4) <> 0 then separ2 := ' / '    else separ2 := '';
    if animation_running <> 2 then { 2016 }
    begin
      if ((mode >= -3) and (mode <= -1) and (form_animation.visible = false))
      then { comet/astroids give velocity info }
        bericht9 := comet_velocity
      else
        bericht9 := '';
      bar_hint := bar_hint + bericht9;
      mainwindow.statusbar1.caption :=
        (naam2 + separ1 + naam3 + separ2 + naam4 + '  ' +  convert_Abbreviations(spectr) + '   ' + descrip2 { spectr } + bericht9);
    end;
    { graphically to allow large then 135 charactors. Simpletext and graphical are drawn direct. panels[0], panels[1] after finished mainwindow }
  end
  else
  begin { stars }
    if (mode = 18) { ucac4 } then
    begin
        mainwindow.statusbar1.caption := naam2 + ' ' + ucac4_info;
        bar_hint:=bar_hint+', ' + ucac4_info;
    end
    else
    if (mode = 50) { gaia } then
    begin
      if ((magBP>0.01) and (magRP>0.01) and  (magBP-magRP>=-0.5) and (magBP-magRP<=2.75)) then {formula valid, can calculate Johnson-V}
      begin
        magn_info:=magG + 0.01760 + 0.006860 * (magBP-magRP) + 0.1732 * sqr(magBP-magRP);
        str(magn_info:3:1,bericht2);
        bericht2:=',  Johnson-V='+bericht2;
      end
      else
      bericht2:='';

       mainwindow.statusbar1.caption:='Gaia_id: ' + naam2 + '   Gmag='+Gmag+',  BPmag='+BPmag+',  RPmag='+RPmag+bericht2;
       bar_hint:=bar_hint+#9+'Gmag='+Gmag+#9+'BPmag='+BPmag+#9+'RPmag='+RPmag+bericht2;
    end
    else
    if ((mode =14){290file} and (Bp_Rp>-128)) then {Gaia color info available}
    begin
      bericht2:=', Bp-Rp= '+floattostrF_local(bp_Rp/10,3,1 );
      mainwindow.statusbar1.caption := (Star_string  + bericht2);
      bar_hint:=bar_hint+#9+bericht2;
    end
    else
    mainwindow.statusbar1.caption := (Star_string { + ' '+descrip2 } );
  end;

  if ((marker_telrad <> 0) or (marker_name <> 0)) then
  begin
    markers.font[markers_position] := mode;
    { font of 1 deepskynames, 2 star names, 3 deepskymag, 4 star magnitude, 5 time stamp }

    if mode >= 12 then font7 := 2 { stars } else begin font7 := 1; { deepsky } end; { stars/deepsky }
    { mode -3 comet, -1 asteroids,  1,3,5,7,9 supplements, 11 deepsky, 12,13 ...stars }
    { font of 1 deepskynames, 2 star names, 3 deepskymag, 4 star magnitude, 5 time stamp }
    skip_marker := false;
    for i := 0 to markers_position
      do { search for existing markers. If true skip }
    begin
      if ((abs(markers.ra[i] - ra2) < 1E-13) and
        (abs(markers.dec[i] - dec2) < 1E-13))
      then { 1E-13, compensate for small rounding error after loadsettings }
      begin
        skip_marker := true;
        markers.name[i] := ''; { do not display }
        markers.ra[i] := 999; { remove entry }
        markers.mode[i] := 0; { do not display }
        missedupdate := 2; { rewrite window }
        paint_sky; { rewrite window }
      end;;
    end;
    if ((skip_marker = false) and (found <> 2) { mouse search } ) then
    begin
      markers.mode[markers_position] := 0; { false }

      if marker_name = 1
      then { 2013, 2016, mark name but not with tekst search }
      begin
        if mode >= 12 then begin
          font7 := 2; { stars } end else begin
            font7 := 1; { deepsky } end; { stars/deepsky }
        { mode -3 comet, -1 asteroids,  1 suppl1, 3 suppl2, 5 deepsky, 7,8 ...stars }
        { font of 1 deepskynames, 2 star names, 3 deepskymag, 4 star magnitude, 5 time stamp }
        marker_name2(dc, ra2, dec2, font7, naam2);{write directly without repaint}
        markers.name[markers_position] := naam2;
        markers.mode[markers_position] := 0 { off }
      end
      else if marker_name = 2 then { mark magnitude }
      begin
        if mode >= 12 then begin font7 := 4; { stars magnitude } end else begin font7 := 3; { deepsky magnitude } end;
        { mode -3 comet, -1 asteroids,  1 suppl1, 3 suppl2, 5 deepsky, 7,8 ...stars }
        { font of 1 deepskynames, 2 star names, 3 deepskymag, 4 star magnitude, 5 time stamp }
        marker_name2(dc, ra2, dec2, font7, inttostr(mag2));
        markers.name[markers_position] := inttostr(mag2);
        markers.mode[markers_position] := 0 { off }
      end
      else if ((marker_name = 3) and (mode <= 5 + 6))
      then { mark time for solar objects only }
      begin
        font7 := 5; { underscore time,but text right alligned }
        if old_month2 <> month2 then bericht9 := copy(today2, 1, 10) else begin if old_day2 <> day2 then bericht9 := today2 else bericht9 := copy(today2, 13, 5); end;
        marker_name2(dc, ra2, dec2, font7, bericht9);
        markers.name[markers_position] := bericht9;
        if old_naam2 <> naam2 then { new solar object } markers.mode[markers_position] := -2 { move to } else markers.mode[markers_position] := 0; { line to }
        old_day2 := day2;
        old_month2 := month2;
        old_naam2 := naam2;
      end
      else
        markers.name[markers_position] := ''; { for telrad }

      if marker_telrad <> 0 then
      begin
        if mode >= 12 then begin font7 := 2; { stars telrad } end else  begin font7 := 1; { deepsky telrad } end;
        marker_telrad2(dc, ra2, dec2, font7);
        markers.mode[markers_position] := 1; { true }
      end;

      if ((marker_name <> 0) or (marker_telrad <> 0)) then
      begin
        markers.ra[markers_position] := ra2; { store RA }
        markers.dec[markers_position] := dec2; { store dec }
        markers.font[markers_position] := font7; { store font }
        if nr_markers < max_markers then inc(nr_markers, 1);
        if markers_position < max_markers then inc(markers_position, 1) else markers_position := 0;
      end;
    end; { skip_marker false }
  end;
  canvas_report; // see als write_field
end;

{%%%%%%%%}
function find_object(dc:tcanvas;searchmode:char):boolean;
var
   maxmode,i,star_nr               : integer;
   skip, error_index               : boolean;
   limitmagn2,sep1,pa              : double;
   s1                 : string;
   starn              : string;
begin
  Application.ProcessMessages; { 2016 read all messages !!!!! }

  //  if (size_pulled_rectangle>0) then exit;{fist check,  pull box mode ongoing?, yes then exit }
  skip := false; { disable jump over compare find }
  if searchmode = 'T' then mainwindow.statusbar1.caption :=searching_string+'  ' + goto_str;
  found:=0;
  limitmagn2 := limitmagn; { is later for GSC and UCAC4 adapted if 'T' search }
  if stars_activated = 0 then  maxmode := 11 { no stars search planets, supplement and deepsky only }
    else if ((searchmode = 'T') and (ord(goto_str[1]) >= 65)) then
  begin { do not search for letters in star database unless known star name }
    maxmode := 11; { till deepsky only }
    i:=0;
    repeat
      starn:=string(Bright_star_name[i]);
      if comparetext(goto_str, starn)=0 then
      begin
        maxmode:=14 ; {star name is known  search also in .DAT and .290 databases}
        ra2:=Bright_star_pos[i,0];
        dec2:=Bright_star_pos[i,1];
        telescope_ra:=ra2;telescope_dec:=dec2;{center for search routine, search in nearby area only}
        cos_telescope_dec:=cos(telescope_dec);{here to save CPU time. Used for field calcalculation cos(telescope_dec)}
        maxmag:=29;{search only in bright stars brighter then 2.9, makes it faster}
        searchmode:='X';{text search but without full field. Map already centered on bright star with telescope_ra, telecope_dec}
        i:=99999;{stop search}
      end;
      inc(i);
    until i>round(-1+sizeof(bright_star_pos)/8);
  end
  else
  begin
    maxmode := 99; { search in all databases including USNO if activated }
    if (searchmode = 'T') then limitmagn2 := 999; { for GSC und ucac4 }
  end;

  if searchmode = 'A' then maxmode := 11 { area search planetary and deepsky only }
     else if searchmode = 'P' then maxmode := -1; { planetary search }

  width2 := 0; { prevent funny result planets }
  type2 := ''; { make type2 empthy }
  spectr:= '';
  naam3 := ''; { make naam3 empthy }
  naam4 := ''; { make naam4 empthy }
  descrip2 := '';
  brightn:=999;  {required since brigthness -99,-98 is used to filter out magnitude of supplement text labels in magnitude writeinfo routine or for drawing, -1, -2}
                 {so a supplement could in some cases block writing magnitude of a star}
  orientation2:=999; {unknown, for export to server}

  lineposcatalog := 38; { first 47 lines are comments }

  if searchmode='D' then begin maxmode:=11; mode:=0;searchmode:='T' end {supplement and deepsky only}
  else
  mode:=-46;

  repeat
    newtime := gettickcount64;
    if (abs(newtime - oldtime) > 100) then
    begin
      mainwindow.image1.cursor := crwaitCursor;
      Application.ProcessMessages; { 2016 read all messages !!!!! }
      oldtime := newtime;
    end;
    if mode < 0 then
    begin
        case mode of
           -46: begin planet(0,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);{x_sun,y_sun,z_sun are also updated and accessible}
                      if ((planets_activated<>0) or (searchmode='T')) then
                        begin naam2:=Sun_string;planetnr:=0;{for rise set} type2:='P';{planet} inc(mode); end
                        else
                        begin skip:=true;{!!!} mode:=-4;{go to comets}end;
                end;
           -45: begin planet(9,2000,julian_et,ra2,dec2,mag,length2,delta,phase,phi);{pluto}
                      pluto_ra:=ra2;pluto_dec:=dec2;planet_mag:=mag;planet_dia:=length2;
                      if mag<1000 then naam2:=Pluto_string else naam2:='';
                      descrip2:=pluto_hint;{naam3} planetnr:=9;{for rise set} type2:='P';{planet}
                      inc(mode);
                end;
           -44: begin
                    planetmoons(9,1,julian_et,pluto_ra,pluto_dec,planet_mag,delta,{Charon}
                                              planet_dia,{var}ra2,dec2,mag,length2);
                      naam2:=Charon_string; descrip2:=moon_of_string+' '+Pluto_string;type2:='M';{moon}inc(mode);end;

           -43: begin planet(8,2000,julian_et,ra2,dec2,mag,length2,delta,phase,phi);naam2:=Neptune_string;
                      neptune_ra:=ra2;neptune_dec:=dec2;planet_mag:=mag;planet_dia:=length2;;
                      descrip2:=neptune_hint;{naam3} planetnr:=8;{for rise set}type2:='P';{planet}
                      inc(mode);
                end;
           -42: begin planetmoons(8,1,julian_et,neptune_ra,neptune_dec,planet_mag,delta,
                                              planet_dia,{var}ra2,dec2,mag,length2);
                      naam2:=Triton_string; descrip2:=moon_of_string+' '+Neptune_string;type2:='M';{moon}inc(mode);end;
           -41: begin planet(7,2000,julian_et,ra2,dec2,mag,length2,delta,phase,phi);naam2:=Uranus_string; planetnr:=7;{for rise set}type2:='P';{planet}
                      uranus_ra:=ra2;uranus_dec:=dec2;planet_mag:=mag;planet_dia:=length2;descrip2:=uranus_hint;{naam3}inc(mode);
                end;
           -40: begin planetmoons(7,1,julian_et,uranus_ra,uranus_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Ariel_string;descrip2:=moon_of_string+' '+Uranus_string;type2:='M';{moon} inc(mode);end;
           -39: begin planetmoons(7,2,julian_et,uranus_ra,uranus_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Umbriel_string;inc(mode); end;
           -38: begin planetmoons(7,3,julian_et,uranus_ra,uranus_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Titania_string;inc(mode); end;
           -37: begin planetmoons(7,4,julian_et,uranus_ra,uranus_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Oberon_string;inc(mode); end;
           -36: begin planet(6,2000,julian_et,ra2,dec2,mag,length2,delta,phase,phi);naam2:=Saturn_string;{xyz are also updated and accessible}
                      saturn_ra:=ra2;saturn_dec:=dec2;planet_mag:=mag;planet_dia:=length2;planetnr:=6;{for rise set}type2:='P';{planet}
                      mag:=mag-abs(0.4*ring_inc/(28*pi/180));  {correction magnitude for ring}
                      {down here, because planet_mag is used for moons}
                      descrip2:=saturn_hint;{naam3}
                      inc(mode);
                end;
           -35: begin planetmoons(6,1,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Mimas_string;descrip2:=moon_of_string+' '+Saturn_string; type2:='M';{moon}inc(mode);end;
           -34: begin planetmoons(6,2,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Enceladus_string;inc(mode); end;
           -33: begin planetmoons(6,3,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Tethys_string;inc(mode); end;
           -32: begin planetmoons(6,4,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Dione_string;inc(mode); end;
           -31: begin planetmoons(6,5,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Rhea_string; inc(mode);end;
           -30: begin planetmoons(6,6,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Titan_string;inc(mode);end;
           -29: begin planetmoons(6,7,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Hyperion_string;inc(mode); end;
           -28: begin planetmoons(6,8,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Iapetus_string;inc(mode);end;

           -27: begin planet(5,2000,julian_et,ra2,dec2,mag,length2,delta,phase,phi);naam2:=Jupiter_string;{xyz are also updated and accessible}
                      descrip2:=jupiter_hint;{naam3} planetnr:=5;{for rise set} type2:='P';{planet}
                      jupiter_ra:=ra2;jupiter_dec:=dec2;planet_mag:=mag;planet_dia:=length2;inc(mode);
                end;
           -26: begin planetmoons(5,1,julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);{xyz are also updated and accessible}
                      naam3:='I';naam2:=IO_string;descrip2:=moon_of_string+' '+Jupiter_string;type2:='M';{moon} inc(mode);end;
           -25: begin planetmoons(5,2,julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);{xyz are also updated and accessible}
                      naam3:='II';naam2:=Europa_string;inc(mode); end;
           -24: begin planetmoons(5,3,julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);{xyz are also updated and accessible}
                      naam3:='III';naam2:=Ganymede_string;inc(mode);end;
           -23: begin planetmoons(5,4,julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);{xyz are also updated and accessible}
                      naam3:='IV';naam2:=Callisto_string;inc(mode);end;
           -22: begin planet(4,2000,julian_et,ra2,dec2,mag,length2,delta,phase,phi);naam2:=Mars_string;
                      mars_ra:=ra2;mars_dec:=dec2;planet_mag:=mag;planet_dia:=length2;planetnr:=4;{for rise set}type2:='P';{planet}
                      planetnr:=4;descrip2:=mars_hint; naam3:='';{empty}inc(mode); end;
           -21: begin planetmoons(4,1,julian_et,mars_ra,mars_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Phobos_string; descrip2:=moon_of_string+' '+mars_string;type2:='M';{moon}inc(mode);end;
           -20: begin planetmoons(4,2,julian_et,mars_ra,mars_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                      naam2:=Deimos_string;inc(mode); end;

           -19: begin planet(2,2000,julian_et,ra2,dec2,mag,length2,delta,phase,phi);naam2:=Venus_string;
                      descrip2:=venus_hint;planetnr:=2;{for rise set} type2:='P';{planet} inc(mode);end;
           -18: begin planet(1,2000,julian_et,ra2,dec2,mag,length2,delta,phase,phi);naam2:=Mercury_string;
                      descrip2:=mercury_hint; planetnr:=1;{for rise set} type2:='P';{planet} inc(mode); end;
           -17: begin planet(10,2000,julian_et,ra2,dec2,mag,length2,delta,phase,phi);
                      naam2:=Moon_string;{moon moet eigenlijk achter asteroids and cometen maar geen probleem voor find routine only}
                      naam3:=Moon_string2; descrip2:=''; planetnr:=10;{re-calculate for riseset}
                      mode:=-4; {jump to comets initilize routine at -4} type2:='P';{planet} end;
           -4 : begin skip:=true; {no action after this}
                      type2:='';{for mode'A'}
                      planetnr:=-1;{do not re-calculate for riseset}
                      if (comets_activated<>0) then begin linepos:=0;type2:=comet_string;descrip2:=Comet_string;inc(mode);{readposition:=0;} errors[0,1]:=0;{FOR ERROR COLOROURING} end else inc(mode,2);{jump to asteroids} end;
           -3 : begin
                  read_comet(searchmode);
                  if mode=-2 then  skip:=true;;
                end;
           -2 : begin skip:=true;; {no action after this}
                      if (asteroids_activated<>0) then begin linepos:=0;type2:=asteroid_string;descrip2:=Asteroid_string; inc(mode);{readposition:=0;} errors[1,1]:=0;{FOR ERROR COLOROURING} end else inc(mode,2);{jump to supplements} end;
           -1 : begin {asteroids}
                  read_asteroid(searchmode);
                  if mode=0 then skip:=true; {leave, next time suppl1}
                end;
        end; {case}
      length2:=length2*(10/60);
      mag2:=trunc(10*mag);
    end{planets, solar objects}
    else
    begin   {mode -3=comet, -1=asteroids,  1=suppl1, 3=suppl2,.. 9=suppl5,  11=deepsky, 12,13 ...stars}
      case mode of
          0: begin skip:=true; {no action after this} if (suppl1_activated<>0) then
               begin inc(mode);linepos:=0; {readposition:=0;} errors[1+1,1]:=0;{FOR ERROR COLOROURING, before skip}worldmap:=pos('WORLD',Uppercase(name_supl1))>0;end
               else inc(mode,2);{jump to second suppl} end; { for suppplement }
          1: read_supplement(searchmode,1); {supplement1 }
          2: begin skip:=true; {no action after this} if (suppl2_activated<>0) then
                begin inc(mode);linepos:=0; {readposition:=0;} errors[2+1,1]:=0;{FOR ERROR COLOROURING, before skip}worldmap:=pos('WORLD',Uppercase(name_supl2))>0;end
                  else inc(mode,2);{jump to deepsky} end; { for suppplement }
          3: read_supplement(searchmode,2); {supplement2 }
          4: begin skip:=true; {no action after this} if (suppl3_activated<>0) then
                   begin inc(mode);linepos:=0;{ readposition:=0;} errors[3+1,1]:=0;{FOR ERROR COLOROURING, before skip}worldmap:=pos('WORLD',Uppercase(name_supl3))>0;end
                   else inc(mode,2);{jump to deepsky} end; { for suppplement }
          5: read_supplement(searchmode,3); {supplement1 }
          6: begin skip:=true; {no action after this} if (suppl4_activated<>0) then
                   begin inc(mode);linepos:=0; {readposition:=0;} errors[4+1,1]:=0;{FOR ERROR COLOROURING, before skip}worldmap:=pos('WORLD',Uppercase(name_supl4))>0;end
                   else inc(mode,2);{jump to deepsky} end; { for suppplement }
          7: read_supplement(searchmode,4); {supplement1 }
          8: begin skip:=true; {no action after this} if (suppl5_activated<>0) then
                   begin inc(mode);linepos:=0; {readposition:=0;} errors[5+1,1]:=0;{FOR ERROR COLOROURING, before skip}worldmap:=pos('WORLD',Uppercase(name_supl5))>0;end
                   else inc(mode,2);{jump to deepsky} end; { for suppplement }
          9: read_supplement(searchmode,5); {supplement1 }

        10: begin  {deep sky}
               skip:=true; {no action after this}
               descrip2:='';
               if ((deep_database<>0) or (searchmode='T')) {always text search in standard database}
                 then begin inc(mode); linepos:=2; {first lines are comments} end
                      else inc(mode,2);{jump to stars} end;
         11: read_deepsky(searchmode); {deepsky}
         12: begin   {Star databases}
               skip:=true; {no action after this}
               brightn:=999;  {required since brigthness -99,-98 is used to filter out magnitude of supplement text labels in magnitude writeinfo routine or for drawing, -1, -2}
                              {so a supplement could in some case block writing magnitude of a star}
               naam3:='';{make naam3 empthy}
               naam4:='';{make naam4 empthy}
               type2:='';{make star names empthy}
               spectr:='';{clear any deepsky info}
               length2:=0;{for star auto zoom}
               orientation2:=999; {unknown, for export to server}
               case stardatabase_displayed of
                        1:begin
                            mode:=17;  {do UCAC later}
                            spectr:=star_string;
                          end;
                        2:  begin  onlinefieldcounter:=0; mode:=20; spectr:=star_string;end; {UCAC 4 online}
                        3:  begin  onlinefieldcounter:=0; mode:=30; spectr:=star_string;end; {NOMAD online}
                        4:  begin  onlinefieldcounter:=0; mode:=40; spectr:=star_string;end; {URAT online}
                        5:  begin  onlinefieldcounter:=0; mode:=50; spectr:=star_string;end; {GAIA online}
                        6:  begin  onlinefieldcounter:=0; mode:=60; spectr:=star_string;end; {PPMXL online}
                            else
                            begin
                              if stardatabase_displayed=0 then
                               begin
                                 opendatabase2(name_star);
                                 mode:=13;{.dat star databases}
                              end
                              else mode:=14;{.290 star databases}
                              area290:=290+1; {reset for readdatabase290 !!!!}
                             end
                        end;{case}
               end;
         13: read_star(searchmode); {.dat star database search}
         14: begin
               naam2:=''; {clear for 5, 6 and 7 bytes records to prevent ghost names}
               readdatabase290(searchmode);{.290 star databases}
               if naam2='' then naam2:={copy(name_star,1,1)+}prepare_IAU_designation(ra2,dec2);
             end;
          17: begin {USNO UCAC4 find region}
               skip:=true; {no action after this}
               inc(mode);
               if (searchmode='T') then begin s1:=goto_str; i:=pos('-',s1); if I>0 then delete(s1,i,1); val(s1,star_nr,i); if i>0 then mode:=100; {error, stop} end
               else star_nr:=0; {mouse search, do not move to regio}
               findregionUCAC4(dc,path_ucac4,telescope_ra,telescope_dec,limitmagn2,star_nr,error_index);
               if error_index=true then mode:=100; {stop}
             end;
         18: begin {USNO UCAC4 read from local copy}
               read_UCAC4(dc,equinox_date,ra2,dec2,mag2);{Read local UCAC4 star database, starnr in naam2}
               if mag2=10000 then begin closeUSNO; mode:=100; naam2:=''; end{einde}
             end;
         20: begin {online catalog_read}
               read_UCAC4catalog(searchmode);
             end;
         30: begin {online catalog_read}
               read_NOMADcatalog(searchmode);
             end;
         40: begin {online catalog_read}
               read_URATcatalog(searchmode)
             end;
         50: begin {online catalog_read}
               read_GAIAcatalog(searchmode)
             end;
         60: begin {online catalog_read}
               read_PPMXLcatalog(searchmode)
             end;
      end;{case}
    end;{deepsky}

    if skip = false then { no initilize step }
    begin
      if searchmode = 'M' then
      begin
        plot_pixel_sphere(dc, ra2, dec2, -99, $0, 0, 0); { mouse click search }
        if ((zc > 0) and (abs(mx - x9) < 5) and (abs(my - y9) < 5)) then
        begin
          found:=1;
          if (mode = 18) then
          begin
            ucac4_info := '';
            if mass_id_nr <> 0 then { 2mass number available }
            begin
              str(mass_id_nr, tempstr); { 2mass id number }
              ucac4_info := ';2M' + tempstr;
            end;
            if uc4_source >= 900000000 then
            ucac4_info := ucac4_info + ';HIP *' { some hipparcos info }
            else if uc4_source >= 800000000 then ucac4_info := ucac4_info + ';FK6 *'
            else if uc4_source >= 700000000 then ucac4_info := ucac4_info + ';HIP *'
            else if uc4_source >= 600000000 then ucac4_info := ucac4_info + ';FK6 *'
            else if uc4_source >= 500000000 then ucac4_info := ucac4_info + ';Tycho annex-2 *'
            else if uc4_source >= 400000000 then ucac4_info := ucac4_info + ';Tycho annex-1 *'
            else if uc4_source >= 300000000 then ucac4_info := ucac4_info + ';Tycho-2 *'
            else if uc4_source >= 200000000 then ucac4_info := ucac4_info + ';Hipparcos double star annex'
            else if uc4_source >= 100000000 then ucac4_info := ucac4_info + ';Hipp *';

            ucac4_info:=ucac4_info+star_class(apass_b_v/1000, apass_error/100)

          end; { add UCAC4 info }
          write_info(dc{, true});
          { else write info in paint procedure, bar_hint is also here created }
        end;
      end
      else
      if searchmode = 'A' then
      begin
        ang_sep(ra2,dec2,popupmouse_RA,popupmouse_dec,sep1);
        if SEP1<=sep_height*((1/1.4159)*pi/(180*60)) then
        begin
          ra_text:=prepare_ra(ra2);
          dec_text:=prepare_dec(dec2);
          str(mag2/10:6:1,magn_text);
          if  ((mode>=-3) and (Mode<=-1)) then {comet/astroids give velocity info}
          foundstring1.Append(naam2+#9+magn_text+#9+ra_text+#9+dec_text+#9+type2+#9+comet_velocity) {comet/asteroid info }
          else
          foundstring1.Append(naam2+#9+magn_text+#9+ra_text+#9+dec_text+#9+spectr);  {info to foundstring1}
          if type2='P' then
          begin
            Precession(2451545.0{J2000},julian_ET,ra2,dec2,ra2,dec2);{ long term precession function in hns_Uprs}
            foundstring1.Append('Mean position:'+#9+prepare_ra(ra2)+#9+prepare_dec(dec2));
            if ((de430_emphemeris<>0) and (type2='P')) then{planet in DE430}
            begin
              nutation_correction_equatorial(ra2,dec2);
              aberration_correction_equatorial(ra2,dec2);{aberration based on earth vectors. Only valid when DE430 is used}
            end
            else{classic}
               nutation_aberration_correction_equatorial_classic(ra2,dec2);{calculate apparent pos, M&P page 208}
            foundstring1.Append('Apparent position:'+#9+prepare_ra(ra2)+#9+prepare_dec(dec2));
            foundstring1.Append('UT '+ JdToDate(julian_ut)+' JD='+floattostrF(julian_UT,ffgeneral,12,5)+ ', DeltaT correction '+prepare_time(delta_T(julian_ut)));
          end;
          foundstring1.Append('');{add an empthy line}
        end;
      end
      else { text search }
      begin
        if ((comparetext(goto_str, naam2) = 0) or
            (comparetext(goto_str, type2) = 0) or
            (comparetext(goto_str, naam3) = 0) or
            (comparetext(goto_str, naam4) = 0)) then
        begin
          found:=2; { menu search found }
          if auto_center = false then
                                         write_info(dc ); { else write info in paint procedure }
        end;
      end;
    end
    else skip := false;
  until ((mode > maxmode { 7 } ) or (found <> 0));{end of repeat}
  { continue till end or found }

  if found <> 0 then
  begin  {after writeinfo the position are converted to the equinox as specified}
    closedatabase;
    closeUSNO;
    find_object := true;
    found_name:=naam2;{for line draw and for edit_supplement_entry}
    found_ra2:=ra2;{for edit_supplement_entry}
    found_dec2:=dec2;
    found_mag2:=mag2;
    found_type2:=spectr;
    found_brightn:=brightn;
    found_descrip2:=descrip2;{descrip2:=data1; brightn:=0   could contain double star data }
    found_length2:=length2;
    found_width2:=width2;
    found_orientation2:=orientation2;{in degrees}
    found_mode:=mode; {remember in which database object was found}

    if ((found_mode>=1) and (found_mode<=9)) then {update hints to show edit of supplement is possible}
    begin
      mainwindow.right3.cursor:=crHandPoint;
      mainwindow.right4.cursor:=crHandPoint;
      mainwindow.right5.cursor:=crHandPoint;
      mainwindow.right6.cursor:=crHandPoint;
      mainwindow.right7.cursor:=crHandPoint;
      mainwindow.right8.cursor:=crHandPoint;
      mainwindow.right9.cursor:=crHandPoint;
      mainwindow.left3.cursor:=crHandPoint;
      mainwindow.left4.cursor:=crHandPoint;
      mainwindow.left5.cursor:=crHandPoint;
      mainwindow.left6.cursor:=crHandPoint;
      mainwindow.left7.cursor:=crHandPoint;
      mainwindow.left8.cursor:=crHandPoint;
      mainwindow.left9.cursor:=crHandPoint;
    end
    else
    begin
      mainwindow.right3.cursor:=crnormalcursor;
      mainwindow.right4.cursor:=crnormalcursor;
      mainwindow.right5.cursor:=crnormalcursor;
      mainwindow.right6.cursor:=crnormalcursor;
      mainwindow.right7.cursor:=crnormalcursor;
      mainwindow.right8.cursor:=crnormalcursor;
      mainwindow.right9.cursor:=crnormalcursor;
      mainwindow.left3.cursor:=crnormalcursor;
      mainwindow.left4.cursor:=crnormalcursor;
      mainwindow.left5.cursor:=crnormalcursor;
      mainwindow.left6.cursor:=crnormalcursor;
      mainwindow.left7.cursor:=crnormalcursor;
      mainwindow.left8.cursor:=crnormalcursor;
      mainwindow.left9.cursor:=crnormalcursor;
    end; {update hints}

    if ((searchmode in ['T','X']) and (auto_zoom)) then
    begin
      if ((length2=0)  and (mode>=-5)) then zoom:=5 {stars}
      else zoom:=(5000/(length2+3));
    end;{autozoom}

    {$IFDEF fpc}
    if server_on then {search request via TCP outstanding} // echo to all if TCP
    begin
      if orientation2<>999{unknown} then pa:=orientation2*pi/180 {orientation is in degrees} else pa:=pi/2;{orientation2 is in degrees}
      mainwindow.SendToAll(floattostrF_local(found_ra2,0,7)+' ' + floattostrF_local(found_dec2,0,7)+' '+found_name+' '+floattostrF_local(pa,0,7)) ;{send object info in radians}
    end;
    {$ELSE} {delphi}
    {$ENDIF}
  end
  else
  if searchmode<>'A' then {don't show ???? for internal search}
  begin
    found_name := ''; { for line draw }
    if mainwindow.Objectinfotoclipboard1.checked then Clipboard.AsText:='????'+#10;
    bar_hint := '????';
    find_object := false;
    missedupdate:=0;
    canvas_object_message('????',colors[25]);//{this left4='????' is tested in mouse up event}

    mainwindow.statusbar1.caption := ('????');
    { As last status bar otherwise background of ???? is changed !!!! }
  end
  else mainwindow.image1.cursor:=crdefault;{show default cursor in Linux while internal search report window is open}

  if (mode < 0) { solar }
  then { 2015 update lock and follow names, both in 'M' search or 'T' search }
  begin
    if (mainwindow.Followsolarobject1.checked = false)  then { only update name when menu option is not checked }
    begin { follow solar object with telescope }
      mainwindow.Followsolarobject1.Caption := follow_string + ' ' +  naam2; { 2015 }
      if ((mode < -25) or (mode > -22)) { not moons jupiter IO<>I } then follownaam2 := naam2 { store follownaam2 solar to keep centered }
      else  follownaam2 := naam3; { store follownaam2 solar to keep centered }
      mainwindow.Followsolarobject1.enabled :=((mainwindow.connect_telescope1.checked = true) and (actualtime = true)); { enable is connected }
    end;

    if searchmode <> 'P'
    then { do not update combobox when find is used for locking }
    begin
      if ((mode < -25) or (mode > -22)) then { not moons jupiter IO<>I } form_animation.planetary_combobox.items.add(naam2) { 2015-12 add  to follow list }
      else  form_animation.planetary_combobox.items.add(naam3);   { 2015-12 add  to follow list }
      if form_animation.planetary_combobox.items.count > 10 then  form_animation.planetary_combobox.items.delete(0);{ do not allow more then 10 }
      form_animation.planetary_combobox.ItemIndex := form_animation.planetary_combobox.ItemIndex + 1; { show selected object }
      if form_animation.lock_on_name.checked then locknaam2:=form_animation.planetary_combobox.text;
    end;
  end;
end;

procedure draw_moon(dc:tcanvas;diameter,phase,orientation:double);
const nr =40;
var   moon :array[0..nr] of tpoint;
      i    : integer;
      xx,yy                          :double;
      sin_pinr,cos_pinr              :double;
      sin_orientation,cos_orientation:double;

begin   {ras 0..2pi, decs -pi/2..pi/2,latitude  size of nul pixel else cirkel with size size}
        {sphere with radius 1}

  phase:=(2*phase-1);
  for i:=0 to nr do
  begin
    if i<(nr*0.5) then
    begin
     sincos(orientation,sin_orientation,cos_orientation);
     sincos(pi*i*2/nr,sin_pinr,cos_pinr);

     xx:=cos_pinr*cos_orientation-phase*sin_pinr*sin_orientation;
     yy:=cos_pinr*sin_orientation+phase*sin_pinr*cos_orientation;
    end
       else
       begin
         sincos(orientation+pi*i*2/nr, yy,xx);
       end;
       moon[i].x:=round(x9 -diameter*xx);
       moon[i].y:=round(y9 -diameter*yy);
   end;
  {$IFDEF fpc}
   dc.polygon(moon,nr);
  {$ELSE} {delphi}
   polygon(dc.handle,moon,nr);
  {$ENDIF}
end;

procedure plot_orbit (dc:tcanvas;pen_main: hpen; planet,startmoon,stopmoon:integer); {draw moon orbit}
var
     U,step,ra3,dec3,magm,geo_long,dia{,sep}         : double;
begin
  selectobject(dc.handle,pen_main);
  repeat
    dia:=0;
    step:=10+trunc(1+(zoom*moon_data[planet,startmoon,0])/(0.005*delta));
    if step>450 then step:=450;
    repeat
      U:=dia*2*pi/step;
      magm:=0; {important to reset}
      MOON_RADEC(planet,startmoon,U ,delta,planet_dia,ra2,dec2, geo_long,magm,ra3,dec3);
           {with RA2,DEC2 so is parallax included !!!}
      if dia=0 then plot_pixel_sphere(dc,ra3,dec3,-2,$0,0,0)   {move to}
      else
      begin
        if magm=999 then begin plot_pixel_sphere(dc,ra3,dec3,-2,$0,0,0);   {move to} end
        else if magm>=1000 then begin selectobject(dc.handle,pen_bound);plot_pixel_sphere(dc,ra3,dec3,-1,$0,0,0) ;selectobject(dc.handle,pen_main); end
        else begin plot_pixel_sphere(dc,ra3,dec3,-1,$0,0,0) ;end;
      end;

      dia:=dia+1;
    until (( round(dia)>step+1) or (zc<0));
    inc(startmoon);
  until ((startmoon>stopmoon) or (zc<0));
end;

procedure plot_glx(dc:tcanvas;ra,dec,diameter,orientation3:double;contour:integer); {draw oval or galaxy}
var   glx :array[0..127 {nr}+1] of tpoint;
      i,nr           : integer;
      r,orientation,neigung              : double;
      xx,yy,sin_ori,cos_ori              : double;

begin
   plot_pixel_sphere(dc,ra,dec+0.5/zoom,-99,$FFFFFF,0,0);{find angle on screen with two plot_pixel calls}
   if zc<0 then exit;
   xx:=x9;yy:=y9;
   plot_pixel_sphere(dc,ra,dec,-99,$FFFFFF,0,1);{load also win95 hints part in plot_pixel}
   if zc<0 then exit;

   xx:=xx-x9; if abs(xx)<0.00001 then xx:=0.00001; {prevent divide zero}
   orientation:=arctan((yy-y9)/xx);

   if fliph<0 then orientation3:= - orientation3; {flipping result in object orientation change, 45 degrees right becomes 45 degrees left}
   if flipv<0 then orientation3:= - orientation3; {flipping result in object orientation change}

   orientation:=orientation  - orientation3;
   neigung:=(width2/length2);{ratio galaxy}

   if diameter<10 then nr:=22
   else if diameter<20 then nr:=44
   else nr:=127;

  if abs(neigung)<0.00001 then neigung:=0.00001;{show ring always also when it is flat}
   for i:=0 to nr+1 do
   begin
     r:=sqrt(sqr(diameter*neigung)/(1.00000000000001-(1-sqr(neigung))*sqr(cos(-pi*i*2/(nr))))); {radius ellips}
      sincos(orientation+pi*i*2/nr, sin_ori, cos_ori);
     glx[i].x:=round(x9    +r * cos_ori );
     glx[i].y:=round(y9    +r * sin_ori );
   end;
    {$IFDEF fpc}

     if contour=0 then dc.polygon(glx,nr+1) else polyline(dc.handle,glx,nr+1);
     //dc.polyline(glx,nr+1);doesn't work for polyline ?????

    {$ELSE} {delphi}
     if contour=0 then polygon(dc.Handle,glx, nr+1) else polyline(dc.handle,glx,nr+1);//polygon(dc.handle,glx,nr+1) else polyline(dc.handle,glx,nr+1);
    {$ENDIF}
end;

procedure mouse_radec(dc:tcanvas;xm,ym: integer;var raok,decok:double); {find mouse position with sort routine}
var
     ra7,dec7 : longint;
     rax,decx,ratry,dectry,delt,deltan,step,step_reduction:double;
const
    tolerance1=1.42;{accuracy relaxed, one pixel in x and y equals sqrt(2)}

  begin
    raok:=0;decok:=0;
    decx:=telescope_dec; rax:=telescope_ra;
    step:=0.5;

    if projection=2  then
       step_reduction:=2.5  {cylindrical, optimized for finding all positions, do not change before checking all area's!}
    else
       step_reduction:=1.99; {ortho. Optimized for poles, do not change unless check near pole accuracy}

    repeat
    begin
      step:=step*step_reduction;
      delt:=999999999;
         for ra7:=-1 to 1 do
         begin
           for dec7:=-1 to 1 do
           begin
              ratry:=raok+ra7*pi/step;
              dectry:=decok+(dec7*pi/2)/step;
              plot_pixel_sphere(dc,ratry,dectry,-99,$0,0,0);{mouse click search}
              if zc>0 {in sight}
              then
              begin
                 deltan:=(sqr(ym-y9) +sqr(xm-x9));
                 if deltan<delt then
                   begin decx:=dectry; rax:=ratry;delt:=deltan; end; {best solution so far}
              end;
           end;
         end; {ra7}
         raok:=rax;
         decok:=decx;
     end;
    until ((step>64000 *16)  or (delt<=tolerance1 {4}));
    if abs(decok)>pi/2 then
    begin
      raok:=raok+pi;
      if decok>0 then decok:=pi-decok else decok:=-pi-decok; {make from 100  80 degrees}
    end;
    raok:=limit_radialen(raok,2*pi);
end;

procedure plot_earth(dc:tcanvas);
var
   resolution,dia,tel,lowestx9,highestx9,lowesty9,highesty9 :integer;
   xxx,yyy,height9,delta1 : double;
   points: array[0..3] of tpoint;
   orien : string;
   oldx9, oldy9   : integer;

begin  {plot earth}

  if (((grid=1){ra,dec grid} and (colors[11]=colors[31])) or (colors[31]=0)) then exit; {don't plot horizon if it has the same colour as the ra,dec grid or when it is black}

  dc.brush.Color:=colors[31];{horizon}
  selectobject(dc.handle,pen_horizon);
  if Zoom>2 then resolution:=2 else resolution:=4;

  if ((earth<>0) and (zoom<=8) and ((projection<>1) or (zoom>0.75))) then
  begin
    case projection of

    2:{cylindrical projection}
    begin
      lowestx9:= +99999;
      highestx9:=-99999;
      lowesty9:= +99999;
      highesty9:=-99999;
      for dia:=0 to ((72*resolution)-1) do
      begin
        az_ra((dia)*pi/(36*resolution),apparent_horizon                ,reallatitude,0,wtime2actual,xxx,yyy);{calculate ra and dec }
        ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}
        plot_pixel_sphere(dc,xxx, yyy,-2,$FFFFFF,0,0);  {Altitude grid}
        if  ((zc<>-1) and (x9<lowestx9)) then lowestx9:=x9;
        if  ((zc<>-1) and (x9>highestx9)) then highestx9:=x9;;
        if lowestx9< rrw.left then lowestx9:=rrw.left;{use file canvas size of image1 including image1 overlap}
        if highestx9> rrw.right+image_overlap+image_overlap then highestx9:=rrw.right+image_overlap+image_overlap;

        if  ((zc<>-1) and (y9<lowesty9)) then lowesty9:=y9;
        if lowesty9< rrw.top {0} then lowesty9:=rrw.top;

        az_ra((dia)*pi/(12*resolution),apparent_horizon - (30*pi/(180)),reallatitude,0,wtime2actual,xxx,yyy);{calculate ra and dec }
        ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}
        plot_pixel_sphere(dc,xxx, yyy,-2,$FFFFFF,0,0);  {Altitude grid}
        if  ((zc<>-1) and (y9>highesty9)) then highesty9:=y9;;
         //      if highesty9> rrw.bottom+200 then highesty9:=rrw.bottom;
      end;
      highesty9:=round((highesty9-lowesty9)* 3 +lowesty9);
      if highesty9> rrw.bottom+image_overlap+image_overlap then highesty9:=rrw.bottom+image_overlap+image_overlap;{use file canvas size of image1 including image1 overlap}
      points[0]:=Point(lowestx9 ,lowesty9);
      points[1]:=Point(highestx9,lowesty9);
      points[2]:=Point(highestx9,highesty9);
      points[3]:=Point(lowestx9 ,highesty9);
     {$IFDEF fpc}
       dc.Polygon(points,4)
     {$ELSE} {delphi}
       Polygon(dc.handle,points,4)
     {$ENDIF}
    end;{2:}
    0,1 : {ortho, azimuthal}
      begin
        for tel:=0 to 17 do
        for dia:=0 to ((24*resolution)-1) do
        begin
          if tel<17 then height9:=5.7 else height9:=4.0; {goede overlapping totdat vlak bij pole, 5,7 i.p.v 5,2 nodig voor sommige grapische kaarten}
          az_ra((dia)*pi/(12*resolution),apparent_horizon - (tel*5*pi/(180)),reallatitude,0,wtime2actual,xxx,yyy );{calculate ra and dec }
          if tel=0 then ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}
          plot_pixel_sphere(dc,xxx, yyy,-2,$FFFFFF,0,0);  {Altitude grid}
          points[0]:=Point(x9,y9);
          if ((zc=-1) or (x9<rrw.left) or (x9>rrw.right+image_overlap+image_overlap) or (y9<rrw.top{0}) or (y9>rrw.bottom+image_overlap+image_overlap))=false then
          begin
            az_ra((dia+1)*pi/(12*resolution),apparent_horizon - (tel*5*pi/(180)),reallatitude,0,wtime2actual,xxx,yyy );{calculate ra and dec }
            if tel=0 then ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}
            plot_pixel_sphere(dc,xxx, yyy,-2,$FFFFFF,0,0);  {Altitude grid}
            points[1]:=Point(x9,y9);
            if ((zc=-1) or (x9<rrw.left) or (x9>rrw.right+image_overlap+image_overlap) or (y9<rrw.top{0}) or (y9>rrw.bottom+image_overlap+image_overlap))=false then
            begin
              az_ra((dia+1)*pi/(12*resolution), - (tel*5 +height9)*pi/(180),reallatitude,15*pi/180,wtime2actual,xxx,yyy );{calculate ra and dec }
              plot_pixel_sphere(dc,xxx, yyy,-2,$FFFFFF,0,0);  {Altitude grid}
              points[2]:=Point(x9,y9);
              if ((zc=-1) or (x9<rrw.left) or (x9>rrw.right+image_overlap+image_overlap) or (y9<rrw.top{0}) or (y9>rrw.bottom+image_overlap+image_overlap))=false then
              begin
                az_ra(dia*pi/(12*resolution), - (tel*5 + height9)*pi/(180),reallatitude,15*pi/180,wtime2actual,xxx,yyy );{calculate ra and dec }
                plot_pixel_sphere(dc,xxx, yyy,-2,$FFFFFF,0,0);  {Altitude grid}
                points[3]:=Point(x9,y9);
                if ((zc=-1) or (x9<rrw.left) or (x9>rrw.right+image_overlap+image_overlap) or (y9<rrw.top{0}) or (y9>rrw.bottom+image_overlap+image_overlap))=false then
                begin
                 {$IFDEF fpc}
                  dc.Polygon(points,4)
                 {$ELSE} {delphi}
                  Polygon(dc.handle,points,4)
                 {$ENDIF}
                end;
              end;
            end;
          end;
        end;
      end;{one case}
    end;{case}

  end {fill earth}
  else
  if colors[31]<>colors[0] then {extra do this only if the horizon colour is visible}
  begin {plot horizon as a line}
    for dia:=0 to 24*resolution do {plot horizon2}
    begin
      az_ra(dia*pi/(12*resolution),apparent_horizon,reallatitude,0,wtime2actual,xxx,yyy );{calculate ra and dec }

      ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}

      if (dia=0) then plot_pixel_sphere(dc,xxx, yyy,-2,0,0,0); {-2 is move action}
      plot_pixel_sphere(dc,xxx, yyy,-1,0,0,0);
    end;
  end; {plot horizon as a line}

  selectfont3(dc);
  setTextColor(dc.handle,colors[16]{ $0000A0});


  for dia:=0 to 7 do {N, S,E, W}
  begin
    {find orientation first}
    az_ra(dia*pi/(4)-0.1,apparent_horizon {+ (dc.TextHeight('N')/1000)/zoom },reallatitude,0,wtime2actual,xxx,yyy );{calculate ra and dec }
    ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}
    plot_pixel_sphere(dc,xxx-0.01, yyy,-2,0,0,0); {-2 is move action}
    oldx9:=x9; oldy9:=y9;
    {end find orientation}

    az_ra(dia*pi/(4),apparent_horizon {+ (dc.TextHeight('N')/1000)/zoom},reallatitude,0,wtime2actual,xxx,yyy );{calculate ra and dec }
    ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}

    plot_pixel_sphere(dc,xxx, yyy,-2,0,0,0); {-2 is move action}
    if ((zc>0) and (x9<Rrw.right+image_overlap+image_overlap) and (x9>Rrw.left {0}) and (y9>rrw.top{0}) and (y9<rrw.bottom+image_overlap+image_overlap)) then  {prevent to write outside image1 otherwise at funny places text}
    begin
       case dia of 6: orien:='W';   {do not use dc.textout otherwise error}
                   5: orien:='SW';
                   4: orien:='S';
                   3: orien:='SE';
                   2: orien:='E';
                   1: orien:='NE';
                   0: orien:='N';
                   7: orien:='NW';
       end;{case}
       delta1:=x9-oldx9;
       if abs(delta1)<0.00001 then delta1:=0.00001; {prevent divide zero}
       AngleTextOut_center_alligned(dc,arctan2(-(y9-oldy9),delta1),  x9,y9,orien);
       {gedraaid}
     end;
  end;{letters}
end;

//procedure find_dome_contour(alt_test: double; var found_az, found_alt:double); {brute force method, very very slow}
//var  tel,dia,xxx,yyy,resolution,halfdomehole    : integer;
//     az1,alt1, sep1,sep2,old_delta_sep, delta_sep :double;
//
//begin
//  resolution:=50; {50 best but take 2 hours or so, else take 1 or 2 }
//  halfdomehole:=15; {15 is 30 degrees wide}
//  old_delta_sep:=999;
//  for xxx:=-halfdomehole*resolution to 90*resolution do {altitude}
//  begin
//     for yyy:=halfdomehole*resolution to 180*resolution do {azimuth}
//     begin
//       az1:=yyy*pi/(180*resolution);
//       alt1:=xxx*pi/(180*resolution);
//       ang_sep(0,alt_test,az1,alt1,sep1);{horizontal distance}
//       ang_sep(halfdomehole*pi/180,0,az1,alt1,sep2);{vertical distance from horizon}
//       if ((abs(sep1-halfdomehole*pi/180)<old_delta_sep) {horizontal condition}
//       and
//       (abs(sep2-alt_test)<pi/(180*resolution)))  {vertical condition}
//       then
//       begin
//         found_az:=az1;
//         found_alt:=alt1;
//         old_delta_sep:=abs(sep1-halfdomehole*pi/180);
//       end;
//     end;
//  end;
//end;

{procedure write_dome_contour;
var tel : integer;
    f   : TextFile;
    found_az, found_alt      : double;
begin
  assign(f,'dome.txt');
  rewrite(f);
  for tel:=0 to 35 do
  begin
    find_dome_contour(tel*3*pi/180,found_az, found_alt);
    writeln(f,'('+floattostr(found_az)+','+floattostr(found_alt)+'),');
  end;
  close(f);
end;}

//procedure PLOT_DOME(dc:tcanvas;ra_m2,dec_m2:double);
// const
//   dome_contour : array[0..35 {heigth},0..1 {az,alt}] of single= {in steps 3 degrees, 0 to 105 degrees, 30 degrees opening }
//  ((0.261799387799149,0),                               {build with procedure find_dome_contour}
//   (0.262148453649548,0.052010811709431),
//   (0.263195651200745,0.104370689269261),
//   (0.264940980452739,0.156730566829091),
//   (0.26773350725593,0.20943951023932),
//   (0.271224165759919,0.261799387799149),
//   (0.275412955964705,0.314159265358979),
//   (0.280648943720688,0.36617007706841),
//   (0.286583063177469,0.418180888777841),
//   (0.293913446035845,0.470191700487272),
//   (0.302291026445418,0.521853446346304),
//   (0.312413936106985,0.574213323906134),
//   (0.323933109170148,0.625875069765167),
//   (0.336848545634906,0.676838683923401),
//   (0.352207443052456,0.728151363932034),
//   (0.370009801422798,0.779464043940668),
//   (0.39095375244673,0.830427658098902),
//   (0.415039296124252,0.88034407470594),
//   (0.443662695856959,0.930260491312978),
//   (0.477522083345649,0.979478776219218),
//   (0.517664656141518,1.02730079772386),
//   (0.566533875197359,1.07477375337811),
//   (0.625875069765167,1.12015231392996),
//   (0.69882983249853,1.16378554522982),
//   (0.789936019452634,1.20497531557689),
//   (0.903033354981866,1.24197629571916),
//   (1.04231062929101,1.27339222225506),
//   (1.21405102768726,1.29817589763338),
//   (1.41127323316262,1.31318572920053),
//   (1.62385433605552,1.31702545355492),
//   (1.83154851704285,1.30899693899575),
//   (2.02388380061262,1.29014738307421),
//   (2.1848031576465,1.2625711808927),
//   (2.31709911494767,1.22801366170321),
//   (2.42286606761853,1.18856922060814),
//   (2.50978346436785,1.14493598930828)   );

//var  tel    : integer;
//     xxx,yyy : double;
//begin
//  mainwindow.Canvas.Pen.color:=clblue;
//  mainwindow.Canvas.Pen.Mode := pmNotXor;	{ use XOR mode to draw/erase }
//  dec_m2:=min(dec_m2,pi/2);{protection}
//  dec_m2:=max(dec_m2,0);
//  ra_m2:=min(ra_m2,2*pi);
//  ra_m2:=max(ra_m2,0);

//  for tel:=0 to round(dec_m2*(30/90)*(180/pi)+5) do  {dome}
//  begin
//    az_ra(ra_m2+ dome_contour[tel,0],dome_contour[tel,1],reallatitude ,0,wtime2actual,xxx,yyy );{calculate ra and dec }
//    ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}
//    if (tel=0) then plot_pixel_sphere(dc,xxx, yyy,-2,0,0,0); {-2 is move action}
//    plot_pixel_sphere(dc,xxx, yyy,-1,0,0,0);
//  end;
//  for tel:=round(dec_m2*(30/90)*(180/pi)+5) downto 0 do {dome}
//  begin
//    az_ra(ra_m2-dome_contour[tel,0],dome_contour[tel,1],reallatitude ,0,wtime2actual,xxx,yyy );{calculate ra and dec }
//    ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}
//    plot_pixel_sphere(dc,xxx, yyy,-1,0,0,0);
//  end;
//  dome_plotted:=true;{for notXor drawing function}
//end;

procedure plot_clock;
var
  clock_size, min_X, min_Y,tel : integer; {for clock}
  sin_point,cos_point        : double;

begin
  mainwindow.panel_clock1.visible:=true;

  mainwindow.image_clock1.canvas.brush.Color := Colors[0];{clear fill bitmap with background color}
  mainwindow.image_clock1.canvas.fillrect(mainwindow.image_clock1.clientrect); {wis canvas using current brush}
  selectobject(mainwindow.image_clock1.canvas.handle,pen1);{star}

  if work_width <mainwindow.toolbar2.width+font_width2*24     then tel:=round(5+mainwindow.toolbar2.height {P0b}) {move date down, not enough space}
                                                              else tel:=round(5 {P0b - font_height2*(0.3+0*1.20)});
  clock_size:=trunc(font_height2*1.2);
  mainwindow.panel_clock1.left:=round({image_overlap+}rrw.right-font_width2*22-clock_size );
  mainwindow.panel_clock1.top:=round({image_overlap+}rrw.top+tel);
  mainwindow.panel_clock1.width:=clock_size+1;
  mainwindow.panel_clock1.height:=clock_size+1;

  mainwindow.image_clock1.canvas.arc
         (      0,
                0,
                0+clock_size,
                0+clock_size,
                0,
                0,
                0,
                0);

  {draw empty circel without changing background  }
                {Coordinates  of clock are  right& under similar as font}

     {clock hours pointer}
  movetoEX(mainwindow.image_clock1.canvas.handle,round(clock_size/2),round(clock_size/2),nil); {move to middle}
  sincos(pi*2*2*(frac(julian_UT)+(timezone+daylight_saving)/24), sin_point,cos_point);
  min_X:=round(clock_size*0.3 * -sin_point  );{clock hours pointer, twice round in 24 hours}
  min_Y:=round(clock_size*0.3 * +cos_point  );{clock hours pointer}
  lineto(mainwindow.image_clock1.canvas.handle,round(clock_size/2)-min_X,round(clock_size/2)-min_Y);

  {clock minutes pointer}
  movetoEX(mainwindow.image_clock1.canvas.handle,round(clock_size/2),round(clock_size/2),nil); {move to middle}
  sincos(pi*2*24*(frac(julian_UT)+(timezone+daylight_saving)/24), sin_point,cos_point);
  min_X:=round(clock_size*0.5 * -sin_point );{clock min pointer, twice round in 24 hours}
  min_Y:=round(clock_size*0.5 * +cos_point );{clock min pointer}
  lineto(mainwindow.image_clock1.canvas.handle,round(clock_size/2)-min_X,round(clock_size/2)-min_Y);
end;

procedure PLOT_info(dc2:tcanvas);
var
  tel,i                      :integer;
  ss_string                  : string;
  width,height               : String[8];
  xxx,yyy, alt9,az9          : double;

begin
  selectfont2(dc2);{font selection before textcolors}
  settextcolor(dc2.handle,colors[0]); {000000}

  links:=rrw.left+round(font_width2*1.725); {for text on screen}

  line0_y:= round(rrw.top+font_height2*(0.3+0*1.20)+hide_mainmenu*mainwindow.toolbar2.height);
  line1_y:= round(rrw.top+font_height2*(0.3+1*1.20)+hide_mainmenu*mainwindow.toolbar2.height);

  north_ypos:={-mainwindow.image1.Top}{=imag_overlap} {+rrw.top}+ round(font_height2*1.8)+ hide_mainmenu*mainwindow.ToolBar2.height; {adjust for menu}
  north_leng:=round(font_height2);
  north_xpos:={-mainwindow.image1.left}{+rrw.left}+round(font_width2*38);

  telescope_height:=field_factor/(zoom);
  telescope_width:=work_width*(field_factor/((work_height)*zoom));
  if telescope_height<=60 then
  begin
     if telescope_height<=10 then tel:=1 else tel:=0;
     str(telescope_width:6:tel,width);
     str(telescope_height:6:tel,height);
     ss_string:=Field_string+width+'  x'+height+' '+char(39)+'     ';
  end
  else
  begin
     if telescope_height<=600 then tel:=1 else tel:=0;
    str(telescope_width/60:6:tel,width);
    str(telescope_height/60:6:tel,height);
     ss_string:=Field_string+width+'  x'+height+' °     ';
  end;

 if  actualtime=true  then plot_clock {draw round clock to show it is following the clock}
                       else mainwindow.panel_clock1.visible:=false;

  report_azalt.field:=ss_string;

 if ((flipv=+1) and  (fliph=+1)) then report_azalt.flipped:=''
 else
 if ((flipv=-1) and  (fliph= 1)) then report_azalt.flipped:='V'
 else
 if ((flipv= 1) and  (fliph=-1)) then report_azalt.flipped:='H'
 else
 if ((flipv=-1) and  (fliph=-1)) then report_azalt.flipped:='H V';

  drive_status:='';
  if ((form_animation.Lock_on_name.Checked) and (locknaam2<>''))  then drive_status:='    '+tracking_string+' '+locknaam2
  else
  begin
    if sidereal<>0 then drive_status:='    '+sidereal_string
    else
    drive_status:='    '+terrestrial_string;
  end;
  if timestep<>0 then i:=timestep*60 else i:=1;
  if  actualtime=true then  drive_status:=drive_status+'    '+refresh_rate_string+' '+inttostr(i);

  if ((found>0) and (animation_running=0)) then
  begin
    if found=2 then
          write_info(dc2); {menu search found. Window has been cleaned due to center function}
  end
  else
  begin

    {=====centre altitude, azimuth====}
    ep(2000,equinox_date,ra2,dec2,xxx,yyy); {convert to actual ra,dec for current date !!}
    ra_az(xxx,yyy,reallatitude,0, wtime2actual,az9,alt9); {viewx, viewy could normally be used but give big error if north is true and latitude=90 and <> reallatitude}
    if apparent_horizon<>0 then  alt9:=altitude_apparent(alt9); {refraction at atmosphere, max 34 minutes near horizon}
    str(alt9*180/pi:3:0,ss_string {height});

    report_azalt.alt:=ss_string;{give altitude of centre screen after refresh}{do not print due to override by field info}

    if  azimuth_degrees=0 then
    begin
      report_azalt.az:=richting[round(az9*8/pi)];{give azimuth of screen centre in N, S, E, W. Do not print due to override by field info}
    end
    else
    begin
      str(az9*180/pi:4:0,ss_string); {azimuth}
      report_azalt.az:=ss_string;{give azimuth in degrees, font position is top/left coordinates}
    end;
   {end =====centre altitude, azimuth====}

    if equinox<>2000 then
    begin
       if equinox=1950 then ep(2000,1950,ra2,dec2,ra2,dec2)  {convert to 1950}
       else
       if equinox<=1 then ep(2000,equinox_date,ra2,dec2,ra2,dec2) {convert to actual ra,dec }
       else
       EQU_GAL(ra2,dec2,ra2,dec2);{galactic cordinates}
     end;
     if equinox<>9999 then
     begin {normal mode}
       ra_text:=prepare_ra2(ra2);
       dec_text:=prepare_dec2(dec2);
     end
     else
     begin {galactic mode}
       str(ra2*180/pi:6:3,ra_text);
       str(dec2*180/pi:6:3,dec_text);
     end;

     report_right.p1:=ra_text;
     report_right.p2:=dec_text;
  end;

  if ((found=0) or (animation_running<>0)) then {2018, update field and dattime on canvas}
          canvas_field_message; //see also write_report
end;

procedure PLOT_GRID(dc1: tcanvas);
var  resolution, resolution_milk,
     tel,dia                    :integer;
     ss_string                  : string;
     width,height               : String[8];
     direct,direct2             : string[2]; //array[0..1] of ansichar;

     xxx,yyy,oldyyy,oldrax,olddecX,RAX,DECX,app,stepsize,
     delta1, l_milk,b_milk,
     b2_milk,
     ra1875,dec1875, oldra1875, olddec1875,ra2000,dec2000,ramean,decmean  : double;
     oldx9,oldy9,step_ra, i, steps,offs                    :integer;
     above,set_crossing,rise_crossing : boolean;
begin
  selectfont3(dc1);
  SetTextColor(dc1.handle,colors[29]); {006080}
  selectobject(dc1.handle,pen11);
  above:=true;

  if northtop=1 then
  begin
    if flipv<0 then begin direct:='S'; direct2:='N'; end else begin direct:='N';direct2:='S';end;
    if middle_x>image_overlap+mainwindow.toolbar2.width+font_width2 then tel:=1 else tel:=line0_y;
    textout_center_aligned(dc1,middle_x,image_overlap+tel,direct);
    textout_center_aligned(dc1,middle_x,image_overlap+rrw.bottom - font_height3,direct2); {show where north south is}
    if fliph<0 then begin direct:='E'; direct2:='W'; end else begin direct:='W';direct2:='E';end;
    textout_center_aligned(dc1,image_overlap+rrw.right-font_height3,round(middle_y),direct);
    textout_center_aligned(dc1,image_overlap+round(font_height3*0.5),round(middle_y),direct2);
  end;

  if zoom<150*gridstep then
  begin
    if zoom<=2 then resolution:=14 {resolution} else resolution:=7;
    if grid=1 then {plot ra, dec grid}
    begin
      for dia:=0 to ((24*gridstep)-1) do {vertial lines ra }
      begin
        for tel:=-5*resolution to 5*resolution do
        begin
          rax:=dia*(pi/12)/gridstep; decx:=tel*pi/(12*resolution);

          if equinox<>2000 then
          begin
            if equinox=1950 then ep(1950,2000,rax,decx,rax,decx) {convert to 2000, reverse as other ep calls !!! Map is always in equinox 2000}
            else
            if equinox<=1 then ep(equinox_date,2000,rax,decx,rax,decx) {convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}
            else
            GAL_EQU(rax,decx,rax,decx);{galactic cordinates}

          end;

          if tel=-5*resolution then
          begin
            plot_pixel_sphere(dc1,rax,decx,-2,$FFFFFF,0,0); {-2 is move action}
            oldyyy:=999;
            oldrax:=rax;
            olddecx:=decx;
          end
          else
          begin
            {begin colour below or above horizon. Execution takes about 0.6 ms.}
            yyy:=altitude(rax, decx,reallatitude,0, wtime2actual);{conversion ra & dec to altitude only}

            yyy:=yyy-apparent_horizon; {apparent_altitude}
            set_crossing:=((oldyyy>0) and (yyy<=0));
            rise_crossing:=((oldyyy<0) and (yyy>=0));
            if   (  (oldyyy<>999) and  ( (set_crossing) or (rise_crossing) ) ) then {horizon crossing}
            begin
              if rise_crossing then selectobject(dc1.handle,pen_below_horizon) else selectobject(dc1.handle,pen11);
              stepsize:=abs(oldyyy/(yyy-oldyyy));
              plot_pixel_sphere(dc1,oldrax+(rax-oldrax)*stepsize,olddecx+(decx-olddecx)*stepsize,-1,$FFFFFF,0,0); {-1 is line draw action}
            end;
            if ((yyy>0) and (above=false))  then
            begin
              selectobject(dc1.handle,pen11);
              above:=true;
            end;
            if ((yyy<=0) and (above=true))  then
            begin
              selectobject(dc1.handle,pen_below_horizon);
              above:=false;
            end;

            oldyyy:=yyy;
            oldrax:=rax;
            olddecx:=decx;
            {end colour below or above horizon}

            plot_pixel_sphere(dc1,rax,decx,-1,$FFFFFF,0,0); {-1 is line draw action}
          end;
        end;
      end;

      for tel:=round(-6*gridstep+1) to (6*gridstep-1) do  {horizontal lines constant dec}
      begin
        for dia:=0 to 24*resolution do  {ra steps}
        begin
          rax:=dia*pi/(12*resolution); decx:=tel*(pi/12)/gridstep;

          if equinox<>2000 then
          begin
            if equinox=1950 then ep(1950,2000,rax,decx,rax,decx) {convert to 2000} {reverse as other ep call !!!}
            else
            if equinox<=1 then ep(equinox_date,2000,rax,decx,rax,decx) {convert to 2000} {reverse as other ep call !!!}
            else
            GAL_EQU(rax,decx,rax,decx);{galactic cordinates}
          end;
          if dia=0 then
          begin
            plot_pixel_sphere(dc1,rax,decx,-2,$FFFFFF,0,0); {-2 is move action}
            oldyyy:=999;
            oldrax:=rax;
            olddecx:=decx;
          end
          else
          begin
            {begin colour below or above horizon}
            yyy:=altitude(rax, decx,reallatitude,0, wtime2actual);{conversion ra & dec to altitude only}
            yyy:=yyy-apparent_horizon; {apparent_altitude}
            set_crossing:=((oldyyy>0) and (yyy<=0));
            rise_crossing:=((oldyyy<0) and (yyy>=0));
            if   (  (oldyyy<>999) and  ( (set_crossing) or (rise_crossing) ) ) then {horizon crossing}
            begin
              if  rise_crossing then selectobject(dc1.handle,pen_below_horizon) else selectobject(dc1.handle,pen11);
              stepsize:=abs(oldyyy/(yyy-oldyyy));
              plot_pixel_sphere(dc1,oldrax+(rax-oldrax)*stepsize,olddecx+(decx-olddecx)*stepsize,-1,$FFFFFF,0,0); {-1 is line draw action}
            end;
            if ((yyy>0) and (above=false))  then
            begin
              selectobject(dc1.handle,pen11);
              above:=true;
            end;
            if ((yyy<=0) and (above=true))  then
            begin
              selectobject(dc1.handle,pen_below_horizon);
              above:=false;
            end;
            oldyyy:=yyy;
            oldrax:=rax;
            olddecx:=decx;
            {end colour below or above horizon}

            plot_pixel_sphere(dc1,rax,decx,-1,$FFFFFF,0,0); {-1 is line draw action}

          end;

          if ((zc>0) and (x9<Rrw.right+image_overlap+image_overlap) and (x9>Rrw.left {0}) and (y9>rrw.top{0}) and (y9<rrw.bottom+image_overlap+image_overlap) {write only within image1}
                          and (dia/resolution<>24) and ( ((zoom>=4) and (frac(dia/resolution)=0)) or (dia=0) or (dia/resolution=6) or (dia/resolution=12) or (dia/resolution=18))) then
          begin
            {write ra/dec grid labels}
            str(trunc(tel*15/gridstep):5,height);
            str(trunc(dia/(resolution)):2,width);
            ss_string:=width+height;
            textout_center_aligned(dc1,x9,y9-font_height3,ss_string);{don't use this dc.textout. Moves the pointer and constellation lines are a little wrong}
           end;
        end;
      end;
    end; {grid on/off}


    if grid=2 then {plot azimut/altitude grid}
    begin
      for tel:=1 to 5*gridstep do
      begin
        app:=tel*15*pi/(180*gridstep);
        if apparent_horizon<>0 then app:=altitude_to_true(app); {apparent_altitude}
        for dia:=0 to 24*resolution do {plot az_dec grid}
        begin
          az_ra(dia*pi/(12*resolution),{apparent_altitude} app,reallatitude,0,wtime2actual,xxx,yyy );{calculate ra and dec }

          ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}

          if (dia=0) then plot_pixel_sphere(dc1,xxx, yyy,-2,$FFFFFF,0,0) {-2 is move action}
          else
          plot_pixel_sphere(dc1,xxx, yyy,-1,$FFFFFF,0,0);

          if ((zc>0) and (x9<Rrw.right+image_overlap+image_overlap) and (x9>Rrw.left {0}) and (y9>rrw.top{0}) and (y9<rrw.bottom+image_overlap+image_overlap)) then {write only within image1}
          begin
             if  (
                 ((zoom>=1.7) and ((dia=3*resolution) or (dia=9*resolution) or (dia=15*resolution)or (dia=21*resolution)) )
                 or
                 ((dia/resolution=6) or (dia/resolution=12) or (dia/resolution=18) or (dia/resolution=24)) {skip 0 for move to action}
                 ) then
            begin {write altitude grid labels}
              str(trunc(tel*15/gridstep):3,height);
              width:=richting2[trunc((1/3)*dia/resolution)];{get N,S,E,W info}
              ss_string:=width+height;
              delta1:=x9-oldx9;
              if abs(delta1)<0.00001 then delta1:=0.00001; {prevent divide zero}
              AngleTextOut_center_alligned(dc1,arctan2(1+oldy9-y9,delta1),  x9,y9 {-font_height3},ss_string); {rotated text}
            end;
          end;
          if frac((dia)/resolution)=0 then begin oldx9:=x9; oldy9:=y9; end;{use only big steps for text orientation}

        end;
      end;


      for dia:=0 to (24*gridstep)-1 do {azimuth grid}
      begin
        if (dia in [0,12]) then  selectobject(dc1.handle,penNS) {dotted line for north/south}
        else
        if (dia in [1,13]) then  selectobject(dc1.handle,pen11);{back to normal pen}

        for tel:=0 to (5*resolution) do  {horizontal lines}
        begin
          if ((tel=0) and (apparent_horizon<>0)) then app:=apparent_horizon {apparent_altitude}
          else app:=tel*15*pi/(180*resolution);

          az_ra(dia*pi/(12*gridstep),app {tel*(pi/12)/resolution},reallatitude,0,wtime2actual,xxx,yyy );{calculate ra and dec }

          ep(equinox_date,2000,xxx,yyy,xxx,yyy); {new 19-12-2000, convert to 2000, reverse as other ep call !!! Map is always in equinox 2000}

          if (tel=0) then plot_pixel_sphere(dc1,xxx, yyy,-2,$FFFFFF,0,0); {-2 is move action}
          plot_pixel_sphere(dc1,xxx, yyy,-1,$FFFFFF,0,0);
        end;
      end;
    end;{az/alt grid}

    plot_pixel_sphere(dc1,ra_celestial_pole,dec_celestial_pole,-2,$0,0,0);   {plot cross at northpole}
    if zc>0 then {visible}
    begin
      offs:=round(zoom*2);
      dc1.LineTo(x9+offs,y9+offs);
      dc1.moveTo(x9,y9);
      dc1.LineTo(x9+offs,y9-offs);
      dc1.moveTo(x9,y9);
      dc1.LineTo(x9-offs,y9+offs);
      dc1.moveTo(x9,y9);
      dc1.LineTo(x9-offs,y9-offs);
    end;
    plot_pixel_sphere(dc1,ra_celestial_pole-pi,-dec_celestial_pole,-2,$0,0,0);   {plot cross at southpole}
    if zc>0 then {visible}
    begin
      offs:=round(zoom*2);
      dc1.LineTo(x9+offs,y9+offs);
      dc1.moveTo(x9,y9);
      dc1.LineTo(x9+offs,y9-offs);
      dc1.moveTo(x9,y9);
      dc1.LineTo(x9-offs,y9+offs);
      dc1.moveTo(x9,y9);
      dc1.LineTo(x9-offs,y9-offs);
   end;


    if grid<>0 then
    begin
      selectobject(dc1.handle,pen_ecliptic);
      for dia:=0 to 24*resolution do {plot ecliptic}
      begin
        if (dia=0) then plot_pixel_sphere(dc1,0,0,-2,0,0,0); {-2 is move action}
        AZ_RA(-pi/2+dia*pi/(12*resolution),0,-90+ecliptic2 {23.4},90,0,ra2,dec2);{calculate ecliptic position very accurate 99-7-31}
        plot_pixel_sphere(dc1,ra2,dec2,-1,$FFFFFF,0,0); {-3 is horizon mode}
      end;
    end;
   resolution_milk:=5*resolution;
   if milkyway<>0 then {milky way}
     begin
      selectobject(dc1.handle,pen_milkyway);
      for tel:=0 to 1 do {two lines, mirrored}
      FOR dia:=-resolution_milk TO resolution_milk do
      begin
        l_milk:=dia*(pi/resolution_milk);
        b_milk:=22.5*pi/360- (9*pi/360)*abs(dia/resolution_milk);{inner disk about 22.5 degrees high, outer 13,5 degrees thin}
        b2_milk:=(31.5*pi/360) *(1-(6*6*dia*dia/(resolution_milk*resolution_milk))/2.0); {bulge maximum 31.5 degrees high, bulb ratio about 1 to 2.0}
        if b2_milk>b_milk then
            b_milk:=b2_milk;
        if tel=1 then b_milk:=-b_milk;{do second contour mirrored}
        gal_equ(l_milk,b_milk,xxx,yyy); {galactic (milky way) to equatorial coordinates}
        if (dia=-resolution_milk) then plot_pixel_sphere(dc1,xxx,yyy,-2,$FFFFFF,0,0); {-2 is move action}
        plot_pixel_sphere(dc1,xxx,yyy,-1,$FFFFFF,0,0);
      end;
    end;

    if constellat>0 then
    begin
      selectobject(dc1.handle,pens);
      selectfontgreek(dc1,colors[26]){ $0000A0};

      zc:=+1; {make last drawing action within range}
      FOR dia:=0 TO constellation_length {602} DO  {constellations}
      begin
        if zc<0 then tel:=-2  {move to, prevent long lines through whole screen in azimatuh equid mode}
        else  tel:=constellation[dia].dm;{draw line or move to}
        plot_pixel_sphere(dc1,constellation[dia].ra*pi/12000,constellation[dia].dec*pi/18000,tel,$FFFFFF,0,0);
        if ((namest>1) and (zc>0))  then
        begin
        { system.ansistrings.strpcopy(naam2,char(lo(constellation[dia,3])));}
           textout(dc1.handle,x9-half_font_width_greek,y9-font_height_greek-5,(constellation[dia].bay),length(constellation[dia].bay));{pchar( of a var char geeft soms exception errors??, zo gebruik string}
        end;
      end;

      selectfont3(dc1);
      setTextColor(dc1.handle,colors[26]{ $0000A0});{repeat text color after font change}

      FOR dia:=0 TO 88 DO  {constellations}
      begin
        plot_pixel_sphere(dc1,constpos[dia,0]*pi/12000,constpos[dia,1]*pi/18000,-2,$FFFFFF,0,0);
        if zc>0 then textout_center_aligned(dc1,x9,y9,constname[dia]);//    dc.TextOut(x9,y9,constname[dia]);
      end;
    end;

    if boundaries>0 then
    begin  selectobject(dc1.handle,pen_bound);
      oldra1875:=0;
      olddec1875:=0;

      FOR dia:=0 TO round(-1+sizeof(constbound1875)/6) DO  {constellation bounds}
      begin
        ra1875:= constbound1875[dia,1];
        dec1875:=constbound1875[dia,2];
        step_ra:=round(ra1875-oldra1875);
        if step_ra>+12000 then step_ra:=-(24000-step_ra)
        else
        if step_ra<-12000 then step_ra:=(24000+step_ra);
        steps:=round(1+2*zoom);

        if ((constbound1875[dia,0]<>-2) and (steps<>0)) then {plot line or move to if steps is large enough}
        begin
          for i:=1 to abs(steps) do  {this only working well with orginal equinox 1875  !!!}
          begin
            ep(1875,2000,(oldra1875+(step_ra)*i/abs(steps))*pi/12000,(olddec1875+(-olddec1875+dec1875)*i/abs(steps))*pi/18000,ra2000,dec2000);
            plot_pixel_sphere(dc1,ra2000,dec2000,-1,$FFFFFF,0,0)
          end;
        end
        else
        begin
          ep(1875,2000,ra1875*pi/12000,dec1875*pi/18000,ra2000,dec2000);
          plot_pixel_sphere(dc1,ra2000,dec2000,constbound1875[dia,0],$FFFFFF,0,0);
        end;
        oldra1875:=ra1875;
        olddec1875:=dec1875;
      end;
    end;
  end; {zoom<150}

  if cross>0 then {cross-hair or pointing circle}
  begin
    selectfont2(dc1);
    setTextColor(dc1.handle,colors[28]);
    selectobject(dc1.handle,pen_crosshair);

    if cross=1 then
    begin {cross-hair}

      if zoom>64 then dia:=1
      else
      if zoom>32 then dia:=2
      else
      if zoom>16 then dia:=5
      else
      if zoom>8 then dia:=10
      else
      if zoom>4 then dia:=20
      else
      dia:=40;

      if zoom<800 then
      begin
      for tel:=1 to 5 do
        begin
        xxx:=dia*tel*(work_height)*zoom*telrad_factor;{0.377*0.884/480;}
        if (dia*20/200)>=1 then  str((tel*dia*20/200):4:0,ss_string) else str((tel*dia*20/200):4:1,ss_string);
        ss_string:=ss_String+'°';

        plot_pixel_sphere(dc1,telescope_ra {ra2},telescope_dec {dec2} +(tel*dia/(580*0.95)) ,-2,$0,0,0);
        dc1.textout((x9),(y9),ss_string);
        plot_pixel_sphere(dc1,telescope_ra {ra2},telescope_dec {dec2},round(xxx),0,1,0);{draw arc without filling while style is 1}
        end;
      end;
    end
    else {cross=2 show telrad }
    begin {telrad}
      if zoom<2000 then
      begin
       for tel:=1 to 5 do
        begin
          xxx:=telrad[tel]*(work_height)*zoom*5*telrad_factor;
          if xxx>5 then
            begin
            str((telrad[tel]):4:2,ss_string);
            width:=FloatToStr(telrad[tel]);
            ss_string:=width+'°';
            plot_pixel_sphere(dc1,telescope_ra {ra2},telescope_dec {dec2} + (telrad[tel]*5/(580*0.95)) ,-2,$0,0,0);
            dc1.textout(x9,y9,ss_string);
            plot_pixel_sphere(dc1,telescope_ra {ra2},telescope_dec {dec2},round(xxx),0,1,0);{draw arc without filling while style is 1}
          end;
        end;{for}
      end;
    end;
   end;{cross>0}
end; {plot grid}

procedure find_chart_orientation(dc1: tcanvas);
var
  y10,x10,yyyy   : double;{for find chart orientation}

begin
  {find chart orientation}
  plot_pixel_sphere(dc1,telescope_ra,telescope_dec,-99,$0,0,0); { find orientation by moving to }
  y10:=y9;
  x10:=x9;
  plot_pixel_sphere(dc1,telescope_ra,telescope_dec+0.5/zoom,-99,$0,0,0); { find orientation by moving to }
  if zc<0 then exit; {not in sight}
  yyyy:=y10-y9;
  if abs(yyyy)<0.00001 then yyyy:=0.00001; {prevent divide zero}
  chart_orientation:=-arctan2((x10-x9),yyyy);{required for plot_north arrow and plotfitsplanets !!!!}
end;

procedure plot_toast(canvas2:tcanvas);
type
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array [0..4096] of {$IFDEF fpc} tagRGBQUAD {$ELSE} TRGBTriple {$ENDIF}; {Note set size dynamic array doesn''t work for RGBtripple??}
                                                                     { QUAD is 4bytes instead 3 bytes!!}
var
   x,y : integer;
   pixcol , oldpixcol : tcolor;
   dec7,ra7, orien2, angle, xx,yy, size2,delta_ra,
   view_size, distance_from_center  :double;
   nearby     : boolean;
   pixel_line :  PRGBTripleArray;

begin
  if ((png.height<1) or (zoom<0.8)) then exit;
  size2:=zoom*(work_height/(png.height/2.5));{size of pixes/squares plotted}

  if round(size2)>1 then {prepare for square pixes using polygon in plot_pixel}
  begin {square pixe preparation}
    plot_pixel_sphere(canvas2,telescope_ra+0.5/zoom,telescope_dec,-99,$FFFFFF,0,0);{find angle on screen with two plot_pixel calls}
    if zc<0 then exit;{not in sight}
    xx:=x9;yy:=y9;
    plot_pixel_sphere(canvas2,telescope_ra,telescope_dec,-99,$FFFFFF,0,0);
    if zc<0 then exit;
    xx:=xx-x9; if abs(xx)<0.00001 then xx:=0.00001; {prevent divide zero}
    orien2:=arctan((yy-y9)/xx);
    orien2:=(angle-orien2);{find angle of pixels in FITS}
    rotate(orien2,size2,size2,xx,yy); {rotate a vector point, this case one of the corner of a square}
    square_x_step:=round(xx/2);
    square_y_step:=round(yy/2);
  end; {end square pixe preparation}

//  //Var
//  startTick  : DWord;
//  deltaticks : DWord;

  y:=0;
  nearby:=true;
  while y<= png.height-1 do
  begin
    nearby:=false;
    x:=0;
    pixel_line:=PNG.ScanLine[y];{get one line of image}
    while x<= png.width-1 do
     begin
      newtime:=gettickcount64;
      if (abs(newtime-oldtime)>100) then   {140 longer then other WORKS BETTER THEN 100}
      begin
        Application.ProcessMessages;
        oldtime:=newtime;
      end;
     try
       de_toast(x, y, png.height,ra7,dec7);
       delta_ra:=abs(ra7-telescope_ra); if delta_ra>pi then delta_ra:=pi*2-delta_ra;
       distance_from_center:=sqr((1-abs(telescope_dec)/(0.5*pi))*delta_ra)+sqr(dec7-telescope_dec);
       view_size:=2.5*sqr((work_width/(work_height))/zoom);
       if distance_from_center<view_size then
       begin
         nearby:=true;
         {$IFDEF fpc}
         if ((pixel_line[x].rgbRed>1) or  (pixel_line[x].rgbGreen>1) or (pixel_line[x].rgbBlue>1)) then {mostly black then skip}
         {$ELSE}
         if ((pixel_line[x].rgbtRed>1) or  (pixel_line[x].rgbtGreen>1) or (pixel_line[x].rgbtBlue>1)) then {mostly black then skip}
         {$ENDIF}
         begin
           {$IFDEF fpc}
            pixcol:=rgb(pixel_line[x].rgbRed,pixel_line[x].rgbGreen,pixel_line[x].rgbBlue); {FPC}
           {$ELSE}
            pixcol:=rgb(pixel_line[x].rgbtRed,pixel_line[x].rgbtGreen,pixel_line[x].rgbtBlue);{Delphi}
           {$ENDIF}
           if ((round(size2)<>0) and (pixcol<>oldpixcol)) then {slow process so only for larger then one pixel required and new color}
           begin
              canvas2.Pen.Color:=pixcol;
              canvas2.brush.Color:=pixcol;
              oldpixcol:=pixcol;
           end;
           plot_pixel_sphere(canvas2,ra7,dec7,round(size2),pixcol,2,0);{pixel or square box depending on size}
         end;
         inc(x);
       end {within sight}
       else
       begin
          inc(x,round(1+0.1*(png.height*work_width/work_height)/zoom));{speed up scanning of toast projection.}
       end;
       except;
       {some computer errors}
       end;
    end;{x loop}
   if nearby then inc(y,1) else inc(y,round(1+ 0.1*(png.height*work_width/work_height)/zoom));{speed up scanning of toast projection.}
  end; {y loop}

  pixel_line:=nil;{remove dynamic array from memory}
//  deltaticks := gettickcount64 - startTick;
//  ShowMessage(IntToStr(deltaticks) + 'ms');
end;

Function plotfitsplanets(canvas2:tcanvas;filen:string;planet,moon:integer):boolean;{load planet fits file, by Han Kleijn}
const bufwide=$2000;
      wide2  : integer=100;
      height2: integer=100;{do not use reserved word height}
      naxis  : integer=2;
type  byteX3 = array[0..2] of byte;
var
   i,j, max_nr_labels: integer;
   col1,col2,col3: integer;
   bzero       : integer; {integer;}{zero shift. For example used in AMT}
   skipfactor  : integer; {smart skip overlapping pixels}

   dRa,dDec,sin_h,cos_h,sin_a,cos_a   :double;
   header      : array[0..$4000] of ansichar;
   oldoutcolor : integer;

   fitsbuffer :   array[0..bufwide] of byte;{buffer for 8 bit FITS file}
   fitsbufferRGB: array[0..trunc(bufwide/3)] of byteX3 absolute fitsbuffer;{buffer for 8 bit RGB FITS file}
   nrbits,outcolor,reader_position     : integer;
   bcolor,gcolor,rcolor                : integer; {fits color}
   back_bcolor,back_gcolor,back_rcolor : integer;{background colors}

   datamin, datamax,             {range image}
   size2,cdelt2       :double;   {for size and orientation square pixes}
   rgbdummy    : byteX3;

   poin, oldpoin: array[0..3] of tpoint;

   xm,ym,zm,xm2,ym2,zm2,DCR,RA,moon_anomoly:double;
   x5,y5,x6,y6,x7,y7,oldx6,oldy6,dummy,
   sin_chart_orientation, cos_chart_orientation,
   sqr_sun_planetsurface,sqr_sun_planetcenter,lightzone,
   sqr_earth_planetsurface,sqr_earth_planetcenter,
   planet_radius,  x_step, y_step,
   x1_step, y1_step, x2_step, y2_step,
   rot,oval, cos_rot,sin_rot,
   x_stepcos,x_stepsin,y_stepcos,y_stepsin  :double;
   x_center,y_center                        :integer;
   sin_theta,cos_theta,sin_phi,cos_phi,visiblezone,
   x_planet,y_planet,z_planet              :double;
const
  end_record: boolean=false;

   procedure close_fits_file; inline;
   begin
     Reader_fits.free;
     TheFile_fits.free;
     fits_file_open:=0;{closed}
   end;

   Function validate_float:double;{read floating point or integer values}
   var t :shortstring;
       r,err : integer;
   begin
     t:='';
     r:=I+10;{position 11 equals 10}
     while ((header[r]<>'/') and (r<=I+29) {pos 30}) do {'/' check is strictly not necessary but safer}
     begin  {read 20 characters max, position 11 to 30 in string, position 10 to 29 in pchar}
       if header[r]<>' ' then t:=t+header[r];
       inc(r);
     end;
     val(t,result,err);
   end;
begin
  oldx6:=0;
  oldy6:=0;
  plotfitsplanets:=false; {for all exceptions}

  plot_pixel_sphere(canvas2,ra2,dec2,-2,0,0 ,hints);  {1) move to and 2) check if visible with zc>0}
  if zc<0 then {not in sight}
  begin
    plotfitsplanets:=true;{do not to try to plot conventionel anymore}
    exit;
  end;
  x_center:=x9;{center of planet/moon}
  y_center:=y9;
  x_planet:=x_pln;{save, somehow they are sometimes changed for moon where x,y,z=> delta=1, resulting that plotting stops halfway. Find out later}
  y_planet:=y_pln;
  z_planet:=z_pln;

  if fits_file_open<> 0 then close_fits_file; {still open interupted by process.messages}
  try
    TheFile_fits:=tfilestream.Create( filen, fmOpenRead or fmShareDenyWrite);
    Reader_fits := TReader.Create (theFile_fits,$4000);{number of hnsky records}
  except
     exit;
  end;
  fits_file_open:=1; {remember that file is open}

  if colors[0]<>$FFFFFF {white} then begin Bcolor:=$FF; Gcolor:=$FF;  Rcolor:=$FF;end
                                else begin Bcolor:=$00; Gcolor:=$00;  Rcolor:=$00;end;

  back_Bcolor:=getBvalue(colors[0]); {background seperate colors}
  back_Gcolor:=getGvalue(colors[0]);
  back_Rcolor:=getRvalue(colors[0]);

  max_nr_labels:=trunc(thefile_fits.Size/(80));{used for protection against headers with no end}


  reader_position:=0;  {thefile_stars.size-reader.position>sizeof(hnskyhdr) could also be used but slow down a factor of 2 !!!}

  repeat {header, 2880 bytes loop}
    I:=0;
    try
      reader_fits.read(header[0],2880);{read file info, 2880 bytes only}
    except
      close_fits_file;
      exit;
    end;

    repeat {loop for 80 bytes in 2880 block}
      inc(reader_position,80);
      dec(max_nr_labels,1); if max_nr_labels<10 then begin Reader_fits.free; TheFile_fits.free; exit; end;{error, header has no end. This works 10% faster then using reader.position}
      if ((header[i]='B') and (header[i+1]='I')  and (header[i+2]='T') and (header[i+3]='P') and (header[i+4]='I') and (header[i+5]='X')) then
      begin
        nrbits:=round(validate_float);{BITPIX, read integer using real routine}
        if nrbits=8 then begin datamin:=0;datamax:=255; {8 bits files} end
        else {16, -32 files}
        begin datamin:=0;datamax:=4*4096;end;{not always specified. For example in skyview. So refresh here for case brightness is adjusted}
      end;
      if ((header[i]='N') and (header[i+1]='A')  and (header[i+2]='X') and (header[i+3]='I') and (header[i+4]='S')) then
         begin
           if (header[i+5]=' ') then naxis:=round(validate_float) else {number of dimensions}
           if (header[i+5]='1') then wide2:=round(validate_float) else {NAXIS1 pixels}
           if (header[i+5]='2') then height2:=round(validate_float) else {NAXIS2 pixels}
           if (header[i+5]='3') then
           begin {RGB fits}
             wide2:=height2;
             height2:=round(validate_float);  {NAXIS2 pixels}
           end;
         end;
      if ((header[i]='D') and (header[i+1]='A')  and (header[i+2]='T') and (header[i+3]='A') and (header[i+4]='M')) then
         begin
           if ((header[i+5]='I') and (header[i+6]='N')) then datamin:=validate_float else {DATAMIN. Note some FIT files contain real}
           if ((header[i+5]='A') and (header[i+6]='X')) then datamax:=validate_float;{DATAmax. Note some FIT files contain real }
         end;
      if ((header[i]='B') and (header[i+1]='Z')  and (header[i+2]='E') and (header[i+3]='R') and (header[i+4]='O') ) then
               bzero:=round(validate_float);
      end_record:=((header[i]='E') and (header[i+1]='N')  and (header[i+2]='D'));{end of header}

      inc(i,80);{go to next 80 bytes record}

    until ((i>=2880) or (end_record));
  until end_record;

  if naxis=3 then nrbits:=24; {threat RGB fits as 2 dimensional with 24 bits data}

  datamin:=datamin+round((datamax-datamin)*dss_background/100);
  if datamin<1 then datamin:=0;
  datamax:=datamax*(1-dss_brightness/100);if datamax<=datamin then datamax:=datamin+1;
  wide2:=min(wide2,round(bufwide/(abs(nrbits/8))));{prevent violation error too large images. limit wide to buffer, image will not displayed correctly}

  cdelt2:=length2/(height2*3600*10/60);{size pixel}
  size2:=zoom*(work_height)*+(cdelt2)*(1/(63));{size of pixes/squares plotted}

  skipfactor:=round(0.78/size2);  if skipfactor<1 then skipfactor:=1; {for smart way to skip pixels if overlapping, 2013}
                   {factor 0.78 is more conservative then for deepsky to prevent black pixels in small planet images}

  moon_anomoly:=fnmodulo( (moon_data[planet,moon,4]{start}+ moon_data[planet,moon,3]{orbitspeed}*((julian_ET-2451545) -delta/173{lightspeed delay}))*pi/180,   2*pi);
  if ((planet=5) and (moon=0)) then moon_anomoly:=moon_anomoly+(grs_offset*pi/(180*24*60))*moon_data[5,0,3];{870 degrees/day} {correction for jupiter GRS}
  oval:=width2/length2;
  rot:=chart_orientation;
  if zoomv<0 then rot:=-rot;
  if zoomh<0 then rot:=-rot+pi;
  planet_radius:=(0.5*moon_data[planet,moon,5]);{planet or moon radius}
  sincos(rot,sin_chart_orientation,cos_chart_orientation);
  cos_rot:=1;{is adapted later during pixel drawing}
  sin_rot:=0;

  sincos(moon_data[planet,moon,1],sin_theta,cos_theta);
  sincos(moon_data[planet,moon,2],sin_phi,cos_phi);

  oldoutcolor:=$11FFFFFF;{non existing value}

  for i:=0 to height2-1 do
  begin
    newtime:=gettickcount64;
    if (abs(newtime-oldtime)>100) then   {140 longer then other WORKS BETTER THEN 100}
    begin
      Application.ProcessMessages;
      oldtime:=newtime;
    end;
    if fits_file_open=1 then
    begin try reader_fits.read(fitsbuffer,wide2*round(abs(nrbits/8)));except; close_fits_file; exit;end; {read file bytes} end
      else  begin {do not close_fits_file; here} exit;end;

    for j:=0 to wide2-1 do
         if ( (frac(i/skipfactor)=0) and (frac(j/skipfactor)=0) ) then  {smart way to skip pixels if overlapping, 2013}
    begin
      if nrbits=8  then
      begin
         col1:=round( ((fitsbuffer[j]-datamin+bzero)*256/(datamax-datamin) ));{scale to maximum contrast}
         col2:=col1;
         col3:=col1;
      end
      else
      if nrbits=24 then
      begin
         rgbdummy:=fitsbufferRGB[j];
         col1:=round( ((rgbdummy[0]-datamin+bzero)*256/(datamax-datamin) ));{scale to maximum contrast}
         col2:=round( ((rgbdummy[1]-datamin+bzero)*256/(datamax-datamin) ));{scale to maximum contrast}
         col3:=round( ((rgbdummy[2]-datamin+bzero)*256/(datamax-datamin) ));{scale to maximum contrast}
      end
      else
      begin {unknown fits}
        col1:=255;
        col2:=255;
        col3:=255;
      end;
      if col1>255 then col1:=255;
      if col1<0   then col1:=0;
      if col2>255 then col2:=255;
      if col2<0   then col2:=0;
      if col3>255 then col3:=255;
      if col3<0   then col3:=0;

      begin

        sincos((i/(height2-1))*pi, sin_h,cos_h);
        sincos(moon_anomoly+(j/(wide2-1))*2*pi, sin_a, cos_a);
        xm:=planet_radius * sin_h {moon distance} * cos_a;{rotation moon in own xy}
        ym:=planet_radius * sin_h {moon distance} * sin_a;
        zm:=planet_radius * -cos_h * oval {for jupiter} ;

        xm2:=xm;
        ym2:=ym* + sin_theta +zm*cos_theta ;{ROTATION MOON AROUND CENTER OF PLANET}
        zm2:=ym* - cos_theta +zm*sin_theta ;{SEE PRISMA WIS VADEMECUM BLZ 68}
                                                        {sin and cos exchanged to get correct result for moon axis}
        xm:=xm2 * + sin_phi +ym2*cos_phi;   {ROTATION MOON AROUND CENTER OF PLANET}
        ym:=xm2 * - cos_phi +ym2*sin_phi;   {SEE PRISMA WIS VADEMECUM BLZ 68}
        zm:=zm2;

        {x,y,z of planet and x_sun..  Sun from HNS_UPLA and for moons from Uast routine moon_radec !!!!}
        {alternatevely would be routine cart2(delta,dec2,ra2,x,y,z); calculate xyz of planet}
        sqr_earth_planetcenter :=(sqr(x_planet)+sqr(y_planet)+sqr(z_planet));
        sqr_earth_planetsurface:=sqr(x_planet+xm)+sqr(y_planet+ym)+sqr(z_planet+zm);


        if  sqr_earth_planetsurface<sqr_earth_planetcenter then {front of the moon only}
        begin
          if planet<>0 then {no sun}
          begin
          sqr_sun_planetsurface:=sqr(x_planet+xm-x_sun)+sqr(y_planet+ym-y_sun)+sqr(z_planet+zm-z_sun); {sqr delta or distance sun-planetsurface}
          sqr_sun_planetcenter:= sqr(x_planet-x_sun)+sqr(y_planet-y_sun)+sqr(z_planet-z_sun);{sqr delta or distance sun-planetcenter}
          lightzone:=(sqrt(sqr_sun_planetcenter)-sqrt(sqr_sun_planetsurface))/planet_radius;
          end
          else lightzone:=1;{sun lights it's self}

          if ((lightzone>0) or (moon_covers_stars=1)) then {light on surface or plot also dark area}

          begin
            if lightzone>0 then {light on surface}
               dummy:=sqrt(lightzone)
               else
               dummy:=0; {dark area, plot black}

            col1:=round(col1*dummy);{rough method to get close to corners darker. Is about okay for jupiter image}
            col2:=round(col2*dummy);
            col3:=round(col3*dummy);

            visiblezone:=(sqrt(sqr_earth_planetcenter)-sqrt(sqr_earth_planetsurface))/planet_radius;

            if canvas2=printer.canvas then {printing}
            begin {printer}
              if inverse_printing then {white sky}
                inverse_intensity_color(rgb(col1 ,col2,col3),outcolor)
                else outcolor:=rgb(col1 ,col2,col3);

             end {printing}
             else
            begin {screen}
              outcolor:=rgb(round((Rcolor * col1 + back_Rcolor * (255 - col1)) / 255),
                            round((Gcolor * col2 + back_Gcolor * (255 - col2)) / 255),
                            round((Bcolor * col3 + back_Bcolor * (255 - col3)) / 255)  );
                         {Alpha blending takes two colors, back and foreground and mixes their r,g,b components by weighting them with a fourth SEE for more plotfits routine}
            end;


            ra:=arctan2(Y_planet+Ym,X_planet+Xm); IF ra<0 THEN ra:=ra+2*pi;{equal routine polar2}
            dcr:=arctan2(Z_planet+Zm,sqrt(sqr(X_planet+xm)+sqr(Y_planet+Ym)));{equal routine polar2}

            dDec:=(dec2-dcr){*oval};{oval only for jupiter}
            dRa:=(ra2-ra)*cos(dec2){dec factor for sizing};

            y5:=dRa * + sin_chart_orientation+ dDec * cos_chart_orientation;{ROTATION MOON AROUND CENTER OF PLANET}
            x5:=dRa * - cos_chart_orientation+ dDec * sin_chart_orientation;{SEE PRISMA WIS VADEMECUM BLZ 68}
            x6:=(-X5*zoomv*work_height/2);
            y6:=(+Y5*zoomh*work_height/2);
            x7:=(x_center+X6);
            y7:=(y_center+Y6);

            if (size2<=1)then
            begin
              if ((moon_covers_stars<>0) and (outcolor=colors[0])) then
                  outcolor:=outcolor or $1000000;{make different to background by setting bit above $FFFFFF, so stars are overwritten in FastBitmapToCanvas}
              fastbitmap1.pixels[round(x7),round(y7)]:=outcolor;{write to fastbitmap1}
            end
            else
            begin
              {adapt pixels to position, draw close to corner smaller, up or down shorter, left right thinner}
              x_step:=0.5*size2*visiblezone;
              y_step:=0.5*size2*(sin(pi*i/(height2-1)));{image latitude is precisely equals to height position}

              if abs(x6-oldx6)<size2+size2 then {calculate only angle if no big steps}
              begin
                dummy:=sqrt(0.000001+sqr(x6-oldx6)+sqr(y6-oldy6));
                cos_rot:=(x6-oldx6)/dummy;
                sin_rot:=(y6-oldy6)/dummy;
                if  (x6-oldx6<0) then begin x_step:=-x_Step; y_step:=-y_step;end;{emperical found}
              end;
              oldx6:=x6;{for next time to calculate the angle}
              oldy6:=y6;

              x_stepcos:=x_step * cos_rot;
              y_stepcos:=y_step * cos_rot;
              x_stepsin:=x_step * sin_rot;
              y_stepsin:=y_step * sin_rot;

              x1_step:=-x_stepcos -y_stepsin;{SEE PRISMA WIS VADEMECUM BLZ 68}
              y1_step:=-x_stepsin +y_stepcos;{ROTATION MOON AROUND CENTER OF PLANET}

              poin[0]:=Point(round(x7+x1_step),+round(y7+y1_step));
              poin[2]:=Point(round(x7-x1_step),+round(y7-y1_step));

              x2_step:=x_stepcos - y_stepsin;{SEE PRISMA WIS VADEMECUM BLZ 68}
              y2_step:=x_stepsin + y_stepcos;{ROTATION MOON AROUND CENTER OF PLANET}

              poin[1]:=Point(round(x7+x2_step),round(y7+y2_step));
              poin[3]:=Point(round(x7-x2_step),round(y7-y2_step));

              if oldoutcolor<>outcolor then {slow process so only when new color}
              begin
                Canvas2.Pen.Color:=outcolor;
                Canvas2.brush.Color:=outcolor;
                oldoutcolor:=outcolor;
              end;
              if size2<=2 then {mini polgon, maximum 2 pixels wide}
              begin
                fastbitmap1.pixels[round(X7) ,ROUND(Y7)]:=outcolor;{write to fastbitmap1}

                fastbitmap1.pixels[round(x7+x1_step/2.4),+round(y7+y1_step/2.4)]:=outcolor;{write to fastbitmap1}
                fastbitmap1.pixels[round(x7-x1_step/2.4),+round(y7-y1_step/2.4)]:=outcolor;{write to fastbitmap1}

                fastbitmap1.pixels[round(x7+x2_step/2.4),+round(y7+y2_step/2.4)]:=outcolor;{write to fastbitmap1}
                fastbitmap1.pixels[round(x7-x2_step/2.4),+round(y7-y2_step/2.4)]:=outcolor;{write to fastbitmap1}

              end
              else
              begin
                 if ( (poin[0].x<>oldpoin[0].x) or (poin[0].y<>oldpoin[0].y) or (poin[1].x<>oldpoin[1].x) or (poin[1].y<>oldpoin[1].y)  )  then {rough but effective method preventing double plotting}
                {$IFDEF fpc}
                 canvas2.Polygon(poin,4);
                {$ELSE} {delphi}
                Polygon(canvas2.handle,poin,4);
               {$ENDIF}
              end;
             oldpoin:=poin;
            end;
          end;{col<>0}
        end;
      end;
    end;
  end;
  close_fits_file;
  plotfitsplanets:=true;{file processed}
end;

function position_to_string(rax,decx:double) :string;{colour and ra and dec to combined 0..10000 string for coding filenames}
var
   colour : string;
begin
  case dss_bandpass of
              8,35 : colour:='R';{red}
              7,18 : colour:='B';{blue}
              37   : colour:='I';{infrared}
              else
              colour:='_';

  end;
  result:=colour+copy(inttostr(round(10000+ rax*10000/(2*pi))),2,4)+ {ra make always 4 digits}
                       copy(inttostr(round(10000+((pi/2)+decx)*10000/pi)),2,4); {southpole distance, make always 4 digits}
end;

function plot_fits(canvas2:tcanvas;filen:string): boolean;{load fits file}
const  wide2  : integer=100;
       height2: integer=100;{do not use reserved word height}
       ra0 : double=0;
       dec0: double=0; {plate center values}
       cdelt1: double=0;{deg/pixel for x}
       cdelt2: double=0;
       crpix1: double=0;{reference pixel}
       crpix2: double=0;
       equinox2: double=2000.0;
       naxis  : integer=2;
       bufwide=8300*8;{8k pixels wide of 64 bit}

type   byteX3 = array[0..2] of byte;
var
   i,j,k, hintfits, max_nr_labels, col1,col2,col3,oldoutcolor,error2,error3 : integer;
   bzero                      : integer;{zero shift. Tricky do not use int64,  maxim DL writes BZERO value -2147483647 as +2147483648 !! }
   wo                         : word;   {for signed 16 bit integer}
   sign_int                   : smallint absolute wo;{for signed 16 bit integer}
   yy,xx,RAM,DECM,dist,
   cd1_1,cd1_2,cd2_1,cd2_2, dRa,dDec,delta,gamma,
   sin_r1,cos_r1,sin_r2,cos_r2,sin_dec0,cos_dec0,factor,
   rac,decc                   : double;
   header    : array[0..2880] of ansichar;
   rgbdummy    : byteX3;
   crota2,crota1 : double; {image rotation at center in degrees}
   angle     : double; {image rotation at center, radians}
   nrbits,outcolor,naxis1,naxis2,naxis3 : integer;
   bcolor,gcolor,rcolor                  : integer; {fits color}
   back_bcolor,back_gcolor,back_rcolor : integer;{background colors}
   col_float,cblack,cwhite   : double;{range image}
   skipfactor           : integer; {smart skip overlapping pixels}
   reader_position      : integer;
   size2 ,orien2        : double;{for size and orientation square pixes}
   highest              : double;
   counter,colv,peakcounts,peakposition,blackpos,counts: integer;
   histogram : array [0..255] of integer;

var
  fitsbuffer : array[0..bufwide] of byte;{buffer for 8 bit FITS file}
  fitsbuffer2: array[0..trunc(bufwide/2)] of word absolute fitsbuffer;{buffer for 16 bit FITS file}
  fitsbuffer4: array[0..trunc(bufwide/4)] of longword absolute fitsbuffer;{buffer for floating bit ( -32) FITS file}
  fitsbufferRGB: array[0..trunc(bufwide/3)] of byteX3 absolute fitsbuffer;{buffer for 8 bit RGB FITS file}
  x_longword  : longword;
  x_single    : single absolute x_longword;{for conversion 32 bit "big-endian" data}

  thefile,thepath  : string;
  success :boolean;
const
  end_record: boolean=false;


    procedure close_fits_file; inline;
    begin
       img_loaded:=nil;{free memory}
       Reader_fits.free;
       TheFile_fits.free;
       fits_file_open:=0;{closed}
     end;

    Procedure old_to_new_WCS;{ convert old WCS to new}
    begin
      sincos(crota1*pi/180,sin_r1,cos_r1);
      cd1_1:=+cdelt1 * cos_r1;  {2013 included crota1 instead of crota2}
      cd1_2:=-cdelt2 * sin_r1;
      sincos(crota2*pi/180,sin_r2,cos_r2);
      cd2_1:=+cdelt1 * sin_r2;
      cd2_2:=+cdelt2 * cos_r2;
    end;

    Function validate_float:double;{read floating point or integer values}
    var t :shortstring;
        r,err : integer;
    begin
      t:='';
      r:=I+10;{position 11 equals 10}
      while ((header[r]<>'/') and (r<=I+29) {pos 30}) do {'/' check is strictly not necessary but safer}
      begin  {read 20 characters max, position 11 to 30 in string, position 10 to 29 in pchar}
        if header[r]<>' ' then t:=t+header[r];
        inc(r);
      end;
      val(t,result,err);
    end;


begin {plotfits}
  result:=false;
  if fits_file_open<> 0 then close_fits_file;{still open interupted by process.messages}
  try
    TheFile_fits:=tfilestream.Create( filen, fmOpenRead or fmShareDenyWrite);
    Reader_fits := TReader.Create (TheFile_fits,$4000);{number of hnsky records}
  except
     exit;
  end;
  if  TheFile_fits.Size<=1024 then begin  close_fits_file;  exit;{2013, not a fits file}  end;
  fits_file_open:=1;{fits file open}

  if ((dss_bandpass<>18) and (dss_bandpass<>7)) then {not blue}
  begin {DSS red}
    if colors[30] and $FF0000>0 then Bcolor:=$FF else Bcolor:=0;
    if colors[30] and $00FF00>0 then Gcolor:=$FF else Gcolor:=0;
    if colors[30] and $0000FF>0 then Rcolor:=$FF else Rcolor:=0;
  end
  else
  begin
    if colors[41] and $FF0000>0 then Bcolor:=$FF else Bcolor:=0;
    if colors[41] and $00FF00>0 then Gcolor:=$FF else Gcolor:=0;
    if colors[41] and $0000FF>0 then Rcolor:=$FF else Rcolor:=0;
  end;

  back_Bcolor:=getBvalue(colors[0]); {background seperate colors}
  back_Gcolor:=getGvalue(colors[0]);
  back_Rcolor:=getRvalue(colors[0]);

  crota2:=0;{just for the case it is not available}
  crota1:=0;{just for the case it is not available}
  naxis3:=1;{just for the case it is not available}


  bzero:=0;{just for the case it is not available}
  cd1_1:=0;{just for the case it is not available}
  cd1_2:=0;{just for the case it is not available}
  cd2_1:=0;{just for the case it is not available}
  cd2_2:=0;{just for the case it is not available}
  cdelt2:=0;{just for the case it is not available}
  ra0:=0;
  dec0:=0;
  cblack:=0;cwhite:=65535;
  hintfits:=1;{give first pixel a hint}
  mag2:=999;

  max_nr_labels:=trunc(TheFile_fits.Size/(80));{used for protection against headers with no end}

  reader_position:=0;
  {TheFile_fits.size-reader.position>sizeof(hnskyhdr) could also be used but slow down a factor of 2 !!!}

  repeat {header, 2880 bytes loop}
    I:=0;
    try
      reader_fits.read(header[0],2880);{read file info, 2880 bytes only}
    except
      close_fits_file;
      exit;
    end;

    repeat {loop for 80 bytes in 2880 block}
      if reader_position=0 then if ((header[i+0]='S') and (header[i+1]='I') and (header[i+6]=' '))=false then begin close_fits_file; exit; end; {should start with "SIMPLE  =",  MaximDL compressed files start with SIMPLE‚=”}
      inc(reader_position,80);
      dec(max_nr_labels,1); if max_nr_labels<10 then begin close_fits_file;exit; end;{error, header has no end. This works 10% faster then using reader.position}

      if ((header[i]='B') and (header[i+1]='I')  and (header[i+2]='T') and (header[i+3]='P') and (header[i+4]='I') and (header[i+5]='X')) then
      begin
        nrbits:=round(validate_float);{BITPIX, read integer using real routine}
      end;
      if ((header[i]='N') and (header[i+1]='A')  and (header[i+2]='X') and (header[i+3]='I') and (header[i+4]='S')) then
      begin
        if (header[i+5]=' ') then naxis:=round(validate_float) {number of dimensions}
        else
        begin
          if (header[i+5]='1') then begin naxis1:=round(validate_float); wide2:=naxis1; end {NAXIS1 pixels}
          else
          begin
            if (header[i+5]='2') then begin naxis2:=round(validate_float); height2:=naxis2;end {NAXIS2 pixels}
            else
            begin
              if (header[i+5]='3') then
              begin {RGB fits}
                naxis3:=round(validate_float);  {NAXIS3 pixels}
                if naxis3>1 then {colour}
                begin
                  if colors[0]<>$FFFFFF {white} then begin Bcolor:=$FF; Gcolor:=$FF;  Rcolor:=$FF;end {prepare colors for RGB fits}
                                                else begin Bcolor:=$00; Gcolor:=$00;  Rcolor:=$00;end;
                  if naxis3>3 then {colour type 24, naxis=3, naxis1=3, naxis2=width, naxis3=height}
                  begin
                    wide2:=naxis2;
                    height2:=naxis3;
                  end;
                end;{else RGB type with 3 seperate colors, naxis1 width, naxis2=length, naxis3=3  three color images}

               end;{no naxis 2}
            end;{no naxis 1}
          end;{no naxis}
        end;
      end;
      if (header[i]='C') then
         begin
           if ((header[i+1]='W') and (header[i+2]='H') and (header[i+3]='I') and (header[i+4]='T')  and (header[i+5]='E')) then
           cwhite:=validate_float {indicates the white point used when displaying the image}
           else
           if ((header[i+1]='B') and (header[i+2]='L') and (header[i+3]='A') and (header[i+4]='C')  and (header[i+5]='K')) then
           cblack:=validate_float; {indicates the black point used when displaying the image}
         end;

      if ((header[i]='B') and (header[i+1]='Z')  and (header[i+2]='E') and (header[i+3]='R') and (header[i+4]='O') ) then
               bzero:=round(validate_float);

       if ((header[i]='C') and (header[i+1]='R')  and (header[i+2]='O') and (header[i+3]='T') and (header[i+4]='A')) then
          begin
             if header[i+5]='2' then crota2:=validate_float
             else
             if header[i+5]='1' then crota1:=validate_float;
          end;
      if ((header[i]='C') and (header[i+1]='R')  and (header[i+2]='P') and (header[i+3]='I') and (header[i+4]='X')) then
          begin
            if header[i+5]='1' then crpix1:=validate_float else{ref pixel for x}
            if header[i+5]='2' then crpix2:=validate_float;    {ref pixel for y}
          end;
      if ((header[i]='C') and (header[i+1]='D')  and (header[i+2]='E') and (header[i+3]='L') and (header[i+4]='T')) then
          begin
            if header[i+5]='1' then cdelt1:=validate_float else{deg/pixel for RA}
            if header[i+5]='2' then cdelt2:=validate_float;    {deg/pixel for DEC}
          end;

      if ((header[i]='C') and (header[i+1]='R')  and (header[i+2]='V') and (header[i+3]='A') and (header[i+4]='L')) then
          begin
            if (header[i+5]='1') then  ra0:=validate_float*pi/180; {ra center, read real value}
            if (header[i+5]='2') then  dec0:=validate_float*pi/180; {dec center, read real value}
          end;

      if ((header[i]='C') and (header[i+1]='D')) then
          begin
            if ((header[i+2]='1') and (header[i+3]='_') and (header[i+4]='1')) then   cd1_1:=validate_float;
            if ((header[i+2]='1') and (header[i+3]='_') and (header[i+4]='2')) then   cd1_2:=validate_float;
            if ((header[i+2]='2') and (header[i+3]='_') and (header[i+4]='1')) then   cd2_1:=validate_float;
            if ((header[i+2]='2') and (header[i+3]='_') and (header[i+4]='2')) then   cd2_2:=validate_float;
          end;

      if ((header[i]='E') and (header[i+1]='Q')  and (header[i+2]='U') and (header[i+3]='I') and (header[i+4]='N') and (header[i+5]='O') and (header[i+6]='X')) then
               equinox2:=validate_float;{rotation, read real value}

      end_record:=((header[i]='E') and (header[i+1]='N')  and (header[i+2]='D'));{end of header}

      inc(i,80);{go to next 80 bytes record}

    until ((i>=2880) or (end_record));
  until end_record;

  if cd1_1=0  then
  begin
     if (crota1=0) then crota1:=crota2; {for case crota1 is not used}
     old_to_new_WCS;{ new WCS missing, convert old WCS to new}
  end;
  if cdelt2=0 then  cdelt2:=sqrt(sqr(cd1_2)+sqr(cd2_2));{Required for distance calculation. if no old wcs header use cd2_2 of new WCS style for pixel size}

  if cdelt2=0 then begin close_fits_file; exit;  end; {do not load bad fits}

  if (canvas2=nil) then
  begin {manual loaded FITS file}
     ra_az(ra0,dec0,latitude,0,wtime2,{var} viewx,viewy); {move sphere to center object}
     zoom:=abs(0.5*70/(height2*cdelt2));
     close_fits_file;
     result:=true;{solution in header. Consider this as a success}
     exit;
  end;

  if ((naxis=3) and (naxis1=3))  then nrbits:=24; {threat RGB fits as 2 dimensional with 24 bits data, 2014 added naxis1 condition}

  naam2:=ExtractFileName(FileN)+' '+inttostr(wide2)+'x';mag2:=wide2*10;{For later. Give one corner of the a hint containing FITS name and dimensions See also hintfits}

  ang_sep(telescope_ra,telescope_dec,ra0,dec0,dist);
  if dist-(abs(cdelt2)*height2*pi/360)>2/zoom then begin close_fits_file; exit;  end;{out of view}
           {second term allows better view of corners}

  angle:=(-crota2)*pi/180;{alternatively the corner positions could be used as give in FITS header}

  size2:=zoom*(work_height)*+abs(cdelt2)*(2*1.5*60/20000);{size of pixes/squares plotted}

  skipfactor:=round(0.78/size2);{factor 0.78 critical to prevent sometimes black lines}
  if skipfactor<1 then skipfactor:=1; {for smart way to skip pixels if overlapping, 2013}

  if size2>1 then size2:=size2+0.5;


  if round(size2)>1 then {prepare for square pixes using polygon in plot_pixel}
  begin {square pixe preparation}
    plot_pixel_sphere(canvas2,ra0+0.5/zoom,dec0,-99,$FFFFFF,0,0);{find angle on screen with two plot_pixel calls}
    if zc<0 then exit;{not in sight}
    xx:=x9;yy:=y9;
    plot_pixel_sphere(canvas2,ra0,dec0,-99,$FFFFFF,0,0);
    if zc<0 then exit;
    xx:=xx-x9; if abs(xx)<0.00001 then xx:=0.00001; {prevent divide zero}
    orien2:=arctan((yy-y9)/xx);
    orien2:=(angle-orien2);{find angle of pixels in FITS}
    rotate(orien2,size2,size2,xx,yy); {rotate a vector point, this case one of the corner of a square}
    square_x_step:=round(xx/2);
    square_y_step:=round(yy/2);
  end; {end square pixe preparation}

   if equinox2<>2000 then
       ep(equinox2,2000,ra0,dec0,ra0,dec0); {convert center position to new equinox }

  wide2:=min(wide2,round(bufwide/(abs(nrbits/8))));{prevent violation error too large images. limit wide to buffer, image will not displayed correctly}

  oldoutcolor:=$11FFFFFF;{non existing value}

  {READ IMAGE DATA IN ARRAY}
  setlength(img_loaded,3,wide2,height2);{set length of image array}

  if nrbits=24 then  for i:=0 to height2-1 do
                     begin
                       try reader_fits.read(fitsbuffer,wide2*round(abs(nrbits/8)));except; close_fits_file;  exit; end; {read file bytes}
                       for j:=0 to wide2-1 do
                       begin
                         rgbdummy:=fitsbufferRGB[j];
                         for k:=0 to 2 do
                           img_loaded[k,j,i]:=rgbdummy[k]+bzero;
                       end;
                    end
  else
  for k:=0 to naxis3-1 do {all colours}
  for i:=0 to height2-1 do
  begin
    try reader_fits.read(fitsbuffer,wide2*round(abs(nrbits/8)));except; close_fits_file;  exit; end; {read file bytes}
    for j:=0 to wide2-1 do
    begin
       if nrbits=8 then col_float:=fitsbuffer[j]+bzero
       else
       if nrbits=16 then
       begin
         wo:=swap(fitsbuffer2[j]);{move data to wo and therefore sign_int}
         col_float:=sign_int+bzero;
       end
       else
       if nrbits=-32 then  {4 byte floating point FITS image}
       begin
         x_longword:=swapendian(fitsbuffer4[j]);{conversion 32 bit "big-endian" data, x_single  : single absolute x_longword; }
         col_float:=x_single +bzero; {int_IEEE, swap four bytes and the read as floating point}
       end
       else
       if nrbits=32 then  {32 bit FITS image}
         col_float:=swapendian(fitsbuffer4[j])+bzero
       else
       col_float:=0; {unknown of -64 bit}


       img_loaded[k,j,i]:=col_float;
       if naxis3=1 then {monochrome}
       begin
         img_loaded[1,j,i]:=col_float;
         img_loaded[2,j,i]:=col_float;
       end;

    end;
  end;
  {END READING IMAGE DATA}

 {find background aand intensity values}
  if ((nrbits=8) or (nrbits=24)) then {do not measure for 8 byte files}
  begin
    cwhite:=255;
    cblack:=0;
  end
  else
  if cwhite<>65535 then {do nothing use cwhite cblack values}
  begin
  end
  else
  begin {measure data range}
    {find scaling}
    highest:=0;
    for k:=1 to 20 do {check 20 lines only}
    begin  {find scaling}
      i:=trunc((height2-1) *k /21);

      for j:=0 to wide2-1 do
      begin {find range}
        col_float:=img_loaded[0,j,i]; {use mono or red colour}
        if col_float>highest then highest:=col_float;
      end; {find range}
    end;

    {build histogram}
    for i:=0 to 255 do histogram[i]:=0;
    counter:=0;
    for k:=1 to 20 do {check 20 lines only}
    begin  {find scaling}
       i:=trunc((height2-1) *k /21);
       for j:=0 to wide2-1 do
       begin {find range}
         col_float:=img_loaded[0,j,i]; {use mono or red colour}
         if col_float>0.001 then
         begin
           inc(counter);
           colv:=trunc(255*col_float/highest);
           histogram[colv]:=histogram[colv]+1;
         end;
      end; {find range}
    end;


    {find background peak value}
    peakposition:=0;
    peakcounts:=0;
    for i:=0 to 127 do  {up to 255 is not required}
      if histogram[i]>peakcounts then
      begin
        peakcounts:=histogram[i];{find position which is most common equals background}
        peakposition:=i;
      end;

    {set cblack just below background value}
    i:=peakposition;{typical background position in histogram};
    blackpos:=0;
    while ((blackpos=0) and (i>0)) do
    begin
      dec(i);
      if histogram[i]<=0.1*peakcounts then blackpos:=i; {find position with 10% count below histo_peak_position}
    end;
    cblack:=highest*blackpos/255;

    {find star level}
    counts:=0;
    i:=255;
    while ((i>0) and (counts<0.003 * counter)) do {find star level where 0.03 of the values are above}
    begin
      counts:=counts+histogram[i];
      dec(i);
    end;
    cwhite:=highest*i/255;{star level}
  end; {measure range}


  {adapt to slider settings objectmenu}
  cblack:=cblack-(cwhite-cblack)*dss_background/100;
  if cblack<1 then cblack:=0;
  cwhite:=cwhite*(1-dss_brightness/100);if cwhite<=cblack then cwhite:=cblack+1;

  {plot fits to canvas}
  for i:=0 to height2-1 do  {plot fits file}
  begin
    for j:=0 to wide2-1 do
      if ( (frac(i/skipfactor)=0) and (frac(j/skipfactor)=0) ) then  {smart way to skip pixels if overlapping, 2013}
    begin
      col1:=round( (img_loaded[0,j,i]-cblack)*256/(cwhite-cblack) );{scale to 0..255 integer}
      if col1>255 then col1:=255; if col1<0   then col1:=0;


      if col1<>0 then
      begin
        {new WCS pixel to RA, DEC}
        dRa :=(cd1_1*(j+1-crpix1)+cd1_2*(i+1-crpix2))*pi/180;{+1 because pixels are counted in FITS files from 1 to wide/length !!}
        dDec:=(cd2_1*(j+1-crpix1)+cd2_2*(i+1-crpix2))*pi/180;
        sincos(dec0,sin_dec0,cos_dec0);
        delta:=cos_dec0-dDec*sin_dec0;
        gamma:=sqrt(dRa*dRa+delta*delta);
        RAM:=RA0+arctan2(Dra,delta); {arctan2 is required for images containing celestial pole}
        DECM:=arctan2((sin_dec0+dDec*cos_dec0),gamma);
        {new WCS}

        if canvas2=printer.canvas then {printing}
        begin {printer}
          if inverse_printing then {white sky}
             inverse_intensity_color(rgb(col1 ,col2,col3),outcolor)
            else outcolor:=rgb(col1 ,col2,col3);
           Canvas2.Pen.Color:=outcolor;
           Canvas2.brush.Color:=outcolor;

        end {printing}
        else
        begin {screen}
          col2:=round( (img_loaded[1,j,i]-cblack)*256/(cwhite-cblack) );{scale to 0..255 integer}
          if col2>255 then col2:=255; if col2<0   then col2:=0;
          col3:=round( (img_loaded[2,j,i]-cblack)*256/(cwhite-cblack) );{scale to 0..255 integer}
          if col3>255 then col3:=255; if col3<0   then col3:=0;


          outcolor:=rgb(round((Rcolor * col1 + back_Rcolor * (255 - col1)) / 255),
                        round((Gcolor * col2 + back_Gcolor * (255 - col2)) / 255),
                        round((Bcolor * col3 + back_Bcolor * (255 - col3)) / 255)  );
                         {Based on an idea of Leandro}
                         {http://courses.ece.uiuc.edu/ece291/lecture/lecture16.ppt
                         A flower will dissolve a swan
                         Alpha determines the intensity of the flower
                         The full intensity, the flower's 8-bit alpha value is FFh,  or 255
                         The equation below calculates each pixel:

                         Result_pixel =Flower_pixel *(alpha/255) + Swan_pixel * [1-(alpha/255)]
                         For alpha 230, the resulting pixel is 90% flower and 10% swan}

                         {Alpha blending takes two colors, back and foreground and mixes their r,g,b components by weighting them with a fourth
                         component: Alpha. Alpha is the degree of transparency of the foreground color. In our case, 0=transparent, 255=opaque. So,
                         if you use your fits 8 bit values
                         as the alpha channel, you can choose whatever color for background and foreground and the alpha blending routine will mix
                         them correctly. The only thing you cannot do is to choose same color for back and foreground (of course).}


         if round(size2)>=1 {large then one pixel drawing} then
         begin {larger then one pixel drawing}
           if naxis3>1  then {colour, only 255 monochrome brush and pen are created during startup program}
           begin
             if oldoutcolor<>outcolor then {slow process so only for larger then one pixel required and new color}
             begin
               Canvas2.Pen.Color:=outcolor;
               Canvas2.brush.Color:=outcolor;
               oldoutcolor:=outcolor;
             end;
           end{naxis3>1, nrbits=24}

           else {monochrome images use prepared pen and brush for speed !! almost 2 times faster}
           if oldoutcolor<>outcolor then {slow process so only for larger then one pixel required and new color}
           begin
             if ((dss_bandpass<>18) and (dss_bandpass<>7)) then {not blue}
             begin
               selectobject(Canvas2.handle,pen_dss[col1{col1 and not outcolor !}]);{use prepared pen faster then Canvas2.Pen.Color:=outcolor;}
               selectobject(Canvas2.handle,brush_dss[col1]);{use prepared brush faster then Canvas2.brush.Color:=outcolor;}
             end
             else
             begin
               selectobject(Canvas2.handle,pen_dss_blue[col1{col1 and not outcolor !}]);{use prepared pen faster then Canvas2.Pen.Color:=outcolor;}
               selectobject(Canvas2.handle,brush_dss_blue[col1]);{use prepared brush faster then Canvas2.brush.Color:=outcolor;}
             end;

             oldoutcolor:=outcolor; {compare outcolor rather then col1. Most likely less color changes.}
           end;
           end;{round(size2) >=1}
        end;{screen}

        if (round(size2)<=1) then
        begin
          plot_pixel_sphere(Canvas2,raM,decM,-99,outcolor,2,hintfits);{move to}

          fastbitmap1.pixels[x9,y9]:=outcolor;{write to fastbitmap1}
        end
        else
        plot_pixel_sphere(Canvas2,raM,decM,round(size2),outcolor,2,hintfits);{pixel or square box depending on size}

        hintfits:=0;
      end;{col<>0}
    end;{for j:=0 to wide2-1}
  end;{for i:=0 to height2-1}


  close_fits_file;

//  try
//    thefile:=extractfilename(filen);
//    val(copy(thefile,1,4),rac,error2);
//    val(copy(thefile,5,4),rac,error3);
//    if ((error2<>0) or (error3<>0)) then
//    begin
//      thepath:=extractfilepath(filen);
//      delete (thefile,pos('.',thefile),99);
//      while length(thefile)>8 do delete(thefile,9,1);
//      while length(thefile)<8 do thefile:=thefile+'_';
//      thefile:=thefile+position_to_string(ra0,dec0)+'.fit';
//      success:=renamefile(filen,thepath+thefile);
//    end;
//  except
//  end;

  result:=true;
end;{plotfits}

Procedure BubbleSort;{put jovian moon in sequence of distance}
Var i, j, temp2  : Integer;
    temp: double;
Begin
  for i := 4 downto 1 do
      for j := 1 to i-1 do
        if jovian_distance[j] < jovian_distance[j+1] then {sort, greater distance first}
          begin
            { swapping: array[j]<->array[j+1] }
            temp := jovian_distance[j];
            jovian_distance[j] := jovian_distance[j+1];
            jovian_distance[j+1] := temp;

            temp2 := jovian_moon_sequence[j]; {extra swapping sequence table}
            jovian_moon_sequence[j] := jovian_moon_sequence[j+1];
            jovian_moon_sequence[j+1] := temp2;
          end;
End;

procedure plot_PLANETS2(moon : boolean ;    dc : tcanvas);
  {if moon is false plot planets else The Moon. This to allow comet/asteroid plotting first}

var dia,dia_min,dia2,i,stepx,mode2   : integer;
    xxx ,ec2                         : double;
    umbra,penumbra                   : double;
    fits_success                     : boolean;
begin
  selectfont1(dc);
  if moon=false then mode2:=-46 else mode2:=-17;{do moon only}
  {use mode2 to prevent problems with proecessmessages and find_object also changing the mode}
  repeat
    begin
      newtime:=gettickcount64;
      if (abs(newtime-oldtime)>100) then
      begin
        Application.ProcessMessages;
        oldtime:=newtime;
      end;

     fits_success:=false;{try to plot planetary fits image}
     case mode2 of
                 -46: begin  planet(0,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);SetTextColor(dc.handle,colors[18]);
                             selectobject(dc.handle,penplanet1);selectobject(dc.handle,brushplanet1);naam2:=Sun_string;
                             dia_min:=round((work_height)/220);
                       end;
                 -45: begin sun_x9:=x9; sun_y9:=y9;{save sun position for moon orientation}
                            planet(9,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);{pluto}
                            if mag<1000 then naam2:=PLUTO_string else naam2:=' ';
                              {if outside allowed time range mag will be set at 1000}
                            dia_min:=1;
                            selectobject(dc.handle,penplanet3); {rocky planets}
                            selectobject(dc.handle,brushplanet3);
                            SetTextColor(dc.handle,colors[36] );
                            if zoom <120 then inc(mode2,1) {skip moons next time}
                            else begin pluto_ra:=ra2;pluto_dec:=dec2;planet_mag:=mag;planet_dia:=length2;; end;

                            end;
                 -44: begin if show_orbit<>0 then plot_orbit(dc,penplanet4,9,1,1);{here RA2 includes parallax !!}
                            planetmoons(9,1,julian_et,pluto_ra,pluto_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);{moon charon}
                            SetTextColor(dc.handle, colors[35]); selectobject(dc.handle,brushmoons);{jovian moons}
                            selectobject(dc.handle,penmoons);naam2:=Charon_string; end;

                 -43: begin planet(8,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);naam2:=NEPTUNE_string;
                            selectobject(dc.handle,penplanet2); {uranus, neptune, pluto}
                            selectobject(dc.handle,brushplanet2);

                            if zoom <120 then inc(mode2,1) {skip moons next time}
                            else begin neptune_ra:=ra2;neptune_dec:=dec2;planet_mag:=mag;planet_dia:=length2;; end;
                       end;
                 -42: begin if show_orbit<>0 then plot_orbit(dc,penplanet4,8,1,1);{here RA2 includes parallax !!}
                            planetmoons(8,1,julian_et,neptune_ra,neptune_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                            SetTextColor(dc.handle, colors[35]); selectobject(dc.handle,brushmoons);{jovian moons}
                            selectobject(dc.handle,penmoons);naam2:=Triton_string; end;
                 -41: begin planet(7,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);naam2:=URANUS_string;
                            {etTextColor(dc.handle, $606060);}
                            SetTextColor(dc.handle,colors[36] );
                            selectobject(dc.handle,penplanet2); {uranus, neptune, pluto}
                            selectobject(dc.handle,brushplanet2);
                            if zoom <90 then inc(mode2,4) {skip moons next time}
                            else begin uranus_ra:=ra2;uranus_dec:=dec2;planet_mag:=mag;planet_dia:=length2;
                            end;
                          END;
                 -40: begin if show_orbit<>0 then  plot_orbit(dc,penplanet4,7,1,4);  {here RA2 includes parallax !!}
                            selectobject(dc.handle,penplanet2); {uranus, neptune, pluto}
                            planetmoons(7,1,julian_et,uranus_ra,uranus_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                            SetTextColor(dc.handle,colors[35]); selectobject(dc.handle,brushmoons);{jovian moons}
                            selectobject(dc.handle,penmoons);naam2:=Ariel_string; end;
                 -39: begin planetmoons(7,2,julian_et,uranus_ra,uranus_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                            naam2:=Umbriel_string; end;
                 -38: begin planetmoons(7,3,julian_et,uranus_ra,uranus_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                            naam2:=Titania_string; end;
                 -37: begin planetmoons(7,4,julian_et,uranus_ra,uranus_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                            naam2:=Oberon_string; end;

                 -36: begin planet(6,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);naam2:=SATURN_string;
                            SetTextColor(dc.handle, colors[21]);
                            selectobject(dc.handle,penplanet3);selectobject(dc.handle,brushplanet3);
                            find_inc_ring(ra2,dec2);{find saturn ring opening}
                            planet_mag:=mag;{down here, because planet_mag is used for moons, independent from moons}
                            mag:=mag-abs(0.4*ring_inc/(28*pi/180));  {correction magnitude for ring}
                            if zoom <10 then inc(mode2,8) {skip moons next time}
                            else
                            begin
                              saturn_ra:=ra2;saturn_dec:=dec2;planet_dia:=length2;
                            end;
                            dia_min:=round((work_height)/300);
                          end;
                 -35: begin if show_orbit<>0 then plot_orbit(dc,penplanet4,6,1,8);{here RA2 includes parallax !!}
                            planetmoons(6,1,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            SetTextColor(dc.handle, colors[35]); selectobject(dc.handle,brushmoons);{jovian moons}
                            selectobject(dc.handle,penmoons);naam2:=Mimas_string;dia_min:=1; end;

                 -34: begin planetmoons(6,2,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            naam2:=Enceladus_string; end;
                 -33: begin planetmoons(6,3,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            naam2:=Tethys_string; end;
                 -32: begin planetmoons(6,4,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            naam2:=Dione_string; end;
                 -31: begin planetmoons(6,5,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            naam2:=Rhea_string; end;
                 -30: begin planetmoons(6,6,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            naam2:=Titan_string;end;
                 -29: begin planetmoons(6,7,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            naam2:=Hyperion_string; end;
                 -28: begin planetmoons(6,8,julian_et,saturn_ra,saturn_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            naam2:=Iapetus_string;end;
                 -27: begin planet(5,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);naam2:=JUPITER_string;
                            SetTextColor(dc.handle, colors[21]);
                            selectobject(dc.handle,penplanet3);selectobject(dc.handle,brushplanet3);
                            width2:=length2*(66854/71492)*(10/60);{unit in min*10}{see new meeus page 360}
                            if zoom <10 then inc(mode2,4) {skip jovian moons next time}
                             else
                             begin
                               {jovianmoons(julian_et,ra2,dec2,mag,length2);}
                               jupiter_ra:=ra2;jupiter_dec:=dec2;planet_mag:=mag;planet_dia:=length2;
                             end;
                             dia_min:=round(work_height/220);
                          end;
                 -26: begin  if show_orbit<>0 then plot_orbit(dc,penplanet4,5,1,4);{here RA2 includes parallax !!}
                             {work out sequence of plot by sorting distances, 2014}
                             planetmoons(5,1,julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);{calculate distances}
                             jovian_distance[1]:=moon_distance;jovian_moon_sequence[1]:=1;
                             planetmoons(5,2,julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                             jovian_distance[2]:=moon_distance;jovian_moon_sequence[2]:=2;
                             planetmoons(5,3,julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);{calculate distances}
                             jovian_distance[3]:=moon_distance;jovian_moon_sequence[3]:=3;
                             planetmoons(5,4,julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                             jovian_distance[4]:=moon_distance;jovian_moon_sequence[4]:=4;
                             Bubblesort; {sort moon sequence in distance, most distance first. So nearest moon will cover farthest}

                            {plot now first moon most far away}
                             planetmoons(5,jovian_moon_sequence[1],julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                             SetTextColor(dc.handle, colors[35]); selectobject(dc.handle,brushmoons);{jovian moons}
                             selectobject(dc.handle,penmoons);
                             naam2:=Jovian_moon_name[ jovian_moon_sequence[1]]{'I'};dia_min:=1;end;
                 -25: begin planetmoons(5,jovian_moon_sequence[2],julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            naam2:=Jovian_moon_name[ jovian_moon_sequence[2]]{'II'};end;
                 -24: begin planetmoons(5,jovian_moon_sequence[3],julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            naam2:=Jovian_moon_name[ jovian_moon_sequence[3]]{'III'};end;
                 -23: begin planetmoons(5,jovian_moon_sequence[4],julian_et,jupiter_ra,jupiter_dec,planet_mag,delta,planet_dia,ra2,dec2,mag,length2);
                            naam2:=Jovian_moon_name[ jovian_moon_sequence[4]]{'IV'};end;
                 -22: begin planet(4,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);naam2:=MARS_string;
                            SetTextColor(dc.handle, colors[21]);
                            selectobject(dc.handle,penplanet4);selectobject(dc.handle,brushplanet4);
                            if zoom <60 then begin inc(mode2,2);  {skip moons next time}
                                                   selectobject(dc.handle,penplanet3); selectobject(dc.handle,brushplanet3);end
                            else begin selectobject(dc.handle,brushplanet4);mars_ra:=ra2;mars_dec:=dec2;planet_mag:=mag;planet_dia:=length2; end;
                            dia_min:=round(((work_height))/300);
                            end;
                 -21: begin if show_orbit<>0 then plot_orbit(dc,penplanet4,4,1,2); {with Ra2 so parallax is included}
                            planetmoons(4,1,julian_et,mars_ra,mars_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                            SetTextColor(dc.handle, colors[35]); selectobject(dc.handle,brushmoons);{jovian moons}
                            selectobject(dc.handle,penmoons);naam2:=Phobos_string;dia_min:=1;{to fix in delphi version} end;
                 -20: begin planetmoons(4,2,julian_et,mars_ra,mars_dec,planet_mag,delta,planet_dia,{v}ra2,dec2,mag,length2);
                            naam2:=Deimos_string; end;

                 -19: begin planet(2,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);naam2:=VENUS_string;
                            selectobject(dc.handle,penplanet4);selectobject(dc.handle,brushplanet4);
                            SetTextColor(dc.handle,colors[21]);
                            dia_min:=round(((work_height))/220);
                       end;
                 -18: begin planet(1,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);naam2:=MERCURY_string;
                             dia_min:=round(((work_height))/300);
                      end;
                 -17: begin
                       planet(10,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);naam2:=MOON_string;
                         SetTextColor(dc.handle, colors[18]);
                         selectobject(dc.handle,penplanet4); selectobject(dc.handle,brushplanet4);
                         dia_min:=round(((work_height))/220);{for moon only mode so this one is always required}
                      end;

      end;

      {export find position to ASCOM telescope to follownaam2}
      if ((telescope_follow_solar=1) and  (comparetext(follownaam2,naam2)=0)) then export_to_telescope(ra2,dec2);

      mag2:=trunc(10*mag);
      length2:=length2*(10/60);{unit in min*10}

      if ((tracks2<>0) and (form_animation.Visible=true)) then naam2:=naam2+', '+copy(today2,6,12); {add date to hints in case tracks are plot in animation}


    end;{planets}

    if (mag<999)   then {escape for julian moons when behind jupiter or no comet,supplement available}
    begin
      dia2:=trunc(length2/(sizing_factor)*(work_height)*zoom);
        {note zoom*size/240 give error 215 whith high zoom}
      if dia2>3000 then dia:=3000 else dia:=dia2;{note dia2 is use earth shadow routine}
      if dia<dia_min then dia:=dia_min
      else
      if ((dia>1){maak niet kleiner anders geen fits plot by wide field} and (fits_insert<>0)) then {try to plot fits}
      begin
        clear_FastBitmap_selective(fastbitmap1,colors[0]);{clear fastbitmap pixels, used area only}

        if mode2<>-27 then width2 :=length2;{for plotfitsplanet, loading FITS images. Only jupiter is oval}
        case mode2 of
                     -46: fits_success:=plotfitsplanets(dc,dss_path+'map_sun.fit',0,0);{sun}
                     -43: fits_success:=plotfitsplanets(dc,dss_path+'map_neptune.fit',8,0);{Neptune}
                     -41: fits_success:=plotfitsplanets(dc,dss_path+'map_uranus.fit',7,0);{Uranus}
                     -36: fits_success:=plotfitsplanets(dc,dss_path+'map_saturn.fit',6,0);{Saturn}
                     -27: fits_success:=plotfitsplanets(dc,dss_path+'map_jupiter.fit',5,0);{jupiter}
                     -26: fits_success:=plotfitsplanets(dc,dss_path+Jovian_moon_fits[jovian_moon_sequence[1]],5,jovian_moon_sequence[1]);{Jovians moons, io.....}
                     -25: fits_success:=plotfitsplanets(dc,dss_path+Jovian_moon_fits[jovian_moon_sequence[2]],5,jovian_moon_sequence[2]);
                     -24: fits_success:=plotfitsplanets(dc,dss_path+Jovian_moon_fits[jovian_moon_sequence[3]],5,jovian_moon_sequence[3]);
                     -23: fits_success:=plotfitsplanets(dc,dss_path+Jovian_moon_fits[jovian_moon_sequence[4]],5,jovian_moon_sequence[4]);
                     -22: fits_success:=plotfitsplanets(dc,dss_path+'map_mars.fit',4,0);{mars}

                     -19: fits_success:=plotfitsplanets(dc,dss_path+'map_venus.fit',2,0);{venus}
                     -18: fits_success:=plotfitsplanets(dc,dss_path+'map_mercury.fit',1,0);{mercury}

                     -17: fits_success:=plotfitsplanets(dc,dss_path+'map_moon.fit',3,1);{moon}
                   end; {case}
      end;{try fits}
      if fits_success then
      begin
        if ((fastbitmap1.x_min<fastbitmap1.x_max){something plotted}) then FastBitmapTocanvas(fastbitmap1, dc);{add fastbitmap to bitmap2 containing the plotted FITS files}
      end { fits_success=true}
      else
      begin { fits_success=false}
        if ((mode2=-27) and (dia>4)) then {oval objects jupiter}
        begin
           plot_glx(dc,ra2,dec2,dia,pi/2-cos(ra2)*ecliptic2*pi/180,0);{draw galaxy/oval object}
        end
        else
        begin {round objects}
          plot_pixel_sphere(dc,ra2,dec2,dia,0,0 ,hints) {plot background circle}
        end;
        case mode2 of
          -17,-18,-19,-22: {draw moon shape for mercury,venus, mars, moon only}
            begin
              if ((zc>0)) then {visible, in sight}
              begin
                xxx:=sun_x9-x9; if abs(xxx)<0.000001 then xxx:=0.000001;
                ec2:=arctan((sun_y9-y9)/(xxx));
                if (sun_x9-x9)>pi then ec2:=ec2+pi;

                if mode2=-17 then
                  begin selectobject(dc.handle,penplanet1);selectobject(dc.handle,brushplanet1);end
                else
                  begin selectobject(dc.handle,penplanet3); selectobject(dc.handle,brushplanet3);end;
                draw_moon(dc,dia,(phase)/100,ec2+pi/2);
              end;{draw moon shape}
            end;
         end;{case}
         if ((zc>0) and (mag2<=naming-10/zoom) and (length(naam2)<>0))then dc.TextOut(x9+5, y9-font_height1,naam2);
      end;{fits_success=false}
      if mode2=-36 then {saturn ring}
           begin
             stepx:=round(1+zoom*work_height*planet_dia/(3000000));
             if printing=false then stepx:=min(stepx,100);{limit number of rings drawn}
             for i:=-stepx to stepx do
             begin
               if ((i<=0.21*stepx) or (i>=0.35*stepx)) then {no cassini ring}
               begin
                 moon_data[6,0,0]:=((5.5+i/(stepx))/5.5)*114000/AE;
                 plot_orbit(dc,penplanet1,6,0,0);
               end;
             end;
           end; {end ring,   plot ring saturn, not perfect no parallax correction ring}
      if ((zoom >10) and (mode2>=-26) and (mode2<=-23) and (dec_shadow<>1000)) then {shadows jupitermoons visible,2015}
         begin
           selectobject(dc.handle,penplanet3);
           selectobject(dc.handle,brushb);
           naam2:=naam2+'_shadow';
           mag2:=999;
           plot_pixel_sphere(dc,ra_shadow,dec_shadow,dia,0,0 ,hints); {plot background circle}
           selectobject(dc.handle,brushmoons);{restore the brush and pen for jovian moons for next moon}
           selectobject(dc.handle,penmoons);
         end; {shadows}

      if ((moon) and (phase>=99.9) and (zc>0)) {moon} then
        begin {earth shadow}                {shadowdiam = planetdiam - (sundiam-planetdia)*shadowdistance/sundistance}
          selectobject(dc.handle,pen_bound);                         {diameter umbra in moon diameters}
          planet(3,2000,julian_ET,ra2,dec2,dummy,umbra,delta,penumbra,dummy);{calculate earth shadow position in or exclusief parallax}
          {use previous moon dia as reference, however use dia2 otherwise shadow doesn't smaller when zooming out to wide views}

          mag2:=999;{for earth shadow hint}
          if ((tracks2<>0) and (form_animation.Visible=true))then naam2:=copy(EARTH_SHADOW_string,1,12)+', '+copy(today2,6,12) {add date to hints in case tracks are plot in animation}
          else naam2:=EARTH_SHADOW_string;
          plot_pixel_sphere(dc,ra2,dec2,round(dia2*umbra),0,1,hints);{draw dark shadow parallax dependent !!}

          selectobject(dc.handle,pen_ecliptic);
          plot_pixel_sphere(dc,ra2,dec2,round(dia2*penumbra),0,1,0);{draw dark shadow parallax dependent !!}

          TextOut(dc.handle, x9+5, y9,pchar(EARTH_SHADOW_string),length(EARTH_SHADOW_string));
        end;

    end;{mag<>999}
    inc(mode2);

  until mode2>=-17;{stop at mercury, do moon only if started with -17 !!!!!}
end;


//Var
//  startTick  : DWord;
//  deltaticks : DWord;

procedure PLOT_COMETS( dc:tcanvas);{comets}
var dia      : integer;
    name_all : boolean;
begin
//  startTick := gettickcount64;
  selectfont1(dc);
  type2:=comet_string;
  selectobject(dc.handle,pencomet);
  SetTextColor(dc.handle, colors[38]{ and $A0A0A0});
  selectobject(dc.handle,brushCOMET); {brush after textcolor. Check with VIC if this solves problem}
  length2:=0;
  mag:=999; {999=skip plotting of last comets when nothing plotted}
  linepos:=0;
  //readposition:=0;
  errors[0,1]:=0;{FOR ERROR COLOROURING}
  mode:=-5;
  name_all:=((comets_activated=2) and (naming>-99999));{name all in mode 2 but not when animation makes tracks, see plot_solartracks(canvas2:tcanvas);}
  repeat
    begin
    newtime:=gettickcount64;
    if (abs(newtime-oldtime)>100) then
    begin
      Application.ProcessMessages;
      oldtime:=newtime;
    end;
    read_comet('S');
    mag2:=trunc(10*mag);
    length2:=length2*(10/60);{unit in min*10}
    if ((tracks2<>0) and (form_animation.Visible=true))then naam2:=copy(naam2,1,12)+', '+copy(today2,6,12); {add date to hints in case tracks are plot in animation}

    if (mode=-5)   then {else escape for no comet available}
      begin
        dia:=trunc(length2/(sizing_factor)*(work_height)*zoom);
         {note zoom*size/240 give error 215 whith high zoom}
        if dia<1 then dia:=1; if dia>3000 then dia:=3000;
          plot_pixel_sphere(dc,ra2,dec2,dia,0,contour_only,hints); {plot open circel}
        if ((zc>0) and ((name_all) or (mag2<=naming-30/zoom)) and (length(naam2)<>0))then
                                                                              dc.TextOut(x9+5, y9-font_height1,naam2);

        {export find position to ASCOM telescope to follownaam2}
        if ((telescope_follow_solar=1) and  (comparetext(follownaam2,naam2)=0)) then export_to_telescope(ra2,dec2);

        plot_pixel_sphere(dc,ra2,dec2,-2,0,0,0);{move to for drawing tail}
        COMET_tail(1+length2/12000,RA2,DEC2);{calculate tails end, factor 1+length2/1200 further away from sun}
        plot_pixel_sphere(dc,ra2,dec2,-1,0,0,0);{draw tail}
      end;{mode=-5}
    end;
  until mode>=-4;
//      deltaticks := gettickcount64 - startTick;
//      ShowMessage(IntToStr(deltaticks) + 'ms');
end;

//Var
//  startTick  : DWord;
//  deltaticks : DWord;

procedure PLOT_ASTEROIDS( dc:tcanvas);
var dia      : integer;
    name_all : boolean;
begin
//  startTick := gettickcount64;
  selectfont1(dc);
  type2:=asteroid_string;
  selectobject(dc.handle,penasteroid);
  SetTextColor(dc.handle, colors[37]{ and $A0A0A0});
  length2:=0;
  selectobject(dc.handle,brushCOMET);

  mag:=999; {999=skip plotting of last comets when nothing plotted}
  linepos:=0;
//  readposition:=0;
  errors[1,1]:=0; {FOR ERROR COLOROURING}

  name_all:=((asteroids_activated=2) and (naming>-99999));{name all in mode 2 but not when animation makes tracks, see plot_solartracks(canvas2:tcanvas);}

  mode:=-3;
  repeat
    begin
    newtime:=gettickcount64;
    if (abs(newtime-oldtime)>100) then
    begin
      Application.ProcessMessages;
      oldtime:=newtime;
    end;
    read_asteroid('S');
    mag2:=trunc(10*mag);
    length2:=length2*(10/60);{unit in min*10}
    if ((tracks2<>0) and (form_animation.Visible=true)) then naam2:=copy(naam2,1,12)+', '+copy(today2,6,12); {add date to hints in case tracks are plot in animation}

    if (mode=-3)   then {else escape for no asteroid available}
      begin
        dia:=trunc(length2/(sizing_factor)*(work_height)*zoom);
         {note zoom*size/240 give error 215 whith high zoom}
        if dia<1 then dia:=1; if dia>3000 then dia:=3000;
          plot_pixel_sphere(dc,ra2,dec2,dia,0,1,hints); {plot open circel}
        if ((zc>0) and ((name_all) or (mag2<=(naming+50)-30/zoom)) and (length(naam2)<>0)) then {the +50 is because asteroids are smaller and have therefore have a greater brightness}
                                                              dc.TextOut(x9+5, y9-font_height1,naam2);

        {export find position to ASCOM telescope to follownaam2}
        if ((telescope_follow_solar=1) and  (comparetext(follownaam2,naam2)=0)) then export_to_telescope(ra2,dec2);
      end;{mode=-3}
    end;
  until mode>=-2;
//      deltaticks := gettickcount64 - startTick;
//      ShowMessage(IntToStr(deltaticks) + 'ms');
end;

procedure plot_fits_fastbitmap(canvas2:tcanvas;filen : string);
begin
  clear_FastBitmap_selective(fastbitmap1,colors[0]);{clear fastbitmap pixels, used area only}
  if plot_fits(canvas2,filen) then {did contain an astronomical solution}
  begin
    if (fastbitmap1.x_min<fastbitmap1.x_max){something plotted} then
       FastBitmapTocanvas(fastbitmap1, canvas2);{add fastbitmap to bitmap2 containing the plotted FITS files}
  end
  else
    mainwindow.statusbar1.caption:=('Astrometrical solution missing in '+ filen);{error message to canvas}
end;
procedure get_fits(canvas2:tcanvas;searchstr: string);
var
  SearchRec: TSearchRec;
  raf,decf,error2,error3 :  integer;
  dist : double;
  colour : string;
  red,blue, ir, unknown : boolean;
begin
  if DirectoryExists(dss_path)=false then  {error  directory wrong}
     canvas_error_message(dss_path+'  '+not_found);{error message to canvas}

//  supplstring2.Append(inttostr(gettickcount64)+'  '+'STARTING PLOTFITS: '+ floattostr(viewx*180/pi)+#39+' '+floattostr(viewy*180/pi) );

  if extra_fits_file<>'' then
    plot_fits_fastbitmap(canvas2,extra_fits_file);

  if FindFirst(dss_path+searchstr{dss_search}, faAnyFile, SearchRec)=0 then
  begin
    repeat
      if (copy(SearchRec.Name,1,4)<>'map_') then {do not here load moon and mars fits files}
      begin
        colour:=copy(SearchRec.Name,9,1);
        red:=((colour='R') and ((dss_bandpass=8) or  (dss_bandpass=35)));
        blue:=((colour='B') and ((dss_bandpass=7) or  (dss_bandpass=18)));
        ir:=((colour='I') and (dss_bandpass=37)); {infrared}
        unknown:=((colour<>'R') and (colour<>'B') and (colour<>'I'));

        if  ( (red) or (blue) or (ir) or (unknown)) then
        begin
          val(copy(SearchRec.Name,10,4),raf,error2); {extract ra in range 0..10000}
          val(copy(SearchRec.Name,14,4),decf,error3);{extract southpole distance in range 0..10000}
          if ((error2=0) and (error3=0)) then ang_sep(telescope_ra,telescope_dec,raf*pi*2/10000,-(pi/2) + decf*pi/10000,dist){use ra [0..9999] and south pole distance [0..9999]}
                                         else dist:=0;{accept files without position in the file name}
          if dist- 2*pi/180 <2/zoom then {fits center is in view }
          begin
             plot_fits_fastbitmap(canvas2, dss_path+SearchRec.Name);
             newtime:=gettickcount64;
             if (abs(newtime-oldtime)>100) then
             begin
               Application.ProcessMessages;
               oldtime:=newtime;
             end;
          end;
        end;
      end; {no maps}
    until ({(PLOTTING=0) or} (FindNext(SearchRec)<>0));
    Findclose(SearchRec);
  end;
//  supplstring2.Append(inttostr(gettickcount64)+'  ''END PLOTFITS: '+ floattostr(viewx*180/pi)+#39+' '+floattostr(viewy*180/pi) );

end;

procedure max_star_magnitude; {overhauled in 2015}
var
  area_visible,ln_area_per_star,
  magn_required_for_star_density: double;
  abbreviation                  : string;
begin
  area_visible:=((1080*1080)/(work_height*work_height))* 13271*(16/9)/(zoom*zoom); {visible area in square degrees with 2016 correction for work_height}
  ln_area_per_star:=ln(area_visible/(exp(8+density/8)));{ln of area availabe if 3000 stars=(exp(8+density/8)) displayed}

  {0.0128x2  - 0.9547x + 7.8866}
  magn_required_for_star_density:=10*(0.0128*ln_area_per_star*ln_area_per_star - 0.9546*ln_area_per_star + 7.8866);{empirical, limiting magnitude * 10 required for seeing 3000 stars in the area_visible}

  maxmag:=magn_required_for_star_density;
  boldfactor:=round(maxmag-65);
  abbreviation:=uppercase(copy(name_star,1,3));{uppercase to be sure for old defaults.hns}

  if stardatabase_displayed=0 then begin if boldfactor>=100-65 then boldfactor:=100-65;end {up to mag 10 vissible with default glider position. arrange weakest stars are within range 65-55 for color $444444}
  else
  if ((abbreviation='G18') and (stardatabase_displayed=290)) then begin if boldfactor>=180-65 then boldfactor:=180-65;end {290 up to mag 18.0 vissible with default glider position.}
  else
  if ((abbreviation='G17') and (stardatabase_displayed=290)) then begin if boldfactor>=170-65 then boldfactor:=180-65;end {290 up to mag 17.0 vissible with default glider position.}
  else
  if ((abbreviation='G16') and (stardatabase_displayed=290)) then begin if boldfactor>=160-65 then boldfactor:=180-65;end {290 up to mag 16.0 vissible with default glider position.}
  else
  if ((abbreviation='G15') and (stardatabase_displayed=290)) then begin if boldfactor>=150-65 then boldfactor:=180-65;end {290 up to mag 15.0 vissible with default glider position.}
  else
  if ((abbreviation='TUC' ) and (stardatabase_displayed=290)) then begin if boldfactor>=150-65 then boldfactor:=150-65;end {TYCHO/UCAC4 290 up to mag 15.0 vissible with default glider position.}
  else
  if stardatabase_displayed=290 then begin if boldfactor>=125-65 then boldfactor:=125-65;end {up to mag 12.5 vissible with default glider position.}
  else
  if stardatabase_displayed=3 then begin if boldfactor>=200-65 then boldfactor:=200-65;end {NOMAD, up to mag 20 vissible with default glider position.}
  else
  if stardatabase_displayed=4 then begin if boldfactor>=185-65 then boldfactor:=185-65;end {URAT, up to mag 18.5 vissible with default glider position.}
  else
  if stardatabase_displayed=5 then begin if boldfactor>=200-65 then boldfactor:=200-65;end {GAIA, up to mag 20 vissible with default glider position.}
  else
  if stardatabase_displayed=6 then begin if boldfactor>=200-65 then boldfactor:=200-65;end {PPMXL, up to mag 20 vissible with default glider position.}
  else
  begin if boldfactor>=165-65 then boldfactor:=170-65;end;{ucac4 and else}

  boldfactor:=boldfactor+ bold ; {bold is schuif in object menu};
  if maxmag>limitmagn*10 then maxmag:=limitmagn*10;
end;
  function select_primary_or_secondary_catalogue(stardatabase_selected2:integer):integer;{when to switch from primary to secondary star catalogue based on zoom and catalogue}
begin
   if (
          (name_star<>'') and  {2016 special, if no primary allow use of secondary database at low zoom}

        ( ((stardatabase_selected2 in [1,2]) and (zoom<80)) or           {UCAC4}
          ((stardatabase_selected2 in [3,4,5,6,7]) and (zoom<120))    )  {URAT, NOMAD, GAIA allows only small field, so use late}
            )
           then
    begin {use primary star catalogue}
      if upcase(ansichar(name_star[1])) in ['T','U','G']  then result:=290  else {tycho, U16, G17  .290     .290}
      {if name_star[1] in ['s','p','h'] then} result:= 0;      {sao, ppm, .dat}
    end
    else
    begin
      result:=stardatabase_selected2; {use secundary}
    end;
end;

//  Var
//    startTick  : DWord;
//    deltaticks : DWord;
Procedure PLOT_supplement(dc:tcanvas;sup:integer);
var
  dia,mag3,contour_only2,hints2,brightn_old,mag2_old : integer;
  open_cluster   :boolean;
  all_frames : string;
begin
//    startTick := gettickcount64;

  linepos:=0; {of supplstring}
  errors[SUP+1,1]:=0;{FOR ERROR COLOROURING}
  if sup=1 then worldmap:=pos('WORLD',Uppercase(name_supl1))>0 else
  if sup=2 then worldmap:=pos('WORLD',Uppercase(name_supl2))>0  else
  if sup=3 then worldmap:=pos('WORLD',Uppercase(name_supl3))>0  else
  if sup=4 then worldmap:=pos('WORLD',Uppercase(name_supl4))>0 else
  if sup=5 then worldmap:=pos('WORLD',Uppercase(name_supl5))>0 ;

  selectfont1(dc);
  mag:=0;{mag 999 is used to skip object}
  all_frames:='';{empthy the string containing the frames for server export}
  repeat
    read_supplement('S',sup);{supplement database, screen mode}
    if mag=999 then
    begin
//        deltaticks := gettickcount64 - startTick;
//        ShowMessage(IntToStr(deltaticks) + 'ms');
      if ((export_frames) and (all_frames<>'')) then mainwindow.SendToAll(all_frames); {export the found mosaic frames via the server}
      exit;
    end; ; {no more supplements there}
    newtime:=gettickcount64;
    if (abs(newtime-oldtime)>100) then
    begin
      Application.ProcessMessages;
      oldtime:=newtime;
    end;
    if brightn>0 then
    begin {deep sky, no point source}
        dia:=trunc(length2/(sizing_factor)*(work_height)*zoom);
        {note zoom*size/240 give error 215 whith high zoom}
        if dia<1 then dia:=1; if dia>3000 then dia:=3000;
        open_cluster:=((length(spectr)>=2) and (spectr[1]='O'));{is this a open cluster}
        if ((contour_only<>0) or (fits_insert<>0) or ((length(spectr)>=2) and ((spectr[1]='O'){OC} or (spectr[1]='D'){DN} or (spectr[2]='A' {galcl})))) then{ kijk uit gebruik niet de derde letter want die kan van oudere spectr zijn}
          contour_only2:=1
          else
          contour_only2:=0;

        if (brightn>limit_deep_medium_color) then  {use faintest color for brightness >121}
        begin
          if open_cluster then selectobject(dc.handle,pen4_dotted) else selectobject(dc.handle,pen4);
          if contour_only2=0 then begin if (dia>100) then selectobject(dc.handle,brushdeepsky4G) else selectobject(dc.handle,brushdeepsky4); end;
          SetTextColor(dc.handle, colors[8]);
        end
        else
        begin
          if brightn<=limit_deep_bright_color then {use brightest color or brightness <110}
          begin
            if open_cluster then selectobject(dc.handle,pen2_dotted) else selectobject(dc.handle,pen2);
            if contour_only2=0 then begin if (dia>100) then selectobject(dc.handle,brushdeepsky2G) else selectobject(dc.handle,brushdeepsky2); end;
            SetTextColor(dc.handle, colors[10]);
          end
          else
          begin  {average bright}
            if open_cluster then selectobject(dc.handle,pen3_dotted) else selectobject(dc.handle,pen3);
            if contour_only2=0 then begin if (dia>100) then selectobject(dc.handle,brushdeepsky3G) else selectobject(dc.handle,brushdeepsky3); end;
            SetTextColor(dc.handle,colors[9]);
          end;
        end;

        if ((dia>2) and (width2>0) and (orientation2<>999)) then
            plot_glx(dc,ra2,dec2,dia,orientation2*pi/180,contour_only2){draw galaxy/oval object}
        else
        begin
        if ((dia<>1) and (contour_only2<>0))
          then plot_pixel_sphere(dc,ra2,dec2,dia,0,1,hints) {plot open circel}
          else plot_pixel_sphere(dc,ra2,dec2,dia,0,0,hints); {draw circel object}
        end;
        if ((length(naam2)<>0) and (mag2<=naming-30/zoom) and (zc>0))then dc.TextOut(x9+5, y9-font_height1,naam2);
    end
    else {star}
    if brightn=0 then
    begin
       selectobject(dc.handle,pen1);{for stars}
       selectobject(dc.handle,brush0);
       SetTextColor(dc.handle,colors[24]{777777});
       mag3:=mag2-boldfactor;
       if mag3<-124 then mag3:=-124;{limit  mag3 to prevent outside bounderies error in star_size[mag3]}
       if mag3>65 then begin zc:=-1; end{do not indicate any more}
       else
       if mag3>55 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[2]{444444},0,hints); end {lowest magnitude}
       else
       if mag3>45 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[3]{777777},0,hints);end {lowest magnitude}
       else
       if mag3>35 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[4]{AAAAAA},0,hints);End
       ELSE
       plot_pixel_sphere(dc,ra2,dec2,star_size[mag3],colors[1]{FFFFFF},0,hints);

       if ((zc>0) and (namest<>0)) then dc.TextOut(x9+5, y9-font_height1,naam2);
    end  {stars}
    else
    if brightn<-100 then{xy info of moons}
    begin
      plot_pixel_sphere(dc,ra2,dec2,0,colors[34],0,hints);  {moon color}
      if ((length(naam2)<>0) and (mag2<=naming-30/zoom) and (zc>0))then
      begin
        SetTextColor(dc.handle,colors[35]);
        dc.TextOut(x9+5, y9-font_height1,naam2);
      end;
    end
    else {linemode}
    begin
        {brightn=-1 draw line to}
        {brightn=-2 move to}
        {brightn=-99 label}
       brightn_old:=brightn;{keep for later}

       if mag2=-20 then selectobject(dc.handle,pen_horizon)
       else
       if mag2=-21 then selectobject(dc.handle,pen2)
       else
       if mag2=-22 then selectobject(dc.handle,pen3)
       else
       if mag2=-23 then selectobject(dc.handle,pen4)
       else
       if mag2=-24 then selectobject(dc.handle,pen_bound)
       else
       if mag2=-25 then selectobject(dc.handle,pen_crosshair)
       else
       selectobject(dc.handle,pens);

       if ((brightn<=-3) and (brightn>=-5))=false then {no houses}
       begin
         if length(naam2)>0 then hints2:=hints else hints2:=0; {no empthy hints}
       end
       else
       begin  {houseses}
         if brightn=-3 then brightn:=-1  {the az/alt positions of the horizon houses are converted to ra/dec in read_supplement}
         else
         if brightn=-4 then brightn:=-2
         else
         if brightn=-5 then
         begin
           selectobject(dc.handle,brushb);
           brightn:=trunc(length2/(sizing_factor)*(work_height)*zoom); {circle and so on}
         end;
         hints2:=0;{no hits for horizon houses}
       end;{plot houses}
       if brightn=-99 then hints2:=0 {no hints, RA/DEC  label mode}
       else
       if brightn<=-98 then brightn:=-99; {hints on, , RA/DEC  label mode. -99 is only calculate x9,y9 position for label}

       mag2_old:=mag2;
       mag2:=-999;{suppress magnitude in hints of houses, lines, frames}

       if brightn<>-8 then
       plot_pixel_sphere(dc,ra2,dec2,brightn,0,0,hints2) {find  position and  add hint if required}
       else
       begin
         plot_rectangle(dc,width2*pi/(10*60*180),length2*pi/(10*60*180),orientation2*pi/180,ra2,dec2);
         if export_frames  then  {export the mosaic frames via the server}
           all_frames:=all_frames+floattostrF_local(ra2,0,7)+' '+floattostrF_local(dec2,0,7)+' '+naam2+' '+floattostrF_local(orientation2*pi/180,0,7)+#13+#10;{collect the frames in all_frames}
       end;

       if label_all_lines then {edit mode function}
         naam2:=inttostr(linepos);

       if ((brightn=-1) or (label_all_lines))  then {RA/DEC line mode or label}
       selectfont1(dc){underline}
       else
       selectfont3(dc); {no underline}


       if ((zc>0) and ((namest<>0) or (brightn<=-98) or (label_all_lines) or (mag2_old<=-20) {az/alt labels})  ) then
       begin
         if mag2_old=-20 then setTextColor(dc.handle,colors[16 ]){color text horizon}
         else
         if mag2_old=-21 then setTextColor(dc.handle,colors[10]){color text bright deepsky}
         else
         if mag2_old=-22 then setTextColor(dc.handle,colors[9]){color text medium deepsky}
         else
         if mag2_old=-23 then setTextColor(dc.handle,colors[8]){color text faint deepsky}
         else
         if mag2_old=-24 then setTextColor(dc.handle,colors[20]){color text bound}
         else
         if mag2_old=-25 then setTextColor(dc.handle,colors[28]){color text cross hair}
         else
         setTextColor(dc.handle,colors[26 ]);{constellation text label  color}
         if length(naam2)>0 then
         TextOut(dc.handle, x9+5, y9-font_height1,pchar(naam2),length(naam2));{do not use here dc.textout since it will move position}
       end;
    end;
  until false; {mode>1;}
end;

//Var
//  startTick  : DWord;
//  deltaticks : DWord;

procedure PLOT_DEEPSKY(dc:tcanvas);
var dia,contour_only2 : integer;
    open_cluster      : boolean;

begin
//  startTick := gettickcount64;

  selectfont1(dc);
  mag2:=0;
  linepos:=2; {first lines are comments}
  mode:=11;
  repeat
    read_deepsky('S');{deepsky database search, screen mode}

    if mode>11 then
    begin
//      deltaticks := gettickcount64 - startTick;
//      ShowMessage(IntToStr(deltaticks) + 'ms');
      exit;{new 2003-10-14}
    end;
    newtime:=gettickcount64;
    if (abs(newtime-oldtime)>100) then
    begin
      Application.ProcessMessages;
      oldtime:=newtime;
    end;
    begin {deep sky, no point source}
        dia:=trunc(length2/(sizing_factor)*(work_height)*zoom);
         {note zoom*size/240 give error 215 whith high zoom}
        open_cluster:=((length(spectr)>=2) and (spectr[1]='O'));{is this a open cluster}
        if dia<1 then dia:=1; if dia>3000 then dia:=3000;
        if ((contour_only<>0) or (fits_insert<>0) or ((length(spectr)>=2) and ((spectr[1]='O'){OC} or (spectr[1]='D'){DN} or (spectr[2]='A' {galcl})))) then{ kijk uit gebruik niet de derde letter want die kan not van oudere spectr zijn}
           contour_only2:=1
           else
           contour_only2:=0;

        if (brightn>limit_deep_medium_color) then  {faintest}
        begin
          if open_cluster then selectobject(dc.handle,pen4_dotted) else selectobject(dc.handle,pen4);
          if contour_only2=0 then begin if (dia>100) then selectobject(dc.handle,brushdeepsky4G) else selectobject(dc.handle,brushdeepsky4); end;
          SetTextColor(dc.handle, colors[8]);
        end
        else
        begin
          if brightn<=limit_deep_bright_color then {brightest}
          begin
            if open_cluster then selectobject(dc.handle,pen2_dotted) else selectobject(dc.handle,pen2);
            if contour_only2=0 then begin if (dia>100) then selectobject(dc.handle,brushdeepsky2G) else selectobject(dc.handle,brushdeepsky2);end;
            SetTextColor(dc.handle, colors[10]);
          end
          else
          begin  {average bright}
            if open_cluster then selectobject(dc.handle,pen3_dotted) else selectobject(dc.handle,pen3);
            if contour_only2=0 then begin if (dia>100) then selectobject(dc.handle,brushdeepsky3G) else selectobject(dc.handle,brushdeepsky3); end;
            SetTextColor(dc.handle,colors[9]);
          end;
        end;
        if ((dia>2) and (width2>0) and (orientation2<>999)) then
          plot_glx(dc,ra2,dec2,dia,orientation2*pi/180,contour_only2){draw galaxy/oval object}
        else
        begin
          plot_pixel_sphere(dc,ra2,dec2,dia,0,contour_only2,hints) {plot open circel}
        end;
        if ((length(naam2)<>0) and (mag2<=naming-30/zoom) and (zc>0))then
        begin
          dc.TextOut(x9+5, y9-font_height1,naam2  );
        end;
    end;

  until false;{always repeat}
end;

procedure plot_star_scale;{plots magnitude index}
var
    mag3,size,vert,links3 : integer;
    bb                       : string;
const  hh=11;
begin
   mainwindow.panel_starscale1.visible:=true;

  mainwindow.image_starscale1.width:= mainwindow.panel_starscale1.width;
  mainwindow.image_starscale1.height:= mainwindow.panel_starscale1.height;

  mainwindow.panel_starscale1.width:=font_height1*3;
  mainwindow.panel_starscale1.height:=round(font_height1*hh);
  mainwindow.panel_starscale1.top:=rrw.bottom - round(font_height1*hh);{rrw.bottom includes statusbar1.height}
  mainwindow.panel_starscale1.height:=round(font_height1*hh);

  mainwindow.image_starscale1.Picture.Bitmap.width := mainwindow.image_starscale1.Width;
  mainwindow.image_starscale1.Picture.Bitmap.Height:= mainwindow.image_starscale1.Height;

  mainwindow.Image_starscale1.canvas.brush.Color := Colors[0];{clear fill bitmap with background color}
  mainwindow.Image_starscale1.canvas.fillrect(mainwindow.image_starscale1.clientrect); {wis canvas using current brush}

  links3:=font_height1;

  vert:=round(font_height1*(hh-1));{mainwindow.Image_starscale1.height is delayed???}

  selectfont1(mainwindow.Image_starscale1.canvas);
  SetTextColor(mainwindow.Image_starscale1.canvas.handle,colors[24]{777777});
  selectobject(mainwindow.Image_starscale1.canvas.handle,pen1);{for stars}
  selectobject(mainwindow.Image_starscale1.canvas.handle,brush0);


  mag2:=round(maxmag)-80;{eight steps maximum}
  if mag2<0 then mag2:=0;
  repeat
    mag3:=mag2-boldfactor;
    if mag3<-124 then mag3:=-124;{limit  mag3 to prevent outside bounderies error in star_size[mag3]}

    if mag3>65 then exit{do not indicate any more}
    else
    if mag3>55 then size:=-3
    else
    if mag3>45 then size:=-2
    else
    if mag3>35 then size:=-1
    ELSE
    size:=star_size[mag3];

    case size
        of -3: mainwindow.Image_starscale1.canvas.pixels[links3,vert]:=colors[2];
           -2: mainwindow.Image_starscale1.canvas.pixels[links3,vert]:=colors[3];
           -1: mainwindow.Image_starscale1.canvas.pixels[links3,vert]:=colors[4]{AAAAAA};
            0: mainwindow.Image_starscale1.canvas.pixels[links3,vert]:=colors[1]{FFFFFF};
            else
            begin
               mainwindow.Image_starscale1.canvas.ellipse(links3-size,vert-size,links3+size,vert+size);
            end;
      end;{case}
    str(round(mag2/10):3,bb);
    mainwindow.Image_starscale1.canvas.textout(round(links3+4),vert-font_height1,bb);
    dec(vert,font_height1);
    mag2:=mag2+10;
  until vert< font_height1;
end;

procedure PLOT_STARS(dc:tcanvas);
var
  mag3            :integer;

begin
  {system.ansistrings.}strpcopy(database2,Not_available);{for case read error}
  if length(name_Star)<=9 then exit;

  selectfont1(dc);{223}
  SetTextColor(dc.handle,colors[24]{777777});
  selectobject(dc.handle,pen1);{for stars}
  selectobject(dc.handle,brush0);

  opendatabase2(name_star);
  mode:=13;
  type2:='';{to prevent ghost star names}
  repeat
    newtime:=gettickcount64;
    if (abs(newtime-oldtime)>100) then
    begin
      Application.ProcessMessages;
      oldtime:=newtime;
    end;
    {stars}
      read_star('S'); {star database search, screen mode}
      mag3:=mag2-boldfactor;
      if mag3<-124 then mag3:=-124;{limit  mag3 to prevent outside bounderies error in star_size[mag3]}
      if mag3>65 then begin zc:=-1; end{do not indicate any more}
      else
      if mag3>55 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[2]{444444},0,hints); end {lowest magnitude}
      else
      if mag3>45 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[3]{777777},0,hints);end {lowest magnitude}
      else
      if mag3>35 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[4]{AAAAAA},0,hints);End
      else
      plot_pixel_sphere(dc,ra2,dec2,star_size[mag3],colors[1]{FFFFFF},0,hints);

      if ((zc>0) and (length(type2)>0)) then
      begin
        {$ifdef mswindows}
        {$else} {unix}
///      dc.Brush.Style:=bsClear;{transparent style}{temp for vic}
        {$endif}
         dc.textout(x9+5,y9-font_height1,type2);
      end;
  until mode>13;
  objectmenu.star_combo1.HINT:=DATABASE2;{v230 ADD STAR FILE INFO TO HINT}

//  SetTextColor(dc.handle,colors[27]);
//  textout(dc.handle,200,100,pchar('maxmag:'+floattostr(maxmag)+'             '),20);
//  textout(dc.handle,200,130plotfits,pchar('zoom:'+floattostr(zoom)+'              '),20);
//  textout(dc.handle,200,160,pchar('boldfactor:'+floattostr(boldfactor)+'             '),20);
//  textout(dc.handle,200,190,pchar('density:'+floattostr(density)+'              '),20);
end;

function Gaia_star_color(Bp_Rp: integer):integer;
begin
  if Bp_Rp=-128  then result:=$00FF00 {unknown, green}
  else
  if Bp_Rp<=-0.25*10 then result:=$FF0000 {<-0.25 blauw}
  else
  if Bp_Rp<=-0.1*10 then result:=$FFFF00 {-0.25 tot -0.1 cyaan}
  else
  if Bp_Rp<=0.3*10 then result:=$FFFFFF {-0.1 tot 0.3 wit}
  else
  if Bp_Rp<=0.7*10 then result:=$A5FFFF {0.3 tot 0.7 geelwit}
  else
  if Bp_Rp<=1.0*10 then result:=$00FFFF {0.7 tot 1.0 geel}
  else
  if Bp_Rp<=1.5*10 then result:=$00A5FF {1.0 tot 1.5 oranje}
  else
  result:=$0000FF; {>1.5 rood}
end;

procedure PLOT_STARS_290(dc:tcanvas);
var
  mag3,star_color            :integer;

  i,j :integer;
begin
  {system.ansistrings.}strpcopy(database2,Not_available);{for case read error}
  if length(name_Star)<=9 then exit;

  selectfont1(dc);{223}
  SetTextColor(dc.handle,colors[24]{777777});

  selectobject(dc.handle,pen1);{for stars}

  selectobject(dc.handle,brush0);
  star_color:=$FFFFFF;{default}

  area290:=290+1; {!!!!! for 32 file system}

  mode:=13;

  repeat
    newtime:=gettickcount64;
    if (abs(newtime-oldtime)>100) then
    begin
      Application.ProcessMessages;
      oldtime:=newtime;
    end;
    {stars}
    if readdatabase290('S') then {if statement to prevent moon magnitude plotting if no stars is found}
    begin
      if ((star_colouring<>0) and  (Bp_Rp>=-128)) then {colouring on and database contains colour information}
      begin
        star_color:=Gaia_star_color(Bp_Rp);
        dc.pen.color:=star_color;
        dc.brush.color:=star_color;
      end;{star colouring}

      mag3:=mag2-boldfactor;

      if mag3<-124 then mag3:=-124;{limit  mag3 to prevent outside bounderies error in star_size[mag3]}

      if mag3>65 then begin zc:=-1; end{do not indicate any more}
      else
      if mag3>55 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[2]{444444}and star_color,0,hints); end {lowest magnitude}
      else
      if mag3>45 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[3]{777777}and star_color,0,hints);end {lowest magnitude}
      else
      if mag3>35 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[4]{AAAAAA}and star_color,0,hints);End
      else
      plot_pixel_sphere(dc,ra2,dec2,star_size[mag3],colors[1]{FFFFFF}and star_color,0,hints);

      if ((zc>0) and (length(type2)>0)) then
      begin
         if ((star_colouring<>0) and  (Bp_Rp>=-128)) then {fix background of text}
         begin
          {$ifdef mswindows}
          setbkmode(dc.handle,TRANSPARENT); {transparent}
          {$else} {Linux}
          dc.Brush.Style:=bsClear;{transparent style}
          {$endif}
        end;
        dc.textout(x9+5,y9-font_height1,type2);
      end;
    end;
  until mode>13;

  objectmenu.star_combo1.HINT:=DATABASE2;{v230 ADD STAR FILE INFO TO HINT}

//  SetTextColor(dc.handle,colors[27]);
//  textout(dc.handle,200,100,pchar('maxmag:'+floattostr(maxmag)+'             '),20);
//  textout(dc.handle,200,130,pchar('zoom:'+floattostr(zoom)+'              '),20);
//  textout(dc.handle,200,160,pchar('boldfactor:'+floattostr(boldfactor)+'             '),20);
//  textout(dc.handle,200,190,pchar('density:'+floattostr(density)+'              '),20);
end;
procedure PLOT_UCAC4STARS(dc:tcanvas);
  var
     mag3                    : integer;
     diameter                : double;
     error_index:boolean;
begin
  selectfont1(dc);{223}
  SetTextColor(dc.handle,colors[24]{777777});
  selectobject(dc.handle,pen1);{for stars}
  selectobject(dc.handle,brush0);

  type2:='';
  Application.ProcessMessages;
  mode:=18;
  findregionUCAC4(dc,path_ucac4,telescope_ra,telescope_dec,limitmagn,0,error_index);
  if error_index=true then mode:=100; {stop}
  while mode=18 do
  begin
    newtime:=gettickcount64;
    if (abs(newtime-oldtime)>100) then
    begin
       Application.ProcessMessages;
       oldtime:=newtime;
    end;
    {stars}
       read_UCAC4(dc,equinox_date,ra2,dec2,mag2);{Read local UCAC4 star database, starnr in naam2}
       if mag2=10000 then
       begin
         closeUSNO;
         mode:=100;
       end{einde}
       else
       begin
        mag3:=round(mag2-boldfactor);

        if mag3<-124 then mag3:=-124;{limit  mag3 to prevent outside bounderies error in star_size[mag3]}
        if mag3>65 then begin end{do not indicate any more}
        else
        if mag3>55 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[2]{444444},0,hints); end {lowest magnitude}
        else
        if mag3>45 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[3]{777777} ,0,hints);end {lowest magnitude}
        else
        if mag3>35 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[4] {AAAAAA},0,hints);End
        else
        begin
          if ((UCAC_leda_diameter<>0) or (UCAC_X2M_diameter<>0)) then
                   begin selectobject(dc.handle,pen_green);selectobject(dc.handle,brushgreen);
                         if UCAC_X2M_diameter= 0 then diameter:=UCAC_leda_diameter/6{log unit not implemente} else diameter:=UCAC_X2M_diameter/6;
                         plot_pixel_sphere(dc,ra2,dec2,trunc(diameter/(sizing_factor)*(work_height)*zoom),colors[23] {extended object},contour_only,hints);
                         selectobject(dc.handle,pen1); selectobject(dc.handle,brush0)
                   end
                   else begin ;plot_pixel_sphere(dc,ra2,dec2,star_size[mag3],colors[1],0,hints);end;
        end;
      end;
  end; {while}
end;


procedure PLOT_onlineSTARS(dc:tcanvas); {plot stars from  internet}
  var
     mag3,star_color              : integer;
begin
  selectfont1(dc);{223}
  SetTextColor(dc.handle,colors[24]{777777});
  selectobject(dc.handle,pen1);{for stars}
  selectobject(dc.handle,brush0);

  type2:='';
  onlinefieldcounter:=0;
  begin
    Application.ProcessMessages;
    mode:=20;
    while mode=20 do
    begin
      newtime:=gettickcount64;
      if (abs(newtime-oldtime)>100) then
      begin
       Application.ProcessMessages;
       oldtime:=newtime;
      end;
      {stars}
      if stardatabase_displayed=6 then read_PPMXLcatalog('S'){screen mode}
      else
      if stardatabase_displayed=5 then
      begin
          read_GAIAcatalog('S');{screen mode}
          if star_colouring<>0 then {colouring on}
          begin
            if (magBp<>0) and (magRP<>0) then Bp_Rp:=round((magBp-magRp)*10)  {database contains colour information}
                                         else Bp_Rp:=-128;
            star_color:=Gaia_star_color(Bp_Rp);
            dc.pen.color:=star_color;
            dc.brush.color:=star_color;
          end;{star colouring}
      end
      else
      if stardatabase_displayed=4 then read_URATcatalog('S'){screen mode}
      else
      if stardatabase_displayed=3 then read_NOMADcatalog('S') {screen mode}
      else
      if stardatabase_displayed=2 then read_UCAC4catalog('S');

      mag3:=round(mag2-boldfactor);
      if mag3<-124 then mag3:=-124;{limit  mag3 to prevent outside bounderies error in star_size[mag3]}
      if mag3>65 then begin end{do not indicate any more}
      else
      if mag3>55 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[2]{444444},0,hints); end {lowest magnitude}
      else
      if mag3>45 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[3]{777777} ,0,hints);end {lowest magnitude}
      else
      if mag3>35 then begin plot_pixel_sphere(dc,ra2,dec2,0,colors[4] {AAAAAA},0,hints);End
      else
      begin
        plot_pixel_sphere(dc,ra2,dec2,star_size[mag3],colors[1],0,hints);
      end;
    end; {while}
  end;{for loop}
end;

procedure find_line(dc:tcanvas);{find line from supplement 2}
begin
  linepos:=2; {first lines are comments}
  mag:=0;
  repeat  {find line position}
    read_supplement('M',2); {supplement2 }
     plot_pixel_sphere(dc,ra2,dec2,-99,$0,0,0);{mouse click search}
  until ( (mag=999) or  ((zc>0) and ( abs(mx-x9)<5 ) and ( abs(my-y9)<5) and (brightn<0){=line})   );
  if mag<>999 then
  begin
    cut_position:=linepos-1;
    message_canvas(x9,y9,clred,'✓');{set selected marker}
  end
  else
  begin
    cut_position:=0;
    beep;{not found}
  end;
end;

function extract_command(inp: string;pos1 {start comma}:integer): string; {find drawing_command/brightness in supplement line}
var
  position1,position2,i :integer;
begin
   position1:=0;
   for i := 1 to pos1 do
               position1:=posex(',',inp,position1+1); {find first comma position}

   position2:=posex(',',inp,position1+1);
   if position2=0 then position2:=length(inp)+1;{no next comma}
   result:=copy(inp,position1+1,position2-position1-1);
end;
function change_line_color(inp: string): string; {change line color in supplement line}
var
  value1 :string;
  position1,position2,i :integer;
begin
   position1:=0;
   for i := 1 to 6 do {go to magnitude}
               position1:=posex(',',inp,position1+1); {find first comma position}

   position2:=posex(',',inp,position1+1);
   if position2=0 then position2:=length(inp)+1;{no next comma}
   value1:=copy(inp,position1+1,position2-position1-1);
   if value1='-25' then  value1:='' {constellation}
   else
   if ((value1='') or (value1='0')) then  value1:='-20' {horizon}
   else
   if value1='-20' then  value1:='-21'
   else
   if value1='-20' then  value1:='-21'
   else
   if value1='-21' then  value1:='-22'
   else
   if value1='-22' then  value1:='-23'
   else
   if value1='-23' then  value1:='-24'
   else
   if value1='-24' then  value1:='-25';

   delete(inp,position1+1,position2-position1-1);
   insert(value1,inp,position1+1);
   result:=inp;
end;

function FontStyleToStr(Style: TFontStyles): string; {2013}
const
 {$IFDEF fpc}                                                    {NO longer required !!, stikeout and underline require to be swapped}
    StyleStrings: Array[TFontStyle] of string = ('Bold', 'Italic','Underline', 'StrikeOut');
   {$else} {delphi}
    StyleStrings: Array[TFontStyle] of string = ('Bold', 'Italic', 'Underline', 'StrikeOut');
   {$endif}
var
  Strings: TStringList;
  i      : TFontStyle;
begin
  Strings:=TStringList.create;
  try
    for i:=low(i) to high(i) do
      if i in Style then
        Strings.Add(StyleStrings[i]);
    result:=Strings.Commatext;
  finally
    Strings.free;
  end;
end;

function StrToFontStyle(StyleStr: string): TFontStyles; {2013}
const
 {$IFDEF fpc}                                                    {stikeout and underline require to be swapped}
  StyleStrings: Array[TFontStyle] of string = ('Bold', 'Italic','Underline', 'StrikeOut');
 {$else} {delphi}
  StyleStrings: Array[TFontStyle] of string = ('Bold', 'Italic','Underline', 'StrikeOut');
 {$endif}
var
  Strings: TStringList;
  i      : TFontStyle;
begin
  Strings:=TStringList.create;
  Strings.Commatext:=StyleStr;
  result:=[];
  try
    for i:=low(i) to high(i) do
     if Strings.IndexOf(StyleStrings[i])>= 0 then
       include(result, i);
  finally
    Strings.free;
  end;
  if fsStrikeOut in result then Result := [fsUnderLine]; {temporary fix till all compiler fixed}
end;

procedure loaddeep;
var
   oldmag,counter, perc20: integer;
begin
  with deepstring do
  begin
     try
     LoadFromFile(application_path+name_deep);{load from file }
     except;
       clear;
       if length(name_Deep)>4 {no error if blank or .HND} then application.messagebox(pchar(Deepsky_file+' '+name_deep+' '+not_found),pchar(Error_string),MB_ICONWARNING+MB_OK);
       deepstring.add(Not_available);
     end;

     {find the second and third section in the deep sky database by a magnitude dip}
     mode:=5;
     oldmag:=0;
     counter:=0;
     linepos:=2; {first lines are comments}
     perc20:=round(0.20*count);{For old databases, if no dip is found at about 13% then stop}
     repeat
       read_deepsky('T');{deepsky1 database search, text mode}
       if mag2<oldmag-10 then {Dip of 1 magnitude or larger, reached a new section}
       begin
         inc(counter);
         if counter=1 then position_deep2:=linepos-1
         else
         if counter=2 then position_deep3:=linepos-1;

       end;
       oldmag:=mag2;
     until ((mode>5) or (counter>=2) or (linepos>perc20){stop searching for dip});
     if position_deep2>9999999 then position_deep2:=round(0.01*count);
     if position_deep3>9999999 then position_deep3:=round(0.10*count);
  end;
end;

procedure loadcomet;
begin
  with cometstring do
  begin
     try
     LoadFromFile(documents_path+'hns_com1.cmt');	{ load from file }
     except;
       {action none}
       clear;
       cometstring.add(Not_available); {for seletcted databases info}
       cometfile_age:=Not_available; {2013}
       exit;
     end;
  end;
  cometfile_age:=DateTimeToStr(FileDateToDateTime(FileAge(documents_path+'hns_com1.cmt')));
end;

procedure loadasteroid;
begin
  with asteroidstring do
  begin
     try
     LoadFromFile(documents_path+'hns_ast1.ast');	{ load from file }
     except;
       {action none}
        clear;
        asteroidstring.add(Not_available);
        asteroidfile_age:=Not_available;{2013}
        exit;{2013}
     end;
  end;
  asteroidfile_age:=DateTimeToStr(FileDateToDateTime(FileAge(documents_path+'hns_ast1.ast')));
end;

procedure loadsupplement1;
begin
  if length(name_supl1)<=4 then supplstring1.add(';'+Not_available) {empthy path doesn't give always an error in linux}
  else
  with supplstring1 do
  begin
    try
      LoadFromFile(documents_path+name_supl1);	{ load from file }
    except;
     {action none}
      clear;
      supplstring1.add(';'+Not_available);
    end;
  end;
end;

procedure loadsupplement2;
begin
  if length(name_supl2)<=4 then supplstring2.add(';'+Not_available) {empthy path doesn't give always an error linux}
  else
  with supplstring2 do
  begin
    try
      LoadFromFile(documents_path+name_supl2);	{ load from file }
    except;
      {none}
       clear;
       supplstring2.add(';'+Not_available);
    end;
 end;
end;

procedure loadsupplement3;
begin
  if length(name_supl3)<=4 then supplstring3.add(';'+Not_available) {empthy path doesn't give always an error in linux}
  else
  with supplstring3 do
  begin
    try
      LoadFromFile(documents_path+name_supl3);	{ load from file }
    except;
      {none}
       clear;
       supplstring3.add(';'+Not_available);
    end;
 end;
end;

procedure loadsupplement4;
begin
  if length(name_supl4)<=4 then supplstring4.add(';'+Not_available) {empthy path doesn't give always an error in linux}
  else
  with supplstring4 do
  begin
    try
      LoadFromFile(documents_path+name_supl4);	{ load from file }
    except;
      {none}
       clear;
       supplstring4.add(';'+Not_available);
    end;
 end;
end;

procedure loadsupplement5;
begin
  if length(name_supl5)<=4 then supplstring5.add(';'+Not_available) {empthy path doesn't give always an error in linux}
  else
  with supplstring5 do
  begin
    try
      LoadFromFile(documents_path+name_supl5);	{ load from file }
    except;
      {none}
       clear;
       supplstring5.add(';'+Not_available);
    end;
 end;
end;

procedure loadtoast;
begin
  try
    if length(name_toast)>4 then png.LoadFromFile(application_path+name_toast)
    else
    begin {free memory}
      {$IFDEF fpc}
      freeandnil(png);
      png:= TPortableNetworkGraphic.Create;   {FPC}
      {$ELSE}
      png.Free;
      png := TPNGObject.Create; {delphi}
      {$ENDIF}
    end;
    except
  end;
end;


procedure setdefaultcolors;
begin
  colors[00]:=$000000; {background}
  colors[01]:=$FFFFFF; {white}
  colors[02]:=$444444; {star very faint}
  colors[03]:=$777777; {star faint}
  colors[04]:=$AAAAAA; {star medium}
  colors[05]:=rgb(80,90,80);{deep4}
  colors[06]:=rgb(130,140,130);{deep3}
  colors[07]:=rgb(170,180,170);{deep2}
  colors[08]:=$009000;{text deep4}
  colors[09]:=$00B000;{text deep3}
  colors[10]:=$00F000;{text deep2}
  colors[11] :=RGB(0,$70,0); {colorp}
  colors[12]:=rgb(170,170,170);{colora asteroid}
  colors[13]:=rgb(170,170,170);{colorc comet}

  colors[14]:=RGB(80,90,80);{brushplanet4, dark limbs. Not adjustable !!}
  colors[15]:=RGB(0,180,120);{brushplanet2, outer planets}

  colors[16]:=RGB($FF,$00,0);{text horizon}
  colors[17]:=RGB($90,0,0); {red  000070 pens}
  colors[18]:=$00FFFF; {sun and moon text color}
  colors[19]:=RGB(110,120,0);{pen_ecliptic}
  colors[20]:=RGB(0,110,110); {pen_bound}
  colors[21]:=$a0c0c0; {text color saturn, jupiter, mars, venus mercury }
  colors[22]:=$FF0000; {brush red GSC  }
  colors[23]:=$00FF00; {brushgreen and pen green, gsc}
  colors[24]:=$777777; {text stars}
  colors[25]:=$A0F0F0; {text info  after clicking on}
  colors[26]:=$0000A0; {text constellations}
  colors[27]:=$FFFFFF; {text info}
  colors[28]:=RGB(192,128,0); {cross-hair}
  colors[29]:=$006080; {text RA/DEC grid}
  colors[30]:=$0000FF; {DSS}
  colors[31]:=RGB(49,23,23); {color horizon}
  colors[32]:=RGB(238,209,111); {inner planets}
  colors[33]:=$D0FFFF; {sun,moon}
  colors[34]:=$FFFF00; {color moons}
  colors[35]:=$B0B000; {color moons labels}
  colors[36]:=$A0A0A0; {color uranus, neptune labels}
  colors[37]:=rgb(170,170,170);{color label asteroid}
  colors[38]:=rgb(170,170,170);{color label comet}
  colors[39]:=$00000; {menu color}
  colors[40]:=rgb(190,190,170);; {Milky Way}
  colors[41]:=$FF0000; {DSS}

  limit_deep_medium_color:=limitdeepmediumcolor;{go to default}
  limit_deep_bright_color:=limitdeepbrightcolor;

  inverse:=false;{do no longer use inversed copy of colors}
end;
procedure prepare_penbrush;
var
  i,outcolor      : integer;
  bcolor,gcolor,rcolor : integer; {fits color}
  back_bcolor,back_gcolor,back_rcolor : integer;{background colors}
begin
  pen11:=createpen(ps_insideframe,1,colors[11]);{007000, note ps_insideframe werkt niet in printer routine}
  penNS:=createpen(PS_dot,1,colors[11]);{north/south dotted line}
  pen4:=createpen(ps_insideframe,1,colors[5] {RGB(85,95,85)});{darkgreen}
  pen3:=createpen(ps_insideframe,1,colors[6]);{darkgreen}
  pen2:=createpen(ps_insideframe,1,colors[7]);{darkgreen}

  pen4_dotted:=createpen(ps_dot,1,colors[5] {palettergb(85,95,85)});{darkgreen}
  pen3_dotted:=createpen(ps_dot,1,colors[6]);{darkgreen}
  pen2_dotted:=createpen(ps_dot,1,colors[7]);{darkgreen}

  penasteroid:=createpen(ps_insideframe,1,colors[12]);
  pencomet:=createpen(ps_insideframe,1,colors[13]);

  brushdeepsky4:=createsolidbrush(colors[5]);
  brushdeepsky3:=createsolidbrush(colors[6]);
  brushdeepsky2:=createsolidbrush(colors[7]);

  {$ifdef mswindows}
  brushcomet:=CreateHatchBrush(HS_DIAGCROSS,colors[13]{RGB(1*64+1,1*64+1,1*64+1)});
  brushdeepsky4G:=CreateHatchBrush(hs_cross,colors[5]{RGB(1*64+1,1*64+1,1*64+1)});
  brushdeepsky3G:=CreateHatchBrush(hs_cross,colors[6]{RGB(1*64+1,1*64+1,1*64+1)});
  brushdeepsky2G:=CreateHatchBrush(hs_cross,colors[7]{RGB(1*64+1,1*64+1,1*64+1)});
  {$ELSE} {Linux}
  brushcomet:=CreatesolidBrush(colors[13]{RGB(1*64+1,1*64+1,1*64+1)});
  brushdeepsky4G:=CreatesolidBrush(colors[5]{RGB(1*64+1,1*64+1,1*64+1)});
  brushdeepsky3G:=CreatesolidBrush(colors[6]{RGB(1*64+1,1*64+1,1*64+1)});
  brushdeepsky2G:=CreatesolidBrush(colors[7]{RGB(1*64+1,1*64+1,1*64+1)});
  {$endif}


  pen0:=createpen(ps_insideframe,1,colors[0]);{background to erase, 2018}
  pen_horizon:=createpen(ps_insideframe,5,colors[31]); {horizon}
  if colors[31]<>colors[0] then {horizon made background}
     pen_below_horizon:=createpen(ps_insideframe,1,colors[31])  {below horizon}
  else
    pen_below_horizon:=createpen(ps_insideframe,1,colors[11]);  {below horizon grid equals above grid}
  pen1:=createpen(ps_insideframe,1,colors[1]) {RGB(255,255,255)};
  penS:=createpen(ps_insideframe,1,colors[17]) {RGB($70,0,0)}; {red  000070}
  penmoons:=createpen(ps_insideframe,1,colors[34]);
  pen_ecliptic:=createpen(ps_dot,1,colors[19]){RGB(110,120,0)};
  pen_milkyway:=createpen(ps_dot,1,colors[40]);

  pen_bound:=createpen(ps_dot,1,colors[20]{RGB(0,110,110)});
  pen_blue  :=createpen(ps_insideframe,1,colors[22]);{gsc}
  pen_green:=createpen(ps_insideframe,1,colors[23]);{gsc RGB(0,255,0)}

  penplanet4:=createpen(ps_insideframe,1,colors[14]);
  penplanet3:=createpen(ps_insideframe,1,colors[32]);{inner planets}
  penplanet2:=createpen(ps_insideframe,1,colors[15]);
  penplanet1:=createpen(ps_insideframe,1,colors[33]);
  pen_crosshair:=createpen(ps_insideframe,1,colors[28] {RGB($70,0,0)}); {red  000070}

  brushplanet4:=createsolidbrush(colors[14]);
  brushplanet3:=createsolidbrush(colors[32]);{inner planets}
  brushplanet2:=Createsolidbrush(colors[15]);
  brushplanet1:=Createsolidbrush(colors[33]);

  brushb:=createsolidbrush(colors[0] {000000});
  brush0:=createsolidbrush(colors[1]{FFFFFF});
  brushmoons:=createsolidbrush(colors[34]);
  brushred:=createsolidbrush(colors[22]{FF0000 GSC});
  brushgreen:=createsolidbrush(colors[23]{00FF00 GSC});

  {now prepare pen and brush for monochrome FITS}

  {DSS red}
  back_Bcolor:=getBvalue(colors[0]); {background seperate colors}
  back_Gcolor:=getGvalue(colors[0]);
  back_Rcolor:=getRvalue(colors[0]);

  if colors[30] and $FF0000>0 then Bcolor:=$FF else Bcolor:=0;
  if colors[30] and $00FF00>0 then Gcolor:=$FF else Gcolor:=0;
  if colors[30] and $0000FF>0 then Rcolor:=$FF else Rcolor:=0;
  for i:=0 to 255 do
  begin
    outcolor:=RGB(round((Rcolor * i + back_Rcolor * (255 - i)) / 255),
                         round((Gcolor * i + back_Gcolor * (255 - i)) / 255),
                         round((Bcolor * i + back_Bcolor * (255 - i)) / 255)  );
    pen_dss[i]:=createpen(ps_insideframe,1,outcolor);
    brush_dss[i]:=createsolidbrush(outcolor);
  end;

  {DSS blue}
  if colors[41] and $FF0000>0 then Bcolor:=$FF else Bcolor:=0;
  if colors[41] and $00FF00>0 then Gcolor:=$FF else Gcolor:=0;
  if colors[41] and $0000FF>0 then Rcolor:=$FF else Rcolor:=0;
  for i:=0 to 255 do
  begin
    outcolor:=RGB(round((Rcolor * i + back_Rcolor * (255 - i)) / 255),
                         round((Gcolor * i + back_Gcolor * (255 - i)) / 255),
                         round((Bcolor * i + back_Bcolor * (255 - i)) / 255)  );
    pen_dss_blue[i]:=createpen(ps_insideframe,1,outcolor);
    brush_dss_blue[i]:=createsolidbrush(outcolor);
  end;

  {end prepare pen and brush for monochrome FITS}

   mainwindow.statusbar1.font.color:=colors[25];
   mainwindow.toolbar2.color:=colors[39];
   mainwindow.toolbar2.font.color:=colors[27];{menu font colour}

end;

procedure delete_penbrush;
var
   i:integer;
begin
  for i:=255 downto 0 do
  begin
    DeleteObject(brush_dss[i]);
    DeleteObject(pen_dss[i]);
    DeleteObject(brush_dss_blue[i]);
    DeleteObject(pen_dss_blue[i]);
  end;

  DeleteObject(brushgreen);
  DeleteObject(brushred);

  DeleteObject(brushmoons);
  DeleteObject(brush0);
  DeleteObject(brushB);


  DeleteObject(brushplanet1);
  DeleteObject(brushplanet2);
  DeleteObject(brushplanet3);
  DeleteObject(brushplanet4);

  DeleteObject(pen_crosshair);
  DeleteObject(penplanet1);
  DeleteObject(penplanet2);
  DeleteObject(penplanet3);
  DeleteObject(penplanet4);

  DeleteObject(pen_green);
  DeleteObject(pen_blue);
  DeleteObject(pen_bound);
  DeleteObject(pen_ecliptic);
  DeleteObject(pen_milkyway);

  DeleteObject(penmoons);
  DeleteObject(pens);
  DeleteObject(pen1);
  DeleteObject(pen_horizon);
  DeleteObject(pen_below_horizon);
  DeleteObject(pen0);

  DeleteObject(brushdeepsky2G);
  DeleteObject(brushdeepsky2);
  DeleteObject(brushdeepsky3G);
  DeleteObject(brushdeepsky3);
  DeleteObject(brushdeepsky4G);
  DeleteObject(brushdeepsky4);

  DeleteObject(brushcomet);
  DeleteObject(pencomet);

  DeleteObject(penasteroid);

  DeleteObject(pen2);
  DeleteObject(pen3);
  DeleteObject(pen4);
  DeleteObject(pen2_dotted);
  DeleteObject(pen3_dotted);
  DeleteObject(pen4_dotted);

  DeleteObject(pen11);

end;
procedure update_button_hints;{copy mainmenu hints and objectmenu hints to buttons}
begin
//  mainwindow.searchtoolbutton.hint:=mainwindow.search1.hint;{tool buttons hints}
//  mainwindow.intoolbutton.hint:=mainwindow.in1.hint;
//  mainwindow.outtoolbutton.hint:=mainwindow.out1.hint;
//  mainwindow.objectstoolbutton.hint:=mainwindow.objects1.hint;
  mainwindow.Enterdatetimetoolbutton.hint:=mainwindow.Enterdatetime1.hint;
  mainwindow.GotoRADECToolButton.hint:=mainwindow.GotoRADEC1.hint;
  mainwindow.Foundobjectmarkertoolbutton.hint:=mainwindow.Foundobjectmarker1.hint;
  mainwindow.instrumentstoolbutton.hint:=mainwindow.Instruments1.hint;
  mainwindow.undotoolbutton.hint:=mainwindow.undoview1.hint;
  mainwindow.redotoolbutton.hint:=mainwindow.redoview1.hint;
  mainwindow.deephlptoolbutton.hint:=mainwindow.help1.hint;
  mainwindow.Savesettingstoolbutton.hint:=mainwindow.Savesettings1.hint;
  mainwindow.telescope_aborttoolbutton.hint:=mainwindow.telescope_abort1.hint;
  mainwindow.settingstoolbutton.hint:=mainwindow.settings1.hint;
  mainwindow.deephlptoolbutton.hint:=mainwindow.deepskyobservations1.hint;
  mainwindow.Darknightstoolbutton.hint:=mainwindow.Darknights1.hint;
  mainwindow.animatetoolbutton.hint:=mainwindow.animation1.hint;
  mainwindow.Solarsystemtonighttoolbutton.hint:=mainwindow.Solarsystemtonight1.hint;
  mainwindow.gridRAtoolbutton.hint:=mainwindow.GridRADEC1.hint;

  mainwindow.gridAZtoolbutton.hint:=mainwindow.GridAZAlt1.hint;
  mainwindow.milkywaytoolbutton.hint:=mainwindow.Milkyway1.hint;
  mainwindow.earthtoolbutton.hint:=mainwindow.earth1.hint;
  mainwindow.constellationstoolbutton.hint:=mainwindow.Constellations1.hint;
  mainwindow.fitstoolbutton.hint:=mainwindow.InsertFITSimage1.hint;
  mainwindow.flipHtoolbutton.hint:=mainwindow.Fliphorizontal1.hint;
  mainwindow.flipVtoolbutton.hint:=mainwindow.Flipvertical1.hint;
  mainwindow.Northabovetoolbutton.hint:=mainwindow.Northabove1.hint;
  mainwindow.siderealtoolbutton.hint:=mainwindow.sidereal1.hint;
end;

procedure load_settings(update_time :integer);
var
  initstring :tstrings; {settings for save and loading}
  i,yyyy     : integer;
  dock       : string;
  {$ifdef mswindows}
  SystemTime: tSystemTime;  {contains computer time}
  {$endif}
  {$ifdef unix}
  datetime : tdatetime;
  {$endif}

      Procedure get_float(var float: double;s1 : string); {this give much smaller exe file then using strtofloat}
      var s2:string; err:integer; r:double;
      begin
        s2:=initstring.Values[s1];
        val(s2,r,err);
        if err=0 then float:=r;
      end;

      Procedure get_int(var integ: integer;s1 : string);{this give much smaller exe file then using strtoint}
      var s2:string; err:integer; r:integer;
      begin
        s2:=initstring.Values[s1];
        val(s2,r,err);
        if err=0 then integ:=r;
      end;

      Function get_boolean(s1 : string;default1:boolean): boolean;
      var s2:string; err:integer; r:integer;
      begin
        s2:=initstring.Values[s1];
        val(s2,r,err);
        if err<>0 then result:=default1 {if no data, result is default1}
        else
        begin
           if r<=0 then result:=false
           else result:=true;
        end;
      end;

      procedure get_str(var s1: string; const lab : string);
      var vv:string;
      begin
        vv:=initstring.Values[lab];
        if vv<>'' then s1:=vv;{use value if available lese keep existing value}
      end;
Begin
  font_charset:=mainwindow.font.charset;{default if not overwritten by loadfile}
  font_name:=mainwindow.font.name;
  initstring := Tstringlist.Create;
  with initstring do
  begin
    try
    loadfromFile(FileName);	{ load from file, contain already documents path }
    except
      initstring.Free;{2015}
      getdatetime(true,false);{set time and julian good}
      mainwindow.OnoffClick(nil);{update toolbuttons in accordance with pulldownmenu, normally off}

      new_user:=true;
      exit; {new user or error}
    end;
  end;

  if initstring.count<20 then {not a normal file, not enough strings. Protection against old files}
  begin
    new_user:=true;
    getdatetime(true,false);{set time and julian good}
    exit; {new user or error}
  end;

  get_float(longitude,'longitude');
  get_float(reallatitude,'latitude');
  get_float(timezone,'time_zone');
  get_float(zoom,'zoom');
  get_float(telescope_Ra,'telescope_ra');
  get_float(telescope_dec,'telescope_dec');
  get_float( apparent_horizon,'apparent_horizon');
  get_float( frame_width,'frame_width'); {ccd frame}
  get_float( frame_height,'frame_height');
  get_float( limitmagn,'limit_magn');
  get_float( step_size,'step_size');
  get_float( nr_of_steps,'nr_of_steps');
  get_float(  telrad[1],'telrad1');
  get_float(  telrad[2],'telrad2');
  get_float(  telrad[3],'telrad3');
  get_float(  telrad[4],'telrad4');
  get_float(  telrad[5],'telrad5');
  get_float(  density,'density');
  get_float(  min_size_deep,'min_size_deep');
  get_float(  nautical_end,'nautical_end');{normally -18, for use in darkform}


   {integers}
  get_int(projection,'projection');
  get_int(bold,'bold');{star boldness}
  get_int(deep,'deep');{how many deep sky objects will be displayed};
  get_int(naming,'naming');{how many names of deepsky displayed}
  get_int(deepsky_level,'deep_level');{deep sky level}

  get_int(daylight_saving,'daylight_saving');
  get_int(north,'north');
  get_int(equinox,'equinox');
  get_int(equinox_telescope,'equinox_telescope');
  get_int(azimuth_degrees,'azimuth_degrees');
  get_int(parallax2,'parallax');
  get_int(flipv,'flipv');
  get_int(fliph,'fliph');
  get_int(cross,'cross');
  get_int(star_colouring,'star_colouring');
  get_int(namest,'namest');
  get_int(constellat,'constellations');
  get_int(boundaries,'boundaries');
  get_int(milkyway,'milkyway');
  get_int(earth,'earth');
  get_int(stardatabase_selected,'star_database');{DAT, .290, GSC or USNO}
  get_int(contour_only,'contour_only');
  get_int(show_orbit,'show_orbit');
  get_int(northtop,'north_top');
  get_int(magscale,'mag_scale');
  get_int(grid,'grid');
  get_int(northarrow,'north_arrow');
  get_int(hide_mainmenu,'hide_mainmenu');
  get_int(hide_mainmenu_text,'hide_mainmenu_text');
  get_int(clock,'clock');
  get_int(sidereal,'sidereal');
  get_int(find_solareclipse,'find_solar_eclipse');


  auto_zoom:=initstring.Values['auto_zoom']='1';
  slewto:=initstring.Values['slew_to']='1';

  get_int(deep_database,'deep_database');
  get_int(suppl1_activated,'suppl1_activated');
  get_int(suppl2_activated,'suppl2_activated');
  get_int(suppl3_activated,'suppl3_activated');
  get_int(suppl4_activated,'suppl4_activated');
  get_int(suppl5_activated,'suppl5_activated');
  get_int(toast_activated,'toast_activated');
  get_int(hints,'hints');
  get_int(mframe,'frame');

  get_int(timestep,'time_step');
  get_int(stars_activated,'stars_activated');
  get_int(planets_activated,'planets_activated');

  get_int(comets_activated,'comets_activated');
  get_int(asteroids_activated,'asteroids_activated');
  get_int(plot_moon_movement,'plot_moon_movement');
  get_int(step_unit,'step_unit');
  mainwindow.Twolinesnorthsouth1.checked:=initstring.Values['marker_two_lines']='1';

  get_int(marker_telrad,'marker_telrad');
  get_int(marker_name,'marker_name');

  mainwindow.connect_telescope1.checked:=initstring.Values['enable_telescope']='1';;

  mainwindow.Objectinfotoclipboard1.checked :=initstring.Values['Objectinfotoclipboard']='1';
  Time_Reference:=initstring.Values['time_reference'];{'UTC' else Time_Reference'TDT'}

  filtertype:=initstring.Values['filter_type'];
  get_int(fontsize1,'fontsize1');
  get_int(fontsize2,'fontsize2');
  get_int(fontsize3,'fontsize3');
  get_int(fits_insert,'fits_insert');
  get_int(dss_background,'dss_background');{dss background and brightness}
  get_int(dss_brightness,'dss_brightness');
  get_int(limit_deep_bright_color,'limit_deep_bright_color');
  get_int(limit_deep_medium_color,'limit_deep_medium_color');

  get_int(objectmenuleft,'objectmenu_left');
  get_int(objectmenutop,'objectmenu_top');
  get_int(stars_external_index,'stars_external_index');

  get_int(searchmenutop,'searchmenu_top');

  get_int(searchmenuleft,'searchmenu_left');

  get_int(datemenutop,'datemenu_top');
  get_int(datemenuleft,'datemenu_left');
  get_int(gotomenutop,'gotomenu_top');
  get_int(gotomenuleft,'gotomenu_left');
  get_int(animationtop,'animation_top');
  get_int(animationleft,'animation_left');

  get_int(gridstep,'grid_step');
  get_int(font_charset,'font_charset');
  get_int(page_settings,'page_settings'); {set page of settings pagecontrol}
  get_int(fontsize_e,'fontsize_edit');
  get_int(mouse_wheel_reverse,'mouse_wheel_reverse');{mouse reverse}
  get_int(moon_covers_stars,'moon_covers_stars');
  get_int(earth_covers_stars,'earth_covers_stars');
  get_int(Zoom_show_DSS,'zoom_show_dss');{show DSS fits early?}

  get_int(de430_emphemeris,'de_emphemeris');{use DE430, 431}
  get_int(grs_offset,'grs_offset');{jupier grs}


  actualtime:=initstring.Values['actual_time']='1';
  server_on:=initstring.Values['server']='1';
  fontname_E:=initstring.Values['fontname_edit'];

  get_str(internet_skyview_wide,'internetskyview_wide');
  get_str(internet_skyview,'internetskyview');
  get_str(internet_eso,'internet_eso');
  get_str(internet_mast,'internet_mast');
  get_int(dss_bandpass,'dss_bandpass');{bandpass dss download}
     set_dds_bandpass_menu;


  get_str(internet_simbad,'internet_simbad2');


  get_str(internet_leda,'internet_leda2');
//  internet_leda:=stringreplace(internet_leda,'vt<','bt<',[]);{remove in mid 2020}

  get_str(internet_ned,'internet_ned');

  get_str(vizier_server,'internet_vizier');

  get_str(internet_asteroid,'internet_asteroid2');
  get_str(asteroids_maxnr,'asteroids_maxnr');
  get_str(asteroids_maxmagn,'asteroids_maxmagn');

  get_str(internet_comet,'internet_comet');

  name_star:=initstring.Values['name_star'];
  name_deep:=initstring.Values['name_deep'];
     if pos('level',name_deep)>0 then name_deep:='deep_sky.hnd';{temporary. Remove after 3 years in 2022}
  name_supl1:=initstring.Values['name_supl1'];
  name_supl2:=initstring.Values['name_supl2'];
  name_supl3:=initstring.Values['name_supl3'];
  name_supl4:=initstring.Values['name_supl4'];
  name_supl5:=initstring.Values['name_supl5'];
  name_toast:=initstring.Values['name_toast'];


  path_ucac4:=initstring.Values['path_ucac4'];
  dss_mask:=initstring.Values['dss_mask'];
  extra_fits_file:=initstring.Values['extra_fits_file'];

  get_str(de430_file,'de430_file');
  get_str(de431_file,'de431_file');


  font_name:=initstring.Values['font'];

  dock:=initstring.Values['font_style']; if length(dock)>=1 then  font_style:=StrToFontStyle(dock);{if length zero then old default.hns file, else minimum ' '}

  language_module:=initstring.Values['language_module'];
  ascom_driver:=initstring.Values['ascom_driver'];

  get_str(INDI_telescope_name,'indi_telescope');
  get_str(INDI_server_address,'indi_server');{'localhost'}
  get_str(INDI_port,'indi_port');{'7624'}
  get_str(telescope_interface,'telescope_interface');

  get_str(server_address,'server_address'); {'localhost'}
  get_str(server_port,'server_port'); {'7700'}
  get_str(alpaca_address,'alpaca_address');{'127.0.0.1'}
  get_str(alpaca_port,'alpaca_port');      {'11111'}
  get_str(alpaca_telescope,'alpaca_telescope');{'11111'}

  get_int(colors[0],'color0');
  get_int(colors[1],'color1');
  get_int(colors[2],'color2');
  get_int(colors[3],'color3');
  get_int(colors[4],'color4');
  get_int(colors[5],'color5');
  get_int(colors[6],'color6');
  get_int(colors[7],'color7');
  get_int(colors[8],'color8');
  get_int(colors[9],'color9');
  get_int(colors[10],'color10');
  get_int(colors[11],'color11');
  get_int(colors[12],'color12');
  get_int(colors[13],'color13');
  get_int(colors[14],'color14');
  get_int(colors[15],'color15');
  get_int(colors[16],'color16');
  get_int(colors[17],'color17');
  get_int(colors[18],'color18');
  get_int(colors[19],'color19');
  get_int(colors[20],'color20');
  get_int(colors[21],'color21');
  get_int(colors[22],'color22');
  get_int(colors[23],'color23');
  get_int(colors[24],'color24');
  get_int(colors[25],'color25');
  get_int(colors[26],'color26');
  get_int(colors[27],'color27');
  get_int(colors[28],'color28');
  get_int(colors[29],'color29');
  get_int(colors[30],'color30');
  get_int(colors[31],'color31');
  get_int(colors[32],'color32');
  get_int(colors[33],'color33');
  get_int(colors[34],'color34');
  get_int(colors[35],'color35');
  get_int(colors[36],'color36');
  get_int(colors[37],'color37');
  get_int(colors[38],'color38');
  get_int(colors[39],'color39');
  get_int(colors[40],'color40');
  get_int(colors[41],'color41');

  get_int(astro_color,'astro_twilight_color');{for darkform}
  get_int(nautical_color,'nautical_twilight_color');
  get_int(civil_color,'civil_twilight_color');

  mainwindow.save_onoff.checked:=get_boolean('savesettingstoolbutton',false);  {default is off}
  mainwindow.time_onoff.checked:=get_boolean('enterdatetimetoolbutton',false);
  mainwindow.gotoradec_onoff.checked:=get_boolean('gotoradectoolbutton',false);
  mainwindow.tools_onoff.checked:=get_boolean('instrumentstoolbutton',false);
  mainwindow.foundmarker_onoff.Checked:=get_boolean('foundobjectmarkertoolbutton',false);
  mainwindow.undo_onoff.checked:=get_boolean('undotoolbutton',false);
  mainwindow.redo_onoff.checked:=get_boolean('redotoolbutton',false);
  mainwindow.settings_onoff.Checked:=get_boolean('settingstoolbutton',false);
  mainwindow.animation_onoff.checked:=get_boolean('animationtoolbutton',false);
  mainwindow.deephlp_onoff.checked:=get_boolean('deephlptoolbutton',false);
  mainwindow.darknights_onoff.checked:=get_boolean('darknightstoolbutton',false);
  mainwindow.solarsystem_onoff.checked:=get_boolean('solarsystemtonighttoolbutton',false);
  mainwindow.slew_onoff.checked:=get_boolean('ascom_aborttoolbutton',false);
  mainwindow.gridRA_onoff.checked:=get_boolean('gridRAtoolbutton',false);
  mainwindow.gridAZ_onoff.checked:=get_boolean('gridAZtoolbutton',false);
  mainwindow.milkyway_onoff.checked:=get_boolean('milkywaytoolbutton',false);
  mainwindow.earth_onoff.checked:=get_boolean('earthtoolbutton',false);

  mainwindow.constellations_onoff.checked:=get_boolean('constellations_onoff',false);
  mainwindow.fits_onoff.checked:=get_boolean('fitstoolbutton',false);
  mainwindow.flipH_onoff.checked:=get_boolean('flipHtoolbutton',false);
  mainwindow.flipV_onoff.checked:=get_boolean('flipVtoolbutton',false);
  mainwindow.Northabove_onoff.checked:=get_boolean('Northabovetoolbutton',false);
  mainwindow.Sidereal_onoff.checked:=get_boolean('Siderealtoolbutton',false);
  dst_auto:=get_boolean('dst_auto',false);{auto daylight saving}
  showPlottime:=get_boolean('showplottime',false);
  mainwindow.tracktelescope1.checked:=get_boolean('track_telescope',false);

  all_device_communication:=get_boolean('all_device_communication',false);{indi}

  mainwindow.OnoffClick(nil);{update toolbuttons}

  get_int(nr_markers,'nr_markers');
  get_int(markers_position,'markers_position');
  for i:=0 to nr_markers-1 do {load markers}
  begin
    get_float(markers.ra[i],inttostr(i)+'_ra');
    get_float(markers.dec[i],inttostr(i)+'_dec');
    get_int(markers.mode[i],inttostr(i)+'_mode');
    get_int(markers.font[i],inttostr(i)+'_font');
    markers.name[i]:=initstring.Values[inttostr(i)+'_name'];
  end;

  case update_time of 1:
                         getdatetime(true,actualtime=false);{calculate current wtime because know latitude and longitude are now know}
                         {This wtime could be used in next old ra dec calculation !!!. Also required when after .init and projection is not 0 !!}
                      2:   {time related event}
                        begin
                          get_int(year2 ,'year');
                          get_int(month2,'month');
                          get_int(day2  ,'day');
                          get_int(hour2 ,'hour');
                          get_int(min2  ,'min');
                          getdatetime(false,false);
                        end;
                      end;{case}

  wtime2:=wtime2actual;
  if zoom>if_below_return_view then {if high zoom restore RA/DEC using current time, else restore azimuth/altitude view}
  begin
    if northtop=1 then latitude:=90 else latitude:=reallatitude;
    ra_az(telescope_ra,telescope_dec,latitude,0,wtime2actual, viewx,viewy);
  end
  else
  begin
    {uses loaded viewx, y}
    get_float(viewx,'view_x');{store position screen}
    get_float(viewy,'view_y');{store position of centre screen}
  end;
  if ((longitude=0) and (reallatitude=50)) then new_user:=true; {new user message}

  mainwindow.font.name:=font_name;{new for font settings in other windows}
  mainwindow.font.charset:=font_charset; {rest (most) will follow}


  {now as last windows dimensions}
  missedupdate:=2; {rewrite window in a repaint}
  mainwindow.statusbar1.visible:=initstring.Values['status_bar']<>'0';

  i:=mainwindow.top;get_int(i,'mainwindow_top'); mainwindow.top:=i;
  i:=mainwindow.left;get_int(i,'mainwindow_left'); mainwindow.left:=i;

  {this will trigger a repaint}
  i:=mainwindow.Clientwidth;get_int(i,'client_width'); mainwindow.Clientwidth:=i;{here required to be able to get tool_bar very left during start up}
  i:=mainwindow.Clientheight;  get_int(i,'client_height'); mainwindow.Clientheight:=i;{first before maximized to prevent some strange problems with toolbar}
  {important for correct positionduring loading:}
  {                                 Set clientwidth, height before setting tool_bars at right position}
  if initstring.Values['maximized']='1' then mainwindow.windowstate:=wsMaximized
                      else mainwindow.windowstate:=wsnormal;

  initstring.free;
end;


procedure save_settings;
var
  initstring :tstrings; {settings for save and loading}
  I            : integer;
const
  BoolStr: array [boolean] of String = ('0', '1');
begin
  initstring := Tstringlist.Create;

  initstring.Values['longitude']:=floattostr(longitude);
  initstring.Values['latitude']:=floattostr(reallatitude);
  initstring.Values['time_zone']:=floattostr(timezone);
  initstring.Values['zoom']:=floattostr(zoom);
  initstring.Values['telescope_ra']:=floattostr(telescope_Ra); {store ra position screen}
  initstring.Values['telescope_dec']:=floattostr(telescope_dec);{store dec position of centre screen}
  initstring.Values['view_x']:=floattostr(viewx);{store position screen}
  initstring.Values['view_y']:=floattostr(viewy);{store position of centre screen}

  initstring.Values['apparent_horizon']:=floattostr(apparent_horizon);
  initstring.Values['frame_width']:=floattostr(frame_width);
  initstring.Values['frame_height']:=floattostr(frame_height);
  initstring.Values['limit_magn']:=floattostr(limitmagn);
  initstring.Values['step_size']:=floattostr(step_size);
  initstring.Values['nr_of_steps']:=floattostr(nr_of_steps);
  initstring.Values['telrad1']:=floattostr(telrad[1]);
  initstring.Values['telrad2']:=floattostr(telrad[2]);
  initstring.Values['telrad3']:=floattostr(telrad[3]);
  initstring.Values['telrad4']:=floattostr(telrad[4]);
  initstring.Values['telrad5']:=floattostr(telrad[5]);
  initstring.Values['density']:=floattostr(density);
  initstring.Values['min_size_deep']:=floattostr(min_size_deep);

  initstring.Values['nautical_end']:=floattostr(nautical_end);

   {integers}
  initstring.Values['projection']:=intTostr(projection);
  initstring.Values['bold']:=intTostr(bold);{star boldness}
  initstring.Values['deep']:=intTostr(deep) {how many deep sky objects will be displayed};
  initstring.Values['naming']:=intTostr(naming);{how many names of deepsky displayed}

  initstring.Values['deep_level']:=intTostr(deepsky_level);


  initstring.Values['daylight_saving']:=intTostr(daylight_saving);

  initstring.Values['year']:=intTostr(year2);
  initstring.Values['month']:=intTostr(month2);
  initstring.Values['day']:=intTostr(day2);
  initstring.Values['hour']:=intTostr(hour2);
  initstring.Values['min']:=intTostr(min2);

  initstring.Values['north']:=intTostr(north);
  initstring.Values['equinox']:=intTostr(equinox);
  initstring.Values['equinox_telescope']:=intTostr(equinox_telescope);
  initstring.Values['azimuth_degrees']:=intTostr(azimuth_degrees);
  initstring.Values['parallax']:=intTostr(parallax2);
  initstring.Values['flipv']:=intTostr(flipv);
  initstring.Values['fliph']:=intTostr(fliph);
  initstring.Values['cross']:=intTostr(cross);
  initstring.Values['star_colouring']:=intTostr(star_colouring);
  initstring.Values['namest']:=intTostr(namest);
  initstring.Values['constellations']:=intTostr(constellat);
  initstring.Values['boundaries']:=intTostr(boundaries);
  initstring.Values['milkyway']:=intTostr(milkyway);
  initstring.Values['earth']:=intTostr(earth);

  initstring.Values['star_database']:=intTostr(stardatabase_selected);{DAT, .290, GSC or USNO}

  initstring.Values['contour_only']:=intTostr(contour_only);
  initstring.Values['show_orbit']:=intTostr(show_orbit);
  initstring.Values['north_top']:=intTostr(northtop);
  initstring.Values['mag_scale']:=intTostr(magscale);

  initstring.Values['grid']:=intTostr(grid);
  initstring.Values['north_arrow']:=intTostr(northarrow);
  initstring.Values['hide_mainmenu']:=intTostr(hide_mainmenu);
  initstring.Values['hide_mainmenu_text']:=intTostr(hide_mainmenu_text);
  initstring.Values['clock']:=intTostr(clock);
  initstring.Values['sidereal']:=intTostr(sidereal);
  initstring.Values['find_solar_eclipse']:=intTostr(find_solareclipse);

  initstring.Values['auto_zoom']:=BoolStr[auto_zoom];
  initstring.Values['slew_to']:=BoolStr[slewto];

  initstring.Values['deep_database']:=intTostr(deep_database);
  initstring.Values['suppl1_activated']:=intTostr(suppl1_activated);
  initstring.Values['suppl2_activated']:=intTostr(suppl2_activated);
  initstring.Values['suppl3_activated']:=intTostr(suppl3_activated);
  initstring.Values['suppl4_activated']:=intTostr(suppl4_activated);
  initstring.Values['suppl5_activated']:=intTostr(suppl5_activated);
  initstring.Values['toast_activated']:=intTostr(toast_activated);
  initstring.Values['hints']:=intTostr(hints);
  initstring.Values['frame']:=intTostr(mframe);

  initstring.Values['time_step']:=intTostr(timestep);
  initstring.Values['stars_activated']:=intTostr(stars_activated);
  initstring.Values['planets_activated']:=intTostr(planets_activated);

  initstring.Values['comets_activated']:=intTostr(comets_activated);
  initstring.Values['asteroids_activated']:=intTostr(asteroids_activated);
  initstring.Values['plot_moon_movement']:=intTostr(plot_moon_movement);
  initstring.Values['step_unit']:=intTostr(step_unit);

  initstring.Values['marker_two_lines']:=Boolstr[mainwindow.Twolinesnorthsouth1.checked];
  initstring.Values['marker_telrad']:=intTostr(marker_telrad);
  initstring.Values['marker_name']:=intTostr(marker_name);

  initstring.Values['enable_telescope']:=Boolstr[mainwindow.connect_telescope1.checked];

  initstring.Values['Objectinfotoclipboard']:=Boolstr[mainwindow.Objectinfotoclipboard1.checked];
  initstring.Values['time_reference']:=time_reference;{UTC, TDT}

  initstring.Values['filter_type']:=filtertype;
  initstring.Values['fontsize1']:=intTostr(fontsize1);
  initstring.Values['fontsize2']:=intTostr(fontsize2);
  initstring.Values['fontsize3']:=intTostr(fontsize3);
  initstring.Values['fits_insert']:=intTostr(fits_insert);
  initstring.Values['dss_background']:=intTostr(dss_background);{dss background and brightness}
  initstring.Values['dss_brightness']:=intTostr(dss_brightness);

  initstring.Values['limit_deep_bright_color']:=intTostr(limit_deep_bright_color);
  initstring.Values['limit_deep_medium_color']:=intTostr(limit_deep_medium_color);

  initstring.Values['objectmenu_top']:=intTostr(objectmenu.top);
  initstring.Values['objectmenu_left']:=intTostr(objectmenu.left);
  initstring.Values['stars_external_index']:=intTostr(stars_external_index);

  initstring.Values['searchmenu_top']:=intTostr(center_on.top);
  initstring.Values['searchmenu_left']:=intTostr(center_on.left);
  initstring.Values['gotomenu_top']:=intTostr(move_to.top);
  initstring.Values['gotomenu_left']:=intTostr(move_to.left);

  initstring.Values['animation_top']:=intTostr(form_animation.top);
  initstring.Values['animation_left']:=intTostr(form_animation.left);

  initstring.Values['datemenu_top']:=intTostr(settime.top);
  initstring.Values['datemenu_left']:=intTostr(settime.left);

  initstring.Values['grid_step']:=intTostr(gridstep);
  initstring.Values['font_charset']:=intTostr(font_charset);
  initstring.Values['font']:=font_name;
  initstring.Values['font_style']:=FontStyleToStr(font_style)+' ';

  initstring.Values['page_settings']:=intTostr(page_settings); {set page of settings pagecontrol}
  initstring.Values['fontsize_edit']:=intTostr(fontsize_e);
  initstring.Values['fontname_edit']:=fontname_e;
  initstring.Values['mouse_wheel_reverse']:=intTostr(mouse_wheel_reverse);{inverse mouse wheel?}
  initstring.Values['moon_covers_stars']:=intTostr(moon_covers_stars);
  initstring.Values['earth_covers_stars']:=intTostr(earth_covers_stars);

  initstring.Values['zoom_show_dss']:=intTostr(Zoom_show_DSS);
  initstring.Values['dss_bandpass']:=intTostr(dss_bandpass);

  initstring.Values['de_emphemeris']:=intTostr(de430_emphemeris);
  initstring.Values['grs_offset']:=intTostr(grs_offset);{jupiter grs }


  initstring.Values['actual_time']:=BoolStr[actualtime];
  initstring.Values['server']:=BoolStr[server_on];

  initstring.Values['name_star']:=name_star;
  initstring.Values['name_deep']:=name_deep;
  initstring.Values['name_supl1']:=name_supl1;
  initstring.Values['name_supl2']:=name_supl2;

  initstring.Values['name_supl3']:=name_supl3;
  initstring.Values['name_supl4']:=name_supl4;
  initstring.Values['name_supl5']:=name_supl5;
  initstring.Values['name_toast']:=name_toast;

  initstring.Values['path_ucac4']:=path_ucac4;
  initstring.Values['dss_mask']:=dss_mask;
  initstring.Values['extra_fits_file']:=extra_fits_file;

  initstring.Values['de430_file']:=de430_file;
  initstring.Values['de431_file']:=de431_file;

  initstring.Values['language_module']:=language_module;
  initstring.Values['ascom_driver']:=ascom_driver;

  initstring.Values['internetskyview_wide']:=internet_skyview_wide;
  initstring.Values['internetskyview']:=internet_skyview;
  initstring.Values['internet_eso']:=internet_eso;
  initstring.Values['internet_mast']:=internet_mast;

  initstring.Values['internet_simbad2']:=internet_simbad;
  initstring.Values['internet_leda2']:=internet_leda;
  initstring.Values['internet_ned']:=internet_ned;
  initstring.Values['internet_vizier']:=vizier_server;

  initstring.Values['internet_asteroid2']:=internet_asteroid;
  initstring.Values['internet_comet']:=internet_comet;

  initstring.Values['asteroids_maxnr']:=asteroids_maxnr;
  initstring.Values['asteroids_maxmagn']:=asteroids_maxmagn;


  initstring.Values['indi_telescope']:=INDI_telescope_name;
  initstring.Values['indi_server']:=INDI_server_address;{localhost'}
  initstring.Values['indi_port']:=INDI_port{'7624'};
  initstring.Values['telescope_interface']:=telescope_interface;{A= ascom, I is INDI, C=Alpaca}

  initstring.Values['server_address']:=server_address;{localhost'}
  initstring.Values['server_port']:=server_port{'7624'};
  initstring.Values['alpaca_address']:=alpaca_address;{'127.0.0.1'}
  initstring.Values['alpaca_port']:=alpaca_port{'11111'};
  initstring.Values['alpaca_telescope']:=alpaca_telescope{'0'};

  initstring.Values['color0']:=intTostr(colors[0]);
  initstring.Values['color1']:=intTostr(colors[1]);
  initstring.Values['color2']:=intTostr(colors[2]);
  initstring.Values['color3']:=intTostr(colors[3]);
  initstring.Values['color4']:=intTostr(colors[4]);
  initstring.Values['color5']:=intTostr(colors[5]);
  initstring.Values['color6']:=intTostr(colors[6]);
  initstring.Values['color7']:=intTostr(colors[7]);
  initstring.Values['color8']:=intTostr(colors[8]);
  initstring.Values['color9']:=intTostr(colors[9]);
  initstring.Values['color10']:=intTostr(colors[10]);
  initstring.Values['color11']:=intTostr(colors[11]);
  initstring.Values['color12']:=intTostr(colors[12]);
  initstring.Values['color13']:=intTostr(colors[13]);
  initstring.Values['color14']:=intTostr(colors[14]);
  initstring.Values['color15']:=intTostr(colors[15]);
  initstring.Values['color16']:=intTostr(colors[16]);
  initstring.Values['color17']:=intTostr(colors[17]);
  initstring.Values['color18']:=intTostr(colors[18]);
  initstring.Values['color19']:=intTostr(colors[19]);
  initstring.Values['color20']:=intTostr(colors[20]);
  initstring.Values['color21']:=intTostr(colors[21]);
  initstring.Values['color22']:=intTostr(colors[22]);
  initstring.Values['color23']:=intTostr(colors[23]);
  initstring.Values['color24']:=intTostr(colors[24]);
  initstring.Values['color25']:=intTostr(colors[25]);
  initstring.Values['color26']:=intTostr(colors[26]);
  initstring.Values['color27']:=intTostr(colors[27]);
  initstring.Values['color28']:=intTostr(colors[28]);
  initstring.Values['color29']:=intTostr(colors[29]);
  initstring.Values['color30']:=intTostr(colors[30]);
  initstring.Values['color31']:=intTostr(colors[31]);
  initstring.Values['color32']:=intTostr(colors[32]);
  initstring.Values['color33']:=intTostr(colors[33]);
  initstring.Values['color34']:=intTostr(colors[34]);
  initstring.Values['color35']:=intTostr(colors[35]);
  initstring.Values['color36']:=intTostr(colors[36]);
  initstring.Values['color37']:=intTostr(colors[37]);
  initstring.Values['color38']:=intTostr(colors[38]);
  initstring.Values['color39']:=intTostr(colors[39]);
  initstring.Values['color40']:=intTostr(colors[40]);
  initstring.Values['color41']:=intTostr(colors[41]);

  initstring.Values['astro_twilight_color']:=intTostr(astro_color);{for darkform}
  initstring.Values['nautical_twilight_color']:=intTostr(nautical_color);
  initstring.Values['civil_twilight_color']:=intTostr(civil_color);

  initstring.Values['savesettingstoolbutton']:=Boolstr[mainwindow.save_onoff.checked];
  initstring.Values['enterdatetimetoolbutton']:=Boolstr[mainwindow.time_onoff.checked];
  initstring.Values['gotoradectoolbutton']:=Boolstr[mainwindow.gotoradec_onoff.checked];
  initstring.Values['instrumentstoolbutton']:=Boolstr[mainwindow.tools_onoff.checked];
  initstring.Values['foundobjectmarkertoolbutton']:=Boolstr[mainwindow.foundmarker_onoff.checked];
  initstring.Values['undotoolbutton']:=Boolstr[mainwindow.undo_onoff.checked];
  initstring.Values['redotoolbutton']:=Boolstr[mainwindow.redo_onoff.checked];
  initstring.Values['settingstoolbutton']:=Boolstr[mainwindow.settings_onoff.checked];
  initstring.Values['deephlptoolbutton']:=Boolstr[mainwindow.deephlp_onoff.checked];
  initstring.Values['darknightstoolbutton']:=Boolstr[mainwindow.darknights_onoff.checked];
  initstring.Values['animationtoolbutton']:=Boolstr[mainwindow.animation_onoff.checked];
  initstring.Values['solarsystemtonighttoolbutton']:=Boolstr[mainwindow.solarsystem_onoff.checked];
  initstring.Values['ascom_aborttoolbutton']:=Boolstr[mainwindow.slew_onoff.checked];
  initstring.Values['gridRAtoolbutton']:=Boolstr[mainwindow.gridRA_onoff.checked];
  initstring.Values['gridAZtoolbutton']:=Boolstr[mainwindow.gridAZ_onoff.checked];
  initstring.Values['milkywaytoolbutton']:=Boolstr[mainwindow.milkyway_onoff.checked];
  initstring.Values['earthtoolbutton']:=Boolstr[mainwindow.earth_onoff.checked];
  initstring.Values['constellations_onoff']:=Boolstr[mainwindow.constellations_onoff.checked];
  initstring.Values['fitstoolbutton']:=Boolstr[mainwindow.fits_onoff.checked];
  initstring.Values['FlipHtoolbutton']:=Boolstr[mainwindow.FlipH_onoff.checked];
  initstring.Values['FlipVtoolbutton']:=Boolstr[mainwindow.FlipV_onoff.checked];
  initstring.Values['Northabovetoolbutton']:=Boolstr[mainwindow.Northabove_onoff.checked];
  initstring.Values['Siderealtoolbutton']:=Boolstr[mainwindow.Sidereal_onoff.checked];
  initstring.Values['dst_auto']:=Boolstr[dst_auto];{day light saving}
  initstring.Values['showplottime']:=Boolstr[showplottime];
  initstring.Values['track_telescope']:=Boolstr[mainwindow.tracktelescope1.checked];

  initstring.Values['all_device_communication']:=Boolstr[all_device_communication];{indi}

  if ((marker_name<>0) or (marker_telrad<>0)) then
  begin
    initstring.Values['nr_markers']:=intTostr(nr_markers);
    initstring.Values['markers_position']:=intTostr(markers_position);
    for i:=0 to nr_markers-1 do {save markers}
    begin
      initstring.Values[inttostr(i)+'_ra']:=floattostr(markers.ra[i]);
      initstring.Values[inttostr(i)+'_dec']:=floattostr(markers.dec[i]);
      initstring.Values[inttostr(i)+'_mode']:=inttostr(markers.mode[i]);
      initstring.Values[inttostr(i)+'_font']:=inttostr(markers.font[i]);
      initstring.Values[inttostr(i)+'_name']:=markers.name[i];
    end;
  end;

  initstring.Values['status_bar']:=Boolstr[mainwindow.statusbar1.visible];
  initstring.Values['mainwindow_top']:=intTostr(mainwindow.top);
  initstring.Values['mainwindow_left']:=intTostr(mainwindow.left);
  if mainwindow.windowstate=wsMaximized then initstring.Values['maximized']:='1'
                                        else initstring.Values['maximized']:='0';
  initstring.Values['client_width']:=intTostr(mainwindow.Clientwidth);
  initstring.Values['client_height']:=intTostr(mainwindow.Clientheight);

  with initstring do
  begin
    try
    savetoFile(FileName);	{ save to file. Filename contains path }
    except
      application.messagebox(pchar('Error writing: '+FileName),pchar(Error_string),MB_ICONWARNING+MB_OK);
      exit;
    end;
  end;

  initstring.free;
end;

procedure load_cursors;
begin
 {$ifdef mswindows}
  screen.cursors[crnormalcursor]:=loadcursor(hinstance,'cursor_1'); {load cursor from res file}
  screen.cursors[crnormalcursor2]:=loadcursor(hinstance,'cursor_3'); {load cursor from res file}
  screen.cursors[crwaitCursor] := loadcursor(hInstance,'cursor_2');

  screen.cursors[crCursorright]:=loadcursor(hInstance,'cursor_right');
  screen.cursors[crCursorleft]:=loadcursor(hInstance,'cursor_left');
  screen.cursors[crCursordown]:=loadcursor(hInstance,'cursor_down');
  screen.cursors[crCursorup]:=loadcursor(hInstance,'cursor_up');{program does not like cursor_up ??!!}
  screen.cursors[crCursor_draw]:=loadcursor(hInstance,'cursor_draw');
  screen.cursors[crCursor_tel]:=loadcursor(hInstance,'cursor_tel');{special cursor for telescope pointing}
  screen.cursors[crCursor_hand]:=LoadCursor(hInstance,'cursor_hand');

 {$else} {unix}
 {use special cursors}
  screen.cursors[crnormalcursor]:=loadcursor(hinstance,'cursor_1b'); {load cursor from res file}
  screen.cursors[crnormalcursor2]:=loadcursor(hinstance,'cursor_3b'); {load cursor from res file}
  screen.cursors[crwaitCursor] := loadcursor(hInstance,'cursor_2b');

  screen.cursors[crCursorright]:=loadcursor(hInstance,'cursor_rightb');
  screen.cursors[crCursorleft]:=loadcursor(hInstance,'cursor_leftb');
  screen.cursors[crCursordown]:=loadcursor(hInstance,'cursor_downb');
  screen.cursors[crCursorup]:=loadcursor(hInstance,'cursor_upb');{program does not like cursor_up ??!!}
  screen.cursors[crCursor_draw]:=loadcursor(hInstance,'cursor_drawb');
  screen.cursors[crCursor_tel]:=loadcursor(hInstance,'cursor_telb');{special cursor for telescope pointing}
  screen.cursors[crCursor_hand]:=LoadCursor(hInstance,'cursor_handb');
 {$endif}
end;

Procedure GetDocumentsPath;
{$IFDEF fpc}
  {$ifdef mswindows}
  var
     PIDL : PItemIDList;
     Folder : array[0..MAX_PATH] of Char;
     const CSIDL_PERSONAL = $0005;
  begin
     SHGetSpecialFolderLocation(0, CSIDL_PERSONAL, PIDL);
      SHGetPathFromIDList(PIDL, Folder);
      documents_path:=Folder+'\hnsky\';{FPC mswindows solution}
  end;
  {$ELSE}{linux}
  begin
    documents_path:=expandfilename('~/.hnsky/');{home plus hnsky, will be created if it doesn't exist}
  end;
  {$ENDIF}
{$ELSE}{delphi}
begin
   documents_path:=TPath.GetDocumentsPath+'\hnsky\';{delphi solution}
end;
{$ENDIF}

procedure Tmainwindow.FormCreate(Sender: TObject);
begin
  fastbitmap1:=Tfastbitmap.Create;{memory raw image, for delphi create before loadsettings}

  DoubleBuffered := true;  {very important for flickering, http://delphi.about.com/library/bluc/text/uc052102g.htm}

  local_decimalseparator:=formatSettings.decimalseparator;{remember country settings}
  FormatSettings.decimalseparator:='.'; {for floattostr and strtofloat !! in Dutch and German systems}
  {FormatSettings. for delphi XE6}
  setdefaultcolors;

   if ((ParamCount>0) and (pos('.hns',paramstr(1))<>0)) then filename:=paramstr(1); {other name then default.hns}
                         {extra check for .hns while DDE is sending output as paramstr(1)}

  application_Path:= {ExtractShortPathName}(ExtractFilePath(Application.ExeName));  {get application path, short 8.3 version without spaces for calling firefox}

  GetDocumentsPath;

  {$ifdef mswindows}
   if DirectoryExists(documents_path)=false then
                                      documents_path:=extractfilepath(application.location); {use alternatively program directory}
  {$ELSE}{linux}
  if DirectoryExists(documents_path)=false then
                                     createdir(documents_path);{create ~/.hnsky/}
  {$ENDIF}

  cache_path:=documents_path+'cache'+PathDelim;
  if DirectoryExists(cache_path)=false then CreateDir(cache_path);{if no cache path, make one}

  filename:=documents_path+default_hns;

  load_settings(1 {start with 24 hr}); {load file and true= calculate current wtime }
                                  {getdatetime is then not required. This solves problem}
                                  {getting longitude latitude, calculate wtime and then calculate old ra old dec from file data}

  if DirectoryExists(dss_path)=false then {no path specified in settings, make the default}
  begin
    dss_path:=documents_path+'fits'+PathDelim;
    CreateDir(dss_path);{if no cache path, make one}
  end;
  mainwindow.color:=colors[0];
  mainwindow.statusbar1.font.color:=colors[25];


  mainwindow.toolbar2.Font.size:=fontsize2;
  mainwindow.statusbar1.font.size:=fontsize2;
  mainwindow.Font.size:=fontsize2;

  prepare_penbrush;

  try
    labelstring := TmemIniFile.Create(application_path+language_module  {hns_uk.ini or other}); {meminifile much faster then tinifile}
    language_mode:=1; {module available}
  except
    language_mode:=0;
  end;

  if language_mode<>0 then load_main; {language module, here before errors are reported in following load databases}
  if language_mode<>0 then {second check about while if load_main is not there skip this one to}
  begin
    load_popup;
    load_popup_mainmenu;
    load_general;
    update_button_hints;{copy mainmenu hints and objectmenu hints to buttons}
  end;
  if
  {$ifdef mswindows}
  (pos(':',help_path)=0)
  {$ELSE}{linux}
  ((pos('./',help_path)<>0) or ((pos('~/',help_path)<>0)))
  {$ENDIF}
  then {not a full path specified}
    help_path:=application_path+ExtractFilePath(help_path)+ExtractFilename(help_path);

  deepstring := Tstringlist.Create;
  loaddeep; {load deep in stringlisting}

  cometstring := Tstringlist.Create;
  loadcomet; {load comet in stringlisting}
  asteroidstring := Tstringlist.Create;
  loadasteroid; {load asteroid in stringlisting}
  supplstring1 := Tstringlist.Create;
  supplstring2 := Tstringlist.Create;
  supplstring3 := Tstringlist.Create;
  supplstring4 := Tstringlist.Create;
  supplstring5 := Tstringlist.Create;


  foundstring1 := Tstringlist.Create;{for search area}

  loadsupplement1; {load supplement in stringlisting}
  loadsupplement2; {load supplement in stringlisting}
  loadsupplement3; {load supplement in stringlisting}
  loadsupplement4; {load supplement in stringlisting}
  loadsupplement5; {load supplement in stringlisting}

  catalogstring := Tstringlist.Create;

  load_cursors; {load_cursors}

  image1.Cursor:=crnormalcursor;

  auto_center:=true; {search option of find menu}

  Application.OnHint := DisplayHint;
  application.HintHidePause:=5000;{display hint 5000 ms instead standard 2500}
  {application.HintPause:=1000;}
  application.HintShortPause:=1000;
  if mainwindow.connect_telescope1.checked=true then {connect directly to ascom if saved in settings, 2015}
  begin
   {$IFDEF fpc}
    if telescope_interface='I' then connect_during_creation:=3 {connect telescope in indi unit during creation}
    else
  {$ENDIF}
    if telescope_interface='A' then connect_telescope(nil);
    {alpaca will be connected by Timer_delayed_start_server}
  end;

  {$IFDEF fpc}
   png:= TPortableNetworkGraphic.Create;   {FPC}

   Timer_delayed_start_server.Enabled := True; // start TCP server host delayed otherwise INDI client get's connected}

  {$ELSE}
   png := TPNGObject.Create;{Delphi}
  {$ENDIF}
   loadtoast; {load toast projection of the sky}
end;

procedure Tmainwindow.FormDestroy(Sender: TObject);
begin
  labelstring.free; {for non-english module}

  delete_penbrush;

  deepstring.free;{free deepsky}
  cometstring.free;{free comets}
  asteroidstring.free;{free comets}
  supplstring1.free;{free suppl1}
  supplstring2.free;{free suppl2}
  supplstring3.free;
  supplstring4.free;
  supplstring5.free;
  foundstring1.free;{free }
  catalogstring.free;{free USNOB1 from vizier}
 // Bitmap2.Free;{removed. after this a resize comes and a second bitmap2.free gives an error!
  png.free;
  if de430_loaded then close_de_file;{close de431 filestream}

end;

function Tmainwindow.FormHelp(Command: Word; Data: NativeInt;
  var CallHelp: Boolean): Boolean;
begin
//  HelpFile := ExtractFilePath(Application.ExeName) + HelpFile;
//  Application.HelpShowTableOfContents();

    {this routine is called if in the menu F1=help is pressed (without defining it}
  CallHelp :=  false; // True; - to execute the default OnHelp event handler

  open_file(help_path);{call browser with own html help}

end;


procedure telescope_cursor(orientation: double);
var
  oldascomcursorcounter : integer;
  yr,xr,x2,y2           : double;
begin

  yr:=round(frame_height*zoom*(half_height)/field_factor);
  xr:=round(frame_width*zoom*(half_height)/field_factor);

  mainwindow.image1.Canvas.Pen.color:=clblue;
  mainwindow.image1.Canvas.Pen.Mode := pmNotXor;	{ use XOR mode to draw/erase }

  if  ascomcursorcounter<>10 then begin ascomcursorcounter:=10;oldascomcursorcounter:=9; end else begin  ascomcursorcounter:=9;oldascomcursorcounter:=10;end; {blinker to show ASCOM puls}

  if mainwindow.image1.canvas.pixels[oldMovePt.x+8,oldMovePt.y+8]=colorwritten2  then {cross is still written, most reliable method}
  begin
     mainwindow.image1.Canvas.MoveTo(oldMovePt.x-oldascomcursorcounter, oldMovePt.y-oldascomcursorcounter);	{ move pen back to origin }
     mainwindow.image1.canvas.LineTo(oldMovePt.x -3, oldMovePt.y -3);	{ erase the old line }
     mainwindow.image1.canvas.MoveTo(oldMovePt.x+oldascomcursorcounter, oldMovePt.y+oldascomcursorcounter);	{ move pen back to origin }
     mainwindow.image1.canvas.LineTo(oldMovePt.x +3, oldMovePt.y +3);	{ erase the old line }

     mainwindow.image1.canvas.MoveTo(oldMovePt.x+oldascomcursorcounter, oldMovePt.y-oldascomcursorcounter);	{ move pen back to origin }
     mainwindow.image1.canvas.LineTo(oldMovePt.x+ 3, oldMovePt.y -3);	{ erase the old line }

     mainwindow.image1.canvas.MoveTo(oldMovePt.x-oldascomcursorcounter, oldMovePt.y+ oldascomcursorcounter);	{ move pen back to origin }
     mainwindow.image1.canvas.LineTo(oldMovePt.x- 3, oldMovePt.y+ 3);	{ erase the old line }


     {telescope rectangle}
     rotate( oldorientation,xr,yr,x2,y2);
     mainwindow.image1.Canvas.MoveTo(oldMovePt.x+round(x2) ,oldMovePt.y+round(y2) );  { move pen back to origin }
     rotate( oldorientation,xr,-yr,x2,y2);
     mainwindow.image1.Canvas.lineTo(oldMovePt.x+round(x2) ,oldMovePt.y+round(y2) );  { draw }
     rotate( oldorientation,-xr,-yr,x2,y2);
     mainwindow.image1.Canvas.lineTo(oldMovePt.x+round(x2) ,oldMovePt.y+round(y2) );  { draw }
     mainwindow.image1.Canvas.moveTo(oldMovePt.x+round(x2) ,oldMovePt.y+round(y2) );  { draw }
     rotate( oldorientation,-xr,+yr,x2,y2);
     mainwindow.image1.Canvas.lineTo(oldMovePt.x+round(x2) ,oldMovePt.y+round(y2) );  { draw }
     rotate( oldorientation,+xr,+yr,x2,y2);
     mainwindow.image1.Canvas.lineTo(oldMovePt.x+round(x2) ,oldMovePt.y+round(y2) );  { draw }
     {end telescope rectangle}
   end;
   mainwindow.image1.canvas.MoveTo(movept.x-ascomcursorcounter, movept.y-ascomcursorcounter);	{ move pen back to origin }
   mainwindow.image1.canvas.LineTo(movept.x -3, movept.y -3);	{ draw the new line }
   mainwindow.image1.canvas.MoveTo(movept.x+ascomcursorcounter, movept.y+ascomcursorcounter);
   mainwindow.image1.canvas.LineTo(movept.x +3, movept.y +3);

   mainwindow.image1.canvas.MoveTo(movept.x+ascomcursorcounter, movept.y-ascomcursorcounter);
   mainwindow.image1.canvas.LineTo(movept.x+ 3, movept.y -3);

   mainwindow.image1.canvas.MoveTo(movept.x-ascomcursorcounter, movept.y+ascomcursorcounter);
   mainwindow.image1.canvas.LineTo(movept.x- 3, movept.y+ 3);

   {telescope rectangle}
   rotate(orientation,xr,yr,x2,y2);
   mainwindow.image1.Canvas.MoveTo(MovePt.x+round(x2) ,MovePt.y+round(y2) );  { move pen back to origin }
   rotate(orientation,xr,-yr,x2,y2);
   mainwindow.image1.Canvas.lineTo(MovePt.x+round(x2) ,MovePt.y+round(y2) );  { draw }
   rotate(orientation,-xr,-yr,x2,y2);
   mainwindow.image1.Canvas.lineTo(MovePt.x+round(x2) ,MovePt.y+round(y2) );  { draw }
   mainwindow.image1.Canvas.moveTo(MovePt.x+round(x2) ,MovePt.y+round(y2) );  { draw }
   rotate(orientation,-xr,+yr,x2,y2);
   mainwindow.image1.Canvas.lineTo(MovePt.x+round(x2) ,MovePt.y+round(y2) );  { draw }
   rotate(orientation,+xr,+yr,x2,y2);
   mainwindow.image1.Canvas.lineTo(MovePt.x+round(x2) ,MovePt.y+round(y2) );  { draw }
   {end telescope rectangle}

   oldMovePt := Point(movept.x, movept.y);	{ record point for next move }
   oldorientation:=orientation;
   colorwritten2:=mainwindow.image1.canvas.pixels[oldMovePt.x+8,oldMovePt.y+8];{remember pixel value to see if erase is required  }

   mainwindow.image1.canvas.Pen.Mode := pmCopy;
end;

procedure process_telescope_position(ra_telesc,dec_telesc,equinox_tel:double);
var
  dec_map,ra_map, RA_display,DEC_display,orientation_t,xxxx,frame_diameter  : double;
  ra5_text,dec5_text                                        : string;{telescope values}
  telescope_boundary : integer;
begin
  if equinox_tel<=1 then ep(equinox_date,  2000,RA_telesc,DEC_telesc,ra_map,dec_map) {convert telescope astrometric to 2000 for map}
  else
  if equinox_tel=2000 then begin ra_map:=RA_telesc; dec_map:=DEC_telesc; end
  else
  ep(equinox_tel,  2000,RA_telesc,DEC_telesc,ra_map,dec_map);{1950,2050}


  if equinox=2000 then begin ra_display:=RA_map;  Dec_display:=dec_map; end{no conversion required}
  else
  if equinox<=1 then begin ra_display:=RA_telesc;  Dec_display:=dec_telesc; end{no conversion required}
  else
  if equinox=1950 then{conversion required}
  begin
    ep(equinox_date,  1950,RA_telesc,DEC_telesc,ra_display,dec_display); {convert telescope astrometric to 2000 for map}
  end;
  ra5_text:=prepare_ra(ra_display);{for display telescope position at mainwindow.caption}
  dec5_text:=prepare_dec(dec_display);

  if equinox>1 then {1950, 2000, 2050}
     telescope_position:='       '+Telescopetekst+'_'+inttostr(equinox)+': '+ra5_text+', '+dec5_text
     else
     telescope_position:='       '+Telescopetekst+'_'+mean_string     + ' '+ra5_text+', '+dec5_text;

  plot_pixel_sphere(mainwindow.image1.canvas,ra_map,dec_map,-99,$0,0,0);{find x and y coordinate based on image1.canvas. Note based on mainwindow.canvas is possible but cause a repaint.}


  movept.x:=x9;{Store ascom pointer position for telescope_cursor}
  movept.y:=y9;

  plot_pixel_sphere(mainwindow.image1.canvas,ra_map,dec_map+0.5/zoom,-99,$0,0,0); { find orientation by moving to }
  xxxx:=movept.x-x9; if abs(xxxx)<0.000001 then xxxx:=0.000001; {prevent divide zero}
  orientation_t:=+arctan((movept.y-y9)/xxxx)+(90-frame_angle)*pi/180;{frame_angle is extra rotation from ctrl + mouse wheel}

  if ((zc>=0) and (size_pulled_rectangle=0)) then telescope_cursor(orientation_t);{plot telescope cursor & rectangle}

  if mainwindow.tracktelescope1.checked=true then {follow telescope and update screen}
  begin
    telescope_boundary:=round((rrw.bottom-rrw.top)*0.2);{keep telescope within this from canvas corners}
    if ((movept.x+mainwindow.image1.left<rrw.left+telescope_boundary) or (movept.x+mainwindow.image1.left>rrw.right-telescope_boundary) or
        (movept.y+mainwindow.image1.top<rrw.top+telescope_boundary) or (movept.y+mainwindow.image1.top>(rrw.bottom)-telescope_boundary)) then {use image1.top and image1.left since image1 can be moved without repaint}
    begin
      ra_az(ra_map,dec_map,latitude,0,wtime2,{var} viewx,viewy); {move sphere to center object}
      found:=0; {prevent a second and other writeinfo if quick a repaint is give by e.g. dde interface}
      missedupdate:=2; {rewrite window}
      paint_sky;{rewrite window}
    end;
  end;
end;

procedure tmainwindow.update_menu;
begin
  {this is done here to set menu checked after starting up and loading default.hns file}
  {update pulldown window:}
  measuringframe1.checked:=mframe<>0;
  {$IFDEF fpc}
    indi_client1.visible:=telescope_interface='I';{show in popup only if indi is selected}
  {$ENDIF}

  objecthints1.checked:=hints=1;
  Showclock1.checked:=clock<>0;
  GridRADEC1.checked:=grid=1;
  gridRAtoolButton.down:=grid=1;
  GridAZAlt1.checked:=grid=2;
  gridAZtoolButton.down:=grid=2;
  milkywaytoolbutton.Down:=milkyway<>0;
  earthtoolbutton.Down:=earth<>0;
  Constellations1.checked:=constellat>0;
  constellationstoolbutton.down:=constellat>0;

  Boundaries1.checked:=boundaries>0;
  milkyway1.checked:=milkyway<>0;
  earth1.checked:=earth<>0;
  Crosshair1.checked:=cross=1;
  pointingcircles1.checked:=cross=2;
  Fliphorizontal1.checked:=fliph< 0;
  Flipvertical1.checked:=flipv< 0;
  FLIPHtoolButton.down:=flipH<0;
  FLIPVtoolButton.down:=flipV<0;

  Northabove1.checked:=northtop>0;
  northabovetoolbutton.down:=northtop>0;

  sidereal1.checked:=sidereal>0;
  siderealtoolbutton.Down:=sidereal>0;
  settime.siderealtoolbutton2.Down:=sidereal>0;{settime menu}

  settime.followtime_toolButton1.down:=actualtime; {update tool button}

  form_animation.followstars.Checked:=sidereal>0;
  form_animation.follow_none.Checked:=sidereal=0;

  starscale1.checked:=magscale<>0;
  northarrow1.checked:=northarrow<>0;
  northarrow1.enabled:=projection<>2; {no north arrow in cylindrical projection}


  if menu_changed then {update menu}
  begin
    hide_menu.Checked:=hide_mainmenu<>1;{0 is hide, 1 is visible all the time. Used as multiplier in height calculation}
    hide_text.Checked:=hide_mainmenu_text=1;{1 is hide, 0 is visible all the time.}
    hide_icons.Checked:=hide_mainmenu_text=2;{2 is hide, 0 is visible all the time.}
    case hide_mainmenu_text of
      1:begin {no text only icons}
        toolbar2.Visible:=false; {stop updating temporary}
        {$IFDEF fpc}
        filetoolbutton.showcaption:=false; {FPC & Lazarus solution}
        searchtoolbutton.showcaption:=false;
        intoolbutton.showcaption:=false;
        outtoolbutton.showcaption:=false;
        resettoolbutton.showcaption:=false;
        Screentoolbutton.showcaption:=false;
        objectstoolbutton.showcaption:=false;
        datetoolbutton.showcaption:=false;
        helptoolbutton.showcaption:=false;
        {$ELSE} {delphi}
        filetoolbutton.style:=tbsbutton;
        searchtoolbutton.style:=tbsbutton;
        intoolbutton.style:=tbsbutton;
        outtoolbutton.style:=tbsbutton;
        resettoolbutton.style:=tbsbutton;
        Screentoolbutton.style:=tbsbutton;
        objectstoolbutton.style:=tbsbutton;
        datetoolbutton.style:=tbsbutton;
        helptoolbutton.style:=tbsbutton;
        {$ENDIF}
        filetoolbutton.imageindex:=0;
        searchtoolbutton.imageindex:=17;
        intoolbutton.imageindex:=15;
        outtoolbutton.imageindex:=16;
        resettoolbutton.imageindex:=37;
        Screentoolbutton.imageindex:=38;
        objectstoolbutton.imageindex:=24;
        datetoolbutton.imageindex:=10;
        helptoolbutton.imageindex:=14;
        telescope1.ImageIndex:=25;
        centreon1.ImageIndex:=23;

        toolbar2.ButtonWidth:=5;{trick to refresh toolbar2 width, otherwise strange wide stretch.}
        toolbar2.Visible:=true;
      end;
    0:begin {text and icons}
        toolbar2.Visible:=false; {stop updating temporary}
        {$IFDEF fpc}
        filetoolbutton.showcaption:=true; {FPC & Lazarus solution}
        searchtoolbutton.showcaption:=true;
        intoolbutton.showcaption:=true;
        outtoolbutton.showcaption:=true;
        resettoolbutton.showcaption:=true;
        Screentoolbutton.showcaption:=true;
        objectstoolbutton.showcaption:=true;
        datetoolbutton.showcaption:=true;
        helptoolbutton.showcaption:=true;
        {$ELSE} {delphi}
        {$ENDIF}


        filetoolbutton.imageindex:=0;
        searchtoolbutton.imageindex:=17;
        intoolbutton.imageindex:=15;
        outtoolbutton.imageindex:=16;
        resettoolbutton.imageindex:=37;
        Screentoolbutton.imageindex:=38;
        objectstoolbutton.imageindex:=24;
        datetoolbutton.imageindex:=10;
        helptoolbutton.imageindex:=14;
        telescope1.ImageIndex:=25;
        centreon1.ImageIndex:=23;
        toolbar2.Visible:=true;

      end;
    2:begin {only text, no icons}
        toolbar2.Visible:=false; {stop updating temporary}
        {$IFDEF fpc}
        filetoolbutton.showcaption:=true; {FPC & Lazarus solution}
        searchtoolbutton.showcaption:=true;
        intoolbutton.showcaption:=true;
        outtoolbutton.showcaption:=true;
        resettoolbutton.showcaption:=true;
        Screentoolbutton.showcaption:=true;
        objectstoolbutton.showcaption:=true;
        datetoolbutton.showcaption:=true;
        helptoolbutton.showcaption:=true;
        {$ELSE} {delphi}
        filetoolbutton.style:=tbstextbutton;
        searchtoolbutton.style:=tbstextbutton;
        intoolbutton.style:=tbstextbutton;
        outtoolbutton.style:=tbstextbutton;
        resettoolbutton.style:=tbstextbutton;
        Screentoolbutton.style:=tbstextbutton;
        objectstoolbutton.style:=tbstextbutton;
        datetoolbutton.style:=tbstextbutton;
        helptoolbutton.style:=tbstextbutton;
        {$ENDIF}
        filetoolbutton.imageindex:=-1;
        searchtoolbutton.imageindex:=-1;
        intoolbutton.imageindex:=-1;
        outtoolbutton.imageindex:=-1;
        resettoolbutton.imageindex:=-1;
        Screentoolbutton.imageindex:=-1;
        objectstoolbutton.imageindex:=-1;
        datetoolbutton.imageindex:=-1;
        helptoolbutton.imageindex:=-1;
        telescope1.ImageIndex:=-1;
        centreon1.ImageIndex:=-1;
        toolbar2.Visible:=true;
      end;
    end;{case}
    menu_changed:=false;{work done}
  end; {if}

  Showmoonorbits1.checked:=show_orbit <>0;
  Deepskycontoursonly1.checked:=contour_only<>0;
  InsertFITSimage1.checked:=fits_insert<>0;
  fitstoolButton.down:=fits_insert<>0;
  Showstatusbar1.checked:=statusbar1.visible;   {note this should be also done at showstatusbar because this routine is not called after change}

  Pointingcirclemarker1.checked:=marker_telrad<>0;
  Nameofobjectmarker1.checked:=marker_name=1;
  Magnitudeofobjectmarker1.checked:=marker_name=2;
  Dateandtimemarker1.checked:=marker_name=3;
  mouseposition1.visible:=server_on; {server on the show export to server}
  export_frames_via_server1.visible:=server_on; {server on the show export to server}

  case projection of 0:  begin
                           Azimuthalequidistant1.checked:=false;
                           Orthographic_projection1.checked:=true;
                           Cylindrical1.Checked:=false;
                           Northabove1.Enabled:=true;
                         end;
                     1:  begin
                            Azimuthalequidistant1.checked:=true;
                            Orthographic_projection1.checked:=false;
                            Cylindrical1.Checked:=false;
                            Northabove1.Enabled:=true;
                         end;
                     2:  begin
                            Azimuthalequidistant1.checked:=false;
                            Orthographic_projection1.checked:=false;
                            Cylindrical1.Checked:=true;
                            Northabove1.Checked:=false;
                            northtop:=0;
                            Northabove1.Enabled:=false;
                         end;
                      end;{case}

  if actualtime=false then
    begin
      Usesystemtime1.checked:=false;
      MinF3.enabled:=true;
      MinF4.enabled:=true;
      hourF5.enabled:=true;
      HourF6.enabled:=true;
      DayF7.enabled:=true;
      DayF8.enabled:=true;
      N2356F11.enabled:=true;
      N2356F12.enabled:=true;
      Followsolarobject1.enabled:=false;

    end
    else
    begin
      Usesystemtime1.checked:=true;
      MinF3.enabled:=false;
      MinF4.enabled:=false;
      hourF5.enabled:=false;
      HourF6.enabled:=false;
      DayF7.enabled:=false;
      DayF8.enabled:=false;
      N2356F11.enabled:=false;
      N2356F12.enabled:=false;
      mainwindow.followsolarobject1.enabled:=((follownaam2<>'') and (mainwindow.connect_telescope1.checked=true));{enable is connected}
    end;

    mainwindow.home1.Visible:=telescope_interface<>'I';{ascom, do not show for INDI}
    mainwindow.tracking1.Visible:=telescope_interface<>'I';{ascom, do not show for INDI}
end;

procedure tmainwindow.maakplaatje(canvas2:tcanvas;polarscope:boolean);
var i       : integer;
    old_RAm,old_DECM: double;
    bericht : string;
    bmp     :tbitmap;
begin
  oldx:=-9999; {reset ccd frame in mousemove}
  old_RAm:=999;  {for line solarobject}
  old_DECM:=999;

  if canvas2<>printer.canvas then
     mainwindow.color:=colors[0]{clblack};{make only screen black or white when not printing !! This is required when background is changed and then start scrolling, old color is coming back}
  if missedupdate>=2 then {clear canvas}
  begin
    Canvas2.Brush.Color := Colors[0];{clear fill bitmap with background color}
    canvas2.fillrect(rect(0,0,canvas2.width,canvas2.height){.clientrect}); {wis canvas using current brush}
  end;

  indexcounter:=0;{for index window 95 labels objects, Grid are not selected, hints is made there zero}

  {lock routines 2015}
  if ((sidereal=0) and (form_animation.Lock_on_name.Checked=false)) then
      wtime2:=wtime2actual;{2015 lock RA-DEC, wtime2actual is rotation position earth}
  {wtime2actual is the actual rotation  of the earth influcencing thesky and  always used for horizion, altitude grid and houses in supplement, riseset calculation, azimuth latitude calculation}
  {wtime2 is normally identical to wtime2actual and used for all objects that have a semi fixed RA, DEC position to rotate them around the sky  but can  be frozen (by lock ra, lock on name) to stop rotation}
  if  ((julian_ET<>old_julian_ET) and (form_animation.Lock_on_name.Checked) and  (locknaam2<>'') and (polarscope_visible=false)) then {keep tracking on solar object, polarscope_visible is added to prevent polar view is showing tracked solar object instead polar star}
  begin
    planet(0,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);{alway calculate sun position, otherwise problems}
    goto_str:=locknaam2;
    if find_object(canvas2,'P') then {find only solar and do  not update solar_combobox}
    begin
      ra_az(ra2,dec2,latitude,0,wtime2,viewx,viewy); {move sphere to center object}
    end
  end;

  if (julian_ET<>old_julian_ET) then sun200_calculated:=false; {sun200 values for asteroids and comets are no longer valid. They are not calculated be DE431}
  old_julian_et:=julian_ET;
  {end lock routines 2015}

  if northtop=1 then latitude:=90 else latitude:=reallatitude;
  latitude2:=(90-latitude)*pi/180;

  sincos(latitude2, sin_latitude2, cos_latitude2);
  sincos(viewx,sin_viewx,cos_viewx);
  sincos(viewy,sin_viewy,cos_viewy);
  sincos(latitude*pi/180,sin_latitude,cos_latitude);{for cylindrical projection}
  half_height:=round((rrw.bottom-rrw.top)/2);
  work_height:=rrw.bottom-rrw.top;
  work_width:=rrw.right-rrw.left;
  middle_x:=round((rrw.left+rrw.right)/2)+image_overlap;{overlap beyond mainwindow corners}
  middle_y:=round((rrw.bottom+rrw.top)/2)+image_overlap;
  zoomh:=flipv*zoom;
  zoomv:=fliph*zoom;

  if min_size_deep<0 then min_size2:=200/(zoom+0.01) {auto size}
  else min_size2:=min_size_deep;

  oldtime:=gettickcount64;{for escape routine}

  if showplottime then startTick:=oldtime;{for measuring speed}

  az_ra(viewx,viewy,latitude,0,wtime2,ra2,dec2);{calculate ra and dec from viewx,viey}
  telescope_ra:=ra2;telescope_dec:=dec2;{used if telescope drive is on}
  cos_telescope_dec:=cos(telescope_dec);{here to save CPU time. Used for field calcalculation cos(telescope_dec)}

  if missedupdate=-9 then exit;{special for polar plot, some variable recalculated such as cos_viewx}
   missedupdate:=0;

  if ((viewch=false) and (line_drawing_mode=false)) then {busy rebuilding cursor, else keep left,up, right down ARROW cursor}
  begin
    if swipe_mode=0 then image1.Cursor:=crnormalcursor2
    else
    image1.Cursor:=crcursor_hand;
  end;

  if toast_activated<>0 then plot_toast(canvas2); if missedupdate<>0 then exit;
  if (earth_covers_stars=0) then plot_earth(canvas2);

  find_chart_orientation(canvas2);
  if ((polarscope=false) and (printing=false)) then {do this not for polarscope}
  begin
    plot_info(canvas2);
    if ((northarrow<>0) and (projection<>2)) then
                      plot_north_arrow(north_xpos,north_ypos,north_leng)
                                             else mainwindow.panel_north1.visible:=false;
  end;
  plot_grid(canvas2);

  stardatabase_displayed:=select_primary_or_secondary_catalogue(stardatabase_selected);{ before max_star_magnitude, 2015, when to switch from primary to secondary star catalogue based on zoom and catalogue}

  if ((stardatabase_displayed=0) or  (stardatabase_displayed>=32)) {32 or new 290} then
    stardatabase_displayed_naam:=uppercase(copy(name_star,1,3)) {create short naam for mainwindow.caption}
  else
    try  stardatabase_displayed_naam:=objectmenu.stars_external1.items[stardatabase_displayed-1];except; end;

  max_star_magnitude;{for supplements and star databases}

  if
  {$ifdef mswindows}
  (pos(':',dss_mask)=0)
  {$ELSE}{linux}
  ((pos('./',dss_mask)<>0) or ((pos('~/',dss_mask)<>0)))
  {$ENDIF}
  then {not a full path specified}
    dss_path:=documents_path+ExtractFilePath(dss_mask)
  else {full path specified}
    dss_path:=ExtractFilePath(dss_mask);
  dss_search:=ExtractFilename(dss_mask);
  if ExtractFileExt(dss_search)='' then  dss_search:=IncludeTrailingPathDelimiter(dss_search)+'*.fit*'; {2013 always add extension, make fool proof}

  if (fits_insert<>0) then
  begin
    if  (zoom>zoom_show_DSS) then
    begin
       get_fits(canvas2,dss_search);
    end
    else
    get_fits(canvas2,'downM*.fit');{only download files with probably Mellinger survey}
  end;

  if planets_activated<>0 then
    plot_PLANETS2(false,canvas2) {planets}
  else
    planet(0,2000,julian_ET,ra2,dec2,mag,length2,delta,phase,phi);{alway calculate sun position, otherwise problems}

  if comets_activated<>0 then begin plot_COMETS(canvas2);   end;
  if asteroids_activated<>0 then begin plot_ASTEROIDS(canvas2);  end;
  if moon_covers_stars=0 then {before comets}
  begin
    if planets_activated<>0 then plot_PLANETS2(true,canvas2);{moon}
  end;{stars before moon}
  if suppl1_activated<>0 then begin plot_supplement(canvas2,1); end;
  if suppl2_activated<>0 then begin plot_supplement(canvas2,2); end;
  if suppl3_activated<>0 then begin plot_supplement(canvas2,3); end;
  if suppl4_activated<>0 then begin plot_supplement(canvas2,4); end;
  if suppl5_activated<>0 then begin plot_supplement(canvas2,5); end;

  if ((deep_database>0) and (deep>50)) {hide LMC, tracker far left is deepsky disabled}
        then begin plot_deepsky(canvas2); end;

  if showplottime then deltaticksD:=gettickcount64;;{for measuring speed}

  if stars_activated<>0 then
  begin
    naam3:='';{for clipboard routine}
    case stardatabase_displayed of   1: plot_UCAC4stars(canvas2);
                             2,3,4,5,6: plot_onlinestars(canvas2);{UCAC4, NOMAD, URAT, Gaia online, PPMXL}
                                 290: begin
                                        plot_stars_290(canvas2); {tycho2 and other 290 databases}
                                        if statusbarfree=true then {otherwise found object is not displayed}
                                         begin
                                           str(maxmag/10:3:1,bericht);
                                           mainwindow.statusbar1.caption:=(Limiting_magn+' '+bericht);
                                         end;
                                       end;
                                  0: begin plot_stars(canvas2); {.dat star databases such as SAO, PPM}
                                        if statusbarfree=true then
                                        begin
                                          str(maxmag/10:3:1,bericht);
                                          mainwindow.statusbar1.caption:=(Limiting_magn+' '+bericht);
                                        end;
                                     end;
                                   end;{case}
  end;

  if polarscope=false then
  begin
    if magscale<>0 then plot_star_scale
                   else mainwindow.panel_starscale1.visible:=false;
  end;
  if showplottime then deltaticksS:=gettickcount64;;{for measuring speed}

  if moon_covers_stars=1 then {before comets and stars}
  begin
    if planets_activated<>0 then plot_PLANETS2(true,canvas2);{moon}
  end;{moon covers stars}

  for i:=0 to nr_markers-1 do {add markers}
  begin
    if ((marker_telrad<>0) and (markers.mode[i]>0 {true})) then
    begin
       marker_telrad2(canvas2,markers.ra[i],markers.dec[i],markers.font[i]);
    end;
    if ((marker_name<>0) and (markers.name[i]<>'')) then
    begin
        marker_name2(canvas2,markers.ra[i],markers.dec[i],markers.font[i],markers.name[i]);
        if markers.font[i]= 5 then {line for solar objects}
        begin
          if ((old_RAM<>999)  and (markers.mode[i]=-1)) then
          begin
            selectobject(canvas2.handle,pen11);
            plot_pixel_sphere(canvas2,old_RAm,old_DECm,-2,$0,0,0);   {move to}
            plot_pixel_sphere(canvas2,markers.ra[i],markers.dec[i],-1,$0,0,0);{line to}
          end;
          old_RAm:=markers.ra[i];
          old_DECm:=markers.dec[i];
        end;
     end;
  end;

  if ((earth_covers_stars<>0)) then plot_earth(canvas2);

  if ((de430_emphemeris<>0) and (de430_loaded=false)) then mainwindow.statusbar1.caption:='JPL file '+DE430_file+' or '+DE431_file+' '+not_found+' (or invalid date)';{no ephemeride file found}

  if done_tracks=false then {plot solar tracks}
  begin
    plot_solartracks(canvas2);
    done_tracks:=true;
  end;

  if ((movelines1.checked) or (Linestart1.checked) or (LinestartAzALT1.checked) or (hidelines1.checked) or (removelines1.Checked) or (insertlines1.Checked) or (colorchange1.checked) ) then
  begin
    line_drawing_mode:=true;
    image1.cursor:=crcursor_draw;
  end
  else
  begin
    line_drawing_mode:=false;
    if viewch=false then {else keep left,up, right down ARROW cursor}
    begin
      if swipe_mode=0 then image1.Cursor:=crnormalcursor
      else
      image1.Cursor:=crcursor_hand;
    end;
  end;

  missedupdate:=0;{important for example menu settings if no change}
//    SetTextColor(canvas2.handle,colors[27]{FFFFFF});
//    textout(canvas2.handle,200,150,pchar('wtimeactual:'+floattostr(wtime2actual)),20);
//    textout(canvas2.handle,200,170,pchar('wtime2:      '+floattostr(wtime2)+'          '),20);
//    textout(canvas2.handle,200,190,pchar('viewx:'+floattostr(viewx)),20);
//    textout(canvas2.handle,200,220,pchar('viewy:'+floattostr(viewy)),20);
//    textout(canvas2.handle,200,290,pchar('telescope_ra:'+floattostr(telescope_ra*12/pi)),20);
//    textout(canvas2.handle,200,310,pchar('telescope_dec:'+floattostr(telescope_dec*180/pi)),20);
//    textout(canvas2.handle,200,330,pchar('latitude2:'+floattostr(latitude2*180/pi)),20);

end; {maakplaatje}


procedure paint_sky;{redraw the sky}
var
  used_canvas :tcanvas;
begin
  redrawing:=true;
  Application.ProcessMessages;{2018, should empthy actions}

  {prepare for any error messaga}
  mainwindow.error_message1.visible:=false;
  mainwindow.error_message1.caption:='';
  mainwindow.error_message1.font.color:=colors[1];

  found:=0;{reset for clock driven repaint}
  oldx:=-9999;{2015 to prevent that frame is not correctly erased in first move}

  if printing then exit;{do not update till printing finished}

  RRW:=mainwindow.clientrect; {get dimensions window}

  used_canvas:=bitmap2.canvas; {new 2015, write to bitmap and later copy to canvas}
  selectfont2(used_canvas);{some will use parentfont, for labels and statictext as parent font}
  if mainwindow.statusbar1.Visible then
  begin
    mainwindow.statusbar1.Height:=round(3+font_height2);{autosize doesn't work for text}
    rrw.bottom:=rrw.bottom-mainwindow.statusbar1.height;
  end;

  if animation_running<>0 then statusbarfree:=false {do not allow display limiting magnitude}
  else statusbarfree:=true;

  if action2>0 then {search action required}
  begin
    begin
      if action2=2 then  begin ra2:=ra_const;dec2:=dec_const; end
      else mainwindow.image1.Cursor:=crwaitcursor;
      if ((action2=2) or (find_object(used_canvas,'T'))) then
      begin
        if auto_center then
        begin
          if ((mainwindow.connect_telescope1.Checked=false) or (center_on.slewto1.checked=false)) then
          begin
            ra_az(ra2,dec2,latitude,0,wtime2,viewx,viewy); {move sphere to center object}   {2016}
            telescope_ra:=ra2;telescope_dec:=dec2;{for startup, lock object}
            cos_telescope_dec:=cos(telescope_dec);{here to save CPU time. Use for field calcalculation cos(telescope_dec)}
            missedupdate:=2;
          end
          else
            export_to_telescope(ra2,dec2); {slew to object, ascom or indi}
        end
        else
        begin
          plot_pixel_sphere(mainwindow.canvas,ra2,dec2,-99,$0,0,0);{find x and y coordinate}
          x9:=x9+mainwindow.image1.left;{shift location from image1 to mainwindow}
          y9:=y9+mainwindow.image1.top;
          if ((x9>0) and (x9<rrw.right) and (y9>0) and (Y9<rrw.Bottom)) then  {within window 2015}
             setcursorpos(mainwindow.ClientOrigin.x+x9,mainwindow.ClientOrigin.y+y9);{move mouse to found object, independent of menu font size !!}
          action2:=0; {done action}

          mainwindow.image1.Canvas.Draw(0, 0, Bitmap2);{show two line marker     2019x}
          exit;  {do not change canvas}
        end;{no auto_center}
      end;
    end;
    action2:=0; {done action}
  end;

  if  missedupdate<>0 then
  begin
    if missedupdate<>3 then {no image swipe, so don't copy old wrong position}
    mainwindow.Canvas.CopyRect(rrw,Bitmap2.Canvas,rect(-mainwindow.image1.left,-mainwindow.image1.top,-mainwindow.image1.left+rrw.right,-mainwindow.image1.top+rrw.bottom));{This is twice faster then mainwindow.image1.repaint !!!!!}

    mainwindow.maakplaatje(used_canvas,false);

    if ((zoom<3) or (abs(mainwindow.image1.top+image_overlap)>image_overlap/2) or (abs(mainwindow.image1.left+image_overlap)>image_overlap/2)) then {only when offset is too large}
    begin
      mainwindow.image1.Top:=-image_overlap;{reposition moved image1}
      mainwindow.image1.left:=-image_overlap;
    end;

  end;
  {else is not possible}
  if missedupdate=0 then  mainwindow.image1.Canvas.Draw(0, 0, Bitmap2);{fastest, faster then  mainwindow.Image1.Picture.Graphic := Bitmap2; Simple repaint canvas, restore fast using bitmap copy}

  if undo_used=false then {only add to buffer in no undo is used}
  begin;
    if ((old_telescope_ra<>telescope_ra) or
        (old_telescope_dec<>telescope_dec) or
        (z_position<0) {buffer empthy starts with -1, prevent runtime error next zoom check} or
        (z_buffer[z_position,3]<>zoom))  then {no repaint  but real new view, 2013}
    begin
      inc(z_position); if z_position>z_length then z_position:=0;
      z_buffer[z_position,1]:=telescope_ra;
      z_buffer[z_position,2]:=telescope_dec;
      z_buffer[z_position,3]:=zoom;
      old_telescope_ra:=telescope_ra;
      old_telescope_dec:=telescope_dec;
    end;
  end
  else {do no store this repaint}
  undo_used:=false;

  mainwindow.update_menu;{update the menu}

  if ((showplottime) and (statusbarfree)) then
  begin
    deltaticksA:=gettickcount64;;{for measuring speed}
    mainwindow.statusbar1.caption:='Total:'+(IntToStr(deltaticksA-starttick) + 'ms')+'  Deepsky:'+(IntToStr(deltaticksD-starttick) + 'ms')+'  Stars:'+(IntToStr(deltaticksS-deltaticksD) + 'ms');
  end;

//  supplstring2.Append(inttostr(gettickcount64)+'  ''end of paint_sky: '+ floattostr(viewx*180/pi)+#39+' '+floattostr(viewy*180/pi) );

//  used_viewx:=viewx;{remember since sometimes a next paint action is interrupted after modifying viewx but not completing a new image}
//  used_viewy:=viewy;

 // starty:=-999999; {painting finished for clock driven update}
//  textout(used_canvas.handle,200,310,pchar('zzzzzzzzzzzzz:'+floattostr(z_position)),20);
  if new_user then CHECK_NEW_USER;{default.hns not found or longitude=0 latitude=50 (in the sea)} {For linux this message not in an ONpaint event since the messagebox will be grey.}

  redrawing:=false; {for measruing frame}
end;  {paint_sky}

procedure Tmainwindow.FormResize(Sender: TObject);
begin
  image_overlap:=round(mainwindow.Height/2);// else image_overlap:=0;{above zoom>3 swipe by move image }
  Bitmap2.Free;
  Bitmap2 := TBitmap.Create;
  bitmap2.Canvas.Brush.Color := Colors[0];{before setting size to clear}
  Bitmap2.Width := mainwindow.width+image_overlap+image_overlap;
  Bitmap2.Height := mainwindow.height+image_overlap+image_overlap;
  Bitmap2.PixelFormat := pf24bit;

  RRW:=mainwindow.clientrect; {get dimensions window}

  fastbitmap1.size:=Point(mainwindow.width+image_overlap+image_overlap, mainwindow.Height+image_overlap+image_overlap);{set size correctly}
  clear_FastBitmap(fastbitmap1,colors[0]);{clear fastbitmap pixels, fill with outcolor}

  if printing then exit;{do not update till printing finished}

  image1.top:=-image_overlap;
  image1.left:=-image_overlap;

  mainwindow.image1.height:=mainwindow.height+image_overlap+image_overlap;
  mainwindow.image1.width:=mainwindow.width+image_overlap+image_overlap;
  image1.Picture.Bitmap.Width := Image1.Width;
  image1.Picture.Bitmap.Height := Image1.Height;
  missedupdate:=2;
  paint_sky;
end;

procedure Tmainwindow.FormShow(Sender: TObject);
var
    icon_height: integer;
begin
  icon_height:=8*round(ToolBar2.height*(16/23)/8); {16, 24, 32}
  PopupMenu_menubar1.ImagesWidth:=icon_height; {adapt icons, lazarus 1.9}
  if icon_height=16 then  PopupMenu1.images:=ImageList16x16 {resizing doesn't work for this menu? bug}
  else
  PopupMenu1.ImagesWidth:=icon_height;

  ToolBar2.ImagesWidth:=icon_height;
end;

procedure Tmainwindow.markmousepos(Sender: TObject);
var
  eq :string;
  mouse_ra2,mouse_dec2 : double;
begin
  if equinox<>2000 then {classic method not the high accuracy method}
  begin
    if equinox<=1 then
    begin
      ep(2000,equinox_date,mouse_ra,mouse_dec,mouse_ra2,mouse_dec2); {convert to actual ra,dec}
      if equinox=0 then eq:=app_string else eq:=mean_string;
    end
    else
    if equinox=1950 then begin ep(2000,1950,mouse_ra,mouse_dec,mouse_ra2,mouse_dec2); {convert to 1950} eq:='B1950: '; end
    else
    begin EQU_GAL(mouse_ra,mouse_dec,mouse_ra2,mouse_dec2);{galactic coordinates} eq:='gal: '; end;

    eq:=eq+prepare_ra(mouse_ra2)+' '+prepare_dec(mouse_dec2);
  end
  else
  eq:=prepare_ra(mouse_ra)+' '+prepare_dec(mouse_dec);

  if mframe<>0 then
  begin
    supplstring2.Append(floattostr2(mouse_ra*12/pi)+',,,'+ floattostr2(mouse_dec*180/pi)+',,,-25,_'+inttostr(1+supplstring2.count)+'/'+inttostr(frame_angle)+'°,frame,-8,'+inttostr(round(frame_width*10))+','+inttostr(round(frame_height*10))+','+inttostr(frame_angle)); {data point to suppl2}
                                                                    {CCD rotation clockwise is positive, then image rotation counter-clockwise giving a positive CROTA2 equal to CCD rotation.}
    inc(linepoint_counter);
    suppl2_activated:=1;{activate supplement 2 to show}
  end
  else
  begin
    supplstring2.Append(floattostr2(mouse_ra*12/pi)+',,,'+    {2016-11-10, changed popupmouse_ra to mouse_ra}
    floattostr2(mouse_dec*180/pi)+',,,,_'+eq+' ('+inttostr(1+supplstring2.count)+')/'+copy(today2,1,10)+'    '+',Log/_   ,-99');{info to clipboard}
  end;

  missedupdate:=1;
  suppl2_activated:=1; {always activate supplement 2}
  paint_sky;
end;

Procedure open_link(link:string);{OpenURL allows anchor parameters}
begin
  {$ifdef fpc}
  OpenURL(link);
  {$ELSE} {delphi}
  ShellExecute(mainwindow.handle {application.handle},'open', PChar('"'+link+'"'),nil , nil, SW_NORMAL);  {'"' for path names with spaces like program files}
  {$endif}
end;
Procedure open_file(link:string);{no parameters allowed}
begin
  {$ifdef fpc}
  OpenDocument(link);
  {$ELSE} {delphi}
  ShellExecute(mainwindow.handle {application.handle},'open', PChar('"'+link+'"'),nil , nil, SW_NORMAL);  {'"' for path names with spaces like program files}
  {$endif}
end;

procedure open_file_with_parameters(filelink,parameters2:string);{This one does work for anchor parameters. Works for chrome and Firefox, not for internet explorer}
 {$ifdef unix}
var
  AProcess: TProcess;
  browser :string;
begin
  {FindExecutable not available in Linux, workaround:}
  if FileExists('/usr/bin/firefox') then browser:='/usr/bin/firefox' else
  if FileExists('/usr/bin/seamonkey') then browser:='/usr/bin/seamonkey' else
  if FileExists('/usr/bin/google-chrome') then browser:='/usr/bin/google-chrome' else
  if FileExists('/usr/bin/chromium-browser') then browser:='/usr/bin/chromium-browser' else {raspberry pi chromium}
  if FileExists('/usr/bin/opera') then browser:='/usr/bin/opera' else
  if FileExists('/usr/bin/midori') then browser:='/usr/bin/midori' else
  if FileExists('/usr/bin/konqueror') then browser:='/usr/bin/konqueror' else {not tested yet}
  if FileExists('/usr/bin/web') then browser:='/usr/bin/web' else {not tested yet}
  if FileExists('/usr/bin/conkeror') then browser:='/usr/bin/conkeror' else {not tested yet}
  if FileExists('/usr/bin/qupzilla') then browser:='/usr/bin/qupzilla'  else {not tested yet}
  browser:='';

  if browser<>'' then
  begin
    AProcess := TProcess.Create(nil);
    AProcess.Executable := browser;
    AProcess.Parameters.Add('file:///'+filelink+parameters2);
    // AProcess.Options are not set so the program continues after starting the browser}
    AProcess.Execute;
    AProcess.Free;
  end
  else
  OpenDocument(Filelink);{unknown browser, open without anchor}
end;

{$ELSE} {windows}
 var
    Buffer: array[0..MAX_PATH] of
    Char;
    Res: Integer;
  begin

  FillChar(Buffer, SizeOf(Buffer), #0);
  Res := FindExecutable(PChar(filelink), nil, Buffer );
  if Res > 32 then {Executable program for filelink is in Buffer}
  begin
    ShellExecute(mainwindow.handle, 'open', buffer, PChar('"'+'file:///'+filelink+parameters2+'"'),nil, SW_SHOWNORMAL)  {file:///  for firefox, otherwise # becomes %23,  '"' for paths with spaces like program files}
  end;
end;
 {$endif}

function DownloadFile(SourceFile, DestFile: string): Boolean;{2013, download files from internet}
begin
  mainwindow.image1.cursor:=crwaitCursor;
  application.processmessages; {required otherwise no wait cursor in Linux}

  {$ifdef mswindows}
  try
    Result := UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0, nil) = 0;
  except
    Result := False;
  end;
  {$ELSE} {Linux}
   result:=download_file(SourceFile, DestFile);
   {$endif}
  mainwindow.image1.cursor:=crnormalcursor;
end;

procedure Tmainwindow.Exit1Click(Sender: TObject);
begin
  application.terminate;
end;

procedure draw_lines;{make line drawings}
var commando1 : string;
    position2,i : integer;
begin
 {begin line functions}
  if mainwindow.hidelines1.Checked=true then {remove line mode}
  begin
    find_line(mainwindow.canvas); {find position in supplement 2}
    if cut_position<>0 then
    begin
      commando1:=copy(supplstring2.strings[cut_position],length(supplstring2.strings[cut_position])-1,2){old -2 or -1, or -3, -4};
      if commando1='-1' then commando1:='-2' else  {toggle line to or move to}
      if commando1='-2' then commando1:='-1' else
      if commando1='-3' then commando1:='-4' else
      if commando1='-4' then commando1:='-3' else commando1:='';
      if commando1<>'' then
      begin {remove line by changing drawing commando}
        supplstring2.strings[cut_position]:= copy(supplstring2.strings[cut_position],1,length(supplstring2.strings[cut_position])-2)+commando1;
        missedupdate:=2; paint_sky;
      end;
      cut_position:=0;
      exit;
    end;
  end
  else
  if mainwindow.removelines1.Checked=true then {remove line mode}
  begin
    find_line(mainwindow.canvas); {find position in supplement 2}
    if cut_position<>0 then
    begin
      supplstring2.strings[cut_position]:= ';$$$'+supplstring2.strings[cut_position];
      missedupdate:=2; paint_sky;
    end;
    cut_position:=0;
    exit;
  end
  else
  if mainwindow.insertlines1.Checked=true then {insert line mode}
  begin
    if cut_position=0 then find_line(mainwindow.canvas) {find position in supplement 2}
    else
    begin
      commando1:=extract_command(supplstring2.strings[cut_position],9);
      if ((commando1='-3') or (commando1='-4') or (commando1='-5')) then {az/alt line}
        supplstring2.insert(cut_position, floattostr2(azimuth2*12/pi)+',,,'+ floattostr2(altitude2*180/pi)+',,,-20,,line_point,-3')
        else
        supplstring2.insert(cut_position,floattostr2(mouse_ra*12/pi)+',,,'+ floattostr2(mouse_dec*180/pi)+',,,-25,,line_point,-1'); {data point to suppl2}
      cut_position:=0;
      missedupdate:=2;paint_sky;
    end;
    exit;
  end
  else
  if mainwindow.colorchange1.Checked=true then {line colour change mode}
  begin

    find_line(mainwindow.canvas); {find position in supplement 2}
    if cut_position<>0 then supplstring2.strings[cut_position]:=change_line_color(supplstring2.strings[cut_position]);
    cut_position:=0;
    missedupdate:=2;paint_sky;
    exit;
  end
  else
  if mainwindow.linestart1.checked=true then {draw line point ra/dec}
  begin{draw line point ra/dec}
    if linepoint_counter=0 then
    begin
      if found_name='' then found_name:=inttostr(1+supplstring2.count);{add line number instead of found name}
      supplstring2.Append(floattostr2(mouse_ra*12/pi)+',,,'+ floattostr2(mouse_dec*180/pi)+',,,-25,_'+found_name+',line_point,-2'); {data point to suppl2}
    end
    else supplstring2.Append(floattostr2(mouse_ra*12/pi)+',,,'+ floattostr2(mouse_dec*180/pi)+',,,-25,/_'+inttostr(1+supplstring2.count)+',line_point,-1'); {data point to suppl2}
    inc(linepoint_counter);
    missedupdate:=1;paint_sky;{rewrite window}
    exit;
  end {ra/dec line draw}
  else
  if mainwindow.LinestartAzALT1.checked=true then {draw ra/dec lines}
  begin {draw line point az/alt}
    if linepoint_counter=0 then supplstring2.Append(floattostr2(azimuth2*12/pi)+',,,'+ floattostr2(altitude2*180/pi)+',,,-20,_'+inttostr(1+supplstring2.count)+',line_point,-4')
    else supplstring2.Append(floattostr2(azimuth2*12/pi)+',,,'+ floattostr2(altitude2*180/pi)+',,,-20,/'+inttostr(1+supplstring2.count)+',line_point,-3');
    inc(linepoint_counter);
    missedupdate:=1;paint_sky;  {rewrite window without clearing}
    exit;
  end
  else
  if mainwindow.movelines1.Checked=true then {move object mode}
  begin
    if cut_position=0 then find_line(mainwindow.canvas) {find position in supplement 2}
    else
    begin
      position2:=0;
      for i := 1 to 6 do  position2:=posex(',',supplstring2.strings[cut_position],position2+1); {find last comma position}
      tempstr:=copy(supplstring2.strings[cut_position],position2+1,999){};
      commando1:=extract_command(supplstring2.strings[cut_position],9);
      if ((commando1='-3') or (commando1='-4') or (commando1='-5')) then {az/alt command}
      supplstring2.strings[cut_position]:=floattostr2(azimuth2*12/pi)+',,,'+ floattostr2(altitude2*180/pi)+',,,'+tempstr {data point to suppl2}
      else
      supplstring2.strings[cut_position]:=floattostr2(mouse_ra*12/pi)+',,,'+ floattostr2(mouse_dec*180/pi)+',,,'+tempstr; {data point to suppl2}
      cut_position:=0;
      missedupdate:=2;paint_sky;
    end;
    exit;
  end;
 {end line functions}
end;

procedure Tmainwindow.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  down_x:=x;
  down_y:=y;

  goto_str:='';{cancel tracking}
  if ssleft in shift then
  begin
    viewch:=false;
    found:=0;
    if (size_pulled_rectangle<1) then {no rubber rectangle}
    begin
      mx:=x;
      my:=y;
      if x+image1.left<rrw.left+20 then begin image1.cursor:=crcursorleft;viewx:=limit_radialen(viewx-scrollsize*fliph/(zoom),2*pi);viewch:=true;end {scroll right}
      else
      if x+image1.left>rrw.right-20 then begin  image1.cursor:=crcursorright;viewx:=limit_radialen(viewx+scrollsize*fliph/(zoom),2*pi);viewch:=true;end
      else
      if ((y+image1.top<rrw.top+20) or ((toolbar2.Visible=true) and (mx+image1.left<=toolbar2.Width) and (my+image1.top<rrw.Top+20+toolbar2.height))  ) then begin
                                    image1.cursor:=crcursorup;viewy:=limit_radialen(viewy+scrollsize* flipv/(zoom),2*pi);viewch:=true;end
      else
      if y+image1.top>rrw.bottom-20{-offset} then  begin image1.cursor:=crcursordown; viewy:=limit_radialen(viewy-scrollsize*flipv/(zoom),2*pi);viewch:=true;;end;

      if (viewch=false) then
      begin
        if line_drawing_mode=false then
        begin
          if find_object(image1.canvas,'M') then  begin image1.cursor:=crnormalcursor; end
          else
          image1.Cursor:=crcursor_hand;
        end
        else
        draw_lines;
      end
      else
      begin {view change}
        missedupdate:=2;
        paint_sky;{restart again}
      end;
    end;{size square <1}
  end;

  if ((ssCTRL in Shift) and (ssDOUBLE in Shift) and (mainwindow.connect_telescope1.Checked)) then
    mainwindow.Telescopetomouseposition1Click(nil) {mmove telescope to mouse position}
  else {2017-8}
  if ( ((ssDouble in shift)=false) and ((ssCtrl in shift)=false) and (ssleft in Shift) ) then {swipe mode }
  begin {swipe mode}
     swipe_mode:=1;
     mouse_radec(image1.canvas,x,y,popupmouse_ra,popupmouse_dec);  {find mouse position}
    ra_az(popupmouse_ra, popupmouse_dec,latitude,0, wtime2,viewx1,viewy1);{using the start popupmouse_ra}
  end
  else
  if ((ssmiddle in Shift) or { middle  button}
     ({(ssAlt in shift) and} (ssDouble in shift)) or  {alt plus double click left mouse button}
     ((ssAlt in shift) and (ssright in shift )) ) then  {alt plus right mouse button}
  begin  {center on mouse position}
    mouse_radec(image1.canvas,x,y,popupmouse_ra,popupmouse_dec);  {find mouse position}
    mainwindow.Centreon1Click(nil);
  end;
end;

procedure Tmainwindow.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var sep,xxx,yyy: double;
    dd,xr,yr,overlapx,overlapy,extraX,extraY,len   : integer;
    ssw,ssh, ss, ss_sep, ber,mag : string;
    xxxx,orientation, x2,y2,ra9,dec9,viewx2,viewy2 : double;
    pullboxmode    : boolean;{pulling a rectangle with the mouse?}

begin
  if printing then exit;{do not update till printing finished}

  viewch:=false;
  if (ssleft in shift)=false then swipe_mode:=0; {sometimes it is missed in mouse_up}

  mx:=x;
  my:=y;

  pullboxmode:=(
                (sender=mainwindow.image1) and  {prevent starting pullbox modes while not in mainwindow, e.g from animation menu}
                (  ((ssctrl in shift) and (ssleft in shift)) or (ssright in shift)) {ssleft in shift gives problems with closing editor windows with leftmouse button, new 6-2003}
                 and (oldx>0) {oldX=-9999 protection, if mouse leaving toolbar2 or entering mainwindow}
                 and (starty>0)
                 and (swipe_mode=0){2017-8}
                 );
  if pullboxmode=false then
  begin
    if ((ssleft in shift) and ((zoom>3) or (projection=2){cylindr})) then {swipe image1 effect}
    begin
      if ((abs(y-down_y)>2) or (abs(x-down_x)>2)) then
      begin
        image1.cursor:=crcursor_hand;{swipe mode}
        mainwindow.image1.Top:= mainwindow.image1.Top+(y-down_y);
        mainwindow.image1.left:= mainwindow.image1.left+(x-down_x);

        if left4.caption='????' then
          begin left4.visible:=false;statusbar1.caption:=''; end;{hide not found question marks ????. Keep other messages when swipping}
      end;
     exit;{no more to do}
   end;

    if swipe_mode=4 then {set cursor delayed in swipe mode}
    begin
      image1.cursor:=crcursor_hand;
    end
    else
    if swipe_mode>9 then
    begin
      mouse_radec(image1.canvas,x,y,mouse_ra,mouse_dec);  {find mouse position}
      ra_az(mouse_ra,mouse_dec,latitude,0, wtime2,viewx2,viewy2);
      viewx:=viewx-(viewx2-viewx1);
      viewy:=viewy-(viewy2-viewy1);

      swipe_mode:=5;
      missedupdate:=2; paint_sky;{restart again}
    end;
    if swipe_mode<>0 then
    begin
      inc(swipe_mode);{counter for swipe/hand cursor}
      exit;
    end;
  end;{no pullboxmode}

  if ((y+image1.top<=toolbar2.height+10{p0}) and (x+image1.left<=toolbar2.Width+20)) then
  begin {hide_mainmenu, 0 is hide, 1 is visible all the time. Use as multiplier in height calculation}
    if ((hide_mainmenu<>1) and (toolbar2.Visible=false)) then
    begin
      mainwindow.field1.visible:=false;
      mainwindow.az_m1.visible:=false;
      mainwindow.az_m2.visible:=false;
      mainwindow.alt_m1.visible:=false;
      mainwindow.alt_m2.visible:=false;
      mainwindow.flipped1.visible:=false;
      toolbar2.Visible:=true; {unhide/show}
    end;
  end
  else
  begin
    if ((hide_mainmenu<>1) and (toolbar2.Visible=true)) then
    begin
      toolbar2.Visible:=false; {unhide/show}
      mainwindow.field1.visible:=true;
      mainwindow.az_m1.visible:=true;
      mainwindow.az_m2.visible:=true;
      mainwindow.alt_m1.visible:=true;
      mainwindow.alt_m2.visible:=true;
      mainwindow.flipped1.visible:=true;
    end;
  end;

  if x+image1.left<rrw.left+20 then
  begin
    image1.cursor:=crcursorleft; mainwindow.statusbar1.caption:=(To_go_left);
  end
  else

  if ((y+image1.top<rrw.top+20) or ((toolbar2.Visible=true) and (x+image1.left<=toolbar2.Width) and (y+image1.top<rrw.Top+20+toolbar2.height))  ) then
  begin
    image1.cursor:=crcursorup;
     if my>1 {required for reliable toolbar menu hints}
       then mainwindow.statusbar1.caption:=(To_go_up)
  end
  else
  if x+image1.left>rrw.right-20 then begin
    image1.cursor:=crcursorright;mainwindow.statusbar1.caption:=(To_go_right);end
  else
  if ((y+image1.top>rrw.bottom-20)) then begin image1.cursor:=crcursordown;{statusbarfree:=true;}mainwindow.statusbar1.caption:=(To_go_down); end
  else
  begin
    mainwindow.hint:=''; {Clear UTC hint}
    if ((movelines1.checked) or (Linestart1.checked) or (LinestartAzALT1.checked) or (hidelines1.checked) or (removelines1.Checked) or (insertlines1.Checked) or (colorchange1.checked) ) then
    begin
       line_drawing_mode:=true;
       if image1.cursor<>crcursor_draw then image1.cursor:=crcursor_draw;
    end
    else
    begin
      line_drawing_mode:=false;
      if ((ssCtrl in Shift) and (mainwindow.connect_telescope1.Checked)) then mainwindow.image1.cursor:=crcursor_tel  {telescope can move to here after double click}
      else
      if ((image1.cursor<>crnormalcursor) and  (image1.cursor<>crnormalcursor2) {and (ssleft in shift=false) and (image1.cursor=crcursor_hand)}) then
      begin
        mainwindow.statusbar1.caption:='';{clear message: To go left....}
        image1.cursor:=crnormalcursor;{2015 moved to if statement}
      end;
    end;
    if ((hints<>0) and (pullboxmode=false)  and (found=0){skip first mouse move after found object so statusbar message stays}
       and (mainwindow.active=true){for better hints control for other forms})  then
    begin
      mainwindow.showhint:=false;
      application.HintPause:=1000;
      dd:=0;
      while  ((dd<indexcounter))do
      begin
        if ( (abs(index[0,dd]-mx)<4) and (abs(index[1,dd]-my)<4)) then
        begin
          mainwindow.showhint:=true;
          application.HintPause:=0;

          if magnitudes[dd]<>-999 then
          begin
            str(magnitudes[dd]/10:0:1,mag);
            if names[dd]<>'' then
              mainwindow.hint:=names[dd]+'  '+mag
            else
              mainwindow.hint:=mag;
          end
          else
          mainwindow.hint:=names[dd];{suppress magnitude indication of lines, houses frames}

          found:=0;
          dd:=$FFFF;{stop searching}
        end
        else
        begin
          inc(dd);
        end;
      end;
      if dd<$FFFF then
                   mainwindow.statusbar1.caption:=('');{clear statusbar} //statusbarfree:=true;
    end;{window 95 hints}
    if ((abs(oldx-x)>2)  or (abs(oldy-y)>2)) then found:=0;{ready for new hint, correction 2013}
  end;

  mouse_radec(image1.canvas,x,y,mouse_ra,mouse_dec);  {find mouse position}

  if equinox<>2000 then
  begin
    if equinox<=1 then ep(2000,equinox_date,mouse_ra,mouse_dec,ra9,dec9) {convert to actual ra,dec}
    else
    if equinox=1950 then ep(2000,1950,mouse_ra,mouse_dec,ra9,dec9) {convert to 1950}
    else
    EQU_GAL(mouse_ra,mouse_dec,ra9,dec9);{galactic cordinates}
  end
  else begin ra9:=mouse_ra;  dec9:=mouse_dec; end;{RA9, DEC9 for not spoiling ra,dec for altitude calculation later}

  if equinox<>9999 then
  begin
    report_azalt.ra:=prepare_ra3(ra9);{give RA}
    report_azalt.dec:=prepare_dec2(dec9);{give DEC}

//    if ((equinox=2000) {and (shift=[ssShift])}) then{insider special function, give position in deepsky database format, assist info for correcting deepsky database}
//    begin
//      bar_hint:=inttostr(round(ra9*864000/(2*pi)))+','+inttostr(round(dec9*324000/(0.5*pi))) ;{click on status bar to copy info}
//      statusbar1.caption:=bar_hint;
//    end;

  end
  else
  begin {galactic position}
    str(ra9*180/pi:6:1,ber);
    report_azalt.ra:=ber;{give galactic longitude}
    str(dec9*180/pi:6:1,ber);
    report_azalt.dec:=ber;{give galactice latitude}
  end;

  if ((oldx=x) and (oldy=y))=false then {mouse move, overwrite the found object azimuth altitude with mouse azimuth, altitude}
  begin    {give azimuth/altitude of mouse position}

    ep(2000,equinox_date,mouse_ra,mouse_dec,xxx,yyy); {new 19-12-2000, convert to actual ra,dec }
    ra_az(xxx,yyy,reallatitude,0, wtime2actual,azimuth2,altitude2); {new 19-12-2000, for current date !!}
    if apparent_horizon<>0 then  altitude2:=altitude_apparent(altitude2); {refraction at atmosphere, max 34 minutes near horizon}
    if  azimuth_degrees=0 then
    begin
      str(altitude2*180/pi:5:0,ber);{altitude standard}

      report_azalt.alt:=ber;{give altitude} {ber needs to be string not ansistring otherwise rubbish???}
      report_azalt.az:=richting[round(azimuth2*8/pi)];{azimuth in N, S, E, W}

    end
    else
    begin
      str(altitude2*180/pi:5:1,ber);{altitude with one digit behind point,  azimuth in degrees}
      report_azalt.alt:=ber;{give altitude}
      str(azimuth2*180/pi:4:1,ber); {azimuth}
      report_azalt.az:=ber;{give azimuth in degrees}
    end;
  end;{give azimuth/altitude of mouse position}

  if ((linestart1.checked=true) or  (LinestartAzALT1.checked=true)) then exit;{do not draw squares in this mode}


  {rubber line, based on example from help delphi}
  if pullboxmode then
  begin
//  if size_pulled_rectangle>1 then old_size_pulled_rectangle:=size_pulled_rectangle;{fix for Linux, unreliable rubber rectangle if done too fast.}
    mainwindow.showhint:=false; {hints disturb rubber box}

    overlapX:=-image1.Left;
    overlapY:=-image1.top;

    {write on mainwindow.canvas, not on image1.canvas. This reduces CPU load significantly}

   {$ifdef CPUARM}
      mainwindow.Canvas.Pen.color:=$00FFFF; {required for Linux Buster, yellow}
   {$else}
      mainwindow.Canvas.Pen.color:=$FF0000; {yellow}
   {$endif}
    mainwindow.canvas.Pen.Mode := pmNotXor;       { use XOR mode to draw/erase }
    mainwindow.canvas.MoveTo(startx - overlapX, startY - overlapY);   { move pen back to origin }

    if oldX- startX>0 then extraX:=1 else extraX:=-1;
    if oldY- startY>0 then extraY:=1 else extraY:=-1;
    mainwindow.Canvas.CopyRect(rect(startX-overlapX-extraX,startY-overlapY-extraY,oldX- overlapX+extraX,oldY- overlapY+extraY),Bitmap2.Canvas,
                               rect(startX-extraX,startY-extraY,oldX+extraX,oldY+extraY)  );{erase by simple repaint canvas, restore fast using bitmap copy, visible part only}

    mainwindow.canvas.LineTo(X - overlapX, startY - overlapY);     { draw the new line }
    mainwindow.canvas.LineTo(X - overlapX, Y - overlapY);          { draw the new line }
    mainwindow.canvas.LineTo(startX - overlapX, Y - overlapY);     { draw the new line }
    mainwindow.canvas.LineTo(startX - overlapX, startY - overlapY);{ draw the new line }

    mainwindow.canvas.Pen.Mode := pmCopy; {back to normal}

    centerx:=round((startX+X)/2);
    centery:=round((startY+Y)/2);
    size_pulled_rectangle:=abs(startY-Y);

    if ((oldx<>x) or (oldy<>y)) then
    begin
      str((180/pi)*(chart_orientation-arctan2(x-startx,starty-y) ):6:1,ss);{PA}
      sep:=sqrt(sqr(startX-X)+sqr(startY-Y))*{6883}field_factor/(work_height*zoom);{arc_min}
      sep_width:=abs(startX-X)*{6883}field_factor/(work_height*zoom);{arc_min,  used for get_DSS}
      sep_height:=abs(startY-Y)*{6883}field_factor/(work_height*zoom);{arc_min, used for get_DSS}

      if sep>60 then
      begin {degrees}
        str((sep/60):6:2,ss_sep);
        str(sep_width/60:5:1,ssw);
        str(sep_height/60:5:1,ssh);
        ss_sep:=ss_sep+'°    ('+ssw+' x'+ssh+'°)    PA='+ss;
      end
      else
      if sep<1  then
      begin {arcsec}
        str((sep*60):6:2,ss_sep);
        str(sep_width*60:5:1,ssw);
        str(sep_height*60:5:1,ssh);
        ss_sep:=ss_sep+'"    ('+ssw+' x'+ssh+'" )    PA='+ss;
      end
      else
      begin {arcmin}
        str((sep)   :6:2,ss_sep);
        str(sep_width:5:1,ssw);
        str(sep_height:5:1,ssh);
        ss_sep:=ss_sep+#39+'    ('+ssw+' x'+ssh+#39+' )    PA='+ss;
      end;
      statusbar1.caption:=ss_sep;
    end;
  end {rubber}
  else
  begin
    centerx:=0; centery:=0; size_pulled_rectangle:=0;
    startx:=x;starty:=y;

    {measuring frame}

    if mframe=0 then orientation:=90 {default landscape}
    else
    if redrawing=false then {don't do this during repaint. Copyrect(... bitmap2) could be old}
    if ((oldx<>x) or (oldy<>y) or (old_frame_angle<>frame_angle){to preserve found text and to rotate}) then
    begin {frame<>0, sensor measuring frame}
      plot_pixel_sphere(mainwindow.image1.canvas,mouse_ra,mouse_dec+0.5/zoom {(frame_height*0.3*pi/180)},-99,$0,0,0); { find orientation by moving to }
      if zc<0 then exit;

      xxxx:=x-x9; if abs(xxxx)<0.000001 then xxxx:=0.000001; {prevent divide zero (old compiler only?) }
      orientation:=+arctan((y-y9)/xxxx)+(90-frame_angle)*pi/180;{frame_angle is extra rotation from ctrl + mouse wheel}

      yr:=round(frame_height*zoom*(half_height)/field_factor);
      xr:=round(frame_width*zoom*(half_height)/field_factor);

      if ((xr<half_height) and (yr<half_height) ) then {prevent drawing artifacts if drawing measuring too large}
      begin
        selectobject(image1.canvas.handle,pen1);{for stars}
        extraX:=xr+yr+300;

        mainwindow.image1.Canvas.CopyRect(rect(x-extraX,y-extraX,x+extraX,y+extraX),Bitmap2.Canvas,
                                          rect(x-extraX,y-extraX,x+extraX,y+extraX) );{simple repaint canvas, restore fast using bitmap copy, visible part only}
       {draw on image1 for flicker free rectangle. On mainwindow.canvas is also possible if above line is image1.repaint but flickers}
        image1.Canvas.Pen.color:=$00FF00; {required for Linux Buster White is $000000 for Windows. Buster it is $FFFFFF}
        image1.Canvas.Pen.Mode := pmNotXor;       { use XOR mode to draw/erase }

        rotate(orientation,xr,yr,x2,y2);
        image1.Canvas.MoveTo(x+round(x2) ,y+round(y2) );  { move pen back to origin }
        rotate(orientation,xr,-yr,x2,y2);
        image1.Canvas.lineTo(x+round(x2) ,y+round(y2) );  { draw }
        rotate(orientation,-xr,-yr,x2,y2);
        image1.Canvas.lineTo(x+round(x2) ,y+round(y2) );  { draw }
        rotate(orientation,-xr,+yr,x2,y2);
        image1.Canvas.lineTo(x+round(x2) ,y+round(y2) );  { draw }
        rotate(orientation,+xr,+yr,x2,y2);
        image1.Canvas.lineTo(x+round(x2) ,y+round(y2) );  { draw }

        image1.Canvas.Pen.Mode := pmCopy;
      end;
    end;{measuring frame}

  end;

  oldx:=x;
  oldy:=y;
  old_frame_angle:=frame_angle;
  canvas_mouse_pos; //see als write_field
end;

procedure Tmainwindow.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   viewx2,viewy2 : double;
   x1,y1         : integer;

begin
  if button=mbright then
  {$ifdef fpc}
  PopupMenu1.PopUp;{call popup manually if right key is released, not when clicked. Set in popupmenu autopopup off !!!}
  {$else} {delphi}
  PopupMenu1.PopUp(x,y);{call popup manually if right key is released, not when clicked. Set in popupmenu autopopup off !!!}
  {$endif}

  if ((oldx<>startx) or (oldY<>startY) )=false then
  begin {no rubber rectangle in action}
    if ((abs(image1.top+image_overlap)>image_overlap/2) or (abs(image1.left+image_overlap)>image_overlap/2)) then
    begin

      x1:=round(rrw.right/2  - mainwindow.image1.left);
      y1:=round(rrw.bottom/2  - mainwindow.image1.top);

      image1.cursor:=crnormalcursor;{2018 back to normal}

      mouse_radec(image1.canvas,x1,y1,mouse_ra,mouse_dec);  {find mouse position}

      ra_az(mouse_ra,mouse_dec,latitude,0, wtime2,viewx,viewy);

      missedupdate:=3;{Three 2018 !!!}{swipe_mode:=0;}

      paint_sky;
    end;
  end;

  {swipe mode for low zoom factors}
  if swipe_mode>=4 then
  begin
//    mouse_radec(image1.canvas,mx,my,mouse_ra,mouse_dec);  {find new mouse position}
    mouse_radec(image1.canvas,x,y,mouse_ra,mouse_dec);  {find new mouse position}
    ra_az(mouse_ra,mouse_dec,latitude,0, wtime2,viewx2,viewy2);
    viewx:=viewx-(viewx2-viewx1);
    viewy:=viewy-(viewy2-viewy1);
    missedupdate:=2;{swipe_mode:=0;}
    paint_sky;
  end
  else
  if button=mbleft then
  begin
    if (({old_}size_pulled_rectangle>20) {old_size_size_pulled_rectangle rather then size_pulled_rectangle for Linux}
    and (abs(startX-X)>20) {this one is only required for mswindows, otherwise strange thing happens when clicking fast}
     and (oldx>0){oldX=-9999 protection, if mouse leaving toolbar2 or entering mainwindow} ) then
    begin
      mouse_radec(image1.canvas,centerX,centerY,mouse_ra,mouse_dec);  {find mouse position}
      ra_az(mouse_ra,mouse_dec,latitude,0, wtime2,viewx,viewy);
      zoom:=zoom*(rrw.bottom-rrw.top)/{old_}size_pulled_rectangle;
      missedupdate:=3; {three !!!, no repaint till new bitmap is updated. Only swipe}
      paint_sky;{rewrite window}
      end;
    end ;
  swipe_mode:=0;
  if ((viewch=false) and (line_drawing_mode=false)) then image1.Cursor := crnormalcursor; {else keep left,up, right down ARROW cursor}
end;

procedure Tmainwindow.image_clock1click(Sender: TObject);
begin
  mainwindow.Enterdatetime1Click(Sender);{enter time & date}
end;

procedure Tmainwindow.Image_clock1MouseEnter(Sender: TObject);
begin
   hint:=Time_reference+': '+today2_UTC;{show with hint UTC or TDT time}
end;

procedure Tmainwindow.Image_north1Click(Sender: TObject);
begin
   mainwindow.Northabove1Click(Sender);
end;

procedure Tmainwindow.Image_starscale1Click(Sender: TObject);
begin
  mainwindow.Objects1Click(Sender);{object menu}
end;

procedure update_telescope_menu(on1: boolean);
begin
  mainwindow.connect_telescope1.checked:=on1; {enable popupmenu1 options}
  mainwindow.Telescopetomouseposition1.enabled:=on1;{mouse menu make enable instead of disabled}
  mainwindow.telescope_synctomouse1.enabled:=on1;
  mainwindow.telescope_abort1.enabled:=on1;
  mainwindow.telescope_aborttoolbutton.enabled:=on1;
  mainwindow.tracktelescope1.enabled:=on1;
  mainwindow.park_unpark1.enabled:=on1;
  if on1 then telescope_position:='   Telescope connected' else  telescope_position:='';
end;

procedure Tmainwindow.Load1Click(Sender: TObject);  {load status}
begin
  opendialog1.initialdir:=documents_path;
  opendialog1.title:=Open_status_title;
  opendialog1.filter:='Hnsky settings *.hns|*.hns';
  if opendialog1.execute then
  begin
     filename:=opendialog1.filename;
     load_settings(0 {no time action});
     objectmenu.FormCreate(nil);{update the info in objectmenu based on *.hns file}

     loaddeep;        {hns could have a different deepsky setting, so reload}
     loadsupplement1; {could be different so update}
     loadsupplement2;
     loadsupplement3;
     loadsupplement4;
     loadsupplement5;
     loadtoast;
      {object windows=>} invalidaterect(objectmenu.handle,nil,true); {update OBJECTmenu window}

      Missedupdate:=2;
      paint_sky; {required to display extra selected supplements}

  end;
end;
procedure Tmainwindow.loadevent1Click(Sender: TObject);
begin
  opendialog1.initialdir:=documents_path;
  opendialog1.title:=Open_event_title;
  opendialog1.filter:='Hnsky settings *.hns|*.hns';
  if opendialog1.execute then
  begin
     filename:=opendialog1.filename;
     load_settings(2);{load event with original time}
     objectmenu.FormCreate(nil);{update the info in objectmenu based on *.hns file}

     loaddeep;        {hns could have a different deepsky setting, so reload}
     loadsupplement1; {could be different so update}
     loadsupplement2;
     loadsupplement3;
     loadsupplement4;
     loadsupplement5;
     loadtoast;

     {object windows=>} invalidaterect(objectmenu.handle,nil,true); {rewrite OBJECTmenu window}
     Missedupdate:=2;
     paint_sky;    {required to display extra selected supplements}
  end;
end;

procedure Tmainwindow.export_frames_via_server1Click(Sender: TObject);
begin
    export_frames:=true;{export via plotting supplement2}
    missedupdate:=1;
    paint_sky; {frames will be send while plotting supplement 2}
    export_frames:=false;{export only once}
end;



procedure Tmainwindow.Help1Click(Sender: TObject);
begin
  open_file(help_path);
end;

procedure Tmainwindow.Hide_menuClick(Sender: TObject);
begin
  if hide_mainmenu=0 then
  begin
    hide_mainmenu:=1;{off}
    mainwindow.field1.visible:=true;{recover after switching from hide to normal}
    mainwindow.az_m1.visible:=true;
    mainwindow.az_m2.visible:=true;
    mainwindow.alt_m1.visible:=true;
    mainwindow.alt_m2.visible:=true;
  end
  else
  begin
    hide_mainmenu:=0;
  end;
  missedupdate:=2;
  menu_changed:=true;
  paint_sky; {{rewrite window 2017-9-29}
  {hide_mainmenu:  0 is hide, 1 is visible all the time. Use as multiplier in height calculation}
end;

procedure Tmainwindow.Hide_textClick(Sender: TObject);
begin
  if sender=hide_text then
  begin
    if hide_mainmenu_text in [0,2] then begin hide_mainmenu_text:=1;{off}  end else begin hide_mainmenu_text:=0; end;
  end
  else
  begin {sender hideicons1}
    if hide_mainmenu_text in [0,1] then begin hide_mainmenu_text:=2;{off}  end else begin hide_mainmenu_text:=0; end;
  end;
  missedupdate:=2;
  menu_changed:=true;
  paint_sky; {{rewrite window }
end;

procedure Tmainwindow.About1Click(Sender: TObject);
var
  jul, bericht2, bericht3, about_message10,about_message11   : string;
begin
  if sizeof(IntPtr) = 8 then
  about_message10:='  (64 bit version)'
  else
  about_message10:='  (32 bit version)';

 {$IFDEF fpc}
 {$MACRO ON} {required for FPC_fullversion}
  about_message11:='(compiler: Free Pascal compiler '+inttoStr(FPC_version)+'.'+inttoStr(FPC_RELEASE)+'.'+inttoStr(FPC_patch)+', Lazarus IDE '+lcl_version+')';

 {$ELSE} {delphi}
  about_message11:='';
 {$ENDIF}


  str(julian_UT:7:5,jul);
  bericht2:=prepare_ra2(2*pi*frac(julian_UT+0.5)); {radialen to text  format 24: 00}

  bericht3:=
  about_message0+about_message10+
  #13+#10+
  #13+#10+about_message11+
  #13+#10+
  #13+#10+about_message1+
  #13+#10+about_message2+
  #13+#10+
  #13+#10+about_message3+
  #13+#10+about_message4+
  #13+#10+
  #13+#10+about_message5+': '+Time_reference+':   '+bericht2+', Julian day:   '+jul;
  application.messagebox(pchar(bericht3),pchar(about_title),MB_OK);
end;

procedure Tmainwindow.IN1Click(Sender: TObject);
begin
  zoom_in(1.4);
end;

{$IFDEF fpc}
procedure Tmainwindow.indi_client1Click(Sender: TObject);
begin
  indi.visible:=true;
  indi.setfocus;
end;

procedure Tmainwindow.home1Click(Sender: TObject);
begin
   {to undo, set tracking on and move to a location}
  {$ifdef mswindows}
   if telescope_interface='A' then
   begin
     try
     ascom_mount.Findhome
     except
        Showmessage(error_string+', Home');
     end;
  end;
  {$else} {unix}
  {$endif}
  if telescope_interface='C' then
  begin
    alpaca_communication_counter:=0; {force a quick status read}
    alpaca_put_string('findhome','');{put for tracking=true or false, abort,findhome, park}
  end;
end;

procedure Tmainwindow.OpenDialog1Close(Sender: TObject);
begin
   oldx:=-9999;{kill any rubber band behaviour, for example double clicked on file after load event}
end;
{$ENDIF}

procedure Tmainwindow.park1Click(Sender: TObject);
begin
 {$ifdef mswindows}
  if telescope_interface='A' then
  begin
    try
    if park1.checked=false then
      ascom_mount.Park
    else
    begin
       ascom_mount.UnPark;
       ascom_mount.Tracking:=true;{set tracking on}
    end;
    except
       Showmessage(error_string+', Park/Unpark');
    end;
  end;
 {$else} {unix}
 {$endif}

  if telescope_interface='C' then
  begin
    alpaca_communication_counter:=0; {force a quick status read}
    if park1.checked=false then
        alpaca_put_string('park','') {put for tracking=true or false, abort,findhome, park}
     else
     begin
       alpaca_put_string('unpark','');{put for tracking=true or false, abort,findhome, park}
       alpaca_put_string('tracking','tracking=true');{set tracking on}  {put for tracking=true or false, abort,findhome, park}
     end;
  end;

 {$IFDEF fpc}
  if telescope_interface='I' then
  begin
    if park1.checked=false then
      sendmessage2('<newSwitchVector device="'+INDI_telescope_name+'" name="TELESCOPE_PARK"><oneSwitch name="PARK">On</oneSwitch><oneSwitch name="UNPARK">Off</oneSwitch></newSwitchVector>')
      else
      begin
        sendmessage2('<newSwitchVector device="'+INDI_telescope_name+'" name="TELESCOPE_PARK"><oneSwitch name="PARK">Off</oneSwitch><oneSwitch name="UNPARK">On</oneSwitch></newSwitchVector>');
        sendmessage2('<newSwitchVector  device="'+INDI_telescope_name+'" name="ON_COORD_SET">  <oneSwitch name="TRACK">On</oneSwitch> </newSwitchVector>');{telescope tracking on and therefore sync is off}
      end;
  end;
 {$ELSE} {delphi}
 {$ENDIF}
end;

procedure Tmainwindow.right1Click(Sender: TObject);
begin
  mainwindow.GotoRADEC1Click(Sender);exit;{goto RA,DEC menu}
end;

procedure Tmainwindow.right7Click(Sender: TObject);
begin
  if ((found_mode>=1) and (found_mode<=9)) then {allow edit of supplement}
  Editobject1Click(nil);
end;

procedure Tmainwindow.SaveDialog1Close(Sender: TObject);
begin
  oldx:=-9999;{kill any rubber band behaviour, for example double clicked on file after load event}
end;

procedure Tmainwindow.setpark1Click(Sender: TObject);
begin
  {$ifdef mswindows}
   if telescope_interface='A' then
   begin
     try
     ascom_mount.SetPark;
     except
        Showmessage(error_string+', SetPark');
     end;
   end;
  {$else} {unix}
  {$endif}
   if telescope_interface='C' then alpaca_put_string('setpark','');{put for tracking=true or false, abort,findhome, park}

  {$IFDEF fpc}
   if telescope_interface='I' then
   begin
     sendmessage2('<newSwitchVector device="'+INDI_telescope_name+'" name="TELESCOPE_PARK_OPTION"><oneSwitch name="PARK_CURRENT">On</oneSwitch></newSwitchVector>');  {set position}
     sendmessage2('<newSwitchVector device="'+INDI_telescope_name+'" name="TELESCOPE_PARK_OPTION"><oneSwitch name="PARK_WRITE_DATA">On</oneSwitch></newSwitchVector>');{save data}
   end;
  {$ELSE} {delphi}
  {$ENDIF}
end;

procedure Tmainwindow.OUT1Click(Sender: TObject);
begin
  zoom_out(1.4);
end;

procedure Tmainwindow.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var   zoomfactor, scrollfactor2 : double;
begin
  {in linux, mainwindow.keypreview must be on !!!!}
  FOUND:=0;
  hns_keydown:=0;

  if (
    (key=vk_ESCAPE ) or   {esc}
    (key=vk_F1))
  then begin  hns_keydown:=1;
  end
  else
  if key=mainwindow.MinF3.shortcut then begin  hns_keydown:=2; end
  else
  if key=mainwindow.MinF4.shortcut then begin  hns_keydown:=2 end
  else
  if key=mainwindow.hourF5.shortcut then begin hns_keydown:=2; end
  else
  if key=mainwindow.hourF6.shortcut then begin hns_keydown:=2 end
  else
  if key=mainwindow.dayF7.shortcut then begin hns_keydown:=2; end
  else
  if (key=mainwindow.dayF8.shortcut) then begin hns_keydown:=2 end
  else
  if (key=mainwindow.N2356F11.shortcut) then begin hns_keydown:=2; end
  else
  if (key=mainwindow.N2356F12.shortcut) then begin hns_keydown:=2 end
  else
  if (key=vk_up) then
  begin
    hns_keydown:=2;
    if (Shift = [ssCtrl]) then scrollfactor2:=0.1 else scrollfactor2:=1;  {ctrl+arrow slow scroll}
    if mainwindow.active=true then {for object menu to prevent scrolling wenn using arrow keys}
    viewy:=limit_radialen(viewy+flipv*scrollsize*scrollfactor2/(zoom+3/zoom),2*pi);  {(zoom+3/zoom) always slow scroll at low zoom factors}
  end
  else
  if key=vk_down then
  begin
    hns_keydown:=2;
    if (Shift = [ssCtrl]) then scrollfactor2:=0.1 else scrollfactor2:=1; {ctrl+arrow slow scroll}
    if mainwindow.active=true then {for object menu to prevent scrolling wenn using arrow keys}
      viewy:=limit_radialen(viewy-flipv*scrollsize*scrollfactor2/(zoom+3/zoom),2*pi);   {(zoom+3/zoom) always slow scroll at low zoom factors}
  end
  else
  if (key=vk_left) then
  begin
    hns_keydown:=2;
    if (Shift = [ssCtrl]) then scrollfactor2:=0.1 else scrollfactor2:=1; {ctrl+arrow slow scroll}
    if mainwindow.active=true then {for object menu to prevent scrolling wenn using arrow keys}
       viewx:=limit_radialen(viewx-fliph*scrollsize*scrollfactor2/(zoom+3/zoom),2*pi); {(zoom+3/zoom) always slow scroll at low zoom factors}
  end
  else
  if (key=vk_right) then
  begin
    hns_keydown:=2;
    if (Shift = [ssCtrl]) then scrollfactor2:=0.1 else scrollfactor2:=1;
    if mainwindow.active=true then {for object menu to prevent scrolling wenn using arrow keys}
      viewx:=limit_radialen(viewx+fliph*scrollsize*scrollfactor2/(zoom+3/zoom),2*pi);
  end
  else
  if (key=vk_add) then
  begin
    if (Shift = [ssCtrl]) then inctime2((23+56/60+4/3600)/24) {23:56}
    else
    inctime2(1/24);
    hns_keydown:=2;
  end
  else
  if key=vk_subtract then
  begin
    if (Shift = [ssCtrl]) then inctime2(-(23+56/60+4/3600)/24) {23:56}
    else
    inctime2(-1/24);
    hns_keydown:=2;
  end
  else
  if (key=vk_next) then {pagedown}
  begin
    if (Shift = [ssCtrl]) then zoomfactor:=1.01 else zoomfactor:=1.4;
    if mainwindow.active=true then {for object menu to prevent scrolling wenn using arrow keys}
    begin zoom_in(zoomfactor); hns_keydown:=0; {repaint is done from zoom_in} end;
  end
  else
  if (key=vk_prior) then {pageup}
  begin
    if (Shift = [ssCtrl]) then zoomfactor:=1.01 else zoomfactor:=1.4;
    if mainwindow.active=true then {for object menu to prevent scrolling wenn using arrow keys}
    begin zoom_out(zoomfactor);hns_keydown:=0; {repaint is done from zoom_in}end;
  end
  else
  if (key=vk_space) then
     hns_keydown:=1 {redraw screen.}
  else
  begin
  end;
  if  ((hns_keydown<>0)) then
  begin
    missedupdate:=2;
    paint_sky;{restart again}
  end;
end;

procedure Tmainwindow.Savesettings1Click(Sender: TObject);
begin
  filename:=documents_path+default_hns;
  save_settings;
end;

procedure Tmainwindow.Saveas1Click(Sender: TObject);
begin
  savedialog1.initialdir:=documents_path;
  savedialog1.title:=Save_status_title;
  if savedialog1.execute then
  begin
     filename:=savedialog1.filename;
     save_settings;
  end;
end;
procedure Tmainwindow.DisplayHint(Sender: TObject);
begin
  mainwindow.statusbar1.caption:=StringReplace(Application.Hint, #13, ' ',[rfReplaceAll]);
end;

procedure Tmainwindow.Drawsolarobjecttracks1Click(Sender: TObject);
begin
  done_tracks:=false;{allow plotting tracks in the end of maak_plaatje}
  locknaam2:='';{otherwise strange things happen}
  missedupdate:=3;
   paint_sky; {{rewrite window }
end;

procedure Tmainwindow.Search1Click(Sender: TObject);
begin
  center_on.visible:=true;
  center_on.setfocus;
end;

procedure Tmainwindow.Showstatusbar1Click(Sender: TObject);
begin
  if statusbar1.visible=true then
  begin
    statusbar1.visible:=false;
  end else statusbar1.visible:=true;
  missedupdate:=2;
  paint_sky;
end;

procedure Tmainwindow.settings1click(Sender: TObject);
begin
  settings:=Tsettings.Create(self);
  settings.ShowModal;
  settings.Free;
  settings:=nil;{to be sure to detect if not vissible}
  clear_FastBitmap(fastbitmap1,colors[0]);{clear/fill fastbitmap pixels with outcolor for case it is changed color}
  if missedupdate<>0 then paint_sky;
end;

procedure Tmainwindow.Reset1Click(Sender: TObject);
begin
  if projection=0 then zoom:=0.9 else zoom:=0.9/(pi/2);
  northtop:=0;{switch off north up}
  if projection=0 then  viewy:=0 else  viewy:=pi/2;

  if north=1 then begin viewx:=pi; end
            else  begin viewx:=0; end;

  wtime2:=wtime2actual;{set world straight up}
  missedupdate:=2;
  paint_sky; {rewrite window}
end;

procedure Tmainwindow.Enterdatetime1Click(Sender: TObject);
begin
  settime.visible:=true;
  settime.setfocus;
end;

procedure Tmainwindow.NowF9Click(Sender: TObject);
begin
  getdatetime(true,false);
  actualtime:=false;
  missedupdate:=2;
  paint_sky; {{rewrite window }
end;

procedure Tmainwindow.Timer_delayed_start_serverTimer(Sender: TObject);
begin {Start host server delayed otherwise the indi client get's connected event with server}
  Timer_delayed_start_server.enabled:=false;
  server_on:=switch_server_onoff(server_on);{try to switch if required}

  if ((telescope_interface='C') and (mainwindow.connect_telescope1.Checked {setpoint})) then {delayed connection alpaca client}
    {alpaca_connected:=}switch_alpaca_client_onoff(true);

end;

procedure Tmainwindow.tracking1Click(Sender: TObject);
begin
  {$ifdef mswindows}
  if telescope_interface='A' then
  begin
  try
    ascom_mount.Tracking:=tracking1.Checked=false;{set tracking on/off}
    except
      Showmessage(error_string+', Tracking');
    end;
  end;
  {$else} {unix}
  {$endif}
  if telescope_interface='C' then
  begin
     alpaca_communication_counter:=0; {force a quick status read}
     if tracking1.Checked then
       alpaca_put_string('tracking','tracking=false') {put for tracking=true or false, abort,findhome, park}
     else
       alpaca_put_string('tracking','tracking=true'); {put for tracking=true or false, abort,findhome, park}
  end;
end;

procedure Tmainwindow.Usesystemtime1Click(Sender: TObject);
begin
  if actualtime=true then
  begin
    actualtime:=false;
  end
  else
  begin
    actualtime:=true;
    getdatetime(true,false);
  end;
  missedupdate:=2;
  paint_sky; {{rewrite window }
end;

procedure Tmainwindow.Tonight1Click(Sender: TObject);
begin
  actualtime:=false;
  getdatetime(true,true);
  wtime2:=wtime2actual; {2015, set world straight up if no time function keys F3, F4, ... are pressed}
  missedupdate:=2;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Fliphorizontal1click(Sender: TObject);
begin
  if fliph=1 then fliph:=-1 else fliph:=1;
  missedupdate:=2;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Flipvertical1Click(Sender: TObject);
begin
  if flipv=1 then flipv:=-1 else flipv:=1;
  missedupdate:=2;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Constellations1Click(Sender: TObject);
begin
  if constellat>0 then begin constellat:=-1; missedupdate:=2; end else begin constellat:=1;missedupdate:=1;end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Boundaries1Click(Sender: TObject);
begin
  if boundaries>0 then begin boundaries:=-1; missedupdate:=2;end else begin boundaries:=1;missedupdate:=1;end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Showmoonorbits1Click(Sender: TObject);
begin
  if show_orbit<>0 then begin show_orbit:=0;missedupdate:=2; end else begin show_orbit:=1;missedupdate:=1;end;
  paint_sky; {rewrite window }
end;


procedure Tmainwindow.Deepskycontoursonly1Click(Sender: TObject);
begin
 if contour_only=0 then begin contour_only:=1;missedupdate:=2;end else begin contour_only:=0;missedupdate:=1;end;
 paint_sky; {rewrite window }
end;

procedure Tmainwindow.Orthographic_projection1Click(Sender: TObject);
begin
  if projection=2 then northtop:=old_northtop2; {restore old settings after cylindrical projection}
  projection:=0;
  missedupdate:=2;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Azimuthalequidistant1Click(Sender: TObject);
begin
  if projection=2 then northtop:=old_northtop2; {restore old settings after cylindrical projection}
  projection:=1;
  missedupdate:=2;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Cylindrical1Click(Sender: TObject);
begin
  old_northtop2:=northtop;{store for going back to projection 0, 1}
  projection:=2;
  missedupdate:=2;
  paint_sky; {rewrite window }
end;

procedure Copytoclipboard(formX:Tform);{copy the image1.canvas from a Form to the clipboard}
var
  bm: TBitmap;
begin
  bm := TBitmap.Create;
  try
    bm.SetSize(formX.ClientWidth, formX.ClientHeight);
    Bm.canvas.CopyRect(Rect(0, 0, formX.ClientWidth, formX.ClientHeight), formX.canvas, Rect(0, 0, formX.ClientWidth, formX.ClientHeight));
    Clipboard.Assign(bm); {copy to clipboard}
  finally
    bm.Free;
  end;
end;

procedure Tmainwindow.Copywindowtoclipboard1Click(Sender: TObject);
begin
  Copytoclipboard(mainwindow);
end;

procedure Tmainwindow.Databases1Click(Sender: TObject);
var br,mes0,mes1s,mes2s,mes3s,mes4s,mes5s,mes3,mes4 : string;
begin
  if deep_database=0 then mes0:=disabled_mess else mes0:='';
  if suppl1_activated=0 then mes1s:=disabled_mess else mes1s:='';
  if suppl2_activated=0 then mes2s:=disabled_mess else mes2s:='';
  if suppl3_activated=0 then mes3s:=disabled_mess else mes3s:='';
  if suppl4_activated=0 then mes4s:=disabled_mess else mes4s:='';
  if suppl5_activated=0 then mes5s:=disabled_mess else mes5s:='';
  if stars_activated=0  then mes3:=disabled_mess else mes3:='';

  {0 .dat star database}
  {32 .290 star database}
  {1,2,3,4, GSC, UCAC4....}

  mes4:=stars_external_hint[stars_external_index{+1}  {objectmenu.stars_external.ItemIndex+1}];
  if ((stars_activated=0) or (stardatabase_selected=0)  or (stardatabase_selected=290) ) then mes4:=disabled_mess+mes4;

   br:=      (            '1) '+mes0+deepstring.strings[0]
         +#13+#10+#13+#10+'2) '+mes3+ uppercase(copy(name_star, 1, 3))+' '+copy(database2,1,108) {primary star database. Do not display last byte (110) used for record type. Byte 109 is used for maximum magnitude}
         +#13+#10+#13+#10+'3) '+mes4            {secondary star database}
         +#13+#10+#13+#10+'4) Comets file dated: '+cometfile_age
         +#13+#10+#13+#10+'5) Asteroids file dated: '+asteroidfile_age
         +#13+#10+#13+#10+'6) '+mes1s+supplstring1.strings[0]
         +#13+#10+#13+#10+'7) '+mes2s+supplstring2.strings[0]
         +#13+#10+#13+#10+'8) '+mes3s+supplstring3.strings[0]
         +#13+#10+#13+#10+'9) '+mes4s+supplstring4.strings[0]
        +#13+#10+#13+#10+'10) '+mes5s+supplstring5.strings[0]);

    br:=StringReplace(br, ';', ' ',[rfReplaceAll{, rfIgnoreCase}]);
  application.messagebox(pchar(br),pchar(selected_databases),MB_OK);
end;

procedure Tmainwindow.GotoRADEC1Click(Sender: TObject);
begin
  move_to.visible:=true;
  move_to.setfocus;
end;

procedure Tmainwindow.cometdataeditorClick(Sender: TObject);
begin
  editfile:=0;
  edit2:=Tedit2.Create(self); {in project option not loaded automatic}
  edit2.ShowModal;
  edit2.release;
  missedupdate:=2; {rewrite window}
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.AsteroiddataeditorClick(Sender: TObject);
begin
  editfile:=1;
  edit2:=Tedit2.Create(self); {in project option not loaded automatic}
  edit2.ShowModal;
  edit2.release;
  update_mag:=true; {recalculate asteroid magnitude since data could be changed}
  missedupdate:=2; {rewrite window}
  paint_sky; {rewrite window }
end;


procedure inverse_intensity_color(incolor:integer;var outcolor:integer);{keep color=hue but inverse intensity. By han Kleijn}
{The HSB model is based on the human perception of color. In the HSB model, all colors are described in terms of three fundamental characteristics:
  Hue is the wavelength of light reflected from or transmitted through an object. More commonly, hue is identified by the name of the color, such as red, orange, or green. Hue is measured as a location on the standard color wheel and expressed as a specific angle between 0° and 360°.
  Saturation, sometimes called chroma, is the strength or purity of the color. Saturation represents the amount of gray in relation to the hue and is measured as a percentage from 0 percent (gray) to 100 percent (fully saturated).
  Brightness is the relative lightness or darkness of the color and is usually measured as a percentage from 0 percent (black) to 100 percent (white).}

var i,max,r,g,b: double;
begin
  r:=getrvalue(incolor);
  g:=getgvalue(incolor);
  b:=getbvalue(incolor);

  if r>g then max:=r else max:=g;
  if b>max then max:=b;

  if max<1 then
  begin
    r:=255;{black should become white}
    g:=255;
    b:=255;
  end
  else
  begin {normal}
    i:=255-max;
    r:=r*i/max;
    g:=g*i/max;
    b:=b*i/max;
  end;
  outcolor:=rgb(round(r),round(g),round(b));
end;
procedure negative;
var i:integer;
begin
 if inverse=false then
 begin
    Move(colors,colorsinverse,SizeOf(colorsinverse));
    for i:=0 to length(colors)-1 do
         inverse_intensity_color(colors[i],colors[i]);
    inverse:=true;
 end
 else
 begin
   Move(colorsinverse,colors,SizeOf(colors));{restore old situtatIon}
   inverse:=false;
 end;
 delete_penbrush;
 prepare_penbrush;
end;

procedure Tmainwindow.Printwindowwhitesky1Click(Sender: TObject);
var
    oldimage_overlap: integer;
begin
  screen.cursor := crhourglass;{this will take some time}
  Printer.Orientation:=poLandscape;
  if PrintersetupDialog1.execute then
  begin
     printing:=true; {do not update screen because colors inverse}
     Printer.BeginDoc;

     rrw.left:=0;
     rrw.top:=0;
     rrw.bottom:=printer.Pageheight;
     rrw.right:=printer.PageWidth;

     inverse_printing:=false;
     if (  ((sender=Printwindowwhitesky1){make white sky} and(colors[0]=0)) or
           ((sender=Printwindowblacksky1) {make black sky} and (colors[0]<>0)) ) then
     begin
       negative;
       inverse_printing:=true;
     end;
     oldimage_overlap:=image_overlap;
     image_overlap:=0;

     FillRect(printer.canvas.handle,Rect(0,0,printer.Pagewidth,printer.Pageheight),brushb);{make everything black, otherwise like glass !!}
     maakplaatje(printer.canvas,false); {instead of normally mainwindow.image1.canvas}

     image_overlap:=oldimage_overlap;

     if inverse_printing then  negative;{restore old situation}
     printing:=false;{updating screen allowed, color and bold correct}

  Printer.EndDoc;
  end;
  screen.cursor := crdefault;

  missedupdate:=2;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Printwindowblacksky1Click(Sender: TObject);
begin
  Printwindowwhitesky1Click(Sender);
end;

procedure Tmainwindow.Timer1Timer(Sender: TObject);
var
  mon,day,hou,mi,sec  : STRING[2];
  year3               : STRING[4];
  timedifference      : integer;
  active_file_settings,JPL_DE  : string;
  {$ifdef mswindows}
  SystemTime: tSystemTime;
  {$else}
  {$endif}

begin
  {$ifdef fpc}
  {indi actions}
  if ((telescope_interface='I') and  (connect_during_creation>0)) then {this doesn't work in oncreate in indiform, it freezes keyboard and grahpic. It works however timer based or on onshow}
  begin
    {first step}
    if connect_during_creation=2 then
    begin
      try
      indi_server_connecting:= indi.INDI_client.Connect(indi_server_address,strtoint(indi_Port));{localhost, 7624}
      except
        indi_server_connecting:=false;
      end;
    end
    else
    indi_server_connecting:=false; {remove yellow color}
    application.processmessages; {wait a little}
    {connect INDI telescope driver}
    {second step }
    if ((connect_during_creation=1) and (indi_server_connected)) then connect_indi_device(indi_telescope_name);    {update_telescope menu is done procedure extract_indi_switches(s:string);}

    dec(connect_during_creation);{step done}
  end;

  if indi_telescope_connected then
         process_telescope_position(ra_indi_telescope_hours*pi/12,dec_indi_telescope_degrees*pi/180,equinox_indi);{call INDI telescope cursor procedure existing position (blinking)}
 {end indi actions}
 {$endif}


  active_file_settings:=ExtractFileName(FileName);
  if active_file_settings=default_hns then  active_file_settings:=''
                                      else  active_file_settings:=active_file_settings+' - ';

  if ((clock<>0) or (actualtime)) then
  {$ifdef mswindows}
  GetLocalTime(SystemTime);
  {$else}
  {$endif}

  if clock<>0 then
  begin
    {$ifdef mswindows}
    str(systemtime.wyear:4,year3);
    mon:=leadingzero(systemtime.wmonth);
    day:=leadingzero(systemtime.wday);
    hou:=leadingzero(systemtime.whour);
    mi:=leadingzero(systemtime.wminute);
    sec:=leadingzero(systemtime.wsecond);
    {$else}
    str(yearof(date):4,year3);
    mon:=leadingzero(monthof(date));
    day:=leadingzero(dayof(date));
    hou:=leadingzero(hourof(time));
    mi:=leadingzero(minuteof(time));
    sec:=leadingzero(secondof(time));
   {$endif}
    if de430_loaded then JPL_DE:=',    DE' else JPL_DE:='';
    mainwindow.caption:=active_file_settings +'Hallo northern sky   '+
                   year3+'-'+mon+'-'+day+'  '+hou+':'+mi+':'+sec+telescope_position+drive_status+JPL_DE+',   '+stardatabase_displayed_naam;
  end
  else
    mainwindow.caption:=active_file_settings+'Hallo northern sky   '+telescope_position+drive_status ;

  {$ifdef mswindows}
  if ((actualtime) and  ((systemtime.wsecond=0)or (timestep=0){for update every second}) ) then
  {$else}
  if ((actualtime) and  ((secondof(time)=0) or (timestep=0){for update every second}) ) then
  {$endif}

  begin
    if ((getkeystate(vk_lbutton)<0) or (missedupdate<>0) or (size_pulled_rectangle<>0)   {popup active}) then exit;{ 2016 do not update  when mouse is  pulling square or popup is visible}

    {$ifdef mswindows}
    timedifference:=trunc(fnmodulo(systemtime.wminute - min2,60));
    {$ELSE} {}
    timedifference:=trunc(fnmodulo(minuteof(time) - min2,60));
    {$endif}

    if ((timedifference>=timestep) or (timedifference=0)) {0 for every 60 minutes !}then
    begin
      getdatetime(actualtime,false);
      missedupdate:=2;
      paint_sky; {rewrite window }
    end;
  end;
//  if new_user then CHECK_NEW_USER;{default.hns not found or longitude=0 latitude=50 (in the sea)} {For linux this message not in an ONpaint event since the messagebox will be grey.}
end;

procedure Tmainwindow.Showclock1Click(Sender: TObject);
begin
  if clock=0 then clock:=1 else clock:=0;
  Showclock1.checked:=clock<>0; {here also because no rewrite screen}
end;

procedure Tmainwindow.SupplementeditorClick(Sender: TObject);
begin
   mainwindow.image1.cursor:=crwaitcursor;{new 2016}
  if ((sender=Supplement1editor) or (sender=objectmenu.supl1)) then editfile:=2 else
  if ((sender=Supplement2editor) or (sender=objectmenu.supl2)) then editfile:=3 else
  if ((sender=Supplement3editor) or (sender=objectmenu.supl3)) then editfile:=4 else
  if ((sender=Supplement4editor) or (sender=objectmenu.supl4)) then editfile:=5 else
  editfile:=6;

  edit2:=Tedit2.Create(self); {in project option not loaded automatic}
  edit2.ShowModal;
  edit2.release;
  missedupdate:=2; {rewrite window}
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Objecthints1Click(Sender: TObject);
begin
 if hints=0 then
 begin
   hints:=1;
   missedupdate:=1;
   paint_sky; {rewrite window }
 end
 else
 begin
   hints:=0;
   objecthints1.checked:=false; {here because no menu update}
 end;
end;

procedure Tmainwindow.Objects1Click(Sender: TObject);
begin
  objectmenu.visible:=true;
  objectmenu.setfocus;
end;

procedure Tmainwindow.Measuringframe1Click(Sender: TObject);
begin
  if mframe<>0 then
  begin
    mframe:=0;
  end
  else
  begin
    mframe:=1;
    oldx:=-999;
  end;
  measuringframe1.checked:=mframe<>0;
  missedupdate:=1;
  paint_sky; {rewrite window }
end;

procedure ShowHTMLHelp(const HelpString: String); {get html help keyword, idea by Jan Goyvaerts, 2004 for delphi 6, 7}
{$ifdef mswindows}
{$IFDEF fpc}
type
 { begin Lazarus type specification, not required in Delphi}
  tagHH_AKLINK = packed record
        cbStruct : longint;              { sizeof this structure }
        fReserved : BOOL;                { must be FALSE (really!) }
        pszKeywords : LPCTSTR;           { semi-colon separated keywords }
        pszUrl : LPCTSTR;                { URL to jump to if no keywords found (may be NULL) }
        pszMsgText : LPCTSTR;            { Message text to display in MessageBox if pszUrl is NULL and no keyword match }
        pszMsgTitle : LPCTSTR;           { Message text to display in MessageBox if pszUrl is NULL and no keyword match }
        pszWindow : LPCTSTR;             { Window to display URL in }
        fIndexOnFail : BOOL;             { Displays index if keyword lookup fails. }
     end;
   HH_AKLINK = tagHH_AKLINK;
  {end lazarus Type specification}

{$ENDIF}
var
  AKLink: HH_AKLink;
begin
  AKLink.cbStruct := SizeOf(AKLink);
  AKLink.fReserved := False;
  AKLink.pszKeywords := PChar(HelpString);
  AKLink.pszURL := nil;
  AKLink.pszMsgText := nil;
  AKLink.pszMsgTitle := nil;
  AKLink.pszWindow := nil;
  AKLink.fIndexOnFail := True;
 {$IFDEF fpc}
  HTMLHelpA(0, pchar(application_Path+'deepsky.chm'), HH_KEYWORD_LOOKUP, Integer(@AKLink)); {FPC solution}
 {$ELSE}
  HTMLHelp(0, application_Path+'deepsky.chm', HH_KEYWORD_LOOKUP, Integer(@AKLink));{Delphi solution}
 {$ENDIF}
end;
{$ELSE} {Linux HTML help}
var
  AProcess: TProcess;
const
     chmviewer='/usr/bin/kchmviewer';
begin
  if fileexists(chmviewer)=false then begin application.messagebox(pchar('Could not find program kchmviewer !!, Install this program. Eg: sudo apt-get install kchmviewer' ),pchar('Error'),MB_ICONWARNING+MB_OK);;exit; end;

  AProcess := TProcess.Create(nil);
  AProcess.Executable := chmviewer;
  AProcess.Parameters.Add('-index');
  AProcess.Parameters.Add(HelpString);
  AProcess.Parameters.Add(application_Path+'deepsky.chm');
  // AProcess.Options are not set so the program continues after starting the browser}
  AProcess.Execute;
  AProcess.Free;
end;
{$endif}

procedure Tmainwindow.deepskyobservations1Click(Sender: TObject);
begin
  ShowHTMLHelp(deepskyhelpnaam2) {HTMLHELP}
end;

procedure Tmainwindow.Darknights1Click(Sender: TObject);
begin
  darkform:=Tdarkform.Create(self); {in project option not loaded automatic}
  darkform.ShowModal;
  darkform.release;
end;

procedure Tmainwindow.Pointingcircles1Click(Sender: TObject);
begin
  if cross=0 then missedupdate:=1 else missedupdate:=2; {new cross or pointing cicles, check before changing to 1 or 2}
  if cross<>2 then begin cross:=2; end else begin cross:=0; end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Crosshair1Click(Sender: TObject);
begin
  if cross=0 then missedupdate:=1 else missedupdate:=2; {new cross or pointing cicles, check before changing to 1 or 2}
  if cross<>1 then begin cross:=1; end else begin cross:=0;end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Twolinesnorthsouth1Click(Sender: TObject);
begin
  mainwindow.Twolinesnorthsouth1.checked:=mainwindow.Twolinesnorthsouth1.checked=false;
end;

procedure Tmainwindow.Pointingcirclemarker1Click(Sender: TObject);
begin
  if marker_telrad=0 then
  begin
    marker_telrad:=1;
    missedupdate:=1;
  end
  else
  begin
    marker_telrad:=0;
    missedupdate:=2;
  end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Nameofobjectmarker1Click(Sender: TObject);
begin
  if marker_name=0 then missedupdate:=1 else missedupdate:=2;
  if marker_name<>1 then
  begin
    marker_name:=1;
  end
  else
  begin
    marker_name:=0;
  end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Dateandtimemarker1Click(Sender: TObject);
Begin
  if marker_name=0 then missedupdate:=1 else missedupdate:=2;
  if marker_name<>3 then
  begin
    marker_name:=3;
  end
  else
  begin
    marker_name:=0;
  end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Magnitudeofobjectmarker1Click(Sender: TObject);
begin
  if marker_name=0 then missedupdate:=1 else missedupdate:=2;
  if marker_name<>2 then
  begin
    marker_name:=2;
  end
  else
  begin
    marker_name:=0;
  end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Clearmarkers1Click(Sender: TObject);
begin
  markers_position:=0;
  nr_markers:=0;
  loadsupplement2;{clear "home" markers}
   linepoint_counter:=0;{drawing pointer counter to zero, so first point is a move to}
  missedupdate:=2;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.menu_ColorClick(Sender: TObject);
begin
  mainwindow.ColorDialog0.color:=colors[39];{menu background color}
  if mainwindow.ColorDialog0.execute then
  begin
    colors[39]:= mainwindow.ColorDialog0.color;
  end;
   mainwindow.toolbar2.color:=colors[39];
end;

procedure Tmainwindow.GridRADEC1click(Sender: TObject);
begin
  if grid=0 then missedupdate:=1 else missedupdate:=2;{before changing to 1 or 2}
  if grid<>1 then begin grid:=1; end else begin grid:=0;end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.GridAZAlt1Click(Sender: TObject);
begin
  if grid=0 then missedupdate:=1 else missedupdate:=2;{before changing to 1 or 2}
  if grid<>2 then begin grid:=2; end else begin grid:=0;end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Objectinfotoclipboard1Click(Sender: TObject);
begin
  Objectinfotoclipboard1.checked:=Objectinfotoclipboard1.checked=false;
end;

procedure Tmainwindow.Animation1Click(Sender: TObject);
begin
  form_animation.visible:=true;
  form_animation.setfocus;
end;

procedure Tmainwindow.telescope_abort1Click(Sender: TObject);
begin
  {$ifdef mswindows}
  if telescope_interface='A' then
  begin
    if (ascom_mount.connected) then {allow export}
    begin
      try
        ascom_mount.AbortSlew;
      except
         on E: Exception do
         begin
           beep;
           application.messagebox(pchar(E.Message),'ASCOM returns following error:',MB_ICONWARNING+MB_OK); {show error from driver error, for example below horizon}
         end;
      end;
    end;
  end;
  {$else} {unix}
  {$endif}
  if telescope_interface='C' then alpaca_put_string('abortslew','');{put for tracking=true or false, abort,findhome, park}

  {$ifdef fpc}
  if telescope_interface='I' then
    sendmessage2('<newSwitchVector device="'+INDI_telescope_name+'" name="TELESCOPE_ABORT_MOTION"><oneSwitch name="ABORT_MOTION">On</oneSwitch></newSwitchVector>');
  {$else} {delphi}
   ;
  {$endif}
end;

procedure Tmainwindow.telescope_synctomouse1Click(Sender: TObject);
var
    Target_ra, Target_dec        : double;
    s1,s2                        : string;

begin
  Target_ra :=mouse_ra;{mouse position is target}
  Target_dec:=mouse_dec;

  if equinox_telescope=0 then ep(2000,equinox_date, Target_ra, Target_dec,Target_ra, Target_dec) {convert equinox2000 map to astrometric/date}
  else
  if equinox_telescope<>2000 then ep(2000,equinox_telescope, Target_ra, Target_dec,Target_ra, Target_dec); {convert equinox2000 map to telescope equinox}

  Target_ra :=(Target_ra)*12/pi;
  Target_dec:=(Target_dec)*180/pi;
  if Target_dec>90 then Target_dec:=90 else if Target_dec<-90 then Target_dec:=-90;{exceptions above 90 will occur}

  {$ifdef mswindows}
  if telescope_interface='A' then
  begin {ascom telescope connection}
    if (ascom_mount.connected) then {allow sync}
    begin

     try
      ascom_mount.SyncToCoordinates(Target_ra, Target_dec);
      except
         on E: Exception do
         begin
           beep;
           application.messagebox(pchar(E.Message),'ASCOM returns following error:',MB_ICONWARNING+MB_OK); {show error from driver error, for example below horizon}
           exit;
         end
      end;
    end;
  end;
  {$else} {unix}
  {$endif}


  if telescope_interface='C' then alpaca_put_generic('synctocoordinates',target_ra,target_dec);{slewtocoordinates or synctocoordinates}

  {$ifdef fpc}
  if telescope_interface='I' then {indi telescope connection}
  begin
    str(target_ra:0:6,s1);{here direct after plot grid to get latest ra,dec}
    str(target_dec:0:6,s2);
    sendmessage2('<newSwitchVector  device="'+INDI_telescope_name+'" name="ON_COORD_SET"> <oneSwitch name="SYNC">On</oneSwitch></newSwitchVector>');{sync on}
    sendmessage2('<newNumberVector  device="'+INDI_telescope_name+'" name="EQUATORIAL_EOD_COORD">  <oneNumber name="RA">'+s1+'</oneNumber>  <oneNumber  name="DEC">'+s2+'</oneNumber></newNumberVector>');{sync}
    sendmessage2('<newSwitchVector  device="'+INDI_telescope_name+'" name="ON_COORD_SET">  <oneSwitch name="TRACK">On</oneSwitch> </newSwitchVector>');{telescope tracking on and therefore sync is off}
  end;
  {$else} {delphi}
  {$endif}

end;

procedure export_to_telescope(ra5,dec5 :double); {export position to telescope}
var
    Target_ra, Target_dec        : double;
    s1,s2                        : string;
begin
  if (mainwindow.connect_telescope1.Checked)=false then exit;


  {$ifdef fpc}
  if telescope_interface='I' then {export to INDI}
  begin
    ep(2000,equinox_date,ra5,dec5,ra5,dec5); {convert J2000 map to equinox of date for telescope commnication}
    str(ra5*12/pi:0:6,s1);{here direct after plot grid to get latest ra,dec}
    str(dec5*180/pi:0:6,s2);
    sendmessage2('<newNumberVector  device="'+indi_telescope_name+'"  name="EQUATORIAL_EOD_COORD">  <oneNumber    name="RA">'+s1+'</oneNumber>  <oneNumber    name="DEC">'+s2+'</oneNumber></newNumberVector>');
    exit;
  end;
  {$else} {delphi}
  {$endif}


  {generic for ascom/alpaca}

  if mainwindow.tracking1.Checked=false then
  begin
    mainwindow.error_message1.visible:=true;
    mainwindow.error_message1.caption:=tracking_string+'=⍻'
  end;
  if equinox_telescope=0 then ep(2000,equinox_date, ra5,dec5,ra5,dec5) {convert equinox2000 map to astrometric/date}
  else
  if equinox_telescope<>2000 then ep(2000,equinox_telescope, ra5,dec5,ra5,dec5); {convert equinox2000 map to telescope equinox}

  Target_ra :=fnmodulo( (ra5)*12/pi , 24);
  Target_dec:=(dec5)*180/pi;

  mainwindow.statusbar1.caption:='Pos --> Ascom';
  if Target_dec>90 then Target_dec:=90 else if Target_dec<-90 then Target_dec:=-90;{exceptions above 90 will occur}

  {$ifdef mswindows}
  if telescope_interface='A' then
  begin
    if (ascom_mount.connected) then {allow export}
    begin
      try {parked ?}
        if ascom_mount.AtPark then
        begin
           Showmessage(error_string+', Parked !');
           exit;
        end;
        except
          on E: Exception do
          begin
            application.messagebox(pchar(E.Message),'ASCOM returns following error:',MB_ICONWARNING+MB_OK); {show error from driver error, for example below horizon}
          end;
      end;{park test}
      try {export}
      if Ascom_mount_capability=2 then  ascom_mount.SlewToCoordinatesAsync(Target_ra, Target_dec)
      else
      if Ascom_mount_capability=1 then  ascom_mount.SlewToCoordinates(Target_ra, Target_dec)
      else;
      {nothing}
      except
        on E: Exception do
        begin
          beep;
          application.messagebox(pchar(E.Message),'ASCOM returns following error:',MB_ICONWARNING+MB_OK); {show error from driver error, for example below horizon}
        end;
     end;
   end;
  end; {ascom}
  {$else} {unix}
  {$endif}

  if telescope_interface='C' then
  begin
    if mainwindow.park1.checked then
      begin
         Showmessage(error_string+', Parked !');
         exit;
      end;
    if  Ascom_mount_capability=2 then alpaca_put_generic('slewtocoordinatesasync',target_ra,target_dec) {slewToCoordinatesAsync, slewtocoordinates or synctocoordinates}
    else
    if  Ascom_mount_capability=2 then alpaca_put_generic('slewtocoordinates',target_ra,target_dec);{slewToCoordinatesAsync, slewtocoordinates or synctocoordinates}
  end;

end;

procedure Tmainwindow.import_from_ascom(Sender: TObject); {driven by ascom_timer}
var  ra_telesc,dec_telesc : double;
     eqs                : integer;

begin
  if  mainwindow.connect_telescope1.Checked then {ascom}
  begin
    if telescope_interface='C' then
    begin
      if alpaca_connected then
      begin
        alpaca_get_radec; {send request out, result will in alpaca_ra,alpaca_dec};
        process_telescope_position(alpaca_ra*pi/12,alpaca_dec*pi/180,equinox_telescope);{adatp equinox and some other things}
        if alpaca_communication_counter<=0 then  {once in ten timed}
        begin
          alpaca_get_tracking;{request tracking status}
          alpaca_get_atpark;
          alpaca_get_athome;
          alpaca_get_equatorialsystem;
        end;
        inc(alpaca_communication_counter); if alpaca_communication_counter>10 then alpaca_communication_counter:=0;{reduce communication for tracking, atHome, atPark}

        if Ascom_mount_capability=0 then {ask capabilities}
        begin
          alpaca_get_canslew; {slew possible but not feedback of position at the same time}
          alpaca_get_canslewasync;{async slew possible, live feed back Ra/DEC}
        end;
      end
      else
      begin
        mainwindow.statusbar1.caption:='Alpaca '+error_string+' '+DateTimeToStr(Now); ;
        statusbarfree:=false;
        switch_alpaca_client_onoff(true);{reconnect}
      end;
    end {alpaca}
    else
    if ascom_mount.connected then {allow import}
    begin
      try
        Dec_telesc:=(ascom_mount.declination)*pi/180 ;
        RA_telesc :=(ascom_mount.RightAscension)*pi/12;{telescope equinox date}
        mainwindow.park1.checked:=ascom_mount.AtPark; {update menu telescope parked?}
        mainwindow.tracking1.Checked:=ascom_mount.Tracking;{tracking ?}
        mainwindow.home1.Checked:=ascom_mount.AtHome;{home ?}
        except
      end;
      try    {check if ascom can specify equinox used}
         eqs:=ascom_mount.EquatorialSystem;
      except
         eqs:=0;
      end;
      case eqs of
         0 : equinox_telescope:=0;    {equOther	0	Custom or unknown equinox and/or reference frame.}
         1 : equinox_telescope:=0;    {equLocalTopocentric	1	Local topocentric; this is the most common for amateur telescopes.}
         2 : equinox_telescope:=2000; {equJ2000	2	J2000 equator/equinox, ICRS reference frame.}
         3 : equinox_telescope:=2050; {equJ2050	3	J2050 equator/equinox, ICRS reference frame.}
         4 : equinox_telescope:=1950; {equB1950	4	B1950 equinox, FK4 reference frame.}
      end;
      process_telescope_position(ra_telesc,dec_telesc,equinox_telescope);

    end;
  end;
end;

procedure Tmainwindow.connect_telescope1click(Sender: TObject);{connect to ascom telescope driver}
begin
  if connect_telescope1.checked=false then
  begin
      connect_telescope(sender);{result will activate menu}
  end
  else
  begin
    update_telescope_menu(false);
    mainwindow.ascom_timer.enabled:=false;{disable communication with ascom}

  {$ifdef fpc}
    if telescope_interface='I' then
      INDI_disconnect_device(indi_telescope_name); {disconnect INDI telescope device}

  {$else} {delphi}
  {$endif}
  end;
  invalidaterect(center_on.handle,nil,false); {update search window that goto becomes telescope slew to}
end;

procedure connect_telescope(Sender: TObject);{connect to telescope driver}
var
  V: variant;
begin
  if telescope_interface='C' then
  begin
    {alpaca_connected:=}switch_alpaca_client_onoff(true);
  end
  else
  if telescope_interface='A' then {=Ascom or I for INDI}
  begin
    {$ifdef mswindows}
    try
    if not VarIsEmpty(ascom_mount) then  {ascom alive?}
    begin
      mainwindow.ascom_timer.enabled:=false;
      ascom_mount.connected:=false;
      ascom_mount := Unassigned;
      update_telescope_menu(false);
      {canslew and canslewasync will be asked later. Here to early}
    end
    else
    begin
      if sender<>nil then {send from popup menu}
      begin {show this only when called from popup menu}
        try
          V := CreateOleObject('ASCOM.Utilities.Chooser'); {for 64 bit applications as suggested in http://www.ap-i.net/mantis/view.php?id=778#bugnotes, "ASCOM." is required!!}
          except
          V := CreateOleObject('DriverHelper.Chooser');{This will work for old Ascom and 32 bit windows only. Note this give an error when run in the Delphi environment}
        end;
        V.devicetype:=widestring('Telescope');
        ascom_driver:=(V.Choose(ascom_driver));
        V:=Unassigned;
      end;{end send from popup menu}

      if ascom_driver='' then exit; {e.g. 'ScopeSim.Telescope'}

      {setup Ascom}
      try
        ascom_mount := CreateOleObject(ascom_driver); {See at the end of this file the ASCOM fix 2018, """"SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide,exOverflow, exUnderflow, exPrecision]); """"}
        ascom_mount.connected:=true;
        if ascom_mount.CanSlewAsync then Ascom_mount_capability:=2 else {async slew possible, live feed back Ra/DEC}
        if ascom_mount.CanSlew      then Ascom_mount_capability:=1 else {slew possible but not feedback of position at the same time}
                 Ascom_mount_capability:=0;{no slew possible}
        mainwindow.ascom_timer.enabled:=true;
        if sender<>nil then Showmessage(ascom_mount.Description+#13+#10+#13+#10+ascom_mount.DriverInfo);{show this only when called from popup menu}
        ascom_mount.Tracking:=true;{set tracking on}
        update_telescope_menu(true);
      except
        on E: EOleException do ShowMessage('ASCOM error : ' + E.Message) {e.g. wrong com port}
        else
        begin {other errors}
         // mainwindow.connect_telescope1.checked:=false; {diable if default.hns is loaded and ASCOM driver is not there}
          update_telescope_menu(false);
          Showmessage(error_string+', ASCOM driver "'+ascom_driver+'" ' +not_found);
        end;
      end; {end setup ascom}

    end;

    except {ascom alive}
      Showmessage(error_string+', No ASCOM detected. Install from http://ascom-standards.org');
    end;
    {$else}
      {Not available in Linux}
    {$endif}
  end
  else
  {$ifdef fpc}
  if ((telescope_interface='I') and (sender<>nil)) then {=Ascom or I for INDI, if snder is nil, then call is from load setting, ignore. Build up connection with event creata}
  begin
    mainwindow.ascom_timer.enabled:=false;{INDI communication and timer give problemss}
    if indi_server_connected=false then connect_during_creation:=2;
    {connect INDI telescope driver}
  end;
  {$else} {delphi}
  {$endif}
end;

procedure Tmainwindow.tracktelescope1Click(Sender: TObject);
begin
   if tracktelescope1.checked=false then tracktelescope1.checked:=true else tracktelescope1.checked:=false;
   invalidaterect(center_on.handle,nil,false); {update search window that goto becomes telescope slew to}
end;

procedure Tmainwindow.Northabove1Click(Sender: TObject);
var t:double;
begin
  if northtop<>1 then  begin northtop:= 1; t:=90;          end
                 else  begin northtop:= 0; t:=reallatitude;end;
  ra_az(telescope_ra,telescope_dec,t,0,wtime2, viewx,viewy);{keep tracking on ra/dec}
  missedupdate:=2;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.Starscale1Click(Sender: TObject);
begin
  if magscale<>0 then begin  magscale:=0; missedupdate:=2; end else begin magscale:=1;missedupdate:=1;end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.statusbar1Click(Sender: TObject);
begin
  Clipboard.AsText:=bar_hint+#13+#10;{info to clipboard}
end;

procedure Tmainwindow.statusbar1MouseEnter(Sender: TObject);
begin
  mainwindow.image1.cursor := crarrow;{linux}
  {$IFDEF fpc} {FPC doesnt show tabs in statusbar}
   if bar_hint<>'' then statusbar1.caption:=bar_hint+'     '+click_to_copy_string; {'<=Click to copy into clipboard'}
  {$else}  {delphi}
  if bar_hint<>'' then statusbar1.caption:=bar_hint+#9+click_to_copy_string; {'<=Click to copy into clipboard'}
  {$endif}
end;

procedure Tmainwindow.Northarrow1Click(Sender: TObject);
begin
  if northarrow<>0 then begin  northarrow:=0; missedupdate:=2; end else begin northarrow:=1;missedupdate:=1;end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.InsertFITSimage1Click(Sender: TObject);
begin
  if fits_insert<>0 then fits_insert:=0 else fits_insert:=1;
  if ((fits_insert<>0) and (contour_only<>0)) then missedupdate:=1 else missedupdate:=2;
  paint_sky; {rewrite window }
  {object windows=>} invalidaterect(objectmenu.handle,nil,false); {rewrite OBJECT window}
end;

procedure Tmainwindow.Internal1Click(Sender: TObject);
begin
  editfile:=10;
  foundstring1.clear; {empthy string}
  find_object(mainwindow.image1.canvas,'A');
  search_results:=Tsearch_results.Create(self); {in project option not loaded automatic}
  search_results.ShowModal;
  search_results.release;
end;

procedure Tmainwindow.ToolBar2CustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
   Sender.canvas.Font.Color := colors[27];
end;

procedure Tmainwindow.ToolBar2MouseLeave(Sender: TObject);
begin
  oldx:=-999;{kill any rubber band behaviour}
end;

procedure Tmainwindow.toolbutton_menuClick(Sender: TObject);
var
  button: TControl;
  lowerLeft: TPoint;
begin
  if Sender is TControl then
  begin
    button := TControl(Sender);
    lowerLeft := Point(0, button.Height);
    lowerLeft := button.ClientToScreen(lowerLeft);
    PopupMenu_menubar1.Popup(lowerLeft.X, lowerLeft.Y);
  end;
end;

procedure Tmainwindow.Enterdatetime1buttonClick(Sender: TObject);
begin
  mainwindow.Enterdatetime1Click(Sender);
end;

procedure Tmainwindow.zenith1Click(Sender: TObject);
begin
  move_to.Zenithbutton1Click(nil);
end;

procedure Tmainwindow.OnoffClick(Sender: TObject);
const
  BoolStr: array [boolean] of String = (' ', '✔');
begin
  savesettingstoolbutton.visible:=save_onoff.checked;
  save_onoff.caption:=Boolstr[save_onoff.checked];

  enterdatetimetoolbutton.visible:=time_onoff.checked;
  time_onoff.caption:=Boolstr[time_onoff.checked];

  gotoradectoolbutton.visible:=gotoradec_onoff.checked;
  gotoradec_onoff.caption:=Boolstr[gotoradec_onoff.checked];

  instrumentstoolbutton.visible:=tools_onoff.checked;
  tools_onoff.caption:=Boolstr[tools_onoff.checked];

  foundobjectmarkertoolbutton.visible:=foundmarker_onoff.checked;
  foundmarker_onoff.caption:=Boolstr[foundmarker_onoff.checked];

  undotoolbutton.visible:=undo_onoff.checked;
  undo_onoff.caption:=Boolstr[undo_onoff.checked];

  redotoolbutton.visible:=redo_onoff.checked;
  redo_onoff.caption:=Boolstr[redo_onoff.checked];

  settingstoolbutton.visible:=settings_onoff.checked;
  settings_onoff.caption:=Boolstr[settings_onoff.checked];

  deephlptoolbutton.visible:=deephlp_onoff.checked;
  deephlp_onoff.caption:=Boolstr[deephlp_onoff.checked];

  darknightstoolbutton.visible:=darknights_onoff.checked;
  darknights_onoff.caption:=Boolstr[darknights_onoff.checked];

  animatetoolbutton.visible:=animation_onoff.checked;
  animation_onoff.caption:=Boolstr[animation_onoff.checked];


  solarsystemtonighttoolbutton.visible:=solarsystem_onoff.checked;
  solarsystem_onoff.caption:=Boolstr[solarsystem_onoff.checked];

  telescope_aborttoolbutton.visible:=slew_onoff.checked;
  SLEW_onoff.caption:=Boolstr[slew_onoff.checked];

  gridRAtoolbutton.visible:=gridRA_onoff.checked;
  gridRA_onoff.caption:=Boolstr[gridRA_onoff.checked];

  gridAZtoolbutton.visible:=gridAZ_onoff.checked;
  gridAZ_onoff.caption:=Boolstr[gridAZ_onoff.checked];

  milkywaytoolbutton.visible:=milkyway_onoff.checked;
  milkyway_onoff.caption:=Boolstr[milkyway_onoff.checked];

  earthtoolbutton.visible:=earth_onoff.checked;
  earth_onoff.caption:=Boolstr[earth_onoff.checked];

  ConstellationstoolButton.visible:=constellations_onoff.checked;
  Constellations_onoff.caption:=Boolstr[Constellations_onoff.checked];

  fitstoolbutton.visible:=fits_onoff.checked;
  fits_onoff.caption:=Boolstr[fits_onoff.checked];

  FlipHtoolbutton.visible:=FlipH_onoff.checked;
  FlipH_onoff.caption:=Boolstr[FlipH_onoff.checked];

  FlipVtoolbutton.visible:=FlipV_onoff.checked;
  FlipV_onoff.caption:=Boolstr[FlipV_onoff.checked];

  Northabovetoolbutton.visible:=Northabove_onoff.checked;
  Northabove_onoff.caption:=Boolstr[Northabove_onoff.checked];

  Siderealtoolbutton.visible:=Sidereal_onoff.checked;
  Sidereal_onoff.caption:=Boolstr[Sidereal_onoff.checked];
end;

procedure Tmainwindow.north1Click(Sender: TObject);
begin
  move_to.Northbutton1Click(nil);
end;

procedure Tmainwindow.South1Click(Sender: TObject);
begin
  move_to.Southbutton1Click(nil);
end;

procedure Tmainwindow.east1Click(Sender: TObject);
begin
  move_to.Eastbutton1Click(nil);
end;

procedure Tmainwindow.West1Click(Sender: TObject);
begin
  move_to.Westbutton1Click(nil);
end;

procedure Tmainwindow.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
   zoom_factor: double;
begin
  if ((ssctrl in shift) and ((mframe<>0) or (mainwindow.connect_telescope1.Checked)) ) then  {allow rotation if measuring frame is on or telescope connected}
  begin
    if frame_angle<=355 then
    begin
      if (ssAlt in shift)=false then inc(frame_angle,5) else inc(frame_angle,1);
      mainwindow.image1MouseMove(Sender, Shift,mx,my);
//      Mouse_Event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_MOVE, Round(mousepos.x * (65535 / Screen.Width)),Round(mousepos.y * (65535 / Screen.Height)), 0, 0) ;
      statusbar1.caption:=inttostr(frame_angle)+'°';
    end;
  end
  else
  begin
    if ((ssCtrl in shift) or (ssAlt in shift) or (ssShift in shift)) then zoom_factor:=1.01 else zoom_factor:=1.4;
    if mouse_wheel_reverse=0 then zoom_in(zoom_factor) else zoom_out(zoom_factor);
  end;
end;

procedure Tmainwindow.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
     zoom_factor: double;
begin
  if ((ssctrl in shift) and ((mframe<>0) or (mainwindow.connect_telescope1.Checked)) ) then
  begin
    if frame_angle>=-355 then
    begin
      if (ssAlt in shift)=false then dec(frame_angle,5) else dec(frame_angle,1);
      mainwindow.image1MouseMove(Sender, Shift,mx,my);
  //    Mouse_Event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_MOVE, Round(mousepos.x * (65535 / Screen.Width)),Round(mousepos.y * (65535 / Screen.Height)), 0, 0) ;
      statusbar1.caption:=inttostr(frame_angle)+'°';
    end;
  end
  else
  begin
    if ((ssCtrl in shift) or (ssAlt in shift) or (ssShift in shift)) then zoom_factor:=1.01 else zoom_factor:=1.4;
    if mouse_wheel_reverse=0 then zoom_out(zoom_factor) else zoom_in(zoom_factor);
  end;
end;

procedure Tmainwindow.Earth1Click(Sender: TObject);
begin
  if earth<>0 then begin earth:=0; missedupdate:=2; end else begin earth:=1;missedupdate:=1;end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.MilkyWay1Click(Sender: TObject);
begin
  if milkyway<>0 then begin milkyway:=0; missedupdate:=2; end else begin milkyway:=1;missedupdate:=1;end;
  paint_sky; {rewrite window }
end;

procedure Tmainwindow.MinF3Click(Sender: TObject);
begin
  inctime2(-1/(24*60));
  missedupdate:=2;paint_sky; {rewrite window}
end;

procedure Tmainwindow.MinF4Click(Sender: TObject);
begin
  inctime2(1/(24*60));
  missedupdate:=2;  paint_sky; {rewrite window }
end;

procedure Tmainwindow.HourF5Click(Sender: TObject);
begin
  inctime2(-1/24);
  missedupdate:=2;paint_sky; {rewrite window}
end;

procedure Tmainwindow.HourF6Click(Sender: TObject);
begin
  inctime2(1/24);
  missedupdate:=2;paint_sky; {rewrite window}
end;

procedure Tmainwindow.DayF7Click(Sender: TObject);
begin
  inctime2(-1);
  missedupdate:=2;paint_sky; {rewrite window}
end;


procedure string_replace(thestart,thestop,thenew  :string; var theline :string);
var
   p1,p2 :integer;
begin
  p1:=pos(thestart,theline);
  if p1<>0 then
  begin
    p1:=p1+length(thestart);
    p2:=posex(thestop,theline,p1+1);
    if p2=0 then p2:=999;
    delete(theline,p1,p2-p1);
    insert(thenew,theline,p1);
  end;
end;


//http://skyview.gsfc.nasa.gov/cgi-bin/pskcall?return=fits&Survey=DSS2R&
//survey=DSS
//survey=DSS2+IR
//survey=DSS2+Blue
//survey=SDSSr
//survey=H-Alpha+Comp
//survey=NEAT
//2MASS-J


//http://archive.eso.org/dss/dss?mime-type=download-fits&equinox=J2000&Sky-Survey=DSS2&
//http://archive.eso.org/dss/dss/image?ra=01+34+50&dec=20+0+0&equinox=J2000&name=0&x=5&y=5&Sky-Survey=DSS2-red&mime-type=download-fits&statsmode=WEBFORM
//http://archive.eso.org/dss/dss/image?ra=01+34+50&dec=20+0+0&equinox=J2000&name=0&x=5&y=5&Sky-Survey=DSS2-blue&mime-type=download-fits&statsmode=WEBFORM
//http://archive.eso.org/dss/dss/image?ra=&dec=&equinox=J2000&name=m27&x=20&y=20&Sky-Survey=DSS2-infrared&mime-type=download-fits&statsmode=WEBFORM

//http://archive.stsci.edu/cgi-bin/dss_search?v=3&
//https://archive.stsci.edu/cgi-bin/dss_search?v=poss2ukstu_red&r=19+59+36.38&d=%2B22+43+15.7&e=J2000&h=15.0&w=15.0&f=fits&c=none&fov=NONE&v3=
//https://archive.stsci.edu/cgi-bin/dss_search?v=poss2ukstu_ir&r=19+59+36.38&d=%2B22+43+15.7&e=J2000&h=15.0&w=15.0&f=fits&c=none&fov=NONE&v3=
//https://archive.stsci.edu/cgi-bin/dss_search?v=poss1_red&r=19+59+36.38&d=%2B22+43+15.7&e=J2000&h=15.0&w=15.0&f=fits&c=none&fov=NONE&v3=

//v=poss2ukstu_blue
//poss2ukstu_red
//poss2ukstu_r

//v=poss1_re



procedure set_dds_bandpass_menu;
begin
  mainwindow.dss_red1.checked:=dss_bandpass=8;
  mainwindow.dss2_red1.checked:=dss_bandpass=35;
  mainwindow.dss_blue1.checked:=dss_bandpass=7;
  mainwindow.dss2_blue1.checked:=dss_bandpass=18;
  mainwindow.dss2_infrared1.checked:=dss_bandpass=37;


  mainwindow.get_ESO1.enabled:=dss_bandpass<>2;{dss1-blue not available in ESO}

  if dss_bandpass=8 then {dss1 red}
  begin
    string_replace('urvey=','&','DSS1+red',internet_skyview);
    string_replace('urvey=','&','DSS1',internet_eso);   //https://archive.eso.org/dss/dss/image?ra=&dec=0+0+0&equinox=J2000&name=m27&x=5&y=5&Sky-Survey=DSS1&mime-type=download-fits&statsmode=WEBFORM
    string_replace('v=','&','poss1_red',internet_mast);
    mainwindow.bandpassmenu1.imageindex:=43;{red icon}
  end
  else
  if dss_bandpass=35 then {dss2 red}
  begin
    string_replace('urvey=','&','DSS2+red',internet_skyview);
    string_replace('urvey=','&','DSS2-red',internet_eso);
    string_replace('v=','&','poss2ukstu_red',internet_mast);
    mainwindow.bandpassmenu1.imageindex:=43;{red icon}
  end
  else
  if dss_bandpass=7 then {dss1 blue}
  begin
    string_replace('urvey=','&','DSS1+blue',internet_skyview);
    {blue not available in ESO}
    string_replace('v=','&','poss1_blue',internet_mast);
    mainwindow.bandpassmenu1.imageindex:=44;{blue icon}
  end
  else
  if dss_bandpass=18 then {dss2 blue}
  begin
    string_replace('urvey=','&','DSS2+blue',internet_skyview);
    string_replace('urvey=','&','DSS2-blue',internet_eso);
    string_replace('v=','&','poss2ukstu_blue',internet_mast);
    mainwindow.bandpassmenu1.imageindex:=44;{blue icon}
  end
  else
  if dss_bandpass=37 then {dss2 infrared}
  begin
    string_replace('urvey=','&','DSS2+ir',internet_skyview);
    string_replace('urvey=','&','DSS2-infrared',internet_eso); //https://archive.eso.org/dss/dss/image?ra=&dec=0+0+0&equinox=J2000&name=m27&x=5&y=5&Sky-Survey=DSS2-infrared&mime-type=download-fits&statsmode=WEBFORM
    string_replace('v=','&','poss2ukstu_ir',internet_mast);
    mainwindow.bandpassmenu1.imageindex:=45;{dark red icon}
  end;
end;

procedure Tmainwindow.dss_red1Click(Sender: TObject);
begin
  if dss_red1.checked then dss_bandpass:=8;
  set_dds_bandpass_menu;
  missedupdate:=2;
  paint_sky;
end;


procedure Tmainwindow.dss2_red1Click(Sender: TObject);
begin
  if dss2_red1.checked then dss_bandpass:=35;
  set_dds_bandpass_menu;
  missedupdate:=2;
  paint_sky;
end;

procedure Tmainwindow.dss_blue1Click(Sender: TObject);
begin
  if dss_blue1.checked then dss_bandpass:=7;
  set_dds_bandpass_menu;
  missedupdate:=2;
  paint_sky;
end;

procedure Tmainwindow.dss2_blue1Click(Sender: TObject);
begin
  if dss2_blue1.checked then dss_bandpass:=18;
  set_dds_bandpass_menu;
  missedupdate:=2;
  paint_sky;
end;

procedure Tmainwindow.dss2_infrared1Click(Sender: TObject);
begin
  if dss2_infrared1.checked then dss_bandpass:=37;
  set_dds_bandpass_menu;
  missedupdate:=2;
  paint_sky;
end;

procedure Tmainwindow.date_and_time1MouseEnter(Sender: TObject);
begin
  hint:=Time_reference+': '+today2_UTC;{show with hint UTC or TDT time}
end;

procedure Tmainwindow.date_and_time1Click(Sender: TObject);
begin
  mainwindow.Enterdatetime1Click(Sender);{enter time & date}
end;

procedure Tmainwindow.alpaca1Receive(aSocket: TLSocket);
var
  s,err: string;
begin
  if aSocket.GetMessage(s) > 0 then
  begin
    err:=alpaca_read(s);
    if length(err)>0 then statusbar1.caption:='Alpaca:'+err;
//    if server_on then // echo to all if TCP
//        SendToAll(answer);
  end;

end;

procedure Tmainwindow.alpaca1Disconnect(aSocket: TLSocket);
begin
  alpaca_connected:=false; {do not update menu yet, try to reconnect}
  mainwindow.error_message1.visible:=true;
  mainwindow.error_message1.caption:=Alpaca_conn_lost_string;
end;

procedure Tmainwindow.alpaca1Connect(aSocket: TLSocket);
begin
  statusbar1.caption:=alpaca_connection_string;
  statusbarfree:=false;

  alpaca_connected:=true; {actual connection}
  mainwindow.error_message1.visible:=false;
end;

procedure Tmainwindow.alpaca1Error(const msg: string; aSocket: TLSocket);
begin
  alpaca_connected:=false; {actual connection}
  mainwindow.error_message1.visible:=true;
  mainwindow.error_message1.caption:='Alpaca '+error_string+' '+DateTimeToStr(Now);
end;

procedure Tmainwindow.editobject1Click(Sender: TObject);
var
  workstrings :tstrings;
  i           :integer;
begin
  workstrings := Tstringlist.Create;
  case found_mode of {find correct supplement}
                     1:workstrings:=supplstring1;
                     3:workstrings:=supplstring2;
                     5:workstrings:=supplstring3;
                     7:workstrings:=supplstring4;
                     9:workstrings:=supplstring5;
                     else exit;
  end;

  if found_name='' then exit;{no way to locate this object using pos function}

  i:=0;
  repeat
    if ((pos(','+found_name,workstrings[i]+'/')>0) or (pos(','+found_name,workstrings[i]+',')>0)) then {name2 found in supplement, we can edit now}
     begin
       new_line1:=workstrings[i];{this line could be editted}
       edit_supplement_entry:=Tedit_supplement_entry.Create(self); {in project option not loaded automatic}
       edit_supplement_entry.ShowModal;
       edit_supplement_entry.release;
       if ok_butt then {new_lines editted}
       begin
         workstrings[i]:=new_line1;

         case found_mode of
              1:begin supplstring1:=workstrings;if save_butt then supplstring1.savetoFile(documents_path+name_supl1); end;{save to file}
              3:begin supplstring2:=workstrings;if save_butt then supplstring2.savetoFile(documents_path+name_supl2); end;{save to file}
              5:begin supplstring3:=workstrings;if save_butt then supplstring3.savetoFile(documents_path+name_supl3); end;{save to file}
              7:begin supplstring4:=workstrings;if save_butt then supplstring4.savetoFile(documents_path+name_supl4); end;{save to file}
              9:begin supplstring5:=workstrings;if save_butt then supplstring5.savetoFile(documents_path+name_supl5); end;{save to file}
         end;
         missedupdate:=2; {rewrite window}
         paint_sky; {rewrite window}
       end;{new line is not empthy}
       exit;
     end;
     inc(i);
  until i>=workstrings.count;
  workstrings.free;{free suppl1}
end;

{$IFDEF fpc}
procedure Tmainwindow.mouseposition1Click(Sender: TObject);
var
  frame_pa_str: string;
begin
  found_ra2:=popupmouse_ra;{for get_target via server}
  found_dec2:=popupmouse_dec;
  found_name:='mouse_'+ leadingzero(round(found_ra2*12/pi)) + '_'+ leadingzero(round(found_dec2*180/pi));
  if mframe<>0 then frame_pa_str:=' '+floattostrF_local(frame_angle*pi/180,0,7) else frame_pa_str:='';
  mainwindow.SendToAll(floattostrF_local(found_ra2,0,7)+' '+floattostrF_local(found_dec2,0,7)+' '+found_name+frame_pa_str); {CRLF will be added later}
end;
{$ELSE} {delphi}
{$ENDIF}

procedure Tmainwindow.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if ltcp1.Connected then
  begin
    CloseAction := caNone; // make sure we quit gracefuly
    ltcp1.Disconnect; // call disconnect (soft)
  end;

  if alpaca1.Connected then
  begin
    CloseAction := caNone; // make sure we quit gracefuly
    alpaca1.Disconnect; // call disconnect (soft)
  end;

end;

procedure Tmainwindow.DayF8Click(Sender: TObject);
begin
  inctime2(1);
  missedupdate:=2;paint_sky; {rewrite window}
end;

procedure Tmainwindow.N2356F11Click(Sender: TObject);
begin
  inctime2(-(23+56/60+4/3600)/24);
  missedupdate:=2;paint_sky; {rewrite window}
end;

procedure Tmainwindow.N2356F12Click(Sender: TObject);
begin
  inctime2((23+56/60+4/3600)/24);
  missedupdate:=2;paint_sky; {rewrite window}
end;

procedure Tmainwindow.SolarsystemtonightClick(Sender: TObject);
begin
  planetform:=Tplanetform.Create(self); {in project option not loaded automatic}
  planetform.ShowModal;
  planetform.Free;
end;

procedure Tmainwindow.load_fits1Click(Sender: TObject);
begin
  starty:=-9999;{-99 prevent problems pull square start to early after mouse click when screen has not finished painting}
  opendialog1.title:=open_fits_title;  // open_file dialog title;
  opendialog1.InitialDir:=ExtractFilePath(extra_fits_file); //dss_path;
  opendialog1.filter:='FITS imagefile (*.fit*)|*.fit*';

  if opendialog1.execute then
  begin
    if pos('map_',opendialog1.filename)=0 then {only load fits of fixed objects.}
    begin
//      dss_mask:=ExtractFilePath(opendialog1.filename);{change FITs path for next load. Do not dss_path, dss_path will be extracted from dss_mask}
      extra_fits_file:=opendialog1.filename;
      if plot_fits(nil,extra_fits_file)=false then
      begin
         statusbar1.caption:=('Astrometrical solution missing in '+ extra_fits_file);{error message to canvas}
         exit;
      end;
      fits_insert:=1;{activate, for redraw action}
      missedupdate:=2;paint_sky; {rewrite window}
    end;
  end;
end;

procedure Tmainwindow.Centreon1Click(Sender: TObject);
begin
    found:=0;
    ra_az(popupmouse_ra, popupmouse_dec,latitude,0, wtime2,viewx,viewy);
    if  size_pulled_rectangle>4 then zoom:=zoom*(rrw.bottom-rrw.top)/size_pulled_rectangle;{zoom only  if  rubber  box  drawn}

    application.processmessages; {in linux allow closing popup menu}
    missedupdate:=3;{three !!!, no repaint required, first update bitmap}
    paint_sky;
end;

function percent_encoding(inp:string): string;
begin
  result:=StringReplace(inp, '-', '%2D',[]);{replace -}
  result:=StringReplace(inp, '&', '%26',[]);{replace &}
  result:=StringReplace(inp, ' ', '%20',[]);{replace space}
  result:=StringReplace(inp, '<', '%3C',[]);{}
  result:=StringReplace(inp, '>', '%3E',[]);{}

end;

procedure Tmainwindow.Simbad1Click(Sender: TObject);
var
  position,regel,regel2,typ : string;
  m :double;
  err,i,p1,p2,p3,p4,p5,p6,p7 : integer;
begin
//  https://simbad.u-strasbg.fr/simbad/sim-sam?submit=submit+query&maxObject=1000&Criteria=(Vmag<15+|+Bmag<15+)%26+region(box,180.0713d%2B39.9259d,+51.3366m+39.1732m)&OutputMode=LIST&output.format=ASCII
  position:= floattostrf(popupmouse_dec*180/pi,ffFixed,6,4)+'d';
  if popupmouse_dec>=0 then position:='%2B'{+} + position;
  position:=StringReplace(position, '-', '%2D',[]);{replace -}
  position:=floattostrf(popupmouse_ra*180/pi,ffFixed,6,4)+'d'+position;

  size_pulled_rectangle:=0; {kill zoom function in Tmainwindow.OUT1Click}


  application.processmessages; {in linux allow closing popup menu}
  if DownloadFile(internet_simbad+'%26+region(box,'+position+',+'+floattostrf(abs(sep_width),ffFixed,6,4)+'m+'+floattostrf(abs(sep_height),ffFixed,6,4)+'m)&OutputMode=LIST&output.format=ASCII', cache_path+'simbad.txt') then
  begin
  with catalogstring do
  begin
    try
    LoadFromFile(cache_path+'simbad.txt');{load from file }
    except;{no file available}
      clear;
      exit;
    end;

    supplstring2.add(';Imported from Simbad');
    lineposcatalog:=9;{skip first part}
    while lineposcatalog+1<=catalogstring.count do
    begin
      regel:=ansistring(catalogstring.strings[lineposcatalog]);
      inc(lineposcatalog);

      if length(regel)>=130 then
      begin
        {magnitude}
        regel2:='';
        p1:=pos('|',regel);{first column changes in width}
        p2:=posex('|',regel,p1+1);
        p3:=posex('|',regel,p2+1);
        p4:=posex('|',regel,p3+1);
        p5:=posex('|',regel,p4+1);
        p6:=posex('|',regel,p5+1);
        p7:=posex('|',regel,p6+1);

        regel2:=copy(regel,p3+1,p4-p3-1);
        for i:=1 to 5 do  regel2:=StringReplace(regel2, ' ',',',[]);{position is variable if ra or dec contains nice round values.}
        regel2:=regel2+',';
        val(trim(copy(regel,p6+1,p7-p6-1)),m,err);{V magnitude}
        if m=0 then val(trim(copy(regel,p5+1,p6-p5-1)),m,err);{try B magnitude}

        if m=0 then regel2:=regel2+',' {unknown magnitude, e.g ngc1988}
        else
        regel2:=regel2+inttostr(round(m*10))+',';{magn}

        regel2:=regel2+StringReplace(trim(copy(regel,p1+1,p2-p1-1)), ' ', '_',[rfReplaceAll])+',';{name}
        typ:=trim(copy(regel,p2+1,p3-p2-1));
        regel2:=regel2+typ+',';{type}


        if pos('*',typ)=0 then {not a star}
        begin
          regel2:=regel2+'999,0.001,0.001';{brightness, size}
        end
        else
        regel2:=regel2+'';{mark as star by nothing at brightness position}
        supplstring2.add(regel2);{add to supplement2}
        suppl2_activated:=1;{active supplement 2}
        if length(name_supl2)<5 then name_supl2:='Simbad.sup';
      end; {length regel okay}
    end;
  end;
  missedupdate:=2; {rewrite window}
  paint_sky; {rewrite window}
end
else
   application.messagebox(pchar(error_string+' while downloading: ' + internetlink+#13+#10+#13+#10+
     cache_path+'*.txt')
     ,pchar(error_string),MB_OK);

end;

procedure Tmainwindow.HyperLeda1Click(Sender: TObject);
var
   position,regel,regel2,tmp,tmp2 : string;
   m :double;
   err,px,len,wid : integer;
begin
  position:= floattostrf(popupmouse_dec*180/pi,ffFixed,6,4); {floattostr is always using . as decimal seperator as set in form.create}
  position:=StringReplace(position, '-', '%2D',[]);{replace -. Note do not add %2B for +. Doesn't work in Raspberry Pi}
  position:=floattostrf(popupmouse_ra*180/pi,ffFixed,6,4)+'d'+position+'d';

  size_pulled_rectangle:=0; {kill zoom function in Tmainwindow.OUT1Click}


  application.processmessages; {in linux allow closing popup menu}
  if DownloadFile(internet_leda+'&f='+floattostrf(abs(sep_height/2),ffFixed,6,4)+'&p=J'+position+'&a=t[%2C]', cache_path+'hyperleda.txt') then
  begin
    with catalogstring do
    begin
      try
      LoadFromFile(cache_path+'hyperleda.txt');	{ load from file }
      except;{no file available}
        clear;
        exit;
      end;

      lineposcatalog:=41;{skip first part}
      supplstring2.add(';Imported from Hyperleda');
      while lineposcatalog+1<=catalogstring.count do
      begin
        regel:=ansistring(catalogstring.strings[lineposcatalog]);
        inc(lineposcatalog);
        if ((length(regel)>=169) and (regel[32]='J')) then
        begin
          {magnitude}
          val(copy(regel,73,4),m,err);{copy first four characters only, ignoring star colour letter}
          regel2:='';
          regel2:=       copy(regel,33,2)+',';{ra hrs}
          regel2:=regel2+copy(regel,35,2)+',';{ra min}
          regel2:=regel2+copy(regel,37,4)+',';{ra sec}
          regel2:=regel2+copy(regel,41,3)+',';{dec}
          regel2:=regel2+copy(regel,44,2)+',';{dec min}
          regel2:=regel2+copy(regel,46,2)+',';{dec sec}
          val(copy(regel,73,4),m,err);{copy first four characters only, ignoring star colour letter}

          if m=0 then regel2:=regel2+',' {unknown mangitude, e.g ngc1988}
          else
          regel2:=regel2+inttostr(round(m*10))+',';{magn}

          regel2:=regel2+StringReplace(trim(copy(regel,1,30)), ' ', '_',[rfReplaceAll])+',';{name}
          regel2:=regel2+regel[49]+',';{type}

          if regel[49]<>'S' then {not a star, add more}
          begin
            regel2:=regel2+'999,';{brightness}

            {get length and width}
            tmp:=copy(regel,80,10);
            px:=pos('x',tmp);
            if px<>0 then
            begin
              tmp2:=copy(tmp,px+1,10-px);
              val(tmp2,wid,err);
              str(wid*10/60:0:2,tmp2);
              tmp:=copy(tmp,1,px-1);
              val(tmp,len,err);
              str(len*10/60:0:2,tmp);

              regel2:=regel2+tmp+',';
              regel2:=regel2+tmp2+',';

            end
            else
            begin {no size}
              regel2:=regel2+',,';
            end;
            regel2:=regel2+copy(regel,91,3);{PA}
          end
          else
          regel2:=regel2+'';{mark as star by nothing at brightness position}

          supplstring2.add(regel2);{add to supplement2}
          suppl2_activated:=1;{active supplement 2}
          if length(name_supl2)<5 then name_supl2:='HyperLeda.sup';
        end; {length regel okay}
      end;
    end;
    missedupdate:=2; {rewrite window}
    paint_sky; {rewrite window}
  end
  else
     application.messagebox(pchar(error_string+' while downloading: ' + internetlink+#13+#10+#13+#10+
       cache_path+'hyperleda.txt')
       ,pchar(error_string),MB_OK);

end;
procedure Tmainwindow.Ned1Click(Sender: TObject);
begin
  {mouse radec, sep_height is done in Tmainwindow.PopupMenu1Popup(Sender: TObject);}
  open_link(internet_ned+floattostrf(abs(sep_height),ffFixed,6,4)+'&lon='+floattostrf(popupmouse_ra*12/pi,ffFixed,6,4)+'&lat='+floattostrf(popupmouse_dec*180/pi,ffFixed,6,4));
end;

procedure Tmainwindow.get_ESO1Click(Sender: TObject);
var
  destfile:string;
begin
    fits_insert:=1;{switch inserting DSS on}
    if size_pulled_rectangle<=4 then
    begin
      sep_width:=round(telescope_width/5);
      sep_height:=round(telescope_height/5);
    end;
  internetlink:=internet_eso+'&ra='+floattostrf(popupmouse_ra*180/pi,ffFixed,6,4)+'&dec='+floattostrf(popupmouse_dec*180/pi,ffFixed,6,4)+'&x='+floattostrf(minmax(sep_width,0.3,60),ffFixed,6,1)+'&y='+floattostrf(minmax(sep_height,0.3,60),ffFixed,6,1);
  size_pulled_rectangle:=0; {kill zoom function in Tmainwindow.OUT1Click}

  destfile:='down____'+position_to_string(popupmouse_ra,popupmouse_dec)+'.fit'; {colour is at position 9. RA at position 10..13, DEC at position 14..18}

  if Downloadfile(internetlink, dss_path+destfile) then
  begin
    missedupdate:=2; {rewrite window}
    paint_sky; {rewrite window}
  end
  else
    ShowMessage(error_string+' while downloading ' + internetlink);
end;


procedure Tmainwindow.Get_Skyview1Click(Sender: TObject);
var
   size_image: double;
   pixelx, pixely :integer;
var
  destfile:string;
begin
  fits_insert:=1;{switch inserting DSS on}
  {mouse radec is done in Tmainwindow.PopupMenu1Popup(Sender: TObject);}
  if size_pulled_rectangle<=4 then
  begin
    sep_width:=round(telescope_width/5);
    sep_height:=round(telescope_height/5);
  end;

  if  sep_width>sep_height then begin size_image:= sep_width;  pixelx:=max(size_pulled_rectangle,350){2016}; pixely:=round(pixelx*(sep_height/sep_width));end {skyview takes longest, either width or height}
                           else begin size_image:= sep_height; pixely:=max(size_pulled_rectangle,350){2016}; pixelx:=round(pixely*(sep_width/sep_height));end;
  destfile:=position_to_string(popupmouse_ra,popupmouse_dec)+'.fit'; {colour is at position 9. RA at position 10..13, DEC at position 14..18}

  if abs(size_image)>350*0.01*60 then {download Mellinger survey}
  begin
     internetlink:= internet_skyview_wide;
     destfile:='downM___'+destfile;{mark as mellinger file}
  end
  else
  begin
    internetlink:= internet_skyview;{use Axel mellinger if pixel size>0.01 degrees}
    destfile:='down____'+destfile;{standard download name}
  end;

  internetlink:=internetlink+'&VCOORD='+floattostrf(popupmouse_ra*180/pi,ffFixed,6,4)+','+floattostrf(popupmouse_dec*180/pi,ffFixed,6,4)+
  '&PIXELX='+inttostr(pixelx)+
  '&PIXELY='+inttostr(pixely)+
  '&SFACTR='+floattostrf(minmax(abs(size_image),0.3,360*60)/60,ffFixed,6,4);{not limitations but skyview stops at around 140 degrees}



  size_pulled_rectangle:=0; {kill zoom function in Tmainwindow.OUT1Click}

  application.processmessages; {in linux allow closing popup menu}

  if Downloadfile(internetlink, dss_path+destfile) then
  begin
    missedupdate:=2; {rewrite window}
    paint_sky; {rewrite window}
  end
  else
    ShowMessage(error_string+' while downloading ' + internetlink);
end;

procedure Tmainwindow.get_mast1Click(Sender: TObject); {get  mast image}
var
  destfile:string;
begin
    fits_insert:=1;{switch inserting DSS on}
    {mouse radec is done in Tmainwindow.PopupMenu1Popup(Sender: TObject);}
    if size_pulled_rectangle<=4 then
    begin
      sep_width:=round(telescope_width/5);
      sep_height:=round(telescope_height/5);
    end;

  internetlink:=internet_mast+'&r='+floattostrf(popupmouse_ra*180/pi,ffFixed,6,4)+'&d='+floattostrf(popupmouse_dec*180/pi,ffFixed,6,4)+'&w='+floattostrf(minmax(sep_width,0.3,60),ffFixed,6,1)+'&h='+floattostrf(minmax(sep_height,0.3,60),ffFixed,6,1);

  size_pulled_rectangle:=0; {kill zoom function in Tmainwindow.OUT1Click}
  destfile:='down____'+position_to_string(popupmouse_ra,popupmouse_dec)+'.fit';{colour is at position 9. RA at position 10..13, DEC at position 14..18}

  application.processmessages; {in linux allow closing popup menu}

  if Downloadfile(internetlink, dss_path+destfile) then
  begin
    missedupdate:=2; {rewrite window}
    paint_sky; {rewrite window}
  end
  else
    ShowMessage(error_string+' while downloading ' + internetlink);
end;

procedure Tmainwindow.Telescopetomouseposition1Click(Sender: TObject);
var
  ra7, dec7: double;
begin
  mouse_radec(image1.canvas,mx,my,ra7,dec7);  {find mouse position}
  export_to_telescope(ra7,dec7);   {ascom or indi}
end;

procedure Tmainwindow.movelines1Click(Sender: TObject);
begin
  suppl2_activated:=1; {always activate supplement 2}
  if mainwindow.movelines1.checked then
  begin
    mainwindow.insertlines1.checked:=false;
    mainwindow.hidelines1.checked:=false;
    mainwindow.Linestart1.checked:=false;
    mainwindow.LinestartAzALT1.checked:=false;{disable ALT/AZ lines}
    mainwindow.Removelines1.checked:=false;{disable ALT/AZ lines}
    mainwindow.colorchange1.checked:=false;{disable ALT/AZ lines}
    label_all_lines:=true;
  end
  else
  begin
    label_all_lines:=false;
  end;
  cut_position:=0;
  missedupdate:=2;
  paint_sky; {rewrite window}
end;

procedure Tmainwindow.Linestart1Click(Sender: TObject);
begin
  linepoint_counter:=0;{drawing pointer counter to zero, so first point is a move to}
  suppl2_activated:=1; {always activate supplement 2}
  label_all_lines:=false;
  if mainwindow.Linestart1.checked then
  begin
    mainwindow.movelines1.checked:=false;
    mainwindow.LinestartAzALT1.checked:=false;
    mainwindow.hidelines1.checked:=false;
    mainwindow.colorchange1.checked:=false;{disable ALT/AZ lines}
    mainwindow.Removelines1.checked:=false;{disable ALT/AZ lines}
    mainwindow.insertlines1.checked:=false;{disable ALT/AZ lines}
  end;
end;

procedure Tmainwindow.LinestartAzALT1Click(Sender: TObject);
begin
  linepoint_counter:=0;{pointer counter}
  suppl2_activated:=1; {always activate supplement 2}
  label_all_lines:=false;
  if mainwindow.LinestartAzALT1.checked then
  begin
    mainwindow.movelines1.checked:=false;
    mainwindow.Linestart1.checked:=false;
    mainwindow.hidelines1.checked:=false;
    mainwindow.colorchange1.checked:=false;{disable ALT/AZ lines}
    mainwindow.Removelines1.checked:=false;{disable ALT/AZ lines}
    mainwindow.insertlines1.checked:=false;{disable ALT/AZ lines}
  end;
end;
procedure Tmainwindow.hidelines1Click(Sender: TObject);
begin
  suppl2_activated:=1; {always activate supplement 2}
  if mainwindow.hidelines1.checked then
  begin
    mainwindow.movelines1.checked:=false;
    mainwindow.Linestart1.checked:=false;
    mainwindow.LinestartAzALT1.checked:=false;{disable ALT/AZ lines}
    mainwindow.colorchange1.checked:=false;{disable ALT/AZ lines}
    mainwindow.Removelines1.checked:=false;{disable ALT/AZ lines}
    mainwindow.insertlines1.checked:=false;{disable ALT/AZ lines}
    label_all_lines:=true;
  end
  else
  begin
    label_all_lines:=false;
  end;
  missedupdate:=2;
  paint_sky; {rewrite window}
end;

procedure Tmainwindow.Colorchange1Click(Sender: TObject);
begin
  suppl2_activated:=1; {always activate supplement 2}
  if mainwindow.colorchange1.checked then
  begin
    mainwindow.movelines1.checked:=false;
    mainwindow.hidelines1.checked:=false;
    mainwindow.Linestart1.checked:=false;
    mainwindow.LinestartAzALT1.checked:=false;{disable ALT/AZ lines}
    mainwindow.Removelines1.checked:=false;{disable ALT/AZ lines}
    mainwindow.insertlines1.checked:=false;{disable ALT/AZ lines}
    label_all_lines:=true;
  end
  else
  begin
    label_all_lines:=false;
  end;
  missedupdate:=2;
  paint_sky; {rewrite window}
end;

procedure Tmainwindow.Removelines1Click(Sender: TObject);
begin
  suppl2_activated:=1; {always activate supplement 2}
  if mainwindow.Removelines1.checked then
  begin
    mainwindow.movelines1.checked:=false;
    mainwindow.hidelines1.checked:=false;
    mainwindow.Linestart1.checked:=false;
    mainwindow.LinestartAzALT1.checked:=false;{disable ALT/AZ lines}
    mainwindow.colorchange1.checked:=false;{disable ALT/AZ lines}
    mainwindow.insertlines1.checked:=false;{disable ALT/AZ lines}
    label_all_lines:=true;
  end
  else
  begin
    label_all_lines:=false;
  end;
  missedupdate:=2;paint_sky; {rewrite window}
end;

procedure Tmainwindow.Insertlines1Click(Sender: TObject);
begin
  suppl2_activated:=1; {always activate supplement 2}
  if mainwindow.insertlines1.checked then
  begin
    mainwindow.movelines1.checked:=false;
    mainwindow.hidelines1.checked:=false;
    mainwindow.Linestart1.checked:=false;
    mainwindow.LinestartAzALT1.checked:=false;{disable ALT/AZ lines}
    mainwindow.Removelines1.checked:=false;{disable ALT/AZ lines}
    mainwindow.colorchange1.checked:=false;{disable ALT/AZ lines}
    label_all_lines:=true;
  end
  else
  begin
    label_all_lines:=false;
  end;
  cut_position:=0;
  missedupdate:=2;
  paint_sky; {rewrite window}
end;

procedure Tmainwindow.PopupMenu1Popup(Sender: TObject);
begin
  starty:=-9999;{prevent problems pull square start to early after mouse click when screen has not finished painting}

  if  size_pulled_rectangle>4 then
  begin
    mx:=centerX;{overwrite mouse position with center rubber square}
    my:=centerY;
  end;
  get_ESO1.enabled:=((zoom>zoom_show_DSS) and (sep_height<=2*60)); {enable ESO if <=1 degrees}
  Get_mast1.enabled:=((zoom>zoom_show_DSS) and (sep_height<=2*60)); {enable Mast if <=1 degrees}
  Editobject1.Enabled:=((mode>=1) and (mode<=9));{supplement object clicked on?}
  mouse_radec(image1.canvas,mx,my,popupmouse_ra, popupmouse_dec);  {find mouse position center square or mouse  position, note variabels RA2 and DEC don't work for Linux, overwritten? }
  if sep_height=0 then sep_height:=6 {pixels}* field_factor/(work_height*zoom);{arc_min, used search field for Simbad, Ned and internal}
end;

procedure Tmainwindow.PopupMenu_menubar1Popup(Sender: TObject);
begin
  {Update_hints popupmenu}
  mainwindow.save_onoff.hint:=savesettingstoolbutton.hint;  {default is off}
  mainwindow.time_onoff.hint:=enterdatetimetoolbutton.hint;
  mainwindow.gotoradec_onoff.hint:=gotoradectoolbutton.hint;
  mainwindow.tools_onoff.hint:=instrumentstoolbutton.hint;
  mainwindow.foundmarker_onoff.hint:=foundobjectmarkertoolbutton.hint;
  mainwindow.undo_onoff.hint:=undotoolbutton.hint;
  mainwindow.redo_onoff.hint:=redotoolbutton.hint;
  mainwindow.settings_onoff.hint:=settingstoolbutton.hint;
  mainwindow.Animation_onoff.Hint:=Animatetoolbutton.hint;
  mainwindow.deephlp_onoff.hint:=deephlptoolbutton.hint;
  mainwindow.Darknights_onoff.Hint:=Darknightstoolbutton.Hint;
   mainwindow.solarsystem_onoff.hint:=solarsystemtonighttoolbutton.hint;
  mainwindow.slew_onoff.hint:=telescope_aborttoolbutton.hint;
  mainwindow.gridRA_onoff.hint:=gridRAtoolbutton.hint;
  mainwindow.gridAZ_onoff.hint:=gridAZtoolbutton.hint;
  mainwindow.milkyway_onoff.hint:=milkyway1.hint;
  mainwindow.earth_onoff.hint:=earth1.hint;
  mainwindow.constellations_onoff.hint:=constellationstoolbutton.hint;
  mainwindow.fits_onoff.hint:=fitstoolbutton.hint;
  mainwindow.flipH_onoff.hint:=flipHtoolbutton.hint;
  mainwindow.flipV_onoff.hint:=flipVtoolbutton.hint;
  mainwindow.Northabove_onoff.hint:=Northabovetoolbutton.hint;
  mainwindow.Sidereal_onoff.hint:=Siderealtoolbutton.hint;
end;

procedure Tmainwindow.Cleardownload1Click(Sender: TObject);
var cSearchRec: TSearchRec;
    iFind:integer;
begin
  if Application.MessageBox(pchar(delete_question_string_dss),
			   pchar(striphotkey(Cleardownload1.caption)),  { stripHotKey to  remove automatic added "&"}
			   MB_YESNO Or MB_ICONWARNING)= IDYES then
  begin
    iFind := FindFirst(dss_path+'down*.fit*', faAnyFile, cSearchRec);
    while iFind = 0 do
    begin
      DeleteFile(dss_path + cSearchRec.Name);
      iFind := FindNext(cSearchRec);
    end;
    FindClose(cSearchRec);
    missedupdate:=2; {rewrite window}
    paint_sky; {rewrite window}
  end;
end;

procedure Tmainwindow.clearvisibledownload1Click(Sender: TObject); {delete visible files}
var cSearchRec: TSearchRec;
    iFind,error2,error3: integer;
    raf,decf,dist      : double;
begin
  iFind := FindFirst(dss_path+'down*.fit*', faAnyFile, cSearchRec);
  while iFind = 0 do
  begin
    val(copy(cSearchRec.Name,9,4),raf,error2); {extract ra in range 0..10000}
    val(copy(cSearchRec.Name,13,4),decf,error3);{extract southpole distance in range 0..10000}
    if ((error2=0) and (error3=0)) then
    begin
      ang_sep(telescope_ra,telescope_dec,raf*pi*2/10000,-(pi/2) + decf*pi/10000,dist);{use ra [0..9999] and south pole distance [0..9999]}
      if dist <2/zoom then {fits center is in view }
          DeleteFile(dss_path + cSearchRec.Name);
    end;
    iFind := FindNext(cSearchRec);
  end;
  FindClose(cSearchRec);
  missedupdate:=2; {rewrite window}
  paint_sky; {rewrite window}
end;

procedure Tmainwindow.Followsolarobject1Click(Sender: TObject);
begin
   if ((Followsolarobject1.checked=false) and (follownaam2<>'')) then
   begin
     telescope_follow_solar:=1;{follow}
     Followsolarobject1.checked:=true;
     missedupdate:=2; {rewrite window}
     paint_sky; {rewrite window}
   end
   else
   begin
     Followsolarobject1.checked:=false;
     telescope_follow_solar:=0;{follow}
   end;
end;

procedure Tmainwindow.Sidereal1Click(Sender: TObject);
begin
  if sidereal<>0 then
  begin
   sidereal:=0;
   missedupdate:=2;
   {wtime2 is following wtime2actual and updated}
    wtime2:=wtime2actual;{update already wtime2}
  end
  else
  begin
    sidereal:=1;
    missedupdate:=1;
    {wtime2 is frozen. wtime2actual is updated}
  end;
  paint_sky; {rewrite window}
end;

procedure Tmainwindow.Polarscopeview1Click(Sender: TObject);
begin
  polarscope_visible:=true;{for use in maakplaatje, do not follow solar objects}
  polarscope:=Tpolarscope.Create(self); {in project option not loaded automatic}
  polarscope.color:=colors[0];
  polarscope.Caption:=polarview;
  polarscope.ShowModal;
  polarscope.release;
  polarscope_visible:=false;
end;

procedure Tmainwindow.Deletelastpoint1Click(Sender: TObject);
begin
  if linepoint_counter>0 then {could be line or frame}
  begin
    supplstring2.delete(supplstring2.count-1);
    dec(linepoint_counter);
  end;
  missedupdate:=2;paint_sky; {rewrite window}
end;

{$IFDEF FPC}
function StripHotkey(const Text: string): string; {remove &}
var
  I: Integer;
begin
   Result := Text;
   I := 1;
   while I <= Length(Result) do
   begin
     if Result[i] = cHotkeyPrefix then
       if SysLocale.FarEast and
         ((I > 1) and (Length(Result)-I >= 2) and
          (Result[I-1] = '(') and (Result[I+2] = ')')) then
         Delete(Result, I-1, 4)
       else
         Delete(Result, I, 1);
    Inc(I);
  end;
end;
  {$ENDIF}

procedure Tmainwindow.Deleteonlinecache1Click(Sender: TObject);
var cSearchRec: TSearchRec;
    iFind     : integer;
begin
  if Application.MessageBox(pchar(Delete_question_string),
			   pchar(striphotkey(Deleteonlinecache1.caption)),  { stripHotKey to  remove automatic added "&"}
			   MB_YESNO Or MB_ICONWARNING)= IDYES then
  begin {delete cache}
    iFind := FindFirst(cache_path + '*.txt', faAnyFile, cSearchRec);
    while iFind = 0 do
    begin
       DeleteFile(cache_Path + cSearchRec.Name);
      iFind := FindNext(cSearchRec);
     end;
    FindClose(cSearchRec);
  end;
end;

procedure Tmainwindow.Undoview1Click(Sender: TObject);
begin
  if z_buffer[ round(fnmodulo(z_position-1,z_length)),3]>0 then {z buffer is filled, possible to go back}
  begin
    z_position:=round(fnmodulo(z_position-1,z_length));{go back}
    telescope_ra  :=z_buffer[z_position,1];
    telescope_dec :=z_buffer[z_position,2];
    zoom          :=z_buffer[z_position,3];

    undo_used:=true;{do no store this repaint}

    ra_az(telescope_ra,telescope_dec,latitude,0,wtime2,{var} viewx,viewy); {move sphere to center object}
    missedupdate:=2;paint_sky;{rewrite window}
  end;
end;

procedure Tmainwindow.Redoview1Click(Sender: TObject);
begin
  if z_buffer[ round(fnmodulo(z_position+1,z_length)),3]>0 then {z buffer is filled, possible to go forward}
  begin
    z_position:=round(fnmodulo(z_position+1,z_length));{go forward}
    telescope_ra  :=z_buffer[z_position,1];
    telescope_dec :=z_buffer[z_position,2];
    zoom          :=z_buffer[z_position,3];

    undo_used:=true;{do no store this repaint}

    ra_az(telescope_ra,telescope_dec,latitude,0,wtime2,{var} viewx,viewy); {move sphere to center object}
    missedupdate:=2;paint_sky;{rewrite window}
  end;
end;

procedure Tmainwindow.LTCPComponentConnect(aSocket: TLSocket);
begin
  statusbar1.caption:='Connected to remote host';
  statusbarfree:=false;
end;
procedure Tmainwindow.LTCPComponentError(const msg: string; aSocket: TLSocket);
begin
  if server_on then beep;
  statusbar1.caption:=msg;
  statusbarfree:=false;
end;

procedure Tmainwindow.LTCPComponentAccept(aSocket: TLSocket);
begin
  statusbar1.caption:=tcp_conn_accept_string;
  statusbarfree:=false;
end;

procedure Tmainwindow.LTCPComponentReceive(aSocket: TLSocket);
var
  s,answer: string;
begin
  if aSocket.GetMessage(s) > 0 then
  begin
    answer:=read_request(s);
    statusbar1.caption:=s+' | '+answer;

    if server_on then // send feedback message
        SendToAll(answer);
  end;
end;

procedure Tmainwindow.LTcpComponentDisconnect(aSocket: TLSocket);
begin
  statusbar1.caption:= tcp_conn_lost_string;
  statusbarfree:=false;
end;

procedure Tmainwindow.SendToAll(const aMsg: string);
var
  n: Integer;
begin
  if length(aMsg)=0 then exit;
  ltcp1.IterReset; // start at server socket
  while ltcp1.IterNext do
  begin // skip server socket, go to clients only
    n := ltcp1.SendMessage(aMsg+#13+#10 {CRLF} , ltcp1.Iterator);
    if n < Length(aMsg)+2 then  {2 for CRLF}
      statusbar1.caption:=('Error on send [' + IntToStr(n) + ']');
  end;
end;

procedure alpaca_send_http_get(mess: string);{send a http GET to Alpaca}
var st: string;
begin
  if alpaca_connected then
  begin
   {'GET /api/v1/telescope/0/rightascension HTTP/1.1'+#13+#10}
   {'Host: 127.0.0.1:11111'+#13+#10}
   {#13+#10}
    st:='GET /api/v1/telescope/'+alpaca_telescope+'/'+mess+' HTTP/1.1'+#13+#10+
                                    'Host: '+alpaca_address+':'+alpaca_port+#13+#10+#13+#10;
    mainwindow.alpaca1.SendMessage(st);
  end;
end;

procedure alpaca_send_http_put(mess,param: string);{send a http PUT to Alpaca}
var st:string;
begin
  if alpaca_connected then
  begin
    {'PUT /api/v1/telescope/0/slewtocoordinates HTTP/1.1'+#13+#10}
    {'Host: 127.0.0.1:11111'+#13+#10}
    {Content-Length: 65}
    {#13+#10}
    {'RightAscension=23.000&Declination=89.0000&ClientID=0&ClientTransactionID=0'#13+#10}
    {#13+#10}

    {'PUT /api/v1/telescope/0/park HTTP/1.1'+#13+#10}
    {'Host: 127.0.0.1:11111'+#13+#10}
    {Content-Length: 32}
    {#13+#10}
    {'ClientID=0&ClientTransactionID=0'#13+#10}
    {#13+#10}

    {'PUT /api/v1/telescope/0/tracking HTTP/1.1'+#13+#10}
    {'Host: 127.0.0.1:11111'+#13+#10}
    {Content-Length: 42}
    {#13+#10}
    {'tracking=true&ClientID=0&ClientTransactionID=0'#13+#10}
    {#13+#10}

    st:='PUT /api/v1/telescope/'+alpaca_telescope+'/'+mess+' HTTP/1.1'+#13+#10+
        'Host: '+alpaca_address+':'+alpaca_port+#13+#10+
        'Content-Length: '+inttostr(length(param))+#13+#10+
        #13+#10+
        param+#13+#10+
        #13+#10;
    mainwindow.alpaca1.SendMessage(st);
  end;
end;

function switch_server_onoff(on1: boolean):boolean; {server host for remote control via TCP/IP}
begin
  result:=false;
  if  ((on1) and  (mainwindow.ltcp1.Listen(strtoint(SERVER_port) )) ) then
  begin
      mainwindow.statusbar1.caption:=tcp_online_string;
      statusbarfree:=false;
      result:=true;
  end
  else
  begin {off}
      mainwindow.ltcp1.Disconnect;
      mainwindow.statusbar1.caption:=tcp_offline_string;
      statusbarfree:=false;
  end;
end;

procedure switch_alpaca_client_onoff(on1: boolean); {client on/off for Alpaca remote control http via TCP/IP}
begin
  if  on1 then
    mainwindow.alpaca1.Connect(alpaca_address, StrToInt(alpaca_port) )
  else
    mainwindow.alpaca1.Disconnect;

  mainwindow.ascom_timer.enabled:=on1;{start requesting info, and reconnect if connections fails}
  update_telescope_menu(on1);
  mainwindow.ascom_timer.enabled:=on1;
end;

begin {ASCOM fix 2018}
 {"failed to load driver" fix by Patrick Chevalley for ASCOM problem getting properties of "ASCOM.AdvancedLX200.Telescope"}
 {   Probably .NET and other VB disable this FPU exception by default and this is why the exception in the driver initialization do not hurt them.}
 {   Now I add this to Skychart and also to CCDciel to be sure it continue to work if there is a change in the TAchart package.}

 {$if defined(cpui386) or defined(cpux86_64)}
 SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide,exOverflow, exUnderflow, exPrecision]);
 {$endif}
end.
