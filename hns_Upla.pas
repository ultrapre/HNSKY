UNIT hns_Upla;

{Software code is Copyright (C) 1998 by Springer-Nature, Berlin Heidelberg and originates the code described in the book Astronomy on the Personal Computer,
 ISBN 3-540-63521-1 3rd edition 1998. Authors Oliver Montenbruck and Thomas Pleger.
 Reproduced with written permission of SNCSC (Springer-Nature) dated 2019-3-27 under the conditions specified in the letter below.

Modified for the HNSKY planetarium program by Han Kleijn, www.hnsky.org email: han.k.. at...hnsky.org

This program is free software: you can redistribute it and/or modify

it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Springer Nature letter dated 2019-3-27:
*** Johannes Kleijn
*** Netherlands
*** 27/03/2019
*** Dear Mr Kleijn,
*** Re: Your permission request dated: 26 March 2019, your reference: Johannes Kleijn (“Licensee”), our reference: Springer Nature Customer Service Center GmbH (“SNCSC”)
***     acting as a commissionaire agent of Springer Nature Ltd (the PUBLISHER)
*** Request for permission to use: Software code from Astronomy on the Personal Computer, 978-3-540-63521-5, 3rd Edition, 1998 by Montenbruck, Oliver (“Licensed Material”)
*** to be published in the Astronomy Program HNSky http://www.hnsky.org/software.htm under a GPL3 License.
*** This permission covers:
*** •Non-exclusive
*** •Electronic rights only
*** •The English language
*** •Distribution in the following territory: Worldwide
*** •For the avoidance of doubt, derivative rights are excluded from this licence
*** •Copyright fee: gratis
*** This permission is subject to the following conditions:
*** 1. An acknowledgement is made as follows: 'AUTHOR, TITLE, published [YEAR] [publisher - as it appears on our copyright page] reproduced with permission of SNCSC'.
*** 2. This permission does not apply to quotations, figures or tables from other sources which may be part of the material to be used. If the book acknowledgements or credit
***    line on any part of the material you have requested indicates that it was reprinted or adapted by SNCSC with permission from another source, then you should also seek
***    permission from that source to reuse the material.
*** 3. This permission is only valid if no personal rights, trademarks, or competitive products are infringed.
*** 4. The Licensee may not make the Licensed Material available in a manner intended to allow or invite a third party to download, extract, redistribute, republish or access
***    the Licensed Material as a standalone file.
*** 5. This permission is personal to you and may not be sublicensed, assigned, or transferred by you without SNCSC’s written permission, unless specified and agreed with SNCSC.
*** 6. Delivery and use of the Licensed Material must be in a format that retains the integrity of the text. Figures, illustrations, and tables may be altered minimally to serve
***    your work. Any other abbreviations, additions, deletions and/or any other alterations shall be made only with prior written authorization of SNCSC.
*** 7. We do not routinely require a complimentary copy of your product on publication; however we reserve the right to receive a free copy on request at a later stage.
*** 8. We may terminate this licence with immediate effect on written notice to you for any reason. Upon termination of this licence for any reason, all rights in this licence
***    shall immediately revert to SNCSC.
*** 9. This licence shall be governed by, and shall be construed in accordance with, the laws of the Federal Republic of Germany.
*** Yours sincerely
*** Springer Nature Permissions Team
*** On behalf of SNCSC}



{---------------------------------------------------------------------}
{ heliocentric and geocentric planetary positions                     }
{ Based on programs from "astronomy on the personal computer"         }
{---------------------------------------------------------------------}

{calculates the position of all planets in radialen}
{important first calculate the sun position !!!}
Interface

uses  hns_uDE;{for array_5D}

function comet_velocity: string; {calculate velocity in arcsec/hour, only valid if called after procedure comet, by Han 2017-2-20}

PROCEDURE COMET_tail(length3:double;var RA_tail,DEC_tail:double); {2013, calculate tail end, increase  position with factor length3 from sun,, only valid if called after comet}

PROCEDURE PLANET(iplan,equinox:INTEGER;julian:double;var ra3,dec3,mag3,diameter3,delta,phase3,phi3:double);
{ iplan planet nr. Important first call should to sun=0 the define centre}
{ equinox 1950, 2000 or 0 to get actual positions}
{ ra3= ra in radialen
  dec3=dec in radialen,
  mag3=magnitude, in case moon % iluminated
  diameter3 =Diameter in arcsec
  delta0 distance from earth in au
  phase3 phase of moon or planet equals surface iluminated but also width illuminated versa width planet.
         See drawing new meeus page 315
  phi3 is angle earth-planet-sun }


procedure comet(sun:boolean;equinox:INTEGER;julian:double;year,month:integer;d,ecc,q,inc2,lan,aop,teqx0:double;
                var RA,DEC,DELTA,sun_delta:double);
{sun calculate sun or uses values from call to planet(0 ....)}
{equinox  on which basis e.g 2000}
{julian   julian date                                         }
{year, month, d, e,q,q,inc2,lan,aop,teqx0   comet parameters  }
{output:  ra,dec calculated coordinates   }
{         delta0 distance in au           }

function illum_comet : double ; { Get phase angle comet. Only valid is comet routine is called first.}

PROCEDURE ep(yearold,yearnew,raOLD,decold:double;var ranew,decnew:double);
{conversion from one equinox to an other}

procedure get_planet_equatorial_heliocentrisch(var xhp,yhp,zhp: double);

PROCEDURE NUTEQU(T:double;VAR X,Y,Z:double);{add nutation}
PROCEDURE ABERRAT(T: double; VAR VX,VY,VZ: double);{velocity vector of the Earth in equatorial coordinates, and units of the velocity of light}

var
   x_sun,y_sun,z_sun : double; {of earth}
   X_pln,Y_pln,Z_pln : double; {of planet}
   nutation_1        : array_5D; {from DE430}
   earth_helio       : array_5D; {from DE430}
const
   sun200_calculated : boolean=false; {sun200 calculated for comets}
   arcsec_hour_string:string='arcsec/hour';


//Following for use in hns_Unumint
type
  double33= array[1..3,1..3] of double;
FUNCTION CS(X:double):double;
FUNCTION SN(X:double):double;
FUNCTION ATN2(Y,X:double):double;
PROCEDURE GAUSVEC(LAN,INC,AOP:double;VAR PQR:double33);
FUNCTION ECCANOM(MAN,ECC:double):double;
PROCEDURE ELLIP(M,A,ECC:double;VAR X,Y,VX,VY:double);
PROCEDURE ORBECL(XX,YY:double;PQR:double33;VAR X,Y,Z:double);
PROCEDURE SUN200(T:double;VAR L,B,R:double);
PROCEDURE CART(R,THETA,PHI: double; VAR X,Y,Z: double);
PROCEDURE ECLEQU(T:double;VAR X,Y,Z:double);
FUNCTION MJD(DAY,MONTH,YEAR:INTEGER;HOUR:double):double;
PROCEDURE PMATECL(T1,T2:double;VAR A: double33);
PROCEDURE PRECART(A:double33;VAR X,Y,Z:double);


Implementation


USES hns_mercury,
     hns_venus,
     hns_mars,
     hns_jupiter,
     hns_saturn,
     hns_uranus,
     hns_neptune,
     hns_pluto,
     hns_main, hns_Uast, math,sysutils, hns_Uprs;


  CONST //J2000 =  0.0;
        B1950 = -0.500002108;

  const  jd_start: double=0;{valid range for DE430}
         jd_end  : double=0;


  VAR DAY : INTEGER;
      HOUR, T, TEQX,  XP_ecl_helio,YP_ecl_helio,ZP_ecl_helio, XS,YS,ZS,xe,ye,ze {earth},xeb,yeb,zeb {earth tov Bary centre},
                      xsb,ysb,zsb, {Sun t.o.v Bary centre} xa,ya,za {astroid}, sun_geodist, L,B,R,LS,BS,RS,
                      VX,VY,VZ {comet}     : double;
      planet_helio   : Array_5D;


(*---------------------------------------------------------------------------*)
(* ACS: Arcus-Cosinus-Funktion (Gradmass)                                    *)
(*---------------------------------------------------------------------------*)
FUNCTION ACS(X:double):double;
  CONST RAD=0.0174532925199433; EPS=1E-7; C=90.0;
  BEGIN
    IF ABS(X)=1.0
     THEN ACS:=C-X*C
     ELSE IF (ABS(X)>EPS) THEN ACS:=C-ARCTAN(X/SQRT((1.0-X)*(1.0+X)))/RAD
                           ELSE ACS:=C-X/RAD;
  END;

(*-----------------------------------------------------------------------*)
(* SN: sine function (degrees)                                           *)
(*-----------------------------------------------------------------------*)
FUNCTION SN(X:double):double;
  CONST RAD=0.0174532925199433;
  BEGIN
    SN:=SIN(X*RAD)
  END;
(*-----------------------------------------------------------------------*)
(* CS: cosine function (degrees)                                         *)
(*-----------------------------------------------------------------------*)
FUNCTION CS(X:double):double;
  CONST RAD=0.0174532925199433;
  BEGIN
    CS:=COS(X*RAD)
  END;
(*-----------------------------------------------------------------------*)
(* TN: tangent function (degrees)                                        *)
(*-----------------------------------------------------------------------*)
FUNCTION TN(X:double):double;
  CONST RAD=0.0174532925199433;
  VAR XX: double;
  BEGIN
    XX:=X*RAD; TN:=SIN(XX)/COS(XX);
  END;
(*-----------------------------------------------------------------------*)
(* ATN: arctangent function (degrees)                                    *)
(*-----------------------------------------------------------------------*)
FUNCTION ATN(X:double):double;
  CONST RAD=0.0174532925199433;
  BEGIN
    ATN:=ARCTAN(X)/RAD
  END;
(*-----------------------------------------------------------------------*)
(* ATN2: arctangent of y/x for two arguments                             *)
(*       (correct quadrant; -180 deg <= ATN2 <= +180 deg)                *)
(*-----------------------------------------------------------------------*)
FUNCTION ATN2(Y,X:double):double;
  CONST RAD=0.0174532925199433;
  VAR   AX,AY,PHI: double;
  BEGIN
    IF (X=0.0) AND (Y=0.0)
      THEN ATN2:=0.0
      ELSE
        BEGIN
          AX:=ABS(X); AY:=ABS(Y);
          IF (AX>AY)
            THEN PHI:=ARCTAN(AY/AX)/RAD
            ELSE PHI:=90.0-ARCTAN(AX/AY)/RAD;
          IF (X<0.0) THEN PHI:=180.0-PHI;
          IF (Y<0.0) THEN PHI:=-PHI;
          ATN2:=PHI;
        END;
  END;

(*-----------------------------------------------------------------------*)
(* POLAR2: conversion of cartesian coordinates (x,y,z)                    *)
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
(*-----------------------------------------------------------------------*)
(* MJD: Modified Julian Date                                             *)
(*      The routine is valid for any date since 4713 BC.                 *)
(*      Julian calendar is used up to 1582 October 4,                    *)
(*      Gregorian calendar is used from 1582 October 15 onwards.         *)
(*-----------------------------------------------------------------------*)
FUNCTION MJD(DAY,MONTH,YEAR:INTEGER;HOUR:double):double;
  VAR A: double; B: INTEGER;
  BEGIN
    A:=10000.0*YEAR+100.0*MONTH+DAY;
    IF (MONTH<=2) THEN BEGIN MONTH:=MONTH+12; YEAR:=YEAR-1 END;
    IF (A<=15821004.1)
      THEN B:=-2+TRUNC((YEAR+4716)/4)-1179
      ELSE B:=TRUNC(YEAR/400)-TRUNC(YEAR/100)+TRUNC(YEAR/4);
    A:=365.0*YEAR-679004.0;
    MJD:=A+B+TRUNC(30.6001*(MONTH+1))+DAY+HOUR/24.0;
  END;
(*-----------------------------------------------------------------------*)
(* ECLEQU: Conversion of ecliptic into equatorial coordinates            *)
(*         (T: equinox in Julian centuries since J2000)                  *)
(*-----------------------------------------------------------------------*)
PROCEDURE ECLEQU(T:double;VAR X,Y,Z:double);
  VAR EPS,C,S,V: double;
  BEGIN
    EPS:=23.43929111-(46.8150+(0.00059-0.001813*T)*T)*T/3600.0;
    C:=CS(EPS);  S:=SN(EPS);
    V:=+C*Y-S*Z;  Z:=+S*Y+C*Z;  Y:=V;
  END;
