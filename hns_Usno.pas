unit hns_usno;  {reads USNO UCAC4}
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
     {$endif}
     {$ifdef unix}
     baseunix,
     {$endif}
     SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Menus,
     hns_main
     ;

procedure closeUSNO; {closes USNO/UCAC4/3 reader}

procedure findregionUCAC4(dc:tcanvas;cd_UCAC:string;ra,dec,max:double;find_star_nr:integer; var error_index:boolean); {find UCAC region, if find_star_nr<>0 goto regio}
procedure read_UCAC4(dc:tcanvas;epoch2:double;var ra,dec: double; var  mag_UCAC:integer{;star_nr1:string});{Read UCAC4 star database}
var  UCAC_class  : shortint; {start of double star}
     UCAC_leda_diameter  : shortint; {log10 object diameter in 0.1  arcmin}
     UCAC_X2M_diameter  : shortint; {X2M diameter 0.1  arcmin}
     UCAC_poor_PM: shortint; {proper motion capped}
var
   mass_id_nr:  integer;
   UC4_source:  integer;
   APASS_B_V   :  integer; {color by B magnitude minus V magnitude}
   APASS_error :  integer;


implementation
//uses hns_main;
type

  UCAC4hdr = packed record  {version 2013, packed required in delphi 7 to get correct length}

{ 1  ra     I*4 mas}        RAU  : integer;     //right ascension at  epoch J2000.0 (ICRS)  (1)
{ 2  spd    I*4 mas}        DECU : integer;     //south pole distance epoch J2000.0 (ICRS)  (1)
{ 3  im1    I*2 millimag}   U4Fmag: smallint;   //UCAC fit model magnitude                  (2)
{ 4  im2    I*2 millimag}   U4Amag: smallint;   //UCAC aperture  magnitude                  (2)
{ 5  sigmag I*1  1/100 mag} U4REag: shortint;   //UCAC error on magnitude (larger of sc.mod)(3)
{ 6  objt   I*1} 	          U4object: shortint; //object type                               (4)
{ 7  dsf    I*1}            U4doubleflag: shortint;// double star flag                          (5)
// 15 bytes

{ 8  sigra  I*1 mas}        e_RAm: shortint;    //s.e. at central epoch in RA (*cos Dec)
{ 9  sigdc  I*1 mas}        e_DEm: shortint;    //s.e. at central epoch in Dec
{10  na1    I*1}            na1  : shortint;    //total # of CCD images of this star
{11  nu1    I*1}            nrCCD: shortint;    // # of CCD images used for this star        (6)
{12  us1    I*1}            ncatepoch : shortint;// # catalogs (epochs) used for proper motions
// 5bytes

{13  cepra  I*2 0.01 yr}    EpRAm1900: smallint; //central epoch for mean RA, minus 1900
{14  cepdc  I*2 0.01 yr}    EpDEm1900: smallint; //central epoch for mean Dec,minus 1900
{15  pmrac  I*2 0.1 mas/yr} pmRA : smallint;      //proper motion in RA*cos(Dec)
{16  pmdc   I*2 0.1 mas/yr} pmDE : smallint;      //proper motion in Dec
{17  sigpmr I*1 0.1 mas/yr} e_pmRA: shortint;    //s.e. of pmRA * cos Dec
{18  sigpmd I*1 0.1 mas/yr} e_pmDE: shortint;    //s.e. of pmDec
// 10 bytes

{19  id2m   I*4}            mass_id: integer;    //2MASS unique star identifier
{20  jmag   I*2 millimag}   mag_J  : smallint;   //2MASS J  magnitude
{21  hmag   I*2 millimag}   mag_K  : smallint;   //2MASS H  magnitude
{22  kmag   I*2 millimag}   mag_H  : smallint;   //2MASS K_s magnitude
{23  icqflg I*1 * 3}        icqflg1: shortint;   //2MASS cc_flg*10 + phot.qual.flag J        (7)
{24}                        icqflg2: shortint;   //2MASS cc_flg*10 + phot.qual.flag H        (7)
{25}                        icqflg3: shortint;   //2MASS cc_flg*10 + phot.qual.flag K_s      (7)
{26  e2mpho I*1 * 3}        e2mpho1: shortint;   //2MASS error photom. J (1/100 mag)         (8)
{27}                        e2mpho2: shortint;   //2MASS error photom. H(1/100 mag)          (8)
{28}                        e2mpho3: shortint;   //2MASS error photom. K_s(1/100 mag)        (8)
// 16 bytes

