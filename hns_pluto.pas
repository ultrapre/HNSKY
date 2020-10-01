UNIT hns_pluto;

{Software code is Copyright (C) 1998 by Springer-Nature, Berlin Heidelberg and originates the code described in the book Astronomy on the Personal Computer,
 ISBN 3-540-63521-1 3rd edition 1998. Authors Oliver Montenbruck and Thomas Pleger.
 Reproduced with written permission of SNCSC (Springer-Nature) dated 2019-3-27 under the conditions specified in the letter below.

Modified by Johannes (Han) Kleijn, www.hnsky.org email: han.k.. at...hnsky.org

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


INTERFACE

PROCEDURE PLU200(T:double;VAR L,B,R:double);

IMPLEMENTATION

(*-----------------------------------------------------------------------*)
(* PLU200: Pluto; ecliptic coordinates L,B,R (in deg and AU)             *)
(*         equinox of date; only valid between 1890 and 2100!!           *)
(*         (T: time in Julian centuries since J2000)                     *)
(*         (   = (JED-2451545.0)/36525             )                     *)
(*-----------------------------------------------------------------------*)
PROCEDURE PLU200(T:double;VAR L,B,R:double);

  CONST P2=6.283185307;
  VAR C9,S9:    ARRAY [ 0..6] OF double;
      C,S:      ARRAY [-3..2] OF double;
      M5,M6,M9: double;
      DL,DR,DB: double;
      I:        INTEGER;

  FUNCTION FRAC(X:double):double;
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1.0; FRAC:=X  END;

  PROCEDURE ADDTHE(C1,S1,C2,S2:double; VAR C,S:double);
    BEGIN  C:=C1*C2-S1*S2; S:=S1*C2+C1*S2; END;

  PROCEDURE TERM(I9,I:INTEGER;DLC,DLS,DRC,DRS,DBC,DBS:double);
    VAR U,V: double;
    BEGIN
      ADDTHE(C9[I9],S9[I9],C[I],S[I],U,V);
      DL:=DL+DLC*U+DLS*V; DR:=DR+DRC*U+DRS*V; DB:=DB+DBC*U+DBS*V;
    END;

  PROCEDURE PERTJUP;  (* Kepler terms and perturbations by Jupiter *)
    VAR I: INTEGER;
    BEGIN
      C[0]:=1.0; S[0]:=0.0;  C[1]:=COS(M5); S[1]:=SIN(M5);
      FOR I:=0 DOWNTO -1 DO ADDTHE(C[I],S[I],C[1],-S[1],C[I-1],S[I-1]);
      ADDTHE(C[1],S[1],C[1],S[1],C[2],S[2]);
      TERM(1, 0,   0.06,100924.08,-960396.0,15965.1,51987.68,-24288.76);
      TERM(2, 0,3274.74, 17835.12,-118252.2, 3632.4,12687.49, -6049.72);
      TERM(3, 0,1543.52,  4631.99, -21446.6, 1167.0, 3504.00, -1853.10);
      TERM(4, 0, 688.99,  1227.08,  -4823.4,  213.5, 1048.19,  -648.26);
      TERM(5, 0, 242.27,   415.93,  -1075.4,  140.6,  302.33,  -209.76);
      TERM(6, 0, 138.41,   110.91,   -308.8,  -55.3,  109.52,   -93.82);
      TERM(3,-1,  -0.99,     5.06,    -25.6,   19.8,    1.26,    -1.96);
      TERM(2,-1,   7.15,     5.61,    -96.7,   57.2,    1.64,    -2.16);
      TERM(1,-1,  10.79,    23.13,   -390.4,  236.4,   -0.33,     0.86);
      TERM(0, 1,  -0.23,     4.43,    102.8,   63.2,    3.15,     0.34);
      TERM(1, 1,  -1.10,    -0.92,     11.8,   -2.3,    0.43,     0.14);
      TERM(2, 1,   0.62,     0.84,      2.3,    0.7,    0.05,    -0.04);
      TERM(3, 1,  -0.38,    -0.45,      1.2,   -0.8,    0.04,     0.05);
      TERM(4, 1,   0.17,     0.25,      0.0,    0.2,   -0.01,    -0.01);
      TERM(3,-2,   0.06,     0.07,     -0.6,    0.3,    0.03,    -0.03);
      TERM(2,-2,   0.13,     0.20,     -2.2,    1.5,    0.03,    -0.07);
      TERM(1,-2,   0.32,     0.49,     -9.4,    5.7,   -0.01,     0.03);
      TERM(0,-2,  -0.04,    -0.07,      2.6,   -1.5,    0.07,    -0.02);
    END;

  PROCEDURE PERTSAT;  (* perturbations by Saturn *)
    VAR I: INTEGER;
    BEGIN
      C[1]:=COS(M6); S[1]:=SIN(M6);
      FOR I:=0 DOWNTO -1 DO ADDTHE(C[I],S[I],C[1],-S[1],C[I-1],S[I-1]);
      TERM(1,-1, -29.47,    75.97,   -106.4, -204.9,  -40.71,   -17.55);
      TERM(0, 1, -13.88,    18.20,     42.6,  -46.1,    1.13,     0.43);
      TERM(1, 1,   5.81,   -23.48,     15.0,   -6.8,   -7.48,     3.07);
      TERM(2, 1, -10.27,    14.16,     -7.9,    0.4,    2.43,    -0.09);
      TERM(3, 1,   6.86,   -10.66,      7.3,   -0.3,   -2.25,     0.69);
      TERM(2,-2,   4.32,     2.00,      0.0,   -2.2,   -0.24,     0.12);
      TERM(1,-2,  -5.04,    -0.83,     -9.2,   -3.1,    0.79,    -0.24);
      TERM(0,-2,   4.25,     2.48,     -5.9,   -3.3,    0.58,     0.02);
    END;

  PROCEDURE PERTJUS;  (* perturbations by Jupiter and Saturn *)
    VAR PHI,X,Y: double;
    BEGIN
      PHI:=(M5-M6); X:=COS(PHI); Y:=SIN(PHI);
      DL:=DL-9.11*X+0.12*Y; DR:=DR-3.4*X-3.3*Y; DB:=DB+0.81*X+0.78*Y;
      ADDTHE(X,Y,C9[1],S9[1],X,Y);
      DL:=DL+5.92*X+0.25*Y; DR:=DR+2.3*X-3.8*Y; DB:=DB-0.67*X-0.51*Y;
    END;

  PROCEDURE PREC(T:double;VAR L,B:double); (* precess. 1950->equinox of date *)
    CONST DEG=57.2957795;
    VAR D,PPI,PI,P,C1,S1,C2,S2,C3,S3,X,Y,Z: double;
    BEGIN
      D:=T+0.5; L:=L/DEG; B:=B/DEG;
      PPI:=3.044; PI:=2.28E-4*D; P:=(0.0243764+5.39E-6*D)*D;
      C1:=COS(PI); C2:=COS(B); C3:=COS(PPI-L);
      S1:=SIN(PI); S2:=SIN(B); S3:=SIN(PPI-L);
      X:=C2*C3; Y:=C1*C2*S3-S1*S2; Z:=S1*C2*S3+C1*S2;
      B := DEG * ARCTAN( Z / SQRT((1.0-Z)*(1.0+Z)) );
      IF (X>0) THEN L:=360.0*FRAC((PPI+P-ARCTAN(Y/X))/P2)
               ELSE L:=360.0*FRAC((PPI+P-ARCTAN(Y/X))/P2+0.5);
    END;

  BEGIN  (* PLU200 *)

    DL:=0.0; DR:=0.0; DB:=0.0;
    M5:=P2*FRAC(0.0565314+8.4302963*T); M6:=P2*FRAC(0.8829867+3.3947688*T);
    M9:=P2*FRAC(0.0385795+0.4026667*T);
    C9[0]:=1.0; S9[0]:=0.0;  C9[1]:=COS(M9); S9[1]:=SIN(M9);
    FOR I:=2 TO 6 DO ADDTHE(C9[I-1],S9[I-1],C9[1],S9[1],C9[I],S9[I]);
    PERTJUP; PERTSAT; PERTJUS;
    L:= 360.0*FRAC( 0.6232469 + M9/P2 + DL/1296.0E3 );
    R:= 40.7247248  +  DR * 1.0E-5;
    B:= -3.909434  +  DB / 3600.0;
    PREC(T,L,B);

  END;   (* PLU200 *)

END.