(*-----------------------------------------------------------------------*)
(* PMATECL: calculates the precession matrix A[i,j] for                  *)
(*          transforming ecliptic coordinates from equinox T1 to T2      *)
(*          ( T=(JD-2451545.0)/36525 )                                   *)
(*-----------------------------------------------------------------------*)
PROCEDURE PMATECL(T1,T2:double;VAR A: double33);
  CONST SEC=3600.0;
  VAR DT,PPI,PI,PA: double;
      C1,S1,C2,S2,C3,S3: double;
  BEGIN
    DT:=T2-T1;
    PPI := 174.876383889 +( ((3289.4789+0.60622*T1)*T1) +
              ((-869.8089-0.50491*T1) + 0.03536*DT)*DT )/SEC;
    PI  := ( (47.0029-(0.06603-0.000598*T1)*T1)+
             ((-0.03302+0.000598*T1)+0.000060*DT)*DT )*DT/SEC;
    PA  := ( (5029.0966+(2.22226-0.000042*T1)*T1)+
             ((1.11113-0.000042*T1)-0.000006*DT)*DT )*DT/SEC;
    C1:=CS(PPI+PA);  C2:=CS(PI);  C3:=CS(PPI);
    S1:=SN(PPI+PA);  S2:=SN(PI);  S3:=SN(PPI);
    A[1,1]:=+C1*C3+S1*C2*S3; A[1,2]:=+C1*S3-S1*C2*C3; A[1,3]:=-S1*S2;
    A[2,1]:=+S1*C3-C1*C2*S3; A[2,2]:=+S1*S3+C1*C2*C3; A[2,3]:=+C1*S2;
    A[3,1]:=+S2*S3;          A[3,2]:=-S2*C3;          A[3,3]:=+C2;
  END;
(*---------------------------------------------------------------------------*)
(* PMATEQU: Berechnung der Praezessionsmatrix A[i,j] fuer                    *)
(*          aequatoriale Koordinaten vom Aequinoktium T1 nach T2             *)
(*          ( T=(JD-2451545.0)/36525 )                                       *)
(*---------------------------------------------------------------------------*)
PROCEDURE PMATEQU(T1,T2:double; var a:double33);
  CONST SEC=3600.0;
  VAR DT,ZETA,Z,THETA: double;
      C1,S1,C2,S2,C3,S3: double;
  BEGIN
   DT:=T2-T1;
    ZETA  :=  ( (2306.2181+(1.39656-0.000139*T1)*T1)+
                ((0.30188-0.000345*T1)+0.017998*DT)*DT )*DT/SEC;
    Z     :=  ZETA + ( (0.79280+0.000411*T1)+0.000205*DT)*DT*DT/SEC;
    THETA :=  ( (2004.3109-(0.85330+0.000217*T1)*T1)-
                ((0.42665+0.000217*T1)+0.041833*DT)*DT )*DT/SEC;
    C1:=CS(Z);  C2:=CS(THETA);  C3:=CS(ZETA);
    S1:=SN(Z);  S2:=SN(THETA);  S3:=SN(ZETA);
    A[1,1]:=-S1*S3+C1*C2*C3; A[1,2]:=-S1*C3-C1*C2*S3; A[1,3]:=-C1*S2;
    A[2,1]:=+C1*S3+S1*C2*C3; A[2,2]:=+C1*C3-S1*C2*S3; A[2,3]:=-S1*S2;
    A[3,1]:=+S2*C3;          A[3,2]:=-S2*S3;          A[3,3]:=+C2;
  END;

(*-----------------------------------------------------------------------*)
(* PRECART: calculate change of coordinates due to precession            *)
(*          for given transformation matrix A[i,j]                       *)
(*          (to be used with PMATECL und PMATEQU)                        *)
(*-----------------------------------------------------------------------*)
PROCEDURE PRECART(A:double33;VAR X,Y,Z:double);
  VAR U,V,W: double;
  BEGIN
    U := A[1,1]*X+A[1,2]*Y+A[1,3]*Z;
    V := A[2,1]*X+A[2,2]*Y+A[2,3]*Z;
    W := A[3,1]*X+A[3,2]*Y+A[3,3]*Z;
    X:=U; Y:=V; Z:=W;
  END;