{29         I*2 millimag}   APASS_B: smallint;   //B magnitude from APASS
{30         I*2 millimag}   APASS_V: smallint;   //V magnitude from APASS
{31         I*2 millimag}   APASS_g: smallint;   //g magnitude from APASS
{32         I*2 millimag}   APASS_r: smallint;   //r magnitude from APASS
{33         I*2 millimag}   APASS_i: smallint;   //i magnitude from APASS
{34   apase  I*1 1/100 mag} apas_EB: shortint;  // error of B magnitude from APASS         (14)
{35   apase  I*1 1/100 mag} apas_EV: shortint;  // error of V magnitude from APASS         (14)
{36   apase  I*1 1/100 mag} apas_Eg: shortint;  // error of g magnitude from APASS         (14)
{37   apase  I*1 1/100 mag} apas_Er: shortint;  // error of r magnitude from APASS         (14)
{38   apase  I*1 1/100 mag} apas_Ei: shortint;  // error of i magnitude from APASS         (14)
{39  g1     I*1}            yale_g1: shortint;  //  Yale SPM g-flag*10  c-flag
// 16  bytes

{40 63-66 icf(1) I*4}       icf_info: integer;   //  FK6-Hipparcos-Tycho source flag         (16)
{41       icf(2) .. }                            //  AC2000       catalog match flag         (17)
{42       icf(3) .. }                            //  AGK2 Bonn    catalog match flag         (17)
{43       icf(4) .. }                            //  AKG2 Hamburg catalog match flag         (17)
{44       icf(5) .. }                            //  Zone Astrog. catalog match flag         (17)
{45       icf(6) .. }                            //  Black Birch  catalog match flag         (17)
{46       icf(7) .. }                            //  Lick Astrog. catalog match flag         (17)
{47       icf(8) .. }                            //  NPM  Lick    catalog match flag         (17)
{48       icf(9) .. }                            //  SPM  YSJ1    catalog match flag         (17)
//  4 bytes

{49 67    leda   I*1}       leda  : shortint;    //  LEDA galaxy match flag                  (18)
{50 68    x2m    I*1}       x2m   : shortint;    //  2MASS extend.source flag                (19)
{51 69-72 rnm    I*4}       rnm   : integer;     //  unique star identification number       (20)
{52 73-74 zn2    I*2}       zn2   : smallint;    //  zone number of UCAC2 (0 = no match)     (21)
{53 75-78 rn2    I*4}       rn2   : integer;     //  running record number along UCAC2 zone  (21)
// 12 bytes

{    78 = total number of bytes per star record}
end;{UCAC4 record}



var
   bufc4: array[1..sizeof(UCAC4hdr)] of byte;
   puc4      : ^UCAC4hdr;		        { pointer to UCAC record }

var
   TheFile_USNO   : TfileStream;
   Reader_USNO    : TReader;
   nr_records     : integer;
   recordposition : integer;
   maxmag         : double;


   starsdone       : array[1..13] of integer;
   filename_UCAC   : array[1..13] of string;
   seek_startposition    : array[1..13] of integer;
   seek_stopposition    : array[1..13] of integer;
   band_nr:integer;
   Ucaczon              : array[1..13] of integer;

const
   USNOfile_open: byte=0;



procedure closeUSNO; {closes USNO reader}
begin
  if USNOfile_open=2 then
  begin
    Reader_USNO.free;
    TheFile_USNO.free;
  end;
  USNOfile_open:=0;
end;

var
   u4indexda : array[1..2,0..1439,1..900] of integer;{n0 nn, index, zone} {binair index file u3index.unf}   {u4indexda could be in the precudre, but linux compiler gives error}
procedure findregionUCAC4(dc:tcanvas;cd_UCAC:string;ra,dec,max:double;find_star_nr:integer; var error_index:boolean); {find UCAC region, if find_star_nr<>0 goto regio}
var
  zone                            : string[120];
  i,j,zon1                        : integer;
  raband,zonreal,rastart,rastop,
  dec2                            : double;
  indexname                       : string;

begin
  closeUSNO;
  maxmag:=max*10; {x 10 maximum}

  USNOfile_open:=1;
  indexname:= cd_UCAC+'u4index.unf';      {ucac4}
  try
    TheFile_USNO:=tfilestream.Create(indexname , fmOpenRead or fmShareDenyWrite);
    thefile_USNO.read(u4indexda,sizeof(u4indexda)); {read index file info}
  except;
