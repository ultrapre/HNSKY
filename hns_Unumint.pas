unit hns_Unumint;

{Software code is Copyright (C) 1998 by Springer-Nature, Berlin Heidelberg and originates the code described in the book Astronomy on the Personal Computer,
 ISBN 3-540-63521-1 3rd edition 1998. Authors Oliver Montenbruck and Thomas Pleger.
 Reproduced with written permission of SNCSC (Springer-Nature) dated 2019-3-27 under the conditions specified in the letter below.

Planetary Ephemeride calculation modified for higher accuracy by Han Kleijn, www.hnsky.org email: han.k.. at...hnsky.org

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

{numerical integration of perturbed minor planet orbits}
{see astronomy on personal computer, chapter 5}

interface

uses
  {$ifdef mswindows}
//  Windows,
  {$endif}
  {$ifdef unix}
  {$endif}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

FUNCTION NUMINT_ASTEROID(Year,Month:integer; Day1, SMA, ECC, INC, LOA, AOP, MA, Equinox_old:double; Year_new, Month_new:integer; Day_new, Equinox_new: double): STRING;{calculates new  orbital elements  for  asteroids}

implementation
//type
//  double33= array[1..3,1..3] of double;{already in HNS_UPLA

uses hns_mercury,
     hns_venus,
     hns_mars,
     hns_jupiter,
     hns_saturn,
     hns_uranus,
     hns_neptune,
     hns_Upla,  hns_main;

{volgende routines worden ook in hnsUpla gebruikt en kunnen hergebruikt worden
type
  double33= array[1..3,1..3] of double;
FUNCTION CS(X:double):double;
FUNCTION SN(X:double):double;
FUNCTION ATN2(Y,X:double):double;
PROCEDURE GAUSVEC(LAN,INC,AOP:double;VAR PQR:double33);
FUNCTION ECCANOM(MAN,ECC:double):double;
PROCEDURE ELLIP(M,A,ECC:double;VAR X,Y,VX,VY:double);
PROCEDURE ORBECL(XX,YY:double;PQR:double33;VAR X,Y,Z:double);
PROCEDURE POLAR(X,Y,Z:double;VAR R,THETA,PHI:double);
PROCEDURE SUN200(T:double;VAR L,B,R:double);
PROCEDURE CART(R,THETA,PHI: double; VAR X,Y,Z: double);
PROCEDURE ECLEQU(T:double;VAR X,Y,Z:double);
FUNCTION MJD(DAY,MONTH,YEAR:INTEGER;HOUR:double):double;
PROCEDURE PMATECL(T1,T2:double;VAR A: double33);
PROCEDURE PRECART(A:double33;VAR X,Y,Z:double);}


  CONST J2000  = 0.0;


  (*---------------------------------------------------------------------*)
  (* Sample dimensions and type declarations for use with DE,STEP,INTRP  *)
  (*---------------------------------------------------------------------*)
  CONST DE_EQN = 6;           (* Maximum number of ODEs to be integrated *)
        TWOU   = 4.0E-12;     (* Turbo Pascal double data type accuracy    *)
        FOURU  = 8.0E-12;     (* u=2**(-39)=1.81E-12                     *)
        {note han, does not influence speed or stepsize, only guarding}

  TYPE  DE_EQN_VECTOR       = ARRAY[1..DE_EQN] OF double;
        //DE_FUNC = PROCEDURE ( X: double; Y: DE_EQN_VECTOR; VAR YP: DE_EQN_VECTOR );

        DE_12_VECTOR        = ARRAY[1..12] OF double;
        DE_13_VECTOR        = ARRAY[1..13] OF double;
        DE_PHI_ARRAY        = ARRAY[1..DE_EQN,1..16] OF double;

        DE_WORKSPACE_RECORD = RECORD
                                YY,WT,P,YP,YPOUT     :  DE_EQN_VECTOR;
                                PHI                  :  DE_PHI_ARRAY;
                                ALPHA,BETA,V,W,PSI   :  DE_12_VECTOR;
                                SIG,G                :  DE_13_VECTOR;
                                X,H,HOLD,TOLD,DELSGN :  double;
                                NS,K,KOLD,ISNOLD     :  INTEGER;
                                PHASE1,START,NORND   :  BOOLEAN;
                              END;



TYPE  PLANET_TYPE = ( MERCURY, VENUS,  EARTH,  MARS,
                      JUPITER, SATURN, URANUS, NEPTUNE, PLUTO );


  VAR DAY,IFLAG                    : INTEGER;
      HOUR,T_EPOCH, TEQX           : double;
      MJD_START,MJD_END, T1        : double;
      XX,YY,ZZ, VX,VY,VZ           : double;
      PQR                                : double33;
      EQX0_TO_J2000, J2000_TO_EQX        : double33;
      Y                                  : DE_EQN_VECTOR;
      WORK                               : DE_WORKSPACE_RECORD;

      error_message : string;


//redundant units already in unit HNS_Upla
{
//XXXXXXX  Also used in unit HNS_Upla
(*-----------------------------------------------------------------------*)
(* CS: cosine function (degrees)                                         *)
(*-----------------------------------------------------------------------*)
FUNCTION CS(X:double):double;
  CONST RAD=0.0174532925199433;
  BEGIN
    CS:=COS(X*RAD)
  END;

//XXXXXxx  Also used in unit HNS_Upla
(*-----------------------------------------------------------------------*)
(* SN: sine function (degrees)                                           *)
(*-----------------------------------------------------------------------*)
FUNCTION SN(X:double):double;
  CONST RAD=0.0174532925199433;
  BEGIN
    SN:=SIN(X*RAD)
  END;
//XXXXXXX  Also used in unit HNS_Upla
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

//XXXXXXX  Also used in unit HNS_Upla
(*-----------------------------------------------------------------------*)
(* GAUSVEC: calculation of the Gaussian vectors (P,Q,R) from             *)
(*          ecliptic orbital elements:                                   *)
(*          LAN = longitude of the ascending node                        *)
(*          INC = inclination                                            *)
(*          AOP = argument of perihelion                                 *)
(*-----------------------------------------------------------------------*)
//XXXXXXX  Also used in unit HNS_Upla
PROCEDURE GAUSVEC(LAN,INC,AOP:double;VAR PQR:double33);
  VAR C1,S1,C2,S2,C3,S3: double;
  BEGIN
    C1:=CS(AOP);  C2:=CS(INC);  C3:=CS(LAN);
    S1:=SN(AOP);  S2:=SN(INC);  S3:=SN(LAN);
    PQR[1,1]:=+C1*C3-S1*C2*S3; PQR[1,2]:=-S1*C3-C1*C2*S3; PQR[1,3]:=+S2*S3;
    PQR[2,1]:=+C1*S3+S1*C2*C3; PQR[2,2]:=-S1*S3+C1*C2*C3; PQR[2,3]:=-S2*C3;
    PQR[3,1]:=+S1*S2;          PQR[3,2]:=+C1*S2;          PQR[3,3]:=+C2;
  END;

//XXXXXXX  Also used in unit HNS_Upla
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
    IF (I=MAXIT) THEN  //writeln(' convergence problems in ECCANOM');
                        error_message:='Convergence problem in ECCANOM: ';
  END;

//XXXXXXX  Also used in unit HNS_Upla
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

//XXXXXXX  Also used in unit HNS_Upla
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

//XXXXXXX  Also used in unit HNS_Upla
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
//XXXXXXX  Also used in unit HNS_Upla
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

//XXXXXXX  Also used in unit HNS_Upla
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

//XXXXXXX  Also used in unit HNS_Upla
(*-----------------------------------------------------------------------*)
(* POLAR: conversion of cartesian coordinates (x,y,z)                    *)
(*        into polar coordinates (r,theta,phi)                           *)
(*        (theta in [-90 deg,+90 deg]; phi in [0 deg,+360 deg])          *)
(*-----------------------------------------------------------------------*)
PROCEDURE POLAR(X,Y,Z:double;VAR R,THETA,PHI:double);
  VAR RHO: double;
  BEGIN
    RHO:=X*X+Y*Y;  R:=SQRT(RHO+Z*Z);
    PHI:=ATN2(Y,X); IF PHI<0 THEN PHI:=PHI+360.0;
    RHO:=SQRT(RHO); THETA:=ATN2(Z,RHO);
  END;

//XXXXXXX  Also used in unit HNS_Upla
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

//XXXXXXX  Also used in unit HNS_Upla
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
//XXXXXXX  Also used in unit HNS_Upla
PROCEDURE ECLEQU(T:double;VAR X,Y,Z:double);
  VAR EPS,C,S,V: double;
  BEGIN
    EPS:=23.43929111-(46.8150+(0.00059-0.001813*T)*T)*T/3600.0;
    C:=CS(EPS);  S:=SN(EPS);
    V:=+C*Y-S*Z;  Z:=+S*Y+C*Z;  Y:=V;
  END;  }

(*-----------------------------------------------------------------------*)
(*                                                                       *)
(* POSITION:                                                             *)
(*                                                                       *)
(*   Computes the position of a planet assuming Keplerian orbits. Mean   *)
(*   elements at epoch J2000 are used for Mercury to Mars; osculating    *)
(*   elements at epoch 1995/10/10 (JD 2450000.5) are used for Jupiter to *)
(*   Pluto. Relative accuracy approx. 0.001 between 1990 and 2000.       *)
(*                                                                       *)
(*   PLANET  Name of the planet                                          *)
(*   T       Time in Julian centuries since J2000                        *)
(*   X,Y,Z   Ecliptic coordinates (equinox J2000)                        *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)
PROCEDURE POSITIONold( PLANET: PLANET_TYPE; T: double;  VAR X,Y,Z: double );

  VAR   A,E,M,O,I,W,N :  double;
        XX,YY,VVX,VVY :  double;
        T0            :  double;
        PQR           :  double33;

  BEGIN
    (* Heliocentric ecliptic orbital elements for equinox J2000 *)
    t0:=0;
    CASE PLANET OF

      MERCURY : BEGIN
                  A:= 0.387099; E:=0.205634; M:=174.7947; N:=149472.6738;
                  O:= 48.331;   I:= 7.0048;  W:= 77.4552;
                END;
      VENUS   : BEGIN
                  A:= 0.723332; E:=0.006773; M:= 50.4071; N:= 58517.8149;
                  O:= 76.680;   I:= 3.3946;  W:=131.5718;
                END;
      EARTH   : BEGIN
                  A:= 1.000000; E:=0.016709; M:=357.5256; N:= 35999.3720;
                  O:=174.876;   I:= 0.0000;  W:=102.9400;
                END;
      MARS    : BEGIN
                  A:= 1.523692; E:=0.093405; M:= 19.3879; N:= 19140.3023;
                  O:=49.557;    I:= 1.8496;  W:=336.0590;
                END;
      JUPITER : BEGIN
                  A:= 5.202437; E:=0.048402; M:=250.3274; N:=  3035.2275;
                  O:=100.4683;  I:=1.3047;   W:= 15.7192;
                END;
      SATURN  : BEGIN
                  A:= 9.551712; E:=0.052340; M:=267.2465; N:=  1219.6465;
                  O:=113.6439;  I:=2.4855;   W:= 90.9682;
                END;
      URANUS  : BEGIN
                  A:=19.293108; E:=0.044846; M:=118.4320; N:=   424.8150;
                  O:= 74.0903;  I:=0.7733;   W:=176.6152;
                END;
      NEPTUNE : BEGIN
                  A:=30.257162; E:=0.007985; M:=292.4716; N:=   216.3047;
                  O:=131.7750;  I:=1.7700;   W:=  3.0962;
                END;
      PLUTO   : BEGIN
                  A:=39.783607; E:=0.254351; M:=  8.2304; N:=   143.4629;
                  O:=110.3865;  I:=17.1201;  W:=224.7424;
                END
                ELSE
                BEGIN
                  A:= 0; E:=0; M:=0; N:=0; {2013 FOR  compiler only to  get rid of might not have been initialized}
                  O:= 0;   I:= 0;  W:=0;
                END;

    END;

    CASE PLANET OF
      MERCURY,VENUS, EARTH, MARS          : T0:= 0.0;
      JUPITER,SATURN,URANUS,NEPTUNE,PLUTO : T0:=-0.042286105;
    END;

    M := M + N*(T-T0);

    (* Cartesian coordinates mean ecliptic and equinox J2000 *)

    GAUSVEC ( O,I,W-O, PQR );
    ELLIP   ( M,A,E, XX,YY,VVX,VVY );
    ORBECL  ( XX,YY,PQR, X,Y,Z );


  END;

(*-----------------------------------------------------------------------*)
(*                                                                       *)
(* POSITION:                                                             *)
(*                                                                       *)
(*   Computes the position of a planet assuming Keplerian orbits. Mean   *)
(*   elements at epoch J2000 are used for Mercury to Mars; osculating    *)
(*   elements at epoch 1995/10/10 (JD 2450000.5) are used for Jupiter to *)
(*   Pluto. Relative accuracy approx. 0.001 between 1990 and 2000.       *)
(*                                                                       *)
(*   PLANET  Name of the planet                                          *)
(*   T       Time in Julian centuries since J2000                        *)
(*   X,Y,Z   Ecliptic coordinates (equinox J2000)                        *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)

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

PROCEDURE POSITION ( PLANET: PLANET_TYPE; T: double;  VAR X,Y,Z: double );{high precision version by Han resulting in 1" accuracy instead of 10"}

  VAR   L,B,R     :  double;
        PQR       :  double33;

  BEGIN
    (* Heliocentric ecliptic orbital elements for equinox J2000 *)  {update  2013}
    CASE PLANET OF
        mercury:  begin MER200(T, L,B,R);CART(R,B,L,X,Y,Z); end;
        venus  :  begin VEN200(T, L,B,R);CART(R,B,L,X,Y,Z); end;
        earth  :  begin SUN200(T, L,B,R);
                        CART(R,B,L,X,Y,Z);
                        x:=-x; y:=-y; z:=-z;{earth is inverse sun} end;
        mars:     begin MAR200(T, L,B,R);CART(R,B,L,X,Y,Z); end;
        jupiter:  begin JUP200(T, L,B,R);CART(R,B,L,X,Y,Z); end;
        saturn:   begin SAT200(T, L,B,R);CART(R,B,L,X,Y,Z); end;
        uranus:   begin URA200(T, L,B,R);CART(R,B,L,X,Y,Z); end;
        neptune:  begin NEP200(T, L,B,R);CART(R,B,L,X,Y,Z);end;
    end;
    PMATECL(T,j2000,pqr); {prepare conversion}
    PRECART (pqr,X,Y,Z);  {conversion to ecliptic cartesian J2000}
  END;

(*-----------------------------------------------------------------------*)
(*                                                                       *)
(* ACCEL: computes the acceleration                                      *)
(*                                                                       *)
(*   T         Time in Julian centuries since J2000                      *)
(*   X,Y,Z     Heliocentric ecliptic coordinates (in AU)                 *)
(*   AX,AY,AZ  Acceleration (in AU/d**2)                                 *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)

PROCEDURE ACCEL ( T, X,Y,Z: double; VAR AX,AY,AZ: double );

  CONST K_GAUSS =  0.01720209895;     (* Gaussian gravitational constant *)

  VAR   PLANET                :  PLANET_TYPE;
        GM_SUN, R_SQR,R,MU_R3 :  double;
        XP,YP,ZP, DX,DY,DZ    :  double;
        MU                    :  ARRAY[PLANET_TYPE] OF double;

  BEGIN

    (* Grav. constant * solar and planetary masses in AU**3/d**2 *)

    GM_SUN := K_GAUSS*K_GAUSS;

    MU[MERCURY] := GM_SUN / 6023600.0;
    MU[VENUS]   := GM_SUN /  408523.5;
    MU[EARTH]   := GM_SUN /  328900.5;
    MU[MARS]    := GM_SUN / 3098710.0;
    MU[JUPITER] := GM_SUN /    1047.355;
    MU[SATURN]  := GM_SUN /    3498.5;
    MU[URANUS]  := GM_SUN /   22869.0;
    MU[NEPTUNE] := GM_SUN /   19314.0;
    MU[PLUTO]   := GM_SUN / 3000000.0;

    (* Solar attraction *)

    R_SQR := ( X*X + Y*Y + Z*Z );  R := SQRT(R_SQR);
    MU_R3 := GM_SUN / (R_SQR*R);
    AX := -MU_R3*X;  AY := -MU_R3*Y;  AZ := -MU_R3*Z;

    (* Planetary perturbation *)

    FOR PLANET := MERCURY TO PLUTO DO

      BEGIN

        (* Planetary coordinates *)

        POSITION ( PLANET, T, XP,YP,ZP );
        DX:=X-XP;  DY:=Y-YP;  DZ:=Z-ZP;

        (* Direct acceleration   *)

        R_SQR := ( DX*DX + DY*DY + DZ*DZ );  R := SQRT(R_SQR);
        MU_R3 := MU[PLANET] / (R_SQR*R);
        AX := AX-MU_R3*DX;  AY := AY-MU_R3*DY;  AZ := AZ-MU_R3*DZ;

        (* Indirect acceleration *)

        R_SQR := ( XP*XP + YP*YP + ZP*ZP );  R := SQRT(R_SQR);
        MU_R3 := MU[PLANET] / (R_SQR*R);
        AX := AX-MU_R3*XP;  AY := AY-MU_R3*YP;  AZ := AZ-MU_R3*ZP;

      END;

  END;

PROCEDURE F2( X: double; Y: DE_EQN_VECTOR; VAR DYDX: DE_EQN_VECTOR );

  VAR T : double;

  BEGIN

    (* Time in Julian centuries since J2000 *)

    T := ( X-51544.5 ) / 36525.0;

    (* Derivative of the state vector *)

    DYDX[1]:=Y[4]; DYDX[2]:=Y[5]; DYDX[3]:=Y[6];

    ACCEL ( T, Y[1],Y[2],Y[3], DYDX[4],DYDX[5],DYDX[6] );

  END;


(*-----------------------------------------------------------------------*)
(*                                                                       *)
(* INTRP: Interpolation routine for use with DE and STEP                 *)
(*                                                                       *)
(*   X      Independent variable                                         *)
(*   Y      Solution at X                                                *)
(*   XOUT   Independent variable for which the solution is requested     *)
(*   YOUT   Interpolated solution at XOUT                                *)
(*   YPOUT  Derivative at XOUT                                           *)
(*   NEQN   Number of differential equations                             *)
(*   KOLD   Auxiliary quantity (most recently used order)                *)
(*   PHI    Auxiliary quantity                                           *)
(*   PSI    Auxiliary quantity                                           *)
(*                                                                       *)
(* STEP approximates the solution of the differential equation near X by *)
(* a polynomial, which is evaluated by INTRP.                            *)
(*                                                                       *)
(* A detailed description of the method is given in                      *)
(*                                                                       *)
(*    L. F. Shampine, M. K. Gordon; Computer Solution of ordinary        *)
(*    Differential Equations; Freeman and Comp., San Francisco (1975).   *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)

PROCEDURE INTRP ( X              :  double;
                  Y              :  DE_EQN_VECTOR;
                  XOUT           :  double;
                  VAR YOUT,YPOUT :  DE_EQN_VECTOR;
                  NEQN,KOLD      :  INTEGER;
                  PHI            :  DE_PHI_ARRAY;
                  PSI            :  DE_12_VECTOR  );

  VAR I,J,JM1,KI,KIP1,L,LIMIT1 :  INTEGER;
      ETA,GAMMA,HI,PSIJM1      :  double;
      TEMP1,TEMP2,TEMP3,TERM   :  double;
      G,RHO,W                  :  DE_13_VECTOR;


  BEGIN

    G[1]   := 1.0;
    RHO[1] := 1.0;

    HI := XOUT - X;
    KI := KOLD + 1;
    KIP1 := KI + 1;

    (* Initialize W[*] for computing G[*] *)

    FOR I:=1 TO KI DO 
      BEGIN 
        TEMP1 := I;
        W[I] := 1.0/TEMP1;
      END;
    TERM := 0.0;

    (* compute G[*] *)

    FOR J:=2 TO KI DO
      BEGIN
        JM1 := J - 1;
        PSIJM1 := PSI[JM1];
        GAMMA := (HI + TERM )/PSIJM1;
        ETA := HI/PSIJM1;
        LIMIT1 := KIP1 - J;
        FOR I:=1 TO LIMIT1 DO  W[I] := GAMMA*W[I] - ETA*W[I+1];
        G[J] := W[1];
        RHO[J] := GAMMA*RHO[JM1];
        TERM := PSIJM1;
      END;

    (* Interpolate for the solution YOUT and for *)
    (* the derivative of the solution YPOUT      *)

    FOR L:=1 TO NEQN DO
      BEGIN
        YPOUT[L] := 0.0;
        YOUT[L]  := 0.0;
      END;

    FOR J:=1 TO KI DO
      BEGIN
        I := KIP1 - J;
        TEMP2 := G[I];
        TEMP3 := RHO[I];
        FOR L:=1 TO NEQN DO
          BEGIN
            YOUT[L]  := YOUT[L]  + TEMP2*PHI[L,I];
            YPOUT[L] := YPOUT[L] + TEMP3*PHI[L,I];
          END;
      END;

    FOR L:=1 TO NEQN DO  YOUT[L] := Y[L] + HI*YOUT[L];

  END; (* INTRP *)


(*-----------------------------------------------------------------------*)
(*                                                                       *)
(* STEP                                                                  *)
(*                                                                       *)
(* Basic integration routine for the variable order and stepsize code    *)
(* of Shampine and Gordon.                                               *)
(*                                                                       *)
(*                                                                       *)
(*   X                                                                   *)
(*   Y                                                                   *)
(*   F       Function to be integrated                                   *)
(*   NEQN    Number of differential equations                            *)
(*   H                                                                   *)
(*   EPS                                                                 *)
(*   WT                                                                  *)
(*   START                                                               *)
(*   HOLD                                                                *)
(*   K                                                                   *)
(*   KOLD                                                                *)
(*   CRASH   TRUE if STEP was aborted (tolerances too small)             *)
(*   PHI                                                                 *)
(*   P                                                                   *)
(*   YP                                                                  *)
(*   PSI                                                                 *)
(*   ALPHA                                                               *)
(*   BETA                                                                *)
(*   SIG                                                                 *)
(*   V                                                                   *)
(*   W                                                                   *)
(*   G                                                                   *)
(*   PHASE1                                                              *)
(*   NS                                                                  *)
(*   NORND                                                               *)
(*                                                                       *)
(*                                                                       *)
(* Note:                                                                 *)
(*                                                                       *)
(* Replace "F:DE_FUNC;" by                                               *)
(*   "PROCEDURE F(X:double;Y:DE_EQN_VECTOR;VAR YP:DE_EQN_VECTOR);"         *)
(* for use with standard Pascal.                                         *)
(*                                                                       *)
(* A detailed description of the method is given in                      *)
(*                                                                       *)
(*    L. F. Shampine, M. K. Gordon; Computer Solution of ordinary        *)
(*    Differential Equations; Freeman and Comp., San Francisco (1975).   *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)


PROCEDURE STEP ( VAR X              :  double;
                 VAR Y              :  DE_EQN_VECTOR;
              //   F                :  DE_FUNC;
                 VAR NEQN           :  INTEGER;
                 VAR H,EPS          :  double;
                 VAR WT             :  DE_EQN_VECTOR;
                 VAR START          :  BOOLEAN;
                 VAR HOLD           :  double;
                 VAR K,KOLD         :  INTEGER;
                 VAR CRASH          :  BOOLEAN;
                 VAR PHI            :  DE_PHI_ARRAY;
                 VAR P,YP           :  DE_EQN_VECTOR;
                 VAR PSI,ALPHA,BETA :  DE_12_VECTOR;
                 VAR SIG            :  DE_13_VECTOR;
                 VAR V,W            :  DE_12_VECTOR;
                 VAR G              :  DE_13_VECTOR;
                 VAR PHASE1         :  BOOLEAN;
                 VAR NS             :  INTEGER;
                 VAR NORND          :  BOOLEAN            );


  LABEL  999;   (* Error exit at end of procedure *)


  VAR I, IFAIL, IM1, IP1, IQ, J, KM1, KM2, KNEW, KP1, KP2  :  INTEGER;
      L, LIMIT1, LIMIT2, NSM2, NSP1, NSP2                  :  INTEGER;
      ABSH, ERK, ERKM1, ERKM2, ERKP1, ERR, HNEW            :  double;
      P5EPS, R, REALI, REALNS, RHO, ROUND, SUM, TAU, TEMP1 :  double;
      TEMP2, TEMP3, TEMP4, TEMP5, TEMP6, XOLD              :  double;
      TWO, GSTR                                            :  DE_13_VECTOR;
      SUCCESS                                              :  BOOLEAN;

  (* SIGN: computes sign(B)*abs(A) *)

  FUNCTION SIGN(A,B: double): double;
    BEGIN IF (B>=0.0) THEN SIGN:=ABS(A) ELSE SIGN:=-ABS(A); END;

  (* MIN: computes the minimum of A and B *)

  FUNCTION MIN(A,B: double): double;
    BEGIN IF A<B THEN MIN:=A ELSE MIN:=B; END;

  (* MAX: computes the maximum of A and B *)

  FUNCTION MAX(A,B: double): double;
    BEGIN IF A>B THEN MAX:=A ELSE MAX:=B; END;

  BEGIN (* STEP *)


    (* explicit initialization of arrays TWO and GSTR *)

    TWO[1]:=2.0;
    FOR I:=2 TO 13 DO TWO[I]:=2.0*TWO[I-1];

    GSTR[ 1]:=0.5;     GSTR[ 2]:=0.0833;  GSTR[ 3]:=0.0417;
    GSTR[ 4]:=0.0264;  GSTR[ 5]:=0.0188;  GSTR[ 6]:=0.0143;
    GSTR[ 7]:=0.0114;  GSTR[ 8]:=0.00936; GSTR[ 9]:=0.00789;
    GSTR[10]:=0.00679; GSTR[11]:=0.00592; GSTR[12]:=0.00524;
    GSTR[13]:=0.00468;


    (*                                                                   *)
    (* Begin block 0                                                     *)
    (*                                                                   *)
    (* Check if step size or error tolerance is too small for machine    *)
    (* precision.  If first step, initialize PHI array and estimate a    *)
    (* starting step size. If step size is too small, determine an       *)
    (* acceptable one.                                                   *)
    (*                                                                   *)

    IF ( ABS(H) < FOURU*ABS(X) ) THEN
      BEGIN
        H := SIGN(FOURU*ABS(X),H);
        CRASH := TRUE;
        GOTO 999;   (* Exit *)
      END;

    P5EPS := 0.5*EPS;
    CRASH := FALSE;
    G[1]  := 1.0;
    G[2]  := 0.5;
    SIG[1] := 1.0;

    IFAIL := 0;

    (* If error tolerance is too small, increase it to an *)
    (* acceptable value.                                  *)

    ROUND := 0.0;
    FOR L:=1 TO NEQN DO  ROUND := ROUND + (Y[L]*Y[L])/(WT[L]*WT[L]);
    ROUND := TWOU*SQRT(ROUND);
    IF P5EPS<ROUND THEN
      BEGIN
        EPS := 2.0*ROUND*(1.0+FOURU);
        CRASH := TRUE;
        GOTO 999;
      END;


    IF (START) THEN 

      BEGIN

        (* Initialize. Compute appropriate step size for first step. *)
 
        F2(X,Y,YP);
        SUM := 0.0;
        FOR L:=1 TO NEQN DO 
          BEGIN
            PHI[L,1] := YP[L];
            PHI[L,2] := 0.0;
            SUM := SUM + (YP[L]*YP[L])/(WT[L]*WT[L]);
          END; 
        SUM := SQRT(SUM);
        ABSH := ABS(H);
        IF (EPS<16.0*SUM*H*H) THEN ABSH:=0.25*SQRT(EPS/SUM);
        H := SIGN(MAX(ABSH,FOURU*ABS(X)),H);
        HOLD := 0.0;
        K := 1;
        KOLD := 0;
        START := FALSE;
        PHASE1 := TRUE;
        NORND := TRUE;
        IF (P5EPS<=100.0*ROUND) THEN
          BEGIN
            NORND := FALSE;
            FOR L:=1 TO NEQN DO PHI[L,15]:=0.0;
          END;

      END;

    (*                                                                   *)
    (* End block 0                                                       *)
    (*                                                                   *)


    (*                                                                   *)
    (* Repeat blocks 1, 2 (and 3) until step is successful               *)
    (*                                                                   *)

    REPEAT

      (*                                                                 *)
      (* Begin block 1                                                   *)
      (*                                                                 *)
      (* Compute coefficients of formulas for this step. Avoid computing *)
      (* those quantities not changed when step size is not changed.     *)
      (*                                                                 *)
  
      KP1 := K+1;
      KP2 := K+2;
      KM1 := K-1;
      KM2 := K-2;
  
      (* NS is the number of steps taken with size H, including the *)
      (* current one.  When K<NS, no coefficients change.           *)

      IF (H<>HOLD) THEN NS:=0;
      IF (NS<=KOLD) THEN NS:=NS+1;
      NSP1 := NS+1;


      IF (K>=NS) THEN

        BEGIN

          (* Compute those components of ALPHA[*],BETA[*],PSI[*],SIG[*] *)
          (* which are changed                                          *)

          BETA[NS] := 1.0;
          REALNS := NS;
          ALPHA[NS] := 1.0/REALNS;
          TEMP1 := H*REALNS;
          SIG[NSP1] := 1.0;
          IF (K>=NSP1) THEN
            FOR I:=NSP1 TO K DO
              BEGIN
                IM1 := I-1;
                TEMP2 := PSI[IM1];
                PSI[IM1] := TEMP1;
                BETA[I] := BETA[IM1]*PSI[IM1]/TEMP2;
                TEMP1 := TEMP2 + H;
                ALPHA[I] := H/TEMP1;
                REALI := I;
                SIG[I+1] := REALI*ALPHA[I]*SIG[I];
              END;
          PSI[K] := TEMP1;

          (* Compute coefficients G[*]; initialize V[*] and set W[*]. *)
  
          IF (NS>1)

            THEN
  
              BEGIN

                (* If order was raised, update diagonal part of V[*] *)

                IF (K>KOLD) THEN
                  BEGIN
                    TEMP4 := K*KP1;
                    V[K] := 1.0/TEMP4;
                    NSM2 := NS-2;
                    FOR J:=1 TO NSM2 DO
                      BEGIN
                        I := K-J;
                        V[I] := V[I] - ALPHA[J+1]*V[I+1];
                      END;
                  END;

                (* Update V[*] and set W[*] *)

                LIMIT1 := KP1 - NS;
                TEMP5 := ALPHA[NS];
                FOR IQ:=1 TO LIMIT1 DO
                  BEGIN
                    V[IQ] := V[IQ] - TEMP5*V[IQ+1];
                    W[IQ] := V[IQ];
                  END;
                G[NSP1] := W[1];

              END
  
            ELSE 
    
              FOR IQ:=1 TO K DO
                BEGIN
                  TEMP3 := IQ*(IQ+1);
                  V[IQ] := 1.0/TEMP3;
                  W[IQ] := V[IQ];
                END;

  
          (* Compute the G[*] in the work vector W[*] *)

          NSP2 := NS + 2;
          IF (KP1>=NSP2) THEN 
            FOR I:=NSP2 TO KP1 DO
              BEGIN
                LIMIT2 := KP2 - I;
                TEMP6 := ALPHA[I-1];
                FOR IQ:=1 TO LIMIT2 DO  W[IQ] := W[IQ] - TEMP6*W[IQ+1];
                G[I] := W[1];
              END;


        END; (* if K>=NS *)

      (*                                                                 *)
      (* End block 1                                                     *)
      (*                                                                 *)

  

      (*                                                                 *)
      (* Begin block 2                                                   *)
      (*                                                                 *)
      (* Predict a solution P[*], evaluate derivatives using predicted   *)
      (* solution, estimate local error at order K and errors at orders  *)
      (* K, K-1, K-2 as if constant step size were used.                 *)
      (*                                                                 *)

      (* Change PHI to PHI star *)
  
      IF (K>=NSP1) THEN
        FOR I:=NSP1 TO K DO
          BEGIN
            TEMP1 := BETA[I];
            FOR L:=1 TO NEQN DO PHI[L,I] := TEMP1*PHI[L,I];
          END;

      (* Predict solution and differences *)
  
      FOR L:=1 TO NEQN DO
        BEGIN
          PHI[L,KP2] := PHI[L,KP1];
          PHI[L,KP1] := 0.0;
          P[L] := 0.0;
        END;
      FOR J:=1 TO K DO
        BEGIN
          I := KP1 - J;
          IP1 := I+1;
          TEMP2 := G[I];
          FOR L:=1 TO NEQN DO
            BEGIN
              P[L] := P[L] + TEMP2*PHI[L,I];
              PHI[L,I] := PHI[L,I] + PHI[L,IP1];
            END;
        END;
      IF (NORND)
        THEN
          FOR L:=1 TO NEQN DO  P[L] := Y[L] + H*P[L]
        ELSE
          FOR L:=1 TO NEQN DO
            BEGIN
              TAU := H*P[L] - PHI[L,15];
              P[L] := Y[L] + TAU;
              PHI[L,16] := (P[L] - Y[L]) - TAU;
            END;
      XOLD := X;
      X := X + H;
      ABSH := ABS(H);
      F2(X,P,YP);

      (* Estimate errors at orders K,K-1,K-2 *)

      ERKM2 := 0.0;
      ERKM1 := 0.0;
      ERK := 0.0;
      FOR L:=1 TO NEQN DO
        BEGIN
          TEMP3 := 1.0/WT[L];
          TEMP4 := YP[L] - PHI[L,1];
          IF (KM2>0) THEN
             ERKM2 := ERKM2 + ((PHI[L,KM1]+TEMP4)*TEMP3)
                             *((PHI[L,KM1]+TEMP4)*TEMP3);
          IF (KM2>=0) THEN 
             ERKM1 := ERKM1 + ((PHI[L,K]+TEMP4)*TEMP3)
                             *((PHI[L,K]+TEMP4)*TEMP3);
          ERK := ERK + (TEMP4*TEMP3)*(TEMP4*TEMP3);
        END;
      IF (KM2>0) THEN ERKM2 := ABSH*SIG[KM1]*GSTR[KM2]*SQRT(ERKM2);
      IF (KM2>=0) THEN ERKM1 := ABSH*SIG[K]*GSTR[KM1]*SQRT(ERKM1);
      TEMP5 := ABSH*SQRT(ERK);
      ERR := TEMP5*(G[K]-G[KP1]);
      ERK := TEMP5*SIG[KP1]*GSTR[K];
      KNEW := K;

      (* Test if order should be lowered *)

      IF (KM2>0) THEN
        IF (MAX(ERKM1,ERKM2)<=ERK) THEN  KNEW:=KM1;
      IF (KM2=0) THEN 
        IF (ERKM1<=0.5*ERK) THEN KNEW:=KM1;

      (*                                                                 *)
      (* End block 2                                                     *)
      (*                                                                 *)



      (*                                                                 *)
      (* If step is successful continue with block 4, otherwise repeat   *)
      (* blocks 1 and 2 after executing block 3                          *)
      (*                                                                 *)
  
      SUCCESS := (ERR<=EPS);

  
      IF (NOT SUCCESS) THEN

        BEGIN

          (*                                                             *)
          (* Begin block 3                                               *)
          (*                                                             *)
          (* The step is unsuccessful. Restore X, PHI[*,*], PSI[*]. If   *)
          (* 3rd consecutive failure, set order to 1. If step fails more *)
          (* than 3 times, consider an optimal step size. Double error   *)
          (* tolerance and return if estimated step size is too small    *)
          (* for machine precision.                                      *)
          (*                                                             *)

          (* Restore X, PHI[*,*] and PSI[*] *)

          PHASE1 := FALSE;
          X := XOLD;
          FOR I:=1 TO K DO 
            BEGIN 
              TEMP1 := 1.0/BETA[I];
              IP1 := I+1;
              FOR L:=1 TO NEQN DO  PHI[L,I]:=TEMP1*(PHI[L,I]-PHI[L,IP1]);
            END;
          IF (K>=2) THEN 
            FOR I:=2 TO K DO  PSI[I-1] := PSI[I] - H;
      
          (* On third failure, set order to one. *)
          (* Thereafter, use optimal step size   *)

          IFAIL := IFAIL + 1;
          TEMP2 := 0.5;
          IF (IFAIL>3) THEN 
            IF (P5EPS < 0.25*ERK) THEN TEMP2 := SQRT(P5EPS/ERK);
          IF (IFAIL>=3) THEN  KNEW := 1;
          H := TEMP2*H;
          K := KNEW;
          IF (ABS(H)<FOURU*ABS(X)) THEN 
            BEGIN
              CRASH := TRUE;
              H := SIGN(FOURU*ABS(X),H);
              EPS := EPS + EPS;
              GOTO 999;   (* Exit *)
            END;

          (*                                                             *)
          (* End block 3, return to start of block 1                     *)
          (*                                                             *)
  
        END;  (* end if(successful) *)


    UNTIL (SUCCESS);



    (*                                                                   *)
    (* Begin block 4                                                     *)
    (*                                                                   *)
    (* The step is successful. Correct the predicted solution, evaluate  *)
    (* the derivatives using the corrected solution and update the       *)
    (* differences. Determine best order and step size for next step.    *)
    (*                                                                   *)

    KOLD := K;
    HOLD := H;

    (* Correct and evaluate *)

    TEMP1 := H*G[KP1];
    IF (NORND)
      THEN
        FOR L:=1 TO NEQN DO  Y[L] := P[L] + TEMP1*(YP[L] - PHI[L,1])
      ELSE
        FOR L:=1 TO NEQN DO
          BEGIN
            RHO := TEMP1*(YP[L] - PHI[L,1]) - PHI[L,16];
            Y[L] := P[L] + RHO;
            PHI[L,15] := (Y[L] - P[L]) - RHO;
          END;
    F2(X,Y,YP);

    (* Update differences for next step *)

    FOR L:=1 TO NEQN DO
      BEGIN
        PHI[L,KP1] := YP[L] - PHI[L,1];
        PHI[L,KP2] := PHI[L,KP1] - PHI[L,KP2];
      END;
    FOR I:=1 TO K DO
      FOR L:=1 TO NEQN DO
        PHI[L,I] := PHI[L,I] + PHI[L,KP1];

    (* Estimate error at order K+1 unless               *)
    (* - in first phase when always raise order,        *)
    (* - already decided to lower order,                *)
    (* - step size not constant so estimate unreliable  *)

    ERKP1 := 0.0;
    IF ( (KNEW=KM1) OR (K=12) ) THEN  PHASE1:=FALSE;

    IF ( PHASE1 )

      THEN

        BEGIN
          K := KP1;
          ERK := ERKP1;
        END

      ELSE

        BEGIN

          IF ( KNEW=KM1 ) 

            THEN  (* lower order *)

              BEGIN
                K := KM1;
                ERK := ERKM1;
              END

            ELSE

              IF ( KP1<=NS ) THEN
                BEGIN
                  FOR L:=1 TO NEQN DO
                    ERKP1 := ERKP1 + (PHI[L,KP2]/WT[L])*(PHI[L,KP2]/WT[L]);
                  ERKP1 := ABSH*GSTR[KP1]*SQRT(ERKP1);
                  (* Using estimated error at order K+1, determine *)
                  (* appropriate order for next step               *)
                  IF (K>1)
                    THEN
                      IF ( ERKM1<=MIN(ERK,ERKP1)) 
                        THEN  (* lower order *)
                          BEGIN K:=KM1; ERK:=ERKM1 END
                        ELSE
                          BEGIN
                            IF ( (ERKP1<ERK) AND (K<>12) ) THEN
                               (* raise order *)
                               BEGIN K:=KP1; ERK:=ERKP1; END;
                          END
                    ELSE
                      IF ( ERKP1<0.5*ERK) THEN  (* raise order *)
                        BEGIN
                          (* Here ERKP1 < ERK < max(ERKM1,ERKM2) else    *)
                          (* order would have been lowered in block 2.   *)
                          (* Thus order is to be raised                  *)
                          K := KP1;
                          ERK := ERKP1;
                        END;
                  (* end if  K>1 *)
                END; (* if KP1<=NS *)

             (* end if KNEW=KM1 *)

        END;  (* if PHASE1 *)
 

    (* With new order determine appropriate step size for next step *)

    IF ( (PHASE1) OR (P5EPS>=ERK*TWO[K+1]) )
      THEN
        HNEW := H + H
      ELSE
        BEGIN
          IF ( P5EPS<ERK ) 
            THEN
              BEGIN
                TEMP2 := K+1;
                R := EXP ( LN(P5EPS/ERK) * (1.0/TEMP2) );
                HNEW := ABSH*MAX(0.5,MIN(0.9,R));
                HNEW := SIGN(MAX(HNEW,FOURU*ABS(X)),H);
              END
            ELSE
              HNEW := H;
        END;

    H := HNEW;


    (*                                                                   *)
    (* End block 4                                                       *)
    (*                                                                   *)


  999:

  END;  (* STEP *)


(*-----------------------------------------------------------------------*)
(*                                                                       *)
(* DE                                                                    *)
(*                                                                       *)
(* Driver routine for the variable order and step size Adams-Bashforth-  *)
(* Moulton method of Shampine and Gordon.                                *)
(*                                                                       *)
(*   F       Function to be integrated                                   *)
(*   NEQN    Number of differential equations                            *)
(*   Y       State vector                                                *)
(*   T       Time                                                        *)
(*   TOUT    Output time                                                 *)
(*   RELERR  Relative tolerance                                          *)
(*   ABSERR  Absolute tolerance                                          *)
(*   IFLAG   Return code                                                 *)
(*   WORK    Work area for global storage between subsequent calls       *)
(*                                                                       *)
(* Note:                                                                 *)
(*                                                                       *)
(* Subroutine DE is used for the numerical integration of an ordinary    *)
(* differential equation y'=f(x,y) of first order, which must be         *)
(* provided as a subroutine of the form                                  *)
(*   PROCEDURE F ( X: double; Y: DE_EQN_VECTOR; VAR YP: DE_EQN_VECTOR );   *)
(* Aside from DE itself the subroutines STEP and INTRP as well as some   *)
(* global constant and type definitions are required, which are          *)
(* described in detail in DELIB.PAS.                                     *)
(*                                                                       *)
(* On the first call of DE the initial time is passed in T, while Y      *)
(* contains the corresponding state vector. Furthermore the desired      *)
(* output time TOUT and the required relative and absolute accuracy      *)
(* RELERR and ABSERR need to be specified. The status variable IFLAG     *)
(* is set to 1 to inform DE that the integration of a new problem is     *)
(* started.                                                              *)
(*                                                                       *)
(* In normal cases the variable Y subsequently contains the state vector *)
(* at time TOUT. Simultaneously T is assigned the value TOUT, while the  *)
(* status flag IFLAg is set to 2 (successful step). In all continuation  *)
(* steps it is only required for the user to specify a new value TOUT,   *)
(* while all remaining variables (most notably IFLAG) are left           *)
(* unchanged. IFLAG needs only be reset to one in case of a new problem  *)
(* or when changing the direction of integration.                        *)
(*                                                                       *)
(* If DE returns a value of IFLAG different from 2, one of the following *)
(* cases may have occured:                                               *)
(*                                                                       *)
(*   IFLAG = 3  TOUT has not been reached, since the requested           *)
(*              tolerance RELERR or ABSERR was too small. Both           *)
(*              values have been increased for subsequent                *)
(*              computations.                                            *)
(*   IFLAG = 4  TOUT has not been reached, since more than               *)
(*              MAXNUM=500 steps have been required internally.          *)
(*   IFLAG = 5  TOUT has not been reached, since the differential        *)
(*              equation appears to be stiff. This should not happen     *)
(*              when applying DE to problems in celestial mechanics.     *)
(*   IFLAG = 6  Illegal input parameter (e.g. T=TOUT)                    *)
(*                                                                       *)
(* In all cases except IFLAG=6 the integration may simply be continued   *)
(* by calling DE again without changing any parmeter. The interruption   *)
(* is mainly intended to call the user's attention to possible problems  *)
(* that may have occured and e.g. avoid infinite integrations.           *)
(*                                                                       *)
(* The work array WORK is used to store various quantities between       *)
(* subsequent calls of DE and is not changed by the user.                *)
(*                                                                       *)
(* Note that "F:DE_FUNC;" in the specification of DE has to be replaced  *)
(* by "PROCEDURE F(X:double;Y:DE_EQN_VECTOR;VAR YP:DE_EQN_VECTOR);" for    *)
(* use with standard Pascal.                                             *)
(*                                                                       *)
(* A detailed description of the method and its Fortran implementation   *)
(* is given in                                                           *)
(*                                                                       *)
(*  - Shampine L.F., Gordon M.K.: Computer solution of ordinary          *)
(*    Differential Equations; Freeman and Comp., San Francisco (1975).   *)
(*  - Shampine L.F., Watts H.A.: DEPAC - Design of a user oriented       *)
(*    package of ODE solvers; SAND79-2374, Sandia Laboratories (1979).   *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)

PROCEDURE DE (  //F                  :  DE_FUNC;            (* Turbo Pascal *){see above}
               NEQN               :  INTEGER;
               VAR Y              :  DE_EQN_VECTOR;
               VAR T,TOUT         :  double;
               VAR RELERR,ABSERR  :  double;
               VAR IFLAG          :  INTEGER;
               VAR WORK           :  DE_WORKSPACE_RECORD );

  LABEL 99;     (* Error exit at end of procedure *)


  CONST MAXNUM = 500;  (* Maximum number of steps *)


  VAR STIFF, CRASH                           :  BOOLEAN;
      ISN, NOSTEP, KLE4, L                   :  INTEGER;
      RELEPS, ABSEPS, TEND, ABSDEL, DEL, EPS :  double;


  (* SIGN: computes sign(B)*abs(A) *)

  FUNCTION SIGN(A,B: double): double;
    BEGIN IF (B>=0.0) THEN SIGN:=ABS(A) ELSE SIGN:=-ABS(A); END;

  (* MIN: computes the minimum of A and B *)

  FUNCTION MIN(A,B: double): double;
    BEGIN IF A<B THEN MIN:=A ELSE MIN:=B; END;

  (* MAX: computes the maximum of A and B *)

  FUNCTION MAX(A,B: double): double;
    BEGIN IF A>B THEN MAX:=A ELSE MAX:=B; END;

  BEGIN

    WITH WORK DO   (* Use short form of record component name *)

      BEGIN

        (* Test for invalid parameters *)

        EPS   := MAX(RELERR,ABSERR);
        ISN   := TRUNC ( SIGN(1.1,IFLAG) );  (* should be +/- 1 *)
        IFLAG := ABS(IFLAG);

        IF ( ( NEQN   < 1   ) OR ( T      = TOUT ) OR
             ( RELERR < 0.0 ) OR ( ABSERR < 0.0  ) OR ( EPS = 0.0 ) OR
             ( IFLAG  = 0   ) OR ( IFLAG  > 5    ) OR
             ( (IFLAG<>1) AND (T<>TOLD) )               )  THEN

          BEGIN

            IFLAG:=6;  (* Set error code *)
            GOTO 99;   (* Exit           *)

          END;


        (* Set interval limits and step counter *)

        DEL    := TOUT - T;
        ABSDEL := ABS(DEL);
        TEND   := T + 10.0*DEL;
        IF (ISN<0) THEN  TEND:=TOUT;
        NOSTEP := 0;
        KLE4   := 0;
        STIFF  := FALSE;
        RELEPS := RELERR/EPS;
        ABSEPS := ABSERR/EPS;

        IF ( (IFLAG=1) OR (ISNOLD<0) OR (DELSGN*DEL<=0.0) ) THEN

          BEGIN

            (* Set independent and dependent variables X and YY[*] for  *)
            (* steps. Set sign of integration direction. Initialize the *)
            (* step size.                                               *)

            START:=TRUE;
            X := T;
            FOR L:=1 TO NEQN DO YY[L]:=Y[L];
            DELSGN := SIGN(1.0,DEL);
            H := SIGN(MAX(FOURU*ABS(X),ABS(TOUT-X)),TOUT-X);

          END;


        REPEAT

          (* If already past output point, interpolate and return *)

          IF (ABS(X-T)>=ABSDEL) THEN
            BEGIN
              INTRP(X,YY,TOUT,Y,YPOUT,NEQN,KOLD,PHI,PSI);
              IFLAG := 2;
              T := TOUT;
              TOLD := T;
              ISNOLD := ISN;
              GOTO 99;     (* Exit *)
             END;

          (* If cannot go past TSTOP and sufficiently close, *)
          (* extrapolate and return                          *)

          IF ( (ISN<=0) AND (ABS(TOUT-X)<FOURU*ABS(X)) ) THEN
            BEGIN
              H := TOUT - X;
              F2(X,YY,YP);
              FOR L:=1 TO NEQN DO Y[L]:=YY[L]+H*YP[L];
              IFLAG := 2;
              T := TOUT;
              TOLD := T;
              ISNOLD := ISN;
              GOTO 99;       (* Exit *)
            END;
          
          (* Monitor number of steps attempted *)

          IF (NOSTEP>=MAXNUM) THEN
            (* a large amount of work has been expended *)
            BEGIN
              IFLAG := ISN*4;
              IF (STIFF) THEN  IFLAG:=ISN*5;
              FOR L:=1 TO NEQN DO  Y[L]:=YY[L];
              T := X;
              TOLD := T;
              ISNOLD := 1;
              GOTO 99;     (* Exit *)
            END;

          (* Limit step size, set weight vector and take a step *)

          H := SIGN(MIN(ABS(H),ABS(TEND-X)),H);
          FOR L:=1 TO NEQN DO  WT[L]:=RELEPS*ABS(YY[L])+ABSEPS;

          STEP ( X,YY{,F},NEQN,H,EPS,WT,START,
                 HOLD,K,KOLD,CRASH,PHI,P,YP,PSI,
                 ALPHA,BETA,SIG,V,W,G,PHASE1,NS,NORND );
          
          IF (CRASH) THEN   (* Tolerances too small *)
            BEGIN
              IFLAG   := ISN*3;
              RELERR  := EPS*RELEPS;
              ABSERR  := EPS*ABSEPS;
              FOR L:=1 TO NEQN DO Y[L]:=YY[L];
              T := X;
              TOLD   := T;
              ISNOLD := 1;
              GOTO 99;       (* Exit *)
            END;

          (* Stiffness test:                                  *)
          (* count number of consecutive steps taken with the *)
          (* order of the method being less or equal to four  *)

          NOSTEP := NOSTEP+1;
          KLE4   := KLE4+1;
          IF ( KOLD >   4 ) THEN KLE4:=0;
          IF ( KLE4 >= 50 ) THEN STIFF:=TRUE;

        UNTIL FALSE;
      

      END; (* with WORK do *)

  99:

  END;{DE}




(*-----------------------------------------------------------------------*)
(*                                                                       *)
(* INTEGRATE: Integrates the equation of motion                          *)
(*                                                                       *)
(*   Y        State vector (x,y,z in AU, vx,vy,vz in AU/d)               *)
(*   MJD      Epoch (Modified Julian Date)                               *)
(*   MJD_END  Final epoch (Modified Julian Date)                         *)
(*   IFLAG    Return code                                                *)
(*   WORK     Work space                                                 *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)

PROCEDURE INTEGRATE ( VAR Y            : DE_EQN_VECTOR;
                      VAR MJD, MJD_END : double;
                      VAR IFLAG        : INTEGER;
                      VAR WORK         : DE_WORKSPACE_RECORD );

  CONST EPS = 1.0E-8;  (* Accuracy *)

  VAR   RELERR, ABSERR: double;

  BEGIN

    RELERR := EPS;    (* Relative accuracy requirement *)
    ABSERR := 0.0;    (* Absolute accuracy requirement *)

    IF ( MJD_END <> MJD ) THEN
      BEGIN
        REPEAT
          DE ({ F,} 6, Y, MJD, MJD_END, RELERR,ABSERR, IFLAG, WORK );
        UNTIL ((ABS(IFLAG)=2) OR (IFLAG=6));
        IF (IFLAG=6) THEN Error_message:='Illegal input in DE';
                           // WRITELN (' Illegal input in DE ');
      END;

  END;

(*-----------------------------------------------------------------------*)
(*                                                                       *)
(* XYZKEP: conversion of the state vector into Keplerian elements        *)
(*         for elliptical orbits                                         *)
(*                                                                       *)
(*  X,Y,Z    : Position [AU]                                             *)
(*  VX,VY,VZ : Velocity [AU/d]                                           *)
(*  AX       : Semi-major axis [AU]                                      *)
(*  ECC      : Eccentricity                                              *)
(*  INC      : Inclination [deg]                                         *)
(*  LAN      : Longitude of the ascending node [deg]                     *)
(*  AOP      : Argument of perihelion [deg]                              *)
(*  MA       : Mean anomaly [deg]                                        *)
(*                                                                       *)
(*-----------------------------------------------------------------------*)

PROCEDURE XYZKEP ( X,Y,Z, VX,VY,VZ           :  double;
                   VAR AX,ECC,INC,LAN,AOP,MA :  double );

  CONST DEG    = 57.29577951308;    (* Conversion from radian to degrees *)
        KGAUSS =  0.01720209895;    (* Gaussian gravitational constant   *)

  VAR   HX,HY,HZ,H, R,V2    : double;
        GM, C,S,E2, EA,U,NU : double;

  BEGIN

    HX := Y*VZ-Z*VY;                               (* Areal velocity     *)
    HY := Z*VX-X*VZ;
    HZ := X*VY-Y*VX;
    H  := SQRT ( HX*HX + HY*HY + HZ*HZ );

    LAN := ATN2 ( HX, -HY );                       (* Long. ascend. node *)
    INC := ATN2 ( SQRT(HX*HX+HY*HY), HZ );         (* Inclination        *)
    U   := ATN2 ( Z*H, -X*HY+Y*HX );               (* Arg. of latitude   *)

    GM := KGAUSS*KGAUSS;
    R  := SQRT ( X*X + Y*Y + Z*Z );                (* Distance           *)
    V2 := VX*VX + VY*VY + VZ*VZ;                   (* Velocity squared   *)

    AX := 1.0 / (2.0/R-V2/GM);                     (* Semi-major axis    *)

    C  := 1.0-R/AX;                                (* e*cos(E)           *)
    S  := (X*VX+Y*VY+Z*VZ)/(SQRT(AX)*KGAUSS);      (* e*sin(E)           *)

    E2  := C*C + S*S;
    ECC := SQRT ( E2 );                            (* Eccentricity       *)
    EA  := ATN2 ( S, C );                          (* Eccentric anomaly  *)

    MA  := EA - S*DEG;                             (* Mean anomaly       *)

    NU  := ATN2 ( SQRT(1.0-E2)*S, C-E2 );          (* True anomaly       *)
    AOP := U - NU;                                 (* Arg. of perihelion *)

    IF (LAN<0.0) THEN LAN:=LAN+360.0;
    IF (AOP<0.0) THEN AOP:=AOP+360.0;
    IF (MA <0.0) THEN MA :=MA +360.0;

  END;
(*----------------------------------------------------------------------*)
(* CALDAT: Finds the civil calendar date for a given value              *)
(*         of the Modified Julian Date (MJD).                           *)
(*         Julian calendar is used up to 1582 October 4,                *)
(*         Gregorian calendar is used from 1582 October 15 onwards.     *)
(*----------------------------------------------------------------------*)
PROCEDURE CALDAT(MJD:double; VAR DAY,MONTH,YEAR:INTEGER;VAR HOUR:double);
  VAR B,D,F     : INTEGER;
      JD,JD0,C,E: double;
  BEGIN
    JD  := MJD + 2400000.5;
    (* JD0 := TRUNC(JD+0.5);      *)    (* Standard Pascal  *)
       JD0 := INT(JD+0.5);              (* TURBO Pascal     *)
    (* JD0 := LONG_TRUNC(JD+0.5); *)    (* ST Pascal plus   *)
    IF (JD0<2299161.0)                            (* calendar:    *)
      THEN BEGIN C:=JD0+1524.0 END                (* -> Julian    *)
      ELSE BEGIN                                  (* -> Gregorian *)
             B:=TRUNC((JD0-1867216.25)/36524.25);
             C:=JD0+(B-TRUNC(B/4))+1525.0
           END;
    D    := TRUNC((C-122.1)/365.25);          E     := 365.0*D+TRUNC(D/4);
    F    := TRUNC((C-E)/30.6001);
    DAY  := TRUNC(C-E+0.5)-TRUNC(30.6001*F);  MONTH := F-1-12*TRUNC(F/14);
    YEAR := D-4715-TRUNC((7+MONTH)/10);       HOUR  := 24.0*(JD+0.5-JD0);
  END;


Function doubletostr(x:double;length3,decim:integer):string;{double to string}
var s: string[40];
begin
  str(x:length3:decim,s);
  doubletostr:=s;
end;
Function inttostr(x, length3:integer):string; {integer to string}
var s: string[40];
begin
  str(x:length3,s);
  inttostr:=s;
end;

(*-----------------------------------------------------------------------*)
(* DMS: conversion of degrees and fractions of a degree                  *)
(*      into degrees, minutes and seconds                                *)
(*-----------------------------------------------------------------------*)
FUNCTION DMS2(DD:double):STRING;
  VAR D1:double;
      D,M:INTEGER;
       S:double;
       ST,st2: STRING[20];
  BEGIN
    D1:=ABS(DD);  D:=TRUNC(D1);
    D1:=(D1-D)*60.0;  M:=TRUNC(D1);  S:=(D1-M)*60.0;
    IF (DD<0) THEN
      IF (D<>0) THEN D:=-D ELSE IF (M<>0) THEN M:=-M ELSE S:=-S;

      str(D:2,sT);
      str(M:2,sT2);
      ST:=ST+':'+st2;
      str(S:6:4,sT2);
      ST:=ST+' '+st2;
    DMS2:=ST
  END;


FUNCTION NUMINT_ASTEROID(Year,Month:integer; Day1, SMA, ECC, INC, LOA, AOP, MA, Equinox_old:double; Year_new, Month_new:integer; Day_new, Equinox_new: double): STRING;{calculates new  orbital elements  for  asteroids}
BEGIN
  Error_message:='';{2013}
  DAY:=TRUNC(Day1); HOUR:=24.0*(Day1-DAY);
  T_EPOCH := ( MJD(DAY,MONTH,YEAR,HOUR) - 51544.5) / 36525.0;  {old epoch}
  Equinox_old := (Equinox_old-2000.0)/100.0;
  GAUSVEC(LOA,INC,AOP,PQR);


  T1 :=  (  MJD(trunc(day_new),month_new,year_new,24*frac(day_new) {HOUR}) - 51544.5 ) / 36525.0;{new epoch}

    TEQX := (Equinox_new-2000.0)/100.0;


  (* Calculate precession matrices *)

  PMATECL (Equinox_old,J2000,EQX0_TO_J2000);
  PMATECL (J2000,TEQX,J2000_TO_EQX);

  (* Heliocentric position and velocity vector at epoch *)
  (* referred to ecliptic and equinox of J2000          *)

  ELLIP  ( MA,SMA,ECC, XX,YY,VX,VY );
  ORBECL ( XX,YY,PQR, Y[1],Y[2],Y[3] );
  ORBECL ( VX,VY,PQR, Y[4],Y[5],Y[6] );

  PRECART ( EQX0_TO_J2000,Y[1],Y[2],Y[3] );
  PRECART ( EQX0_TO_J2000,Y[4],Y[5],Y[6] );


  (* Start integration: propagate state vector from epoch *)
  (* to start of ephemeris                                *)

  MJD_START := T_EPOCH*36525.0 + 51544.5;
  MJD_END   := T1*36525.0 + 51544.5;

  IFLAG     := 1;   (* Initialization flag *)

  INTEGRATE ( Y, MJD_START, MJD_END, IFLAG, WORK );


  (* Orbital elements at start of ephemeris *)

  XX:=Y[1]; YY:=Y[2]; ZZ:=Y[3];    (* Copy J2000 state vector *)
  VX:=Y[4]; VY:=Y[5]; VZ:=Y[6];

  PRECART (J2000_TO_EQX,XX,YY,ZZ);              (* Precession *)
  PRECART (J2000_TO_EQX,VX,VY,VZ);

  XYZKEP ( XX,YY,ZZ,VX,VY,VZ, SMA,ECC,INC,LOA,AOP,MA ); (* Convert *)


  CALDAT (MJD_END,DAY,MONTH,YEAR,HOUR);

//;                     yyyy mm dd.ddd    e        a [ae]     i       ohm         w     [yyyy]             H     G    next time
//;--------------------+--------------+--------- +--------+--------+---------+---------+-----+----------+-----+-----
//     1 Ceres         |2010 07 23.000|0.079138  |2.765349| 10.5868| 80.3932 | 72.5898 | 2000|113.4105  | 3.34| 0.12|   0.00
//     2 Pallas        |2010 07 23.000|0.231000  |2.772153| 34.8409|173.1295 |310.1509 | 2000| 96.1483  | 4.13| 0.11|   0.00
//     3 Juno          |2008 11 30.000|0.255933  |2.672153| 12.9680|169.9608 |247.9335 | 2000|256.8166  | 5.33| 0.32|   0.00


  NUMINT_ASTEROID:=(Error_message+Formatfloat('0000',year)+' '+Formatfloat('00',month)+' '+Formatfloat('00.000',DAY+HOUR/24)+'|'+Formatfloat('0.0000000',ECC)+'|'+Formatfloat('0.0000000',SMA)+'|'+Formatfloat('00.00000',INC)+
                                       '|'+Formatfloat('000.00000',lOA){ohm}+'|'+Formatfloat('000.00000',aop)+'|'+Formatfloat('0000',Equinox_new)+'|'+Formatfloat('000.00000',ma) );
{testinput according book}
//  (NUMINT_ASTEROID(1983,09,23.0, {OLD EPOCH}
//                   2.7657991,    {a}
//                   0.0785650,    {e}
//                  10.60646,      {i}
//                  80.05225,      {ohm}
//                  73.07274,      {w}
//                 174.19016,      {anomoly}
//                 1950.0,         {old equinox}
//                 1992,           {new epoch}
//                 06,
//                 27.000,
//                 2000.0    {new equinox}
//                     ));


END;

end.