(*-----------------------------------------------------------------------*)
(* NUTEQU: transformation of mean to true coordinates                    *)
(*         (including terms >0.1" according to IAU 1980)                 *)
(*         T = (JD-2451545.0)/36525.0                                    *)
(*-----------------------------------------------------------------------*)
PROCEDURE NUTEQU(T:double;VAR X,Y,Z:double);
  CONST ARC=206264.8062;          (* arcseconds per radian = 3600*180/pi *)
        P2 =6.283185307;          (* 2*pi                                *)
  VAR   LS,D,F,N,EPS : double;
        DPSI,DEPS,C,S: double;
        DX,DY,DZ     : double;
  FUNCTION FRAC(X:double):double;
    (* with several compilers it may be necessary to replace TRUNC *)
    (* by LONG_TRUNC or INT if T<-24!                              *)
    BEGIN  FRAC:=X-TRUNC(X) END;
  BEGIN
    LS  := P2*FRAC(0.993133+  99.997306*T); (* mean anomaly Sun          *)
    D   := P2*FRAC(0.827362+1236.853087*T); (* diff. longitude Moon-Sun  *)
    F   := P2*FRAC(0.259089+1342.227826*T); (* mean argument of latitude *)
    N   := P2*FRAC(0.347346-   5.372447*T); (* longit. ascending node    *)
    EPS := 0.4090928-2.2696E-4*T;           (* obliquity of the ecliptic *)
    DPSI := ( -17.200*SIN(N)   - 1.319*SIN(2*(F-D+N)) - 0.227*SIN(2*(F+N))
              + 0.206*SIN(2*N) + 0.143*SIN(LS) ) / ARC;
    DEPS := ( + 9.203*COS(N)   + 0.574*COS(2*(F-D+N)) + 0.098*COS(2*(F+N))
              - 0.090*COS(2*N)                 ) / ARC;
    C := DPSI*COS(EPS);  S := DPSI*SIN(EPS);
    DX := -(C*Y+S*Z); DY := (C*X-DEPS*Z); DZ := (S*X+DEPS*Y);
    X  :=  X + DX;        Y  := Y + DY;       Z  := Z + DZ;
  END;

(*-----------------------------------------------------------------------*)
(* SUN200: ecliptic coordinates L,B,R (in deg and AU) of the             *)
(*         Sun referred to the mean equinox of date                      *)
(*         (T: time in Julian centuries since J2000)                     *)
(*         (   = (JED-2451545.0)/36525             )                     *)
(*-----------------------------------------------------------------------*)
PROCEDURE SUN200(T:double;VAR L,B,R:double);
  CONST P2=6.283185307;
  VAR C3,S3:          ARRAY [-1..7] OF double;
      C,S:            ARRAY [-8..0] OF double;
      M2,M3,M4,M5,M6: double;
      D,A,UU:         double;
      U,V,DL,DR,DB:   double;
      I:              INTEGER;

  FUNCTION FRAC(X:double):double;
    (* for some compilers TRUNC has to be replaced by LONG_TRUNC *)
    (* or INT (Turbo-Pascal) if the routine is used with T<-24   *)
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1.0; FRAC:=X  END;

  PROCEDURE ADDTHE(C1,S1,C2,S2:double; VAR C,S:double);
    BEGIN  C:=C1*C2-S1*S2; S:=S1*C2+C1*S2; END;

  PROCEDURE TERM(I1,I,IT:INTEGER;DLC,DLS,DRC,DRS,DBC,DBS:double);
    BEGIN
      IF IT=0 THEN ADDTHE(C3[I1],S3[I1],C[I],S[I],U,V)
              ELSE BEGIN U:=U*T; V:=V*T END;
      DL:=DL+DLC*U+DLS*V; DR:=DR+DRC*U+DRS*V; DB:=DB+DBC*U+DBS*V;
    END;


  PROCEDURE PERTVEN;  (* Keplerian terms and perturbations by Venus *)
    VAR I: INTEGER;
    BEGIN
      C[0]:=1.0; S[0]:=0.0; C[-1]:=COS(M2); S[-1]:=-SIN(M2);
      FOR I:=-1 DOWNTO -5 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(1, 0,0,-0.22,6892.76,-16707.37, -0.54, 0.00, 0.00);
      TERM(1, 0,1,-0.06, -17.35,    42.04, -0.15, 0.00, 0.00);
      TERM(1, 0,2,-0.01,  -0.05,     0.13, -0.02, 0.00, 0.00);
      TERM(2, 0,0, 0.00,  71.98,  -139.57,  0.00, 0.00, 0.00);
      TERM(2, 0,1, 0.00,  -0.36,     0.70,  0.00, 0.00, 0.00);
      TERM(3, 0,0, 0.00,   1.04,    -1.75,  0.00, 0.00, 0.00);
      TERM(0,-1,0, 0.03,  -0.07,    -0.16, -0.07, 0.02,-0.02);
      TERM(1,-1,0, 2.35,  -4.23,    -4.75, -2.64, 0.00, 0.00);
      TERM(1,-2,0,-0.10,   0.06,     0.12,  0.20, 0.02, 0.00);
      TERM(2,-1,0,-0.06,  -0.03,     0.20, -0.01, 0.01,-0.09);
      TERM(2,-2,0,-4.70,   2.90,     8.28, 13.42, 0.01,-0.01);
      TERM(3,-2,0, 1.80,  -1.74,    -1.44, -1.57, 0.04,-0.06);
      TERM(3,-3,0,-0.67,   0.03,     0.11,  2.43, 0.01, 0.00);
      TERM(4,-2,0, 0.03,  -0.03,     0.10,  0.09, 0.01,-0.01);
      TERM(4,-3,0, 1.51,  -0.40,    -0.88, -3.36, 0.18,-0.10);
      TERM(4,-4,0,-0.19,  -0.09,    -0.38,  0.77, 0.00, 0.00);
      TERM(5,-3,0, 0.76,  -0.68,     0.30,  0.37, 0.01, 0.00);
      TERM(5,-4,0,-0.14,  -0.04,    -0.11,  0.43,-0.03, 0.00);
      TERM(5,-5,0,-0.05,  -0.07,    -0.31,  0.21, 0.00, 0.00);
      TERM(6,-4,0, 0.15,  -0.04,    -0.06, -0.21, 0.01, 0.00);
      TERM(6,-5,0,-0.03,  -0.03,    -0.09,  0.09,-0.01, 0.00);
      TERM(6,-6,0, 0.00,  -0.04,    -0.18,  0.02, 0.00, 0.00);
      TERM(7,-5,0,-0.12,  -0.03,    -0.08,  0.31,-0.02,-0.01);
    END;

  PROCEDURE PERTMAR;  (* perturbations by Mars *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M4); S[-1]:=-SIN(M4);
      FOR I:=-1 DOWNTO -7 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(1,-1,0,-0.22,   0.17,    -0.21, -0.27, 0.00, 0.00);
      TERM(1,-2,0,-1.66,   0.62,     0.16,  0.28, 0.00, 0.00);
      TERM(2,-2,0, 1.96,   0.57,    -1.32,  4.55, 0.00, 0.01);
      TERM(2,-3,0, 0.40,   0.15,    -0.17,  0.46, 0.00, 0.00);
      TERM(2,-4,0, 0.53,   0.26,     0.09, -0.22, 0.00, 0.00);
      TERM(3,-3,0, 0.05,   0.12,    -0.35,  0.15, 0.00, 0.00);
      TERM(3,-4,0,-0.13,  -0.48,     1.06, -0.29, 0.01, 0.00);
      TERM(3,-5,0,-0.04,  -0.20,     0.20, -0.04, 0.00, 0.00);
      TERM(4,-4,0, 0.00,  -0.03,     0.10,  0.04, 0.00, 0.00);
      TERM(4,-5,0, 0.05,  -0.07,     0.20,  0.14, 0.00, 0.00);
      TERM(4,-6,0,-0.10,   0.11,    -0.23, -0.22, 0.00, 0.00);
      TERM(5,-7,0,-0.05,   0.00,     0.01, -0.14, 0.00, 0.00);
      TERM(5,-8,0, 0.05,   0.01,    -0.02,  0.10, 0.00, 0.00);
    END;

  PROCEDURE PERTJUP;  (* perturbations by Jupiter *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M5); S[-1]:=-SIN(M5);
      FOR I:=-1 DOWNTO -3 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(-1,-1,0,0.01,   0.07,     0.18, -0.02, 0.00,-0.02);
      TERM(0,-1,0,-0.31,   2.58,     0.52,  0.34, 0.02, 0.00);
      TERM(1,-1,0,-7.21,  -0.06,     0.13,-16.27, 0.00,-0.02);
      TERM(1,-2,0,-0.54,  -1.52,     3.09, -1.12, 0.01,-0.17);
      TERM(1,-3,0,-0.03,  -0.21,     0.38, -0.06, 0.00,-0.02);
      TERM(2,-1,0,-0.16,   0.05,    -0.18, -0.31, 0.01, 0.00);
      TERM(2,-2,0, 0.14,  -2.73,     9.23,  0.48, 0.00, 0.00);
      TERM(2,-3,0, 0.07,  -0.55,     1.83,  0.25, 0.01, 0.00);
      TERM(2,-4,0, 0.02,  -0.08,     0.25,  0.06, 0.00, 0.00);
      TERM(3,-2,0, 0.01,  -0.07,     0.16,  0.04, 0.00, 0.00);
      TERM(3,-3,0,-0.16,  -0.03,     0.08, -0.64, 0.00, 0.00);
      TERM(3,-4,0,-0.04,  -0.01,     0.03, -0.17, 0.00, 0.00);
    END;

  PROCEDURE PERTSAT;  (* perturbations by Saturn *)
    BEGIN
      C[-1]:=COS(M6); S[-1]:=-SIN(M6);
      ADDTHE(C[-1],S[-1],C[-1],S[-1],C[-2],S[-2]);
      TERM(0,-1,0, 0.00,   0.32,     0.01,  0.00, 0.00, 0.00);
      TERM(1,-1,0,-0.08,  -0.41,     0.97, -0.18, 0.00,-0.01);
      TERM(1,-2,0, 0.04,   0.10,    -0.23,  0.10, 0.00, 0.00);
      TERM(2,-2,0, 0.04,   0.10,    -0.35,  0.13, 0.00, 0.00);
    END;

  PROCEDURE PERTMOO;  (* difference between the Earth-Moon      *)
    BEGIN             (* barycenter and the center of the Earth *)
      DL := DL +  6.45*SIN(D) - 0.42*SIN(D-A) + 0.18*SIN(D+A)
                              + 0.17*SIN(D-M3) - 0.06*SIN(D+M3);
      DR := DR + 30.76*COS(D) - 3.06*COS(D-A)+ 0.85*COS(D+A)
                              - 0.58*COS(D+M3) + 0.57*COS(D-M3);
      DB := DB + 0.576*SIN(UU);
    END;

  BEGIN  (* SUN200 *)

    DL:=0.0; DR:=0.0; DB:=0.0;
    M2:=P2*FRAC(0.1387306+162.5485917*T);
    M3:=P2*FRAC(0.9931266+99.9973604*T);
    M4:=P2*FRAC(0.0543250+ 53.1666028*T);
    M5:=P2*FRAC(0.0551750+ 8.4293972*T);
    M6:=P2*FRAC(0.8816500+  3.3938722*T); D :=P2*FRAC(0.8274+1236.8531*T);
    A :=P2*FRAC(0.3749+1325.5524*T);      UU:=P2*FRAC(0.2591+1342.2278*T);
    C3[0]:=1.0;     S3[0]:=0.0;
    C3[1]:=COS(M3); S3[1]:=SIN(M3);  C3[-1]:=C3[1]; S3[-1]:=-S3[1];
    FOR I:=2 TO 7 DO ADDTHE(C3[I-1],S3[I-1],C3[1],S3[1],C3[I],S3[I]);
    PERTVEN; PERTMAR; PERTJUP; PERTSAT; PERTMOO;
    DL:=DL + 6.40*SIN(P2*(0.6983+0.0561*T))+1.87*SIN(P2*(0.5764+0.4174*T))
           + 0.27*SIN(P2*(0.4189+0.3306*T))+0.20*SIN(P2*(0.3581+2.4814*T));
    L:= 360.0*FRAC(0.7859453 + M3/P2 + ((6191.2+1.1*T)*T+DL)/1296.0E3 );
    R:= 1.0001398 - 0.0000007*T  +  DR*1E-6;
    B:= DB/3600.0;

  END;   (* SUN200 *)


(*-----------------------------------------------------------------------*)
(* PRINTOUT: print coordinates of one planet                             *)
(*-----------------------------------------------------------------------*)
{PROCEDURE PRINTOUT(IPLAN:INTEGER;L,B,R,RA,DEC,DELTA:double);
  VAR H,M: INTEGER;
      S  : double;
  BEGIN
    DMS(L,H,M,S);   WRITE (H:3,M:3,S:5:1);
    DMS(B,H,M,S);   WRITE (H:4,M:3,S:5:1);
    IF IPLAN<4 THEN WRITE (R:11:6)
               ELSE WRITE (R:10:5,' ');
    DMS(RA,H,M,S);  WRITE (H:4,M:3,S:6:2);
    DMS(DEC,H,M,S); WRITE (H:4,M:3,S:5:1);
    IF IPLAN<4 THEN WRITE (DELTA:11:6)
               ELSE WRITE (DELTA:10:5,' ');
  END;}

(*-----------------------------------------------------------------------*)
(* MOON: analytical lunar theory by E.W.Brown (Improved Lunar Ephemeris) *)
(*       with an accuracy of approx. 1"                                  *)
(*                                                                       *)
(*       T:      time in Julian centuries since J2000 (Ephemeris Time)   *)
(*               (T=(JD-2451545.0)/36525.0)                              *)
(*       LAMBDA: geocentric ecliptic longitude (equinox of date)         *)
(*       BETA:   geocentric ecliptic latitude  (equinox of date)         *)
(*       R:      geocentric distance (in Earth radii)                    *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)

PROCEDURE MOON ( T:double; VAR LAMBDA,BETA,R: double );

  CONST PI2 = 6.283185308;  (* 2*pi;  pi=3.141592654...        *)
        ARC = 206264.81;    (* 3600*180/pi = arcsec per radian *)

  VAR DGAM,FAC           : double;
      DLAM,N,GAM1C,SINPI : double;
      L0, L, LS, F, D ,S : double;
      DL0,DL,DLS,DF,DD,DS: double;
      CO,SI: ARRAY[-6..6,1..4] OF double;

  (* fractional part of a number; with several compilers it may be    *)
  (* necessary to replace TRUNC by LONG_TRUNC or INT if T<-24!        *)
  FUNCTION FRAC(X:double):double;
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1; FRAC:=X  END;

  (* calculate c=cos(a1+a2) and s=sin(a1+a2) from the addition theo-  *)
  (* rems for c1=cos(a1), s1=sin(a1), c2=cos(a2) and s2=sin(a2)       *)
  PROCEDURE ADDTHE(C1,S1,C2,S2:double;VAR C,S:double);
    BEGIN C:=C1*C2-S1*S2; S:=S1*C2+C1*S2; END;

  (* calculate sin(phi); phi in units of 1 revolution = 360 degrees   *)
  FUNCTION SINE (PHI:double):double;
    BEGIN  SINE:=SIN(PI2*FRAC(PHI));  END;

  (* calculate long-periodic changes of the mean elements             *)
  (* l,l',F,D and L0 as well as dgamma                                *)
  PROCEDURE LONG_PERIODIC ( T: double; VAR DL0,DL,DLS,DF,DD,DGAM: double );
    VAR S1,S2,S3,S4,S5,S6,S7: double;
    BEGIN
      S1:=SINE(0.19833+0.05611*T); S2:=SINE(0.27869+0.04508*T);
      S3:=SINE(0.16827-0.36903*T); S4:=SINE(0.34734-5.37261*T);
      S5:=SINE(0.10498-5.37899*T); S6:=SINE(0.42681-0.41855*T);
      S7:=SINE(0.14943-5.37511*T);
      DL0:= 0.84*S1+0.31*S2+14.27*S3+ 7.26*S4+ 0.28*S5+0.24*S6;
      DL := 2.94*S1+0.31*S2+14.27*S3+ 9.34*S4+ 1.12*S5+0.83*S6;
      DLS:=-6.40*S1                                   -1.89*S6;
      DF := 0.21*S1+0.31*S2+14.27*S3-88.70*S4-15.30*S5+0.24*S6-1.86*S7;
      DD := DL0-DLS;
      DGAM  := -3332E-9 * SINE(0.59734-5.37261*T)
                -539E-9 * SINE(0.35498-5.37899*T)
                 -64E-9 * SINE(0.39943-5.37511*T);
    END;


  (* INIT: calculates the mean elements and their sine and cosine   *)
  (* l mean anomaly of the Moon     l' mean anomaly of the Sun      *)
  (* F mean distance from the node  D  mean elongation from the Sun *)

  PROCEDURE INIT;
    VAR I,J,MAX   : INTEGER;
        T2,ARG,FAC: double;
    BEGIN
      T2:=T*T;
      DLAM :=0; DS:=0; GAM1C:=0; SINPI:=3422.7000;
      LONG_PERIODIC ( T, DL0,DL,DLS,DF,DD,DGAM );
      L0 := PI2*FRAC(0.60643382+1336.85522467*T-0.00000313*T2) + DL0/ARC;
      L  := PI2*FRAC(0.37489701+1325.55240982*T+0.00002565*T2) + DL /ARC;
      LS := PI2*FRAC(0.99312619+  99.99735956*T-0.00000044*T2) + DLS/ARC;
      F  := PI2*FRAC(0.25909118+1342.22782980*T-0.00000892*T2) + DF /ARC;
      D  := PI2*FRAC(0.82736186+1236.85308708*T-0.00000397*T2) + DD /ARC;
      FOR I := 1 TO 4 DO
        BEGIN
          CASE I OF
            1: BEGIN ARG:=L;  MAX:=4; FAC:=1.000002208;               END;
            2: BEGIN ARG:=LS; MAX:=3; FAC:=0.997504612-0.002495388*T; END;
            3: BEGIN ARG:=F;  MAX:=4; FAC:=1.000002708+139.978*DGAM;  END;
            4: BEGIN ARG:=D;  MAX:=6; FAC:=1.0;                       END;
          END;
          CO[0,I]:=1.0; CO[1,I]:=COS(ARG)*FAC;
          SI[0,I]:=0.0; SI[1,I]:=SIN(ARG)*FAC;
          FOR J := 2 TO MAX DO
            ADDTHE(CO[J-1,I],SI[J-1,I],CO[1,I],SI[1,I],CO[J,I],SI[J,I]);
          FOR J := 1 TO MAX DO
            BEGIN CO[-J,I]:=CO[J,I]; SI[-J,I]:=-SI[J,I]; END;
        END;
    END;


  (* TERM calculates X=cos(p*arg1+q*arg2+r*arg3+s*arg4) and   *)
  (*                 Y=sin(p*arg1+q*arg2+r*arg3+s*arg4)       *)
  PROCEDURE TERM(P,Q,R,S:INTEGER;VAR X,Y:double);
    VAR  I: ARRAY[1..4] OF INTEGER;  K: INTEGER;
    BEGIN
      I[1]:=P; I[2]:=Q; I[3]:=R; I[4]:=S;  X:=1.0; Y:=0.0;
      FOR K:=1 TO 4 DO
        IF (I[K]<>0) THEN  ADDTHE(X,Y,CO[I[K],K],SI[I[K],K],X,Y);
    END;

  PROCEDURE ADDSOL(COEFFL,COEFFS,COEFFG,COEFFP:double;P,Q,R,S:INTEGER);
    VAR X,Y: double;
    BEGIN
      TERM(P,Q,R,S,X,Y);
      DLAM :=DLAM +COEFFL*Y; DS   :=DS   +COEFFS*Y;
      GAM1C:=GAM1C+COEFFG*X; SINPI:=SINPI+COEFFP*X;
    END;


  PROCEDURE SOLAR1;
    BEGIN
      ADDSOL(   13.902,   14.06,-0.001,   0.2607,0, 0, 0, 4);
      ADDSOL(    0.403,   -4.01,+0.394,   0.0023,0, 0, 0, 3);
      ADDSOL( 2369.912, 2373.36,+0.601,  28.2333,0, 0, 0, 2);
      ADDSOL( -125.154, -112.79,-0.725,  -0.9781,0, 0, 0, 1);
      ADDSOL(    1.979,    6.98,-0.445,   0.0433,1, 0, 0, 4);
      ADDSOL(  191.953,  192.72,+0.029,   3.0861,1, 0, 0, 2);
      ADDSOL(   -8.466,  -13.51,+0.455,  -0.1093,1, 0, 0, 1);
      ADDSOL(22639.500,22609.07,+0.079, 186.5398,1, 0, 0, 0);
      ADDSOL(   18.609,    3.59,-0.094,   0.0118,1, 0, 0,-1);
      ADDSOL(-4586.465,-4578.13,-0.077,  34.3117,1, 0, 0,-2);
      ADDSOL(   +3.215,    5.44,+0.192,  -0.0386,1, 0, 0,-3);
      ADDSOL(  -38.428,  -38.64,+0.001,   0.6008,1, 0, 0,-4);
      ADDSOL(   -0.393,   -1.43,-0.092,   0.0086,1, 0, 0,-6);
      ADDSOL(   -0.289,   -1.59,+0.123,  -0.0053,0, 1, 0, 4);
      ADDSOL(  -24.420,  -25.10,+0.040,  -0.3000,0, 1, 0, 2);
      ADDSOL(   18.023,   17.93,+0.007,   0.1494,0, 1, 0, 1);
      ADDSOL( -668.146, -126.98,-1.302,  -0.3997,0, 1, 0, 0);
      ADDSOL(    0.560,    0.32,-0.001,  -0.0037,0, 1, 0,-1);
      ADDSOL( -165.145, -165.06,+0.054,   1.9178,0, 1, 0,-2);
      ADDSOL(   -1.877,   -6.46,-0.416,   0.0339,0, 1, 0,-4);
      ADDSOL(    0.213,    1.02,-0.074,   0.0054,2, 0, 0, 4);
      ADDSOL(   14.387,   14.78,-0.017,   0.2833,2, 0, 0, 2);
      ADDSOL(   -0.586,   -1.20,+0.054,  -0.0100,2, 0, 0, 1);
      ADDSOL(  769.016,  767.96,+0.107,  10.1657,2, 0, 0, 0);
      ADDSOL(   +1.750,    2.01,-0.018,   0.0155,2, 0, 0,-1);
      ADDSOL( -211.656, -152.53,+5.679,  -0.3039,2, 0, 0,-2);
      ADDSOL(   +1.225,    0.91,-0.030,  -0.0088,2, 0, 0,-3);
      ADDSOL(  -30.773,  -34.07,-0.308,   0.3722,2, 0, 0,-4);
      ADDSOL(   -0.570,   -1.40,-0.074,   0.0109,2, 0, 0,-6);
      ADDSOL(   -2.921,  -11.75,+0.787,  -0.0484,1, 1, 0, 2);
      ADDSOL(   +1.267,    1.52,-0.022,   0.0164,1, 1, 0, 1);
      ADDSOL( -109.673, -115.18,+0.461,  -0.9490,1, 1, 0, 0);
      ADDSOL( -205.962, -182.36,+2.056,  +1.4437,1, 1, 0,-2);
      ADDSOL(    0.233,    0.36, 0.012,  -0.0025,1, 1, 0,-3);
      ADDSOL(   -4.391,   -9.66,-0.471,   0.0673,1, 1, 0,-4);
    END;

  PROCEDURE SOLAR2;
    BEGIN
      ADDSOL(    0.283,    1.53,-0.111,  +0.0060,1,-1, 0,+4);
      ADDSOL(   14.577,   31.70,-1.540,  +0.2302,1,-1, 0, 2);
      ADDSOL(  147.687,  138.76,+0.679,  +1.1528,1,-1, 0, 0);
      ADDSOL(   -1.089,    0.55,+0.021,   0.0   ,1,-1, 0,-1);
      ADDSOL(   28.475,   23.59,-0.443,  -0.2257,1,-1, 0,-2);
      ADDSOL(   -0.276,   -0.38,-0.006,  -0.0036,1,-1, 0,-3);
      ADDSOL(    0.636,    2.27,+0.146,  -0.0102,1,-1, 0,-4);
      ADDSOL(   -0.189,   -1.68,+0.131,  -0.0028,0, 2, 0, 2);
      ADDSOL(   -7.486,   -0.66,-0.037,  -0.0086,0, 2, 0, 0);
      ADDSOL(   -8.096,  -16.35,-0.740,   0.0918,0, 2, 0,-2);
      ADDSOL(   -5.741,   -0.04, 0.0  ,  -0.0009,0, 0, 2, 2);
      ADDSOL(    0.255,    0.0 , 0.0  ,   0.0   ,0, 0, 2, 1);
      ADDSOL( -411.608,   -0.20, 0.0  ,  -0.0124,0, 0, 2, 0);
      ADDSOL(    0.584,    0.84, 0.0  ,  +0.0071,0, 0, 2,-1);
      ADDSOL(  -55.173,  -52.14, 0.0  ,  -0.1052,0, 0, 2,-2);
      ADDSOL(    0.254,    0.25, 0.0  ,  -0.0017,0, 0, 2,-3);
      ADDSOL(   +0.025,   -1.67, 0.0  ,  +0.0031,0, 0, 2,-4);
      ADDSOL(    1.060,    2.96,-0.166,   0.0243,3, 0, 0,+2);
      ADDSOL(   36.124,   50.64,-1.300,   0.6215,3, 0, 0, 0);
      ADDSOL(  -13.193,  -16.40,+0.258,  -0.1187,3, 0, 0,-2);
      ADDSOL(   -1.187,   -0.74,+0.042,   0.0074,3, 0, 0,-4);
      ADDSOL(   -0.293,   -0.31,-0.002,   0.0046,3, 0, 0,-6);
      ADDSOL(   -0.290,   -1.45,+0.116,  -0.0051,2, 1, 0, 2);
      ADDSOL(   -7.649,  -10.56,+0.259,  -0.1038,2, 1, 0, 0);
      ADDSOL(   -8.627,   -7.59,+0.078,  -0.0192,2, 1, 0,-2);
      ADDSOL(   -2.740,   -2.54,+0.022,   0.0324,2, 1, 0,-4);
      ADDSOL(    1.181,    3.32,-0.212,   0.0213,2,-1, 0,+2);
      ADDSOL(    9.703,   11.67,-0.151,   0.1268,2,-1, 0, 0);
      ADDSOL(   -0.352,   -0.37,+0.001,  -0.0028,2,-1, 0,-1);
      ADDSOL(   -2.494,   -1.17,-0.003,  -0.0017,2,-1, 0,-2);
      ADDSOL(    0.360,    0.20,-0.012,  -0.0043,2,-1, 0,-4);
      ADDSOL(   -1.167,   -1.25,+0.008,  -0.0106,1, 2, 0, 0);
      ADDSOL(   -7.412,   -6.12,+0.117,   0.0484,1, 2, 0,-2);
      ADDSOL(   -0.311,   -0.65,-0.032,   0.0044,1, 2, 0,-4);
      ADDSOL(   +0.757,    1.82,-0.105,   0.0112,1,-2, 0, 2);
      ADDSOL(   +2.580,    2.32,+0.027,   0.0196,1,-2, 0, 0);
      ADDSOL(   +2.533,    2.40,-0.014,  -0.0212,1,-2, 0,-2);
      ADDSOL(   -0.344,   -0.57,-0.025,  +0.0036,0, 3, 0,-2);
      ADDSOL(   -0.992,   -0.02, 0.0  ,   0.0   ,1, 0, 2, 2);
      ADDSOL(  -45.099,   -0.02, 0.0  ,  -0.0010,1, 0, 2, 0);
      ADDSOL(   -0.179,   -9.52, 0.0  ,  -0.0833,1, 0, 2,-2);
      ADDSOL(   -0.301,   -0.33, 0.0  ,   0.0014,1, 0, 2,-4);
      ADDSOL(   -6.382,   -3.37, 0.0  ,  -0.0481,1, 0,-2, 2);
      ADDSOL(   39.528,   85.13, 0.0  ,  -0.7136,1, 0,-2, 0);
      ADDSOL(    9.366,    0.71, 0.0  ,  -0.0112,1, 0,-2,-2);
      ADDSOL(    0.202,    0.02, 0.0  ,   0.0   ,1, 0,-2,-4);
    END;

  PROCEDURE SOLAR3;
    BEGIN
      ADDSOL(    0.415,    0.10, 0.0  ,  0.0013,0, 1, 2, 0);
      ADDSOL(   -2.152,   -2.26, 0.0  , -0.0066,0, 1, 2,-2);
      ADDSOL(   -1.440,   -1.30, 0.0  , +0.0014,0, 1,-2, 2);
      ADDSOL(    0.384,   -0.04, 0.0  ,  0.0   ,0, 1,-2,-2);
      ADDSOL(   +1.938,   +3.60,-0.145, +0.0401,4, 0, 0, 0);
      ADDSOL(   -0.952,   -1.58,+0.052, -0.0130,4, 0, 0,-2);
      ADDSOL(   -0.551,   -0.94,+0.032, -0.0097,3, 1, 0, 0);
      ADDSOL(   -0.482,   -0.57,+0.005, -0.0045,3, 1, 0,-2);
      ADDSOL(    0.681,    0.96,-0.026,  0.0115,3,-1, 0, 0);
      ADDSOL(   -0.297,   -0.27, 0.002, -0.0009,2, 2, 0,-2);
      ADDSOL(    0.254,   +0.21,-0.003,  0.0   ,2,-2, 0,-2);
      ADDSOL(   -0.250,   -0.22, 0.004,  0.0014,1, 3, 0,-2);
      ADDSOL(   -3.996,    0.0 , 0.0  , +0.0004,2, 0, 2, 0);
      ADDSOL(    0.557,   -0.75, 0.0  , -0.0090,2, 0, 2,-2);
      ADDSOL(   -0.459,   -0.38, 0.0  , -0.0053,2, 0,-2, 2);
      ADDSOL(   -1.298,    0.74, 0.0  , +0.0004,2, 0,-2, 0);
      ADDSOL(    0.538,    1.14, 0.0  , -0.0141,2, 0,-2,-2);
      ADDSOL(    0.263,    0.02, 0.0  ,  0.0   ,1, 1, 2, 0);
      ADDSOL(    0.426,   +0.07, 0.0  , -0.0006,1, 1,-2,-2);
      ADDSOL(   -0.304,   +0.03, 0.0  , +0.0003,1,-1, 2, 0);
      ADDSOL(   -0.372,   -0.19, 0.0  , -0.0027,1,-1,-2, 2);
      ADDSOL(   +0.418,    0.0 , 0.0  ,  0.0   ,0, 0, 4, 0);
      ADDSOL(   -0.330,   -0.04, 0.0  ,  0.0   ,3, 0, 2, 0);
    END;

  (* part N of the perturbations of ecliptic latitude                 *)
  PROCEDURE SOLARN(VAR N: double);
    VAR X,Y: double;
    PROCEDURE ADDN(COEFFN:double;P,Q,R,S:INTEGER);
      BEGIN TERM(P,Q,R,S,X,Y); N:=N+COEFFN*Y END;
    BEGIN
      N := 0.0;
      ADDN(-526.069, 0, 0,1,-2); ADDN(  -3.352, 0, 0,1,-4);
      ADDN( +44.297,+1, 0,1,-2); ADDN(  -6.000,+1, 0,1,-4);
      ADDN( +20.599,-1, 0,1, 0); ADDN( -30.598,-1, 0,1,-2);
      ADDN( -24.649,-2, 0,1, 0); ADDN(  -2.000,-2, 0,1,-2);
      ADDN( -22.571, 0,+1,1,-2); ADDN( +10.985, 0,-1,1,-2);
    END;

  (* perturbations of ecliptic latitude by Venus and Jupiter          *)
  PROCEDURE PLANETARY(VAR DLAM:double);
    BEGIN
      DLAM  := DLAM
        +0.82*SINE(0.7736  -62.5512*T)+0.31*SINE(0.0466 -125.1025*T)
        +0.35*SINE(0.5785  -25.1042*T)+0.66*SINE(0.4591+1335.8075*T)
        +0.64*SINE(0.3130  -91.5680*T)+1.14*SINE(0.1480+1331.2898*T)
        +0.21*SINE(0.5918+1056.5859*T)+0.44*SINE(0.5784+1322.8595*T)
        +0.24*SINE(0.2275   -5.7374*T)+0.28*SINE(0.2965   +2.6929*T)
        +0.33*SINE(0.3132   +6.3368*T);
    END;

  BEGIN

    INIT;  SOLAR1; SOLAR2; SOLAR3; SOLARN(N);  PLANETARY(DLAM);

    LAMBDA := 360.0*FRAC( (L0+DLAM/ARC) / PI2 );

    S    := F + DS/ARC;
    FAC  := 1.000002708+139.978*DGAM;
    BETA := (FAC*(18518.511+1.189+GAM1C)*SIN(S)-6.24*SIN(3*S)+N) / 3600.0;

    SINPI := SINPI * 0.999953253;
    R     := ARC / SINPI;

  END;

(*-----------------------------------------------------------------------*)
(* CART: conversion of polar coordinates (r,theta,phi)                   *)
(*       into cartesian coordinates (x,y,z)                              *)
(*       (theta in [-90 deg,+90 deg]; phi in [-360 deg,+360 deg])        *)
(*-----------------------------------------------------------------------*)
PROCEDURE CART(R,THETA,PHI: double; VAR X,Y,Z: double);
  VAR RCST : double;
  BEGIN
    RCST := R*CS(THETA);
    X    := RCST*CS(PHI); Y := RCST*SN(PHI); Z := R*SN(THETA)
  END;

(*-----------------------------------------------------------------------*)
(*-----------------------------------------------------------------------*)
(*                                                                       *)
(* ILLUM: Computes the illumination parameters of a planet               *)
(*                                                                       *)
(*   X,Y,Z      Heliocentric coordinates of the planet                   *)
(*   XE,YE,ZE   Heliocentric coordinates of the Earth                    *)
(*   R          Heliocentric distance of the planet                      *)
(*   D          Geocentric distance of the planet                        *)
(*   ELONG      Elongation (deg)                                         *)
(*   PHI        Phase angle (deg)                                        *)
(*   K          Phase                                                    *)
(*                                                                       *)
(* Note: All coordinates must refer to the same coordinate system.       *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)

PROCEDURE ILLUM2( X,Y,Z, XE,YE,ZE: double; VAR R_SP,R_EP,ELONG,PHI,phase: double);

  VAR   XP,YP,ZP, RE, C_PHI : double;

  BEGIN
    (* Compute the planet's geocentric position *)

    XP:=X-XE; YP:=Y-YE; ZP:=Z-ZE;

//    if xe=0 then
//      xe:=1;

    (* Compute the distances in the Sun-Earth-planet triangle *)

    R_SP:= SQRT (  X*X  +  Y*Y  +  Z*Z  ); (* Entfernung Sonne-Planet *)
    RE  := SQRT ( XE*XE + YE*YE + ZE*ZE );   (* Entfernung Sonne-Erde   *)
    R_EP:= SQRT ( XP*XP + YP*YP + ZP*ZP );   (* Entfernung Erde-Planet  *)

    (* Berechnung von Elongation, Phasenwinkel und Phase *)

    ELONG := ACS ( ( R_EP*R_EP + RE*RE - R_SP*R_SP ) / ( 2.0*R_EP*RE ) );

    C_PHI := ( R_EP*R_EP + R_SP*R_SP - RE*RE ) / ( 2.0*R_EP*R_SP ) ;
    PHI   := ACS ( C_PHI );   {phasewinkel}
    phase := 100*0.5*(1.0+C_PHI); {0..100}
  END;



(*---------------------------------------------------------------------------*)
(*                                                                           *)
(* BRIGHT: Berechnet die scheinbare Helligkeit eines Planeten (in mag)       *)
(*                                                                           *)
(*  PLANET     Name des Planeten                                             *)
(*  Rrr        Heliozentrische Entfernung des Planeten (AE)                  *)
(*  DELTA      Entfernung des Planeten vom Beobachter (AE)                   *)
(*  PHI        Phasenwinkel (Grad)                                           *)
(*  DEC        Planetozentrische Breite des Beobachters (Grad)  {erde}       *)
(*  DLONG      Differenz der planetozentrischen Laengen von Sonne und        *)
(*             Beobachter (Grad)                                             *)
(*                                                                           *)
(* Helligkeiten V(1,0) nach Astronomical Almanac 1984. DEC und DLONG werden  *)
(* nur bei der Berechnung der scheinbaren Helligkeit des Saturn benoetigt,   *)
(* die von der Ringoeffnung abhaengt.                                        *)
(*                                                                           *)
(*---------------------------------------------------------------------------*)
FUNCTION BRIGHT ( PLANET: integer; rrR,DELTA,PHI {,DEC,DLONG}: double ): double;

  CONST LN10 = 2.302585093;    (* Natuerlicher Logarithmus von 10 *)

  VAR   P {,SD,DL},MAG :  double;
            {dec,dlong :double;}
  BEGIN
    P := PHI/100.0;

    CASE PLANET OF
      1 {mercury} : MAG := -0.42 + ( 3.80 - ( 2.73 - 2.00*P ) * P ) * P;
      2 {venus}   : MAG := -4.40 + ( 0.09 + ( 2.39 - 0.65*P ) * P ) * P;
      3 {eaRTH}   : MAG := -3.86;
      4 {MARS }   : MAG := -1.52 + 1.6 * P;
      5 {JUPITER} : MAG := -9.40 + 0.5 * P;
      6 {SATURN}  : BEGIN
{                  SD := ABS ( SN(DEC) );
                   DL := ABS ( DLONG/100.0 ); IF DL>1.8 THEN DL:=ABS(DL-3.6);
                   MAG := -8.88 - 2.60 * SD + 1.25 * SD*SD + 4.40 * DL;}
                  mag:=-9.3;
                  { note correction magnitude for ring is done in hnsky !!}
                END;
      7 {URANUS}  : MAG := -7.19;
      8 {NEPTUNE} : MAG := -6.87;
      9 {PLUTO}   : MAG := -1.0;
     10 {MOON}    : MAG := 0.0 + ( 3.80 - ( 2.73 - 2.00*P ) * P ) * P;   {BY hAN EQUAL TO MERCURY }
    END;                                                   {VERY CLOSE TO CALCULATIONS FROM EXPOSURE TABLES}

    BRIGHT := MAG + 5.0 * LN ( rrR*DELTA ) / LN10;

  END;
(*-----------------------------------------------------------------------*)
(*                                                                       *)
(* GEOCEN: geocentric coordinates (geometric and light-time corrected)   *)
(*                                                                       *)
(*   T:        time in Julian centuries since J2000                      *)
(*             T=(JD-2451545.0)/36525.0                                  *)
(*   LP,BP,RP: ecliptic heliocentric coordinates of the planet           *)
(*   LS,BS,RS: ecliptic geocentric   coordinates of the sun              *)
(*                                                                       *)
(*   IPLAN:    planet (0=Sun,1=Mercury,2=Venus,3=Earth,...,9=Pluto       *)
(*   IMODE:    desired type of coordinates (see description of X,Y,Z)    *)
(*             (0=geometric,1=astrometric,2=apparent)                    *)
(*   XP,YP,ZP: ecliptic heliocentric coordinates of the planet           *)
(*   XS,YS,ZS: ecliptic geocentric coordinates of the Sun                *)
(*   X, Y, Z : ecliptic geocentric cordinates of the planet (geometric   *)
(*             if IMODE=0, astrometric if IMODE=1, apparent if IMODE=2)  *)
(*   DELTA0:   geocentric distance (geometric)                           *)
(*                                                                       *)
(*   (all angles in degrees, distances in AU)                            *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)

PROCEDURE GEOCEN(T, LP,BP,RP, LS,BS,RS: double; IPLAN,IMODE: INTEGER;
                 VAR XP,YP,ZP, XS,YS,ZS, X,Y,Z,DELTA0: double);

  CONST P2=6.283185307;

  VAR DL,DB,DR, DLS,DBS,DRS, FAC: double;
      VX,VY,VZ, VXS,VYS,VZS, M  : double;

  FUNCTION FRAC(X:double):double;
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1; FRAC:=X  END;

  PROCEDURE POSVEL(L,B,R,DL,DB,DR: double; VAR X,Y,Z,VX,VY,VZ:double);
    VAR  CL,SL,CB,SB: double;
    BEGIN
      CL:=CS(L); SL:=SN(L); CB:=CS(B); SB:=SN(B);
      X := R*CL*CB;  VX := DR*CL*CB-DL*R*SL*CB-DB*R*CL*SB;
      Y := R*SL*CB;  VY := DR*SL*CB+DL*R*CL*CB-DB*R*SL*SB;
      Z := R*SB;     VZ := DR*SB              +DB*R*CB;
    END;

  BEGIN

    DL:=0.0; DB:=0.0; DR:=0.0; DLS:=0.0; DBS:=0.0; DRS:=0.0;

    IF (IMODE>0) THEN

      BEGIN

        M := P2*FRAC(0.9931266+ 99.9973604*T);              (* Sun     *)
        DLS := 172.00+5.75*SIN(M);  DRS := 2.87*COS(M); DBS := 0.0;

        (* dl,db in 1e-4 rad/d, dr in 1e-4 AU/d *)
        CASE IPLAN OF
          0: BEGIN  DL:=0.0; DB:=0.0; DR:=0.0;  END;        (* Sun     *)
          1: BEGIN                                          (* Mercury *)
               M := P2*FRAC(0.4855407+415.2014314*T);
               DL := 714.00+292.66*COS(M)+71.96*COS(2*M)+18.16*COS(3*M)
                     +4.61*COS(4*M)+3.81*SIN(2*M)+2.43*SIN(3*M)
                     +1.08*SIN(4*M);
               DR := 55.94*SIN(M)+11.36*SIN(2*M)+2.60*SIN(3*M);
               DB := 73.40*COS(M)+29.82*COS(2*M)+10.22*COS(3*M)
                     +3.28*COS(4*M)-40.44*SIN(M)-16.55*SIN(2*M)
                     -5.56*SIN(3*M)-1.72*SIN(4*M);
             END;
          2: BEGIN                                          (* Venus   *)
               M := P2*FRAC(0.1400197+162.5494552*T);
               DL := 280.00+3.79*COS(M);   DR := 1.37*SIN(M);
               DB := 9.54*COS(M)-13.57*SIN(M);
             END;
          3: BEGIN  DL:=DLS; DR:=DRS; DB:=-DBS;  END;       (* Earth   *)
          4: BEGIN                                          (* Mars    *)
               M := P2*FRAC(0.0538553+53.1662736*T);
               DL := 91.50+17.07*COS(M)+2.03*COS(2*M);
               DR := 12.98*SIN(M)+1.21*COS(2*M);
               DB :=  0.83*COS(M)+2.80*SIN(M);
             END;
          5: BEGIN                                          (* Jupiter *)
               M := P2*FRAC(0.0565314+8.4302963*T);
               DL := 14.50+1.41*COS(M); DR:=3.66*SIN(M); DB:=0.33*SIN(M);
             END;
          6: BEGIN                                          (* Saturn  *)
               M := P2*FRAC(0.8829867+3.3947688*T);
               DL := 5.84+0.65*COS(M); DR:=3.09*SIN(M); DB:=0.24*COS(M);
             END;
          7: BEGIN                                          (* Uranus  *)
               M := P2*FRAC(0.3967117+1.1902849*T);
               DL := 2.05+0.19*COS(M); DR:=1.86*SIN(M); DB:=-0.03*SIN(M);
             END;
          8: BEGIN                                          (* Neptune *)
               M := P2*FRAC(0.7214906+0.6068526*T);
               DL := 1.04+0.02*COS(M); DR:=0.27*SIN(M); DB:=0.03*SIN(M);
             END;
          9: BEGIN                                          (* Pluto   *)
               M := P2*FRAC(0.0385795+0.4026667*T);
               DL := 0.69+0.34*COS(M)+0.12*COS(2*M)+0.05*COS(3*M);
               DR := 6.66*SIN(M)+1.64*SIN(2*M);
               DB := -0.08*COS(M)-0.17*SIN(M)-0.09*SIN(2*M);
             END;
        END;

      END;

    POSVEL (LS,BS,RS,DLS,DBS,DRS,XS,YS,ZS,VXS,VYS,VZS);
    POSVEL (LP,BP,RP,DL ,DB ,DR, XP,YP,ZP,VX ,VY ,VZ );
    X:=XP+XS;  Y:=YP+YS;  Z:=ZP+ZS;   DELTA0 := SQRT(X*X+Y*Y+Z*Z);
    IF IPLAN=3 THEN BEGIN X:=0.0; Y:=0.0; Z:=0.0; DELTA0:=0.0 END;

    FAC := 0.00578 * DELTA0 * 1E-4;
    CASE IMODE OF
      1: BEGIN X:=X-FAC*VX;  Y:=Y-FAC*VY;  Z:=Z-FAC*VZ; END;
      2: BEGIN X:=X-FAC*(VX+VXS); Y:=Y-FAC*(VY+VYS); Z:=Z-FAC*(VZ+VZS);END;
     END;

  END;

(*-----------------------------------------------------------------------*)
(* GAUSVEC: calculation of the Gaussian vectors (P,Q,R) from             *)
(*          ecliptic orbital elements:                                   *)
(*          LAN = longitude of the ascending node                        *)
(*          INC = inclination                                            *)
(*          AOP = argument of perihelion                                 *)
(*-----------------------------------------------------------------------*)
PROCEDURE GAUSVEC(LAN,INC,AOP:double;VAR PQR:double33);
  VAR C1,S1,C2,S2,C3,S3: double;
  BEGIN
    C1:=CS(AOP);  C2:=CS(INC);  C3:=CS(LAN);
    S1:=SN(AOP);  S2:=SN(INC);  S3:=SN(LAN);
    PQR[1,1]:=+C1*C3-S1*C2*S3; PQR[1,2]:=-S1*C3-C1*C2*S3; PQR[1,3]:=+S2*S3;
    PQR[2,1]:=+C1*S3+S1*C2*C3; PQR[2,2]:=-S1*S3+C1*C2*C3; PQR[2,3]:=-S2*C3;
    PQR[3,1]:=+S1*S2;          PQR[3,2]:=+C1*S2;          PQR[3,3]:=+C2;
  END;

(*---------------------------------------------------------------------------*)
{PROCEDURE AUSGABE(IPLAN:INTEGER;L,B,R,RA,DEC,DELTA:double);
  VAR H,M: INTEGER;
      S  : double;
  BEGIN
{    DMS(L,H,M,S);   WRITE (H:3,M:3,S:5:1);
    DMS(B,H,M,S);   WRITE (H:4,M:3,S:5:1);
    IF IPLAN<4 THEN WRITE (R:11:6)
               ELSE WRITE (R:10:5,' ');}
 {              write(iplan:3,'===');
    DMS(RA,H,M,S);  WRITE (H:4,M:3,S:6:2);
    DMS(DEC,H,M,S); WRITE (H:4,M:3,S:5:1);
{    IF IPLAN<4 THEN WRITE (DELTA:11:6)
               ELSE WRITE (DELTA:10:5,' ');}

  {  IF IPLAN<>10 THEN write(mag3:2:1,' ');
    IF IPLAN<>0 THEN write(phase*100:3:1,' ',phi:3:1);
  END;}
(*--------------------------------------------------------------------------*)

(*-----------------------------------------------------------------------*)
(* ORBECL: transformation of coordinates XX,YY referred to the           *)
(*         orbital plane into ecliptic coordinates X,Y,Z using           *)
(*         Gaussian vectors PQR                                          *)
(*-----------------------------------------------------------------------*)
PROCEDURE ORBECL(XX,YY:double;PQR:double33;VAR X,Y,Z:double);
  BEGIN
    X:=PQR[1,1]*XX+PQR[1,2]*YY;
    Y:=PQR[2,1]*XX+PQR[2,2]*YY;
    Z:=PQR[3,1]*XX+PQR[3,2]*YY;
  END;

(*-----------------------------------------------------------------------*)
(* HYPANOM: calculation of the eccentric anomaly H=HYPANOM(MH,ECC) from  *)
(*          mean anomaly MH and eccentricity ECC for                     *)
(*          hyperbolic orbits                                            *)
(*-----------------------------------------------------------------------*)
FUNCTION HYPANOM(MH,ECC:double):double;
  CONST EPS=1E-10; MAXIT=15;
  VAR   H,F,EXH,SINHH,COSHH: double;
        I                  : INTEGER;
  BEGIN
    H:=LN(2.0*ABS(MH)/ECC+1.8); IF (MH<0.0) THEN H:=-H;
    EXH:=EXP(H); SINHH:=0.5*(EXH-1.0/EXH); COSHH:=0.5*(EXH+1.0/EXH);
    F := ECC*SINHH-H-MH; I:=0;
    WHILE ( (ABS(F)>EPS*(1.0+ABS(H+MH))) AND (I<MAXIT) )  DO
      BEGIN
        H := H - F / (ECC*COSHH-1.0);
        EXH:=EXP(H); SINHH:=0.5*(EXH-1.0/EXH); COSHH:=0.5*(EXH+1.0/EXH);
        F := ECC*SINHH-H-MH; I:=I+1;
      END;
    HYPANOM:=H;
    IF (I=MAXIT) THEN  {writeln(' convergence problems in HYPANOM');}
                        mainwindow.statusbar1.Caption:=(naam2+' convergence problems in HYPANOM');
  END;



(*-----------------------------------------------------------------------*)
(* HYPERB: calculation of the position and velocity vector               *)
(*         for hyperbolic orbits                                         *)
(*                                                                       *)
(*   T0   time of perihelion passage             X,Y   position          *)
(*   T    time                                   VX,VY velocity          *)
(*   A    semimajor axis (arbitrary sign)                                *)
(*   ECC  eccentricity                                                   *)
(*   (T0,T in julian centuries since J2000)                              *)
(*-----------------------------------------------------------------------*)
PROCEDURE HYPERB(T0,T,A,ECC:double;VAR X,Y,VX,VY:double);
  CONST KGAUSS = 0.01720209895;
  VAR K,MH,H,EXH,COSHH,SINHH,RHO,FAC: double;
  BEGIN
    A   := ABS(A);
    K   := KGAUSS / SQRT(A);
    MH  := K*36525.0*(T-T0)/A;
    H   := HYPANOM(MH,ECC);
    EXH := EXP(H);   COSHH:=0.5*(EXH+1.0/EXH);  SINHH:=0.5*(EXH-1.0/EXH);
    FAC := SQRT((ECC+1.0)*(ECC-1.0));   RHO := ECC*COSHH-1.0;
    X   := A*(ECC-COSHH);  Y  := A*FAC*SINHH;
    VX  :=-K*SINHH/RHO;    VY := K*FAC*COSHH/RHO;
  END;


(*-----------------------------------------------------------------------*)
(* ECCANOM: calculation of the eccentric anomaly E=ECCANOM(MAN,ECC)      *)
(*          from the mean anomaly MAN and the eccentricity ECC.          *)
(*          (solution of Kepler's equation by Newton's method)           *)
(*          (E, MAN in degrees)                                          *)
(*-----------------------------------------------------------------------*)
FUNCTION ECCANOM(MAN,ECC:double):double;
  CONST PI=3.141592654; TWOPI=6.283185308; RAD=0.0174532925199433;
        EPS = 1E-11; MAXIT = 15;
  VAR M,E,F: double;
      I    : INTEGER;
  BEGIN
    M:=MAN/360.0;  M:=TWOPI*(M-TRUNC(M)); IF M<0 THEN M:=M+TWOPI;
    IF (ECC<0.8) THEN E:=M ELSE E:=PI;
    F := E - ECC*SIN(E) - M; I:=0;
    WHILE ( (ABS(F)>EPS) AND (I<MAXIT) ) DO
      BEGIN
        E := E - F / (1.0-ECC*COS(E));  F := E-ECC*SIN(E)-M; I:=I+1;
      END;
    ECCANOM:=E/RAD;
    IF (I=MAXIT) THEN  {writeln(' convergence problems in ECCANOM');}
                        mainwindow.statusbar1.Caption:=(naam2+' convergence problems in ECCANOM');
  END;

(*-----------------------------------------------------------------------*)
(* ELLIP: calculation of position and velocity vector                    *)
(*        for elliptic orbits                                            *)
(*                                                                       *)
(*        M    mean anomaly in degrees       X,Y    position   (in AU)   *)
(*        A    semimajor axis                VX,VY  velocity (in AU/day) *)
(*        ECC  eccentricity                                              *)
(*-----------------------------------------------------------------------*)
PROCEDURE ELLIP(M,A,ECC:double;VAR X,Y,VX,VY:double);
  CONST KGAUSS = 0.01720209895;
  VAR K,E,C,S,FAC,RHO: double;
  BEGIN

    K  := KGAUSS / SQRT(A);
    E  := ECCANOM(M,ECC);   C:=CS(E); S:=SN(E);
    FAC:= SQRT((1.0-ECC)*(1+ECC));  RHO:=1.0-ECC*C;
    X := A*(C-ECC); Y :=A*FAC*S;   VX:=-K*S/RHO;   VY:=K*FAC*C/RHO;
  END;


(*-----------------------------------------------------------------------*)
(*  STUMPFF: calculation of Stumpff's functions C1 = sin(E)/E ,          *)
(*           C2 = (1-cos(E))/(E**2) and C3 = (E-sin(E))/(E**3)           *)
(*           for argument E2=E**2                                        *)
(*           (E: eccentric anomaly in radian)                            *)
(*-----------------------------------------------------------------------*)
PROCEDURE STUMPFF(E2:double;VAR C1,C2,C3:double);
  CONST EPS=1E-12;
  VAR N,ADD: double;
  BEGIN
    C1:=0.0; C2:=0.0; C3:=0.0; ADD:=1.0; N:=1.0;
    REPEAT
      C1:=C1+ADD; ADD:=ADD/(2.0*N);
      C2:=C2+ADD; ADD:=ADD/(2.0*N+1.0);
      C3:=C3+ADD; ADD:=-E2*ADD; N:=N+1.0;
    UNTIL ABS(ADD)<EPS;
  END;


(*-----------------------------------------------------------------------*)
(* CUBR: cube root                                                       *)
(*-----------------------------------------------------------------------*)
FUNCTION CUBR(X:double):double;
  BEGIN
    IF (X=0.0)  THEN CUBR:=0.0  ELSE CUBR:=EXP(LN(X)/3.0)
  END;

(*-----------------------------------------------------------------------*)
(* PARAB: calculation of position and velocity for                       *)
(*        parabolic and near parabolic orbits according to Stumpff       *)
(*                                                                       *)
(*        T0   time of perihelion passage         X,Y    position        *)
(*        T    time                              VX,VY  velocity         *)
(*        Q    perihelion distance                                       *)
(*        ECC  eccentricity                                              *)
(*        (T0,T in julian centuries since J2000)                         *)
(*-----------------------------------------------------------------------*)
PROCEDURE PARAB(T0,T,Q,ECC:double;VAR X,Y,VX,VY:double);
  CONST EPS    = 1E-9;
        KGAUSS = 0.01720209895;
        MAXIT  = 15;
  VAR E2,E20,FAC,C1,C2,C3,K,TAU,A,U,U2: double;
      R: double;
      I: INTEGER;
  BEGIN
    E2:=0.0;  FAC:=0.5*ECC;  I:=0;
    K   := KGAUSS / SQRT(Q*(1.0+ECC));
    TAU := KGAUSS * 36525.0*(T-T0);
    REPEAT
      I:=I+1;
      E20:=E2;
      A:=1.5*SQRT(FAC/(Q*Q*Q))*TAU;  A:=CUBR(SQRT(A*A+1.0)+A);
      U:=A-1.0/A;  U2:=U*U;  E2:=U2*(1.0-ECC)/FAC;
      STUMPFF(E2,C1,C2,C3); FAC:=3.0*ECC*C3;
    UNTIL (ABS(E2-E20)<EPS)OR(I>MAXIT);
    IF (I=MAXIT) THEN  {writeln(' convergence problems in PARAB');}
                       mainwindow.statusbar1.Caption:=(naam2+' convergence problems in PARAB');
    R :=Q*(1.0+U2*C2*ECC/FAC);
    X :=Q*(1.0-U2*C2/FAC);          VY:= K*(X/R+ECC);
    Y :=Q*SQRT((1.0+ECC)/FAC)*U*C1; VX:=-K*Y/R;
  END;
(*-----------------------------------------------------------------------*)
(* KEPLER: calculation of position and velocity for unperturbed          *)
(*         elliptic, parabolic and hyperbolic orbits                     *)
(*                                                                       *)
(*        T0   time of perihelion passage         X,Y,Z     position     *)
(*        T    time                               VX,VY,VZ  velocity     *)
(*        Q    perihelion distance                                       *)
(*        ECC  eccentricity                                              *)
(*        PQR  matrix of Gaussian vectors                                *)
(*        (T0,T in Julian centuries since J2000)                         *)
(*-----------------------------------------------------------------------*)
PROCEDURE KEPLER(T0,T,Q,ECC:double;PQR:double33;VAR X,Y,Z,VX,VY,VZ:double);
  CONST M0=5.0; EPS=0.1;
        KGAUSS = 0.01720209895; DEG = 57.29577951;
  VAR M,DELTA,TAU,INVAX,XX,YY,VVX,VVY: double;
  BEGIN
    DELTA := ABS(1.0-ECC);
    INVAX := DELTA / Q;
    TAU   := KGAUSS*36525.0*(T-T0);
    M     := DEG*TAU*SQRT(INVAX*INVAX*INVAX);
    IF ( (M<M0) AND (DELTA<EPS) )
      THEN  PARAB(T0,T,Q,ECC,XX,YY,VVX,VVY)
      ELSE IF (ECC<1.0)
             THEN ELLIP (M,1.0/INVAX,ECC,XX,YY,VVX,VVY)
             ELSE HYPERB(T0,T,1.0/INVAX,ECC,XX,YY,VVX,VVY);
    ORBECL(XX,YY,PQR,X,Y,Z); ORBECL(VVX,VVY,PQR,VX,VY,VZ);
  END;
(*--------------------------------------------------------------------------*)


(*-----------------------------------------------------------------------*)
(* ABERRAT: velocity vector of the Earth in equatorial coordinates       *)
(*          (in units of the velocity of light)                          *)
(*-----------------------------------------------------------------------*)
PROCEDURE ABERRAT(T: double; VAR VX,VY,VZ: double);{velocity vector of the Earth in equatorial coordinates, and units of the velocity of light}
  CONST P2=6.283185307;
  VAR L,CL: double;
  FUNCTION FRAC(X:double):double;
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1; FRAC:=X  END;
  BEGIN
    L := P2*FRAC(0.27908+100.00214*T);  CL:=COS(L);
    VX := -0.994E-4*SIN(L); VY := +0.912E-4*CL; VZ := +0.395E-4*CL;
  END;

PROCEDURE PLANET(iplan,equinox:INTEGER;julian:double;var ra3,dec3,mag3,diameter3,delta,phase3,phi3:double);
var a        : double33;
    delta0, light_speed_corr,R_SP,R_EP,elong : double;
    de_filename:string;
BEGIN
  if de430_emphemeris<>0 then {use DE431 ?}
  begin
    if ((IPLAN=0){sun is always called first, check is only once required nor for all planets}
      and (de430_loaded) and (check_date_range(julian)=false)) then
    begin {not within time range of DE file. Next to find suitable DE file}
      close_de_file;
      de430_loaded:=false;
    end;

    if de430_loaded=false then
      de430_loaded:=load_de_file2(julian,DE430_file,jd_start,jd_end);
    if de430_loaded=false then
      de430_loaded:=load_de_file2(julian,DE431_file,jd_start,jd_end);{try other file}

    if de430_loaded then
    begin
       CASE IPLAN OF    {julian_ET in call if required}   {Nutation is requested in step 0 and only used in writeinfo since map is in J2000}
           0: begin {sun}
                {earth with respect to the solar-system barycenter}
                Calc_Planet_de(julian, 3, earth_helio, true {in_au},12 {barocenter},TRUE{ velocity});{later used for earth shadow, without liightspeed delay}
                xeb:=earth_helio[0]; {helio centric x,y,z equatorial mean/date vector, later used for planets and shadow }
                yeb:=earth_helio[1]; {helio centric x,y,z equatorial mean/date vector, later used for planets and shadow}
                zeb:=earth_helio[2];
                sun_geodist:=sqrt(earth_helio[0]*earth_helio[0]+earth_helio[1]*earth_helio[1]+earth_helio[2]*earth_helio[2]);

                {now do sun with respect to the solar-system barycenter !!}
                light_speed_corr:=0.0057755183*sun_geodist;{sun is at 1 AU}
                Calc_Planet_de(julian-light_speed_corr, 11, planet_helio, true {in_au},12 {barocenter},false{ velocity});
                x_pln:=planet_helio[0]; {geocentric x,y,z equatorial J2000 vector planets}
                y_pln:=planet_helio[1];
                z_pln:=planet_helio[2];

                xsb:=x_pln;{remember for shadow calculation}
                ysb:=y_pln;
                zsb:=z_pln;

                Calc_Planet_de(julian, 14, nutation_1, true {in_au},3 {earth},false{ velocity});{nutation}
             end;
           1: begin {mercury}
                Calc_Planet_de(julian, 1, planet_helio, true {in_au},12 {barocenter},false{ velocity});
                light_speed_corr:=0.0057755183*sqrt( (planet_helio[0]-earth_helio[0])*(planet_helio[0]-earth_helio[0])+
                                                     (planet_helio[1]-earth_helio[1])*(planet_helio[1]-earth_helio[1])+
                                                     (planet_helio[2]-earth_helio[2])*(planet_helio[2]-earth_helio[2]));
                Calc_Planet_de(julian-light_speed_corr, 1, planet_helio, true {in_au},12 {barocenter},false{ velocity});
              end;
           2: begin {venus}
                Calc_Planet_de(julian, 2,planet_helio, true {in_au},12 {barocenter},false{ velocity});
                light_speed_corr:=0.0057755183*sqrt( (planet_helio[0]-earth_helio[0])*(planet_helio[0]-earth_helio[0])+
                                                     (planet_helio[1]-earth_helio[1])*(planet_helio[1]-earth_helio[1])+
                                                     (planet_helio[2]-earth_helio[2])*(planet_helio[2]-earth_helio[2]));
                Calc_Planet_de(julian-light_speed_corr, 2, Planet_helio, true {in_au},12 {barocenter},false{ velocity});
              end;
           3: begin {earth shadow, see 0:}
                {earth shadow, only called when almost full moon}
                xe:=xeb-xsb;{x earth sun equatorial, used later in illum comet, illum can work both with both equatorial as ecliptic but not mixed}
                ye:=yeb-ysb;
                ze:=zeb-zsb;
                x_pln:=(xe)*r{moon distance}/sun_geodist; {only valid after calling moon first !!!! to set r is distance moon}
                y_pln:=(ye)*r{moon distance}/sun_geodist; {only valid after calling moon first !!!! to set r is distance moon}
                z_pln:=(ze)*r{moon distance}/sun_geodist; {only valid after calling moon first !!!! to set r is distance moon}
              end;
           4: begin {}
                Calc_Planet_de(julian, 4, planet_helio, true {in_au},12 {barocenter},false{ velocity});
                light_speed_corr:=0.0057755183*sqrt( (planet_helio[0]-earth_helio[0])*(planet_helio[0]-earth_helio[0])+
                                                     (planet_helio[1]-earth_helio[1])*(planet_helio[1]-earth_helio[1])+
                                                     (planet_helio[2]-earth_helio[2])*(planet_helio[2]-earth_helio[2]));
                Calc_Planet_de(julian-light_speed_corr, 4, planet_helio, true {in_au},12 {barocenter},false{ velocity});
              end;
           5: begin {}
               {ra/dec calculation}
               {- compute Earth and Jupiter barycentric x,y,z for JD}
               {- get distance Earth-Jupiter, get light-time}
               {- compute Jupiter barycentric x,y,z at JD-lighttime}
               {- subtract previous Earth x,y,z at JD to get geocentric Jupiter x,y,z}

                Calc_Planet_de(julian, 5, planet_helio, true {in_au},12 {barocenter},false{ velocity});
                light_speed_corr:=0.0057755183*sqrt( (planet_helio[0]-earth_helio[0])*(planet_helio[0]-earth_helio[0])+
                                                     (planet_helio[1]-earth_helio[1])*(planet_helio[1]-earth_helio[1])+
                                                     (planet_helio[2]-earth_helio[2])*(planet_helio[2]-earth_helio[2]));
                Calc_Planet_de(julian-light_speed_corr, 5, planet_helio, true {in_au},12 {barocenter},false{ velocity});
              end;
           6: begin {}
                Calc_Planet_de(julian, 6, planet_helio, true {in_au},12 {barocenter},false{ velocity});
                light_speed_corr:=0.0057755183*sqrt( (planet_helio[0]-earth_helio[0])*(planet_helio[0]-earth_helio[0])+
                                                     (planet_helio[1]-earth_helio[1])*(planet_helio[1]-earth_helio[1])+
                                                     (planet_helio[2]-earth_helio[2])*(planet_helio[2]-earth_helio[2]));
                Calc_Planet_de(julian-light_speed_corr, 6, planet_helio, true {in_au},12 {barocenter},false{ velocity});
              end;
           7: begin {}
                Calc_Planet_de(julian, 7, planet_helio, true {in_au},12 {barocenter},false{ velocity});
                light_speed_corr:=0.0057755183*sqrt( (planet_helio[0]-earth_helio[0])*(planet_helio[0]-earth_helio[0])+
                                                     (planet_helio[1]-earth_helio[1])*(planet_helio[1]-earth_helio[1])+
                                                     (planet_helio[2]-earth_helio[2])*(planet_helio[2]-earth_helio[2]));
                Calc_Planet_de(julian-light_speed_corr, 7, planet_helio, true {in_au},12 {barocenter},false{ velocity});
              end;
           8: begin {}
                Calc_Planet_de(julian, 8, planet_helio, true {in_au},12 {barocenter},false{ velocity});
                light_speed_corr:=0.0057755183*sqrt( (planet_helio[0]-earth_helio[0])*(planet_helio[0]-earth_helio[0])+
                                                     (planet_helio[1]-earth_helio[1])*(planet_helio[1]-earth_helio[1])+
                                                     (planet_helio[2]-earth_helio[2])*(planet_helio[2]-earth_helio[2]));
                Calc_Planet_de(julian-light_speed_corr, 8, planet_helio, true {in_au},12 {barocenter},false{ velocity});
              end;
           9: begin {}
                Calc_Planet_de(julian, 9, planet_helio, true {in_au},12 {barocenter},false{ velocity});
                light_speed_corr:=0.0057755183*sqrt( (planet_helio[0]-earth_helio[0])*(planet_helio[0]-earth_helio[0])+
                                                     (planet_helio[1]-earth_helio[1])*(planet_helio[1]-earth_helio[1])+
                                                     (planet_helio[2]-earth_helio[2])*(planet_helio[2]-earth_helio[2]));
                Calc_Planet_de(julian-light_speed_corr, 9, planet_helio, true {in_au},12 {barocenter},false{ velocity});
              end;
           10: begin {moon}
                Calc_Planet_de(julian, 10, planet_helio, true {in_au},3 {earth},false{ velocity});
                r:=  sqrt( (planet_helio[0]*planet_helio[0])+ {r is later used for shadow}
                           (planet_helio[1]*planet_helio[1])+
                           (planet_helio[2]*planet_helio[2]) );
                light_speed_corr:=0.0057755183 * r;{about 1.282 seconds}
                Calc_Planet_de(julian-light_speed_corr, 10, planet_helio, true {in_au},12 {Bary centre},false{ velocity});
                {r is used in iplan 3 for earth shadow}
              end;
//           14: begin end; {nutation of ecliptic, requested in step 0}
            END;

            if ((iplan<>3)) {<>earth shadow} then
            begin
              x_pln:=planet_helio[0]-earth_helio[0]; {geocentric x,y,z equatorial J2000 vector planets}
              y_pln:=planet_helio[1]-earth_helio[1];
              z_pln:=planet_helio[2]-earth_helio[2];
            end;

            {precession request for maps should be in J2000 since all object are plot in J2000. Only for rise and set. Precession is called in writeinfo}
            if equinox<=1950 then {DE430/DE431 are in equatorial J2000}
            begin
              if equinox=1950 then
              Precession_cartesian(2451545.0 {J2000},2433282.4235 {B1950} ,x_pln,y_pln,  z_pln,x_pln,y_pln,z_pln) { precession function, equinox0 to equinox1, calculate B1950}
              else {0 = app or 1= mean}
              Precession_cartesian(2451545.0 {J2000},julian ,x_pln,y_pln,  z_pln,x_pln,y_pln,z_pln) { precession function, equinox0 to equinox1, calculate mean}
            end;

            if parallax2<>0 then PARALLAX_XYZ(wtime2actual,reallatitude*pi/180,X_pln,Y_pln,Z_pln);{correct parallax  in correct equinox. X, Y, Z in AE}
            {now convert equatorial x,y,z to ra, dec with the corrrect equinox}
            polar2(x_pln,y_pln,z_pln,delta,dec3,ra3) ;

            if iplan=0 then
            begin
              mag3:=-27;
            end
            else
            if iplan<>3 then {<> earth, earth xe,ye is calculated in iplan 0 = Sun }
            begin
              illum2(planet_helio[0]-xsb,planet_helio[1]-ysb,planet_helio[2]-zsb,
                     earth_helio[0]-xsb, earth_helio[1]-ysb, earth_helio[2]-zsb, R_SP,R_EP,elong,phi3, phase3);
              mag3:=bright(iplan,R_SP {distance sun planet},R_EP{distance earth planet },phi{Phase winkel earth-planet-sun});
            end;
    end;
  end;

  if ((de430_emphemeris=0) or (de430_loaded=false)) then {use internal empherides routines}
  begin
  CASE IPLAN OF
           1: begin MER200(T,L,B,R);end;
           2: begin VEN200(T,L,B,R);end;
           4: begin MAR200(T,L,B,R);end;
           5: begin
           JUP200(T,L,B,R);end;
           6: begin SAT200(T,L,B,R);end;
           7: begin URA200(T,L,B,R);end;
           8: begin NEP200(T,L,B,R);end;
           9: begin
                if ( (-1.1<T) AND (T<+1.0) )=false then begin ra3:=0;dec3:=pi/2;mag3:=1000;exit;end; (* Pluto ja/nein *)
                PLU200(T,L,B,R);
              end;
           0: BEGIN
                T:=(julian-2400000.5-51544.5)/36525.0;{calculate time, julian_ET in call if required}
                sun200(t,ls,bs,rs);
                sun_geodist:=rs;
                L:=0.0; B:=0.0; R:=0.0;
                sun200_calculated:=true;{for comets}
              END;
          10:
             begin
               MOON(T,L,B,R);        (* ekliptikale Moondkoordinaten           *)
               R:=R * (6378.14/AE);  { scale moon factor from earthdiameters down to AE}
               CART(R,B,L,X_pln,Y_pln,Z_pln);    (* (mittleres Aequinoktium des Datums)    *)
                                                 {moon position without nutequ for astrometric position}
                                                 {so moon position is mean instead of true}
               delta0:=r; {moon distance in ae, delta0 required for magnitude}

               xp_ecl_helio:= xe+x_pln;
               yp_ecl_helio:= ye+y_pln;
               zp_ecl_helio:= ze+z_pln; {calculate helio centric factors}
             end;
          3: BEGIN {Earth shadow near moon}
                   {only valid after calling moon first !!!! to set r is distance moon}

               x_pln:=(xe)*r/rs; {scale distance down to moon distance};
               y_pln:=(ye)*r/rs;
               z_pln:=(ze)*r/rs; {this are now the ecliptice geocentric values of the shadow}

             END;{earth shadow near moon}
           END;

            (* geozentrische ekliptikale PLanetenkoordinaten (retardiert) *)
            if ((iplan<>10) and (iplan<>3)) then {<> moon, earth shadow}
            begin
              {imode 0=geometric,1=astrometric,2=apparent}
              GEOCEN(T, L,B,R, LS,BS,RS, IPLAN,1 {IMODE 1 is astrometric}, // geocentric coordinates (geometric and light-time corrected
                     XP_ecl_helio,YP_ecl_helio,ZP_ecl_helio, XS,YS,ZS, X_pln,Y_pln,Z_pln,DELTA0);
                    (*   IPLAN:    planet (0=Sun,1=Mercury,2=Venus,3=Earth,...,9=Pluto       *)
                    (*   IMODE:    desired type of coordinates (see description of X,Y,Z)    *)
                    (*             (0=geometric,1=astrometric,2=apparent)                    *)
                    (*   XP,YP,ZP: ecliptic heliocentric coordinates of the planet           *)
                    (*   XS,YS,ZS: ecliptic geocentric coordinates of the Sun                *)
                    (*   X, Y, Z : ecliptic geocentric cordinates of the planet (geometric   *)

            end;

            if iplan=0 then {sun}
            begin
              xe:=-xs; ye:=-ys; ze:=-zs;{ecliptiptic geocentric position earth shadow , inverse sun}
              mag3:=-27;
            end
            else
            if iplan<>3 then {<> earth, earth xe,ye is calculated in iplan 0 = Sun }
            begin
              illum2(xp_ecl_helio,yp_ecl_helio,zp_ecl_helio,xe,ye,ze   , R_SP,R_EP,elong,phi3, phase3);
              mag3:=bright(iplan,R_SP {distance sun planet},R_EP{distance earth planet },phi{Phase winkel earth-planet-sun});

            end;
            ECLEQU (T,X_pln,Y_pln,Z_pln);   {Solution 2, ecliptic to equatorial coordinates}
            {now convert equatorial x,y,z to ra, dec with the corrrect equinox}
            if equinox>1 then {planets positions from planpos are in equinox date, convert to the required equinox}
            begin {not mean=1 or apparent=0}
              if equinox=1950 then TEQX:=B1950
              else TEQX := (equinox-2000.0)/100.0;
              PMATEQU(T,TEQX,A);  {See page 22}
              PRECART (a,X_pln,Y_pln,Z_pln);
            end;

            if parallax2<>0 then PARALLAX_XYZ(wtime2actual,reallatitude*pi/180,X_pln,Y_pln,Z_pln);{correct parallax  in correct equinox. X, Y, Z in AE}
            (* Polarkoordinaten *)
            POLAR2 (X_pln,Y_pln,Z_pln ,delta,DEC3,RA3);
  end; {de_emphemeris false}

  CASE IPLAN OF      {diameters}
       0:   begin
              x_sun:=x_pln;y_sun:=y_pln;z_sun:=z_pln;
              diameter3:= ((1/delta)* 1392720 * (360*60*60/ (pi*2*AE))); {ae has been fixed to the value 149597870.700 km as adopted by the International Astronomical Union in 2012}
            end;
       1:   diameter3:= ((1/delta)*  4878 * (360*60*60/ (pi*2*AE)));
       2:   diameter3:= ((1/delta)* 12104 * (360*60*60/ (pi*2*AE)));
       4:   diameter3:= ((1/delta)* 6796 * (360*60*60/ (pi*2*AE)));
       5:   diameter3:= ((1/delta)* 142796 * (360*60*60/ (pi*2*AE)));
       6:   diameter3:= ((1/delta)* 120660 * (360*60*60/ (pi*2*AE)));
       7:   diameter3:= ((1/delta)* 51120 * (360*60*60/ (pi*2*AE)));
       8:   diameter3:= ((1/delta)* 49520 * (360*60*60/ (pi*2*AE)));
       9:   diameter3:= ((1/delta)* 2280 * (360*60*60/ (pi*2*AE)));
      10:   diameter3:= ((1/delta)* 3476 * (360*60*60/ (pi*2*AE))); {ae is 149.6E6 km}
       3:
       begin
         diameter3:= 51/50*(12756-(1392720-12756)*delta/sun_geodist) /  3476; {diameter umbra in moon diameters}
         phase3   := 51/50*(12756+(1392720-12756)*delta/sun_geodist) /  3476; {diameter penumbra in moon diameters}
         {51/50 factor, see note new meeus, to include atmosphere of earth}
         {shadowdiam = planetdiam - (sundiam-planetdia)*shadowdistance/sundistance}
       end;
  END; {case}
END;

PROCEDURE COMET(sun:boolean;equinox:INTEGER;julian:double;year,month:integer;d,ecc,q,inc2,lan,aop,teqx0:double;
                var RA,DEC,DELTA,sun_delta:double);
{sun calculate sun or uses values from call to planet(0 ....)}
{equinox  on which basis e.g 2000}
{julian   julian date                                         }
{year, month, d, e,q,q,inc2,lan,aop,teqx0   comet parameters  }
{output:  ra,dec calculated coordinates   }
{         delta0 distance in au           }
{                      }
var
   A,AS2,PQR :double33; {array[1..3,1..3]}
   {VX,VY,VZ,}fac,t0,delta0 :double;
BEGIN (* COMET *)
{ YEAR:=1986;
{ MONTH:=2;
{ D:=9.43867;
{ Q:= 0.5870992;{    ! Perihelion distance q in AU;}
{ ECC:= 0.9672725;{  ! Eccentricity e}
{ INC2:= 162.23932;{ ! Inclination i}
{ LAN:= 58.14397; {  ! Longitude of the ascending node}
{ AOP:= 111.84658;{  ! Argument of perihelion}
{ TEQX0:=1950.0;{    ! Equinox for the orbital elements}

  T:=(julian-2400000.5-51544.5)/36525.0;{calculate time}

  DAY:=TRUNC(D); HOUR:=24.0*(D-DAY);
  T0 := ( MJD(DAY,MONTH,YEAR,HOUR) - 51544.5) / 36525.0;
  TEQX0 := (TEQX0-2000.0)/100.0;
  GAUSVEC(LAN,INC2,AOP,PQR);
  TEQX := (equinox-2000.0)/100.0;

  (* ecliptic coordinates of the sun, equinox TEQX        *)
  if sun=false then   {position sun already calculated for this time}
  begin
    SUN200 (T,LS,BS,RS);
    CART (RS,BS,LS,XS,YS,ZS);{sun heliocentric ecliptic coordinates equinox date=T}
    sun200_calculated:=true;
  end;

  (* heliocentric ecliptic coordinates of the comet       *)
  KEPLER (T0,T,Q,ECC,PQR,X_pln,Y_pln,Z_pln,VX,VY,VZ);
  PMATECL (TEQX0,T,A);    (* calculate precession matrix         *){for comet to ecliptic equinox T}
  PRECART (A,X_pln,Y_pln,Z_pln);  PRECART (A,VX,VY,VZ); { POLAR (X,Y,Z,R,B,L);}

  sun_DELTA := SQRT ( X_pln*X_pln + Y_pln*Y_pln + Z_pln*Z_pln );
  xa:=x_pln; ya:=y_pln; za:=z_pln;{helio centric position comets, equinox of date for function illuminate later and also comet velocity calculation}

  (* geometric geocentric coordinates of the comet        *)
  X_pln:=X_pln+XS;  Y_pln:=Y_pln+YS;   Z_pln:=Z_pln+ZS;    DELTA0 := SQRT ( X_pln*X_pln + Y_pln*Y_pln + Z_pln*Z_pln );

  (* first order correction for light travel time         *)

  FAC:=0.00578*DELTA0;  X_pln:=X_pln-FAC*VX;   Y_pln:=Y_pln-FAC*VY;   Z_pln:=Z_pln-FAC*VZ;

  ECLEQU (T,X_pln,Y_pln,Z_pln);{convert ecliptic equinox t  to equatorial equinox t}

  if parallax2<>0 then PARALLAX_XYZ(wtime2actual,reallatitude*pi/180,X_pln,Y_pln,Z_pln);{correct parallax  in correct equinox. X, Y, Z in AE}

  PMATEQU (T,TEQX,AS2);{prepare equinox t to desired teqx}
  PRECART (AS2,X_pln,Y_pln,Z_pln); {change equinox}

  POLAR2(X_pln,Y_pln,Z_pln ,DELTA,DEC,RA);{radialen polar2}
END;


function comet_velocity: string; {calculate velocity in arcsec/hour, only valid if called after procedure comet, by Han 2017-2-22}
var
  LS,BS,RS,delta2,ra,dec,ra1,dec1,xs2,ys2,zs2,t,x_pln2,y_pln2,z_pln2,x_pln1,y_pln1,z_pln1,delta1,fac: double;
begin
  T:=(julian_et-2400000.5-51544.5)/36525.0;{calculate time, 1 hour in the future}

  {-------current position}
  X_pln1:=xa+XS;  Y_pln1:=ya+YS;   Z_pln1:=za+ZS;
  {use first order light travel correction formula to calculate position one hour in the future}
  DELTA1 := SQRT ( X_pln1*X_pln1 + Y_pln1*Y_pln1 + Z_pln1*Z_pln1);

  FAC:=0.00578*(delta1); {light travel correction}
  X_pln1:=X_pln1+FAC*VX;  Y_pln1:=Y_pln1+FAC*VY;   Z_pln1:=Z_pln1+FAC*VZ;{including light travel correction}
  ECLEQU (T,X_pln1,Y_pln1,Z_pln1);{convert ecliptic equinox t  to equatorial equinox t}
  {conversion to J2000 not required since it is a relative value}
  POLAR2 (x_pln1,y_pln1,z_pln1 ,DELTA1,DEC1,RA1);{7.214359*0.00578 in 1 light hour is 7.21.. au}
  {--------end current position}


  {--------future position}
  SUN200 (T+(1/24)/36525.0,LS,BS,RS);{calculate sun position one hour in the future}
  CART (RS,BS,LS,XS2,YS2,ZS2);{sun heliocentric ecliptic coordinates at T + 1 hour}

  (* geometric geocentric coordinates of the comet        *)
  FAC:=0.00578*(7.214359); {1 hour in the future equals 7.21 au}
  X_pln2:=xa+FAC*VX+XS2;  Y_pln2:=ya+FAC*VY+YS2;   Z_pln2:=za+FAC*VZ+ZS2;{position, 1 hour in the future taking in account sun=earth and comet position}
  DELTA2 := SQRT ( X_pln2*X_pln2 + Y_pln2*Y_pln2 + Z_pln2*Z_pln2 );{new distance}
  FAC:=0.00578*(delta2); {light travel correction }
  X_pln2:=X_pln2+FAC*VX;   Y_pln2:=Y_pln2+FAC*VY;   Z_pln2:=Z_pln2+FAC*VZ; {calculate position one hour in the future, no light travel correction}
  ECLEQU (T,X_pln2,Y_pln2,Z_pln2);{convert ecliptic equinox t  to equatorial equinox t}
  {conversion to J2000 not required since it is a relative value}
  POLAR2 (x_pln2,y_pln2,z_pln2 ,DELTA,DEC,RA);{7.214359*0.00578 in 1 light hour is 7.21.. au}
  {-------end future position}

  result:='    να: '+ floattostrF((180*60*60/(pi))*(RA-RA1)*cos(dec1),ffGeneral,4,2)+  {arc sec per hour}
          ',   νδ: '+ floattostrF((180*60*60/(pi))*(DEC-DEC1),ffGeneral,4,2)+'  '+arcsec_hour_string;
end;

PROCEDURE COMET_tail(length3:double;var RA_tail,DEC_tail:double); {2013, calculate tail, increase  position with factor length3 from sun,, only valid if called after comet}
var
  AS2         :double33;
begin
 {now tail}

  X_pln:=xa*length3;  Y_pln:=Ya*length3;   Z_pln:=Za*length3;{heliocentric comet position, but moved with length3 away from sun}
  (* geometric geocentric coordinates of the comet        *)
  X_pln:=X_pln+XS;  Y_pln:=Y_pln+YS;   Z_pln:=Z_pln+ZS;

  (* first order correction for light travel time         *)
//  FAC:=0.00578*DELTA0;  X:=X-FAC*VX;   Y:=Y-FAC*VY;   Z:=Z-FAC*VZ;

  ECLEQU (T,X_pln,Y_pln,Z_pln);{convert ecliptic equinox t  to equatorial equinox t}

  PMATEQU (T,TEQX,AS2);{prepare equinox t to desired teqx}
  PRECART (AS2,X_pln,Y_pln,Z_pln); {change equinox}

  POLAR2(X_pln,Y_pln,Z_pln ,DELTA,DEC_tail,RA_tail);
end;

function illum_comet : double ; { Get phase angle comet. Only valid is comet routine is called first.}
var
    R_SP,R_EP,elong,phi1,phase1 :double;
begin
  illum2(xa,ya,za,-xs,-ys,-zs, R_SP,R_EP,elong,phi1, phase1 );{ xa is heliocentric asteriod}
                             { -xs helio centric earth, calculated from sun200}
  illum_comet:=phi1*pi/180;
end;

PROCEDURE EP(yearold,yearnew,raOLD,decold:double;var ranew,decnew:double);{correct precession for equatorial coordinates}
var teqxn,R : double;
    A       : double33;
    x,y,z : double;
begin
  CART(1,decold*180/pi,raold*180/pi,X,Y,Z);
  TEQX := (yearold-2000.0)/100.0;
  TEQXn := (yearnew-2000.0)/100.0;

  PMATEQU(TEQX,TEQXN,a);

  PRECART(A,X,Y,Z);

  TEQX := TEQXN;
  POLAR2(X,Y,Z ,R,DECnew,RAnew);
end;

PROCEDURE Get_planet_equatorial_heliocentrisch(var xhp,yhp,zhp: double);
var A  :double33;
begin  {Only valid is planet routine is called first.}
  if ((de430_emphemeris=0) or (de430_loaded=false)) then
  begin
    xhp:=xp_ecl_helio;  (*   XP,YP,ZP: ecliptic heliocentric coordinates of the planet           *)
    yhp:=yp_ecl_helio;
    zhp:=zp_ecl_helio;
    PMATECL(T,(2000-2000.0)/100.0,A);   {See page 22, astronomy on the personal computer}
    PRECART (A,Xhp,YhP,ZhP);{planet helio centric J2000}
    ECLEQU((2000-2000.0)/100.0,Xhp,YhP,ZhP);(* ECLEQU: Conversion of ecliptic into equatorial coordinates            *)
  end
  else
  begin
    xhp:=planet_helio[0]-xs; {heliocentric x,y,z equatorial vector planets, used for the moons}
    yhp:=planet_helio[1]-ys; {heliocentric x,y,z equatorial vector planets, used for the moons}
    zhp:=planet_helio[2]-zs; {heliocentric x,y,z equatorial vector planets, used for the moons}
  end;
end;

BEGIN (* PLANPOS *)
end.

