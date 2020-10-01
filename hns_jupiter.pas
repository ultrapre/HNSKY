UNIT hns_jupiter;
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

PROCEDURE JUP200 ( T: double; VAR L,B,R: double );

IMPLEMENTATION

(*-----------------------------------------------------------------------*)
(* JUP200: Jupiter; ecliptic coordinates L,B,R (in deg and AU)           *)
(*         equinox of date                                               *)
(*         T: time in Julian centuries since J2000                       *)
(*            = (JED-2451545.0)/36525                                    *)
(*-----------------------------------------------------------------------*)
PROCEDURE JUP200(T:double;VAR L,B,R:double);
  CONST P2=6.283185307;
  VAR C5,S5:        ARRAY [-1..5] OF double;
      C,S:          ARRAY [-10..0] OF double;
      M5,M6,M7:     double;
      U,V,DL,DR,DB: double;
      I:            INTEGER;

  FUNCTION FRAC(X:double):double;
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1.0; FRAC:=X  END;

  PROCEDURE ADDTHE(C1,S1,C2,S2:double; VAR C,S:double);
    BEGIN  C:=C1*C2-S1*S2; S:=S1*C2+C1*S2; END;

  PROCEDURE TERM(I5,I,IT:INTEGER;DLC,DLS,DRC,DRS,DBC,DBS:double);
    BEGIN
      IF IT=0 THEN ADDTHE(C5[I5],S5[I5],C[I],S[I],U,V)
              ELSE BEGIN U:=U*T; V:=V*T END;
      DL:=DL+DLC*U+DLS*V; DR:=DR+DRC*U+DRS*V; DB:=DB+DBC*U+DBS*V;
    END;

  PROCEDURE PERTSAT;  (* Kepler terms and perturbations by Saturn *)
    VAR I: INTEGER;
    BEGIN
      C[0]:=1.0; S[0]:=0.0; C[-1]:=COS(M6); S[-1]:=-SIN(M6);
      FOR I:=-1 DOWNTO -9 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(-1, -1,0,  -0.2,    1.4,     2.0,   0.6,    0.1, -0.2);
      TERM( 0, -1,0,   9.4,    8.9,     3.9,  -8.3,   -0.4, -1.4);
      TERM( 0, -2,0,   5.6,   -3.0,    -5.4,  -5.7,   -2.0,  0.0);
      TERM( 0, -3,0,  -4.0,   -0.1,     0.0,   5.5,    0.0,  0.0);
      TERM( 0, -5,0,   3.3,   -1.6,    -1.6,  -3.1,   -0.5, -1.2);
      TERM( 1,  0,0,-113.1,19998.6,-25208.2,-142.2,-4670.7,288.9);
      TERM( 1,  0,1, -76.1,   66.9,   -84.2, -95.8,   21.6, 29.4);
      TERM( 1,  0,2,  -0.5,   -0.3,     0.4,  -0.7,    0.1, -0.1);
      TERM( 1, -1,0,  78.8,  -14.5,    11.5,  64.4,   -0.2,  0.2);
      TERM( 1, -2,0,  -2.0, -132.4,    28.8,   4.3,   -1.7,  0.4);
      TERM( 1, -2,1,  -1.1,   -0.7,     0.2,  -0.3,    0.0,  0.0);
      TERM( 1, -3,0,  -7.5,   -6.8,    -0.4,  -1.1,    0.6, -0.9);
      TERM( 1, -4,0,   0.7,    0.7,     0.6,  -1.1,    0.0, -0.2);
      TERM( 1, -5,0,  51.5,  -26.0,   -32.5, -64.4,   -4.9,-12.4);
      TERM( 1, -5,1,  -1.2,   -2.2,    -2.7,   1.5,   -0.4,  0.3);
      TERM( 2,  0,0,  -3.4,  632.0,  -610.6,  -6.5, -226.8, 12.7);
      TERM( 2,  0,1,  -4.2,    3.8,    -4.1,  -4.5,    0.2,  0.6);
      TERM( 2, -1,0,   5.3,   -0.7,     0.7,   6.1,    0.2,  1.1);
      TERM( 2, -2,0, -76.4, -185.1,   260.2,-108.0,    1.6,  0.0);
      TERM( 2, -3,0,  66.7,   47.8,   -51.4,  69.8,    0.9,  0.3);
      TERM( 2, -3,1,   0.6,   -1.0,     1.0,   0.6,    0.0,  0.0);
      TERM( 2, -4,0,  17.0,    1.4,    -1.8,   9.6,    0.0, -0.1);
      TERM( 2, -5,0,1066.2, -518.3,    -1.3, -23.9,    1.8, -0.3);
      TERM( 2, -5,1, -25.4,  -40.3,    -0.9,   0.3,    0.0,  0.0);
      TERM( 2, -5,2,  -0.7,    0.5,     0.0,   0.0,    0.0,  0.0);
      TERM( 3,  0,0,  -0.1,   28.0,   -22.1,  -0.2,  -12.5,  0.7);
      TERM( 3, -2,0,  -5.0,  -11.5,    11.7,  -5.4,    2.1, -1.0);
      TERM( 3, -3,0,  16.9,   -6.4,    13.4,  26.9,   -0.5,  0.8);
      TERM( 3, -4,0,   7.2,  -13.3,    20.9,  10.5,    0.1, -0.1);
      TERM( 3, -5,0,  68.5,  134.3,  -166.9,  86.5,    7.1, 15.2);
      TERM( 3, -5,1,   3.5,   -2.7,     3.4,   4.3,    0.5, -0.4);
      TERM( 3, -6,0,   0.6,    1.0,    -0.9,   0.5,    0.0,  0.0);
      TERM( 3, -7,0,  -1.1,    1.7,    -0.4,  -0.2,    0.0,  0.0);
      TERM( 4,  0,0,   0.0,    1.4,    -1.0,   0.0,   -0.6,  0.0);
      TERM( 4, -2,0,  -0.3,   -0.7,     0.4,  -0.2,    0.2, -0.1);
      TERM( 4, -3,0,   1.1,   -0.6,     0.9,   1.2,    0.1,  0.2);
      TERM( 4, -4,0,   3.2,    1.7,    -4.1,   5.8,    0.2,  0.1);
      TERM( 4, -5,0,   6.7,    8.7,    -9.3,   8.7,   -1.1,  1.6);
      TERM( 4, -6,0,   1.5,   -0.3,     0.6,   2.4,    0.0,  0.0);
      TERM( 4, -7,0,  -1.9,    2.3,    -3.2,  -2.7,    0.0, -0.1);
      TERM( 4, -8,0,   0.4,   -1.8,     1.9,   0.5,    0.0,  0.0);
      TERM( 4, -9,0,  -0.2,   -0.5,     0.3,  -0.1,    0.0,  0.0);
      TERM( 4,-10,0,  -8.6,   -6.8,    -0.4,   0.1,    0.0,  0.0);
      TERM( 4,-10,1,  -0.5,    0.6,     0.0,   0.0,    0.0,  0.0);
      TERM( 5, -5,0,  -0.1,    1.5,    -2.5,  -0.8,   -0.1,  0.1);
      TERM( 5, -6,0,   0.1,    0.8,    -1.6,   0.1,    0.0,  0.0);
      TERM( 5, -9,0,  -0.5,   -0.1,     0.1,  -0.8,    0.0,  0.0);
      TERM( 5,-10,0,   2.5,   -2.2,     2.8,   3.1,    0.1, -0.2);
    END;

  PROCEDURE PERTURA;  (* perturbations by Uranus *)
    BEGIN
      C[-1]:=COS(M7); S[-1]:=-SIN(M7);
      ADDTHE(C[-1],S[-1],C[-1],S[-1],C[-2],S[-2]);
      TERM( 1, -1,0,   0.4,    0.9,     0.0,   0.0,    0.0,  0.0);
      TERM( 1, -2,0,   0.4,    0.4,    -0.4,   0.3,    0.0,  0.0);
    END;

  PROCEDURE PERTSUR;  (* perturbations by Saturn and Uranus *)
    VAR PHI,X,Y: double;
    BEGIN
      PHI:=(2*M5-6*M6+3*M7); X:=COS(PHI); Y:=SIN(PHI);
      DL:=DL-0.8*X+8.5*Y; DR:=DR-0.1*X;
      ADDTHE(X,Y,C5[1],S5[1],X,Y);
      DL:=DL+0.4*X+0.5*Y; DR:=DR-0.7*X+0.5*Y; DB:=DB-0.1*X;
    END;

  BEGIN  (* JUP200 *)

    DL:=0.0; DR:=0.0; DB:=0.0;
    M5:=P2*FRAC(0.0565314+8.4302963*T); M6:=P2*FRAC(0.8829867+3.3947688*T);
    M7:=P2*FRAC(0.3969537+1.1902586*T);
    C5[0]:=1.0;     S5[0]:=0.0;
    C5[1]:=COS(M5); S5[1]:=SIN(M5);  C5[-1]:=C5[1]; S5[-1]:=-S5[1];
    FOR I:=2 TO 5 DO ADDTHE(C5[I-1],S5[I-1],C5[1],S5[1],C5[I],S5[I]);
    PERTSAT; PERTURA; PERTSUR;
    L:= 360.0*FRAC(0.0388910 + M5/P2 + ((5025.2+0.8*T)*T+DL)/1296.0E3 );
    R:= 5.208873 + 0.000041*T  +  DR*1.0E-5;
    B:= ( 227.3 - 0.3*T + DB ) / 3600.0;

  END;   (* JUP200 *)

END.
