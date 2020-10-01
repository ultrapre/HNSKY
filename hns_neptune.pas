UNIT hns_neptune;

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

PROCEDURE NEP200(T:double;VAR L,B,R:double);

IMPLEMENTATION

(*-----------------------------------------------------------------------*)
(* NEP200: Neptune; ecliptic coordinates L,B,R (in deg and AU)           *)
(*         equinox of date                                               *)
(*         (T: time in Julian centuries since J2000)                     *)
(*         (   = (JED-2451545.0)/36525             )                     *)
(*-----------------------------------------------------------------------*)
PROCEDURE NEP200(T:double;VAR L,B,R:double);
  CONST P2=6.283185307;
  VAR C8,S8:         ARRAY [ 0..6] OF double;
      C,S:           ARRAY [-6..0] OF double;
      M5,M6,M7,M8:   double;
      U,V, DL,DR,DB: double;
      I: INTEGER;

  FUNCTION FRAC(X:double):double;
    BEGIN  X:=X-TRUNC(X); IF (X<0) THEN X:=X+1.0; FRAC:=X  END;

  PROCEDURE ADDTHE(C1,S1,C2,S2:double; VAR C,S:double);
    BEGIN  C:=C1*C2-S1*S2; S:=S1*C2+C1*S2; END;

  PROCEDURE TERM(I1,I,IT:INTEGER;DLC,DLS,DRC,DRS,DBC,DBS:double);
    BEGIN
      IF IT=0 THEN ADDTHE(C8[I1],S8[I1],C[I],S[I],U,V)
              ELSE BEGIN U:=U*T; V:=V*T END;
      DL:=DL+DLC*U+DLS*V; DR:=DR+DRC*U+DRS*V; DB:=DB+DBC*U+DBS*V;
    END;

  PROCEDURE PERTJUP;  (* perturbations by Jupiter *)
    BEGIN
      C[0]:=1.0; S[0]:=0.0; C[-1]:=COS(M5); S[-1]:=-SIN(M5);
      ADDTHE(C[-1],S[-1],C[-1],S[-1],C[-2],S[-2]);
      TERM(0,-1,0,  0.1,   0.1,    -3.0,   1.8,   -0.3, -0.3);
      TERM(1, 0,0,  0.0,   0.0,   -15.9,   9.0,    0.0,  0.0);
      TERM(1,-1,0,-17.6, -29.3,   416.1,-250.0,    0.0,  0.0);
      TERM(1,-2,0, -0.4,  -0.7,    10.4,  -6.2,    0.0,  0.0);
      TERM(2,-1,0, -0.2,  -0.4,     2.4,  -1.4,    0.4, -0.3);
    END;

  PROCEDURE PERTSAT;  (* perturbations by Saturn *)
    BEGIN
      C[0]:=1.0; S[0]:=0.0; C[-1]:=COS(M6); S[-1]:=-SIN(M6);
      ADDTHE(C[-1],S[-1],C[-1],S[-1],C[-2],S[-2]);
      TERM(0,-1,0, -0.1,   0.0,     0.2,  -1.8,   -0.1, -0.5);
      TERM(1, 0,0,  0.0,   0.0,    -8.3, -10.4,    0.0,  0.0);
      TERM(1,-1,0, 13.6, -12.7,   187.5, 201.1,    0.0,  0.0);
      TERM(1,-2,0,  0.4,  -0.4,     4.5,   4.5,    0.0,  0.0);
      TERM(2,-1,0,  0.4,  -0.1,     1.7,  -3.2,    0.2,  0.2);
      TERM(2,-2,0, -0.1,   0.0,    -0.2,   2.7,    0.0,  0.0);
    END;

  PROCEDURE PERTURA;  (* Kepler terms and perturbations by Uranus *)
    VAR I: INTEGER;
    BEGIN
      C[0]:=1.0; S[0]:=0.0; C[-1]:=COS(M7); S[-1]:=-SIN(M7);
      FOR I:=-1 DOWNTO -5 DO ADDTHE(C[I],S[I],C[-1],S[-1],C[I-1],S[I-1]);
      TERM(1, 0,0, 32.3,3549.5,-25880.2, 235.8,-6360.5,374.0);
      TERM(1, 0,1, 31.2,  34.4,  -251.4, 227.4,   34.9, 29.3);
      TERM(1, 0,2, -1.4,   3.9,   -28.6, -10.1,    0.0, -0.9);
      TERM(2, 0,0,  6.1,  68.0,  -111.4,   2.0,  -54.7,  3.7);
      TERM(2, 0,1,  0.8,  -0.2,    -2.1,   2.0,   -0.2,  0.8);
      TERM(3, 0,0,  0.1,   1.0,    -0.7,   0.0,   -0.8,  0.1);
      TERM(0,-1,0, -0.1,  -0.3,    -3.6,   0.0,    0.0,  0.0);
      TERM(1, 0,0,  0.0,   0.0,     5.5,  -6.9,    0.1,  0.0);
      TERM(1,-1,0, -2.2,  -1.6,  -116.3, 163.6,    0.0, -0.1);
      TERM(1,-2,0,  0.2,   0.1,    -1.2,   0.4,    0.0, -0.1);
      TERM(2,-1,0,  4.2,  -1.1,    -4.4, -34.6,   -0.2,  0.1);
      TERM(2,-2,0,  8.6,  -2.9,   -33.4, -97.0,    0.2,  0.1);
      TERM(3,-1,0,  0.1,  -0.2,     2.1,  -1.2,    0.0,  0.1);
      TERM(3,-2,0, -4.6,   9.3,    38.2,  19.8,    0.1,  0.1);
      TERM(3,-3,0, -0.5,   1.7,    23.5,   7.0,    0.0,  0.0);
      TERM(4,-2,0,  0.2,   0.8,     3.3,  -1.5,   -0.2, -0.1);
      TERM(4,-3,0,  0.9,   1.7,    17.9,  -9.1,   -0.1,  0.0);
      TERM(4,-4,0, -0.4,  -0.4,    -6.2,   4.8,    0.0,  0.0);
      TERM(5,-3,0, -1.6,  -0.5,    -2.2,   7.0,    0.0,  0.0);
      TERM(5,-4,0, -0.4,  -0.1,    -0.7,   5.5,    0.0,  0.0);
      TERM(5,-5,0,  0.2,   0.0,     0.0,  -3.5,    0.0,  0.0);
      TERM(6,-4,0, -0.3,   0.2,     2.1,   2.7,    0.0,  0.0);
      TERM(6,-5,0,  0.1,  -0.1,    -1.4,  -1.4,    0.0,  0.0);
      TERM(6,-6,0, -0.1,   0.1,     1.4,   0.7,    0.0,  0.0);
    END;

  BEGIN  (* NEP200 *)

    DL:=0.0; DR:=0.0; DB:=0.0;
    M5:=P2*FRAC(0.0563867+8.4298907*T); M6:=P2*FRAC(0.8825086+3.3957748*T);
    M7:=P2*FRAC(0.3965358+1.1902851*T); M8:=P2*FRAC(0.7214906+0.6068526*T);
    C8[0]:=1.0; S8[0]:=0.0; C8[1]:=COS(M8); S8[1]:=SIN(M8);
    FOR I:=2 TO 6 DO ADDTHE(C8[I-1],S8[I-1],C8[1],S8[1],C8[I],S8[I]);
    PERTJUP; PERTSAT; PERTURA;
    L:= 360.0*FRAC(0.1254046 + M8/P2 + ((4982.8-21.3*T)*T+DL)/1296.0E3 );
    R:= 30.072984 + (0.001234+0.000003*T) * T  +  DR*1.0E-5;
    B:= (  54.77 + ( 0.26 + 0.06*T) * T  +  DB ) / 3600.0;

  END;   (* NEP200 *)

END.
