UNIT hns_saturn;

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

PROCEDURE SAT200(T:double;VAR L,B,R:double);

IMPLEMENTATION

(*-----------------------------------------------------------------------*)
(* SAT200: Saturn; ecliptic coordinates L,B,R (in deg and AU)            *)
(*         equinox of date                                               *)
(*         (T: time in Julian centuries since J2000)                     *)
(*         (   = (JED-2451545.0)/36525             )                     *)
(*-----------------------------------------------------------------------*)
PROCEDURE SAT200(T:double;VAR L,B,R:double);
  CONST P2=6.283185307;
  VAR C6,S6:         ARRAY [ 0..11] OF double;
      C,S:           ARRAY [-6.. 1] OF double;
      M5,M6,M7,M8:   double;
      U,V, DL,DR,DB: double;
      I:             INTEGER;

  FUNCTION FRAC(X:double):double;
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1.0; FRAC:=X  END;

  PROCEDURE ADDTHE(C1,S1,C2,S2:double; VAR C,S:double);
    BEGIN  C:=C1*C2-S1*S2; S:=S1*C2+C1*S2; END;

  PROCEDURE TERM(I6,I,IT:INTEGER;DLC,DLS,DRC,DRS,DBC,DBS:double);
    BEGIN
      IF IT=0 THEN ADDTHE(C6[I6],S6[I6],C[I],S[I],U,V)
              ELSE BEGIN U:=U*T; V:=V*T END;
      DL:=DL+DLC*U+DLS*V; DR:=DR+DRC*U+DRS*V; DB:=DB+DBC*U+DBS*V;
    END;

  PROCEDURE PERTJUP;  (* Kepler terms and perturbations by Jupiter *)
    VAR I: INTEGER;
    BEGIN
      C[0]:=1.0; S[0]:=0.0; C[1]:=COS(M5); S[1]:=SIN(M5);
      FOR I:=0 DOWNTO -5 DO ADDTHE(C[I],S[I],C[1],-S[1],C[I-1],S[I-1]);
      TERM( 0,-1,0,   12.0,   -1.4,   -13.9,    6.4,    1.2,  -1.8);
      TERM( 0,-2,0,    0.0,   -0.2,    -0.9,    1.0,    0.0,  -0.1);
      TERM( 1, 1,0,    0.9,    0.4,    -1.8,    1.9,    0.2,   0.2);
      TERM( 1, 0,0, -348.3,22907.7,-52915.5, -752.2,-3266.5,8314.4);
      TERM( 1, 0,1, -225.2, -146.2,   337.7, -521.3,   79.6,  17.4);
      TERM( 1, 0,2,    1.3,   -1.4,     3.2,    2.9,    0.1,  -0.4);
      TERM( 1,-1,0,   -1.0,  -30.7,   108.6, -815.0,   -3.6,  -9.3);
      TERM( 1,-2,0,   -2.0,   -2.7,    -2.1,  -11.9,   -0.1,  -0.4);
      TERM( 2, 1,0,    0.1,    0.2,    -1.0,    0.3,    0.0,   0.0);
      TERM( 2, 0,0,   44.2,  724.0, -1464.3,  -34.7, -188.7, 459.1);
      TERM( 2, 0,1,  -17.0,  -11.3,    18.9,  -28.6,    1.0,  -3.7);
      TERM( 2,-1,0,   -3.5, -426.6,  -546.5,  -26.5,   -1.6,  -2.7);
      TERM( 2,-1,1,    3.5,   -2.2,    -2.6,   -4.3,    0.0,   0.0);
      TERM( 2,-2,0,   10.5,  -30.9,  -130.5,  -52.3,   -1.9,   0.2);
      TERM( 2,-3,0,   -0.2,   -0.4,    -1.2,   -0.1,   -0.1,   0.0);
      TERM( 3, 0,0,    6.5,   30.5,   -61.1,    0.4,  -11.6,  28.1);
      TERM( 3, 0,1,   -1.2,   -0.7,     1.1,   -1.8,   -0.2,  -0.6);
      TERM( 3,-1,0,   29.0,  -40.2,    98.2,   45.3,    3.2,  -9.4);
      TERM( 3,-1,1,    0.6,    0.6,    -1.0,    1.3,    0.0,   0.0);
      TERM( 3,-2,0,  -27.0,  -21.1,   -68.5,    8.1,  -19.8,   5.4);
      TERM( 3,-2,1,    0.9,   -0.5,    -0.4,   -2.0,   -0.1,  -0.8);
      TERM( 3,-3,0,   -5.4,   -4.1,   -19.1,   26.2,   -0.1,  -0.1);
      TERM( 4, 0,0,    0.6,    1.4,    -3.0,   -0.2,   -0.6,   1.6);
      TERM( 4,-1,0,    1.5,   -2.5,    12.4,    4.7,    1.0,  -1.1);
      TERM( 4,-2,0, -821.9,   -9.6,   -26.0, 1873.6,  -70.5,  -4.4);
      TERM( 4,-2,1,    4.1,  -21.9,   -50.3,   -9.9,    0.7,  -3.0);
      TERM( 4,-3,0,   -2.0,   -4.7,   -19.3,    8.2,   -0.1,  -0.3);
      TERM( 4,-4,0,   -1.5,    1.3,     6.5,    7.3,    0.0,   0.0);
      TERM( 5,-2,0,-2627.6,-1277.3,   117.4, -344.1,  -13.8,  -4.3);
      TERM( 5,-2,1,   63.0,  -98.6,    12.7,    6.7,    0.1,  -0.2);
      TERM( 5,-2,2,    1.7,    1.2,    -0.2,    0.3,    0.0,   0.0);
      TERM( 5,-3,0,    0.4,   -3.6,   -11.3,   -1.6,    0.0,  -0.3);
      TERM( 5,-4,0,   -1.4,    0.3,     1.5,    6.3,   -0.1,   0.0);
      TERM( 5,-5,0,    0.3,    0.6,     3.0,   -1.7,    0.0,   0.0);
      TERM( 6,-2,0, -146.7,  -73.7,   166.4, -334.3,  -43.6, -46.7);
      TERM( 6,-2,1,    5.2,   -6.8,    15.1,   11.4,    1.7,  -1.0);
      TERM( 6,-3,0,    1.5,   -2.9,    -2.2,   -1.3,    0.1,  -0.1);
      TERM( 6,-4,0,   -0.7,   -0.2,    -0.7,    2.8,    0.0,   0.0);
      TERM( 6,-5,0,    0.0,    0.5,     2.5,   -0.1,    0.0,   0.0);
      TERM( 6,-6,0,    0.3,   -0.1,    -0.3,   -1.2,    0.0,   0.0);
      TERM( 7,-2,0,   -9.6,   -3.9,     9.6,  -18.6,   -4.7,  -5.3);
      TERM( 7,-2,1,    0.4,   -0.5,     1.0,    0.9,    0.3,  -0.1);
      TERM( 7,-3,0,    3.0,    5.3,     7.5,   -3.5,    0.0,   0.0);
      TERM( 7,-4,0,    0.2,    0.4,     1.6,   -1.3,    0.0,   0.0);
      TERM( 7,-5,0,   -0.1,    0.2,     1.0,    0.5,    0.0,   0.0);
      TERM( 7,-6,0,    0.2,    0.0,     0.2,   -1.0,    0.0,   0.0);
      TERM( 8,-2,0,   -0.7,   -0.2,     0.6,   -1.2,   -0.4,  -0.4);
      TERM( 8,-3,0,    0.5,    1.0,    -2.0,    1.5,    0.1,   0.2);
      TERM( 8,-4,0,    0.4,    1.3,     3.6,   -0.9,    0.0,  -0.1);
      TERM( 9,-4,0,    4.0,   -8.7,   -19.9,   -9.9,    0.2,  -0.4);
      TERM( 9,-4,1,    0.5,    0.3,     0.8,   -1.8,    0.0,   0.0);
      TERM(10,-4,0,   21.3,  -16.8,     3.3,    3.3,    0.2,  -0.2);
      TERM(10,-4,1,    1.0,    1.7,    -0.4,    0.4,    0.0,   0.0);
      TERM(11,-4,0,    1.6,   -1.3,     3.0,    3.7,    0.8,  -0.2);
    END;

  PROCEDURE PERTURA;  (* perturbations by Uranus *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M7); S[-1]:=-SIN(M7);
      FOR I:=-1 DOWNTO -4 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM( 0,-1,0,    1.0,    0.7,     0.4,   -1.5,    0.1,   0.0);
      TERM( 0,-2,0,    0.0,   -0.4,    -1.1,    0.1,   -0.1,  -0.1);
      TERM( 0,-3,0,   -0.9,   -1.2,    -2.7,    2.1,   -0.5,  -0.3);
      TERM( 1,-1,0,    7.8,   -1.5,     2.3,   12.7,    0.0,   0.0);
      TERM( 1,-2,0,   -1.1,   -8.1,     5.2,   -0.3,   -0.3,  -0.3);
      TERM( 1,-3,0,  -16.4,  -21.0,    -2.1,    0.0,    0.4,   0.0);
      TERM( 2,-1,0,    0.6,   -0.1,     0.1,    1.2,    0.1,   0.0);
      TERM( 2,-2,0,   -4.9,  -11.7,    31.5,  -13.3,    0.0,  -0.2);
      TERM( 2,-3,0,   19.1,   10.0,   -22.1,   42.1,    0.1,  -1.1);
      TERM( 2,-4,0,    0.9,   -0.1,     0.1,    1.4,    0.0,   0.0);
      TERM( 3,-2,0,   -0.4,   -0.9,     1.7,   -0.8,    0.0,  -0.3);
      TERM( 3,-3,0,    2.3,    0.0,     1.0,    5.7,    0.3,   0.3);
      TERM( 3,-4,0,    0.3,   -0.7,     2.0,    0.7,    0.0,   0.0);
      TERM( 3,-5,0,   -0.1,   -0.4,     1.1,   -0.3,    0.0,   0.0);
    END;

  PROCEDURE PERTNEP;  (* perturbations by Neptune *)
    BEGIN
      C[-1]:=COS(M8); S[-1]:=-SIN(M8);
      ADDTHE(C[-1],S[-1],C[-1],S[-1],C[-2],S[-2]);
      TERM( 1,-1,0,   -1.3,   -1.2,     2.3,   -2.5,    0.0,   0.0);
      TERM( 1,-2,0,    1.0,   -0.1,     0.1,    1.4,    0.0,   0.0);
      TERM( 2,-2,0,    1.1,   -0.1,     0.2,    3.3,    0.0,   0.0);
    END;

  PROCEDURE PERTJUR;  (* perturbations by Jupiter and Uranus *)
    VAR PHI,X,Y: double;
    BEGIN
      PHI:=(-2*M5+5*M6-3*M7); X:=COS(PHI); Y:=SIN(PHI);
      DL:=DL-0.8*X-0.1*Y; DR:=DR-0.2*X+1.8*Y; DB:=DB+0.3*X+0.5*Y;
      ADDTHE(X,Y,C6[1],S6[1],X,Y);
      DL:=DL+(+2.4-0.7*T)*X+(27.8-0.4*T)*Y; DR:=DR+2.1*X-0.2*Y;
      ADDTHE(X,Y,C6[1],S6[1],X,Y);
      DL:=DL+0.1*X+1.6*Y; DR:=DR-3.6*X+0.3*Y; DB:=DB-0.2*X+0.6*Y;
    END;

  BEGIN  (* SAT200 *)

    DL:=0.0; DR:=0.0; DB:=0.0;
    M5:=P2*FRAC(0.0565314+8.4302963*T); M6:=P2*FRAC(0.8829867+3.3947688*T);
    M7:=P2*FRAC(0.3969537+1.1902586*T); M8:=P2*FRAC(0.7208473+0.6068623*T);
    C6[0]:=1.0; S6[0]:=0.0;  C6[1]:=COS(M6); S6[1]:=SIN(M6);
    FOR I:=2 TO 11 DO ADDTHE(C6[I-1],S6[I-1],C6[1],S6[1],C6[I],S6[I]);
    PERTJUP; PERTURA; PERTNEP; PERTJUR;
    L:= 360.0*FRAC(0.2561136 + M6/P2 + ((5018.6+T*1.9)*T +DL)/1296.0E3 );
    R:= 9.557584 - 0.000186*T  +  DR*1.0E-5;
    B:= ( 175.1 - 10.2*T + DB ) / 3600.0;

  END;   (* SAT200 *)

END.