//    setbkmode(dc.handle,Opaque); {!!!! not transparent}
    canvas_error_message(indexname+'  '+not_found);{error message to canvas}
    error_index:=true;
    TheFile_USNO.free;
    USNOfile_open:=0;
    exit;
  end;
  error_index:=false;
  TheFile_USNO.free;
  USNOfile_open:=0;

  if find_star_nr<>0 then {move to regio}
  begin
    zon1:=trunc(find_star_nr/1000000);{get digit 987 from 3UCzzz-nnnnnn}
     i:=0;
    repeat
      if u4indexda[1,I,zon1]+ u4indexda[2,I,zon1]>(find_star_nr-zon1*1000000) then {note 2009, u2indexda[1,I,zon1] + u2indexda[2,239,zon1] gives the star number at the end of the current are}
      begin {star in this zone}
        ucaczon[1]:=zon1;{move to correct zone}
        ra:=(i+1)*pi*2/1440; {ucac4, was 240}
        i:=9999;{end}
        zon1:=9999;{end}
      end;
        inc(i);
      until i>1439  {UCAC4, was 239};
  end {find star number and go to}
  else
  begin {normal find zone and band}
    zonreal:=0.5+((dec*180/pi)+90)* 5 {2013 was * 2};
    ucaczon[1]:=round(zonreal);
  end;


  if ucaczon[1]>880 then
    begin
     ucaczon[2]:=ucaczon[1]-6;{13 bands, go up so plotting is not stopped to early  >900}
     ucaczon[3]:=ucaczon[1]-5;
     ucaczon[4]:=ucaczon[1]-4;
     ucaczon[5]:=ucaczon[1]-3;
     ucaczon[6]:=ucaczon[1]-2;
     ucaczon[7]:=ucaczon[1]-1;
     ucaczon[8]:=ucaczon[1]+1;
     ucaczon[9]:=ucaczon[1]+2;
     ucaczon[10]:=ucaczon[1]+3;
     ucaczon[11]:=ucaczon[1]+4;
     ucaczon[12]:=ucaczon[1]+5;
     ucaczon[13]:=ucaczon[1]+6;

   end
   else
   if ucaczon[1]<20 then
   begin
     ucaczon[2]:=ucaczon[1]+6;{13 bands, go down so plotting is not stopped to early  <0}
     ucaczon[3]:=ucaczon[1]+5;
     ucaczon[4]:=ucaczon[1]+4;
     ucaczon[5]:=ucaczon[1]+3;
     ucaczon[6]:=ucaczon[1]+2;
     ucaczon[7]:=ucaczon[1]+1;
     ucaczon[8]:=ucaczon[1]-1;
     ucaczon[9]:=ucaczon[1]-2;
     ucaczon[10]:=ucaczon[1]-3;
     ucaczon[11]:=ucaczon[1]-4;
     ucaczon[12]:=ucaczon[1]-5;
     ucaczon[13]:=ucaczon[1]-6;
   end
   else
   begin
     ucaczon[2]:=ucaczon[1]+1;{13 bands normal from  middle}
     ucaczon[3]:=ucaczon[1]-1;
     ucaczon[4]:=ucaczon[1]+2;
     ucaczon[5]:=ucaczon[1]-2;
     ucaczon[6]:=ucaczon[1]+3;
     ucaczon[7]:=ucaczon[1]-3;
     ucaczon[8]:=ucaczon[1]+4;
     ucaczon[9]:=ucaczon[1]-4;
     ucaczon[10]:=ucaczon[1]+5;
     ucaczon[11]:=ucaczon[1]-5;
     ucaczon[12]:=ucaczon[1]+6;
     ucaczon[13]:=ucaczon[1]-6;
   end;


  for i:=1 to 13 do
  begin
     if ((ucaczon[i]<1) or (ucaczon[i]>900)) then filename_UCAC[i]:=''
     else
     begin
       str( ucaczon[i]:3,zone);
       for j:=1 to 3 do if zone[j]=' ' then zone[j]:='0';
       filename_UCAC[i]:=cd_UCAC+'z'+zone;
     end;
  end;
   {if rastart<=rASTOP then plotting around RA=0, do 2x seek in read Routine !!!!}
   for i:=1 to 13 do
   begin
   if filename_UCAC[i]<>'' then
   begin

     {prepare rastart and rstop}
     dec2:=dec-(ucaczon[1]-ucaczon[i])*0.2 {2013}*pi/180;

     raband:=abs(  0.035/(COS(dec2+0.015)+0.00000001));

     rastart:=(ra-raband)*1440/(2*pi);
     rastop:= (ra+raband)*1440/(2*pi);

     if ucaczon[i]>890 then begin rastart:=0; rastop:=1439;end;
     if ucaczon[i]< 10  then begin rastart:=0; rastop:=1439;end;

     while rastart<0    do  rastart:=rastart+1439; {maximum range 0..1440,  equals range 0.. 2*pi }
     while rastop>1439   do  rastop:=rastop -1439;  {range 0..240}
     {end of prepare rastart and rstop}

     if ucaczon[i]>1 then starsdone[i]:=u4indexda[1,ucaczon[i],1] else starsdone[i]:=0;{else v230b}
     if ((ucaczon[i]<10 {was2}) or (ucaczon[i]>890  {was 359})) then
      begin seek_startposition[i]:=0;seek_stopposition[i]:=0;end {show celestial poles always complete}
     else                                                             {v223b start with 0 statt 1}
     begin
       seek_startposition[i]:=u4indexda[1,trunc(rastart),trunc(ucaczon[i])] + trunc(frac(rastart)*(u4indexda[1,trunc(rastart+1),trunc(ucaczon[i])] - u4indexda[1,trunc(rastart),trunc(ucaczon[i])])){frac} {- starsdone[i]}{start};
       seek_stopposition[i]:=u4indexda[1,trunc(rastop),trunc(ucaczon[i])]  +  trunc(frac(rastop)*(u4indexda[1,trunc(rastop+1),trunc(ucaczon[i])] - u4indexda[1,trunc(rastop),trunc(ucaczon[i])])){frac}   {- starsdone[i]}{start};
     end;
   end;
   end;
   band_nr:=1;
