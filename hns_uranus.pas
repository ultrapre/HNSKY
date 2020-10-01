UNIT hns_uranus;

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

PROCEDURE URA200(T:double;VAR L,B,R:double);

IMPLEMENTATION

(*-----------------------------------------------------------------------*)
(* URA200: Uranus; ecliptic coordinates L,B,R (in deg and AU)            *)
(*         equinox of date                                               *)
(*         (T: time in Julian centuries since J2000)                     *)
(*         (   = (JED-2451545.0)/36525             )                     *)
(*-----------------------------------------------------------------------*)
PROCEDURE URA200(T:double;VAR L,B,R:double);
  CONST P2=6.283185307;
  VAR C7,S7:         ARRAY [-2..7] OF double;
      C,S:           ARRAY [-8..0] OF double;
      M5,M6,M7,M8:   double;
      U,V, DL,DR,DB: double;
      I:             INTEGER;

  FUNCTION FRAC(X:double):double;
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1.0; FRAC:=X  END;

  PROCEDURE ADDTHE(C1,S1,C2,S2:double; VAR C,S:double);
    BEGIN  C:=C1*C2-S1*S2; S:=S1*C2+C1*S2; END;

  PROCEDURE TERM(I7,I,IT:INTEGER;DLC,DLS,DRC,DRS,DBC,DBS:double);
    BEGIN
      IF IT=0 THEN ADDTHE(C7[I7],S7[I7],C[I],S[I],U,V)
              ELSE BEGIN U:=U*T; V:=V*T END;
      DL:=DL+DLC*U+DLS*V; DR:=DR+DRC*U+DRS*V; DB:=DB+DBC*U+DBS*V;
    END;

  PROCEDURE PERTJUP;  (* perturbations by Jupiter *)
    BEGIN
      C[0]:=1.0; S[0]:=0.0; C[-1]:=COS(M5); S[-1]:=-SIN(M5);
      ADDTHE(C[-1],S[-1],C[-1],S[-1],C[-2],S[-2]);
      TERM(-1,-1,0,  0.0,    0.0,    -0.1,   1.7,  -0.1,   0.0);
      TERM( 0,-1,0,  0.5,   -1.2,    18.9,   9.1,  -0.9,   0.1);
      TERM( 1,-1,0,-21.2,   48.7,  -455.5,-198.8,   0.0,   0.0);
      TERM( 1,-2,0, -0.5,    1.2,   -10.9,  -4.8,   0.0,   0.0);
      TERM( 2,-1,0, -1.3,    3.2,   -23.2, -11.1,   0.3,   0.1);
      TERM( 2,-2,0, -0.2,    0.2,     1.1,   1.5,   0.0,   0.0);
      TERM( 3,-1,0,  0.0,    0.2,    -1.8,   0.4,   0.0,   0.0);
    END;

  PROCEDURE PERTSAT;  (* perturbations by Saturn *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M6); S[-1]:=-SIN(M6);
      FOR I:=-1 DOWNTO -3 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM( 0,-1,0,  1.4,   -0.5,    -6.4,   9.0,  -0.4,  -0.8);
      TERM( 1,-1,0,-18.6,  -12.6,    36.7,-336.8,   1.0,   0.3);
      TERM( 1,-2,0, -0.7,   -0.3,     0.5,  -7.5,   0.1,   0.0);
      TERM( 2,-1,0, 20.0, -141.6,  -587.1,-107.0,   3.1,  -0.8);
      TERM( 2,-1,1,  1.0,    1.4,     5.8,  -4.0,   0.0,   0.0);
      TERM( 2,-2,0,  1.6,   -3.8,   -35.6, -16.0,   0.0,   0.0);
      TERM( 3,-1,0, 75.3, -100.9,   128.9,  77.5,  -0.8,   0.1);
      TERM( 3,-1,1,  0.2,    1.8,    -1.9,   0.3,   0.0,   0.0);
      TERM( 3,-2,0,  2.3,   -1.3,    -9.5, -17.9,   0.0,   0.1);
      TERM( 3,-3,0, -0.7,   -0.5,    -4.9,   6.8,   0.0,   0.0);
      TERM( 4,-1,0,  3.4,   -5.0,    21.6,  14.3,  -0.8,  -0.5);
      TERM( 4,-2,0,  1.9,    0.1,     1.2, -12.1,   0.0,   0.0);
      TERM( 4,-3,0, -0.1,   -0.4,    -3.9,   1.2,   0.0,   0.0);
      TERM( 4,-4,0, -0.2,    0.1,     1.6,   1.8,   0.0,   0.0);
      TERM( 5,-1,0,  0.2,   -0.3,     1.0,   0.6,  -0.1,   0.0);
      TERM( 5,-2,0, -2.2,   -2.2,    -7.7,   8.5,   0.0,   0.0);
      TERM( 5,-3,0,  0.1,   -0.2,    -1.4,  -0.4,   0.0,   0.0);
      TERM( 5,-4,0, -0.1,    0.0,     0.1,   1.2,   0.0,   0.0);
      TERM( 6,-2,0, -0.2,   -0.6,     1.4,  -0.7,   0.0,   0.0);
    END;

  PROCEDURE PERTNEP;  (* Kepler terms and perturbations by Neptune  *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M8); S[-1]:=-SIN(M8);
      FOR I:=-1 DOWNTO -7 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM( 1, 0,0,-78.1,19518.1,-90718.2,-334.7,2759.5,-311.9);
      TERM( 1, 0,1,-81.6,  107.7,  -497.4,-379.5,  -2.8, -43.7);
      TERM( 1, 0,2, -6.6,   -3.1,    14.4, -30.6,  -0.4,  -0.5);
      TERM( 1, 0,3,  0.0,   -0.5,     2.4,   0.0,   0.0,   0.0);
      TERM( 2, 0,0, -2.4,  586.1, -2145.2, -15.3, 130.6, -14.3);
      TERM( 2, 0,1, -4.5,    6.6,   -24.2, -17.8,   0.7,  -1.6);
      TERM( 2, 0,2, -0.4,    0.0,     0.1,  -1.4,   0.0,   0.0);
      TERM( 3, 0,0,  0.0,   24.5,   -76.2,  -0.6,   7.0,  -0.7);
      TERM( 3, 0,1, -0.2,    0.4,    -1.4,  -0.8,   0.1,  -0.1);
      TERM( 4, 0,0,  0.0,    1.1,    -3.0,   0.1,   0.4,   0.0);
      TERM(-1,-1,0, -0.2,    0.2,     0.7,   0.7,  -0.1,   0.0);
      TERM( 0,-1,0, -2.8,    2.5,     8.7,  10.5,  -0.4,  -0.1);
      TERM( 1,-1,0,-28.4,   20.3,   -51.4, -72.0,   0.0,   0.0);
      TERM( 1,-2,0, -0.6,   -0.1,     4.2, -14.6,   0.2,   0.4);
      TERM( 1,-3,0,  0.2,    0.5,     3.4,  -1.6,  -0.1,   0.1);
      TERM( 2,-1,0, -1.8,    1.3,    -5.5,  -7.7,   0.0,   0.3);
      TERM( 2,-2,0, 29.4,   10.2,   -29.0,  83.2,   0.0,   0.0);
      TERM( 2,-3,0,  8.8,   17.8,   -41.9,  21.5,  -0.1,  -0.3);
      TERM( 2,-4,0,  0.0,    0.1,    -2.1,  -0.9,   0.1,   0.0);
      TERM( 3,-2,0,  1.5,    0.5,    -1.7,   5.1,   0.1,  -0.2);
      TERM( 3,-3,0,  4.4,   14.6,   -84.3,  25.2,   0.1,  -0.1);
      TERM( 3,-4,0,  2.4,   -4.5,    12.0,   6.2,   0.0,   0.0);
      TERM( 3,-5,0,  2.9,   -0.9,     2.1,   6.2,   0.0,   0.0);
      TERM( 4,-3,0,  0.3,    1.0,    -4.0,   1.1,   0.1,  -0.1);
      TERM( 4,-4,0,  2.1,   -2.7,    17.9,  14.0,   0.0,   0.0);
      TERM( 4,-5,0,  3.0,   -0.4,     2.3,  17.6,  -0.1,  -0.1);
      TERM( 4,-6,0, -0.6,   -0.5,     1.1,  -1.6,   0.0,   0.0);
      TERM( 5,-4,0,  0.2,   -0.2,     1.0,   0.8,   0.0,   0.0);
      TERM( 5,-5,0, -0.9,   -0.1,     0.6,  -7.1,   0.0,   0.0);
      TERM( 5,-6,0, -0.5,   -0.6,     3.8,  -3.6,   0.0,   0.0);
      TERM( 5,-7,0,  0.0,   -0.5,     3.0,   0.1,   0.0,   0.0);
      TERM( 6,-6,0,  0.2,    0.3,    -2.7,   1.6,   0.0,   0.0);
      TERM( 6,-7,0, -0.1,    0.2,    -2.0,  -0.4,   0.0,   0.0);
      TERM( 7,-7,0,  0.1,   -0.2,     1.3,   0.5,   0.0,   0.0);
      TERM( 7,-8,0,  0.1,    0.0,     0.4,   0.9,   0.0,   0.0);
    END;

  PROCEDURE PERTJSU;  (* perturbations by Jupiter and Saturn *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M6);         S[-1]:=-SIN(M6);
      C[-4]:=COS(-4*M6+2*M5); S[-4]:= SIN(-4*M6+2*M5);
      FOR I:=-4 DOWNTO -5 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(-2,-4,0, -0.7,    0.4,    -1.5,  -2.5,   0.0,   0.0);
      TERM(-1,-4,0, -0.1,   -0.1,    -2.2,   1.0,   0.0,   0.0);
      TERM( 1,-5,0,  0.1,   -0.4,     1.4,   0.2,   0.0,   0.0);
      TERM( 1,-6,0,  0.4,    0.5,    -0.8,  -0.8,   0.0,   0.0);
      TERM( 2,-6,0,  5.7,    6.3,    28.5, -25.5,   0.0,   0.0);
      TERM( 2,-6,1,  0.1,   -0.2,    -1.1,  -0.6,   0.0,   0.0);
      TERM( 3,-6,0, -1.4,   29.2,   -11.4,   1.1,   0.0,   0.0);
      TERM( 3,-6,1,  0.8,   -0.4,     0.2,   0.3,   0.0,   0.0);
      TERM( 4,-6,0,  0.0,    1.3,    -6.0,  -0.1,   0.0,   0.0);
    END;

  BEGIN  (* URA200 *)

    DL:=0.0; DR:=0.0; DB:=0.0;
    M5:=P2*FRAC(0.0564472+8.4302889*T); M6:=P2*FRAC(0.8829611+3.3947583*T);
    M7:=P2*FRAC(0.3967117+1.1902849*T); M8:=P2*FRAC(0.7216833+0.6068528*T);
    C7[0]:=1.0; S7[0]:=0.0; C7[1]:=COS(M7); S7[1]:=SIN(M7);
    FOR I:=2 TO 7 DO ADDTHE(C7[I-1],S7[I-1],C7[1],S7[1],C7[I],S7[I]);
    FOR I:=1 TO 2 DO BEGIN C7[-I]:=C7[I]; S7[-I]:=-S7[I]; END;
    PERTJUP; PERTSAT; PERTNEP; PERTJSU;
    L:= 360.0*FRAC(0.4734843 + M7/P2 + ((5082.3+34.2*T)*T+DL)/1296.0E3 );
    R:= 19.211991 + (-0.000333-0.000005*T)*T  +  DR*1.0E-5;
    B:= (-130.61 + (-0.54+0.04*T)*T + DB ) / 3600.0;

  END;   (* URA200 *)

END.
