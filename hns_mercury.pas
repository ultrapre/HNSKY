UNIT hns_mercury;

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

PROCEDURE MER200 ( T: double; VAR L,B,R: double );

IMPLEMENTATION

  (*-----------------------------------------------------------------------*)
  (* MER200: Mercury; ecliptic coordinates L,B,R (in deg and AU)           *)
  (*         equinox of date                                               *)
  (*         (T: time in Julian centuries since J2000)                     *)
  (*         (   = (JED-2451545.0)/36525             )                     *)
  (*-----------------------------------------------------------------------*)
  PROCEDURE MER200(T:double;VAR L,B,R:double);
    CONST P2=6.283185307;
    VAR C1,S1:          ARRAY [-1..9] OF double;
        C,S:            ARRAY [-5..0] OF double;
        M1,M2,M3,M5,M6: double;
        U,V, DL,DR,DB:  double;
        I:              INTEGER;

    FUNCTION FRAC(X:double):double;
      BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1.0; FRAC:=X  END;

    PROCEDURE ADDTHE(C1,S1,C2,S2:double; VAR C,S:double);
      BEGIN  C:=C1*C2-S1*S2; S:=S1*C2+C1*S2;
      END;

    PROCEDURE TERM(I1,I,IT:INTEGER;DLC,DLS,DRC,DRS,DBC,DBS:double);
      BEGIN
        IF IT=0 THEN ADDTHE(C1[I1],S1[I1],C[I],S[I],U,V)
                ELSE BEGIN U:=U*T; V:=V*T END;
        DL:=DL+DLC*U+DLS*V; DR:=DR+DRC*U+DRS*V; DB:=DB+DBC*U+DBS*V;
      END;

    PROCEDURE PERTVEN;  (* Kepler terms and perturbations by Venus *)
      VAR I: INTEGER;
      BEGIN
        C[0]:=1.0; S[0]:=0.0;  C[-1]:=COS(M2); S[-1]:=-SIN(M2);
        FOR I:=-1 DOWNTO -4 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
        TERM( 1, 0,0, 259.74,84547.39,-78342.34, 0.01,11683.22,21203.79);
        TERM( 1, 0,1,   2.30,    5.04,    -7.52, 0.02,  138.55,  -71.01);
        TERM( 1, 0,2,   0.01,   -0.01,     0.01, 0.01,   -0.19,   -0.54);
        TERM( 2, 0,0,-549.71,10394.44, -7955.45, 0.00, 2390.29, 4306.79);
        TERM( 2, 0,1,  -4.77,    8.97,    -1.53, 0.00,   28.49,  -14.18);
        TERM( 2, 0,2,   0.00,    0.00,     0.00, 0.00,   -0.04,   -0.11);
        TERM( 3, 0,0,-234.04, 1748.74, -1212.86, 0.00,  535.41,  984.33);
        TERM( 3, 0,1,  -2.03,    3.48,    -0.35, 0.00,    6.56,   -2.91);
        TERM( 4, 0,0, -77.64,  332.63,  -219.23, 0.00,  124.40,  237.03);
        TERM( 4, 0,1,  -0.70,    1.10,    -0.08, 0.00,    1.59,   -0.59);
        TERM( 5, 0,0, -23.59,   67.28,   -43.54, 0.00,   29.44,   58.77);
        TERM( 5, 0,1,  -0.23,    0.32,    -0.02, 0.00,    0.39,   -0.11);
        TERM( 6, 0,0,  -6.86,   14.06,    -9.18, 0.00,    7.03,   14.84);
        TERM( 6, 0,1,  -0.07,    0.09,    -0.01, 0.00,    0.10,   -0.02);
        TERM( 7, 0,0,  -1.94,    2.98,    -2.02, 0.00,    1.69,    3.80);
        TERM( 8, 0,0,  -0.54,    0.63,    -0.46, 0.00,    0.41,    0.98);
        TERM( 9, 0,0,  -0.15,    0.13,    -0.11, 0.00,    0.10,    0.25);
        TERM(-1,-2,0,  -0.17,   -0.06,    -0.05, 0.14,   -0.06,   -0.07);
        TERM( 0,-1,0,   0.24,   -0.16,    -0.11,-0.16,    0.04,   -0.01);
        TERM( 0,-2,0,  -0.68,   -0.25,    -0.26, 0.73,   -0.16,   -0.18);
        TERM( 0,-5,0,   0.37,    0.08,     0.06,-0.28,    0.13,    0.12);
        TERM( 1,-1,0,   0.58,   -0.41,     0.26, 0.36,    0.01,   -0.01);
        TERM( 1,-2,0,  -3.51,   -1.23,     0.23,-0.63,   -0.05,   -0.06);
        TERM( 1,-3,0,   0.08,    0.53,    -0.11, 0.04,    0.02,   -0.09);
        TERM( 1,-5,0,   1.44,    0.31,     0.30,-1.39,    0.34,    0.29);
        TERM( 2,-1,0,   0.15,   -0.11,     0.09, 0.12,    0.02,   -0.04);
        TERM( 2,-2,0,  -1.99,   -0.68,     0.65,-1.91,   -0.20,    0.03);
        TERM( 2,-3,0,  -0.34,   -1.28,     0.97,-0.26,    0.03,    0.03);
        TERM( 2,-4,0,  -0.33,    0.35,    -0.13,-0.13,   -0.01,    0.00);
        TERM( 2,-5,0,   7.19,    1.56,    -0.05, 0.12,    0.06,    0.05);
        TERM( 3,-2,0,  -0.52,   -0.18,     0.13,-0.39,   -0.16,    0.03);
        TERM( 3,-3,0,  -0.11,   -0.42,     0.36,-0.10,   -0.05,   -0.05);
        TERM( 3,-4,0,  -0.19,    0.22,    -0.23,-0.20,   -0.01,    0.02);
        TERM( 3,-5,0,   2.77,    0.49,    -0.45, 2.56,    0.40,   -0.12);
        TERM( 4,-5,0,   0.67,    0.12,    -0.09, 0.47,    0.24,   -0.08);
        TERM( 5,-5,0,   0.18,    0.03,    -0.02, 0.12,    0.09,   -0.03);
      END;

    PROCEDURE PERTEAR;  (* perturbations by the Earth *)
      VAR I: INTEGER;
      BEGIN
        C[-1]:=COS(M3); S[-1]:=-SIN(M3);
        FOR I:=-1 DOWNTO -3 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
        TERM( 0,-4,0,  -0.11,   -0.07,    -0.08, 0.11,   -0.02,   -0.04);
        TERM( 1,-1,0,   0.10,   -0.20,     0.15, 0.07,    0.00,    0.00);
        TERM( 1,-2,0,  -0.35,    0.28,    -0.13,-0.17,   -0.01,    0.00);
        TERM( 1,-4,0,  -0.67,   -0.45,     0.00, 0.01,   -0.01,   -0.01);
        TERM( 2,-2,0,  -0.20,    0.16,    -0.16,-0.20,   -0.01,    0.02);
        TERM( 2,-3,0,   0.13,   -0.02,     0.02, 0.14,    0.01,    0.00);
        TERM( 2,-4,0,  -0.33,   -0.18,     0.17,-0.31,   -0.04,    0.00);
      END;

    PROCEDURE PERTJUP;  (* perturbations by Jupiter *)
      VAR I: INTEGER;
      BEGIN
        C[-1]:=COS(M5); S[-1]:=-SIN(M5);
        FOR I:=-1 DOWNTO -2 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
        TERM(-1,-1,0,  -0.08,    0.16,     0.15, 0.08,   -0.04,    0.01);
        TERM(-1,-2,0,   0.10,   -0.06,    -0.07,-0.12,    0.07,   -0.01);
        TERM( 0,-1,0,  -0.31,    0.48,    -0.02, 0.13,   -0.03,   -0.02);
        TERM( 0,-2,0,   0.42,   -0.26,    -0.38,-0.50,    0.20,   -0.03);
        TERM( 1,-1,0,  -0.70,    0.01,    -0.02,-0.63,    0.00,    0.03);
        TERM( 1,-2,0,   2.61,   -1.97,     1.74, 2.32,    0.01,    0.01);
        TERM( 1,-3,0,   0.32,   -0.15,     0.13, 0.28,    0.00,    0.00);
        TERM( 2,-1,0,  -0.18,    0.01,     0.00,-0.13,   -0.03,    0.03);
        TERM( 2,-2,0,   0.75,   -0.56,     0.45, 0.60,    0.08,   -0.17);
        TERM( 3,-2,0,   0.20,   -0.15,     0.10, 0.14,    0.04,   -0.08);
      END;

    PROCEDURE PERTSAT;  (* perturbations by Saturn *)
      BEGIN
        C[-2]:=COS(2*M6); S[-2]:=-SIN(2*M6);
        TERM( 1,-2,0,  -0.19,    0.33,     0.00, 0.00,    0.00,    0.00);
      END;

    BEGIN  (* MER200 *)

      DL:=0.0; DR:=0.0; DB:=0.0;
      M1:=P2*FRAC(0.4855407+415.2014314*T);
      M2:=P2*FRAC(0.1394222+162.5490444*T);
      M3:=P2*FRAC(0.9937861+ 99.9978139*T);
      M5:=P2*FRAC(0.0558417+  8.4298417*T);
      M6:=P2*FRAC(0.8823333+  3.3943333*T);
      C1[0]:=1.0;     S1[0]:=0.0;
      C1[1]:=COS(M1); S1[1]:=SIN(M1);  C1[-1]:=C1[1]; S1[-1]:=-S1[1];
      FOR I:=2 TO 9 DO ADDTHE(C1[I-1],S1[I-1],C1[1],S1[1],C1[I],S1[I]);
      PERTVEN; PERTEAR; PERTJUP; PERTSAT;
      DL := DL + (2.8+3.2*T);
      L:= 360.0*FRAC(0.2151379 + M1/P2 + ((5601.7+1.1*T)*T+DL)/1296.0E3 );
      R:= 0.3952829 + 0.0000016*T  +  DR*1.0E-6;
      B:= ( -2522.15 + (-30.18 + 0.04*T) * T  +  DB ) / 3600.0;

    END;   (* MER200 *)

END.