end;


procedure read_UCAC4(dc:tcanvas;epoch2:double;var ra,dec: double; var  mag_UCAC:integer {;star_nr1:string});{Read UCAC4 star database}
var
  tempstr1, tempstr2 :string[7];
begin
   {$I-}
   repeat
    if  ( (USNOfile_open=0) )  then    {file_open omdat anders fileroutine soms vastloopt}
    begin
      try
      TheFile_USNO :=tfilestream.Create( filename_UCAC[band_nr], fmOpenRead or fmShareDenyWrite);
      except
        canvas_error_message(filename_UCAC[band_nr]+'  '+not_found);{error message to canvas}
        USNOfile_open:=0;
        mag_UCAC:=10000;{stop further reading}
        exit;
      end;

      nr_records:= trunc(thefile_USNO.size/sizeof(UCAC4hdr));
      Reader_USNO := TReader.Create (TheFile_USNO , 12*1024);{number of UCAC records}
      {thefile3.size-reader.position>sizeof(hnskyhdr) could also be used but slow down a factor of 2 !!!}
      USNOfile_open:=2; {buffer size is .. x 1024}
      TheFile_USNO.seek(seek_startposition[band_nr] *sizeof(UCAC4hdr), 0);{jump to correct ra}
      nr_records:=nr_records- seek_startposition[band_nr];
      recordposition:= seek_startposition[band_nr]+1;{at position 0 is star 1 to read}
    end;
    reader_USNO.read(bufc4,sizeof(UCAC4hdr));
    with puc4^ do
       begin {correct star movement for new epoch. Coordinates are always in equinox 2000}

         DEC {(epoch T)} := (DECU + pmDE * (epoch2 - 2000.0)/10.0)*((pi/180)/(3600*1000))-pi/2;  {DEC first}
         RA  {(epoch T)} := (RAU  + pmRA * (epoch2 - 2000.0)/(10.0* cos(dec)) )*((pi/180)/(3600*1000));

          {note if pmDe and pmRA is 32767 the real PM of that star is larger and found in the extra table  file  u4hpm.dat (32 stars, ASCII).}

          {2015 practical magnitude selection}
  {1}    mag_Ucac:=u4Fmag;{accurate for faint stars}
  {2}    if APASS_V < mag_Ucac then mag_Ucac:=APASS_V; {mag=2000 if no magn given, use alternative, for bright stars APASS_V is much better}
  {3}    if U4Amag  < mag_Ucac then mag_Ucac:=U4Amag;  {some faint stars have no u4Fmag}
         mag_Ucac:=round(mag_Ucac/100); {size mili magn to 1/10 magnitude}

        //note 2  UCAC4 Systematic errors are expected to be below 0.1 mag for magm, maga photometric results obtained from the UCAC CCD pixel data.
        // The aperture photometry is considered more robust, particularly for "odd" cases, while the model fit magnitude is expected to be
        // more accurate for "well behaved" stars.


