unit hns_Uprs;
//ESO 2011 Astronomy & Astrophysics
//New precession expressions, valid for long time intervals
//   New precession expressions, valid for long time intervals
//   J. Vondrak , N. Capitaine , and P. Wallace
//   A&A 2011

//Here we define the precession of the equator as that part of the motion of the equato r that covers periods longer than
// 100 centuries, while terms of shorter periods are presumed to be included in the nutation

{http://www.aanda.org/articles/aa/pdf/2011/10/aa17274-11.pdf}
{http://www.aanda.org/articles/aa/pdf/2012/05/aa17274e-11.pdf}
//code adapted from CdC 2017-2-8. Orginal code is Fortran and in above documentation

{
{This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
}

interface

Procedure Precession(j0,j1,ra0,dec0: double; var ra1,dec1: double);{ precession function, equinox0 to equinox1}
Procedure Precession_cartesian(j0,j1,x0,y0,z0:double; var x1,y1,z1: double);{ precession function, equinox0 to equinox1}

implementation

uses math;

type
  double33= array[1..3,1..3] of double;
  double3 = array[1..3 ]     of double;

var prec_r : double33;
    prec_j0, prec_j1: double;

////// Required functions adapted from the SOFA library
procedure sofa_PM(p:double3; var r:double);
// Modulus of p-vector.
var i: integer;
    w,c : double;
begin
  W := 0;
  for i:=1 to 3 do begin
   C := P[I];
   W := W + C*C;
  end;
  R := SQRT(W);
end;
Procedure sofa_ZP(var p:double3);
// Zero a p-vector.
var i: integer;
begin
  for i:=1 to 3 do p[i]:=0;
end;

Procedure sofa_SXP(s: double; p: double3;  var sp: double3);
//  Multiply a p-vector by a scalar.
var i: integer;
begin
  for i:=1 to 3 do sp[i]:=s*p[i];
end;

Procedure sofa_PN(p: double3; var r:double; var u:double3);
// Convert a p-vector into modulus and unit vector.
var w: double;
begin
  // Obtain the modulus and test for zero.
  sofa_PM ( P, W );
  IF ( W = 0 ) THEN
  //  Null vector.
  sofa_ZP ( U )
  ELSE
  //  Unit vector.
  sofa_SXP ( 1/W, P, U );
  //  Return the modulus.
  R := W;
end;

Procedure sofa_PXP(a,b: double3; var axb: double3);
  // p-vector outer (=vector=cross) product.
var xa,ya,za,xb,yb,zb: double;
begin
  XA := A[1];
  YA := A[2];
  ZA := A[3];
  XB := B[1];
  YB := B[2];
  ZB := B[3];
  AXB[1] := YA*ZB - ZA*YB;
  AXB[2] := ZA*XB - XA*ZB;
  AXB[3] := XA*YB - YA*XB;
end;

/////// Precession expressions

Procedure ltp_PECL(epj: double; var vec: double3);
// Precession of the ecliptic
// The Fortran subroutine ltp PECL generates the unit vector for the pole of the ecliptic, using the series for PA , QA (Eq. 8 and Tab. 1)
const npol=4;
      nper=8;
      // Polynomials
      pqpol: array[1..npol,1..2] of double = (
             (+5851.607687,-1600.886300),
             (-0.1189000,+1.1689818),
             (-0.00028913,-0.00000020),
             (+0.000000101,-0.000000437));
      // Periodics
      pqper: array[1..5,1..nper] of double = (
             (708.15,2309,1620,492.2,1183,622,882,547),
             (-5486.751211,-17.127623,-617.517403,413.44294,78.614193,-180.732815,-87.676083,46.140315),
             (-684.66156,2446.28388,399.671049,-356.652376,-186.387003,-316.80007,198.296701,101.135679),
             (667.66673,-2354.886252,-428.152441,376.202861,184.778874,335.321713,-185.138669,-120.97283),
             (-5523.863691,-549.74745,-310.998056,421.535876,-36.776172,-145.278396,-34.74445,22.885731));
var as2r, d2pi, eps0, t, p, q, w, a, s, c, z : extended;
    i : integer;
begin
  d2pi:=pi*2;
  //Arcseconds to radians
  as2r:=pi/(180*60*60);//Arcseconds to radians multiplier
  //Obliquity at J2000.0 (radians).
  eps0 := 84381.406 * as2r;
  // Centuries since J2000.
  T:=(epj-2451545.0)/36525;// Centuries since J2000.
  //Initialize P_A and Q_A accumulators.
  P := 0;
 Q := 0;
  // Periodic terms.
  for i:=1 to nper do begin
    W := D2PI*T;
    A := W/PQPER[1,I];
    sincos(A,S,C);
    P := P + C*PQPER[2,I] + S*PQPER[4,I];
    Q := Q + C*PQPER[3,I] + S*PQPER[5,I];
 end;
  // Polynomial terms.
  W := 1;
  for i:=1 to npol do begin
    P := P + PQPOL[I,1]*W;
   Q := Q + PQPOL[I,2]*W;
   W := W*T;
  end;
  // P_A and Q_A (radians).
  P := P*AS2R;
  Q := Q*AS2R;
  // Form the ecliptic pole vector.
  Z := SQRT(MAX(1-P*P-Q*Q,0));
  sincos(eps0,s,c);
  VEC[1] := P;
  VEC[2] := - Q*C - Z*S;
  VEC[3] := - Q*S + Z*C;
end;

Procedure ltp_PEQU(epj: double; var VEQ: double3);{http://www.aanda.org/articles/aa/pdf/2011/10/aa17274-11.pdf}
// Precession of the equator                      {http://www.aanda.org/articles/aa/pdf/2012/05/aa17274e-11.pdf}
// The Fortran subroutine ltp PEQU generates the unit vector for the pole of the equator, using the series for XA , YA (Eq. 9 and Tab. 2)
const npol=4;
      nper=14;
      // Polynomials
      xypol: array[1..npol,1..2] of double = (
             (+5453.282155,-73750.930350),
             (+0.4252841,-0.7675452),
             (-0.00037173,-0.00018725),
             (-0.000000152,+0.000000231));
      // Periodics
      xyper: array[1..5,1..nper] of double = (
             (256.75,708.15,274.2,241.45,2309,492.2,396.1,288.9,231.1,1610,620,157.87,220.3,1200),
             (-819.940624,-8444.676815,2600.009459,2755.17563,-167.659835,871.855056,44.769698,-512.313065,-819.415595,-538.071099,-189.793622,-402.922932,179.516345,-9.814756),
             (75004.344875,624.033993,1251.136893,-1102.212834,-2660.66498,699.291817,153.16722,-950.865637,499.754645,-145.18821,558.116553,-23.923029,-165.405086,9.344131),
             (81491.287984,787.163481,1251.296102,-1257.950837,-2966.79973,639.744522,131.600209,-445.040117,584.522874,-89.756563,524.42963,-13.549067,-210.157124,-44.919798),
             (1558.515853,7774.939698,-2219.534038,-2523.969396,247.850422,-846.485643,-1393.124055,368.526116,749.045012,444.704518,235.934465,374.049623,-171.33018,-22.899655));
var as2r, d2pi, t, x, y, w, a, s, c : extended;
    i : integer;
begin
  d2pi:=pi*2;
  as2r:=pi/(180*60*60);//Arcseconds to radians multiplier
  T:=(epj-2451545.0)/36525;// Centuries since J2000.

  x:=0;
  y:=0;
  for i:=1 to nper do begin// Periodic terms.
    W := D2PI*T;
    A := W/XYPER[1,I];
    sincos(A,S,C);
    X := X + C*XYPER[2,I] + S*XYPER[4,I];
    Y := Y + C*XYPER[3,I] + S*XYPER[5,I];
  end;
  //Polynomial terms.
  W := 1;
  for i:=1 to npol do begin
    X := X + XYPOL[I,1]*W;
    Y := Y + XYPOL[I,2]*W;
    W := W*T;
  end;
  // X and Y (direction cosines).
  X := X*AS2R;
  Y := Y*AS2R;
  // Form the equator pole vector.
  VEQ[1] := X;
  VEQ[2] := Y;
  W := X*X + Y*Y;
  IF ( W < 1 ) THEN
    VEQ[3] := SQRT(1-W)
  ELSE
    VEQ[3] := 0;
end;

Procedure ltp_PMAT(epj: extended; var rp: double33 {rotmatrix} );
// Precession matrix, mean J2000.0
// The Fortran subroutine ltp PMAT generates the 3 x 3 rotation matrix P, constructed using Fabri parameterization (i.e. directly from
// the unit vectors for the ecliptic and equator poles  see Sect. 5.4). As well as calling the two previous subroutines, ltp PMAT calls
// subroutines from the IAU SOFA library. The resulting matrix transforms vectors with respect to the mean equator and equinox of
// epoch 2000.0 into mean place of date.
var peqr, pecl, v, eqx : double3;
    w :  double;
begin
  ltp_PEQU(epj,peqr);
  ltp_PECL(epj,pecl);
  sofa_PXP(peqr,pecl,v);
  sofa_pn(v,w,eqx);
  sofa_PXP(peqr,eqx,v);
  RP[1,1]:= EQX[1];
  RP[1,2]:= EQX[2];
  RP[1,3]:= EQX[3];
  RP[2,1]:= V[1];
  RP[2,2]:= V[2];
  RP[2,3]:= V[3];
  RP[3,1]:= PEQR[1];
  RP[3,2]:= PEQR[2];
  RP[3,3]:= PEQR[3];
end;

procedure sofa_cr(r:double33; var c: double33);
// Copy an r-matrix.
var i,j: integer;
begin
for j:=1 to 3 do
  for i:=1 to 3 do c[j,i]:=r[j,i];
end;

procedure sofa_tr(r: double33; var rt: double33);
// Transpose an r-matrix.
var wm: double33;
    i,j: integer;
begin
  for i:=1 to 3 do begin
    for j:=1 to 3 do begin
      wm[i,j] := r[j,i];
    end;
  end;
  sofa_cr ( wm, rt );
end;

procedure sofa_rxr(a,b: double33; var atb: double33);
// Multiply two r-matrices.
var i,j,k: integer;
    w: double;
    wm: double33;
begin
  for i:=1 to 3 do
  begin
    for j:=1 to 3 do begin
      W := 0;
      for k:=1 to 3 do begin
        W := W + A[I,K]*B[K,J];
      end; //k
      WM[I,J] := W;
    end; //j
  end; //i
  sofa_CR ( WM, ATB );
end;

procedure sofa_cp(p: double3; var c: double3);
// Copy a p-vector.
var i: integer;
begin
  for i:=1 to 3 do c[i]:=p[i];
end;

procedure sofa_rxp(r: double33; p: double3; var rp: double3);
// Multiply a p-vector by an r-matrix.
var w: double;
    wrp: double3;
    i,j: integer;
begin
  // Matrix R * vector P.
  for j:=1 to 3 do begin
    W := 0;
    for i:=1 to 3 do begin
      W := W + R[J,I]*P[I];
    end; //i
    WRP[J] := W;
  end; //j
  // Return the result.
  sofa_CP ( WRP, RP );
end;

Procedure PrecessionV(j0,j1: double; var p: double3);
var rp: double3;
    r,wm1,wm2: double33;
    oncache: boolean;
begin
  if j0=2451545.0 then begin       // from j2000
    ltp_PMAT(j1,r);
  end
  else
  if j1=2451545.0 then begin  // to j2000
    ltp_PMAT(j0,wm1);
    sofa_tr(wm1,r);
  end
  else begin                    // from date0 to date1
    ltp_PMAT(j0,r);
    sofa_tr(r,wm1);
    ltp_PMAT(j1,wm2);
    sofa_rxr(wm1,wm2,r);
  end;
  sofa_rxp(r,p,rp);
  sofa_cp(rp,p);
  prec_r:=r;
  prec_j0:=j0;
  prec_j1:=j1;
end;


procedure sofa_S2C(theta,phi: double; var c: double3);
// Convert spherical coordinates to Cartesian.
// THETA    d         longitude angle (radians)
// PHI      d         latitude angle (radians)
var sa,ca,sd,cd: double;
begin
  sincos(theta,sa,ca);
  sincos(phi,sd,cd);
  c[1]:=ca*cd;
  c[2]:=sa*cd;
  c[3]:=sd;
end;

procedure sofa_c2s(p: double3; var theta,phi: double);
// P-vector to spherical coordinates.
// THETA    d         longitude angle (radians)
// PHI      d         latitude angle (radians)
var x,y,z,d2: double;
begin
  X := P[1];
  Y := P[2];
  Z := P[3];
  D2 := X*X + Y*Y;
  IF ( D2 = 0 ) THEN
   theta := 0
  ELSE
    theta := arctan2(Y,X);
  IF ( Z = 0 ) THEN
    phi := 0
  ELSE
    phi := arctan2(Z,SQRT(D2));
end;

FUNCTION fnmodulo (x,range: double):double;
BEGIN
 {range should be 2*pi or 24 hours or 0 .. 360}
  x:=range *frac(X /range); {quick method for big numbers}
  if x<0 then x:=x+range;   {do not like negative numbers}
  fnmodulo:=x;
END;

Procedure Precession(j0,j1,ra0,dec0: double; var ra1,dec1: double);{ precession function, equinox0 to equinox1}
var p: double3;
begin
  sofa_S2C(ra0,dec0,p);
  PrecessionV(j0,j1,p);
  sofa_c2s(p,ra1,dec1);
  ra1:=fnmodulo(ra1,pi*2);
end;
Procedure Precession_cartesian(j0,j1,x0,y0,z0:double; var x1,y1,z1: double);{ precession function, equinox0 to equinox1}
var p: double3;
begin
  p[1]:=x0;
  p[2]:=y0;
  p[3]:=z0;
  PrecessionV(j0,j1,p);
  x1:=p[1];
  y1:=p[2];
  z1:=p[3];
end;


end.
