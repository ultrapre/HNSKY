UNIT hns_Uast;
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

{1  Calculates julian day}
{2) conversion between az,alt to ra,dec and back}
{3) calculates solar system moons}
{4) parallax
{and some other things }

Interface

function star_class(b_v,B_V_error:double):string; {estimate star class from B_V difference}

function daylichtsaving(Europe:boolean; y,m :integer;day:double): boolean;{simple formula for Europe, USA using current rules valid 30000 year or more}
procedure calculate_julian(year2,month2,day2,hour2,min2,sec:integer);{update julian_UT and julian_ET}

function riseset(planet_number: integer; ra9,dec9 {ra,dec equinox date }:double) :string;{if planet_number is -1 then rise set time based on mean ra, dec position, else recalculate planet position}

procedure de_toast(x1, y1, size : integer; var lon,lat :double); {de-TOAST x,y coordinates to lat, lon. The origin (0,0) is top left of TOAST projection, size:=height or witdh}
{ inverse Tessellated Octahedral Adaptive Subdivision Transform (TOAST) projection}

function prepare_dec(decx:double):string; {radialen to text, format 90d 00 00}
function prepare_dec2(decx:double):string; {radialen to text  format 90d 00 }
function prepare_ra(rax:double):string; {radialen to text, format 24: 00 00.0 }
function prepare_ra2(rax:double):string; {radialen to text  format 24d 00}
function prepare_ra3(rax:double):string; {radialen to text  format 24d 00.0}
function prepare_IAU_designation(rax,decx :double):string;{radialen to text hhmmss.s+ddmmss  format}
function prepare_time(days:double):string; {time to string format 365d 24:00:00}

procedure checkleapyear(year3:integer);{28 or 29 days in february}
{$IFDEF fpc}
function inttoStr2(Value: Integer):ansistring;{fast str routine for FPC}
{$ENDIF}

var   ecliptic2       : double;
      ring_inc        : double;
      moon_distance   : double;
      dec_shadow,ra_shadow    : double;{moon positions,  helocentric}

const
      siderealtime2000=(280.46061837)*pi/180;{[radians],  90 degrees shifted sidereal time at 2000 jan 1.5 UT (12 hours) =Jd 2451545 at meridian greenwich, see new meeus 11.4}
      earth_angular_velocity = pi*2*1.00273790935; {about(365.25+1)/365.25) or better (365.2421874+1)/365.2421874 velocity dailly. See new Meeus page 83}
      AE=149597870.700; {ae has been fixed to the value 149597870.700 km as adopted by the International Astronomical Union in 2012.  Note average earth distance is 149597870.662 * 1.000001018 see meeus new 379}
      days  : array[0..12] of integer=(31,31,28,31,30,31,30,31,31,30,31,30,31);{dec=0=special, jan=1, febr... dec}
      moon_data : array[0..9 {planet},0..8 {moon},0..6
                       {distance, theta orbit,phi orbit, orbittime,orbit pos, diam, delta mag} ] of real =
     { Data from REPORT OF THE IAU/IAG WORKING GROUP ON CARTOGRAPHIC COORDINATES AND ROTATIONAL ELEMENTS OF THE PLANETS AND SATELLITES: 2009}
        {    0=distance, 1=theta orbit  , 2=phi orbit     ,3=orbitspeed [deg],4=orbit pos, 5=diam, 6=delta mag}
      (
{Sun}  ((0.5*1392720/AE,   63.87 *pi/180 ,   286.13*pi/180   ,14.1844000      ,84.10-180         ,1392720/AE,          0),  {Sun}
        (0,0,0,0,0,0,0),  { Note: Length of day or Differential Rotation once every 25.38 Earth days; near the poles it's as much as 36 Earth days.}
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0)),
{Merc} ((2439.7/AE    ,   61.4143  *pi/180 ,   281.0097*pi/180   ,6.1385025       ,329.5469-180    ,2*2439.7/AE,          0),  {Mercury}
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0)),
         {    0=distance, 1=theta orbit  , 2=phi orbit     ,3=orbitspeed [deg],4=orbit pos, 5=diam, 6=delta mag}
{venus}((6051.8/AE    ,    67.16 *pi/180 ,   272.76 *pi/180,- 1.4813688       ,160.20-180     , 2*6051.8/AE,    0),  {Venus}
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0)),

{Earth}((6378.14/AE    ,      90*pi/180 ,       0         ,360.9856235       ,190.16-180      ,2* 6356.75/AE,          0),  {Earth}
        (1999/AE       , 66.5392*Pi/180 ,269.9949*Pi/180  , 13.17635815      ,38.3213         , 3476/AE,     -12.7 ),  {moon}
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0)),