//          infotxt:=inttostr(round(U4Fmag/100))
//                   +' F'+inttostr(round(U4Fmag/100))
//                   +' A'+inttostr(round(U4Amag/100))
//                   +' V'+ inttostr(round(APASS_V/100))
//                   +'         J'+inttostr(round(mag_J/100))
//                   +' K'+inttostr(round(mag_K/100))
//                   +' H'+inttostr(round(mag_H/100))
//                   +' U4REag'+inttostr(round(U4REag/100));

          str(ucaczon[band_nr],tempstr1);
          str(1000000+recordposition:7,tempstr2);{add zeros by 1000000 and later remove 1, faster then formatfloat}

          naam2:=tempstr1+'-'+tempstr2[2]+tempstr2[3]+tempstr2[4]+tempstr2[5]+tempstr2[6]+tempstr2[7];


          mass_id_nr:=mass_id;{2mass id nr}
          UC4_source:=icf_info;{catalogue source label}

     // UCAC4	367-016700 , Sirus
     // if star_nr= 446136122 then
     //                                writeln;
     {simbad query:}
     {polaris, ICRS coord. (ep=J2010, eqJ2000) : 	02 31 49.09456 +89 15 50.7923 }
     {polaris, ICRS coord. (ep=J2016, eqJ2000) : 	02 31 52.78845 +89 15 50.6026 }
     {polaris, ICRS coord. (ep=J2100, eqJ2000) : 	02 32 12.17295 +89 15 49.6035 }
     {polaris, ICRS coord. (ep=J2250, eqJ2000) : 	02 32 46.75267 +89 15 47.8064 }

     {sirius, ICRS coord. (ep=J2000, eqJ2000) 06 45 08.91728 -16 42 58.0171 }
     {sirius, ICRS coord. (ep=J2016, eqJ2000) 06 45 08.30913 -16 43 17.5868 }
     {sirius, ICRS coord. (ep=J2100, eqJ2000) 06 45 05.11511 -16 45 00.3480 }
     {sirius, ICRS coord. (ep=J2250, eqJ2000) 06 44 59.40628 -16 48 03.9339 }

     {capella, ICRS coord. (ep=J2000, eqJ2000) 05 16 41.35871 +45 59 52.7693 }
     {capella, ICRS coord. (ep=J2016, eqJ2000) 05 16 41.47425 +45 59 45.9390 }
     {capella, ICRS coord. (ep=J2100, eqJ2000) 05 16 42.08070 +45 59 10.0801 }
     {capella, ICRS coord. (ep=J2250, eqJ2000) 05 16 43.16312 +45 58 06.0459 }

     {Star with high proper motion  USNOB 1577-0164870=Ross 452=UCAC4 789-022180  FK4 coord. (ep=B1950 eq=1950) : 	11 56 45.77 +68 04 14.1}


          UCAC_class:=U4doubleflag;
          UCAC_leda_diameter:=leda;{log10 object diameter in 0.1  arcmin}
          UCAC_X2M_diameter :=X2M; {X2M diameter 0.1  arcmin}

          apass_B_V:=apass_B -apass_V;{color}
          apass_error:= abs(apas_EB)+abs(apas_EV); {color error}

          if ((pmRA=32767) or (pmDE=32767)) then UCAC_poor_PM:=1 else UCAC_poor_PM:=0         //Note  (8):  A value of 32767 for either proper motion component means
                                                                                              //the real PM of that star is larger and found in the extra table file  u4hpm.dat (32 stars, ASCII
                                                                                              // example UCAC4 225005836, Kapteyns star
     end;
     inc(recordposition);
     nr_records:=nr_records-1; {faster then  (thefile3.size-thefile3.position<sizeof(hnskyhdr) !!!)}

     if (nr_records<=0)  then {start reading other side of RA=0}
     begin
       TheFile_USNO.seek(0, 0);{jump to correct ra}
       nr_records:= trunc(thefile_USNO.size/sizeof(UCAC4hdr));
       recordposition:=0;
     end;

   if seek_stopposition[band_nr]=recordposition then
   begin
     closeUSNO;
     inc(band_nr);
     if ((band_nr>13 {2013 was 5}) or (filename_UCAC[band_nr]='')) then
     begin
       mag_UCAC:=10000;
       band_nr:=1;
       exit;
     end;
   end;
  until (mag_UCAC<=maxmag);
end;


begin  {program}
  puc4:= @bufc4[1];	{ set UCAC pointer for read routine }
end.
