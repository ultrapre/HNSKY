UNIT hns_mars;

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

PROCEDURE MAR200 ( T: double; VAR L,B,R: double );

IMPLEMENTATION

(*-----------------------------------------------------------------------*)
(* MAR200: Mars; ecliptic coordinates L,B,R (in deg and AU)              *)
(*         equinox of date                                               *)
(*         (T: time in Julian centuries since J2000)                     *)
(*         (   = (JED-2451545.0)/36525             )                     *)
(*-----------------------------------------------------------------------*)
PROCEDURE MAR200(T:double;VAR L,B,R:double);
  CONST P2=6.283185307;
  VAR C4,S4:          ARRAY [-2..16] OF double;
      C,S:            ARRAY [-9.. 0] OF double;
      M2,M3,M4,M5,M6: double;
      U,V, DL,DR,DB:  double;
      I:              INTEGER;

  FUNCTION FRAC(X:double):double;
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1.0; FRAC:=X  END;

  PROCEDURE ADDTHE(C1,S1,C2,S2:double; VAR C,S:double);
    BEGIN  C:=C1*C2-S1*S2; S:=S1*C2+C1*S2; END;

  PROCEDURE TERM(I1,I,IT:INTEGER;DLC,DLS,DRC,DRS,DBC,DBS:double);
    BEGIN
      IF IT=0 THEN ADDTHE(C4[I1],S4[I1],C[I],S[I],U,V)
              ELSE BEGIN U:=U*T; V:=V*T END;
      DL:=DL+DLC*U+DLS*V; DR:=DR+DRC*U+DRS*V; DB:=DB+DBC*U+DBS*V;
    END;

  PROCEDURE PERTVEN; (* perturbations by Venus *)
    BEGIN
      C[0]:=1.0; S[0]:=0.0; C[-1]:=COS(M2); S[-1]:=-SIN(M2);
      ADDTHE(C[-1],S[-1],C[-1],S[-1],C[-2],S[-2]);
      TERM( 0,-1,0, -0.01,   -0.03,      0.10, -0.04,    0.00,   0.00);
      TERM( 1,-1,0,  0.05,    0.10,     -2.08,  0.75,    0.00,   0.00);
      TERM( 2,-1,0, -0.25,   -0.57,     -2.58,  1.18,    0.05,  -0.04);
      TERM( 2,-2,0,  0.02,    0.02,      0.13, -0.14,    0.00,   0.00);
      TERM( 3,-1,0,  3.41,    5.38,      1.87, -1.15,    0.01,  -0.01);
      TERM( 3,-2,0,  0.02,    0.02,      0.11, -0.13,    0.00,   0.00);
      TERM( 4,-1,0,  0.32,    0.49,     -1.88,  1.21,   -0.07,   0.07);
      TERM( 4,-2,0,  0.03,    0.03,      0.12, -0.14,    0.00,   0.00);
      TERM( 5,-1,0,  0.04,    0.06,     -0.17,  0.11,   -0.01,   0.01);
      TERM( 5,-2,0,  0.11,    0.09,      0.35, -0.43,   -0.01,   0.01);
      TERM( 6,-2,0, -0.36,   -0.28,     -0.20,  0.25,    0.00,   0.00);
      TERM( 7,-2,0, -0.03,   -0.03,      0.11, -0.13,    0.00,  -0.01);
    END;

  PROCEDURE PERTEAR;  (* Kepler terms and perturbations by the Earth *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M3); S[-1]:=-SIN(M3);
      FOR I:=-1 DOWNTO -8 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM( 1, 0,0, -5.32,38481.97,-141856.04,  0.40,-6321.67,1876.89);
      TERM( 1, 0,1, -1.12,   37.98,   -138.67, -2.93,   37.28, 117.48);
      TERM( 1, 0,2, -0.32,   -0.03,      0.12, -1.19,    1.04,  -0.40);
      TERM( 2, 0,0, 28.28, 2285.80,  -6608.37,  0.00, -589.35, 174.81);
      TERM( 2, 0,1,  1.64,    3.37,    -12.93,  0.00,    2.89,  11.10);
      TERM( 2, 0,2,  0.00,    0.00,      0.00,  0.00,    0.10,  -0.03);
      TERM( 3, 0,0,  5.31,  189.29,   -461.81,  0.00,  -61.98,  18.53);
      TERM( 3, 0,1,  0.31,    0.35,     -1.36,  0.00,    0.25,   1.19);
      TERM( 4, 0,0,  0.81,   17.96,    -38.26,  0.00,   -6.88,   2.08);
      TERM( 4, 0,1,  0.05,    0.04,     -0.15,  0.00,    0.02,   0.14);
      TERM( 5, 0,0,  0.11,    1.83,     -3.48,  0.00,   -0.79,   0.24);
      TERM( 6, 0,0,  0.02,    0.20,     -0.34,  0.00,   -0.09,   0.03);
      TERM(-1,-1,0,  0.09,    0.06,      0.14, -0.22,    0.02,  -0.02);
      TERM( 0,-1,0,  0.72,    0.49,      1.55, -2.31,    0.12,  -0.10);
      TERM( 1,-1,0,  7.00,    4.92,     13.93,-20.48,    0.08,  -0.13);
      TERM( 2,-1,0, 13.08,    4.89,     -4.53, 10.01,   -0.05,   0.13);
      TERM( 2,-2,0,  0.14,    0.05,     -0.48, -2.66,    0.01,   0.14);
      TERM( 3,-1,0,  1.38,    0.56,     -2.00,  4.85,   -0.01,   0.19);
      TERM( 3,-2,0, -6.85,    2.68,      8.38, 21.42,    0.00,   0.03);
      TERM( 3,-3,0, -0.08,    0.20,      1.20,  0.46,    0.00,   0.00);
      TERM( 4,-1,0,  0.16,    0.07,     -0.19,  0.47,   -0.01,   0.05);
      TERM( 4,-2,0, -4.41,    2.14,     -3.33, -7.21,   -0.07,  -0.09);
      TERM( 4,-3,0, -0.12,    0.33,      2.22,  0.72,   -0.03,  -0.02);
      TERM( 4,-4,0, -0.04,   -0.06,     -0.36,  0.23,    0.00,   0.00);
      TERM( 5,-2,0, -0.44,    0.21,     -0.70, -1.46,   -0.06,  -0.07);
      TERM( 5,-3,0,  0.48,   -2.60,     -7.25, -1.37,    0.00,   0.00);
      TERM( 5,-4,0, -0.09,   -0.12,     -0.66,  0.50,    0.00,   0.00);
      TERM( 5,-5,0,  0.03,    0.00,      0.01, -0.17,    0.00,   0.00);
      TERM( 6,-2,0, -0.05,    0.03,     -0.07, -0.15,   -0.01,  -0.01);
      TERM( 6,-3,0,  0.10,   -0.96,      2.36,  0.30,    0.04,   0.00);
      TERM( 6,-4,0, -0.17,   -0.20,     -1.09,  0.94,    0.02,  -0.02);
      TERM( 6,-5,0,  0.05,    0.00,      0.00, -0.30,    0.00,   0.00);
      TERM( 7,-3,0,  0.01,   -0.10,      0.32,  0.04,    0.02,   0.00);
      TERM( 7,-4,0,  0.86,    0.77,      1.86, -2.01,    0.01,  -0.01);
      TERM( 7,-5,0,  0.09,   -0.01,     -0.05, -0.44,    0.00,   0.00);
      TERM( 7,-6,0, -0.01,    0.02,      0.10,  0.08,    0.00,   0.00);
      TERM( 8,-4,0,  0.20,    0.16,     -0.53,  0.64,   -0.01,   0.02);
      TERM( 8,-5,0,  0.17,   -0.03,     -0.14, -0.84,    0.00,   0.01);
      TERM( 8,-6,0, -0.02,    0.03,      0.16,  0.09,    0.00,   0.00);
      TERM( 9,-5,0, -0.55,    0.15,      0.30,  1.10,    0.00,   0.00);
      TERM( 9,-6,0, -0.02,    0.04,      0.20,  0.10,    0.00,   0.00);
      TERM(10,-5,0, -0.09,    0.03,     -0.10, -0.33,    0.00,  -0.01);
      TERM(10,-6,0, -0.05,    0.11,      0.48,  0.21,   -0.01,   0.00);
      TERM(11,-6,0,  0.10,   -0.35,     -0.52, -0.15,    0.00,   0.00);
      TERM(11,-7,0, -0.01,   -0.02,     -0.10,  0.07,    0.00,   0.00);
      TERM(12,-6,0,  0.01,   -0.04,      0.18,  0.04,    0.01,   0.00);
      TERM(12,-7,0, -0.05,   -0.07,     -0.29,  0.20,    0.01,   0.00);
      TERM(13,-7,0,  0.23,    0.27,      0.25, -0.21,    0.00,   0.00);
      TERM(14,-7,0,  0.02,    0.03,     -0.10,  0.09,    0.00,   0.00);
      TERM(14,-8,0,  0.05,    0.01,      0.03, -0.23,    0.00,   0.03);
      TERM(15,-8,0, -1.53,    0.27,      0.06,  0.42,    0.00,   0.00);
      TERM(16,-8,0, -0.14,    0.02,     -0.10, -0.55,   -0.01,  -0.02);
      TERM(16,-9,0,  0.03,   -0.06,     -0.25, -0.11,    0.00,   0.00);
    END;

  PROCEDURE PERTJUP; (* perturbations by Jupiter *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M5); S[-1]:=-SIN(M5);
      FOR I:=-1 DOWNTO -4 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(-2,-1,0,  0.05,    0.03,      0.08, -0.14,    0.01,  -0.01);
      TERM(-1,-1,0,  0.39,    0.27,      0.92, -1.50,   -0.03,  -0.06);
      TERM(-1,-2,0, -0.16,    0.03,      0.13,  0.67,   -0.01,   0.06);
      TERM(-1,-3,0, -0.02,    0.01,      0.05,  0.09,    0.00,   0.01);
      TERM( 0,-1,0,  3.56,    1.13,     -5.41, -7.18,   -0.25,  -0.24);
      TERM( 0,-2,0, -1.44,    0.25,      1.24,  7.96,    0.02,   0.31);
      TERM( 0,-3,0, -0.21,    0.11,      0.55,  1.04,    0.01,   0.05);
      TERM( 0,-4,0, -0.02,    0.02,      0.11,  0.11,    0.00,   0.01);
      TERM( 1,-1,0, 16.67,  -19.15,     61.00, 53.36,   -0.06,  -0.07);
      TERM( 1,-2,0,-21.64,    3.18,     -7.77,-54.64,   -0.31,   0.50);
      TERM( 1,-3,0, -2.82,    1.45,     -2.53, -5.73,    0.01,   0.07);
      TERM( 1,-4,0, -0.31,    0.28,     -0.34, -0.51,    0.00,   0.00);
      TERM( 2,-1,0,  2.15,   -2.29,      7.04,  6.94,    0.33,   0.19);
      TERM( 2,-2,0,-15.69,    3.31,    -15.70,-73.17,   -0.17,  -0.25);
      TERM( 2,-3,0, -1.73,    1.95,     -9.19, -7.20,    0.02,  -0.03);
      TERM( 2,-4,0, -0.01,    0.33,     -1.42,  0.08,    0.01,  -0.01);
      TERM( 2,-5,0,  0.03,    0.03,     -0.13,  0.12,    0.00,   0.00);
      TERM( 3,-1,0,  0.26,   -0.28,      0.73,  0.71,    0.08,   0.04);
      TERM( 3,-2,0, -2.06,    0.46,     -1.61, -6.72,   -0.13,  -0.25);
      TERM( 3,-3,0, -1.28,   -0.27,      2.21, -6.90,   -0.04,  -0.02);
      TERM( 3,-4,0, -0.22,    0.08,     -0.44, -1.25,    0.00,   0.01);
      TERM( 3,-5,0, -0.02,    0.03,     -0.15, -0.08,    0.00,   0.00);
      TERM( 4,-1,0,  0.03,   -0.03,      0.08,  0.08,    0.01,   0.01);
      TERM( 4,-2,0, -0.26,    0.06,     -0.17, -0.70,   -0.03,  -0.05);
      TERM( 4,-3,0, -0.20,   -0.05,      0.22, -0.79,   -0.01,  -0.02);
      TERM( 4,-4,0, -0.11,   -0.14,      0.93, -0.60,    0.00,   0.00);
      TERM( 4,-5,0, -0.04,   -0.02,      0.09, -0.23,    0.00,   0.00);
      TERM( 5,-4,0, -0.02,   -0.03,      0.13, -0.09,    0.00,   0.00);
      TERM( 5,-5,0,  0.00,   -0.03,      0.21,  0.01,    0.00,   0.00);
    END;

  PROCEDURE PERTSAT;  (* perturbations by Saturn *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M6); S[-1]:=-SIN(M6);
      FOR I:=-1 DOWNTO -3 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(-1,-1,0,  0.03,    0.13,      0.48, -0.13,    0.02,   0.00);
      TERM( 0,-1,0,  0.27,    0.84,      0.40, -0.43,    0.01,  -0.01);
      TERM( 0,-2,0,  0.12,   -0.04,     -0.33, -0.55,   -0.01,  -0.02);
      TERM( 0,-3,0,  0.02,   -0.01,     -0.07, -0.08,    0.00,   0.00);
      TERM( 1,-1,0,  1.12,    0.76,     -2.66,  3.91,   -0.01,   0.01);
      TERM( 1,-2,0,  1.49,   -0.95,      3.07,  4.83,    0.04,  -0.05);
      TERM( 1,-3,0,  0.21,   -0.18,      0.55,  0.64,    0.00,   0.00);
      TERM( 2,-1,0,  0.12,    0.10,     -0.29,  0.34,   -0.01,   0.02);
      TERM( 2,-2,0,  0.51,   -0.36,      1.61,  2.25,    0.03,   0.01);
      TERM( 2,-3,0,  0.10,   -0.10,      0.50,  0.43,    0.00,   0.00);
      TERM( 2,-4,0,  0.01,   -0.02,      0.11,  0.05,    0.00,   0.00);
      TERM( 3,-2,0,  0.07,   -0.05,      0.16,  0.22,    0.01,   0.01);
    END;

  BEGIN  (* MAR200 *)

    DL:=0.0; DR:=0.0; DB:=0.0;
    M2:=P2*FRAC(0.1382208+162.5482542*T);
    M3:=P2*FRAC(0.9926208+99.9970236*T);
    M4:=P2*FRAC(0.0538553+ 53.1662736*T);
    M5:=P2*FRAC(0.0548944+ 8.4290611*T);
    M6:=P2*FRAC(0.8811167+  3.3935250*T);
    C4[0]:=1.0; S4[0]:=0.0;  C4[1]:=COS(M4); S4[1]:=SIN(M4);
    FOR I:=2 TO 16 DO ADDTHE(C4[I-1],S4[I-1],C4[1],S4[1],C4[I],S4[I]);
    FOR I:=-2 TO -1 DO BEGIN C4[I]:=C4[-I]; S4[I]:=-S4[-I] END;
    PERTVEN; PERTEAR; PERTJUP; PERTSAT;
    DL:=DL + 52.49*SIN(P2*(0.1868+0.0549*T))
           +  0.61*SIN(P2*(0.9220+0.3307*T))
           +  0.32*SIN(P2*(0.4731+2.1485*T))
           +  0.28*SIN(P2*(0.9467+0.1133*T));
    DL:=DL + (0.14+0.87*T-0.11*T*T);
    L:= 360.0*FRAC(0.9334591 + M4/P2 + ((6615.5+1.1*T)*T+DL)/1296.0E3 );
    R:= 1.5303352 + 0.0000131*T  +  DR*1.0E-6;
    B:= ( 596.32 + (-2.92 - 0.10*T) * T  +  DB ) / 3600.0;
  END;

END.
