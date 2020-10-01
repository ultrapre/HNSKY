UNIT hns_venus;
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

PROCEDURE VEN200 ( T: double; VAR L,B,R: double );

IMPLEMENTATION

(*-----------------------------------------------------------------------*)
(* VEN200: Venus; ecliptic coordinates L,B,R (in deg and AU)             *)
(*         equinox of date                                               *)
(*         (T: time in Julian centuries since J2000)                     *)
(*         (   = (JED-2451545.0)/36525             )                     *)
(*-----------------------------------------------------------------------*)
PROCEDURE VEN200(T:double;VAR L,B,R:double);
  CONST P2=6.283185307;
  VAR C2,S2:             ARRAY [ 0..8] OF double;
      C,S:               ARRAY [-8..0] OF double;
      M1,M2,M3,M4,M5,M6: double;
      U,V, DL,DR,DB:     double;
      I:                 INTEGER;

  FUNCTION FRAC(X:double):double;
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1.0; FRAC:=X  END;

  PROCEDURE ADDTHE(C1,S1,C2,S2:double; VAR C,S:double);
    BEGIN  C:=C1*C2-S1*S2; S:=S1*C2+C1*S2; END;

  PROCEDURE TERM(I1,I,IT:INTEGER;DLC,DLS,DRC,DRS,DBC,DBS:double);
    BEGIN
      IF IT=0 THEN ADDTHE(C2[I1],S2[I1],C[I],S[I],U,V)
              ELSE BEGIN U:=U*T; V:=V*T END;
      DL:=DL+DLC*U+DLS*V; DR:=DR+DRC*U+DRS*V; DB:=DB+DBC*U+DBS*V;
    END;


  PROCEDURE PERTMER;  (* perturbations by Mercury *)
    BEGIN
      C[0]:=1.0; S[0]:=0.0; C[-1]:=COS(M1); S[-1]:=-SIN(M1);
      ADDTHE(C[-1],S[-1],C[-1],S[-1],C[-2],S[-2]);
      TERM(1,-1,0,   0.00,   0.00,    0.06, -0.09,   0.01,   0.00);
      TERM(2,-1,0,   0.25,  -0.09,   -0.09, -0.27,   0.00,   0.00);
      TERM(4,-2,0,  -0.07,  -0.08,   -0.14,  0.14,  -0.01,  -0.01);
      TERM(5,-2,0,  -0.35,   0.08,    0.02,  0.09,   0.00,   0.00);
    END;

  PROCEDURE PERTEAR;  (* Kepler terms and perturbations by the Earth *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M3); S[-1]:=-SIN(M3);
      FOR I:=-1 DOWNTO -7 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(1, 0,0,   2.37,2793.23,-4899.07,  0.11,9995.27,7027.22);
      TERM(1, 0,1,   0.10, -19.65,   34.40,  0.22,  64.95, -86.10);
      TERM(1, 0,2,   0.06,   0.04,   -0.07,  0.11,  -0.55,  -0.07);
      TERM(2, 0,0,-170.42,  73.13,  -16.59,  0.00,  67.71,  47.56);
      TERM(2, 0,1,   0.93,   2.91,    0.23,  0.00,  -0.03,  -0.92);
      TERM(3, 0,0,  -2.31,   0.90,   -0.08,  0.00,   0.04,   2.09);
      TERM(1,-1,0,  -2.38,  -4.27,    3.27, -1.82,   0.00,   0.00);
      TERM(1,-2,0,   0.09,   0.00,   -0.08,  0.05,  -0.02,  -0.25);
      TERM(2,-2,0,  -9.57,  -5.93,    8.57,-13.83,  -0.01,  -0.01);
      TERM(2,-3,0,  -2.47,  -2.40,    0.83, -0.95,   0.16,   0.24);
      TERM(3,-2,0,  -0.09,  -0.05,    0.08, -0.13,  -0.28,   0.12);
      TERM(3,-3,0,   7.12,   0.32,   -0.62, 13.76,  -0.07,   0.01);
      TERM(3,-4,0,  -0.65,  -0.17,    0.18, -0.73,   0.10,   0.05);
      TERM(3,-5,0,  -1.08,  -0.95,   -0.17,  0.22,  -0.03,  -0.03);
      TERM(4,-3,0,   0.06,   0.00,   -0.01,  0.08,   0.14,  -0.18);
      TERM(4,-4,0,   0.93,  -0.46,    1.06,  2.13,  -0.01,   0.01);
      TERM(4,-5,0,  -1.53,   0.38,   -0.64, -2.54,   0.27,   0.00);
      TERM(4,-6,0,  -0.17,  -0.05,    0.03, -0.11,   0.02,   0.00);
      TERM(5,-5,0,   0.18,  -0.28,    0.71,  0.47,  -0.02,   0.04);
      TERM(5,-6,0,   0.15,  -0.14,    0.30,  0.31,  -0.04,   0.03);
      TERM(5,-7,0,  -0.08,   0.02,   -0.03, -0.11,   0.01,   0.00);
      TERM(5,-8,0,  -0.23,   0.00,    0.01, -0.04,   0.00,   0.00);
      TERM(6,-6,0,   0.01,  -0.14,    0.39,  0.04,   0.00,  -0.01);
      TERM(6,-7,0,   0.02,  -0.05,    0.12,  0.04,  -0.01,   0.01);
      TERM(6,-8,0,   0.10,  -0.10,    0.19,  0.19,  -0.02,   0.02);
      TERM(7,-7,0,  -0.03,  -0.06,    0.18, -0.08,   0.00,   0.00);
      TERM(8,-8,0,  -0.03,  -0.02,    0.06, -0.08,   0.00,   0.00);
    END;

  PROCEDURE PERTMAR;  (* perturbations by Mars *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M4); S[-1]:=-SIN(M4);
      FOR I:=-1 DOWNTO -2 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(1,-3,0,  -0.65,   1.02,   -0.04, -0.02,  -0.02,   0.00);
      TERM(2,-2,0,  -0.05,   0.04,   -0.09, -0.10,   0.00,   0.00);
      TERM(2,-3,0,  -0.50,   0.45,   -0.79, -0.89,   0.01,   0.03);
    END;

  PROCEDURE PERTJUP;  (* perturbations by Jupiter *)
    VAR I: INTEGER;
    BEGIN
      C[-1]:=COS(M5); S[-1]:=-SIN(M5);
      FOR I:=-1 DOWNTO -2 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(0,-1,0,  -0.05,   1.56,    0.16,  0.04,  -0.08,  -0.04);
      TERM(1,-1,0,  -2.62,   1.40,   -2.35, -4.40,   0.02,   0.03);
      TERM(1,-2,0,  -0.47,  -0.08,    0.12, -0.76,   0.04,  -0.18);
      TERM(2,-2,0,  -0.73,  -0.51,    1.27, -1.82,  -0.01,   0.01);
      TERM(2,-3,0,  -0.14,  -0.10,    0.25, -0.34,   0.00,   0.00);
      TERM(3,-3,0,  -0.01,   0.04,   -0.11, -0.02,   0.00,   0.00);
    END;

  PROCEDURE PERTSAT;  (* perturbations by Saturn *)
    BEGIN
      C[-1]:=COS(M6); S[-1]:=-SIN(M6);
      TERM(0,-1,0,   0.00,   0.21,    0.00,  0.00,   0.00,  -0.01);
      TERM(1,-1,0,  -0.11,  -0.14,    0.24, -0.20,   0.01,   0.00);
    END;

  BEGIN  (* VEN200 *)

    DL:=0.0; DR:=0.0; DB:=0.0;
    M1:=P2*FRAC(0.4861431+415.2018375*T);
    M2:=P2*FRAC(0.1400197+162.5494552*T);
    M3:=P2*FRAC(0.9944153+ 99.9982208*T);
    M4:=P2*FRAC(0.0556297+ 53.1674631*T);
    M5:=P2*FRAC(0.0567028+  8.4305083*T);
    M6:=P2*FRAC(0.8830539+  3.3947206*T);
    C2[0]:=1.0; S2[0]:=0.0; C2[1]:=COS(M2); S2[1]:=SIN(M2);
    FOR I:=2 TO 8 DO ADDTHE(C2[I-1],S2[I-1],C2[1],S2[1],C2[I],S2[I]);
    PERTMER; PERTEAR; PERTMAR; PERTJUP; PERTSAT;
    DL:=DL + 2.74*SIN(P2*(0.0764+0.4174*T))
           + 0.27*SIN(P2*(0.9201+0.3307*T));
    DL:=DL + (1.9+1.8*T);
    L:= 360.0*FRAC(0.3654783 + M2/P2 + ((5071.2+1.1*T)*T+DL)/1296.0E3 );
    R:= 0.7233482 - 0.0000002*T  +  DR*1.0E-6;
    B:= ( -67.70 + ( 0.04 + 0.01*T) * T  +  DB ) / 3600.0;

  END;   (* VEN200 *)

END.