{mars} (( (3396.2)/AE  , 52.88650*Pi/180, 317.68143*Pi/180,  350.89198226    ,176.630-180,2*3396.2/AE, 0        ),  {Mars surface}
        (     9400/AE  , 52.9*Pi/180    , 317.68*Pi/180   , 1128.8445850     , 35.06     ,        12/AE, 11.6+1.25),{at J2000 278.88 geolong}
        (    23500/AE  , 53.52*Pi/180   , 316.65*Pi/180   ,  285.1618970     , 79.41     ,         7/AE, 12.7+1.25),{at J2000 330.95 geolong}
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0)),

        {    0=distance, 1=theta orbit  , 2=phi orbit     ,3=orbitspeed [deg],4=orbit pos, 5=diam, 6=delta mag} {https://www.projectpluto.com/jeve_grs.htm
{jup}  ((   71492/AE   , 64.49*Pi/180   , 268.056595*Pi/180, 870.2835 {2017} , 30     ,2*71492/AE  , 0  ), {red  spot, Jupiter system II}
        (  421600/AE   , 64.50*pi/180   , 267.05*pi/180   , 203.4889538      , 200.39  -0.558{ +3 min correction, 2018 valid up to 2100} ,   3630/AE  , 8.1),  {io}
        (  670900/AE   , 64.51*pi/180   , 268.08*pi/180   , 101.3747235      ,  35.72  -1.267{+18 min correction, 2018 valid up to 2100} ,   3138/AE  , 8.4 ),  {europa}
        ( 1070000/AE   , 64.57*pi/180   , 268.20*pi/180   , 050.3176081      ,  43.14  -1.54 {+44 min correction, 2018 valid up to 2100} ,   5262/AE  , 7.6),  {ganym}
        ( 1880000/AE   , 64.83*pi/180   , 268.72*pi/180   , 021.5710715      ,  259.67 +0.689{-46 min correction, 2018 valid up to 2100} ,   4800/AE  , 8.9),   {callisto}
        (11460000/AE  ,  67.43*pi/180   , 275.67*pi/180   , 360/250.56       ,  0            ,     85/AE  ,14.8-1.7), {Himalia, wikipedia reference 2}
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0)),


        {    0=distance, 1=theta orbit  , 2=phi orbit     ,3=orbitspeed [deg],4=orbit pos, 5=diam, 6=delta mag}
{sat}  ((   117000/AE  , 83.537*Pi/180  , 40.589*Pi/180   , 810.7939024      ,38.90-180  ,2*60268/AE,   0 ) ,{Saturn ring/Saturn}
        (   185500/AE  , 83.52*Pi/180   , 40.66*Pi/180    , 381.9945550      ,337.46  ,    392/AE, 12.8) ,{mimas, 1995 8 5 10:3049.6 1TRI, 1995 8 5 12:5216.3 1TRE}
        (   238000/AE  , 83.52*Pi/180   , 40.66*Pi/180    , 262.7318996      ,2.82    ,   500/AE, 11.6) ,{1995 8 6  08:0459.3 2TRI, 1995 8 6 10:4459.9 2TRE}
        (   294660/AE  , 83.52*Pi/180   , 40.66*Pi/180    , 190.6979085      ,10.45   ,   1060/AE, 10.1) ,{1995 8 6  08:0809.8 3TRI, 1995 8 6 11:0555.7 3TRE}
        (   377400/AE  , 83.537*Pi/180  , 40.66*Pi/180    , 131.5349316      ,357     ,   1120/AE, 10.3) ,{Dione, 1995 8 5  04:0938.1 4TRI, 1995 8 5 07:2959.7 4TRE}
        (   527040/AE  , 83.55*Pi/180   , 40.38*Pi/180    ,  79.6900478      ,235.16  ,   1530/AE,  9.6) ,{Rhea, 1995 8 7  03:3254.4 5TRI, 1995 8 7  07:2947.5 5TRE }
        (  1221830/AE  , 83.4279*Pi/180 , 39.4827*Pi/180  ,  22.5769768      ,189.64  ,   5150/AE,  8.2) ,{Titan} {1995 7 5 19:04 7.2 6TRI, 1995 7 6 00:5825.5 6TRE, 1995 8 5 03:4539.6 7TRI , 1995 8 5 10:0105.4 7TRE}{1995 3 31 21:3811.9 6TRI, 1995 4 1  01:0339.5 6TRE}
        (  1481100/AE  , 83.52*Pi/180   , 40.66*Pi/180    ,  16.919989618    ,127.95  {2009},    280/AE, 14.1) ,{hyp}   {variation position 40 degrees, at 2008-07-19 12:03 UT  RA of Saturn and IAP same see http://pds-rings.seti.org/tools/index.html 16.919989458846567138588672659257}
        (  3561300/AE  , 75.03*Pi/180   ,318.16*PI/180    ,   4.5379572      ,350.2   ,   1460/AE, 12.0)),{Iap}   {at 2008-07-17 21:46 UT  RA of Saturn and IAP same see http://pds-rings.seti.org/tools/index.html}

        {    0=distance, 1=theta orbit  , 2=phi orbit     ,3=orbitspeed [deg],4=orbit pos, 5=diam, 6=delta mag}
{Uran} ((     25559/AE , -15.175*Pi/180  ,257.311*Pi/180    , -501.1600928     , 203.81-180,2*25559/AE, 6.2), {Uranus}
        (    191000/AE , -15.10 *Pi/180  ,257.43 *Pi/180    , -142.8356681     , 156.22    ,   1153/AE, 14.5-6.2),{Ariel}
        (    266000/AE , -15.10 *Pi/180  ,257.43 *Pi/180    , -086.8688923     , 108.05    ,   1172/AE, 15.2-6.2),
        (    435900/AE , -15.10 *Pi/180  ,257.43 *Pi/180    , -041.3514316     , 77.74     ,   1580/AE, 14.1-6.2),
        (    583500/AE , -15.10 *Pi/180  ,257.43 *Pi/180    , -026.7394932     ,  6.77     ,   1524/AE, 14.0-6.2), {oberon}
        (0,0,0,0,0,0,0),   {source theta/phi = N.Pole-RA, N.Pole-DC astronomical supplement}
        (0,0,0,0,0,0,0),   {see also theta/phi = N.Pole-RA, N.Pole-DC from http://ssd.jpl.nasa.gov/cgi-bin/eph}
        (0,0,0,0,0,0,0),   {see ook S&W photos 9/2000, blz 794}
        (0,0,0,0,0,0,0)),

        {    0=distance, 1=theta orbit  , 2=phi orbit     ,3=orbitspeed [deg],4=orbit pos, 5=diam, 6=delta mag}
{Nept} ((    24764/AE  , 43.46*Pi/180   ,299.36*Pi/180    ,  +536.3128492  ,253.18        ,2*24764/AE ,     8.4 ),  {neptune surface}
        (   354760/AE  , 41.17*Pi/180   ,299.36*Pi/180    ,   -61.2572637  ,296.53        , 1352.6/AE ,13.6-8.4 ),  {triton}
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0)),

      {    0=distance, 1=theta orbit  , 2=phi orbit     ,3=orbitspeed [deg],4=orbit pos, 5=diam, 6=delta mag}
{pluto}((   1188/AE  ,-6.163*Pi/180   ,132.993*Pi/180    ,  56.3625225  ,122.695      ,2*1188/AE ,    15.1 ),  {pluto surface}
      (   19596 /AE  ,-6.163*Pi/180   ,132.993*Pi/180    ,  56.3625225  ,122.695      , 2*606/AE ,     1.9 ),  {Charon}
      (0,0,0,0,0,0,0),
      (0,0,0,0,0,0,0),
      (0,0,0,0,0,0,0),
      (0,0,0,0,0,0,0),
      (0,0,0,0,0,0,0),
      (0,0,0,0,0,0,0),
      (0,0,0,0,0,0,0)));

// Europa shortest distance to Jupiter
// 2030-Jun-06 02:28

function limit_radialen(z,range:double):double;

Function LeadingZero(w : integer) : String;

Function floattostr2(x:double):string;
procedure val_local(s:string;var x:double;var error1:integer);{uses the current decimal seperator, either dot or komma}
procedure str_local(const x:double; width1,decimals1 :word; var S: String);{uses the current decimal seperator, either dot or komma}
function floattostrF_local(const x:double; width1,decimals1 :word): string;{uses the current decimal seperator, either dot or komma}
function strtofloat_local(s:string): double;{uses the current decimal seperator, either dot or komma}

function number_of_decimals_required(inp:double):integer;

FUNCTION fnmodulo (x,range: double):double;

FUNCTION delta_T(jd:double) : double; {calculates difference dynamic time and UT. Max error about 10 seconds. Range 1680 - 2010}

Function julian_calc(yyyy,mm:integer;dd,hours,minutes,seconds:double):double; {##### calculate julian day}

FUNCTION JdToDate(jd:double):string;{Returns Date from Julian Date,  See MEEUS 2 page 63}

PROCEDURE JdToDate_integers(jd:double;var year,month,day,HH,MM,SS:integer);{Returns Date from Julian Date,  See MEEUS 2 page 63}

FUNCTION JdToDate_2(jd:double):string;{Returns Date from Julian Date,  See MEEUS 2 page 63}
FUNCTION JdToDate_3(jd:double):string;{Variant with month and day only, {Returns Date from Julian Date,  See MEEUS 2 page 63}

Function asteroid_magn_comp(g ,b :double):double; {Magnitude change by phase asteroid, New meeus 32.14}
      {g = slope parameter,  b= angle sun-asteroid-earth}

PROCEDURE AZ_RA(AZ,ALT,LAT,LONG,t:double;var ra,dcr: double);{conversion az,alt to ra,dec}
{input AZ [0..2pi], ALT [-pi/2..+pi/2],lat[-90..90],long[0..360],time[0..2*pi]}


PROCEDURE RA_AZ(RA,dec,LAT,LONG,t:double;var azimuth2,altitude2: double);{conversion ra & dec to altitude,azimuth}
{input RA [0..2pi], DEC [-pi/2..+pi/2],lat[-90..90],long[0..360],time[0..2*pi]}

function altitude(RA,dec,LAT,LONG,t:double):double;{conversion ra & dec to altitude only. This routine is created for speed, only the altitude is calculated}
{input RA [0..2pi], DEC [-pi/2..+pi/2],lat[-90..90],long[0..360],time[0..2*pi]}

procedure GAL_EQU(l,b:double;var ra,dec: double);{galactic to equatorial coordinates}
procedure EQU_GAL(ra,dec:double;var l,b: double);{equatorial to galactic coordinates}
procedure EQU_GAL1950(ra,dec:double;var l,b: double);{equatorial to galactic coordinates}

PROCEDURE MOON_RADEC (planet, moon:integer; moon_anomoly ,planet_R,dia_planet,planet_RA,planet_dec:double;VAR geo_long,magm,RA,DCR :double);

function altitude_apparent(altitude_real:double):double;  {atmospheric refraction, real to seen}

function altitude_to_true(altitude_seen:double):double;  {atmospheric refraction, seen to real}

PROCEDURE PARALLAX_XYZ(WTIME,latitude: double;var X,Y,Z: double);{calculates parallax. X, Y, Z in AE}

PROCEDURE ang_sep(ra1,dec1,ra2,dec2 : double;var sep: double); {calculates angular separation. according formula 9.1 old meeus, 16.1 new meeus}

procedure find_inc_ring(ra,dec:double); {find inclination SATURN ring}

PROCEDURE Update_theta_phi(julian:double);{recalculate moon orientation}

PROCEDURE planetmoons(planet,moon: integer; julian,ra,dcr,mag_planet,delta,
                                               dia_planet:double;var ram,decm ,magm,diameterm : double);
procedure rotate(rot,x,y :double;var  x2,y2:double); {rotate a vector point}

procedure standard_equatorial(ra0,dec0,x,y,cdelt: double; var ra,dec : double);{CCD coordinates to RA,DEC}

PROCEDURE EQUHOR2 (DEC,TAU,PHI: double; VAR H,AZ: double);

procedure nutation_correction_equatorial(var ra,dec:double);  {Nutation only valid is DE430 called}
procedure aberration_correction_equatorial(var ra,dec:double);{aberration based on earth vectors. Only valid when DE430 is used}

Procedure nutation_aberration_correction_equatorial_classic(var ra,dec:double);{M&P page 208}

function Valint32(const s; var code: Integer): Longint;{fast val function, about 4 x faster}


Implementation
uses hns_uPla,math, sysutils {for string replace}, hns_main;

function star_class(B_V,B_V_error:double):string; {estimate star class from B_V difference}
var
   tempstr,tempstr2, error_string :string;
   temperature: double;
//O 	≥ 30,000 K 	blue 	blue 	≥ 16 M☉ 	≥ 6.6 R☉ 	≥ 30,000 L☉ 	Weak 	~0.00003%
//B 	10,000–30,000 K 	blue white 	deep blue white 	2.1–16 M☉ 	1.8–6.6 R☉ 	25–30,000 L☉ 	Medium 	0.13%
//A 	7,500–10,000 K 	white 	blue white 	1.4–2.1 M☉ 	1.4–1.8 R☉ 	5–25 L☉ 	Strong 	0.6%
//F 	6,000–7,500 K 	yellow white 	white 	1.04–1.4 M☉ 	1.15–1.4 R☉ 	1.5–5 L☉ 	Medium 	3%
//G 	5,200–6,000 K 	yellow 	yellowish white 	0.8–1.04 M☉ 	0.96–1.15 R☉ 	0.6–1.5 L☉ 	Weak 	7.6%
//K 	3,700–5,200 K 	orange 	pale yellow orange 	0.45–0.8 M☉ 	0.7–0.96 R☉ 	0.08–0.6 L☉ 	Very weak 	12.1%
//M 	2,400–3,700 K
begin
  if ((B_V<-0.35) or (B_V>2.4)) then begin result:=''; exit; end;
  if (B_V_error>=1 {B_V magnitude difference}) then begin result:=''; exit; end;

  temperature:=4600*( (1/((0.92*B_V)+1.7))+(1/((0.92*B_V)+0.62)) ); { Ballesteros' formula}

  if (temperature>=30000) then result:='O'
  else
  if (temperature>=10000) then result:='B'
  else
  if (temperature>=7500) then result:='A'
  else
  if (temperature>=6000) then result:='F'
  else
  if (temperature>=5200) then result:='G'
  else
  if (temperature>=3700) then result:='K'
  else
  if (temperature>=2400) then result:='M'
  else
  result:='';

  str(round(temperature/50)*50:0,tempstr);
  str(B_V:0:2,tempstr2);
  str(B_V_error:0:2,error_string);
  result:=';APASS B-V=' +tempstr2+' ± '+error_string+' (=> '+tempstr+' K , class '+result+')';
end;


function daylichtsaving(Europe:boolean; y,m :integer;day:double): boolean;{simple formula for Europe, USA using current rules valid 30000 year or more}
var
   d1,d2,numberhunderd, numberfourhunderd, correction : integer;
begin
  if y<1977 then begin result:=false; exit; end {no daylight saving before this, arbitrair}
  else
  begin
     numberhunderd:=trunc((y-2000)/100);
     numberfourhunderd:=trunc((y-2000)/400);
     correction:=(numberhunderd-numberfourhunderd) mod 7;

    if Europe then {Europe, Since 1996, valid through 2099, http://www.webexhibits.org/daylightsaving/i.html}
          Case m of 1: result:=false;
                    2: result:=false;
                    3: begin
                         result:=false;
                         d1:=31 - trunc(5*y/4 + 4 - correction) mod 7;
                         if day>=d1+2/24 then result:=true;
                       end;
                    4: result:=true;
                    5: result:=true;
                    6: result:=true;
                    7: result:=true;
                    8: result:=true;
                    9: result:=true;
                   10: begin
                         result:=true;
                         d2:=31 - trunc(5*y/4 + 1 -correction) mod 7;
                         if day>=d2+2/24 then result:=false;{detection in wintertime}
                       end;
                   11: result:=false;
                   12: result:=false;
                End{case Europe}
     else
     {USA daylight saving, valid 2007 and after}
          Case m of 1: result:=false;
                    2: result:=false;
                    3: begin
                         result:=false;
                         d1:=14 - trunc(y*5/4 + 1 -correction) mod 7;
                         if day>=d1+2/24 then result:=true;
                       end;
                    4: result:=true;
                    5: result:=true;
                    6: result:=true;
                    7: result:=true;
                    8: result:=true;
                    9: result:=true;
                   10: result:=true;
                   11: begin
                         result:=true;
                         d2:=7 - trunc(y*5/4 + 1 - correction) mod 7;
                         if day>=d2+1/24 then result:=false;{detection in wintertime}
                       end;
                   12: result:=false;
                End;{case USA}
  end;
end;

procedure calculate_julian(year2,month2,day2,hour2,min2,sec:integer);{update julian_UT and julian_ET}
begin
  julian_UT:=julian_calc(year2,month2,day2,hour2-(timezone+daylight_saving),min2,sec);{julian time with delta T}

  if Time_Reference='UTC' then julian_ET:=julian_UT+delta_T(julian_UT) {calculates difference dynamic time and UT between 1700 and 2250 in days. new meeus page 74}
  else julian_ET:=julian_UT;
  equinox_date:=2000+(julian_ET-2451545.0)/365.25;

   wtime2actual:=limit_radialen((-longitude*pi/180)+siderealtime2000 +(julian_UT-2451545 )* earth_angular_velocity,2*pi); {longitude is positive towards west so has to be subtracted from time.}
         {change by time & longitude in 0 ..pi*2, simular as siderial time}
         {2451545...for making dayofyear not to big, otherwise small errors occur in sin and cos}
end;

function riseset(planet_number: integer; ra9,dec9 {ra,dec equinox date }:double) :string;{if planet_number is -1 then rise set time based on mean ra, dec position, else recalculate planet position}
var oldalt, rtime,stime,ztime,delta09,diameter9 :double;
    timetel,stepsize : integer;
    never,always : boolean;
    rh,rm,sh,sm  : string;
    azimuth2,altitude2,highest_altitude, time: double;
begin
  oldalt:=999; stime:=999; rtime:=999;ztime:=0;
  always:=false; never:=false;
  stepsize:=4;
  highest_altitude:=-999;
  for timetel:=0 to 24*stepsize do
  begin
    time:=timetel/stepsize;
    calculate_julian(year2,month2,day2,trunc(time),round(frac(time)*60),0);{recalculate julian and wtime}

    if planet_number>=0 then {calculate ra dec at exact moment for sun and moon, mercury, venus}
    begin
      planet(0,0 {equinox date},julian_ET,ra9,dec9,dummy,diameter9,delta09,dummy,dummy);{sun always before planets}
      {watch out ra and dec ...etc are modified}
      if planet_number>0 then
                   planet(planet_number,0 {equinox date},julian_ET,ra9,dec9,dummy,diameter9,delta09,dummy,dummy);
      diameter9:=diameter9*(10/60);
    end; {sun , moon.... position}
    ra_az(ra9,dec9,reallatitude,0, wtime2actual,azimuth2,altitude2); {new 19-12-2000, for current date !!}

    altitude2:=altitude2 - apparent_horizon; {refraction at atmosphere, max 34 minutes near horizon}
                                             {note here is not possible to use function altitude_apparent}

    if planet_number in [0,10]{sun, moon} then  altitude2:=altitude2 +(diameter9/(2*10*60))*(pi/180);

    {watch out for 24 hour indication. Rise time are for the date, so at 2015-11-25 24:00 uur, rise time is for morning 2015-11-25 00:00 hours, so already past}
    if ((time>0) and (oldalt>0) and (altitude2<=0) and (stime=999)) then {999 condition, cycle is a little larger then 24 hours so don't calculate stime/rtime twice and get wrong results}
                                           stime:=(time-(altitude2/(stepsize*(altitude2-oldalt))));
    if ((time>0) and (oldalt<=0) and (altitude2>0) and (rtime=999) ) then
                                          rtime:=(time-(altitude2/(stepsize*(altitude2-oldalt))));
    if ((time>0) and  (altitude2>highest_altitude)) then
                                          begin ztime:=time;highest_altitude:=altitude2; end;

    oldalt:=altitude2;
  end;
   {watch out for 24 hour indication. Rise time are for the date, so at 2015-11-25 24:00 uur, rise time is for morning 2015-11-25 00:00 hours, so already past}
  if ((highest_altitude>0) and (stime>998) and (rtime>998) ) then always:=true;
  if highest_altitude<0 then never:=true;
  stime:=stime +0.5/60; rtime:=rtime+0.5/60; {for correct rounding}
  if ((stime<0) or (stime>=24)) then  begin  sh:='- '; sm:=' -'; end
  else
  begin
    sh:=LeadingZero(trunc(stime)) ;
    sm:=LeadingZero(trunc((frac(stime)*60)));
  end;
  if ((rtime<0) or(rtime>=24)) then  begin rh:='- '; rm:=' -'; end {for moon e.g. 13-10-98}
  else
  begin
    rh:=LeadingZero(trunc(rtime));
    rm:=leadingZero(trunc((frac(rtime)*60)));
  end;

   if always=true then
  begin
   while (length(above_string)<21) do above_string:=above_string+' ';{clean always last line for always above horizon}
   result:=above_string;
  end
  else
  if never=true then
  begin
    while (length(below_string)<21) do below_string:=below_string+' ';{clean always last line for always below horizon}
    result:=below_string;
  end
  else
  begin
     if rtime<stime then
        result:=(Rise_string+' '+rh+':'+rm+'  '+Set_string+' '+sh+':'+sm+' ')
        else
        result:=(Set_string+' '+sh+':'+sm+'  '+Rise_string+' '+rh+':'+rm+' ');
  end;

  if never=false then {get meridian crossing time}
  begin
    if ztime>24 then ztime:=24;{polaris}
    meridian_pass:='≈ '+LeadingZero(trunc(ztime))+':'+LeadingZero(trunc((frac(ztime)*60))) ;{when in meridian}
  end
  else meridian_pass:=''; {no zenith pass}

  calculate_julian(year2,month2,day2,hour2,min2,sec2);{recalculate julian and wtime}
                                                   {recalculate julian and wtime to original value otherwise funny jumps}
end;


procedure de_toast(x1, y1, size : integer; var lon,lat :double); {de-TOAST x,y coordinates to lat, lon. The origin (0,0) is top left of TOAST projection, size:=height or witdh}
{ inverse Tessellated Octahedral Adaptive Subdivision Transform (TOAST) projection}
var
 x,y :double;
begin
  {www.hnsky.org}
  {use eight-fold symmetry of TOAST projection}
  {for x, y range is 0,0 at top left corner}
  {For x, y the left top is 0,0. x is horizontal, y is vertical}
  {calculate x,y}
  x:=-1+ x1/(0.5*size) ;{make range -1..+1, zero at centre, y is positive up, x is positive to the right}
  y:=+1- y1/(0.5*size);{make range -1..+1, zero at centre}

    if( x < 0 ) then  {left part}
    begin
      if( y > 0 ) then {left top quartor}
      begin
      if( y -x < 1 ) then
        begin {left top quartor, northern hemisphere}
          x:=-x;{move origin}
          lat:=(1-y-x)*pi/2;
          lon:=0.5*pi*(1-x/(y+x+0.000000000000001));
          lon:=pi+lon;{bring in range}
        end
        else
        begin {left top quartor, southern hemisphere}
          x:=1+x;{move origin}
          y:=1-y;{move origin}
          lat:=(1-y-x)*pi/2;
          lon:=0.5*pi*(1-x/(y+x+0.000000000000001));
          lat:=-lat; {bring in range}
          lon:=1.5*pi-lon;{bring in range}
        end;
     end
     else
     begin {bottom left quarter}
       if( -y-x < 1)  then
       begin {northern hemisphere}
          x:=-x;{move origin}
          y:=-y;{move origin}
          lat:=(1-y-x)*pi/2;
          lon:=0.5*pi*(1-x/(y+x+0.000000000000001));
          lon:=pi-lon;{bring in range}
       end
       else
       begin {southern hemisphere}
          x:=1+x;{move origin}
          y:=1+y;{move origin}
          lat:=(1-y-x)*pi/2;
          lon:=0.5*pi*(1-x/(y+x+0.000000000000001));
          lat:=-lat; {bring in range}
          lon:=0.5*pi+lon;{bring in range}
       end;
     end;
   end

   else  {x>0, right part}
   begin
     if( y > 0 ) then {right top quarter}
     begin
       if( y + x <1 ) then
       begin  {right top quarter, Northern hemisphere}
          lat:=(1-y-x)*pi/2;
         lon:=0.5*pi*(1-x/(y+x+0.000000000000001));
         lon:=2*pi-lon;{bring in range}
       end
       else
       begin   {right top quarter, Southern hemisphere}
         x:=1-x;{move origin}
         y:=1-y;{move origin}
          lat:=(1-y-x)*pi/2;
         lon:=0.5*pi*(1-x/(y+x+0.000000000000001));
         lat:=-lat; {bring in range}
         lon:=1.5*pi+lon;{bring in range}
       end;
     end {right top part}
     else
     begin {y<0, right bottom quarter}
       if( -y +x <1 ) then
       begin  {right bottom quarter, Northern hemisphere}
         y:=-y;{move origin}
          lat:=(1-y-x)*pi/2;
         lon:=0.5*pi*(1-x/(y+x+0.000000000000001));
       end
       else
       begin {right bottom quarter, Southern hemisphere}
         x:=1-x;{move origin to south pole and reverse direction x}
         y:=y+1;{move origin}
          lat:=(1-y-x)*pi/2;
         lon:=0.5*pi*(1-x/ (y+x+0.000000000000001));
         lat:=-lat; {bring in range}
         lon:=0.5*pi-lon;{bring in range}
       end;
     end;
   end;
   {keep within range to prevent errors}
   if lon>pi*2 then lon:=pi*2;
   if lon<0 then lon:=0;
   if lat>pi/2 then lat:=pi/2;
   if lat<-pi/2 then lat:=-pi/2;
end;

function prepare_IAU_designation(rax,decx :double):string;{radialen to text hhmmss.s+ddmmss  format}
 var
   hh,mm,ss,ds  :integer;
   g,m,s  :integer;
   sign   : char;
begin
  {RA}
  rax:=rax+pi*2*0.05/(24*60*60); {add 1/10 of half second to get correct rounding and not 7:60 results as with round}
  rax:=rax*12/pi; {make hours}
  hh:=trunc(rax);
  mm:=trunc((rax-hh)*60);
  ss:=trunc((rax-hh-mm/60)*3600);
  ds:=trunc((rax-hh-mm/60-ss/3600)*36000);

  {DEC}
  if decx<0 then sign:='-' else sign:='+';
  decx:=abs(decx)+pi*2*0.5/(360*60*60); {add half second to get correct rounding and not 7:60 results as with round}
  decx:=decx*180/pi; {make degrees}
  g:=trunc(decx);
  m:=trunc((decx-g)*60);
  s:=trunc((decx-g-m/60)*3600);
  result:=leadingzero(hh)+leadingzero(mm)+leadingzero(ss)+'.'+char(ds+48)+sign+leadingzero(g)+leadingzero(m)+leadingzero(s);
end;

function prepare_time(days:double):string; {time to string format 365d 24:00:00}
var
   day : String[4];
   d,h,m,s  :integer;
   sign        : char;
begin
  if days<0 then sign:='-' else sign:='+';
  days:=abs(days)+0.5/(24*3600); {add 1/10 of half second to get correct rounding and not 7:60 results as with round}
  d:=trunc(days);
  h:=trunc((days-d)*24);
  m:=trunc((days-d-h/24)*24*60);
  s:=trunc((days-d-h/24-m/(24*60))*24*60*60);
  Str(trunc(d),day);
  result:=sign+string(day)+'d '+leadingzero(h)+':'+leadingzero(m)+' '+leadingzero(s);
end;

function prepare_ra(rax:double):string; {radialen to text, format 24: 00 00.0 }
 var
   B : String[2];
   h,m,s,ds  :integer;
 begin {make from rax [0..pi*2] a text in array bericht. Length is 8 long}
  rax:=rax+pi*2*0.05/(24*60*60); {add 1/10 of half second to get correct rounding and not 7:60 results as with round}
  rax:=rax*12/pi; {make hours}
  h:=trunc(rax);
  m:=trunc((rax-h)*60);
  s:=trunc((rax-h-m/60)*3600);
  ds:=trunc((rax-h-m/60-s/3600)*36000);
  Str(trunc(h):2,b);
  result:=string(b)+': '+leadingzero(m)+' '+leadingzero(s)+'.'+char(ds+48);
end;
function prepare_dec(decx:double):string; {radialen to text, format 90d 00 00}
 var
   B : String[9];
   g,m,s  :integer;
   sign   : char;
begin {make from rax [0..pi*2] a text in array bericht. Length is 10 long}
  if decx<0 then sign:='-' else sign:='+';
  decx:=abs(decx)+pi*2*0.5/(360*60*60); {add half second to get correct rounding and not 7:60 results as with round}
  decx:=decx*180/pi; {make degrees}
  g:=trunc(decx);
  m:=trunc((decx-g)*60);
  s:=trunc((decx-g-m/60)*3600);
  Str(trunc(g):2,b);
  result:=sign+string(b)+'° '+leadingzero(m)+' '+leadingzero(s);
end;
function prepare_ra2(rax:double):string; {radialen to text  format 24h 00}
 var
   B : String[2];
   h,m  :integer;
 begin {make from rax [0..pi*2] a text in array bericht. Length is 8 long}
  rax:=rax+pi*2*0.5/(24*60); {add half minute to get correct rounding and not 7:60 results as with round}
  rax:=rax*12/pi; {make hours}
  h:=trunc(rax);
  m:=trunc((rax-h)*60);
  Str(trunc(h):2,b);
  result:=string(b)+': '+leadingzero(m);
end;

function prepare_ra3(rax:double):string; {radialen to text  format 24d 00.0}
 var
   B : String[2];
   h,m,dm  :integer;
 begin {make from rax [0..pi*2] a text in array bericht. Length is 8 long}
  rax:=rax+pi*2*0.5*0.1/(24*60); {add 1/10 of half minute to get correct rounding and not 7:60 results as with round}
  rax:=rax*12/pi; {make hours}
  h:=trunc(rax);
  m:=trunc((rax-h)*60);
  dm:=trunc((rax-h-m/60)*600);
  Str(trunc(h):2,b);
  result:= string(b)+': '+leadingzero(m)+'.'+char(dm+48);
end;
function prepare_dec2(decx:double):string; {radialen to text  format 90d 00 }
 var
   B : String[7];
   g,m :integer;
   sign   : char;
begin {make from rax [0..pi*2] a text in array bericht. Length is 10 long}
  if decx<0 then sign:='-' else sign:='+';
  decx:=abs(decx)+pi*2*0.5/(360*60); {add half minute to get correct rounding and not 7:60 results as with round}
  decx:=decx*180/pi; {make degrees}
  g:=trunc(decx);
  m:=trunc((decx-g)*60);
  Str(trunc(g):2,b);
  result:= sign+string(b)+'° '+leadingzero(m);
end;

procedure checkleapyear(year3:integer);{29 or 28 days in february}
begin
//if (year is not divisible by 4) then (it is a common year)
//else if (year is not divisible by 100) then (it is a leap year)
//else if (year is not divisible by 400) then (it is a common year)
//else (it is a leap year)
  if year3>1582 then {Gregorion}
  begin
    if (((frac(year3/4)=0) and (frac(year3/100)<>0)) or (frac(year3/400)=0)) {2000 is a leap year}
     then days[2]:=29 {leap year} else days[2]:=28;
  end
  else {Julian years}
  begin
   if frac(year3/4)=0 then days[2]:=29 {leap year} else days[2]:=28;{days in Februari}
  end;
end;

Function  limit_radialen(z,range:double):double;
begin
  {range should be 2*pi or 24 hours}
  z:=range*frac(z/(range));{quick method for big numbers}
  while z<0 do z:=z+range;
  limit_radialen:=z;
end;

Function LeadingZero(w : integer) : String;{add a zero to the front if length is 1}
var
  s : String;
begin
  str(w:0,s);
  if Length(s)=1 then s:= '0' + s;
  result:=s;
end;

function delta_T(jd:double) : double; {calculates difference dynamic time and UT in days. Max error about 10 seconds. Range 1680 - 2150plus}
var y,u,t : double;
    year: integer;
const
  minyeardt = -99999999;{no limit}
  maxyeardt = +99999999;
begin
  { Reference  :
  NASA TP-2006-214141
  Five Millennium Canon of Solar Eclipses: -1999 to +3000 (2000 BCE to 3000 CE)
  Fred Espenak and see new meeus page 72 }
  y:=(2000 +(JD-2451544.5)/365.25);
  year:=round(y);

  {most lines taken from CdC 2016}
  if ((year>=minyeardt) and (year<=-2000)) then { minyeardt..-2000:}
                begin    // use JPL Horizon value
                  u:=(y-1820)/100;
                  result:=(32*u*u);{seconds}
                end
                else
  if ((year>=-1999) and (year<=-501)) then
  begin         // Use Espenak value
    u:=(y-1820)/100;
    result:=(-20+32*u*u);{seconds}
  end
  else
  if ((year>=-500) and (year<=499)) then
  begin
    u:=y/100;
    result:=(10583.6+u*(-1014.41+u*(33.78311+u*(-5.952053+u*(-0.1798452+u*(0.022174192+u*(0.0090316521)))))));{seconds}
  end
  else
  if ((year>=500) and (year<=1599)) then
  begin
    u:=(y-1000)/100;
    result:=(1574.2+u*(-556.01+u*(71.23472+u*(0.319781+u*(-0.8503463+u*(-0.005050998+u*(0.0083572073)))))));{seconds}
  end
  else
  if ((year>=1600) and (year<=1699)) then
  begin
    t:=y-1600;
    result:=(120+t*(-0.9808+t*(-0.01532+t*(1/7129))));{seconds}
  end
  else
  if ((year>=1700) and (year<=1799)) then
  begin
    t:=y-1700;
    result:=(8.83+t*(0.1603+t*(-0.0059285+t*(0.00013336+t*(-1/1174000)))));{seconds}
  end
  else
  if ((year>=1800) and (year<=1859)) then
  begin
    t:=y-1800;
    result:=(13.72+t*(-0.332447+t*(0.0068612+t*(0.0041116+t*(-0.00037436+t*(0.0000121272+t*(-0.0000001699+t*(0.000000000875))))))));{seconds}
  end
  else
  if ((year>=1860) and (year<=1899)) then
  begin
    t:=y-1860;
    result:=(7.62+t*(0.5737+t*(-0.251754+t*(0.01680668+t*(-0.0004473624+t*(1/233174))))));{seconds}
  end
  else
  if ((year>=1900) and (year<=1919)) then
  begin
     t:=y-1900;
     result:=(-2.79+t*(1.494119+t*(-0.0598939+t*(0.0061966+t*(-0.000197)))));{seconds}
  end
  else
  if ((year>=1920) and (year<=1940)) then
  begin
    t:=y-1920;
    result:=(21.20+t*(0.84493+t*(-0.076100+t*(0.0020936))));{seconds}
    end
  else
  if ((year>=1941) and (year<=1960)) then
  begin
    t:=y-1950;
    result:=(29.07+t*(0.407+t*(-1/233+t*(1/2547))));{seconds}
  end
  else
  if ((year>=1961) and (year<=1985)) then
  begin
    t:=y-1975;
    result:=(45.45+t*(1.067+t*(-1/260+t*(-1/718))));{seconds}
  end
  else
  if ((year>=1986) and (year<=2004)) then
  begin
    t:=y-2000;
    result:=(63.86+t*(0.3345+t*(-0.060374+t*(0.0017275+t*(0.000651814+t*(0.00002373599))))));{seconds}
  end
  else
  if ((year>=2005) and (year<=2012)) then
  // adjustement for measured values after 2005 :
  // linear adjustement from 2005.0 value to 66.9 sec. reached by 2013.0
  // factor up to 2150 are adjusted to avoid a discontinuity.
  begin
    t:=y-2005;
    result:=(64.69+t*0.27625);{seconds}  // (66.9-64.69)/8 = 0.27625
  end
  else
  if ((year>=2013) and (year<=2015)) then
  begin
    t:=y-2013;
    result:=(66.9+t*0.4667);{seconds}  // (68.3-66.9)/3 = 0.4667
  end
  else
  if ((year>=2016) and (year<=2020)) then
  begin
    t:=y-2016;
    result:=(68.3+t*0.54);{seconds}  // (71-68.3)/5 = 0.54
  end
  else
  if ((year>=2021) and (year<=2024)) then
  begin
    t:=y-2021;
    result:=(71+t*0.5);{seconds}  // (73-71)/4 = 0.5
  end
  else
  if ((year>=2025) and (year<=2049)) then
  begin
    t:=y-2000;
          //2005-2050: result:=(62.92+t*(0.32217+t*(0.005589)));{seconds}
          // > 2025 : 62.92+(0.32217*25)+(0.005589*25^2)=74.46
          // 62.92-74.46+73 = 61.46
    result:=(61.46+t*(0.32217+t*(0.005589)));{seconds}
  end
  else
  if ((year>=2050) and (year<=2149)) then
  begin
    u:=(y-1820)/100;
    t:=2150-y;
    result:=(-20+32*u*u-0.5788*t);{seconds}
    //result:=(-20+32*u*u-0.5628*t);{seconds}
  end
  else
  if ((year>=2150) and (year<=2999)) then
  begin        // End of Espenak range
    u:=(y-1820)/100;
    result:=(-20+32*u*u);{seconds}
  end
  else
  if ((year>=3000) and (year<=maxyeardt)) then
  begin    // use JPL Horizon value
    u:=(y-1820)/100;
    result:=(32*u*u);{seconds}{https://eclipse.gsfc.nasa.gov/SEhelp/deltatpoly2004.html}
  end
  else  result:=0; // unknown
  result:=result/(24*3600);{convert results to days}
end;

FUNCTION julian_calc(yyyy,mm:integer;dd,hours,minutes,seconds:double):double; {##### calculate julian day, revised 2017}
var
   Y,M   : integer;
   A, B , T ,XX : double;
begin
  IF MM>2 THEN  begin Y:=YYYY; M:=MM;end
  else {MM=1 OR MM=2}
    begin Y:=YYYY-1; M:=MM+12;end;

  DD:=DD+HOURS/24+MINUTES/(24*60)+SECONDS/(24*60*60);

  if ((YYYY+MM/100+DD/10000)<1582.10149999) then B:=0 {year 1582 October, 15, 00:00 reform Gregorian to julian, 1582.10149999=1582.1015 for rounding errors}
  else                                                {test year 837 april 10, 0 hours is Jd 2026871.5}
  begin
    A:=INT(Y/100);
    B:=+ 2 - A + INT(A/4)
  end;

  if Y<0 then XX:=0.75 else xx:=0;{correction for negative years}
    result:=INT(365.25*Y-XX)+INT(30.6001*(M+1))
         + DD
         + B
         + 1720994.5;

  {update the obliquity of ecliptic }
  T:=(result- 2451545)/36525;
  ecliptic2:=23.439291111  - T*46.8150/(60*60) - T*T*0.00059/(60*60); //M&P page 15
  {obliquity of ecliptic }
end;

FUNCTION JdToDate(jd:double):string;{Returns Date from Julian Date,  See MEEUS 2 page 63}
var A,B,C,D,E,F,G,J,M,T,Z: double; {!!! 2016 by purpose, otherwise with timezone 8, 24:00 midnigth becomes 15:59 UTC}
    HH, MM, SS           : integer;
    year3                : STRING[6];
begin
  if (abs(jd)>1461*10000) then begin result:='Error, JD outside allowed range!' ;exit;end;

  jd:=jd+(0.5/(24*3600));{2016 one 1/2 second extra for math errors, fix problem with timezone 8, 24:00 midnight becomes 15:59 UTC}

  Z:=trunc (JD + 0.5);
  F:=Frac(JD + 0.5);
  If Z < 2299160.5 Then A:=Z // < 15.10.1582 00:00 {Note Meeus 2 takes midday 12:00}
  else
  begin
   g:= int((Z-1867216.25) / 36524.25);
   a:=z+1+g-trunc(g/4);
  end;
  B := A+1524+ {special =>} (1461*10000);{allow up to 40.000 year in past, 1461 days *100000 = 4x 10000 years}
  C := trunc((B-122.1)/365.25);
  D := trunc(365.25 * C);
  E := trunc((B-D)/30.6001);
  T := B-D-int(30.6001*E) + F; {day of the month}
  if(E<14) then
    M := E-1
  else
    M := E-13;
  if (M>2) then
      J := C-4716
  else
      J := C-4715;

   j:=J - {special= >} 4*10000;{allow up to 40.000 year in past, 1461 days *100000 = 4x 10000 years}

  F:=fnmodulo(F,1);{for negative julian days}
  HH:=trunc(F*24);
  MM:=trunc((F-HH/24)*(24*60));{not round otherwise 23:60}
  SS:=trunc((F-HH/24-MM/(24*60))*(24*3600));

  str(trunc(j):4,year3);

  result:=year3+'-' +leadingzero(trunc(m))+'-'+leadingzero(trunc(t))+'  '+leadingzero(HH)+':'+leadingzero(MM)+':'+leadingzero(SS);
end;


PROCEDURE JdToDate_integers(jd:double;var year,month,day,HH,MM,SS:integer);{Returns Date from Julian Date,  See MEEUS 2 page 63}
var A,B,C,D,E,F,G,J,M,T,Z: double;
begin
  if (abs(jd)>1461*10000) then begin year:=0; day:=0; month:=0; HH:=0; MM:=0; ;exit;end;

  jd:=jd+(0.5/(24*3600));{2016 one 1/2 second extra for math errors, fix problem with timezone 8, 24:00 midnight becomes 15:59 UTC}

  Z:=trunc (JD + 0.5);
  F:=Frac(JD + 0.5);
  If Z < 2299160.5 Then A:=Z // < 15.10.1582 00:00 {meeus takes midday 12:00}
  else
  begin
   g:= int((Z-1867216.25) / 36524.25);
   a:=z+1+g-trunc(g/4);
  end;
  B := A+1524+ {special =>} (1461*10000);{allow up to 40.000 year in past, 1461 days *100000 = 4x 10000 years}
  C := trunc((B-122.1)/365.25);
  D := trunc(365.25 * C);
  E := trunc((B-D)/30.6001);
  T := B-D-int(30.6001*E) + F; {day of the month}
  if(E<14) then
    M := E-1
  else
    M := E-13;
  if (M>2) then
      J := C-4716
  else
      J := C-4715;

   j:=J - {special= >} 4*10000;{allow up to 40.000 year in past, 1461 days *100000 = 4x 10000 years}

  F:=fnmodulo(F,1);{for negative julian days}
  HH:=trunc(F*24);
  MM:=trunc((F-HH/24)*(24*60));{not round otherwise 23:60}
  SS:=trunc((F-HH/24-MM/(24*60))*(24*3600));

  year:=trunc(j);
  month:=trunc(m);
  day:=trunc(t);
end;


FUNCTION JdToDate_2(jd:double):string;{Variant with fraction of days, {Returns Date from Julian Date,  See MEEUS 2 page 63}
var A,B,C,D,E,F,G,J,M,T,Z: double;
    year3                : STRING[4];
    mon                  : STRING[2];
    day                  : string[6];
begin
  if (jd<1721424) or (jd>5373484) then begin result:='Error JD->Greg';exit;end;

  jd:=jd+(0.5/(24*3600));{2016 one 1/2 second extra for math errors}

  Z:=Int (JD + 0.5);
  F:=Frac(JD + 0.5);
  If Z < 2299161 Then A:=Z // < 15.10.1582
  else
  begin
   g:= int((Z-1867216.25) / 36524.25);
   a:=z+1+g-int(g/4);
  end;
  B := A+1524;
  C := Int((B-122.1)/365.25);
  D := int(365.25 * C);
  E := Int((B-D)/30.6001);
  T := B-D-int(30.6001*E) + F;
  if(E<14) then
    M := E-1
  else
    M := E-13;
  if (M>2) then
      J := C-4716
  else
      J := C-4715;
  if j<1 then j:=j-1;

  str(trunc(j):4,year3);
  mon:=leadingzero(trunc(m));
  str(t:6:3,day);
  if day[1]=' ' then day[1]:='0';

  result:=year3+' ' +mon+' '+day;
end;


FUNCTION JdToDate_3(jd:double):string;{Variant with month and day only, {Returns Date from Julian Date,  See MEEUS 2 page 63}
var A,B,C,D,E,F,G,{J,} M,T,Z: double;
begin
  if (jd<1721424) or (jd>5373484) then begin result:='Error JD->Greg';exit;end;

  jd:=jd+(0.5/(24*3600));{2016 one 1/2 second extra for math errors}

  Z:=Int (JD + 0.5);
  F:=Frac(JD + 0.5);
  If Z < 2299161 Then A:=Z // < 15.10.1582
  else
  begin
   g:= int((Z-1867216.25) / 36524.25);
   a:=z+1+g-int(g/4);
  end;
  B := A+1524;
  C := Int((B-122.1)/365.25);
  D := int(365.25 * C);
  E := Int((B-D)/30.6001);
  T := B-D-int(30.6001*E) + F;
  if(E<14) then
    M := E-1
  else
    M := E-13;
//  if (M>2) then
//      J := C-4716
//  else
//      J := C-4715;
 // if j<1 then j:=j-1;

  result:=inttostr(trunc(m))+'-' +inttostr(trunc(t));
end;

Function asteroid_magn_comp(g ,b :double):double; {Magnitude change by phase asteroid, New meeus 32.14}
      {g = slope parameter,  b= angle sun-asteroid-earth}
var b2,q1,q2 :double;
begin
  b2:=sin(b*0.5)/cos(b*0.5); {tan is sin/cos}
  q1:=EXP(-3.33*EXP(0.63*LN(b2+0.00000001))); {power :=EXP(tweedevar*LN(eerstevar))}
  q2:=EXP(-1.87*EXP(1.22*LN(b2+0.00000001)));
  asteroid_magn_comp:= -2.5*ln( (1-g)*q1  + g*q2 )/ln(10);
end;


function altitude_apparent(altitude_real:double):double;  {atmospheric refraction, real to seen}
var  hn  :double;
begin
  hn:=(altitude_real*(180/pi)+10.3/(altitude_real*(180/pi)+5.11))*pi/180;
                 {watch out with radians and degrees!!!!!!  carefully with factors}
  altitude_apparent:=altitude_real + (pi/180)* (1.02/60)/(sin(hn)/cos(hn) ); {note: tan(x) = sin(x)/cos(x)}
 {bases on meeus 1991 page 102 formula 15.4}
end;
function altitude_to_true(altitude_seen:double):double;  {atmospheric refraction seen to real}
var  hn  :double;
begin
  hn:=(altitude_seen*(180/pi)+7.31/(altitude_seen*(180/pi)+4.4))*pi/180;
                 {watch out with radians and degrees!!!!!!  carefully with factors}
  altitude_to_true:=altitude_seen - (pi/180)* (1.00/60)/(sin(hn)/cos(hn) ); {note: tan(x) = sin(x)/cos(x)}
 {bases on meeus 1991 page 102, formula 15.3}
end;

//FUNCTION ATN_2(Y,X:double):double; {replaced by internal math function arctan2}
//  VAR   AX,AY,PHI: double;
//  BEGIN
//    IF (X=0.0) AND (Y=0.0)
//      THEN ATN_2:=0.0
//      ELSE
//        BEGIN
//          AX:=ABS(X); AY:=ABS(Y);
//          IF (AX>AY)
//            THEN PHI:=ARCTAN(AY/AX)
//            ELSE PHI:=(pi/2)-ARCTAN(AX/AY);
//          IF (X<0.0) THEN PHI:=pi-PHI;
//          IF (Y<0.0) THEN PHI:=-PHI;
//          ATN_2:=PHI;
//        END;
//  END;

(*-----------------------------------------------------------------------*)
(* CART: conversion of polar coordinates (r,theta,phi)                   *)
(*       into cartesian coordinates (x,y,z)                              *)
(*       (theta in [-pi/2.. pi/2 rad]; phi in [-pi*2,+pi*2 rad])         *)
(*-----------------------------------------------------------------------*)
PROCEDURE CART2(R,THETA,PHI: double; VAR X,Y,Z: double);
  VAR RCST : double;
      cos_theta,sin_theta :double;
      cos_phi,sin_phi     :double;
  BEGIN
//    RCST := R*COS(THETA);
//    X    := RCST*COS(PHI); Y := RCST*SIN(PHI); Z := R*SIN(THETA)

    sincos(theta,sin_theta,cos_theta);
    sincos(phi  ,sin_phi  ,cos_phi);
    RCST := R*COS_THETA;
    X    := RCST*COS_PHI; Y := RCST*SIN_PHI; Z := R*SIN_THETA;

  END;

(*-----------------------------------------------------------------------*)
(* POLAR: conversion of cartesian coordinates (x,y,z)                    *)
(*        into polar coordinates (r,theta,phi)                           *)
(*        (theta in [-pi/2 deg,+pi/2]; phi in [0 ,+ 2*pi radians]        *)
(*-----------------------------------------------------------------------*)
PROCEDURE POLAR2(X,Y,Z:double;VAR R,THETA,PHI:double);
  VAR RHO: double;
  BEGIN
    RHO:=X*X+Y*Y;  R:=SQRT(RHO+Z*Z);
    PHI:=arctan2(Y,X); IF PHI<0 THEN PHI:=PHI+2*pi;
    RHO:=SQRT(RHO); THETA:=arctan2(Z,RHO);
  END;
(*----------------------------------------------------------------*)
(* EQUHOR: conversion of equatorial into horizontal coordinates   *)
(*   DEC  : declination (-pi/2 .. +pi/2)                          *)
(*   TAU  : hour angle (0 .. 2*pi)                                *)
(*   PHI  : geographical latitude (in rad)                        *)
(*   H    : altitude (in rad)                                     *)
(*   AZ   : azimuth (0 deg .. 2*pi rad, counted S->W->N->E->S)    *)
(*----------------------------------------------------------------*)
PROCEDURE EQUHOR2 (DEC,TAU,PHI: double; VAR H,AZ: double);
  VAR COS_PHI,SIN_PHI, COS_DEC,SIN_DEC,COS_TAU, SIN_TAU, X,Y,Z, DUMMY: double;
  BEGIN {updated with sincos function for fastest execution}
    SINCOS(PHI,SIN_PHI,COS_PHI);
    SINCOS(DEC,SIN_DEC,COS_DEC);
    SINCOS(TAU,SIN_TAU,COS_TAU);
    X:=COS_DEC*SIN_PHI*COS_TAU - SIN_DEC*COS_PHI;
    Y:=COS_DEC*SIN_TAU;
    Z:=COS_DEC*COS_PHI*COS_TAU + SIN_DEC*SIN_PHI;
    POLAR2(X,Y,Z, DUMMY,H,AZ)
  END;
PROCEDURE RA_AZ(RA,dec,LAT,LONG,t:double;var azimuth2,altitude2: double);{conversion ra & dec to altitude,azimuth}
{input RA [0..2pi], DEC [-pi/2..+pi/2],lat[-90..90],long[0..360],time[0..2*pi]}
begin
  EQUHOR2(dec,ra-(long*pi/180)-t,lat*pi/180,  {var:} altitude2,azimuth2);
  azimuth2:=pi-azimuth2;
  IF AZIMUTH2<0 THEN AZIMUTH2:=AZIMUTH2+2*Pi;
end;

function altitude(RA,dec,LAT,LONG,t:double):double;{conversion ra & dec to altitude only. This routine is created for speed, only the altitude is calculated}
{input RA [0..2pi], DEC [-pi/2..+pi/2],lat[-90..90],long[0..360],time[0..2*pi]}
var t5 :double;
    sin_lat,cos_lat,sin_dec,cos_dec:double;
begin
  LAT:=pi*LAT/180;
  LONG:=pi*LONG/180;
  T5:=T-RA+LONG;
  sincos(lat,sin_lat,cos_lat);
  sincos(dec,sin_dec,cos_dec);
  try
  {***** altitude calculation from RA&DEC, meeus new 12.5 *******}
  result:=arcsin(SIN_LAT*SIN_DEC+COS_LAT*COS_DEC*COS(T5));
  except
  {ignore floating point errors outside builder}
  end;

end;

//PROCEDURE RA_AZ2(RA,dec,LAT,LONG,t:double;var azimuth2,altitude2: double);{conversion ra & dec to altitude, azimuth}
//{input RA [0..2pi], DEC [-pi/2..+pi/2],lat[-90..90],long[0..360],time[0..2*pi]}
//var t5 :double;
//    sin_lat,cos_lat,sin_dec,cos_dec,sin_t5,cos_t5:double;
//begin
//  LAT:=pi*LAT/180;
//  LONG:=pi*LONG/180;
//  T5:=T-RA+LONG;
//  sincos(lat,sin_lat,cos_lat);
//  sincos(dec,sin_dec,cos_dec);
//  sincos(t5,sin_t5,cos_t5);
//  try
//  {***** altitude calculation from RA&DEC, meeus new 12.5 *******}
//  altitude2:=arcsin(SIN_LAT*SIN_DEC+COS_LAT*COS_DEC*COS_T5);

//  {***** azimuth calculation from RA&DEC, meeus new 12.6 ****** }
//  azimuth2:=arctan2(sin_t5,cos_t5*sin_lat- tan(dec)*cos_lat);
//  except
//  {ignore floating point errors outside builder}
//  end;
//  azimuth2:=azimuth2-pi;
//end;


procedure GAL_EQU(l,b:double;var ra,dec: double);{galactic (milky way) to equatorial coordinates}
const
  {North_galactic pole (J2000)}
  pole_ra : double = 192.8595*pi/180;
  pole_dec: double =  27.1283*pi/180;
  posangle: double =  32.9319*pi/180;

// Converting between galactic to equatorial coordinates
// The galactic north pole is at RA = 12:51.4, Dec = +27:07 (2000.0),
// the galactic center at RA = 17:45.6, Dec = -28:56 (2000.0).
// The inclination of the galactic equator to the celestial equator is thus 62.9°.
// The intersection, or node line, of the two equators is at
// RA = 282.25°, Dec = 0:00 (2000.0), and at l = 33°, b=0.
// The transformation between the equatorial and galactic systems consisted of:
// 1. a rotation around the celestial polar axis by 282.25°,
// so that the reference zero longitude matches the node
// 2. a rotation around the node by 62.9°
// 3. a rotation around the galactic polar axis by 33°
// so that the zero longitude meridian matches the galactic center.

// North galactic pole (B1950)
// pole_ra = radians(192.25)
// pole_dec = radians(27.4)
// posangle = radians(123.0-90.0)
var
  sin_b, cos_b, sin_pole_dec, cos_pole_dec :double;
begin
  sincos(b,sin_b, cos_b);
  sincos(pole_dec,sin_pole_dec, cos_pole_dec);
  ra  := arctan2( (cos_b*cos(l-posangle)), (sin_b*cos_pole_dec - cos_b*sin_pole_dec*sin(l-posangle)) ) + pole_ra;
  dec := arcsin( cos_b*cos_pole_dec*sin(l-posangle) + sin_b*sin_pole_dec );

//  ra  := arctan2( (cos(b)*cos(l-posangle)), (sin(b)*cos(pole_dec) - cos(b)*sin(pole_dec)*sin(l-posangle)) ) + pole_ra;
//  dec := arcsin( cos(b)*cos(pole_dec)*sin(l-posangle) + sin(b)*sin(pole_dec) );
end;

procedure EQU_GAL(ra,dec:double;var l,b: double);{equatorial to galactic coordinates}
const
  {North_galactic pole (J2000)}
  pole_ra : double = (12+51/60+26.27549/3600)*pi/12; {12h51m26.27549    https://www.aanda.org/articles/aa/pdf/2011/02/aa14961-10.pdf }
  pole_dec: double =  (27+7/60+41.7043/3600)*pi/180; {+27◦07′41.7043′′}
  posangle: double =  (122.93191857-90)*pi/180; {122.93191857◦}

// Converting between galactic to equatorial coordinates
// The galactic north pole is at RA = 12:51.4, Dec = +27:07 (2000.0),
// the galactic center at RA = 17:45.6, Dec = -28:56 (2000.0).
// The inclination of the galactic equator to the celestial equator is thus 62.9°.
// The intersection, or node line, of the two equators is at
// RA = 282.25°, Dec = 0:00 (2000.0), and at l = 33°, b=0.
var
  sin_b, cos_b, sin_pole_dec, cos_pole_dec :double;
begin
  sincos(pole_dec,sin_pole_dec, cos_pole_dec);
  b:=arcsin(cos(dec)*cos_pole_dec*cos(ra - pole_ra) + sin(dec)*sin_pole_dec);
  sincos(b,sin_b, cos_b);
  l:=arctan2(  (sin(dec) - sin_b *sin_pole_dec ) , (cos(dec)*cos_pole_dec*sin(ra - pole_ra)) )  + posangle;
end;
procedure EQU_GAL1950(ra,dec:double;var l,b: double);{equatorial to galactic coordinates}
const
  {North_galactic pole (1950)}
  pole_ra : double = 192.25*pi/180;
  pole_dec: double =  27.4*pi/180;
  posangle: double =  33*pi/180;

// Converting between galactic to equatorial coordinates
// The galactic north pole is at RA = 12:51.4, Dec = +27:07 (2000.0),
// the galactic center at RA = 17:45.6, Dec = -28:56 (2000.0).
// The inclination of the galactic equator to the celestial equator is thus 62.9°.
// The intersection, or node line, of the two equators is at
// RA = 282.25°, Dec = 0:00 (2000.0), and at l = 33°, b=0.
var
  sin_b, cos_b, sin_pole_dec, cos_pole_dec :double;
begin
  sincos(pole_dec,sin_pole_dec, cos_pole_dec);
  b:=arcsin(cos(dec)*cos_pole_dec*cos(ra - pole_ra) + sin(dec)*sin_pole_dec);
  sincos(b,sin_b, cos_b);
  l:=arctan2(  (sin(dec) - sin_b *sin_pole_dec ) , (cos(dec)*cos_pole_dec*sin(ra - pole_ra)) )  + posangle;
end;

PROCEDURE AZ_RA(AZ,ALT,LAT,LONG,t:double;var ra,dcr: double);{conversion az,alt to ra,dec}
{input AZ [0..2pi], ALT [-pi/2..+pi/2],lat[-90..90],long[0..360],time[0..2*pi]}
begin
  EQUHOR2(alt,az,lat*pi/180,{var:} dcr,ra);
  ra:=pi-ra+long*pi/180 +t;
  while ra<0 do ra:=ra+2*pi;
  while ra>=2*pi do ra:=ra-2*pi;
end;
//PROCEDURE AZ_RA2(AZ,ALT,LAT,LONG,t:double;var ra,dcr: double);{conversion az,alt to ra,dec}
//{input AZ [0..2pi], ALT [-pi/2..+pi/2],lat[-90..90],long[0..360],time[0..2*pi]}
//var
//  sindec,sin_lat, cos_lat, sin_alt, cos_alt,sin_az,cos_az   : double;
//begin
//  sincos(lat*pi/180,sin_lat,cos_lat);
//  sincos(alt,sin_alt,cos_alt);
//  sincos(az,sin_az,cos_az);

//  dcr:=arcsin(sin_alt*sin_lat - cos_alt*cos_az*cos_lat) ;{new Meeus, formule behind 12.6}
//  RA:=arctan2(sin_az, cos_az*sin_lat+tan(alt)*cos_lat  );

//  RA:=RA+long*pi/180 +t;

//  while ra<0 do ra:=ra+2*pi;
//  while ra>=2*pi do ra:=ra-2*pi;
//end;


procedure rotate(rot,x,y :double;var  x2,y2:double);{rotate a vector point, angle seen from y-axis, counter clockwise}
var
  sin_rot, cos_rot :double;
begin
  sincos(rot, sin_rot, cos_rot);
  x2:=x * + sin_rot + y*cos_rot;{ROTATION MOON AROUND CENTER OF PLANET}
  y2:=x * - cos_rot + y*sin_rot;{SEE PRISMA WIS VADEMECUM BLZ 68}
end;

{ra0,dec0: right ascension and declination of the optical axis       }
{x,y     : CCD coordinates                                           }
{cdelt:  : scale of CCD pixel in arc seconds                         }
{ra,dec  : right ascension and declination                           }
procedure standard_equatorial(ra0,dec0,x,y,cdelt: double; var ra,dec : double);{CCD coordinates to RA,DEC}
var sin_dec0 ,cos_dec0 : double;
begin
  sincos(dec0  ,sin_dec0 ,cos_dec0);
  x:=x*cdelt/(3600*180/pi);{scale CCD pixels to standard coordinates (tang angle)}
  y:=y*cdelt/(3600*180/pi);
  ra  := ra0 + arctan (-x / (cos_DEC0- y*sin_DEC0) );
  dec := arcsin ( (sin_dec0+y*cos_dec0)/sqrt(1.0+x*x+y*y) );
end;


PROCEDURE MOON_RADEC (planet,moon:integer; moon_anomoly ,planet_R,dia_planet,planet_RA,planet_dec:double;VAR geo_long,magm,RA,DCR :double);
{moon position calculation}
var x3,y3,z3,xm,ym,zm,xm2,ym2,zm2, xhp,yhp,zhp,dec_h,ra_h,DEC_hm,RA_hm, helio_distance,dummy,distance,adj_dec:double;
    dia_planet_helio,sin_m1,cos_m1,sin_m2,cos_m2   :double;
begin
  cart2(planet_R,planet_dec,planet_ra,x3,y3,z3); {caculate xyz of planet}
  xm:=moon_data[planet,moon,0] {moon distance} * cos(moon_anomoly);{rotation moon in own xy}
  ym:=moon_data[planet,moon,0] {moon distance} * sin(moon_anomoly);
  zm:=0;

  sincos(moon_data[planet,moon,1],sin_m1,cos_m1);
  xm2:=xm;
  ym2:=ym* + sin_m1{theta} +zm*cos_m1{theta};{ROTATION MOON AROUND CENTER OF PLANET}
  zm2:=ym* - cos_m1{theta} +zm*sin_m1{theta};{SEE PRISMA WIS VADEMECUM BLZ 68}
                                                        {sin and cos exchanged to get correct result for moon axis}
  sincos(moon_data[planet,moon,2],sin_m2,cos_m2);
  xm:=xm2 * + sin_m2{phi} + ym2*cos_m2{phi};{ROTATION MOON AROUND CENTER OF PLANET}
  ym:=xm2 * - cos_m2{phi} + ym2*sin_m2{phi};{SEE PRISMA WIS VADEMECUM BLZ 68}
  zm:=zm2;

  {NOTE in principle X_helio_moon+X_helio_planet+X_helio_earth = X_helio_moon+X_geo_planet}
  POLAR2(x3+xm,y3+ym,z3+zm, moon_distance,DCR,RA); {distance and position of moon}
  geo_long:=arctan2(YM,XM)-planet_RA; {geo longitude,as seen from earth}
  while geo_long<0 do geo_long:=geo_long+2*pi; {geo_long could be -pi -2*pi=-3*pi, should be positive}

  {*** and now test if moon is behind planet ***}
  if planet=5 then
        adj_dec:=(dcr-planet_dec)*(71492/66854) +planet_dec {jupiter, adjust very rough for flattening ignore difference equat - eclip}
  else adj_dec:=dcr;        {saturn is not done due to the fact noth pole is pointing far away from north ecliptic}

  ang_sep(ra,adj_dec,planet_ra,planet_dec,{var} distance);
  if ((distance*2*360*60*60/(2*pi)<=dia_planet) and (abs(geo_long-pi)>pi*0.5))
     then magm:=999; {behind planet.}

  {*** and now test if moon in shadow planet ***}
  if magm<>999 then
  begin
    get_planet_equatorial_heliocentrisch(xhp,yhp,zhp);

    POLAR2 (Xhp,Yhp,Zhp, helio_distance,dec_h,ra_h); {distance and position of planet heliocentrisch}

    {==calculate moon  shadow on planet}
    dec_shadow:=1000; {no shadow on planet, default in case the calculation below is not run}
    if (abs(geo_long-pi)<pi*0.5) then {moon on the front}
    begin
      moon_distance:=(moon_data[planet,moon,0]-moon_data[planet,0,0])/helio_distance;{distance_jup_surface<->moon/distance_jup<->sun, aproximation since shadow is not in the middle}
      POLAR2 (x3+xm+xhp*moon_distance,y3+ym+yhp*moon_distance,z3+zm+zhp*moon_distance, dummy,dec_shadow,RA_shadow); {position of moon shadow}
      ang_sep(planet_ra,planet_dec,ra_shadow,dec_shadow,{var} distance);{separation moon and center planet shadow using geo positions}
      if (distance*2*180*60*60/pi>dia_planet) then {dia_planet since we are using geo positions}
          dec_shadow:=1000; {no shadow on planet.}
    end;{moon on the front}
    {==end of moon calculate shadow on planet}

    if (abs(geo_long-pi)>pi*0.5) then {behind planet}
    begin
      {correction shadow diameter}
      dia_planet_helio:=dia_planet*planet_r/helio_distance;{diameter planet helio centric as seen from sun}
      dia_planet_helio:=dia_planet_helio* (1 - moon_data[planet,moon,0]*(0.5*1392720/ae)/(helio_distance*moon_data[planet,0,0]));
                        {correction shadow for moon distance from planet, 1.5 % iapetus, 2.4 % callisto}

       POLAR2 (Xhp+xm,Yhp+ym,Zhp+zm, dummy,dec_hm,RA_hm); {distance and position of moon heliocentrisch}

      {extra} if planet=5 then dec_hm:=(dec_hm-dec_h)*(71492/66854) +dec_h; {jupiter, adjust very rough for flattening. Ignore difference equat - eclip}

       ang_sep(ra_h,dec_h,ra_hm,dec_hm,{var} distance);{separation moon and center planet shadow using helio positions}

      {Alternative solution}
      {note han: scalair product:  cos(w)*|a|*|b|=Xa*Xb+Ya*Yb+Za*Zb. See prisma wis vad. }
      {distance:=(xhp*(xhp+xm)+yhp*(yhp+ym)+zhp*(zhp+zm))/(sqrt(xhp*xhp+yhp*yhp+zhp*zhp)*sqrt((xhp+xm)*(xhp+xm)+(yhp+ym)*(yhp+ym)+(zhp+zm)*(zhp+zm)));}
      {distance:=sqrt(abs(1-sqr(distance)));}

      if (distance*2*180*60*60/pi<=dia_planet_helio)  {dia_planet_helio since we are using helio positions}
          then  magm:=1000; {in planet shadow.}
    end;{behind planet}

  end;
  x_pln:=x3+xm;{update x,y,z in Upla for general purposes such as loadfitsplanet in hns_res}
  y_pln:=y3+ym;
  z_pln:=z3+zm;
end;

PROCEDURE PARALLAX_XYZ(WTIME,latitude : double;var X,Y,Z: double); { {X,Y,Z in AU,  By Han Kleijn}
{wtime= Sidereal time at greenwich - longitude, equals azimuth position of the sky for the observer.
{ wtime:=limit_radialen((-longitude*pi/180)+siderealtime2000 +(julian-2451545 )* earth_angular_velocity,2*pi); {longitude positive if WEST}
{ siderealtime2000=(280.46061837-90)*pi/180       earth_angular_velocity=pi*2*1.00273790935}
{see also new meeus page 78}
{parallax can be 8.8 arcsec  per au distance. }
var
    sin_latitude_corrected,
    cos_latitude_corrected,
    height_above_sea,
    flatteningearth,
    x_observ,y_observ,z_observ,u :double;

Begin
  height_above_sea:=100;{meters}
  flatteningearth:=0.99664719; {earth is not perfect round}

  u:=arctan(flatteningearth*sin(latitude)/cos(latitude)); {tan:=sin/cos}
  sin_latitude_corrected:=flatteningearth*sin(u)+height_above_sea*sin(latitude)/6378140;
  cos_latitude_corrected:=cos(u)+height_above_sea*cos(latitude)/6378140;
  {above values are very close to sin(latitude) and cos(latitude)}

  X_observ := (6378.14/AE)*cos_latitude_corrected * COS(wtime);
  Y_observ := (6378.14/AE)*cos_latitude_corrected * SIN(wtime);
  Z_observ := (6378.14/AE)*sin_latitude_corrected;
  X:=X-X_observ; Y:=Y-Y_observ; Z:=Z-Z_observ;
end;

procedure ang_sep(ra1,dec1,ra2,dec2 : double;var sep: double);{Version 2018-5-23, calculates angular separation. according formula 9.1 old Meeus or 16.1 new Meeus, version 2018-5-23}
var
    sin_dec1,cos_dec1,sin_dec2,cos_dec2, cos_sep:double;
Begin
  sincos(dec1,sin_dec1,cos_dec1);{use sincos function for speed}
  sincos(dec2,sin_dec2,cos_dec2);

  cos_sep:=sin_dec1*sin_dec2+ cos_dec1*cos_dec2*cos(ra1-ra2);
  sep:=arccos(cos_sep);
end;


function floattostr2(x:double):string;
begin
  str(x:10:6,result);
end;

procedure val_local(s:string;var x:double;var error1:integer);{uses the current decimal seperator, either dot or komma}
begin                                                         {an other option is setting the FormatSettings.DecimalSeparator temporary}
  if local_DecimalSeparator<>'.' then s:=StringReplace(s,local_DecimalSeparator,'.',[]);{replaces komma by dot}
  val(s,x,error1);
end;
procedure str_local(const x:double; width1,decimals1 :word; var s: String);{uses the current decimal seperator, either dot or komma}
begin                                                                      {an other option is setting the FormatSettings.DecimalSeparator temporary and use floattostrF}
  str(x:width1:decimals1,s);
  if local_DecimalSeparator<>'.' then  s:=StringReplace(s,'.',local_DecimalSeparator,[]); {replaces dot by komma}
end;

function floattostrF_local(const x:double; width1,decimals1 :word): string;{uses the current decimal seperator, either dot or komma}
begin                                                                      {an other option is setting the FormatSettings.DecimalSeparator temporary and use floattostrF}
  str(x:width1:decimals1,result);
  if local_DecimalSeparator<>'.' then result:=StringReplace(result,'.',local_DecimalSeparator,[]); {replaces dot by komma}
end;

function strtofloat_local(s:string): double;{uses the current decimal seperator, either dot or komma}
var
  error1:integer;
begin
  if local_DecimalSeparator<>'.' then s:=StringReplace(s,local_DecimalSeparator,'.',[]); {replaces komma by dot}
  val(s,result,error1);
end;

function number_of_decimals_required(inp:double):integer;
begin
  if inp<0.000001 then result:=9
  else
  if inp<0.00001 then result:=8
  else
  if inp<0.0001 then result:=7
  else
  if inp<0.001 then result:=6
  else
  if inp<0.01 then result:=5
  else
  if inp<0.1 then result:=4
  else
  if inp<1 then result:=3
  else
  if inp<10 then result:=2
  else
  if inp<100 then result:=1
  else
  result:=0;
end;

FUNCTION fnmodulo (x,range: double):double;
BEGIN
   {range should be 2*pi or 24 hours or 0 .. 360}
   x:=range *frac(X /range); {quick method for big numbers}
   if x<0 then x:=x+range;   {do not like negative numbers}
   fnmodulo:=x;
END;

{$IFDEF fpc}
const
 TwoDigitLookup : packed array[0..99] of array[1..2] of ansiChar =
   ('00','01','02','03','04','05','06','07','08','09',
    '10','11','12','13','14','15','16','17','18','19',
    '20','21','22','23','24','25','26','27','28','29',
    '30','31','32','33','34','35','36','37','38','39',
    '40','41','42','43','44','45','46','47','48','49',
    '50','51','52','53','54','55','56','57','58','59',
    '60','61','62','63','64','65','66','67','68','69',
    '70','71','72','73','74','75','76','77','78','79',
    '80','81','82','83','84','85','86','87','88','89',
    '90','91','92','93','94','95','96','97','98','99');

//fast pure pascal by John O'Harrow see:
//http://www.fastcode.dk/fastcodeproject/fastcodeproject/61.htm
//function IntToStr_JOH_PAS_5(Value: Integer): string;
//almost as fast as str in Delphi. Much faster then str in FPC}
function inttoStr2(Value: Integer):ansistring;{fast str routine for FPC}
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative       : Boolean;
  I, J, K        : Cardinal;
  Digits         : Integer;
  P              : PByte;
  NewLen         : Integer;
begin
  Negative := (Value < 0);
  I := Abs(Value);
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
 NewLen  := Digits + Ord(Negative);

 SetLength(Result, NewLen);

 P := Pointer(Result);
 P^ := Byte('-');
 Inc(P, Ord(Negative));
 if Digits > 2 then
 repeat
      J  := I div 100;           {Dividend div 100}
      K  := J * 100;
      K  := I - K;               {Dividend mod 100}
      I  := J;                   {Next Dividend}

      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K]);
  until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I])
  else
    P^ := I or ord('0');
end;
{$ENDIF}

//http://fastcode.sourceforge.net/
//function ValLong_JOH_PAS_4_c(Value: Integer): string;
function Valint32(const s; var code: Integer): Longint;{fast val function, about 4 x faster}
var
  Digit: Integer;
  Neg, Hex, Valid: Boolean;
  P: PChar;
begin
  Code := 0;
  P := Pointer(S);
  if not Assigned(P) then
    begin
      Result := 0;
      inc(Code);
      Exit;
    end;
  Neg   := False;
  Hex   := False;
  Valid := False;
  while P^ = ' ' do
    Inc(P);
  if P^ in ['+', '-'] then
    begin
      Neg := (P^ = '-');
      inc(P);
    end;
  if P^ = '$' then
    begin
      inc(P);
      Hex := True;
    end
  else
    begin
      if P^ = '0' then
        begin
          inc(P);
          Valid := True;
        end;
      if Upcase(P^) = 'X' then
        begin
          Hex := True;
          inc(P);
        end;
    end;
  Result := 0;
  if Hex then
    begin
      Valid := False;
      while True do
        begin
          case P^ of
            '0'..'9': Digit := Ord(P^) - Ord('0');
            'a'..'f': Digit := Ord(P^) - Ord('a') + 10;
            'A'..'F': Digit := Ord(P^) - Ord('A') + 10;
            else      Break;
          end;
          if (Result < 0) or (Result > $0FFFFFFF) then
            Break;
          Result := (Result shl 4) + Digit;
          Valid := True;
          inc(P);
        end;
    end
  else
    begin
      while True do
        begin
          if not (P^ in ['0'..'9']) then
            break;
          if Result > (MaxInt div 10) then
            break;
          Result := (Result * 10) + Ord(P^) - Ord('0');
          Valid := True;
          inc(P);
        end;
      if Result < 0 then {Possible Overflow}
        if (Cardinal(Result) <> $80000000) or (not neg) then
          begin {Min(LongInt) = $80000000 is a Valid Result}
            Dec(P);
            Valid := False;
          end;
    end;
  if Neg then
    Result := -Result;
  if (not Valid) or (P^ <> #0) then
    Code := P-@S+1;
end;

procedure find_inc_ring(ra,dec:double); {find inclination SATURN ring}
var
    x,y,z,xr,yr,zr,cosangle,angle:double;
begin
  cart2(1,dec,ra,x,y,z); {caculate xyz of planet}
  cart2(1,moon_data[6,0,1],moon_data[6,0,2],xr,yr,zr); {caculate xyz of ring}

  { note han: scalair product:  cos(w)*|a|*|b|=Xa*Xb+Ya*Yb+Za*Zb. See prisma wis vad. }
  { |a|*|b| are sqrt((x*x+y*y+z*z)*(xr*xr+yr*yr+zr*zr)) but value in this case value is always one}

  COSangle:=(x*xr+y*yr+z*zr); {=(cos(w)}
  angle:=arctan( sqrt(abs(1-sqr(COSangle))) / COSangle );  {REM   ArcCOS = arctan(  sqrt(abs(1-sqr(w))) / w )  }
  IF angle > 0 then ring_inc:= +(PI / 2) - angle else ring_inc:= -(PI / 2) - angle;
end;

//procedure find_planet_crota(planet:integer;ra,dec:double;var rot1:double); {find planet rotation as seen}
//var
//    x,y,z,xr,yr,zr,cosangle,angle,dec0,ra0:double;
//begin
{  p:=atn2(cos(dec0)*sin(ra0-ra), sin(dec0)*cos(dec)-cos(dec0)*sin(dec)*cos(ra0-ra) ); nieuw meeus page 304 from 15 or formula 41.4 }
//  dec0:=moon_data[planet,0,1];
//  ra0:=moon_data[planet,0,2];
//  rot1:=-arctan2(cos(dec0)*sin(ra0-ra), sin(dec0)*cos(dec)-cos(dec0)*sin(dec)*cos(ra0-ra) ); {nieuw meeus page 304 from 15 or formula 41.4 }
//end;

var  sinj3, sinj4,sinj5,sinj6, sinj7, sinj8,sinS3,sins4, SinS7, SinS8, SinS9, sinXN7 :double;{these values will be used later}
PROCEDURE Update_theta_phi(julian:double);{recalculate moon orientation}
var Tc     : double;
    j3,j4, j5,j6,j7,j8,cosj3, cosj4, cosj5, cosj6, cosj7,cosj8  : double; {for jupiter moons}
    s3,s4,s7,s8,s9,coss3,coss4,coss7,coss8  : double; {for Saturn moons}
    N7  :double;

begin
  Tc:= (julian-2451545)/36525;

  {long term correction}
  moon_data[1,0,2]:=(281.0097 - 0.0328 * Tc) * pi/180;  {phi Mercury, 2009}
  moon_data[1,0,1]:=( 61.4143 - 0.0049 * Tc) * pi/180;  {theta Mercury}

  {long term correction}
  moon_data[3,0,2]:=( 0.00 - 0.641 * Tc) * pi/180;  {phi Earth}
  moon_data[3,0,1]:=(90.00 - 0.557 * Tc) * pi/180;  {theta Earth}


  {mars moons}
  moon_data[4,1,2]:=(317.68 -  0.108 * Tc) * pi/180;  {phi phobos, small fast terms not included}
  moon_data[4,1,1]:=(52.90  -  0.061 * Tc) * pi/180;  {theta phobos, small fast terms not included}

  moon_data[4,2,2]:=(316.65 - 0.108 * Tc ) * pi/180;  {phi deimos}
  moon_data[4,2,1]:=(53.52 -  0.061 * Tc ) * pi/180;  {theta deimos}

  {jupiter moons}
  J3:=(283.90 + 4850.7 * Tc)* pi/180; sinj3:=sin(j3);cosj3:=cos(j3);
  J4:=(355.80 + 1191.3 * Tc)* pi/180; sinj4:=sin(j4);cosj4:=cos(j4);
  J5:=(119.90 + 0262.1 * Tc)* pi/180; sinj5:=sin(j5);cosj5:=cos(j5);
  J6:=(229.80 + 0064.3 * Tc)* pi/180; sinj6:=sin(j6);cosj6:=cos(j6);
  J7:=(352.25 + 2382.6 * Tc)* pi/180; sinj7:=sin(j7);cosj7:=cos(j7);
  J8:=(113.35 + 6070.0 * Tc)* pi/180; sinj8:=sin(j8);cosj8:=cos(j8);

  moon_data[5,1,2]:=(268.05 - 0.009 * Tc + 0.094 * sinj3 + 0.024 * sinj4) * pi/180;  {phi io}
  moon_data[5,1,1]:=(64.50  + 0.003 * Tc + 0.040 * cosJ3 + 0.011 * cosj4) * pi/180;  {theta io}

  moon_data[5,2,2]:=(268.08 - 0.009 * Tc + 1.086 * sinj4 + 0.060 * sinj5 + 0.015 * sinj6 + 0.009 * sinj7)  * pi/180;  {phi europa}
  moon_data[5,2,1]:=(64.51  + 0.003 * Tc + 0.468 * cosJ4 + 0.026 * cosj5 + 0.007 * cosJ6 + 0.002 * cosj7 )* pi/180;  {theta europa}

  moon_data[5,3,2]:=(268.20 - 0.009 * Tc - 0.037 * sinj4 + 0.431 * sinj5 + 0.091 * sinj6 )* pi/180;  {phi ganymede}
  moon_data[5,3,1]:=(64.57  + 0.003 * Tc - 0.016 * cosJ4 + 0.186 * cosj5 + 0.039 * cosJ6 )* pi/180;  {theta ganymede}

  moon_data[5,4,2]:=(268.72 - 0.009 * Tc - 0.068 * sinj5 + 0.590 * sinj6 + 0.010 * sinj8 )* pi/180;  {phi calisto}
  moon_data[5,4,1]:=(64.83  + 0.003 * Tc - 0.029 * cosJ5 + 0.254 * cosj6 - 0.004 * cosJ8 )* pi/180;  {theta calisto}

  S3:=(177.40 - 36505.5 * Tc)* pi/180; sins3:=sin(s3);coss3:=cos(s3);
  S4:=(300.00 - 07225.9 * Tc)* pi/180; sins4:=sin(s4);coss4:=cos(s4);
  S7:=(345.20 - 01016.3 * Tc)* pi/180; sins7:=sin(s7);coss7:=cos(s7);
  S8:=(029.80 - 00052.1 * Tc)* pi/180; sins8:=sin(s8);coss8:=cos(s8);
  S9:=(316.45 + 00506.2 * Tc)* pi/180; sins9:=sin(s9);{for later calc W}

  moon_data[6,0,2]:=(40.589 - 0.036 * Tc) * pi/180;  {phi saturn & ring}
  moon_data[6,0,1]:=(83.537 - 0.004 * Tc) * pi/180;  {theta Saturn & ring}

  moon_data[6,1,2]:=(40.589 - 0.036 * Tc + 13.56 * sins3) * pi/180;  {phi mimas}
  moon_data[6,1,1]:=(83.537 - 0.004 * Tc - 1.530 * cosS3) * pi/180;  {theta mimas}

  moon_data[6,2,2]:=(40.589 - 0.036 * Tc ) * pi/180;  {phi enceladus}
  moon_data[6,2,1]:=(83.537 - 0.004 * Tc ) * pi/180;  {theta enceladus}

  moon_data[6,3,2]:=(40.589 - 0.036 * Tc + 9.660 * sins4) * pi/180;  {phi tethys}
  moon_data[6,3,1]:=(83.537 - 0.004 * Tc - 1.090 * cosS4) * pi/180;  {theta tethys}

  moon_data[6,4,2]:=(40.589 - 0.036 * Tc ) * pi/180;  {phi dione}
  moon_data[6,4,1]:=(83.537 - 0.004 * Tc ) * pi/180;  {theta dione}

  moon_data[6,5,2]:=(40.38 - 0.036 * Tc + 3.10 * sins7) * pi/180;  {phi rhea}
  moon_data[6,5,1]:=(83.55 - 0.004 * Tc - 0.35 * cosS7) * pi/180;  {theta rhea}

  moon_data[6,6,2]:=(36.41 - 0.036 * Tc + 2.66 * sins8) * pi/180;  {phi titan}
  moon_data[6,6,1]:=(83.94 - 0.004 * Tc - 0.30 * cosS8) * pi/180;  {theta titan}

  moon_data[6,7,2]:= moon_data[6,6,2]; {hyperion   phi and theta change are not publiced. chaotic orbit}
  moon_data[6,7,1]:= moon_data[6,6,1];

  moon_data[6,8,2]:=(318.16 - 3.949 * Tc ) * pi/180;  {phi iapetus}
  moon_data[6,8,1]:=( 75.03 - 1.143 * Tc ) * pi/180;  {theta iapetus}

  {neptune moon triton}
  N7:=(177.85 + 52.316 * Tc)* pi/180;
  sinXN7:=22.25*sin(N7) + 6.73*sin(2*N7) + 2.05*sin(3*N7) + 0.74*sin(4*N7) + 0.28*sin(5*N7) + 0.11*sin(6*N7);{for W factor later}

  moon_data[8,1,2]:=(299.36 - 32.35*sin(N7) - 6.28*sin(2*N7) - 2.08*sin(3*N7) - 0.74*sin(4*N7) - 0.28*sin(5*N7)) * pi/180;  {phi triton}
  moon_data[8,1,1]:=( 41.17 + 22.55*cos(N7) + 2.10*cos(2*N7) + 0.55*cos(3*N7) + 0.16*cos(4*N7))  * pi/180;  {theta triton}
end;

PROCEDURE planetmoons(planet,moon: integer; julian,ra,dcr,mag_planet,delta,
                                      dia_planet:double;var ram,decm ,magm,diameterm : double);
Var UM                          : double;
    geo_long                    : double;{longitude as seen from earth}
    D,t,w, m1,m2,m3,sinm1,sinm2,sinm3,cosm3 :double;

//    u1corr,u2corr,wraw:double;
BEGIN
  D := julian - 2451545; {year 2000 january 1 12 hours TD}
  t:=D -delta/173;

  w:= (moon_data[planet,moon,4] +(moon_data[planet,moon,3])*t);
  {now corrections if any}
  case planet of 4:{mars}
                 case moon of 1:begin
                                  M1:=(169.51 - 0.4357640 * t)* pi/180; sinm1:=sin(m1);
                                  M2:=(192.93 + 1128.4096700 * julian + 0.6644e-9 * julian * julian)* pi/180;sinm2:=sin(m2);
                                  W:=35.06+1128.8445850*t+0.6644e-9*t*t-1.42*sinm1-0.78*sinm2;
                                end;
                              2:begin
                                  M3:=(53.47 - 0.0181510 * t)* pi/180;sinm3:=sin(m3);cosm3:=cos(m3);
                                  W:=79.41+285.1618970*t-0.390e-10*t*t-2.58*sinm3+0.19*cosm3;
                                end;
                              end;{case moon}
                 5:{jupiter}
                 case moon of 1: W:=W + 0.473 * sin(pi/180 * 2 * (163.8067 - 358.4108 + (203.4058643 - 101.2916334) * t)) {short term corrections only, meeus new page  286, io}
                                      - 0.085 * sinj3 - 0.022 * sinj4;{long term corrections based on astronomical supplement}
                              2:
                              begin
                              // u2corr:=+ 1.065 * sin(pi/180 * 2 * (358.4108 - 5.7129   + (101.2916334 -  50.2345179) * t)); {short term correction europa}
                             //  wraw:=fnmodulo( w   ,360);
                              W:=W + 1.065 * sin(pi/180 * 2 * (358.4108 - 5.7129   + (101.2916334 -  50.2345179) * t)) {short term correction europa}
                                      - 0.980 * sinj4 - 0.054 * sinj5  - 0.014 * sinj6 - 0.008 * sinj7; {corrections based on astronomical supplement}
                              end;
                              3: W:=W + 0.165 * sin(pi/180 * (331.18 + 50.310482 * t)) +  {short term ganymede}
                                      + 0.033 * sinj4 - 0.389 * sinJ5 - 0.082 * sinj6;{long term callisto corrections based on astronomical supplement}
                              4: W:=W + 0.841 * sin(pi/180 * (87.40 + 21.569231 * t)) +  {short term correction Callisto based on meeus page 286}
                                      + 0.061 * sinJ5 - 0.533 * sinJ6 - 0.009 * sinJ8; {long term callisto corrections based on astronomical supplement}
                              end;
                 6:{Saturn}
                 case moon of 1: W:=W -  13.48 * sinS3 - 44.85 * sinS9; { correction Mimas based on astronomical supplement}
                              3: W:=W -   9.60 * sinS4 +  2.23 * sinS9; { correction Tethys based on astronomical supplement}
                              5: W:=W -   3.08 * sinS7                ; { correction Rhea based on astronomical supplement}
                              6: W:=W -   2.64 * sinS8                ; { correction Titan based on astronomical supplement}
                              end;
                 8:{Neptune}
                 case moon of 1: W:=W + sinXN7 ; {long term correction Triton based on astronomical supplement}
                              end;

                 end; {planet of}

  um:=fnmodulo( w * pi/180  ,Pi*2);

  magm:=mag_planet+moon_data[planet,moon,6];

  {0=distance, 1=theta orbit,2=phi orbit, 3=orbittime,4=orbit pos, 5=diam, 6=delta mag}
  MOON_RADEC(planet,moon,um, delta,dia_planet,RA,DCR,   geo_long,MAGM,raM,decM);
//  diameterm:= 10*pi*2*3600*moon_data[planet,moon,5]/(delta);{10*radialen sec}
  diameterm:= (360*60*60/ (pi*2))*moon_data[planet,moon,5]/(delta);{10*radialen sec}
  if ((planet=6) and (moon=8)) then
   magm:=magm - ln(4-3*sin(geo_long))*(2.5/ln(10)); {log(x) is ln(x)/ln(10)}
               {magnitude of iapetes is sinus of position with peak to peak 2,1 magnitude difference}
               {ln to make magnitude from intensity}
               {calculation based on magnitude values from kosmos himmelbook 1999}
               {see also S&W 8/2000 seite 659}
               {see als astronomical supplement page 411, factor is 7.042 or 2.12 magnituden}

 {for test purposes}
 //   magm:=fnmodulo(geo_long*180/pi,360);
 // magm:=geo_long*180/pi;

 END;
 

Procedure nutation_aberration_correction_equatorial_classic(var ra,dec:double);{M&P page 208}
var r,x0,y0,z0,vx,vy,vz:double;
begin
  cart2(1,dec,ra,x0,y0,z0); {make cartesian coordinates}
  NUTEQU((julian_et-2451545.0)/36525.0, X0,Y0,Z0);{add nutation}

  ABERRAT((julian_et-2451545.0)/36525.0, VX,VY,VZ);{ABERRAT: velocity vector of the Earth in equatorial coordinates and units of the velocity of light}
  x0:=x0+VX;{apply aberration,(v_earth/speed_light)*180/pi=20.5"}
  y0:=y0+VY;
  z0:=z0+VZ;

  polar2(x0,y0,z0,r,dec,ra);
end;


procedure nutation_correction_equatorial(var ra,dec:double);  {Nutation only valid if DE430 called}
var sin_ecl,cos_ecl,x0,y0,z0,r :double;
    nut  : double33;
begin
  // nutation matrix
  sincos(ecliptic2*pi/180,sin_ecl,cos_ecl);
  nut[1,1]:= 1;
  nut[1,2]:= -cos_ecl * nutation_1[0]{nutation in longitude};
  nut[1,3]:= -sin_ecl * nutation_1[0]{nutation in longitude};
  nut[2,1]:= +cos_ecl * nutation_1[0]{nutation in longitude};
  nut[2,2]:= 1;
  nut[2,3]:= -nutation_1[1]{nutation in obliquity};
  nut[3,1]:= +sin_ecl * nutation_1[0]{nutation in longitude};
  nut[3,2]:= +nutation_1[1]{nutation in obliquity};
  nut[3,3]:= 1;

  cart2(1,dec,ra,x0,y0,z0);{cartesian coordinates object}
  precart(nut,x0,y0,z0);{multiply with the nutation matrix}
  polar2(x0,y0,z0,r,dec,ra); {test sao382288 on 2028-11-13.19 delta_ra=15.843"(15.91"_ and delta_dec=6.218" (6.372") Meeus2 page 141}
end;

procedure aberration_correction_equatorial(var ra,dec:double);{input radians, aberration based on earth vectors. Only valid when DE430 is used}
var  {ra_direction,dec_direction,}
     r:double;
     x0,y0,z0 : double;
begin
//  polar2(earth_vectors[3] {speed in in x},earth_vectors[4] {speed in y},earth_vectors[5]{speed in z},r,dec_direction,ra_direction);
//  delta_ra:=sin(ra_direction-ra)*20.49552*pi/(180*60*60); {abberation is maximum 20.5 arc seconds}
//  delta_dec:=sin(dec_direction-dec)*20.5*pi/(180*60*60); {abberation is maximum 20.5 arc seconds}
//  ra2:=ra+delta_ra;
//  dec2:=dec+delta_dec;

    cart2(1,dec,ra,x0,y0,z0);
    x0:=x0+earth_helio[3]*0.00009935*180/pi;{apply aberration,(v_earth/speed_light)*180/pi=20.5"}
    y0:=y0+earth_helio[4]*0.00009935*180/pi;
    z0:=z0+earth_helio[5]*0.00009935*180/pi;
    polar2(x0,y0,z0,r,dec,ra); {test sao382288 on 2028-11-13.19 delta_ra=29.64" an delta_dec=6.526" Meeus2 page 141}
end;


begin
end.
