unit hns_Ucon; {version 2001-10-21}
{Copyright (C) 1997,2018 by Han Kleijn, www.hnsky.org
 email: han.k.. at...hnsky.org

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

Interface

Const

{Bright star name)}
Bright_star_name : array[0..67] of ansistring=
(('Sirius'),{SAO-151881}
('Canopus'),{SAO-234480}
('Vega'),{SAO-67174}
('Alpha_Centauri'),{SAO-252838}
('Capella'),{SAO-40186}
('Arcturus'),{SAO-100944}
('Rigel'),{SAO-131907}
('Procyon'),{SAO-115756}
('Betelgeuse'),{SAO-113271}
('Achernar'),{SAO-232481}
('Altair'),{SAO-125122}
('Hadar'),{SAO-252582}
('Aldebaran'),{SAO-94027}
('Antares'),{SAO-184415}
('Deneb'),{SAO-49941}
('Pollux'),{SAO-79666}
('Regulus'),{SAO-98967}
('Spica'),{SAO-157923}
('Fomalhaut'),{SAO-191524}
('Mimosa'),{SAO-240259}
('Castor'),{SAO-60198}
('Gacrux'),{SAO-240019}
('Acrux'),{SAO-251904}
('Alioth'),{SAO-28553}
('ElNath'),{SAO-77168}
('Bellatrix'),{SAO-112740}
('Alnilam'),{SAO-132346}
('Shaula'),{SAO-208954}
('Avior'),{SAO-235932}
('Miaplacidus'),{SAO-250495}
('Mirphak'),{SAO-38787}
('Alkaid'),{SAO-44752}
('Alhena'),{SAO-95912}
('Regor'),{SAO-219504}
('Atria'),{SAO-253700}
('Dubhe'),{SAO-15384}
('Mira'),{SAO-129825}
('Alnitak'),{SAO-132444}
('Mirzam'),{SAO-151428}
('Wezen'),{SAO-173047}
('Kaus_Australis'),{SAO-210091}
('Sargas'),{SAO-228201}
('Polaris'),{SAO-308}
('Menkalinan'),{SAO-40750}
('Alpheratz'),{SAO-73765}
('Rasalhague'),{SAO-102932}
('Nunki'),{SAO-187448}
('Peacock'),{SAO-246574}
('Kochab'),{SAO-8102}
('Hamal'),{SAO-75151}
('Alphekka'),{SAO-83893}
('Denebola'),{SAO-99809}
('Saiph'),{SAO-132542}
('Alphard'),{SAO-136871}
('Diphda'),{SAO-147420}
('Menkent'),{SAO-205188}
('AlNair'),{SAO-230992}
('Caph'),{SAO-21133}
('Schedar'),{SAO-21609}
('Enif'),{SAO-127029}
('Mintaka'),{SAO-132220}
('Ankaa'),{SAO-215093}
('Algieba'),{SAO-81298}
('Markab'),{SAO-108378}
('Sabik'),{SAO-160332}
('Menkar'),{SAO-110920}
('Gienah'),{SAO-157176}
('Zuben_Elgenubi'));{SAO-158840}

// Bright_star_nr:array[0..67,0..1] of longint=
{saonr,ppmnr}
// ((151881,217626),{Sirius}
// (234480,335149),{Canopus}
// (67174,81558),{Vega}
// (252838,360911),{AlphaCentauri}
// (40186,47925), {Capella}
// (100944,130442), {Arcturus}
// (131907,187839), {Rigel}
// (115756,153068), {Procyon}
// (113271,149643), {Betelgeuse}
// (232481,331199), {Achernar}
// (125122,168779), {Altair}
// (252582,360515), {Hadar}
// (94027,120061),  {Aldebaran}
// (184415,265579), {Antares}
// (49941,60323), {Deneb}
// (79666,97924), {Pollux}
// (98967,127140), {Regulus}
// (157923,227262), {Spica}
// (191524,274426), {Fomalhaut}
// (240259,341305), {Mimosa}
// (60198,72938), {Castor}
// (240019,341058), {Gacrux}
// (251904,359410), {Acrux}
// (28553,33769), {Alioth}
// (77168,94361), {El Nath}
// (112740,148916), {Bellatrix}
// (132346,175945), {Alnilam}
// (208954,296488), {Shaula}
// (235932,336856), {Avior}
// (250495,357200), {Miaplacidus}
// (38787,46127), {Mirphak}
// (44752,53742), {Alkaid}
// (95912,122774), {Alhena}
// (219504,312662), {Regor}
// (253700,362330), {Atria}
// (15384,17705), {Dubhe}
// (129825,184482), {Mira}
// (132444,400076), {Alnitak}
// (151428,217099), {Mirzam}
// (173047,251718), {Wezen}
// (210091,297655), {Kaus Australis}
// (228201,323186), {Sargas}
// (308,431), {Polaris}
// (40750,48617), {Menkalinan}
// (73765,89441), {Alpheratz}
// (102932,133563), {Rasalhague}
// (246574,348537), {Peacock}
// (8102,8758), {Kochab}
// (75151,91373), {Hamal}
// (83893,104146), {Alphekka }
// (99809,128576), {Denebola}
// (132542,188455), {Saiph}
// (136871,192393), {Alphard}
// (147420,209214), {Diphda}
// (205188,292214), {Menkent}
// (230992,327928), {Al Nair}
// (21133,25054), {Caph}
// (21609,25578), {Schedar}
// (127029,172188), {Enif}
// (132220,175888), {Mintaka}
// (215093,304876), {Ankaa}
// (81298,127320), {Algieba}
// (108378,142158), {Markab}
// (160332,232699), {Sabik}
// (110920,146172), {Menkar}
// (157176,225593), {Gienah}
// (187448,269078), {Nunki}
// (158840,229372)); {Zuben Elgenubi}

{Bright star position}
Bright_star_pos : array[0..67,0..1] of single=
((1.76779451, -0.29170371),{Sirius}{SAO-151881}
(1.67531113,-0.91966511),{Canopus}{SAO-234480}
(4.87356557,0.67690254),{Vega}{SAO-67174}
(3.83799109,-1.06172967),{Alpha_Centauri}{SAO-252838}
(1.38181783,0.80281742),{Capella}{SAO-40186}
(3.73352723,0.33479674),{Arcturus}{SAO-100944}
(1.37243081,-0.14309820),{Rigel}{SAO-131907}
(2.00408336,0.09119321),{Procyon}{SAO-115756}
(1.54973031,0.12927758),{Betelgeuse}{SAO-113271}
(0.42636389,-0.99892091),{Achernar}{SAO-232481}
(5.19577269,0.15478188),{Altair}{SAO-125122}
(3.68187821,-1.05365942),{Hadar}{SAO-252582}
(1.20393111,0.28814103),{Aldebaran}{SAO-94027}
(4.31710468,-0.46127731),{Antares}{SAO-184415}
(5.41676966,0.79029128),{Deneb}{SAO-49941}
(2.03032282,0.48914925),{Pollux}{SAO-79666}
(2.65452342,0.20886744),{Regulus}{SAO-98967}
(3.51331859,-0.19475339),{Spica} {SAO-157923}
(6.01113741,-0.51695789),{Fomalhaut}{SAO-191524}
(3.34981706,-1.04171658),{Mimosa}{SAO-240259}
(1.98356636,0.55655901),{Castor}{SAO-60198}
(3.27757953,-0.99676562),{Gacrux}{SAO-240019}
(3.25765313,-1.10123792),{Acrux}{SAO-251904}
(3.37733996,0.97668399),{Alioth}{SAO-28553}
(1.42371731,0.49929333),{ElNath}{SAO-77168}
(1.41865135,0.11082187),{Bellatrix}{SAO-112740}
(1.46700845,-0.02093026),{Alnilam}{SAO-132346}
(4.59723743,-0.64753520),{Shaula}{SAO-208954}
(2.19263079,-1.03858907),{Avior}{SAO-235932}
(2.41379629,-1.21674693),{Miaplacidus}{SAO-250495}
(0.89152671,0.87024198),{Mirphak}{SAO-38787}
(3.61082749,0.86068026),{Alkaid}{SAO-44752}
(1.73534648,0.28622130),{Alhena}{SAO-95912}
(2.13599147,-0.82613292),{Regor}{SAO-219504}
(4.40113394,-1.20471196),{Atria}{SAO-253700}
(2.89606098,1.07775614),{Dubhe}{SAO-15384}
(0.60800954,-0.05192128),{Mira}{SAO-129825}
(1.48684046,-0.03385768),{Alnitak}{SAO-132444}
(1.66984145,-0.31334329),{Mirzam}{SAO-151428}
(1.86920952,-0.46060020),{Wezen}{SAO-173047}
(4.81786289,-0.60007823),{Kaus_Australis}{SAO-210091}
(4.61342550,-0.75040498),{Sargas}{SAO-228201}
(0.66240406,1.55795186),{Polaris}{SAO-308}
(1.56874066,0.78448043),{Menkalinan}{SAO-40750}
(0.03659870,0.50772386),{Alpheratz}{SAO-73765}
(4.60302057,0.21921432),{Rasalhague}{SAO-102932}
(4.95352919,-0.45891642),{Nunki}{SAO-187448}
(5.34789932,-0.99016625),{Peacock}{SAO-246574}
(3.88643920,1.29425734),{Kochab}{SAO-8102}
(0.55489808,0.40949591),{Hamal}{SAO-75151}
(4.07834559,0.46625975),{Alphekka}{SAO-83893}
(3.09385649,0.25433034),{Denebola}{SAO-99809}
(1.51737440,-0.16871991),{Saiph}{SAO-132542}
(2.47656779,-0.15107408),{Alphard}{SAO-136871}
(0.19019602,-0.31387790),{Diphda}{SAO-147420}
(3.69435005,-0.63472893),{Menkent}{SAO-205188}
(5.79551199,-0.81957717),{AlNair}{SAO-230992}
(0.04004941,1.03235727),{Caph}{SAO-21133}
(0.17674822,0.98676273),{Schedar}{SAO-21609}
(5.69058523,0.17235132),{Enif}{SAO-127029}
(1.44865198,-0.00517250),{Mintaka}{SAO-132220}
(0.11468828,-0.73833181),{Ankaa}{SAO-215093}
(2.70513992,0.34630215),{Algieba}{SAO-81298}
(6.04215932,0.26538167),{Markab}{SAO-108378}
(4.49587336,-0.27440224),{Sabik}{SAO-160332}
(0.79534470,0.07137879),{Menkar}{SAO-110920}
(3.21056000,-0.30611661),{Gienah}{SAO-157176}
(3.88719158,-0.27993389));{Zuben_Elgenubi}{SAO-158840}

{Bright star position}
{Bright_star_pos : array[0..67,0..1] of integer=  {RA [0..24000],Dec [-9000..9000] }
{({(6752,-1671),{Sirius SAO-151881}
{(6399,-5269),{Canopus SAO-234480}
{(18616,3878),{Vega SAO-67174}
{(14660,-6083),{Alpha Centauri SAO-252838}
{(5278,4600),{Capella SAO-40186}
{(14261,1918),{Arcturus SAO-100944}
{(5242,-820),{Rigel SAO-131907}
{(7655,522),{Procyon SAO-115756}
{(5920,741),{Betelgeuse SAO-113271}
{(1629,-5723),{Achernar SAO-232481}
{(19846,887),{Altair SAO-125122}
{(14064,-6037),{Hadar SAO-252582}
{(4599,1651),{Aldebaran SAO-94027}
{(16490,-2643),{Antares SAO-184415}
{(20691,4528),{Deneb SAO-49941}
{(7755,2803),{Pollux SAO-79666}
{(10140,1197),{Regulus SAO-98967}
{(13420,-1116),{Spica SAO-157923}
{(22961,-2962),{Fomalhaut SAO-191524}
{(12795,-5969),{Mimosa SAO-240259}
{(7577,3189),{Castor SAO-60198}
{(12519,-5711),{Gacrux SAO-240019}
{(12443,-6310),{Acrux SAO-251904}
{(12900,5596),{Alioth SAO-28553}
{(5438,2861),{El Nath SAO-77168}
{(5419,635),{Bellatrix SAO-112740}
{(5604,-120),{Alnilam SAO-132346}
{(17560,-3710),{Shaula SAO-208954}
{(8375,-5951),{Avior SAO-235932}
{(9220,-6971),{Miaplacidus SAO-250495}
{(3405,4986),{Mirphak SAO-38787}
{(13792,4931),{Alkaid SAO-44752}
{(6629,1640),{Alhena SAO-95912}
{(8159,-4733),{Regor SAO-219504}
{(16811,-6902),{Atria SAO-253700}
{(11062,6175),{Dubhe SAO-15384}
{(2322,-297),{Mira SAO-129825}
{(5679,-194),{Alnitak SAO-132444}
{(6378,-1795),{Mirzam SAO-151428}
{(7140,-2639),{Wezen SAO-173047}
{(18403,-3438),{Kaus Australis SAO-210091}
{(17622,-4300),{Sargas SAO-228201}
{(2530,8926),{Polaris SAO-308}
{(5992,4495),{Menkalinan SAO-40750}
{(140,2909),{Alpheratz SAO-73765}
{(17582,1256),{Rasalhague SAO-102932}
{(20427,-5673),{Peacock SAO-246574}
{(14845,7416),{Kochab SAO-8102}
{(2120,2346),{Hamal SAO-75151}
{(15578,2671),{Alphekka  SAO-83893}
{(11818,1457),{Denebola SAO-99809}
{(5796,-967),{Saiph SAO-132542}
{(9460,-866),{Alphard SAO-136871}
{(726,-1798),{Diphda SAO-147420}
{(14111,-3637),{Menkent SAO-205188}
{(22137,-4696),{Al Nair SAO-230992}
{(153,5915),{Caph SAO-21133}
{(675,5654),{Schedar SAO-21609}
{(21736,988),{Enif SAO-127029}
{(5533,-30),{Mintaka SAO-132220}
{(438,-4230),{Ankaa SAO-215093}
{(10333,1984),{Algieba SAO-81298}
{(23079,1521),{Markab SAO-108378}
{(17173,-1572),{Sabik SAO-160332}
{(3038,409),{Menkar SAO-110920}
{(12263,-1754),{Gienah SAO-157176}
{(18350,-2983),{Nunki SAO-186681}
{(14848,-1604)); {Zuben Elgenubi SAO-158840}



type
   const_star = record
        dm    : smallint;{drawing mode, -2=start/ -1=draw}
        ra    : smallint;{ra [0..24000]}
        dec   : smallint;{dec[-9000..9000]}
        bay   : pchar; {bayer letter}
   end;

const
constellation_length=602;
Constellation : array[0..constellation_length] of const_star=
{constellation lines and bayer letter
{Format: -2=start/ -1=draw,RA [0..24000],Dec [-9000..9000], bayer letter}
((dm:-2;ra:140;dec:2909;bay:'α'),   {Alpha And} {0}
(dm:-1;ra:655;dec:3086;bay:'δ'),   {Delta And} {0}
(dm:-1;ra:1162;dec:3562;bay:'β'),  {Beta And} {0}
(dm:-1;ra:2065;dec:4233;bay:'γ'), {Gamma 1 And} {0}
(dm:-2;ra:1162;dec:3562;bay:'β'),  {Beta And} {0}
(dm:-1;ra:946;dec:3850;bay:'μ'), {Mu And} {0}
(dm:-1;ra:830;dec:4108;bay:'ν'),  {Nu And} {0}
(dm:-2;ra:10945;dec:-3714;bay:'ι'),  {Iota Ant} {1}
(dm:-1;ra:10453;dec:-3107;bay:'α'), {Alpha Ant} {1}
(dm:-1;ra:9487;dec:-3595;bay:'ε'), {Epsilon Ant} {1}
(dm:-2;ra:14798;dec:-7904;bay:'α'), {Alpha Aps} {2}
(dm:-1;ra:16558;dec:-7890;bay:'γ'), {Gamma Aps} {2}
(dm:-1;ra:16718;dec:-7752;bay:'β'),  {Beta Aps} {2}
(dm:-2;ra:22877;dec:-758;bay:'λ'),  {Lambda Aqr} {3}
(dm:-1;ra:22589;dec:-12;bay:'η'),   {Eta Aqr} {3}
(dm:-1;ra:22480;dec:-2;bay:'ζ'),  {Zeta 1 Aqr} {3}
(dm:-1;ra:22361;dec:-139;bay:'γ'), {Gamma Aqr} {3}
(dm:-1;ra:22096;dec:-32;bay:'α'), {Alpha Aqr} {3}
(dm:-1;ra:21526;dec:-557;bay:'β'),  {Beta Aqr} {3}
(dm:-1;ra:20795;dec:-950;bay:'ε'), {Epsilon Aqr} {3}
(dm:-2;ra:22361;dec:-139;bay:'γ'), {Gamma Aqr} {3}
(dm:-1;ra:22281;dec:-778;bay:'θ'), {Theta Aqr} {3}
(dm:-1;ra:22911;dec:-1582;bay:'δ'), {Delta Aqr} {3}
(dm:-2;ra:20189;dec:-82;bay:'θ'), {Theta Aql} {4}
(dm:-1;ra:19922;dec:641;bay:'β'),  {Beta Aql} {4}
(dm:-1;ra:19846;dec:887;bay:'α'), {Alpha Aql} {4}
(dm:-1;ra:19771;dec:1061;bay:'γ'), {Gamma Aql} {4}
(dm:-1;ra:19090;dec:1386;bay:'ζ'),  {Zeta Aql} {4}
(dm:-1;ra:18994;dec:1507;bay:'ε'), {Epsilon Aql} {4}
(dm:-2;ra:19846;dec:887;bay:'α'), {Alpha Aql} {4}
(dm:-1;ra:19425;dec:311;bay:'δ'), {Delta Aql} {4}
(dm:-1;ra:19104;dec:-488;bay:'λ'),  {Lambda Aql} {4}
(dm:-2;ra:18110;dec:-5009;bay:'θ'), {Theta Ara} {5}
(dm:-1;ra:17531;dec:-4988;bay:'α'), {Alpha Ara} {5}
(dm:-1;ra:17422;dec:-5553;bay:'β'),  {Beta Ara} {5}
(dm:-1;ra:17423;dec:-5638;bay:'γ'), {Gamma Ara} {5}
(dm:-1;ra:17518;dec:-6068;bay:'δ'), {Delta Ara} {5}
(dm:-2;ra:17422;dec:-5553;bay:'β'),  {Beta Ara} {5}
(dm:-1;ra:16977;dec:-5599;bay:'ζ'),  {Zeta Ara} {5}
(dm:-1;ra:16830;dec:-5904;bay:'η'),   {Eta Ara} {5}
(dm:-2;ra:2833;dec:2726;bay:'41'), {41 Ari} {6}
(dm:-1;ra:2120;dec:2346;bay:'α'),  {Alpha Ari} {6}
(dm:-1;ra:1911;dec:2081;bay:'β'), {Beta Ari} {6}
(dm:-1;ra:1892;dec:1930;bay:'γ'),  {Gamma 1 Ari B} {6}
(dm:-2;ra:5278;dec:4600;bay:'α'),  {Alpha Aur} {7}
(dm:-1;ra:5033;dec:4382;bay:'ε'),   {Epsilon Aur} {7}
(dm:-1;ra:4950;dec:3317;bay:'ι'), {Iota Aur} {7}
(dm:-1;ra:5438;dec:2861;bay:'β'), {Beta Tau} {78}
(dm:-1;ra:5995;dec:3721;bay:'θ'),  {Theta Aur} {7}
(dm:-1;ra:5992;dec:4495;bay:'β'), {Beta Aur} {7}
(dm:-1;ra:5278;dec:4600;bay:'α'),  {Alpha Aur} {7}
(dm:-2;ra:13911;dec:1840;bay:'η'),  {Eta Boo} {8}
(dm:-1;ra:14261;dec:1918;bay:'α'),  {Alpha Boo} {8}
(dm:-1;ra:14531;dec:3037;bay:'ρ'),  {Rho Boo} {new 2001-10-21} {8}
(dm:-1;ra:14535;dec:3831;bay:'γ'),  {Gamma Boo} {8}
(dm:-1;ra:15032;dec:4039;bay:'β'), {Beta Boo} {8}
(dm:-1;ra:15258;dec:3331;bay:'δ'),  {Delta Boo} {8}
(dm:-1;ra:14750;dec:2707;bay:'ε'),   {Epsilon Boo} {8}
(dm:-1;ra:14261;dec:1918;bay:'α'),  {Alpha Boo} {8}
(dm:-1;ra:14686;dec:1373;bay:'ζ'), {Zeta Boo} {8}
(dm:-2;ra:4514;dec:-4495;bay:'δ'),  {Delta Cae} {9}
(dm:-1;ra:4676;dec:-4186;bay:'1'),  {1 Cae} {9}
(dm:-1;ra:4701;dec:-3714;bay:'β'), {Beta Cae} {9}
(dm:-1;ra:5073;dec:-3548;bay:'γ'),  {Gamma Cae} {9}
(dm:-2;ra:12821;dec:8341;bay:''),  {SAO2102 Cam} {10}
(dm:-1;ra:7001;dec:7698;bay:''), {6022 Cam} {10}
(dm:-1;ra:6314;dec:6932;bay:''), {SAO13788 Cam} {10}
(dm:-1;ra:4901;dec:6634;bay:'α'),  {Alpha Cam} {10}
(dm:-1;ra:5057;dec:6044;bay:'β'), {Beta Cam} {10}
(dm:-1;ra:4955;dec:5375;bay:'7'),  {7 Cam} {10}
(dm:-2;ra:3484;dec:5994;bay:'CS'), {CS Cam} {10}
(dm:-1;ra:3825;dec:6553;bay:'BE'), {BE Cam} {10}
(dm:-1;ra:3839;dec:7133;bay:'γ'),  {Gamma Cam} {10}
(dm:-1;ra:6314;dec:6932;bay:''), {SAO13788 Cam} {10}
(dm:-2;ra:8975;dec:1186;bay:'α'),  {Alpha Cnc} {11}
(dm:-1;ra:8745;dec:1815;bay:'δ'),  {Delta Cnc} {11}
(dm:-1;ra:8721;dec:2147;bay:'γ'),  {Gamma Cnc} {11}
(dm:-1;ra:8778;dec:2876;bay:'ι'), {Iota Cnc} {11}
(dm:-2;ra:8275;dec:919;bay:'β'), {Beta Cnc} {11}
(dm:-1;ra:8745;dec:1815;bay:'δ'),  {Delta Cnc} {11}
(dm:-1;ra:8204;dec:1765;bay:'ζ'), {Zeta Cnc} {11}
(dm:-2;ra:12933;dec:3831;bay:'α'),  {Alpha 1 CVn} {12}
(dm:-1;ra:12562;dec:4136;bay:'β'), {Beta CVn} {12}
(dm:-2;ra:7402;dec:-2930;bay:'η'),  {Eta CMa} {13}
(dm:-1;ra:7140;dec:-2639;bay:'δ'),  {Delta CMa} {13}
(dm:-1;ra:6752;dec:-1672;bay:'α'),  {Alpha CMa} {13}
(dm:-1;ra:6378;dec:-1796;bay:'β'), {Beta CMa} {13}
(dm:-2;ra:7063;dec:-1563;bay:'γ'),  {Gamma CMa} {13}
(dm:-1;ra:6936;dec:-1705;bay:'ι'), {Iota CMa} {13}
(dm:-1;ra:6752;dec:-1672;bay:'α'),  {Alpha CMa} {13}
(dm:-2;ra:6977;dec:-2897;bay:'ε'),   {Epsilon CMa} {13}
(dm:-1;ra:7140;dec:-2639;bay:'δ'),  {Delta CMa} {13}
(dm:-2;ra:7655;dec:523;bay:'α'),  {Alpha CMi} {14}
(dm:-1;ra:7453;dec:829;bay:'β'), {Beta CMi} {14}
(dm:-1;ra:7469;dec:893;bay:'γ'),  {Gamma CMi} {14}
(dm:-2;ra:20294;dec:-1251;bay:'α'),  {Alpha 1 Cap} {15}
(dm:-1;ra:20301;dec:-1255;bay:'α2'),   {Alpha2 Cap} {15}
(dm:-1;ra:20350;dec:-1478;bay:'β'), {Beta 1 Cap} {15}
(dm:-1;ra:20768;dec:-2527;bay:'ψ'),  {Psi Cap} {15}
(dm:-1;ra:20864;dec:-2692;bay:'ω'),  {Omega Cap} {15}
(dm:-1;ra:21444;dec:-2241;bay:'ζ'), {Zeta Cap} {15}
(dm:-1;ra:21784;dec:-1613;bay:'δ'),  {Delta Cap} {15}
(dm:-1;ra:21668;dec:-1666;bay:'γ'),  {Gamma Cap} {15}
(dm:-1;ra:21371;dec:-1683;bay:'ι'), {Iota Cap} {15}
(dm:-1;ra:21099;dec:-1723;bay:'θ'),  {Theta Cap} {15}
(dm:-1;ra:20350;dec:-1478;bay:'β'), {Beta 1 Cap} {15}
(dm:-2;ra:6399;dec:-5270;bay:'α'),  {Alpha Car} {16}
(dm:-1;ra:7946;dec:-5298;bay:'χ'),  {Chi Car} {16}
(dm:-1;ra:8375;dec:-5951;bay:'ε'),   {Epsilon Car} {16}
(dm:-1;ra:9183;dec:-5897;bay:'a'),  {a Car} {16}
(dm:-1;ra:9285;dec:-5928;bay:'ι'), {Iota Car} {16}
(dm:-1;ra:10285;dec:-6133;bay:'q'),  {q Car} {16}
(dm:-1;ra:10716;dec:-6439;bay:'θ'),  {Theta Car} {16}
(dm:-1;ra:10229;dec:-7004;bay:'ω'),  {Omega Car} {16}
(dm:-1;ra:9220;dec:-6972;bay:'β'), {Beta Car} {16}
(dm:-1;ra:9785;dec:-6507;bay:'υ'),  {Upsilon Car} {16}
(dm:-1;ra:9285;dec:-5928;bay:'ι'), {Iota Car} {16}
(dm:-2;ra:1907;dec:6367;bay:'ε'),   {Epsilon Cas} {17}
(dm:-1;ra:1430;dec:6024;bay:'δ'),  {Delta Cas} {17}
(dm:-1;ra:945;dec:6072;bay:'γ'),  {Gamma Cas} {17}
(dm:-1;ra:675;dec:5654;bay:'α'),  {Alpha Cas} {17}
(dm:-1;ra:153;dec:5915;bay:'β'), {Beta Cas} {17}
(dm:-2;ra:14660;dec:-6084;bay:'α'),  {Alpha 1 Cen} {18}
(dm:-1;ra:14064;dec:-6037;bay:'β'), {Beta Cen} {18}
(dm:-1;ra:13665;dec:-5347;bay:'ε'),   {Epsilon Cen} {18}
(dm:-1;ra:13926;dec:-4729;bay:'ζ'), {Zeta Cen} {18}
(dm:-1;ra:14592;dec:-4216;bay:'η'),  {Eta Cen} {18}
(dm:-1;ra:14111;dec:-3637;bay:'θ'),  {Theta Cen} {18}
(dm:-1;ra:13343;dec:-3671;bay:'ι'), {Iota Cen} {18}
(dm:-1;ra:12692;dec:-4896;bay:'γ'),  {Gamma Cen} {18}
(dm:-2;ra:12139;dec:-5072;bay:'δ'),  {Delta Cen} {18}
(dm:-1;ra:12692;dec:-4896;bay:'γ'),  {Gamma Cen} {18}
(dm:-1;ra:13665;dec:-5347;bay:'ε'),   {Epsilon Cen} {18}
(dm:-2;ra:21478;dec:7056;bay:'β'), {Beta Cep} {19}
(dm:-1;ra:21310;dec:6259;bay:'α'),  {Alpha Cep} {19}
(dm:-1;ra:22486;dec:5842;bay:'δ'),  {Delta Cep} {19}
(dm:-1;ra:22828;dec:6620;bay:'ι'), {Iota Cep} {19}
(dm:-1;ra:23656;dec:7763;bay:'γ'),  {Gamma Cep} {19}
(dm:-1;ra:21478;dec:7056;bay:'β'), {Beta Cep} {19}
(dm:-1;ra:22828;dec:6620;bay:'ι'), {Iota Cep} {19}
(dm:-2;ra:3038;dec:409;bay:'α'),  {Alpha Cet} {20}
(dm:-1;ra:2722;dec:324;bay:'γ'),  {Gamma Cet} {20}
(dm:-1;ra:2658;dec:33;bay:'δ'),  {Delta Cet} {20}
(dm:-1;ra:2322;dec:-298;bay:'ο'),   {Omicron Cet} {20}
(dm:-1;ra:1858;dec:-1034;bay:'ζ'), {Zeta Cet} {20}
(dm:-1;ra:1734;dec:-1594;bay:'τ'),  {Tau Cet} {20}
(dm:-1;ra:726;dec:-1799;bay:'β'), {Beta Cet} {20}
(dm:-1;ra:324;dec:-882;bay:'ι'), {Iota Cet} {20}
(dm:-2;ra:1858;dec:-1034;bay:'ζ'), {Zeta Cet} {20}
(dm:-1;ra:1400;dec:-818;bay:'θ'),  {Theta Cet} {20}
(dm:-1;ra:1143;dec:-1018;bay:'η'),  {Eta Cet} {20}
(dm:-1;ra:726;dec:-1799;bay:'β'), {Beta Cet} {20}
(dm:-2;ra:8309;dec:-7692;bay:'α'),  {Alpha Cha} {21}
(dm:-1;ra:10591;dec:-7861;bay:'γ'),  {Gamma Cha} {21}
(dm:-1;ra:12306;dec:-7931;bay:'β'), {Beta Cha} {21}
(dm:-1;ra:10763;dec:-8054;bay:'δ2'),   {Delta2 Cha} {21}
(dm:-1;ra:8344;dec:-7748;bay:'θ'),  {Theta Cha} {21}
(dm:-1;ra:8309;dec:-7692;bay:'α'),  {Alpha Cha} {21}
(dm:-2;ra:15292;dec:-5880;bay:'β'), {Beta Cir} {22}
(dm:-1;ra:14708;dec:-6498;bay:'α'),  {Alpha Cir} {22}
(dm:-1;ra:15390;dec:-5932;bay:'γ'),  {Gamma Cir} {22}
(dm:-2;ra:6369;dec:-3344;bay:'δ'),  {Delta Col} {23}
(dm:-1;ra:5849;dec:-3577;bay:'β'), {Beta Col} {23}
(dm:-1;ra:5661;dec:-3407;bay:'α'),  {Alpha Col} {23}
(dm:-1;ra:5520;dec:-3547;bay:'ε'),   {Epsilon Col} {23}
(dm:-1;ra:5849;dec:-3577;bay:'β'), {Beta Col} {23}
(dm:-2;ra:13166;dec:1753;bay:'α'),  {Alpha Com} {24}
(dm:-1;ra:13198;dec:2788;bay:'β'), {Beta Com} {24}
(dm:-1;ra:12449;dec:2827;bay:'γ'),  {Gamma Com} {24}
(dm:-2;ra:19107;dec:-3706;bay:'γ'),  {Gamma CrA} {25}
(dm:-1;ra:19158;dec:-3790;bay:'α'),  {Alpha CrA} {25}
(dm:-1;ra:19167;dec:-3934;bay:'β'), {Beta CrA} {25}
(dm:-2;ra:15960;dec:2688;bay:'ε'),   {Epsilon CrB} {26}
(dm:-1;ra:15712;dec:2630;bay:'γ'),  {Gamma CrB} {26}
(dm:-1;ra:15578;dec:2671;bay:'α'),  {Alpha CrB} {26}
(dm:-1;ra:15464;dec:2911;bay:'β'), {Beta CrB} {26}
(dm:-1;ra:15549;dec:3136;bay:'θ'),  {Theta CrB} {26}
(dm:-2;ra:12140;dec:-2473;bay:'α'),  {Alpha Crv} {27}
(dm:-1;ra:12169;dec:-2262;bay:'ε'),   {Epsilon Crv} {27}
(dm:-1;ra:12263;dec:-1754;bay:'γ'),  {Gamma Crv} {27}
(dm:-1;ra:12498;dec:-1652;bay:'δ'),  {Delta Crv} {27}
(dm:-1;ra:12573;dec:-2340;bay:'β'), {Beta Crv} {27}
(dm:-1;ra:12169;dec:-2262;bay:'ε'),   {Epsilon Crv} {27}
(dm:-2;ra:10996;dec:-1830;bay:'α'),  {Alpha Crt} {28}
(dm:-1;ra:11194;dec:-2283;bay:'β'), {Beta Crt} {28}
(dm:-1;ra:11415;dec:-1768;bay:'γ'),  {Gamma Crt} {28}
(dm:-1;ra:11322;dec:-1478;bay:'δ'),  {Delta Crt} {28}
(dm:-1;ra:10996;dec:-1830;bay:'α'),  {Alpha Crt} {28}
(dm:-2;ra:12443;dec:-6310;bay:'α'),  {Alpha 1 Cru} {29}
(dm:-1;ra:12519;dec:-5711;bay:'γ'),  {Gamma Cru a} {29}
(dm:-2;ra:12795;dec:-5969;bay:'β'), {Beta Crux} {29}
(dm:-1;ra:12252;dec:-5875;bay:'δ'),  {Delta Cru} {29}
(dm:-2;ra:20691;dec:4528;bay:'α'),  {Alpha Cyg} {30}
(dm:-1;ra:20370;dec:4026;bay:'γ'),  {Gamma Cyg} {30}
(dm:-1;ra:19938;dec:3508;bay:'η'),  {Eta Cyg} {30}
(dm:-1;ra:19843;dec:3291;bay:'χ'),  {Chi Cyg} {30}
(dm:-1;ra:19513;dec:2797;bay:'β'), {Beta Cyg} {30}
(dm:-2;ra:21216;dec:3023;bay:'ζ'), {Zeta Cyg} {30}
(dm:-1;ra:20770;dec:3397;bay:'ε'),   {Epsilon Cyg} {30}
(dm:-1;ra:20370;dec:4026;bay:'γ'),  {Gamma Cyg} {30}
(dm:-1;ra:19750;dec:4513;bay:'δ'),  {Delta Cyg} {30}
(dm:-1;ra:19495;dec:5173;bay:'ι'), {Iota Cyg} {30}
(dm:-1;ra:19285;dec:5337;bay:'κ'),  {Kappa Cyg} {30}
(dm:-2;ra:20554;dec:1130;bay:'ε'),   {Epsilon Del} {31}
(dm:-1;ra:20588;dec:1467;bay:'ζ'), {Zeta Del} {31}
(dm:-1;ra:20661;dec:1591;bay:'α'),  {Alpha Del} {31}
(dm:-1;ra:20777;dec:1612;bay:'γ'),  {Gamma 1 Del} {31}
(dm:-1;ra:20724;dec:1507;bay:'δ'),  {Delta Del} {31}
(dm:-1;ra:20626;dec:1460;bay:'β'), {Beta Del} {31}
(dm:-1;ra:20588;dec:1467;bay:'ζ'), {Zeta Del} {31}
(dm:-2;ra:4267;dec:-5149;bay:'γ'),  {Gamma Dor} {32}
(dm:-1;ra:4567;dec:-5505;bay:'α'),  {Alpha Dor} {32}
(dm:-1;ra:5560;dec:-6249;bay:'β'), {Beta Dor} {32}
(dm:-1;ra:5746;dec:-6574;bay:'δ'),  {Delta Dor} {32}
(dm:-2;ra:12558;dec:6979;bay:'κ'),  {Kappa Dra} {33}
(dm:-1;ra:14073;dec:6438;bay:'α'),  {Alpha Dra} {33}
(dm:-1;ra:15415;dec:5897;bay:'ι'), {Iota Dra} {33}
(dm:-1;ra:16031;dec:5857;bay:'θ'),  {Theta Dra} {33}
(dm:-1;ra:16400;dec:6151;bay:'η'),  {Eta Dra} {33}
(dm:-1;ra:17146;dec:6571;bay:'ζ'), {Zeta Dra} {33}
(dm:-1;ra:19803;dec:7027;bay:'ε'),   {Epsilon Dra} {33}
(dm:-1;ra:19209;dec:6766;bay:'δ'),  {Delta Dra} {33}
(dm:-1;ra:17536;dec:5518;bay:'ν'), {Nu 1 Dra} {33}
(dm:-1;ra:17507;dec:5230;bay:'β'), {Beta Dra} {33}
(dm:-1;ra:17943;dec:5149;bay:'γ'),  {Gamma Dra} {33}
(dm:-1;ra:17536;dec:5518;bay:'ν'), {Nu 1 Dra} {33}
(dm:-2;ra:21264;dec:525;bay:'α'),  {Alpha Equ} {34}
(dm:-1;ra:21241;dec:1001;bay:'δ'),  {Delta Equ} {34}
(dm:-1;ra:21172;dec:1013;bay:'γ'),  {Gamma Equ} {34}
(dm:-1;ra:20985;dec:429;bay:'ε'),   {Epsilon Equ} {34}
(dm:-1;ra:21264;dec:525;bay:'α'),  {Alpha Equ} {34}
(dm:-2;ra:5131;dec:-509;bay:'β'), {Beta Eri} {35}
(dm:-1;ra:4605;dec:-335;bay:'ν'), {Nu Eri} {35}
(dm:-1;ra:3967;dec:-1351;bay:'γ'),  {Gamma Eri} {35}
(dm:-1;ra:3721;dec:-976;bay:'δ'),  {Delta Eri} {35}
(dm:-1;ra:3549;dec:-946;bay:'ε'),   {Epsilon Eri} {35}
(dm:-1;ra:2940;dec:-890;bay:'η'), {Eta Eri} {35}
(dm:-1;ra:4298;dec:-3380;bay:'41'), {41 Eri} {35}
(dm:-1;ra:2971;dec:-4030;bay:'θ'), {Theta 1 Eri} {35}
(dm:-1;ra:2275;dec:-5150;bay:'φ'),  {phi Eri} {35}
(dm:-1;ra:1933;dec:-5161;bay:'χ'),  {Chi Eri} {35}
(dm:-1;ra:1629;dec:-5724;bay:'α'),  {Alpha Eri} {35}
(dm:-2;ra:3704;dec:-3194;bay:'δ'),  {Delta For} {36}
(dm:-1;ra:3201;dec:-2899;bay:'α'),  {Alpha For} {36}
(dm:-1;ra:2818;dec:-3241;bay:'β'), {Beta For} {36}
(dm:-1;ra:2075;dec:-2930;bay:'ν'), {Nu For} {36}
(dm:-2;ra:6629;dec:1640;bay:'γ'),  {Gamma Gem} {37}
(dm:-1;ra:7068;dec:2057;bay:'ζ'), {Zeta Gem} {37}
(dm:-1;ra:7335;dec:2198;bay:'δ'),  {Delta Gem} {37}
(dm:-1;ra:7755;dec:2803;bay:'β'), {Beta Gem} {37}
(dm:-1;ra:7577;dec:3189;bay:'α'),  {Alpha Gem} {37}
(dm:-1;ra:6732;dec:2513;bay:'ε'),   {Epsilon Gem} {37}
(dm:-1;ra:6383;dec:2251;bay:'μ'), {Mu Gem {37}
(dm:-1;ra:6248;dec:2251;bay:'η'),  {Eta Gem} {37}
(dm:-2;ra:21899;dec:-3737;bay:'γ'),  {Gamma Gru} {38}
(dm:-1;ra:22488;dec:-4350;bay:'δ'),  {Delta 1 Gru} {38}
(dm:-1;ra:22496;dec:-4375;bay:'δ2'),   {Delta2 Gru} {38}
(dm:-1;ra:22711;dec:-4688;bay:'β'), {Beta Gru} {38}
(dm:-1;ra:22809;dec:-5132;bay:'ε'),   {Epsilon Gru} {38}
(dm:-1;ra:23015;dec:-5275;bay:'ζ'), {Zeta Gru} {38}
(dm:-2;ra:22137;dec:-4696;bay:'α'),  {Alpha Gru} {38}
(dm:-1;ra:22488;dec:-4350;bay:'δ'),  {Delta 1 Gru} {38}
(dm:-2;ra:17938;dec:3725;bay:'θ'),  {Theta Her} {39}
(dm:-1;ra:17251;dec:3681;bay:'π'), {Pi Her} {39}
(dm:-1;ra:17005;dec:3093;bay:'ε'),   {Epsilon Her} {39}
(dm:-1;ra:17251;dec:2484;bay:'δ'),  {Delta Her} {39}
(dm:-1;ra:17244;dec:1439;bay:'α'),  {Alpha 1 Her} {39}
(dm:-2;ra:17251;dec:3681;bay:'π'), {Pi Her} {39}
(dm:-1;ra:16715;dec:3892;bay:'η'),  {Eta Her} {39}
(dm:-1;ra:16688;dec:3160;bay:'ζ'), {Zeta Her} {39}
(dm:-1;ra:16504;dec:2149;bay:'β'), {Beta Her} {39}
(dm:-1;ra:16365;dec:1915;bay:'γ'),  {Gamma Her} {39}
(dm:-2;ra:17005;dec:3093;bay:'ε'),   {Epsilon Her} {39}
(dm:-1;ra:16688;dec:3160;bay:'ζ'), {Zeta Her} {39}
(dm:-2;ra:16715;dec:3892;bay:'η'),  {Eta Her} {39}
(dm:-1;ra:16568;dec:4244;bay:'σ'),  {Sigma Her} {39}
(dm:-1;ra:16329;dec:4631;bay:'τ'),  {Tau Her} {39}
(dm:-2;ra:4233;dec:-4229;bay:'α'),  {Alpha Hor} {40}
(dm:-1;ra:2623;dec:-5254;bay:'η'),  {Eta Hor} {40}
(dm:-1;ra:2980;dec:-6407;bay:'β'), {Beta Hor} {40}
(dm:-2;ra:14106;dec:-2668;bay:'π'), {Pi Hya} {41}
(dm:-1;ra:13495;dec:-2328;bay:'R'),  {R Hya} {41}
(dm:-1;ra:13315;dec:-2317;bay:'γ'),  {Gamma Hya} {41}
(dm:-1;ra:11882;dec:-3391;bay:'β'), {Beta Hya} {41}
(dm:-1;ra:11550;dec:-3186;bay:'ξ'), {Xi Hya} {41}
(dm:-1;ra:10827;dec:-1619;bay:'ν'), {Nu Hya} {41}
(dm:-1;ra:10176;dec:-1235;bay:'λ'),  {Lambda Hya} {NIEUW HAN} {41}
(dm:-1;ra:9858;dec:-1485;bay:'υ'),   {Upsilon 1 Hya} {nieuw han} {41}
(dm:-1;ra:9460;dec:-866;bay:'α'),  {Alpha Hya} {41}
(dm:-1;ra:9664;dec:-114;bay:'ι'),   {Iota Hya} {nieuw han} {41}
(dm:-1;ra:9239;dec:231;bay:'θ'),    {Theta Hya} {nieuw han} {41}
(dm:-1;ra:8923;dec:595;bay:'ζ'), {Zeta Hya} {41}
(dm:-1;ra:8780;dec:642;bay:'ε'),   {Epsilon Hya} {41}
(dm:-1;ra:8628;dec:570;bay:'δ'),  {Delta Hya} {41}
(dm:-1;ra:8720;dec:340;bay:'η'),  {Eta Hya} {41}
(dm:-1;ra:8923;dec:595;bay:'ζ'), {Zeta Hya} {41}
(dm:-2;ra:1980;dec:-6157;bay:'α'),  {Alpha Hyi} {42}
(dm:-1;ra:429;dec:-7725;bay:'β'), {Beta Hyi} {42}
(dm:-1;ra:3787;dec:-7424;bay:'γ'),  {Gamma Hyi} {42}
(dm:-1;ra:1980;dec:-6157;bay:'α'),  {Alpha Hyi} {42}
(dm:-2;ra:20626;dec:-4729;bay:'α'),  {Alpha Ind} {43}
(dm:-1;ra:21331;dec:-5345;bay:'θ'),  {Theta Ind} {43}
(dm:-1;ra:20913;dec:-5845;bay:'β'), {Beta Ind} {43}
(dm:-2;ra:21331;dec:-5345;bay:'θ'),  {Theta Ind} {43}
(dm:-1;ra:21965;dec:-5499;bay:'δ'),  {Delta Ind} {43}
(dm:-2;ra:22393;dec:5223;bay:'β'), {Beta Lac} {44}
(dm:-1;ra:22522;dec:5028;bay:'α'),  {Alpha Lac} {44}
(dm:-1;ra:22266;dec:3775;bay:'1'),  {1 Lac} {44}
(dm:-2;ra:9764;dec:2377;bay:'ε'),  {Epsilon Leo} {45}
(dm:-1;ra:10278;dec:2342;bay:'ζ'), {Zeta Leo} {45}
(dm:-1;ra:10333;dec:1984;bay:'γ'),  {Gamma Leo} {45}
(dm:-1;ra:10122;dec:1676;bay:'η'),  {Eta Leo} {45}
(dm:-1;ra:10140;dec:1197;bay:'α'),  {Alpha Leo} {45}
(dm:-1;ra:11237;dec:1543;bay:'θ'),  {Theta Leo} {45}
(dm:-1;ra:11818;dec:1457;bay:'β'), {Beta Leo} {45}
(dm:-1;ra:11235;dec:2052;bay:'δ'),  {Delta Leo} {45}
(dm:-1;ra:10333;dec:1984;bay:'γ'),  {Gamma Leo} {45}
(dm:-2;ra:10889;dec:3421;bay:'46'), {46 LMi} {46}
(dm:-1;ra:10465;dec:3671;bay:'β'), {Beta LMi} {46}
(dm:-1;ra:10124;dec:3524;bay:'21'), {21 LMi} {46}
(dm:-1;ra:9570;dec:3640;bay:'10'), {10 LMi} {46}
(dm:-2;ra:5940;dec:-1417;bay:'η'),  {Eta Lep} {47}
(dm:-1;ra:5855;dec:-2088;bay:'δ'),  {Delta Lep} {47}
(dm:-1;ra:5741;dec:-2245;bay:'γ'),  {Gamma Lep} {47}
(dm:-1;ra:5471;dec:-2076;bay:'β'), {Beta Lep} {47}
(dm:-1;ra:5091;dec:-2237;bay:'ε'),   {Epsilon Lep} {47}
(dm:-1;ra:5216;dec:-1621;bay:'μ'), {Mu Lep} {47}
(dm:-1;ra:5545;dec:-1782;bay:'α'),  {Alpha Lep} {47}
(dm:-1;ra:5855;dec:-2088;bay:'δ'),  {Delta Lep} {47}
(dm:-1;ra:5783;dec:-1482;bay:'ζ'), {Zeta Lep} {47}
(dm:-2;ra:5545;dec:-1782;bay:'α'),  {Alpha Lep} {47}
(dm:-1;ra:5471;dec:-2076;bay:'β'), {Beta Lep} {47}
(dm:-2;ra:15592;dec:-1479;bay:'γ'),  {Gamma Lib} {48}
(dm:-1;ra:15283;dec:-938;bay:'β'), {Beta Lib} {48}
(dm:-1;ra:14848;dec:-1604;bay:'α2'),   {Alpha2 Lib} {48}
(dm:-2;ra:14699;dec:-4739;bay:'α'),  {Alpha Lup} {49}
(dm:-1;ra:14976;dec:-4313;bay:'β'), {Beta Lup} {49}
(dm:-1;ra:15356;dec:-4065;bay:'δ'),  {Delta Lup} {49}
(dm:-1;ra:16002;dec:-3840;bay:'η'),  {Eta Lup} {49}
(dm:-1;ra:15586;dec:-4117;bay:'γ'),  {Gamma Lup} {49}
(dm:-1;ra:15378;dec:-4469;bay:'ε'),   {Epsilon Lup} {49}
(dm:-1;ra:15199;dec:-4874;bay:'κ'),  {Kappa 1 Lup} {49}
(dm:-1;ra:15205;dec:-5210;bay:'ζ'), {Zeta Lup} {49}
(dm:-1;ra:14699;dec:-4739;bay:'α'),  {Alpha Lup} {49}
(dm:-2;ra:9351;dec:3439;bay:'α'),  {Alpha Lyn} {50}
(dm:-1;ra:9314;dec:3680;bay:'38'), {38 Lyn} {50}
(dm:-1;ra:9011;dec:4178;bay:'10'), {10 Lyn} {50}
(dm:-1;ra:8381;dec:4319;bay:'31'), {31 Lyn} {50}
(dm:-1;ra:7445;dec:4921;bay:'21'), {21 Lyn} {50}
(dm:-2;ra:18616;dec:3878;bay:'α'),  {Alpha Lyr} {51}
(dm:-1;ra:18746;dec:3761;bay:'ζ'), {Zeta 1 Lyr} {51}
(dm:-1;ra:18835;dec:3336;bay:'β'), {Beta Lyr} {51}
(dm:-1;ra:18982;dec:3269;bay:'γ'),  {Gamma Lyr} {51}
(dm:-1;ra:18908;dec:3690;bay:'δ2'),   {Delta2 Lyr} {51}
(dm:-1;ra:18746;dec:3761;bay:'ζ'), {Zeta 1 Lyr} {51}
(dm:-2;ra:6171;dec:-7475;bay:'α'),  {Alpha Men} {52}
(dm:-1;ra:5531;dec:-7634;bay:'γ'),  {Gamma Men} {52}
(dm:-1;ra:4920;dec:-7494;bay:'η'),  {Eta Men} {52}
(dm:-1;ra:5045;dec:-7131;bay:'β'), {Beta Men} {52}
(dm:-2;ra:20833;dec:-3378;bay:'α'),  {Alpha Mic} {53}
(dm:-1;ra:21022;dec:-3226;bay:'γ'),  {Gamma Mic} {53}
(dm:-1;ra:21299;dec:-3217;bay:'ε'),   {Epsilon Mic} {53}
(dm:-2;ra:8143;dec:-298;bay:'ζ'), {Zeta Mon} {54}
(dm:-1;ra:7687;dec:-955;bay:'α'),  {Alpha Mon} {54}
(dm:-1;ra:7198;dec:-49;bay:'δ'),  {Delta Mon} {54}
(dm:-2;ra:6396;dec:459;bay:'ε'),   {Epsilon Mon} {54}
(dm:-1;ra:7198;dec:-49;bay:'δ'),  {Delta Mon} {54}
(dm:-1;ra:6480;dec:-703;bay:'β'), {Beta Mon} {54}
(dm:-1;ra:6248;dec:-627;bay:'γ'),  {Gamma Mon} {54}
(dm:-2;ra:11760;dec:-6673;bay:'λ'), {Lambda Mus} {55}
(dm:-1;ra:12293;dec:-6796;bay:'ε'),   {Epsilon Mus} {55}
(dm:-1;ra:12620;dec:-6914;bay:'α'),  {Alpha Mus} {55}
(dm:-1;ra:12771;dec:-6811;bay:'β'), {Beta Mus} {55}
(dm:-1;ra:13038;dec:-7155;bay:'δ'),  {Delta Mus} {55}
(dm:-1;ra:12541;dec:-7213;bay:'γ'),  {Gamma Mus} {55}
(dm:-1;ra:12620;dec:-6914;bay:'α'),  {Alpha Mus} {55}
(dm:-2;ra:16331;dec:-5016;bay:'γ2'),   {Gamma2 Nor} {56}
(dm:-1;ra:16054;dec:-4923;bay:'η'),  {Eta Nor} {56}
(dm:-2;ra:22768;dec:-8138;bay:'β'), {Beta Oct} {57}
(dm:-1;ra:14449;dec:-8367;bay:'δ'),  {Delta Oct} {57}
(dm:-1;ra:21691;dec:-7739;bay:'ν'), {Nu Oct} {57}
(dm:-1;ra:22768;dec:-8138;bay:'β'), {Beta Oct} {57}
(dm:-2;ra:17367;dec:-2500;bay:'θ'),  {Theta Oph} {58}
(dm:-1;ra:17173;dec:-1572;bay:'η'),  {Eta Oph} {58}
(dm:-1;ra:17725;dec:457;bay:'β'), {Beta Oph} {58}
(dm:-1;ra:17582;dec:1256;bay:'α'),  {Alpha Oph} {58}
(dm:-1;ra:16961;dec:938;bay:'κ'),  {Kappa Oph} {58}
(dm:-1;ra:16239;dec:-369;bay:'δ'),  {Delta Oph} {58}
(dm:-1;ra:16305;dec:-469;bay:'ε'),   {Epsilon Oph} {58}
(dm:-1;ra:16619;dec:-1057;bay:'ζ'), {Zeta Oph} {58}
(dm:-1;ra:17173;dec:-1572;bay:'η'),  {Eta Oph} {58}
(dm:-2;ra:5679;dec:-194;bay:'ζ'), {Zeta Ori} {59}
(dm:-1;ra:5920;dec:741;bay:'α'),  {Alpha Ori} {59}
(dm:-1;ra:5586;dec:993;bay:'λ'), {Lambda Ori} {59}
(dm:-1;ra:5419;dec:635;bay:'γ'),  {Gamma Ori} {59}
(dm:-1;ra:5533;dec:-28;bay:'δ'),  {Delta Ori} {59}
(dm:-1;ra:5604;dec:-120;bay:'ε'),   {Epsilon Ori} {59}
(dm:-1;ra:5679;dec:-194;bay:'ζ'), {Zeta Ori} {59}
(dm:-1;ra:5796;dec:-967;bay:'κ'),  {Kappa Ori} {59}
(dm:-1;ra:5242;dec:-820;bay:'β'), {Beta Ori} {59}
(dm:-1;ra:5533;dec:-28;bay:'δ'),  {Delta Ori} {59}
(dm:-2;ra:21441;dec:-6537;bay:'τ'),  {Tau Pav} {60}
(dm:-1;ra:20749;dec:-6620;bay:'β'), {Beta Pav} {60}
(dm:-1;ra:20010;dec:-7291;bay:'ε'),   {Epsilon Pav} {60}
(dm:-1;ra:18717;dec:-7143;bay:'ζ'), {Zeta Pav} {60}
(dm:-1;ra:17762;dec:-6472;bay:'η'),  {Eta Pav} {60}
(dm:-1;ra:18387;dec:-6149;bay:'ξ'), {Xi Pav} {60}
(dm:-1;ra:20145;dec:-6618;bay:'δ'),  {Delta Pav} {60}
(dm:-1;ra:20749;dec:-6620;bay:'β'), {Beta Pav} {60}
(dm:-2;ra:22717;dec:3022;bay:'η'),  {Eta Peg} {61}
(dm:-1;ra:23063;dec:2808;bay:'β'), {Beta Peg} {61}
(dm:-1;ra:140;dec:2909;bay:'α'), {Alpha And} {0}
(dm:-1;ra:221;dec:1518;bay:'γ'),  {Gamma Peg} {61}
(dm:-1;ra:23079;dec:1521;bay:'α'),  {Alpha Peg} {61}
(dm:-1;ra:22691;dec:1083;bay:'ζ'), {Zeta Peg} {61}
(dm:-1;ra:22170;dec:620;bay:'θ'),  {Theta Peg} {61}
(dm:-1;ra:21736;dec:988;bay:'ε'),   {Epsilon Peg} {61}
(dm:-2;ra:23063;dec:2808;bay:'β'), {Beta Peg} {61}
(dm:-1;ra:23079;dec:1521;bay:'α'),  {Alpha Peg} {61}
(dm:-2;ra:2845;dec:5590;bay:'η'),  {Eta Per} {62}
(dm:-1;ra:3080;dec:5351;bay:'γ'),  {Gamma Per} {62}
(dm:-1;ra:3405;dec:4986;bay:'α'),  {Alpha Per} {62}
(dm:-1;ra:3715;dec:4779;bay:'δ'),  {Delta Per} {62}
(dm:-1;ra:3964;dec:4001;bay:'ε'),   {Epsilon Per} {62}
(dm:-1;ra:3902;dec:3188;bay:'ζ'), {Zeta Per} {62}
(dm:-2;ra:3405;dec:4986;bay:'α'),  {Alpha Per} {62}
(dm:-1;ra:3136;dec:4096;bay:'β'), {Beta Per} {62}
(dm:-1;ra:3086;dec:3884;bay:'ρ'),  {Rho Per} {62}
(dm:-2;ra:157;dec:-4575;bay:'ε'),   {Epsilon Phe} {63}
(dm:-1;ra:437;dec:-4368;bay:'κ'),  {Kappa Phe} {63}
(dm:-1;ra:1101;dec:-4672;bay:'β'), {Beta Phe} {63}
(dm:-1;ra:1473;dec:-4332;bay:'γ'),  {Gamma Phe} {63}
(dm:-1;ra:1521;dec:-4907;bay:'δ'),  {Delta Phe} {63}
(dm:-1;ra:1140;dec:-5525;bay:'ζ'), {Zeta Phe} {63}
(dm:-1;ra:1101;dec:-4672;bay:'β'), {Beta Phe} {63}
(dm:-2;ra:6803;dec:-6194;bay:'α'),  {Alpha Pic} {64}
(dm:-1;ra:5830;dec:-5617;bay:'γ'),  {Gamma Pic} {64}
(dm:-1;ra:5788;dec:-5107;bay:'β'), {Beta Pic} {64}
(dm:-2;ra:1525;dec:1535;bay:'η'),  {Eta Psc} {65}
(dm:-1;ra:1757;dec:916;bay:'ο'),   {Omicron Psc} {65}
(dm:-1;ra:2034;dec:276;bay:'α'),  {Alpha Psc} {65}
(dm:-1;ra:1049;dec:789;bay:'ε'),   {Epsilon Psc} {65}
(dm:-1;ra:811;dec:759;bay:'δ'),  {Delta Psc} {65}
(dm:-1;ra:23989;dec:686;bay:'ω'),  {Omega Psc} {65}
(dm:-1;ra:23666;dec:563;bay:'ι'), {Iota Psc} {65}
(dm:-1;ra:23466;dec:638;bay:'θ'),  {Theta Psc} {65}
(dm:-1;ra:23065;dec:382;bay:'β'), {Beta Psc} {65}
(dm:-1;ra:23286;dec:328;bay:'γ'),  {Gamma Psc} {65}
(dm:-1;ra:23666;dec:563;bay:'ι'), {Iota Psc} {65}
(dm:-2;ra:21749;dec:-3303;bay:'ι'), {Iota PsA} {66}
(dm:-1;ra:22525;dec:-3235;bay:'β'), {Beta PsA} {66}
(dm:-1;ra:22875;dec:-3288;bay:'γ'),  {Gamma PsA} {66}
(dm:-1;ra:22932;dec:-3254;bay:'δ'),  {Delta PsA} {66}
(dm:-1;ra:22961;dec:-2962;bay:'α'),  {Alpha PsA} {66}
(dm:-1;ra:22678;dec:-2704;bay:'ε'),   {Epsilon PsA} {66}
(dm:-1;ra:22525;dec:-3235;bay:'β'), {Beta PsA} {66}
(dm:-2;ra:8126;dec:-2430;bay:'ρ'),  {Rho Pup} {67}
(dm:-1;ra:7822;dec:-2486;bay:'ξ'), {Xi Pup} {67}
(dm:-1;ra:8060;dec:-4000;bay:'ζ'), {Zeta Pup} {67}
(dm:-1;ra:7286;dec:-3710;bay:'π'), {Pi Pup} {67}
(dm:-1;ra:7487;dec:-4330;bay:'σ'),  {Sigma Pup} {67}
(dm:-1;ra:7226;dec:-4464;bay:'L2'),  {L2 Pup} {67}
(dm:-1;ra:6629;dec:-4320;bay:'ν'), {Nu Pup} {67}
(dm:-1;ra:6832;dec:-5061;bay:'τ'),  {Tau Pup} {67}
(dm:-1;ra:7226;dec:-4464;bay:'L2'),  {L2 Pup} {67}
(dm:-2;ra:8060;dec:-4000;bay:'ζ'), {Zeta Pup} {67}
(dm:-1;ra:7487;dec:-4330;bay:'σ'),  {Sigma Pup} {67}
(dm:-2;ra:8668;dec:-3531;bay:'β'), {Beta Pyx} {68}
(dm:-1;ra:8727;dec:-3319;bay:'α'),  {Alpha Pyx} {68}
(dm:-1;ra:8842;dec:-2771;bay:'γ'),  {Gamma Pyx} {68}
(dm:-2;ra:4240;dec:-6247;bay:'α'),  {Alpha Ret} {69}
(dm:-1;ra:3737;dec:-6481;bay:'β'), {Beta Ret} {69}
(dm:-1;ra:4015;dec:-6216;bay:'γ'),  {Gamma Ret} {69}
(dm:-1;ra:3979;dec:-6140;bay:'4'),  {4 Ret} {69}
(dm:-1;ra:4275;dec:-5930;bay:'ε'),   {Epsilon Ret} {69}
(dm:-1;ra:4240;dec:-6247;bay:'α'),  {Alpha Ret} {69}
(dm:-2;ra:19668;dec:1801;bay:'α'),  {Alpha Sge} {70}
(dm:-1;ra:19790;dec:1853;bay:'δ'),  {Delta Sge} {70}
(dm:-1;ra:19684;dec:1748;bay:'β'), {Beta Sge} {70}
(dm:-2;ra:19790;dec:1853;bay:'δ'),  {Delta Sge} {70}
(dm:-1;ra:19979;dec:1949;bay:'γ'),  {Gamma Sge} {70}
(dm:-2;ra:19387;dec:-4480;bay:'β2'), {Beta2 Sgr} {71}
(dm:-1;ra:19377;dec:-4446;bay:'β'), {Beta 1 Sgr} {71}
(dm:-1;ra:19398;dec:-4062;bay:'α'),  {Alpha Sgr} {71}
(dm:-1;ra:19044;dec:-2988;bay:'ζ'), {Zeta Sgr} {71}
(dm:-1;ra:18921;dec:-2630;bay:'σ'),  {Sigma Sgr} {71}
(dm:-1;ra:18466;dec:-2542;bay:'λ'), {Lambda Sgr} {71}
(dm:-1;ra:18350;dec:-2983;bay:'δ'),  {Delta Sgr} {71}
(dm:-1;ra:18403;dec:-3438;bay:'ε'),   {Epsilon Sgr} {71}
(dm:-1;ra:18294;dec:-3676;bay:'η'),  {Eta Sgr} {71}
(dm:-2;ra:18097;dec:-3042;bay:'γ'),  {Gamma Sgr} {71}
(dm:-1;ra:18350;dec:-2983;bay:'δ'),  {Delta Sgr} {71}
(dm:-2;ra:18229;dec:-2106;bay:'μ'), {Mu Sgr} {71}
(dm:-1;ra:18466;dec:-2542;bay:'λ'), {Lambda Sgr} {71}
(dm:-2;ra:18962;dec:-2111;bay:'ξ2'), {Xi2 Sgr} {71}
(dm:-1;ra:18921;dec:-2630;bay:'σ'),  {Sigma Sgr} {71}
(dm:-2;ra:17560;dec:-3710;bay:'λ'), {Lambda Sco} {72}
(dm:-1;ra:17708;dec:-3903;bay:'κ'),  {Kappa Sco} {72}
(dm:-1;ra:17622;dec:-4300;bay:'θ'),  {Theta Sco} {72}
(dm:-1;ra:17203;dec:-4324;bay:'η'),  {Eta Sco} {72}
(dm:-1;ra:16910;dec:-4236;bay:'ζ2'), {Zeta2 Sco} {72}
(dm:-1;ra:16864;dec:-3805;bay:'μ'), {Mu 1 Sco} {72}
(dm:-1;ra:16836;dec:-3429;bay:'ε'),   {Epsilon Sco} {72}
(dm:-1;ra:16490;dec:-2643;bay:'α'),  {Alpha Sco} {72}
(dm:-1;ra:16091;dec:-1981;bay:'β'), {Beta 1 Sco} {72}
(dm:-1;ra:16006;dec:-2262;bay:'δ'),  {Delta Sco} {72}
(dm:-1;ra:16490;dec:-2643;bay:'α'),  {Alpha Sco} {72}
(dm:-2;ra:977;dec:-2936;bay:'α'),  {Alpha Scl} {73}
(dm:-1;ra:23815;dec:-2813;bay:'δ'),  {Delta Scl} {73}
(dm:-1;ra:23314;dec:-3253;bay:'γ'),  {Gamma Scl} {73}
(dm:-1;ra:23550;dec:-3782;bay:'β'), {Beta Scl} {73}
(dm:-2;ra:18786;dec:-475;bay:'β'), {Beta Sct} {74}
(dm:-1;ra:18587;dec:-824;bay:'α'),  {Alpha Sct} {74}
(dm:-1;ra:18487;dec:-1457;bay:'γ'),  {Gamma Sct} {74}
(dm:-2;ra:15941;dec:1566;bay:'γ'),  {Gamma Ser} {76}
(dm:-1;ra:15770;dec:1542;bay:'β'), {Beta Ser} {76}
(dm:-1;ra:15580;dec:1054;bay:'δ'),  {Delta Ser} {76}
(dm:-1;ra:15738;dec:643;bay:'α'),  {Alpha Ser} {76}
(dm:-1;ra:15847;dec:448;bay:'ε'),   {Epsilon Ser} {76}
(dm:-1;ra:15827;dec:-343;bay:'μ'), {Mu Ser} {76}
(dm:-1;ra:16239;dec:-369;bay:'δ'),  {Delta Oph} {58}
(dm:-2;ra:17173;dec:-1572;bay:'η'),  {Eta Oph} {58}
(dm:-1;ra:17626;dec:-1540;bay:'ξ'), {Xi Ser} {76}
(dm:-1;ra:18355;dec:-290;bay:'η'),  {Eta Ser} {76}
(dm:-1;ra:18937;dec:420;bay:'θ'),  {Theta 1 Ser} {76}
(dm:-2;ra:10505;dec:-64;bay:'β'), {Beta Sex} {77}
(dm:-1;ra:10132;dec:-37;bay:'α'),  {Alpha Sex} {77}
(dm:-1;ra:9875;dec:-811;bay:'γ'),  {Gamma Sex} {77}
(dm:-2;ra:5627;dec:2114;bay:'ζ'), {Zeta Tau} {78}
(dm:-1;ra:4599;dec:1651;bay:'α'),  {Alpha Tau} {78}
(dm:-1;ra:5438;dec:2861;bay:'β'), {Beta Tau} {78}
(dm:-2;ra:4599;dec:1651;bay:'α'),  {Alpha Tau} {78}
(dm:-1;ra:4478;dec:1587;bay:'θ2'),   {Theta2 Tau} {78}
(dm:-1;ra:4330;dec:1563;bay:'γ'),  {Gamma Tau} {78}
(dm:-1;ra:4382;dec:1754;bay:'δ'),  {Delta 1 Tau} {78}
(dm:-1;ra:4477;dec:1918;bay:'ε'),   {Epsilon Tau} {78}
(dm:-2;ra:3791;dec:2411;bay:'η'),  {Eta Tau} {78}
(dm:-1;ra:4330;dec:1563;bay:'γ'),  {Gamma Tau} {78}
(dm:-1;ra:4011;dec:1249;bay:'λ'), {Lambda Tau} {78}
(dm:-2;ra:18187;dec:-4595;bay:'ε'),   {Epsilon Tel} {79}
(dm:-1;ra:18450;dec:-4597;bay:'α'),  {Alpha Tel} {79}
(dm:-1;ra:18481;dec:-4907;bay:'ζ'), {Zeta Tel} {79}
(dm:-2;ra:1885;dec:2958;bay:'α'),  {Alpha Tri} {80}
(dm:-1;ra:2159;dec:3499;bay:'β'), {Beta Tri} {80}
(dm:-1;ra:2289;dec:3385;bay:'γ'),  {Gamma Tri} {80}
(dm:-1;ra:1885;dec:2958;bay:'α'),  {Alpha Tri} {80}
(dm:-2;ra:16811;dec:-6903;bay:'α'),  {Alpha TrA} {81}
(dm:-1;ra:15919;dec:-6343;bay:'β'), {Beta TrA} {81}
(dm:-1;ra:15315;dec:-6868;bay:'γ'),  {Gamma TrA} {81}
(dm:-1;ra:16811;dec:-6903;bay:'α'),  {Alpha TrA} {81}
(dm:-2;ra:22308;dec:-6026;bay:'α'),  {Alpha Tuc} {82}
(dm:-1;ra:23290;dec:-5824;bay:'γ'),  {Gamma Tuc} {82}
(dm:-1;ra:526;dec:-6296;bay:'β'), {Beta 1 Tuc} {82}
(dm:-1;ra:335;dec:-6488;bay:'ζ'), {Zeta Tuc} {82}
(dm:-1;ra:22308;dec:-6026;bay:'α'),  {Alpha Tuc} {82}
(dm:-2;ra:13792;dec:4931;bay:'η'),  {Eta UMa} {83}
(dm:-1;ra:13399;dec:5493;bay:'ζ'), {Zeta UMa} {83}
(dm:-1;ra:12900;dec:5596;bay:'ε'),   {Epsilon UMa} {83}
(dm:-1;ra:12257;dec:5703;bay:'δ'),  {Delta UMa} {83}
(dm:-1;ra:11062;dec:6175;bay:'α'),  {Alpha UMa} {83}
(dm:-1;ra:11031;dec:5638;bay:'β'), {Beta UMa} {83}
(dm:-1;ra:11897;dec:5369;bay:'γ'),  {Gamma UMa} {83}
(dm:-1;ra:12257;dec:5703;bay:'δ'),  {Delta UMa} {83}
(dm:-2;ra:2531;dec:8926;bay:'α'),  {Alpha UMi} {84}
(dm:-1;ra:17537;dec:8659;bay:'δ'),  {Delta UMi} {84}
(dm:-1;ra:16766;dec:8204;bay:'ε'),   {Epsilon UMi} {84}
(dm:-1;ra:15734;dec:7779;bay:'ζ'), {Zeta UMi} {84}
(dm:-1;ra:14845;dec:7416;bay:'β'), {Beta UMi} {84}
(dm:-1;ra:15345;dec:7183;bay:'γ'),  {Gamma UMi} {84}
(dm:-1;ra:16292;dec:7576;bay:'η'),  {Eta UMi} {84}
(dm:-1;ra:15734;dec:7779;bay:'ζ'), {Zeta UMi} {84}
(dm:-2;ra:10779;dec:-4942;bay:'μ'), {Mu Vel} {85}
(dm:-1;ra:9948;dec:-5457;bay:'φ'),  {Phi Vel} {85}
(dm:-1;ra:9369;dec:-5501;bay:'κ'),  {Kappa Vel} {85}
(dm:-1;ra:8745;dec:-5471;bay:'δ'),  {Delta Vel} {85}
(dm:-1;ra:8158;dec:-4735;bay:'γ'),  {Gamma 1 Vel} {85}
(dm:-1;ra:9133;dec:-4343;bay:'λ'), {Lambda Vel} {85}
(dm:-1;ra:9512;dec:-4047;bay:'ψ'),  {Psi Vel} {85}
(dm:-2;ra:9133;dec:-4343;bay:'λ'), {Lambda Vel} {85}
(dm:-1;ra:9369;dec:-5501;bay:'κ'),  {Kappa Vel} {85}
(dm:-2;ra:14718;dec:-566;bay:'μ'), {Mu Vir} {86}
(dm:-1;ra:14267;dec:-600;bay:'ι'), {Iota Vir} {86}
(dm:-1;ra:13420;dec:-1116;bay:'α'),  {Alpha Vir} {86}
(dm:-1;ra:13166;dec:-554;bay:'θ'),  {Theta Vir} {86}
(dm:-1;ra:12694;dec:-145;bay:'γ'),  {Gamma Vir} {86}
(dm:-1;ra:12332;dec:-67;bay:'η'),  {Eta Vir} {86}
(dm:-1;ra:11845;dec:176;bay:'β'), {Beta Vir} {86}
(dm:-2;ra:12694;dec:-145;bay:'γ'),  {Gamma Vir} {86}
(dm:-1;ra:12927;dec:340;bay:'δ'),  {Delta Vir} {86}
(dm:-1;ra:13578;dec:-60;bay:'ζ'), {Zeta Vir} {86}
(dm:-1;ra:13420;dec:-1116;bay:'α'),  {Alpha Vir} {86}
(dm:-2;ra:13036;dec:1096;bay:'ε'),   {Epsilon Vir} {86}
(dm:-1;ra:12927;dec:340;bay:'δ'),  {Delta Vir} {86}
(dm:-2;ra:9041;dec:-6640;bay:'α'),  {Alpha Vol} {87}
(dm:-1;ra:8132;dec:-6862;bay:'ε'),   {Epsilon Vol} {87}
(dm:-1;ra:7281;dec:-6796;bay:'δ'),  {Delta Vol} {87}
(dm:-1;ra:7145;dec:-7050;bay:'γ'),  {Gamma 1 Vol} {87}
(dm:-1;ra:7697;dec:-7261;bay:'ζ'), {Zeta Vol} {87}
(dm:-1;ra:8132;dec:-6862;bay:'ε'),   {Epsilon Vol} {87}
(dm:-2;ra:20018;dec:2775;bay:'15'), {15 Vul} {88}
(dm:-1;ra:19891;dec:2408;bay:'13'), {13 Vul} {88}
(dm:-1;ra:19478;dec:2467;bay:'α'),  {Alpha Vul} {88}
(dm:-1;ra:19270;dec:2139;bay:'1')); {1 Vul} {88}



Constpos : array[0..88,0..1] of smallint=
{Constellation position , for name see Constname
 RA * 1000, Dec * 100}

((564,3925),       {'Andromeda',}
(10118,-3365),     {'Antlia',}
(16000,-8000),     {'Apus',}
(22697,-1053),     {'Aquarius',}
(19690,337),       {'Aquila',}
(17231,-5189),     {'Ara',}
(2676,2257),       {'Aries',}
(5500,4240),       {'Auriga',}
(14687,3233),      {'Bootes',}
(4721,-3883),      {'Caelum',}
(6151,7196),       {'Camelopardalis',}
(8497,2356),       {'Cancer',}
(13020,4235),      {'Canes_Venatici',}
(6830,-2269),      {'Canis_Major',}
(7624,676),        {'Canis_Minor',}
(21048,-1965),     {'Capricornus',}
(7761,-5717),      {'Carina',}
(870,6030),        {'Cassiopeia',}
(12950,-4400),     {'Centaurus',}
(22417,7256),      {'Cepheus',}
(1709,-664),       {'Cetus',}
(12000,-8000),     {'Chamaeleon',}
(14527,-6770),     {'Circinus',}
(5705,-3708),      {'Columba',}
(12748,2265),      {'Coma_Berenices',}
(18655,-4125),     {'Corona_Australis',}
(15880,3263),      {'Corona_Borealis',}
(12387,-1836),     {'Corvus',}
(11348,-1325),     {'Crater',}
(12600,-6070),     {'Crux',}
(20598,4958),      {'Cygnus',}
(20663,1210),      {'Delphinus',}
(5333,-6399),      {'Dorado',}
(17945,6606),      {'Draco',}
(21251,794),       {'Equuleus',}
(3876,-1701),      {'Eridanus',}
(2766,-2694),      {'Fornax',}
(7300,2600),       {'Gemini',}
(22457,-4586),     {'Grus',}
(17425,3123),      {'Hercules',}
(3212,-5200),      {'Horologium',}
(9136,-1132),      {'Hydra',}
(2589,-7208),      {'Hydrus',}
(21138,-5268),     {'Indus',}
(22514,4667),      {'Lacerta',}
(10600,1800),       {'Leo',}
(10316,3324),      {'Leo_Minor',}
(5436,-1935),      {'Lepus',}
(15187,-1545),     {'Libra',}
(15376,-4228),     {'Lupus',}
(7734,4783),       {'Lynx',}
(18908,4065),      {'Lyra',}
(5500,-7999),      {'Mensa',}
(20942,-3620),     {'Microscopium',}
(6962,-500),       {'Monoceros',}
(12460,-6987),     {'Musca',}
(16042,-5229),     {'Norma',}
(22173,-8473),     {'Octans',}
(17037,-265),      {'Ophiuchus',}
(5660,500),        {'Orion',}
(19160,-6514),     {'Pavo',}
(22617,1965),      {'Pegasus',}
(3514,4489),       {'Perseus',}
(732,-4823),       {'Phoenix',}
(5381,-5163),      {'Pictor',}
(891,1548),        {'Pisces',}
(22410,-3143),     {'Piscis_Austrinus',}
(7873,-3239),      {'Puppis',}
(8891,-2921),      {'Pyxis',}
(3899,-6049),      {'Reticulum',}
(19667,1700),      {'Sagitta',}
(19385,-2911),     {'Sagittarius',}
(16865,-3567),     {'Scorpius',}
(500,-3500),       {'Sculptor',}
(18651,-1011),     {'Scutum',}
(15731,1085),      {'Serpens_Caput',}
(17958,-1352),     {'Serpens_Cauda',}
(10102,-187),      {'Sextans',}
(4095,1734),       {'Taurus',}
(19244,-5154),     {'Telescopium',}
(2043,3234),       {'Triangulum',}
(16124,-6590),     {'Triangulum_Australe',}
(23828,-6406),     {'Tucana',}
(10263,5748),      {'Ursa_Major',}
(15000,7600),      {'Ursa_Minor',}
(9337,-4851),      {'Vela',}
(13343,-349),      {'Virgo',}
(7659,-6939),      {'Volans',}
(20367,2503));     {'Vulpecula'));



{Constellation_name)}
Constname : array[0..88] of ansistring=
(('Andromeda'),
('Antlia'),
('Apus'),
('Aquarius'),
('Aquila'),
('Ara'),
('Aries'),
('Auriga'),
('Bootes'),
('Caelum'),
('Camelopardalis'),
('Cancer'),
('Canes_Venatici'),
('Canis_Major'),
('Canis_Minor'),
('Capricornus'),
('Carina'),
('Cassiopeia'),
('Centaurus'),
('Cepheus'),
('Cetus'),
('Chamaeleon'),
('Circinus'),
('Columba'),
('Coma_Berenices'),
('Corona_Australis'),
('Corona_Borealis'),
('Corvus'),
('Crater'),
('Crux'),
('Cygnus'),
('Delphinus'),
('Dorado'),
('Draco'),
('Equuleus'),
('Eridanus'),
('Fornax'),
('Gemini'),
('Grus'),
('Hercules'),
('Horologium'),
('Hydra'),
('Hydrus'),
('Indus'),
('Lacerta'),
('Leo'),
('Leo_Minor'),
('Lepus'),
('Libra'),
('Lupus'),
('Lynx'),
('Lyra'),
('Mensa'),
('Microscopium'),
('Monoceros'),
('Musca'),
('Norma'),
('Octans'),
('Ophiuchus'),
('Orion'),
('Pavo'),
('Pegasus'),
('Perseus'),
('Phoenix'),
('Pictor'),
('Pisces'),
('Piscis_Austrinus'),
('Puppis'),
('Pyxis'),
('Reticulum'),
('Sagitta'),
('Sagittarius'),
('Scorpius'),
('Sculptor'),
('Scutum'),
('Serpens_Caput'),
('Serpens_Cauda'),
('Sextans'),
('Taurus'),
('Telescopium'),
('Triangulum'),
('Triangulum_Australe'),
('Tucana'),
('Ursa_Major'),
('Ursa_Minor'),
('Vela'),
('Virgo'),
('Volans'),
('Vulpecula'));

Constshortname : array[0..88] of pchar=
(('And'),
('Ant'),
('Aps'),
('Aqr'),
('Aql'),
('Ara'),
('Ari'),
('Aur'),
('Boo'),
('Cae'),
('Cam'),
('Cnc'),
('CVn'),
('CMa'),
('CMi'),
('Cap'),
('Car'),
('Cas'),
('Cen'),
('Cep'),
('Cet'),
('Cha'),
('Cir'),
('Col'),
('Com'),
('CrA'),
('CrB'),
('Crv'),
('Crt'),
('Cru'),
('Cyg'),
('Del'),
('Dor'),
('Dra'),
('Equ'),
('Eri'),
('For'),
('Gem'),
('Gru'),
('Her'),
('Hor'),
('Hya'),
('Hyi'),
('Ind'),
('Lac'),
('Leo'),
('LMi'),
('Lep'),
('Lib'),
('Lup'),
('Lyn'),
('Lyr'),
('Men'),
('Mic'),
('Mon'),
('Mus'),
('Nor'),
('Oct'),
('Oph'),
('Ori'),
('Pav'),
('Peg'),
('Per'),
('Phe'),
('Pic'),
('Psc'),
('PsA'),
('Pup'),
('Pyx'),
('Ret'),
('Sge'),
('Sgr'),
('Sco'),
('Scl'),
('Sct'),
('Ser'),
('Ser'),
('Sex'),
('Tau'),
('Tel'),
('Tri'),
('TrA'),
('Tuc'),
('UMa'),
('UMi'),
('Vel'),
('Vir'),
('Vol'),
('Vul'));



Constbound1875 : array[0..879,0..2] of smallint=
{   Constellation boundary lines equinox B1875 !!!!     Version 2007
    Format:   Move=-2/Draw=-1,Right Ascension,Declination
              Right ascension is decimal hours * 1000),
              Declination is decimal degrees * 100)}
              
((-2,7667,-8250),{1,-1,7:40:00,82:30:00,7.666667,-82.500000}
(-1,13667,-8250),{2,-1,13:40:00,82:30:00,13.666667,-82.500000}
(-1,13667,-7500),{3,-1,13:40:00,75:00:00,13.666667,-75.000000}
(-1,11250,-7500),{4,-1,11:15:00,75:00:00,11.250000,-75.000000}
(-1,9033,-7500),{5,-1,9:02:00,75:00:00,9.033333,-75.000000}
(-1,7667,-7500),{6,-1,7:40:00,75:00:00,7.666667,-75.000000}
(-1,7667,-8250),{7,-1,7:40:00,82:30:00,7.666667,-82.500000}
(-2,13667,-7500),{8,-1,13:40:00,75:00:00,13.666667,-75.000000}
(-1,13667,-7000),{9,-1,13:40:00,70:00:00,13.666667,-70.000000}
(-1,13667,-6500),{10,-1,13:40:00,65:00:00,13.666667,-65.000000}
(-1,13500,-6500),{11,-1,13:30:00,65:00:00,13.500000,-65.000000}
(-1,13500,-6400),{12,-1,13:30:00,64:00:00,13.500000,-64.000000}
(-1,12833,-6400),{13,-1,12:50:00,64:00:00,12.833333,-64.000000}
(-1,11833,-6400),{14,-1,11:50:00,64:00:00,11.833333,-64.000000}
(-1,11250,-6400),{15,-1,11:15:00,64:00:00,11.250000,-64.000000}
(-1,11250,-7500),{16,-1,11:15:00,75:00:00,11.250000,-75.000000}
(-2,14750,-7000),{17,-1,14:45:00,70:00:00,14.750000,-70.000000}
(-1,17000,-7000),{18,-1,17:00:00,70:00:00,17.000000,-70.000000}
(-1,17000,-6750),{19,-1,17:00:00,67:30:00,17.000000,-67.500000}
(-1,16833,-6750),{20,-1,16:50:00,67:30:00,16.833333,-67.500000}
(-1,16833,-6500),{21,-1,16:50:00,65:00:00,16.833333,-65.000000}
(-1,16750,-6500),{22,-1,16:45:00,65:00:00,16.750000,-65.000000}
(-1,16750,-6358),{23,-1,16:45:00,63:35:00,16.750000,-63.583333}
(-1,16583,-6358),{24,-1,16:35:00,63:35:00,16.583333,-63.583333}
(-1,16583,-6100),{25,-1,16:35:00,61:00:00,16.583333,-61.000000}
(-1,16420,-6100),{26,-1,16:25:12,61:00:00,16.420000,-61.000000}
(-1,16420,-6000),{27,-1,16:25:12,60:00:00,16.420000,-60.000000}
(-1,15333,-6000),{28,-1,15:20:00,60:00:00,15.333333,-60.000000}
(-1,15333,-6100),{29,-1,15:20:00,61:00:00,15.333333,-61.000000}
(-1,15167,-6100),{30,-1,15:10:00,61:00:00,15.166667,-61.000000}
(-1,15167,-6358),{31,-1,15:10:00,63:35:00,15.166667,-63.583333}
(-1,14917,-6358),{32,-1,14:55:00,63:35:00,14.916667,-63.583333}
(-1,14917,-6750),{33,-1,14:55:00,67:30:00,14.916667,-67.500000}
(-1,14750,-6750),{34,-1,14:45:00,67:30:00,14.750000,-67.500000}
(-1,14750,-7000),{35,-1,14:45:00,70:00:00,14.750000,-70.000000}
(-2,13667,-8250),{36,-1,13:40:00,82:30:00,13.666667,-82.500000}
(-1,18000,-8250),{37,-1,18:00:00,82:30:00,18.000000,-82.500000}
(-1,18000,-7500),{38,-1,18:00:00,75:00:00,18.000000,-75.000000}
(-1,18000,-6750),{39,-1,18:00:00,67:30:00,18.000000,-67.500000}
(-1,17500,-6750),{40,-1,17:30:00,67:30:00,17.500000,-67.500000}
(-1,17000,-6750),{41,-1,17:00:00,67:30:00,17.000000,-67.500000}
(-2,14750,-7000),{42,-1,14:45:00,70:00:00,14.750000,-70.000000}
(-1,13667,-7000),{43,-1,13:40:00,70:00:00,13.666667,-70.000000}
(-1,13667,-7500),{44,-1,13:40:00,75:00:00,13.666667,-75.000000}
(-2,18000,-7500),{45,-1,18:00:00,75:00:00,18.000000,-75.000000}
(-1,21333,-7500),{46,-1,21:20:00,75:00:00,21.333333,-75.000000}
(-1,21333,-6000),{47,-1,21:20:00,60:00:00,21.333333,-60.000000}
(-1,20333,-6000),{48,-1,20:20:00,60:00:00,20.333333,-60.000000}
(-1,20333,-5700),{49,-1,20:20:00,57:00:00,20.333333,-57.000000}
(-1,18000,-5700),{50,-1,18:00:00,57:00:00,18.000000,-57.000000}
(-1,17500,-5700),{51,-1,17:30:00,57:00:00,17.500000,-57.000000}
(-1,17500,-6750),{52,-1,17:30:00,67:30:00,17.500000,-67.500000}
(-2,21333,-7500),{53,-1,21:20:00,75:00:00,21.333333,-75.000000}
(-1,23333,-7500),{54,-1,23:20:00,75:00:00,23.333333,-75.000000}
(-1,24000,-7500),{55,-1,24:00:00,75:00:00,24.000000,-75.000000}
(-1,24000,-8250),{56,-1,24:00:00,82:30:00,24.000000,-82.500000}
(-1,3500,-8250),{57,-1,3:30:00,82:30:00,3.500000,-82.500000}
(-1,3502,-8500),{58,-1,3:30:06,85:00:00,3.501667,-85.000000}
(-1,7667,-8500),{59,-1,7:40:00,85:00:00,7.666667,-85.000000}
(-1,7667,-8250),{60,-1,7:40:00,82:30:00,7.666667,-82.500000}
(-2,20333,-5700),{61,-1,20:20:00,57:00:00,20.333333,-57.000000}
(-1,20333,-4550),{62,-1,20:20:00,45:30:00,20.333333,-45.500000}
(-1,19167,-4550),{63,-1,19:10:00,45:30:00,19.166667,-45.500000}
(-1,18000,-4550),{64,-1,18:00:00,45:30:00,18.000000,-45.500000}
(-1,18000,-5700),{65,-1,18:00:00,57:00:00,18.000000,-57.000000}
(-2,23333,-7500),{66,-1,23:20:00,75:00:00,23.333333,-75.000000}
(-1,23333,-6750),{67,-1,23:20:00,67:30:00,23.333333,-67.500000}
(-1,22000,-6750),{68,-1,22:00:00,67:30:00,22.000000,-67.500000}
(-1,22000,-5700),{69,-1,22:00:00,57:00:00,22.000000,-57.000000}
(-1,22000,-5000),{70,-1,22:00:00,50:00:00,22.000000,-50.000000}
(-1,21333,-5000),{71,-1,21:20:00,50:00:00,21.333333,-50.000000}
(-1,21333,-4550),{72,-1,21:20:00,45:30:00,21.333333,-45.500000}
(-1,20333,-4550),{73,-1,20:20:00,45:30:00,20.333333,-45.500000}
(-2,24000,-7500),{74,-1,24:00:00,75:00:00,24.000000,-75.000000}
(-1,750,-7500),{75,-1,0:45:00,75:00:00,0.750000,-75.000000}
(-1,750,-7600),{76,-1,0:45:00,76:00:00,0.750000,-76.000000}
(-1,1333,-7600),{77,-1,1:20:00,76:00:00,1.333333,-76.000000}
(-1,1333,-5850),{78,-1,1:20:00,58:30:00,1.333333,-58.500000}
(-1,23333,-5850),{79,-1,23:20:00,58:30:00,23.333333,-58.500000}
(-1,23333,-5700),{80,-1,23:20:00,57:00:00,23.333333,-57.000000}
(-1,22000,-5700),{81,-1,22:00:00,57:00:00,22.000000,-57.000000}
(-2,6583,-7000),{82,-1,6:35:00,70:00:00,6.583333,-70.000000}
(-1,4583,-7000),{83,-1,4:35:00,70:00:00,4.583333,-70.000000}
(-2,3500,-8250),{84,-1,3:30:00,82:30:00,3.500000,-82.500000}
(-1,3500,-7500),{85,-1,3:30:00,75:00:00,3.500000,-75.000000}
(-1,4583,-7500),{86,-1,4:35:00,75:00:00,4.583333,-75.000000}
(-1,4583,-7000),{87,-1,4:35:00,70:00:00,4.583333,-70.000000}
(-1,4583,-6750),{88,-1,4:35:00,67:30:00,4.583333,-67.500000}
(-1,3200,-6750),{89,-1,3:12:00,67:30:00,3.200000,-67.500000}
(-1,2167,-6750),{90,-1,2:10:00,67:30:00,2.166667,-67.500000}
(-1,2167,-5850),{91,-1,2:10:00,58:30:00,2.166667,-58.500000}
(-1,1333,-5850),{92,-1,1:20:00,58:30:00,1.333333,-58.500000}
(-2,6583,-7500),{93,-1,6:35:00,75:00:00,6.583333,-75.000000}
(-1,7667,-7500),{94,-1,7:40:00,75:00:00,7.666667,-75.000000}
(-2,9033,-7500),{95,-1,9:02:00,75:00:00,9.033333,-75.000000}
(-1,9033,-6400),{96,-1,9:02:00,64:00:00,9.033333,-64.000000}
(-1,6833,-6400),{97,-1,6:50:00,64:00:00,6.833333,-64.000000}
(-1,6583,-6400),{98,-1,6:35:00,64:00:00,6.583333,-64.000000}
(-1,6583,-7000),{99,-1,6:35:00,70:00:00,6.583333,-70.000000}
(-1,6583,-7500),{100,-1,6:35:00,75:00:00,6.583333,-75.000000}
(-2,11000,-5650),{101,-1,11:00:00,56:30:00,11.000000,-56.500000}
(-1,11250,-5650),{102,-1,11:15:00,56:30:00,11.250000,-56.500000}
(-1,11250,-6400),{103,-1,11:15:00,64:00:00,11.250000,-64.000000}
(-2,11833,-6400),{104,-1,11:50:00,64:00:00,11.833333,-64.000000}
(-1,11833,-5500),{105,-1,11:50:00,55:00:00,11.833333,-55.000000}
(-1,12833,-5500),{106,-1,12:50:00,55:00:00,12.833333,-55.000000}
(-1,12833,-6400),{107,-1,12:50:00,64:00:00,12.833333,-64.000000}
(-2,13500,-6400),{108,-1,13:30:00,64:00:00,13.500000,-64.000000}
(-1,14533,-6400),{109,-1,14:32:00,64:00:00,14.533333,-64.000000}
(-1,14533,-5500),{110,-1,14:32:00,55:00:00,14.533333,-55.000000}
(-1,14167,-5500),{111,-1,14:10:00,55:00:00,14.166667,-55.000000}
(-1,14167,-4200),{112,-1,14:10:00,42:00:00,14.166667,-42.000000}
(-1,14917,-4200),{113,-1,14:55:00,42:00:00,14.916667,-42.000000}
(-1,14917,-2950),{114,-1,14:55:00,29:30:00,14.916667,-29.500000}
(-1,12583,-2950),{115,-1,12:35:00,29:30:00,12.583333,-29.500000}
(-1,12583,-3300),{116,-1,12:35:00,33:00:00,12.583333,-33.000000}
(-1,12250,-3300),{117,-1,12:15:00,33:00:00,12.250000,-33.000000}
(-1,12250,-3500),{118,-1,12:15:00,35:00:00,12.250000,-35.000000}
(-1,11000,-3500),{119,-1,11:00:00,35:00:00,11.000000,-35.000000}
(-1,11000,-5650),{120,-1,11:00:00,56:30:00,11.000000,-56.500000}
(-2,14917,-2950),{121,-1,14:55:00,29:30:00,14.916667,-29.500000}
(-1,15667,-2950),{122,-1,15:40:00,29:30:00,15.666667,-29.500000}
(-2,13667,-7000),{123,-1,13:40:00,70:00:00,13.666667,-70.000000}
(-1,14750,-7000),{124,-1,14:45:00,70:00:00,14.750000,-70.000000}
(-2,15333,-6000),{125,-1,15:20:00,60:00:00,15.333333,-60.000000}
(-1,15333,-5500),{126,-1,15:20:00,55:00:00,15.333333,-55.000000}
(-1,15050,-5500),{127,-1,15:03:00,55:00:00,15.050000,-55.000000}
(-1,14533,-5500),{128,-1,14:32:00,55:00:00,14.533333,-55.000000}
(-2,16420,-6000),{129,-1,16:25:12,60:00:00,16.420000,-60.000000}
(-1,16420,-4550),{130,-1,16:25:12,45:30:00,16.420000,-45.500000}
(-1,16420,-4200),{131,-1,16:25:12,42:00:00,16.420000,-42.000000}
(-1,16000,-4200),{132,-1,16:00:00,42:00:00,16.000000,-42.000000}
(-1,15667,-4200),{133,-1,15:40:00,42:00:00,15.666667,-42.000000}
(-1,15667,-4800),{134,-1,15:40:00,48:00:00,15.666667,-48.000000}
(-1,15333,-4800),{135,-1,15:20:00,48:00:00,15.333333,-48.000000}
(-1,15333,-5400),{136,-1,15:20:00,54:00:00,15.333333,-54.000000}
(-1,15050,-5400),{137,-1,15:03:00,54:00:00,15.050000,-54.000000}
(-1,15050,-5500),{138,-1,15:03:00,55:00:00,15.050000,-55.000000}
(-2,18000,-4550),{139,-1,18:00:00,45:30:00,18.000000,-45.500000}
(-1,17833,-4550),{140,-1,17:50:00,45:30:00,17.833333,-45.500000}
(-2,17833,-3700),{141,-1,17:50:00,37:00:00,17.833333,-37.000000}
(-1,17833,-4550),{142,-1,17:50:00,45:30:00,17.833333,-45.500000}
(-1,16420,-4550),{143,-1,16:25:12,45:30:00,16.420000,-45.500000}
(-2,8833,-5450),{144,-1,8:50:00,54:30:00,8.833333,-54.500000}
(-1,8450,-5450),{145,-1,8:27:00,54:30:00,8.450000,-54.500000}
(-1,8450,-5300),{146,-1,8:27:00,53:00:00,8.450000,-53.000000}
(-1,8167,-5300),{147,-1,8:10:00,53:00:00,8.166667,-53.000000}
(-1,8167,-5075),{148,-1,8:10:00,50:45:00,8.166667,-50.750000}
(-1,8000,-5075),{149,-1,8:00:00,50:45:00,8.000000,-50.750000}
(-1,6000,-5075),{150,-1,6:00:00,50:45:00,6.000000,-50.750000}
(-1,6000,-5250),{151,-1,6:00:00,52:30:00,6.000000,-52.500000}
(-1,6167,-5250),{152,-1,6:10:00,52:30:00,6.166667,-52.500000}
(-1,6167,-5500),{153,-1,6:10:00,55:00:00,6.166667,-55.000000}
(-1,6500,-5500),{154,-1,6:30:00,55:00:00,6.500000,-55.000000}
(-1,6500,-5800),{155,-1,6:30:00,58:00:00,6.500000,-58.000000}
(-1,6833,-5800),{156,-1,6:50:00,58:00:00,6.833333,-58.000000}
(-1,6833,-6400),{157,-1,6:50:00,64:00:00,6.833333,-64.000000}
(-2,8833,-5650),{158,-1,8:50:00,56:30:00,8.833333,-56.500000}
(-1,11000,-5650),{159,-1,11:00:00,56:30:00,11.000000,-56.500000}
(-2,11000,-3975),{160,-1,11:00:00,39:45:00,11.000000,-39.750000}
(-1,9367,-3975),{161,-1,9:22:00,39:45:00,9.366667,-39.750000}
(-1,9367,-3675),{162,-1,9:22:00,36:45:00,9.366667,-36.750000}
(-1,8367,-3675),{163,-1,8:22:00,36:45:00,8.366667,-36.750000}
(-1,8367,-4300),{164,-1,8:22:00,43:00:00,8.366667,-43.000000}
(-1,8000,-4300),{165,-1,8:00:00,43:00:00,8.000000,-43.000000}
(-1,8000,-5075),{166,-1,8:00:00,50:45:00,8.000000,-50.750000}
(-2,8833,-5450),{167,-1,8:50:00,54:30:00,8.833333,-54.500000}
(-1,8833,-5650),{168,-1,8:50:00,56:30:00,8.833333,-56.500000}
(-2,6000,-6400),{169,-1,6:00:00,64:00:00,6.000000,-64.000000}
(-1,6583,-6400),{170,-1,6:35:00,64:00:00,6.583333,-64.000000}
(-2,6000,-5075),{171,-1,6:00:00,50:45:00,6.000000,-50.750000}
(-1,6000,-4300),{172,-1,6:00:00,43:00:00,6.000000,-43.000000}
(-1,5000,-4300),{173,-1,5:00:00,43:00:00,5.000000,-43.000000}
(-1,4833,-4300),{174,-1,4:50:00,43:00:00,4.833333,-43.000000}
(-1,4833,-4650),{175,-1,4:50:00,46:30:00,4.833333,-46.500000}
(-1,4500,-4650),{176,-1,4:30:00,46:30:00,4.500000,-46.500000}
(-1,4500,-4900),{177,-1,4:30:00,49:00:00,4.500000,-49.000000}
(-1,4500,-5400),{178,-1,4:30:00,54:00:00,4.500000,-54.000000}
(-1,5000,-5400),{179,-1,5:00:00,54:00:00,5.000000,-54.000000}
(-1,5000,-5750),{180,-1,5:00:00,57:30:00,5.000000,-57.500000}
(-1,5500,-5750),{181,-1,5:30:00,57:30:00,5.500000,-57.500000}
(-1,5500,-6100),{182,-1,5:30:00,61:00:00,5.500000,-61.000000}
(-1,6000,-6100),{183,-1,6:00:00,61:00:00,6.000000,-61.000000}
(-1,6000,-6400),{184,-1,6:00:00,64:00:00,6.000000,-64.000000}
(-2,3200,-6750),{185,-1,3:12:00,67:30:00,3.200000,-67.500000}
(-1,3200,-5750),{186,-1,3:12:00,57:30:00,3.200000,-57.500000}
(-1,3500,-5750),{187,-1,3:30:00,57:30:00,3.500000,-57.500000}
(-1,3500,-5317),{188,-1,3:30:00,53:10:00,3.500000,-53.166667}
(-1,3833,-5317),{189,-1,3:50:00,53:10:00,3.833333,-53.166667}
(-1,3833,-5100),{190,-1,3:50:00,51:00:00,3.833333,-51.000000}
(-1,4083,-5100),{191,-1,4:05:00,51:00:00,4.083333,-51.000000}
(-1,4083,-4900),{192,-1,4:05:00,49:00:00,4.083333,-49.000000}
(-1,4267,-4900),{193,-1,4:16:00,49:00:00,4.266667,-49.000000}
(-1,4267,-4000),{194,-1,4:16:00,40:00:00,4.266667,-40.000000}
(-1,3867,-4000),{195,-1,3:52:00,40:00:00,3.866667,-40.000000}
(-1,3867,-4400),{196,-1,3:52:00,44:00:00,3.866667,-44.000000}
(-1,3417,-4400),{197,-1,3:25:00,44:00:00,3.416667,-44.000000}
(-1,3417,-4600),{198,-1,3:25:00,46:00:00,3.416667,-46.000000}
(-1,3000,-4600),{199,-1,3:00:00,46:00:00,3.000000,-46.000000}
(-1,3000,-4900),{200,-1,3:00:00,49:00:00,3.000000,-49.000000}
(-1,2667,-4900),{201,-1,2:40:00,49:00:00,2.666667,-49.000000}
(-1,2667,-5100),{202,-1,2:40:00,51:00:00,2.666667,-51.000000}
(-1,2417,-5100),{203,-1,2:25:00,51:00:00,2.416667,-51.000000}
(-1,2417,-5400),{204,-1,2:25:00,54:00:00,2.416667,-54.000000}
(-1,2167,-5400),{205,-1,2:10:00,54:00:00,2.166667,-54.000000}
(-1,2167,-5850),{206,-1,2:10:00,58:30:00,2.166667,-58.500000}
(-2,4500,-4900),{207,-1,4:30:00,49:00:00,4.500000,-49.000000}
(-1,4083,-4900),{208,-1,4:05:00,49:00:00,4.083333,-49.000000}
(-2,4583,-6750),{209,-1,4:35:00,67:30:00,4.583333,-67.500000}
(-1,4583,-5900),{210,-1,4:35:00,59:00:00,4.583333,-59.000000}
(-1,4333,-5900),{211,-1,4:20:00,59:00:00,4.333333,-59.000000}
(-1,4333,-5650),{212,-1,4:20:00,56:30:00,4.333333,-56.500000}
(-1,4000,-5650),{213,-1,4:00:00,56:30:00,4.000000,-56.500000}
(-1,4000,-5317),{214,-1,4:00:00,53:10:00,4.000000,-53.166667}
(-1,3833,-5317),{215,-1,3:50:00,53:10:00,3.833333,-53.166667}
(-1,3500,-5317),{216,-1,3:30:00,53:10:00,3.500000,-53.166667}
(-2,20333,-4550),{217,-1,20:20:00,45:30:00,20.333333,-45.500000}
(-1,20333,-2800),{218,-1,20:20:00,28:00:00,20.333333,-28.000000}
(-1,20000,-2800),{219,-1,20:00:00,28:00:00,20.000000,-28.000000}
(-1,20000,-1200),{220,-1,20:00:00,12:00:00,20.000000,-12.000000}
(-1,18867,-1200),{221,-1,18:52:00,12:00:00,18.866667,-12.000000}
(-1,18867,-1600),{222,-1,18:52:00,16:00:00,18.866667,-16.000000}
(-1,18250,-1600),{223,-1,18:15:00,16:00:00,18.250000,-16.000000}
(-1,17600,-1600),{224,-1,17:36:00,16:00:00,17.600000,-16.000000}
(-1,17600,-3000),{225,-1,17:36:00,30:00:00,17.600000,-30.000000}
(-1,17833,-3000),{226,-1,17:50:00,30:00:00,17.833333,-30.000000}
(-1,17833,-3700),{227,-1,17:50:00,37:00:00,17.833333,-37.000000}
(-1,19167,-3700),{228,-1,19:10:00,37:00:00,19.166667,-37.000000}
(-1,19167,-4550),{229,-1,19:10:00,45:30:00,19.166667,-45.500000}
(-2,1333,-5850),{230,-1,1:20:00,58:30:00,1.333333,-58.500000}
(-1,1333,-5350),{231,-1,1:20:00,53:30:00,1.333333,-53.500000}
(-1,1583,-5350),{232,-1,1:35:00,53:30:00,1.583333,-53.500000}
(-1,1583,-5150),{233,-1,1:35:00,51:30:00,1.583333,-51.500000}
(-1,1833,-5150),{234,-1,1:50:00,51:30:00,1.833333,-51.500000}
(-1,1833,-4817),{235,-1,1:50:00,48:10:00,1.833333,-48.166667}
(-1,2333,-4817),{236,-1,2:20:00,48:10:00,2.333333,-48.166667}
(-1,2333,-4000),{237,-1,2:20:00,40:00:00,2.333333,-40.000000}
(-1,1667,-4000),{238,-1,1:40:00,40:00:00,1.666667,-40.000000}
(-1,23333,-4000),{239,-1,23:20:00,40:00:00,23.333333,-40.000000}
(-1,23333,-5700),{240,-1,23:20:00,57:00:00,23.333333,-57.000000}
(-2,23000,-2550),{241,-1,23:00:00,25:30:00,23.000000,-25.500000}
(-1,23000,-3700),{242,-1,23:00:00,37:00:00,23.000000,-37.000000}
(-2,23333,-4000),{243,-1,23:20:00,40:00:00,23.333333,-40.000000}
(-1,23333,-3700),{244,-1,23:20:00,37:00:00,23.333333,-37.000000}
(-1,23000,-3700),{245,-1,23:00:00,37:00:00,23.000000,-37.000000}
(-1,21333,-3700),{246,-1,21:20:00,37:00:00,21.333333,-37.000000}
(-1,21333,-4550),{247,-1,21:20:00,45:30:00,21.333333,-45.500000}
(-2,21333,-2800),{248,-1,21:20:00,28:00:00,21.333333,-28.000000}
(-1,21333,-3700),{249,-1,21:20:00,37:00:00,21.333333,-37.000000}
(-2,17600,-3000),{250,-1,17:36:00,30:00:00,17.600000,-30.000000}
(-1,16750,-3000),{251,-1,16:45:00,30:00:00,16.750000,-30.000000}
(-1,16750,-2458),{252,-1,16:45:00,24:35:00,16.750000,-24.583333}
(-1,16267,-2458),{253,-1,16:16:00,24:35:00,16.266667,-24.583333}
(-1,16267,-1925),{254,-1,16:16:00,19:15:00,16.266667,-19.250000}
(-1,16375,-1925),{255,-1,16:22:30,19:15:00,16.375000,-19.250000}
(-1,16375,-1825),{256,-1,16:22:30,18:15:00,16.375000,-18.250000}
(-1,16267,-1825),{257,-1,16:16:00,18:15:00,16.266667,-18.250000}
(-1,16267,-800),{258,-1,16:16:00,8:00:00,16.266667,-8.000000}
(-1,15917,-800),{259,-1,15:55:00,8:00:00,15.916667,-8.000000}
(-1,15917,-2000),{260,-1,15:55:00,20:00:00,15.916667,-20.000000}
(-1,15667,-2000),{261,-1,15:40:00,20:00:00,15.666667,-20.000000}
(-1,15667,-2950),{262,-1,15:40:00,29:30:00,15.666667,-29.500000}
(-1,16000,-2950),{263,-1,16:00:00,29:30:00,16.000000,-29.500000}
(-1,16000,-4200),{264,-1,16:00:00,42:00:00,16.000000,-42.000000}
(-2,10833,-2450),{265,-1,10:50:00,24:30:00,10.833333,-24.500000}
(-1,11833,-2450),{266,-1,11:50:00,24:30:00,11.833333,-24.500000}
(-1,11833,-1100),{267,-1,11:50:00,11:00:00,11.833333,-11.000000}
(-1,11833,-600),{268,-1,11:50:00,6:00:00,11.833333,-6.000000}
(-1,11517,-600),{269,-1,11:31:00,6:00:00,11.516667,-6.000000}
(-1,10750,-600),{270,-1,10:45:00,6:00:00,10.750000,-6.000000}
(-1,10750,-1100),{271,-1,10:45:00,11:00:00,10.750000,-11.000000}
(-1,10750,-1900),{272,-1,10:45:00,19:00:00,10.750000,-19.000000}
(-1,10833,-1900),{273,-1,10:50:00,19:00:00,10.833333,-19.000000}
(-1,10833,-2450),{274,-1,10:50:00,24:30:00,10.833333,-24.500000}
(-2,11833,-2450),{275,-1,11:50:00,24:30:00,11.833333,-24.500000}
(-1,12583,-2450),{276,-1,12:35:00,24:30:00,12.583333,-24.500000}
(-1,12583,-2200),{277,-1,12:35:00,22:00:00,12.583333,-22.000000}
(-1,12833,-2200),{278,-1,12:50:00,22:00:00,12.833333,-22.000000}
(-1,12833,-1100),{279,-1,12:50:00,11:00:00,12.833333,-11.000000}
(-1,11833,-1100),{280,-1,11:50:00,11:00:00,11.833333,-11.000000}
(-2,14250,-2450),{281,-1,14:15:00,24:30:00,14.250000,-24.500000}
(-1,14917,-2450),{282,-1,14:55:00,24:30:00,14.916667,-24.500000}
(-1,14917,-2950),{283,-1,14:55:00,29:30:00,14.916667,-29.500000}
(-2,15917,-800),{284,-1,15:55:00,8:00:00,15.916667,-8.000000}
(-1,15917,-325),{285,-1,15:55:00,3:15:00,15.916667,-3.250000}
(-1,15083,-325),{286,-1,15:05:00,3:15:00,15.083333,-3.250000}
(-1,15083,0),{287,1,15:05:00,0:00:00,15.083333,0.000000}
(-1,14667,0),{288,-1,14:40:00,0:00:00,14.666667,0.000000}
(-1,14667,-800),{289,-1,14:40:00,8:00:00,14.666667,-8.000000}
(-1,14250,-800),{290,-1,14:15:00,8:00:00,14.250000,-8.000000}
(-1,14250,-2450),{291,-1,14:15:00,24:30:00,14.250000,-24.500000}
(-2,12833,-2200),{292,-1,12:50:00,22:00:00,12.833333,-22.000000}
(-1,14250,-2200),{293,-1,14:15:00,22:00:00,14.250000,-22.000000}
(-2,20333,-2800),{294,-1,20:20:00,28:00:00,20.333333,-28.000000}
(-1,21333,-2800),{295,-1,21:20:00,28:00:00,21.333333,-28.000000}
(-1,21333,-2550),{296,-1,21:20:00,25:30:00,21.333333,-25.500000}
(-1,21867,-2550),{297,-1,21:52:00,25:30:00,21.866667,-25.500000}
(-1,21867,-900),{298,-1,21:52:00,9:00:00,21.866667,-9.000000}
(-1,21333,-900),{299,-1,21:20:00,9:00:00,21.333333,-9.000000}
(-1,21333,-1500),{300,-1,21:20:00,15:00:00,21.333333,-15.000000}
(-1,20533,-1500),{301,-1,20:32:00,15:00:00,20.533333,-15.000000}
(-1,20533,-900),{302,-1,20:32:00,9:00:00,20.533333,-9.000000}
(-1,20000,-900),{303,-1,20:00:00,9:00:00,20.000000,-9.000000}
(-1,20000,-1200),{304,-1,20:00:00,12:00:00,20.000000,-12.000000}
(-2,21867,-2550),{305,-1,21:52:00,25:30:00,21.866667,-25.500000}
(-1,23000,-2550),{306,-1,23:00:00,25:30:00,23.000000,-25.500000}
(-1,23833,-2550),{307,-1,23:50:00,25:30:00,23.833333,-25.500000}
(-1,23833,-700),{308,-1,23:50:00,7:00:00,23.833333,-7.000000}
(-1,23833,-400),{309,-1,23:50:00,4:00:00,23.833333,-4.000000}
(-1,22750,-400),{310,-1,22:45:00,4:00:00,22.750000,-4.000000}
(-1,22750,200),{311,1,22:45:00,2:00:00,22.750000,2.000000}
(-1,22000,200),{312,1,22:00:00,2:00:00,22.000000,2.000000}
(-1,22000,175),{313,1,22:00:00,1:45:00,22.000000,1.750000}
(-1,21667,175),{314,1,21:40:00,1:45:00,21.666667,1.750000}
(-1,21667,275),{315,1,21:40:00,2:45:00,21.666667,2.750000}
(-1,21467,275),{316,1,21:28:00,2:45:00,21.466667,2.750000}
(-1,21467,200),{317,1,21:28:00,2:00:00,21.466667,2.000000}
(-1,21333,200),{318,1,21:20:00,2:00:00,21.333333,2.000000}
(-1,20833,200),{319,1,20:50:00,2:00:00,20.833333,2.000000}
(-1,20533,200),{320,1,20:32:00,2:00:00,20.533333,2.000000}
(-1,20533,-900),{321,-1,20:32:00,9:00:00,20.533333,-9.000000}
(-2,1667,-4000),{322,-1,1:40:00,40:00:00,1.666667,-40.000000}
(-1,1667,-2550),{323,-1,1:40:00,25:30:00,1.666667,-25.500000}
(-1,1667,-2550),{324,-1,1:40:00,25:30:00,1.666667,-25.500000}
(-1,23833,-2550),{325,-1,23:50:00,25:30:00,23.833333,-25.500000}
(-2,2333,-4000),{326,-1,2:20:00,40:00:00,2.333333,-40.000000}
(-1,3000,-4000),{327,-1,3:00:00,40:00:00,3.000000,-40.000000}
(-1,3000,-3958),{328,-1,3:00:00,39:35:00,3.000000,-39.583333}
(-1,3500,-3958),{329,-1,3:30:00,39:35:00,3.500000,-39.583333}
(-1,3500,-3600),{330,-1,3:30:00,36:00:00,3.500000,-36.000000}
(-1,3750,-3600),{331,-1,3:45:00,36:00:00,3.750000,-36.000000}
(-1,3750,-2442),{332,-1,3:45:00,24:25:00,3.750000,-24.416667}
(-1,2650,-2442),{333,-1,2:39:00,24:25:00,2.650000,-24.416667}
(-1,1667,-2442),{334,-1,1:40:00,24:25:00,1.666667,-24.416667}
(-1,1667,-2550),{335,-1,1:40:00,25:30:00,1.666667,-25.500000}
(-2,11000,-3500),{336,-1,11:00:00,35:00:00,11.000000,-35.000000}
(-1,10833,-3500),{337,-1,10:50:00,35:00:00,10.833333,-35.000000}
(-1,10833,-3117),{338,-1,10:50:00,31:10:00,10.833333,-31.166667}
(-1,10583,-3117),{339,-1,10:35:00,31:10:00,10.583333,-31.166667}
(-1,10583,-2917),{340,-1,10:35:00,29:10:00,10.583333,-29.166667}
(-1,10250,-2917),{341,-1,10:15:00,29:10:00,10.250000,-29.166667}
(-1,10250,-2650),{342,-1,10:15:00,26:30:00,10.250000,-26.500000}
(-1,9750,-2650),{343,-1,9:45:00,26:30:00,9.750000,-26.500000}
(-1,9750,-2400),{344,-1,9:45:00,24:00:00,9.750000,-24.000000}
(-1,9367,-2400),{345,-1,9:22:00,24:00:00,9.366667,-24.000000}
(-1,9367,-3675),{346,-1,9:22:00,36:45:00,9.366667,-36.750000}
(-2,9367,-2400),{347,-1,9:22:00,24:00:00,9.366667,-24.000000}
(-1,9083,-2400),{348,-1,9:05:00,24:00:00,9.083333,-24.000000}
(-1,9083,-1900),{349,-1,9:05:00,19:00:00,9.083333,-19.000000}
(-1,8583,-1900),{350,-1,8:35:00,19:00:00,8.583333,-19.000000}
(-1,8583,-1700),{351,-1,8:35:00,17:00:00,8.583333,-17.000000}
(-1,8367,-1700),{352,-1,8:22:00,17:00:00,8.366667,-17.000000}
(-1,8367,-3675),{353,-1,8:22:00,36:45:00,8.366667,-36.750000}
(-2,5000,-4300),{354,-1,5:00:00,43:00:00,5.000000,-43.000000}
(-1,5000,-2725),{355,-1,5:00:00,27:15:00,5.000000,-27.250000}
(-1,4833,-2725),{356,-1,4:50:00,27:15:00,4.833333,-27.250000}
(-1,4700,-2725),{357,-1,4:42:00,27:15:00,4.700000,-27.250000}
(-1,4700,-3000),{358,-1,4:42:00,30:00:00,4.700000,-30.000000}
(-1,4583,-3000),{359,-1,4:35:00,30:00:00,4.583333,-30.000000}
(-1,4583,-3700),{360,-1,4:35:00,37:00:00,4.583333,-37.000000}
(-1,4267,-3700),{361,-1,4:16:00,37:00:00,4.266667,-37.000000}
(-1,4267,-4000),{362,-1,4:16:00,40:00:00,4.266667,-40.000000}
(-2,6000,-4300),{363,-1,6:00:00,43:00:00,6.000000,-43.000000}
(-1,6583,-4300),{364,-1,6:35:00,43:00:00,6.583333,-43.000000}
(-1,6583,-3300),{365,-1,6:35:00,33:00:00,6.583333,-33.000000}
(-1,6117,-3300),{366,-1,6:07:00,33:00:00,6.116667,-33.000000}
(-1,6117,-2725),{367,-1,6:07:00,27:15:00,6.116667,-27.250000}
(-1,5000,-2725),{368,-1,5:00:00,27:15:00,5.000000,-27.250000}
(-2,8367,-1700),{369,-1,8:22:00,17:00:00,8.366667,-17.000000}
(-1,8367,-1100),{370,-1,8:22:00,11:00:00,8.366667,-11.000000}
(-1,8083,-1100),{371,-1,8:05:00,11:00:00,8.083333,-11.000000}
(-1,7367,-1100),{372,-1,7:22:00,11:00:00,7.366667,-11.000000}
(-1,7367,-3300),{373,-1,7:22:00,33:00:00,7.366667,-33.000000}
(-1,6583,-3300),{374,-1,6:35:00,33:00:00,6.583333,-33.000000}
(-2,6117,-1100),{375,-1,6:07:00,11:00:00,6.116667,-11.000000}
(-1,6117,-2725),{376,-1,6:07:00,27:15:00,6.116667,-27.250000}
(-2,10750,-1100),{377,-1,10:45:00,11:00:00,10.750000,-11.000000}
(-1,9583,-1100),{378,-1,9:35:00,11:00:00,9.583333,-11.000000}
(-1,9583,700),{379,1,9:35:00,7:00:00,9.583333,7.000000}
(-1,9250,700),{380,1,9:15:00,7:00:00,9.250000,7.000000}
(-1,8083,700),{381,1,8:05:00,7:00:00,8.083333,7.000000}
(-1,8083,0),{382,-1,8:05:00,0:00:00,8.083333,0.000000}
(-1,8083,-1100),{383,-1,8:05:00,11:00:00,8.083333,-11.000000}
(-2,5833,-1100),{384,-1,5:50:00,11:00:00,5.833333,-11.000000}
(-1,6117,-1100),{385,-1,6:07:00,11:00:00,6.116667,-11.000000}
(-1,7367,-1100),{386,-1,7:22:00,11:00:00,7.366667,-11.000000}
(-2,8083,0),{387,-1,8:05:00,0:00:00,8.083333,0.000000}
(-1,7200,0),{388,1,7:12:00,0:00:00,7.200000,0.000000}
(-1,7200,150),{389,1,7:12:00,1:30:00,7.200000,1.500000}
(-1,7017,150),{390,1,7:01:00,1:30:00,7.016667,1.500000}
(-1,7017,550),{391,1,7:01:00,5:30:00,7.016667,5.500000}
(-1,7000,550),{392,1,7:00:00,5:30:00,7.000000,5.500000}
(-1,7000,1000),{393,1,7:00:00,10:00:00,7.000000,10.000000}
(-1,6933,1000),{394,1,6:56:00,10:00:00,6.933333,10.000000}
(-1,6933,1200),{395,1,6:56:00,12:00:00,6.933333,12.000000}
(-1,6308,1200),{396,1,6:18:30,12:00:00,6.308333,12.000000}
(-1,6308,1000),{397,1,6:18:30,10:00:00,6.308333,10.000000}
(-1,6242,1000),{398,1,6:14:30,10:00:00,6.241667,10.000000}
(-1,6242,-400),{399,-1,6:14:30,4:00:00,6.241667,-4.000000}
(-1,5833,-400),{400,-1,5:50:00,4:00:00,5.833333,-4.000000}
(-1,5833,-1100),{401,-1,5:50:00,11:00:00,5.833333,-11.000000}
(-2,5833,-1100),{402,-1,5:50:00,11:00:00,5.833333,-11.000000}
(-1,5083,-1100),{403,-1,5:05:00,11:00:00,5.083333,-11.000000}
(-1,4917,-1100),{404,-1,4:55:00,11:00:00,4.916667,-11.000000}
(-1,4917,-1450),{405,-1,4:55:00,14:30:00,4.916667,-14.500000}
(-1,4833,-1450),{406,-1,4:50:00,14:30:00,4.833333,-14.500000}
(-1,4833,-2725),{407,-1,4:50:00,27:15:00,4.833333,-27.250000}
(-2,2650,-2442),{408,-1,2:39:00,24:25:00,2.650000,-24.416667}
(-1,2650,-175),{409,-1,2:39:00,1:45:00,2.650000,-1.750000}
(-1,3283,-175),{410,-1,3:17:00,1:45:00,3.283333,-1.750000}
(-1,3283,992),{411,1,3:17:00,9:55:00,3.283333,9.916667}
(-1,2000,992),{412,1,2:00:00,9:55:00,2.000000,9.916667}
(-1,2000,200),{413,1,2:00:00,2:00:00,2.000000,2.000000}
(-1,333,200),{414,1,0:20:00,2:00:00,0.333333,2.000000}
(-1,333,-700),{415,-1,0:20:00,7:00:00,0.333333,-7.000000}
(-1,23833,-700),{416,-1,23:50:00,7:00:00,23.833333,-7.000000}
(-2,17167,-1600),{417,-1,17:10:00,16:00:00,17.166667,-16.000000}
(-1,17600,-1600),{418,-1,17:36:00,16:00:00,17.600000,-16.000000}
(-2,18250,-1600),{419,-1,18:15:00,16:00:00,18.250000,-16.000000}
(-1,18250,-400),{420,-1,18:15:00,4:00:00,18.250000,-4.000000}
(-1,18583,-400),{421,-1,18:35:00,4:00:00,18.583333,-4.000000}
(-1,18583,200),{422,1,18:35:00,2:00:00,18.583333,2.000000}
(-1,18867,200),{423,1,18:52:00,2:00:00,18.866667,2.000000}
(-1,18867,625),{424,1,18:52:00,6:15:00,18.866667,6.250000}
(-1,18662,625),{425,1,18:39:44,6:15:00,18.662317,6.250000}
(-1,18250,625),{426,1,18:15:00,6:15:00,18.250000,6.250000}
(-1,18250,450),{427,1,18:15:00,4:30:00,18.250000,4.500000}
(-1,18422,450),{428,1,18:25:18,4:30:00,18.421667,4.500000}
(-1,18422,300),{429,1,18:25:18,3:00:00,18.421667,3.000000}
(-1,18250,300),{430,1,18:15:00,3:00:00,18.250000,3.000000}
(-1,18250,0),{431,1,18:15:00,0:00:00,18.250000,0.000000}
(-1,17833,0),{432,1,17:50:00,0:00:00,17.833333,0.000000}
(-1,17833,-400),{433,-1,17:50:00,4:00:00,17.833333,-4.000000}
(-1,17967,-400),{434,-1,17:58:00,4:00:00,17.966667,-4.000000}
(-1,17967,-1000),{435,-1,17:58:00,10:00:00,17.966667,-10.000000}
(-1,17667,-1000),{436,-1,17:40:00,10:00:00,17.666667,-10.000000}
(-1,17667,-1167),{437,-1,17:40:00,11:40:00,17.666667,-11.666667}
(-1,17583,-1167),{438,-1,17:35:00,11:40:00,17.583333,-11.666667}
(-1,17583,-1000),{439,-1,17:35:00,10:00:00,17.583333,-10.000000}
(-1,17167,-1000),{440,-1,17:10:00,10:00:00,17.166667,-10.000000}
(-1,17167,-1600),{441,-1,17:10:00,16:00:00,17.166667,-16.000000}
(-2,20533,200),{442,1,20:32:00,2:00:00,20.533333,2.000000}
(-1,20300,200),{443,1,20:18:00,2:00:00,20.300000,2.000000}
(-1,20300,850),{444,1,20:18:00,8:30:00,20.300000,8.500000}
(-1,20142,850),{445,1,20:08:30,8:30:00,20.141667,8.500000}
(-1,20142,1575),{446,1,20:08:30,15:45:00,20.141667,15.750000}
(-1,19833,1575),{447,1,19:50:00,15:45:00,19.833333,15.750000}
(-1,19833,1617),{448,1,19:50:00,16:10:00,19.833333,16.166667}
(-1,19000,1617),{449,1,19:00:00,16:10:00,19.000000,16.166667}
(-1,19000,1850),{450,1,19:00:00,18:30:00,19.000000,18.500000}
(-1,18867,1850),{451,1,18:52:00,18:30:00,18.866667,18.500000}
(-1,18867,1200),{452,1,18:52:00,12:00:00,18.866667,12.000000}
(-1,18662,1200),{453,1,18:39:44,12:00:00,18.662317,12.000000}
(-1,18662,625),{454,1,18:39:44,6:15:00,18.662317,6.250000}
(-2,21333,200),{455,1,21:20:00,2:00:00,21.333333,2.000000}
(-1,21333,1250),{456,1,21:20:00,12:30:00,21.333333,12.500000}
(-1,21117,1250),{457,1,21:07:00,12:30:00,21.116667,12.500000}
(-1,21117,1183),{458,1,21:07:00,11:50:00,21.116667,11.833333}
(-1,21050,1183),{459,1,21:03:00,11:50:00,21.050000,11.833333}
(-1,20875,1183),{460,1,20:52:30,11:50:00,20.875000,11.833333}
(-1,20875,600),{461,1,20:52:30,6:00:00,20.875000,6.000000}
(-1,20833,600),{462,1,20:50:00,6:00:00,20.833333,6.000000}
(-1,20833,200),{463,1,20:50:00,2:00:00,20.833333,2.000000}
(-2,21050,1183),{464,1,21:03:00,11:50:00,21.050000,11.833333}
(-1,21050,1950),{465,1,21:03:00,19:30:00,21.050000,19.500000}
(-1,20567,1950),{466,1,20:34:00,19:30:00,20.566667,19.500000}
(-1,20567,2050),{467,1,20:34:00,20:30:00,20.566667,20.500000}
(-1,20250,2050),{468,1,20:15:00,20:30:00,20.250000,20.500000}
(-2,21050,1950),{469,1,21:03:00,19:30:00,21.050000,19.500000}
(-1,21250,1950),{470,1,21:15:00,19:30:00,21.250000,19.500000}
(-1,21250,2350),{471,1,21:15:00,23:30:00,21.250000,23.500000}
(-1,21417,2350),{472,1,21:25:00,23:30:00,21.416667,23.500000}
(-1,21417,2800),{473,1,21:25:00,28:00:00,21.416667,28.000000}
(-1,20917,2800),{474,1,20:55:00,28:00:00,20.916667,28.000000}
(-1,20917,2900),{475,1,20:55:00,29:00:00,20.916667,29.000000}
(-1,19667,2900),{476,1,19:40:00,29:00:00,19.666667,29.000000}
(-1,19667,2750),{477,1,19:40:00,27:30:00,19.666667,27.500000}
(-1,19258,2750),{478,1,19:15:30,27:30:00,19.258333,27.500000}
(-1,19258,2550),{479,1,19:15:30,25:30:00,19.258333,25.500000}
(-1,18867,2550),{480,1,18:52:00,25:30:00,18.866667,25.500000}
(-1,18867,2108),{481,1,18:52:00,21:05:00,18.866667,21.083333}
(-2,5083,-1100),{482,-1,5:05:00,11:00:00,5.083333,-11.000000}
(-1,5083,-400),{483,-1,5:05:00,4:00:00,5.083333,-4.000000}
(-1,4667,-400),{484,-1,4:40:00,4:00:00,4.666667,-4.000000}
(-1,4667,0),{485,1,4:40:00,0:00:00,4.666667,0.000000}
(-1,4617,0),{486,1,4:37:00,0:00:00,4.616667,0.000000}
(-1,3583,0),{487,-1,3:35:00,0:00:00,3.583333,0.000000}
(-1,3583,-175),{488,-1,3:35:00,1:45:00,3.583333,-1.750000}
(-1,3283,-175),{489,-1,3:17:00,1:45:00,3.283333,-1.750000}
(-2,18662,1200),{490,1,18:39:44,12:00:00,18.662317,12.000000}
(-1,18250,1200),{491,1,18:15:00,12:00:00,18.250000,12.000000}
(-1,18250,1433),{492,1,18:15:00,14:20:00,18.250000,14.333333}
(-1,17250,1433),{493,1,17:15:00,14:20:00,17.250000,14.333333}
(-1,17250,1283),{494,1,17:15:00,12:50:00,17.250000,12.833333}
(-1,16750,1283),{495,1,16:45:00,12:50:00,16.750000,12.833333}
(-1,16750,400),{496,1,16:45:00,4:00:00,16.750000,4.000000}
(-1,16267,400),{497,1,16:16:00,4:00:00,16.266667,4.000000}
(-1,16267,-325),{498,-1,16:16:00,3:15:00,16.266667,-3.250000}
(-1,15917,-325),{499,-1,15:55:00,3:15:00,15.916667,-3.250000}
(-2,18867,-1200),{500,-1,18:52:00,12:00:00,18.866667,-12.000000}
(-1,18867,-400),{501,-1,18:52:00,4:00:00,18.866667,-4.000000}
(-1,18583,-400),{502,-1,18:35:00,4:00:00,18.583333,-4.000000}
(-2,20142,1575),{503,1,20:08:30,15:45:00,20.141667,15.750000}
(-1,20250,1575),{504,1,20:15:00,15:45:00,20.250000,15.750000}
(-1,20250,2050),{505,1,20:15:00,20:30:00,20.250000,20.500000}
(-1,20250,2125),{506,1,20:15:00,21:15:00,20.250000,21.250000}
(-1,19833,2125),{507,1,19:50:00,21:15:00,19.833333,21.250000}
(-1,19833,1917),{508,1,19:50:00,19:10:00,19.833333,19.166667}
(-1,19250,1917),{509,1,19:15:00,19:10:00,19.250000,19.166667}
(-1,19250,2108),{510,1,19:15:00,21:05:00,19.250000,21.083333}
(-1,18867,2108),{511,1,18:52:00,21:05:00,18.866667,21.083333}
(-1,18867,1850),{512,1,18:52:00,18:30:00,18.866667,18.500000}
(-2,16267,400),{513,1,16:16:00,4:00:00,16.266667,4.000000}
(-1,16083,400),{514,1,16:05:00,4:00:00,16.083333,4.000000}
(-1,16083,1600),{515,1,16:05:00,16:00:00,16.083333,16.000000}
(-1,15917,1600),{516,1,15:55:00,16:00:00,15.916667,16.000000}
(-1,15917,2200),{517,1,15:55:00,22:00:00,15.916667,22.000000}
(-1,16033,2200),{518,1,16:02:00,22:00:00,16.033333,22.000000}
(-1,16033,2600),{519,1,16:02:00,26:00:00,16.033333,26.000000}
(-1,15183,2600),{520,1,15:11:00,26:00:00,15.183333,26.000000}
(-1,15083,2600),{521,1,15:05:00,26:00:00,15.083333,26.000000}
(-1,15083,800),{522,1,15:05:00,8:00:00,15.083333,8.000000}
(-1,15083,0),{523,1,15:05:00,0:00:00,15.083333,0.000000}
(-2,15083,800),{524,1,15:05:00,8:00:00,15.083333,8.000000}
(-1,13500,800),{525,1,13:30:00,8:00:00,13.500000,8.000000}
(-1,13500,1500),{526,1,13:30:00,15:00:00,13.500000,15.000000}
(-1,12833,1500),{527,1,12:50:00,15:00:00,12.833333,15.000000}
(-1,12833,1400),{528,1,12:50:00,14:00:00,12.833333,14.000000}
(-1,12833,1400),{529,1,12:50:00,14:00:00,12.833333,14.000000}
(-1,11867,1400),{530,1,11:52:00,14:00:00,11.866667,14.000000}
(-1,11867,1100),{531,1,11:52:00,11:00:00,11.866667,11.000000}
(-1,11517,1100),{532,1,11:31:00,11:00:00,11.516667,11.000000}
(-1,11517,-600),{533,-1,11:31:00,6:00:00,11.516667,-6.000000}
(-2,13500,1500),{534,1,13:30:00,15:00:00,13.500000,15.000000}
(-1,13500,2850),{535,1,13:30:00,28:30:00,13.500000,28.500000}
(-1,13250,2850),{536,1,13:15:00,28:30:00,13.250000,28.500000}
(-1,13250,3200),{537,1,13:15:00,32:00:00,13.250000,32.000000}
(-1,12333,3200),{538,1,12:20:00,32:00:00,12.333333,32.000000}
(-1,12333,3400),{539,1,12:20:00,34:00:00,12.333333,34.000000}
(-1,12000,3400),{540,1,12:00:00,34:00:00,12.000000,34.000000}
(-1,12000,2900),{541,1,12:00:00,29:00:00,12.000000,29.000000}
(-1,11867,2900),{542,1,11:52:00,29:00:00,11.866667,29.000000}
(-1,11867,1400),{543,1,11:52:00,14:00:00,11.866667,14.000000}
(-2,11000,2900),{544,1,11:00:00,29:00:00,11.000000,29.000000}
(-1,11867,2900),{545,1,11:52:00,29:00:00,11.866667,29.000000}
(-2,22750,200),{546,1,22:45:00,2:00:00,22.750000,2.000000}
(-1,22750,750),{547,1,22:45:00,7:30:00,22.750000,7.500000}
(-1,23833,750),{548,1,23:50:00,7:30:00,23.833333,7.500000}
(-1,23833,1000),{549,1,23:50:00,10:00:00,23.833333,10.000000}
(-1,0,1000),{550,1,0:00:00,10:00:00,0.000000,10.000000}
(-1,0,1250),{551,1,0:00:00,12:30:00,0.000000,12.500000}
(-1,142,1250),{552,1,0:08:30,12:30:00,0.141667,12.500000}
(-1,142,2100),{553,1,0:08:30,21:00:00,0.141667,21.000000}
(-1,142,2200),{554,1,0:08:30,22:00:00,0.141667,22.000000}
(-1,67,2200),{555,1,0:04:00,22:00:00,0.066667,22.000000}
(-1,67,2800),{556,1,0:04:00,28:00:00,0.066667,28.000000}
(-1,24000,2800),{557,1,24:00:00,28:00:00,24.000000,28.000000}
(-1,24000,3133),{558,1,24:00:00,31:20:00,24.000000,31.333333}
(-1,23750,3133),{559,1,23:45:00,31:20:00,23.750000,31.333333}
(-1,23750,3208),{560,1,23:45:00,32:05:00,23.750000,32.083333}
(-1,23500,3208),{561,1,23:30:00,32:05:00,23.500000,32.083333}
(-1,23500,3450),{562,1,23:30:00,34:30:00,23.500000,34.500000}
(-1,22817,3450),{563,1,22:49:00,34:30:00,22.816667,34.500000}
(-1,22817,3450),{564,1,22:49:00,34:30:00,22.816667,34.500000}
(-1,22817,3500),{565,1,22:49:00,35:00:00,22.816667,35.000000}
(-1,22000,3500),{566,1,22:00:00,35:00:00,22.000000,35.000000}
(-1,22000,3600),{567,1,22:00:00,36:00:00,22.000000,36.000000}
(-1,21875,3600),{568,1,21:52:30,36:00:00,21.875000,36.000000}
(-1,21733,3600),{569,1,21:44:00,36:00:00,21.733333,36.000000}
(-1,21733,2800),{570,1,21:44:00,28:00:00,21.733333,28.000000}
(-1,21417,2800),{571,1,21:25:00,28:00:00,21.416667,28.000000}
(-2,2000,992),{572,1,2:00:00,9:55:00,2.000000,9.916667}
(-1,1667,992),{573,1,1:40:00,9:55:00,1.666667,9.916667}
(-1,1667,2500),{574,1,1:40:00,25:00:00,1.666667,25.000000}
(-1,1667,2800),{575,1,1:40:00,28:00:00,1.666667,28.000000}
(-1,1408,2800),{576,1,1:24:30,28:00:00,1.408333,28.000000}
(-1,1408,3300),{577,1,1:24:30,33:00:00,1.408333,33.000000}
(-1,717,3300),{578,1,0:43:00,33:00:00,0.716667,33.000000}
(-1,717,2375),{579,1,0:43:00,23:45:00,0.716667,23.750000}
(-1,850,2375),{580,1,0:51:00,23:45:00,0.850000,23.750000}
(-1,850,2100),{581,1,0:51:00,21:00:00,0.850000,21.000000}
(-1,142,2100),{582,1,0:08:30,21:00:00,0.141667,21.000000}
(-2,21875,3600),{583,1,21:52:30,36:00:00,21.875000,36.000000}
(-1,21875,4375),{584,1,21:52:30,43:45:00,21.875000,43.750000}
(-1,21908,4375),{585,1,21:54:30,43:45:00,21.908333,43.750000}
(-1,21908,4400),{586,1,21:54:30,44:00:00,21.908333,44.000000}
(-1,21967,4400),{587,1,21:58:00,44:00:00,21.966667,44.000000}
(-1,21967,5275),{588,1,21:58:00,52:45:00,21.966667,52.750000}
(-1,21967,5483),{589,1,21:58:00,54:50:00,21.966667,54.833333}
(-1,20600,5483),{590,1,20:36:00,54:50:00,20.600000,54.833333}
(-1,20600,6092),{591,1,20:36:00,60:55:00,20.600000,60.916667}
(-1,20537,6092),{592,1,20:32:12,60:55:00,20.536667,60.916667}
(-1,20537,5950),{593,1,20:32:12,59:30:00,20.536667,59.500000}
(-1,20000,5950),{594,1,20:00:00,59:30:00,20.000000,59.500000}
(-1,19767,5950),{595,1,19:46:00,59:30:00,19.766667,59.500000}
(-1,19767,5800),{596,1,19:46:00,58:00:00,19.766667,58.000000}
(-1,19417,5800),{597,1,19:25:00,58:00:00,19.416667,58.000000}
(-1,19417,5550),{598,1,19:25:00,55:30:00,19.416667,55.500000}
(-1,19083,5550),{599,1,19:05:00,55:30:00,19.083333,55.500000}
(-1,19083,4750),{600,1,19:05:00,47:30:00,19.083333,47.500000}
(-1,19167,4750),{601,1,19:10:00,47:30:00,19.166667,47.500000}
(-1,19167,4350),{602,1,19:10:00,43:30:00,19.166667,43.500000}
(-1,19400,4350),{603,1,19:24:00,43:30:00,19.400000,43.500000}
(-1,19400,3650),{604,1,19:24:00,36:30:00,19.400000,36.500000}
(-1,19358,3650),{605,1,19:21:30,36:30:00,19.358333,36.500000}
(-1,19358,3000),{606,1,19:21:30,30:00:00,19.358333,30.000000}
(-1,19258,3000),{607,1,19:15:30,30:00:00,19.258333,30.000000}
(-1,19258,2750),{608,1,19:15:30,27:30:00,19.258333,27.500000}
(-2,18367,2600),{609,1,18:22:00,26:00:00,18.366667,26.000000}
(-1,18867,2600),{610,1,18:52:00,26:00:00,18.866667,26.000000}
(-1,18867,2550),{611,1,18:52:00,25:30:00,18.866667,25.500000}
(-2,19083,4750),{612,1,19:05:00,47:30:00,19.083333,47.500000}
(-1,18175,4750),{613,1,18:10:30,47:30:00,18.175000,47.500000}
(-1,18175,4750),{614,1,18:10:30,47:30:00,18.175000,47.500000}
(-1,18175,3000),{615,1,18:10:30,30:00:00,18.175000,30.000000}
(-1,18367,3000),{616,1,18:22:00,30:00:00,18.366667,30.000000}
(-1,18367,2600),{617,1,18:22:00,26:00:00,18.366667,26.000000}
(-2,22867,3450),{618,1,22:52:00,34:30:00,22.866667,34.500000}
(-1,22867,5250),{619,1,22:52:00,52:30:00,22.866667,52.500000}
(-1,22867,5625),{620,1,22:52:00,56:15:00,22.866667,56.250000}
(-1,22317,5625),{621,1,22:19:00,56:15:00,22.316667,56.250000}
(-1,22317,5500),{622,1,22:19:00,55:00:00,22.316667,55.000000}
(-1,22133,5500),{623,1,22:08:00,55:00:00,22.133333,55.000000}
(-1,22133,5275),{624,1,22:08:00,52:45:00,22.133333,52.750000}
(-1,21967,5275),{625,1,21:58:00,52:45:00,21.966667,52.750000}
(-2,18175,4750),{626,1,18:10:30,47:30:00,18.175000,47.500000}
(-1,18233,4750),{627,1,18:14:00,47:30:00,18.233333,47.500000}
(-1,18233,5050),{628,1,18:14:00,50:30:00,18.233333,50.500000}
(-1,17000,5050),{629,1,17:00:00,50:30:00,17.000000,50.500000}
(-1,17000,5150),{630,1,17:00:00,51:30:00,17.000000,51.500000}
(-1,15750,5150),{631,1,15:45:00,51:30:00,15.750000,51.500000}
(-1,15750,4000),{632,1,15:45:00,40:00:00,15.750000,40.000000}
(-1,16333,4000),{633,1,16:20:00,40:00:00,16.333333,40.000000}
(-1,16333,2700),{634,1,16:20:00,27:00:00,16.333333,27.000000}
(-1,16167,2700),{635,1,16:10:00,27:00:00,16.166667,27.000000}
(-1,16167,2600),{636,1,16:10:00,26:00:00,16.166667,26.000000}
(-1,16033,2600),{637,1,16:02:00,26:00:00,16.033333,26.000000}
(-2,15750,4000),{638,1,15:45:00,40:00:00,15.750000,40.000000}
(-1,15433,4000),{639,1,15:26:00,40:00:00,15.433333,40.000000}
(-1,15433,3300),{640,1,15:26:00,33:00:00,15.433333,33.000000}
(-1,15183,3300),{641,1,15:11:00,33:00:00,15.183333,33.000000}
(-1,15183,2600),{642,1,15:11:00,26:00:00,15.183333,26.000000}
(-2,15750,5150),{643,1,15:45:00,51:30:00,15.750000,51.500000}
(-1,15750,5300),{644,1,15:45:00,53:00:00,15.750000,53.000000}
(-1,15250,5300),{645,1,15:15:00,53:00:00,15.250000,53.000000}
(-1,15250,5550),{646,1,15:15:00,55:30:00,15.250000,55.500000}
(-1,14417,5550),{647,1,14:25:00,55:30:00,14.416667,55.500000}
(-1,14033,5550),{648,1,14:02:00,55:30:00,14.033333,55.500000}
(-1,14033,4850),{649,1,14:02:00,48:30:00,14.033333,48.500000}
(-1,14033,3075),{650,1,14:02:00,30:45:00,14.033333,30.750000}
(-1,13958,3075),{651,1,13:57:30,30:45:00,13.958333,30.750000}
(-1,13958,2850),{652,1,13:57:30,28:30:00,13.958333,28.500000}
(-1,13500,2850),{653,1,13:30:00,28:30:00,13.500000,28.500000}
(-2,14033,4850),{654,1,14:02:00,48:30:00,14.033333,48.500000}
(-1,13500,4850),{655,1,13:30:00,48:30:00,13.500000,48.500000}
(-1,13500,5300),{656,1,13:30:00,53:00:00,13.500000,53.000000}
(-1,12083,5300),{657,1,12:05:00,53:00:00,12.083333,53.000000}
(-1,12083,4500),{658,1,12:05:00,45:00:00,12.083333,45.000000}
(-1,12000,4500),{659,1,12:00:00,45:00:00,12.000000,45.000000}
(-1,12000,3400),{660,1,12:00:00,34:00:00,12.000000,34.000000}
(-2,9250,3350),{661,1,9:15:00,33:30:00,9.250000,33.500000}
(-1,9883,3350),{662,1,9:53:00,33:30:00,9.883333,33.500000}
(-1,9883,2850),{663,1,9:53:00,28:30:00,9.883333,28.500000}
(-1,10500,2850),{664,1,10:30:00,28:30:00,10.500000,28.500000}
(-1,10500,2350),{665,1,10:30:00,23:30:00,10.500000,23.500000}
(-1,10750,2350),{666,1,10:45:00,23:30:00,10.750000,23.500000}
(-1,10750,2550),{667,1,10:45:00,25:30:00,10.750000,25.500000}
(-1,11000,2550),{668,1,11:00:00,25:30:00,11.000000,25.500000}
(-1,11000,2900),{669,1,11:00:00,29:00:00,11.000000,29.000000}
(-1,11000,3400),{670,1,11:00:00,34:00:00,11.000000,34.000000}
(-1,10783,3400),{671,1,10:47:00,34:00:00,10.783333,34.000000}
(-1,10783,4000),{672,1,10:47:00,40:00:00,10.783333,40.000000}
(-1,10167,4000),{673,1,10:10:00,40:00:00,10.166667,40.000000}
(-1,10167,4200),{674,1,10:10:00,42:00:00,10.166667,42.000000}
(-1,9583,4200),{675,1,9:35:00,42:00:00,9.583333,42.000000}
(-1,9583,3975),{676,1,9:35:00,39:45:00,9.583333,39.750000}
(-1,9250,3975),{677,1,9:15:00,39:45:00,9.250000,39.750000}
(-1,9250,3350),{678,1,9:15:00,33:30:00,9.250000,33.500000}
(-2,14417,5550),{679,1,14:25:00,55:30:00,14.416667,55.500000}
(-1,14417,6300),{680,1,14:25:00,63:00:00,14.416667,63.000000}
(-1,13500,6300),{681,1,13:30:00,63:00:00,13.500000,63.000000}
(-1,13500,6400),{682,1,13:30:00,64:00:00,13.500000,64.000000}
(-1,12000,6400),{683,1,12:00:00,64:00:00,12.000000,64.000000}
(-1,12000,6650),{684,1,12:00:00,66:30:00,12.000000,66.500000}
(-1,11333,6650),{685,1,11:20:00,66:30:00,11.333333,66.500000}
(-1,11333,7350),{686,1,11:20:00,73:30:00,11.333333,73.500000}
(-1,9167,7350),{687,1,9:10:00,73:30:00,9.166667,73.500000}
(-1,7967,7350),{688,1,7:58:00,73:30:00,7.966667,73.500000}
(-1,7967,6000),{689,1,7:58:00,60:00:00,7.966667,60.000000}
(-1,8417,6000),{690,1,8:25:00,60:00:00,8.416667,60.000000}
(-1,8417,4700),{691,1,8:25:00,47:00:00,8.416667,47.000000}
(-1,9167,4700),{692,1,9:10:00,47:00:00,9.166667,47.000000}
(-1,9167,4200),{693,1,9:10:00,42:00:00,9.166667,42.000000}
(-1,9583,4200),{694,1,9:35:00,42:00:00,9.583333,42.000000}
(-2,14000,6600),{695,1,14:00:00,66:00:00,14.000000,66.000000}
(-1,15667,6600),{696,1,15:40:00,66:00:00,15.666667,66.000000}
(-1,15667,7000),{697,1,15:40:00,70:00:00,15.666667,70.000000}
(-1,16533,7000),{698,1,16:32:00,70:00:00,16.533333,70.000000}
(-1,16533,7500),{699,1,16:32:00,75:00:00,16.533333,75.000000}
(-1,17500,7500),{700,1,17:30:00,75:00:00,17.500000,75.000000}
(-1,17500,8000),{701,1,17:30:00,80:00:00,17.500000,80.000000}
(-1,18000,8000),{702,1,18:00:00,80:00:00,18.000000,80.000000}
(-1,18000,8600),{703,1,18:00:00,86:00:00,18.000000,86.000000}
(-1,21000,8600),{704,1,21:00:00,86:00:00,21.000000,86.000000}
(-1,21000,8617),{705,1,21:00:00,86:10:00,21.000000,86.166667}
(-1,23000,8617),{706,1,23:00:00,86:10:00,23.000000,86.166667}
(-1,22998,8800),{707,1,22:59:54,88:00:00,22.998333,88.000000}
(-1,7998,8800),{708,1,7:59:54,88:00:00,7.998333,88.000000}
(-1,8000,8650),{709,1,8:00:00,86:30:00,8.000000,86.500000}
(-1,14500,8650),{710,1,14:30:00,86:30:00,14.500000,86.500000}
(-1,14500,8000),{711,1,14:30:00,80:00:00,14.500000,80.000000}
(-1,13583,8000),{712,1,13:35:00,80:00:00,13.583333,80.000000}
(-1,13583,7700),{713,1,13:35:00,77:00:00,13.583333,77.000000}
(-1,13000,7700),{714,1,13:00:00,77:00:00,13.000000,77.000000}
(-1,13000,7000),{715,1,13:00:00,70:00:00,13.000000,70.000000}
(-1,14000,7000),{716,1,14:00:00,70:00:00,14.000000,70.000000}
(-1,14000,6600),{717,1,14:00:00,66:00:00,14.000000,66.000000}
(-2,10750,-600),{718,-1,10:45:00,6:00:00,10.750000,-6.000000}
(-1,10750,700),{719,1,10:45:00,7:00:00,10.750000,7.000000}
(-1,9583,700),{720,1,9:35:00,7:00:00,9.583333,7.000000}
(-2,20000,5950),{721,1,20:00:00,59:30:00,20.000000,59.500000}
(-1,20000,6150),{722,1,20:00:00,61:30:00,20.000000,61.500000}
(-1,20417,6150),{723,1,20:25:00,61:30:00,20.416667,61.500000}
(-1,20417,6700),{724,1,20:25:00,67:00:00,20.416667,67.000000}
(-1,20667,6700),{725,1,20:40:00,67:00:00,20.666667,67.000000}
(-1,20667,7500),{726,1,20:40:00,75:00:00,20.666667,75.000000}
(-1,20167,7500),{727,1,20:10:00,75:00:00,20.166667,75.000000}
(-1,20167,8000),{728,1,20:10:00,80:00:00,20.166667,80.000000}
(-1,21000,8000),{729,1,21:00:00,80:00:00,21.000000,80.000000}
(-1,21000,8600),{730,1,21:00:00,86:00:00,21.000000,86.000000}
(-2,13000,7700),{731,1,13:00:00,77:00:00,13.000000,77.000000}
(-1,11500,7700),{732,1,11:30:00,77:00:00,11.500000,77.000000}
(-1,11500,8000),{733,1,11:30:00,80:00:00,11.500000,80.000000}
(-1,10667,8000),{734,1,10:40:00,80:00:00,10.666667,80.000000}
(-1,10667,8200),{735,1,10:40:00,82:00:00,10.666667,82.000000}
(-1,9167,8200),{736,1,9:10:00,82:00:00,9.166667,82.000000}
(-1,9167,7350),{737,1,9:10:00,73:30:00,9.166667,73.500000}
(-2,22867,5625),{738,1,22:52:00,56:15:00,22.866667,56.250000}
(-1,22867,5908),{739,1,22:52:00,59:05:00,22.866667,59.083333}
(-1,23167,5908),{740,1,23:10:00,59:05:00,23.166667,59.083333}
(-1,23167,6300),{741,1,23:10:00,63:00:00,23.166667,63.000000}
(-1,23583,6300),{742,1,23:35:00,63:00:00,23.583333,63.000000}
(-1,23583,6600),{743,1,23:35:00,66:00:00,23.583333,66.000000}
(-1,333,6600),{744,1,0:20:00,66:00:00,0.333333,66.000000}
(-1,333,7700),{745,1,0:20:00,77:00:00,0.333333,77.000000}
(-1,3417,7700),{746,1,3:25:00,77:00:00,3.416667,77.000000}
(-1,3508,7700),{747,1,3:30:30,77:00:00,3.508333,77.000000}
(-1,3508,8000),{748,1,3:30:30,80:00:00,3.508333,80.000000}
(-1,5000,8000),{749,1,5:00:00,80:00:00,5.000000,80.000000}
(-1,5000,8500),{750,1,5:00:00,85:00:00,5.000000,85.000000}
(-1,8000,8500),{751,1,8:00:00,85:00:00,8.000000,85.000000}
(-1,8000,8650),{752,1,8:00:00,86:30:00,8.000000,86.500000}
(-2,8083,700),{753,1,8:05:00,7:00:00,8.083333,7.000000}
(-1,7925,700),{754,1,7:55:30,7:00:00,7.925000,7.000000}
(-1,7925,1000),{755,1,7:55:30,10:00:00,7.925000,10.000000}
(-1,7808,1000),{756,1,7:48:30,10:00:00,7.808333,10.000000}
(-1,7808,1350),{757,1,7:48:30,13:30:00,7.808333,13.500000}
(-1,7500,1350),{758,1,7:30:00,13:30:00,7.500000,13.500000}
(-1,7500,1250),{759,1,7:30:00,12:30:00,7.500000,12.500000}
(-1,7000,1250),{760,1,7:00:00,12:30:00,7.000000,12.500000}
(-1,7000,1000),{761,1,7:00:00,10:00:00,7.000000,10.000000}
(-2,9250,700),{762,1,9:15:00,7:00:00,9.250000,7.000000}
(-1,9250,3350),{763,1,9:15:00,33:30:00,9.250000,33.500000}
(-1,8000,3350),{764,1,8:00:00,33:30:00,8.000000,33.500000}
(-1,8000,2800),{765,1,8:00:00,28:00:00,8.000000,28.000000}
(-1,7883,2800),{766,1,7:53:00,28:00:00,7.883333,28.000000}
(-1,7883,2000),{767,1,7:53:00,20:00:00,7.883333,20.000000}
(-1,7808,2000),{768,1,7:48:30,20:00:00,7.808333,20.000000}
(-1,7808,1350),{769,1,7:48:30,13:30:00,7.808333,13.500000}
(-2,22867,5250),{770,1,22:52:00,52:30:00,22.866667,52.500000}
(-1,23333,5250),{771,1,23:20:00,52:30:00,23.333333,52.500000}
(-1,23333,5000),{772,1,23:20:00,50:00:00,23.333333,50.000000}
(-1,23583,5000),{773,1,23:35:00,50:00:00,23.583333,50.000000}
(-1,23583,4800),{774,1,23:35:00,48:00:00,23.583333,48.000000}
(-1,167,4800),{775,1,0:10:00,48:00:00,0.166667,48.000000}
(-1,167,4600),{776,1,0:10:00,46:00:00,0.166667,46.000000}
(-1,867,4600),{777,1,0:52:00,46:00:00,0.866667,46.000000}
(-1,867,4800),{778,1,0:52:00,48:00:00,0.866667,48.000000}
(-1,1117,4800),{779,1,1:07:00,48:00:00,1.116667,48.000000}
(-1,1117,5000),{780,1,1:07:00,50:00:00,1.116667,50.000000}
(-1,1367,5000),{781,1,1:22:00,50:00:00,1.366667,50.000000}
(-1,1367,5400),{782,1,1:22:00,54:00:00,1.366667,54.000000}
(-1,1700,5400),{783,1,1:42:00,54:00:00,1.700000,54.000000}
(-1,1700,5750),{784,1,1:42:00,57:30:00,1.700000,57.500000}
(-1,1908,5750),{785,1,1:54:30,57:30:00,1.908333,57.500000}
(-1,1908,5850),{786,1,1:54:30,58:30:00,1.908333,58.500000}
(-1,2433,5850),{787,1,2:26:00,58:30:00,2.433333,58.500000}
(-1,2433,5700),{788,1,2:26:00,57:00:00,2.433333,57.000000}
(-1,3100,5700),{789,1,3:06:00,57:00:00,3.100000,57.000000}
(-2,8000,3350),{790,1,8:00:00,33:30:00,8.000000,33.500000}
(-1,7750,3350),{791,1,7:45:00,33:30:00,7.750000,33.500000}
(-1,7750,3550),{792,1,7:45:00,35:30:00,7.750000,35.500000}
(-1,7367,3550),{793,1,7:22:00,35:30:00,7.366667,35.500000}
(-1,6533,3550),{794,1,6:32:00,35:30:00,6.533333,35.500000}
(-1,6533,2800),{795,1,6:32:00,28:00:00,6.533333,28.000000}
(-1,5883,2800),{796,1,5:53:00,28:00:00,5.883333,28.000000}
(-1,5883,2150),{797,1,5:53:00,21:30:00,5.883333,21.500000}
(-1,5883,2150),{798,1,5:53:00,21:30:00,5.883333,21.500000}
(-1,6217,2150),{799,1,6:13:00,21:30:00,6.216667,21.500000}
(-1,6217,1750),{800,1,6:13:00,17:30:00,6.216667,17.500000}
(-1,6308,1750),{801,1,6:18:30,17:30:00,6.308333,17.500000}
(-1,6308,1200),{802,1,6:18:30,12:00:00,6.308333,12.000000}
(-2,7967,6000),{803,1,7:58:00,60:00:00,7.966667,60.000000}
(-1,7000,6000),{804,1,7:00:00,60:00:00,7.000000,60.000000}
(-1,7000,6200),{805,1,7:00:00,62:00:00,7.000000,62.000000}
(-1,6100,6200),{806,1,6:06:00,62:00:00,6.100000,62.000000}
(-1,6100,5600),{807,1,6:06:00,56:00:00,6.100000,56.000000}
(-1,6100,5400),{808,1,6:06:00,54:00:00,6.100000,54.000000}
(-1,6500,5400),{809,1,6:30:00,54:00:00,6.500000,54.000000}
(-1,6500,5000),{810,1,6:30:00,50:00:00,6.500000,50.000000}
(-1,6800,5000),{811,1,6:48:00,50:00:00,6.800000,50.000000}
(-1,6800,4450),{812,1,6:48:00,44:30:00,6.800000,44.500000}
(-1,7367,4450),{813,1,7:22:00,44:30:00,7.366667,44.500000}
(-1,7367,3550),{814,1,7:22:00,35:30:00,7.366667,35.500000}
(-2,3283,992),{815,1,3:17:00,9:55:00,3.283333,9.916667}
(-1,3283,1900),{816,1,3:17:00,19:00:00,3.283333,19.000000}
(-1,3367,1900),{817,1,3:22:00,19:00:00,3.366667,19.000000}
(-1,3367,3067),{818,1,3:22:00,30:40:00,3.366667,30.666667}
(-1,2717,3067),{819,1,2:43:00,30:40:00,2.716667,30.666667}
(-1,2417,3067),{820,1,2:25:00,30:40:00,2.416667,30.666667}
(-1,2417,2725),{821,1,2:25:00,27:15:00,2.416667,27.250000}
(-1,1917,2725),{822,1,1:55:00,27:15:00,1.916667,27.250000}
(-1,1917,2500),{823,1,1:55:00,25:00:00,1.916667,25.000000}
(-1,1667,2500),{824,1,1:40:00,25:00:00,1.666667,25.000000}
(-2,3333,5250),{825,1,3:20:00,52:30:00,3.333333,52.500000}
(-1,4692,5250),{826,1,4:41:30,52:30:00,4.691667,52.500000}
(-1,5000,5250),{827,1,5:00:00,52:30:00,5.000000,52.500000}
(-1,5000,5600),{828,1,5:00:00,56:00:00,5.000000,56.000000}
(-1,6100,5600),{829,1,6:06:00,56:00:00,6.100000,56.000000}
(-2,3417,7700),{830,1,3:25:00,77:00:00,3.416667,77.000000}
(-1,3417,6800),{831,1,3:25:00,68:00:00,3.416667,68.000000}
(-1,3100,6800),{832,1,3:06:00,68:00:00,3.100000,68.000000}
(-1,3100,5700),{833,1,3:06:00,57:00:00,3.100000,57.000000}
(-1,3167,5700),{834,1,3:10:00,57:00:00,3.166667,57.000000}
(-1,3167,5500),{835,1,3:10:00,55:00:00,3.166667,55.000000}
(-1,3333,5500),{836,1,3:20:00,55:00:00,3.333333,55.000000}
(-1,3333,5250),{837,1,3:20:00,52:30:00,3.333333,52.500000}
(-2,1408,3300),{838,1,1:24:30,33:00:00,1.408333,33.000000}
(-1,1408,3500),{839,1,1:24:30,35:00:00,1.408333,35.000000}
(-1,2000,3500),{840,1,2:00:00,35:00:00,2.000000,35.000000}
(-1,2000,3675),{841,1,2:00:00,36:45:00,2.000000,36.750000}
(-1,2517,3675),{842,1,2:31:00,36:45:00,2.516667,36.750000}
(-1,2517,5050),{843,1,2:31:00,50:30:00,2.516667,50.500000}
(-1,2042,5050),{844,1,2:02:30,50:30:00,2.041667,50.500000}
(-1,2042,4700),{845,1,2:02:30,47:00:00,2.041667,47.000000}
(-1,1667,4700),{846,1,1:40:00,47:00:00,1.666667,47.000000}
(-1,1667,5000),{847,1,1:40:00,50:00:00,1.666667,50.000000}


(-1,1367,5000),{781,1,1:22:00,50:00:00,1.366667,50.000000}

//(-1,1117,5000),{848,1,1:07:00,50:00:00,1.116667,50.000000} {updated}

(-2,2717,3067),{849,1,2:43:00,30:40:00,2.716667,30.666667}
(-1,2717,3400),{850,1,2:43:00,34:00:00,2.716667,34.000000}
(-1,2567,3400),{851,1,2:34:00,34:00:00,2.566667,34.000000}
(-2,5883,2283),{852,1,5:53:00,22:50:00,5.883333,22.833333}
(-1,5700,2283),{853,1,5:42:00,22:50:00,5.700000,22.833333}
(-1,5700,1800),{854,1,5:42:00,18:00:00,5.700000,18.000000}
(-1,5767,1800),{855,1,5:46:00,18:00:00,5.766667,18.000000}
(-1,5767,1250),{856,1,5:46:00,12:30:00,5.766667,12.500000}
(-1,5600,1250),{857,1,5:36:00,12:30:00,5.600000,12.500000}
(-1,5600,1550),{858,1,5:36:00,15:30:00,5.600000,15.500000}
(-1,5333,1550),{859,1,5:20:00,15:30:00,5.333333,15.500000}
(-1,5333,1550),{860,1,5:20:00,15:30:00,5.333333,15.500000}
(-1,5333,1600),{861,1,5:20:00,16:00:00,5.333333,16.000000}
(-1,4967,1600),{862,1,4:58:00,16:00:00,4.966667,16.000000}
(-1,4967,1550),{863,1,4:58:00,15:30:00,4.966667,15.500000}
(-1,4617,1550),{864,1,4:37:00,15:30:00,4.616667,15.500000}
(-1,4617,0),{865,1,4:37:00,0:00:00,4.616667,0.000000}
(-2,5883,2150),{866,1,5:53:00,21:30:00,5.883333,21.500000}
(-1,5883,2850),{867,1,5:53:00,28:30:00,5.883333,28.500000}
(-1,4750,2850),{868,1,4:45:00,28:30:00,4.750000,28.500000}
(-1,4750,3000),{869,1,4:45:00,30:00:00,4.750000,30.000000}
(-1,4500,3000),{870,1,4:30:00,30:00:00,4.500000,30.000000}
(-1,4500,3067),{871,1,4:30:00,30:40:00,4.500000,30.666667}
(-1,3367,3067),{872,1,3:22:00,30:40:00,3.366667,30.666667}
(-2,4500,3067),{873,1,4:30:00,30:40:00,4.500000,30.666667}
(-1,4500,3600),{874,1,4:30:00,36:00:00,4.500000,36.000000}
(-1,4692,3600),{875,1,4:41:30,36:00:00,4.691667,36.000000}
(-1,4692,5250),{876,1,4:41:30,52:30:00,4.691667,52.500000}
(-2,2517,3675),{877,1,2:31:00,36:45:00,2.516667,36.750000}
(-1,2567,3675),{878,1,2:34:00,36:45:00,2.566667,36.750000}
(-1,2567,3400),{879,1,2:34:00,34:00:00,2.566667,34.000000}
(-1,2717,3400));{880,1,2:43:00,34:00:00,2.716667,34.000000}

greekalph : array[0..24] of pchar=
(('   '),
('Alpha'), {alpha}
('Beta'),
('Gamma'),
('Delta'),
('Epsilon'),
('Zeta'),
('Eta'),
('Theta'),
('Iota'),
('Kappa'),
('Lambda'),
('My '),
('Ny '),
('Xi '),
('Omikron'),
('Pi '),
('Rho'),
('Sigma'),
('Tau'),
('Ypsilon'),
('Phi'),
('Chi'),
('Psi'),
('Omega')); {Omega}

{convert short IC and NGC  abbreviations to long text}
function convert_Abbreviations(inp : string): string;



Implementation

Uses SysUtils {, ansistrings};
Const
{The descriptions use the abbreviations from the NGC and Burnham's.  They are given below:}
abbrevsize=204;
Abbreviations : array[0..abbrevsize,0..1] of {pansichar} ansistring=(
('NGC','NGC'), {prevent translation NGC}

('ASTER',' Asterism'),
('BRTNB',' Bright nebula'),
('CL+NB',' Cluster with nebulosity'),
('DRKNB',' Dark nebula'),
('GALCL',' Galaxy cluster'),
('GALXY',' Galaxy'),
('GLOCL',' Globular cluster'),
('GX+DN',' Diffuse nebula in a Galaxy'),
('GX+GC',' Globular cluster in a Galaxy'),
('G+C+N',' Cluster with nebulosity in a Galaxy'),
('LMCCN',' Cluster with nebulosity in the LMC'),
('LMCDN',' Diffuse nebula in the LMC'),
('LMCGC',' Globular cluster in the LMC'),
('LMCOC',' Open cluster in the LMC'),
('NONEX',' Nonexistent in RNGC'),
('OPNCL',' Open cluster'),
('PLNNB',' Planetary nebula'),
('SMCCN',' Cluster with nebulosity in the SMC'),
('SMCDN',' Diffuse nebula in the SMC'),
('SMCGC',' Globular cluster in the SMC'),
('SMCOC',' Open cluster in the SMC'),
('SNREM',' Supernova remnant'),
('QUASR',' Quasar'),
('UVSOB',' Unverified southern object'),

('GX',' Galaxy'),
('OC',' Open clustor'),
('GC',' Globular cluster'),
('PN',' Planetary nebula'),
('CL+NB',' Cluster with nebulosity'),
('GALCL',' Galaxy cluster'),
('DN',' Dark nebula'),
('BN',' Bright nebula'),


('***f',' triple star following '),
('***',' triple star '),
('**p',' double star preceeding '),
('**f',' double star following '),
('**S',' double star small '),
('**',' double star '),
('*M',' star in middle '),
('*',' star(s) '),

('_att/',' attached'),
('_p/',' preceeding'),
('_f/',' following'),
('_F/',' faint'),
('_sp/',' south preceeding'),
('_sf/',' south following'),
('_np/',' north preceeding'),
('_nf/',' north following'),
('_inv/',' involved'),
('_nr/',' near'),

('_att_',' attached'),
('_p_',' preceeding'),
('_f_',' following'),
('_F_',' faint'),
('_sp_',' south preceeding'),
('_sf_',' south following'),
('_np_',' north preceeding'),
('_nf_',' north following'),
('_inv_',' involved'),
('_nr_',' near'),


('_att;',' attached'),
('_p;',' preceeding'),
('_f;',' following'),
('_F;',' faint'),
('_sp;',' south preceeding'),
('_sf;',' south following'),
('_np;',' north preceeding'),
('_nf;',' north following'),
('_inv;',' involved'),
('_nr;',' near'),


('/Irr',', irregular'),
('/irR',', irregular'),
('/iR',', irregular round'),
('!!!Cl',' magnificent cluster '),
('!!Cl' ,' very remarkable cluster '),
('!!B' ,' very remarkable bright '),
('!Cl'  ,' remarkable cluster '),
('!B'  ,' remarkable bright '),
('!!!'  ,' magnificent object '),
('!!'   ,' very remarkable object '),
('!'    ,' remarkable object '),
('/B',', bright'),
('/pB',', pretty bright'), {before F,B,L or S}
('/vvB',', very very bright'),
('/vB',', very bright'),
('/eB',', extremely bright'),
('/gbM',', gradually brighter middle'),
('/gmbM',', gradually much brighter middle'),
('/glbM',', gradually little brighter middle'),
('/gvlbM',', gradually very little brighter middle'),
('/gvmbM',', gradually very much brighter middle'),
('/gpmbM',', gradually pretty much brighter middle'),
('/vsmbM',', very suddenly much brighter middle'),
('/lbM',', little brighter middle'),
('/vlbM',', very little brighter middle'),
('/pgbM',', pretty gradually brighter middle'),
('/psbM',', pretty suddenly brighter middle'),
('/psmbMN',', pretty suddenly much brighter middle nucleus'),
('/psmbM',', pretty suddenly much brighter middle'),
('/vsvmbM',', very suddenly very much brighter middle'),
('/vglbM',', very gradually little brighter middle'),
('/vgmbM',', very gradually much brighter middle'),
('/vgbM',', very gradually brighter middle'),
('/vsbM',', very suddenly brighter middle'),
('/vmbM',', very much brighter middle'),
('/pCM' ,', pretty compressed middle'),
('/Cl' ,', cluster'),
('/C'  ,', compressed'),
('/D'  ,', double'),
('/pmC'  ,', pretty much compressed'),
('/pC'  ,', pretty compressed'),
('/sC' ,', suddenly compressed'),
('/vmC' ,', very much compressed'),
('/vCM',', very compressed middle'),
('/vC' ,', very compressed'),
('/eCM',', extremely compressed middle'),
('/eC',', extremely compressed'),
('/eB',', extremely bright'),
('/eeB',', most extremely bright'),
('/lC',', little compressed'),
('/vlC',', very little compressed'),
('/er',', easily resolved'), {note  first er then e for replacement routine}
('/F' ,', faint'),
('/P' ,', poor'),
('/pF',', pretty faint'), {before F,B,L or S}
('/vF',', very faint'),
('/eeF',' most extremely faint'),
('/eF',', extremely faint'),
('/cF',', considerably faint'),
('/E',', extended'),
('/eiF',', extremely irregular figure'),
('/iF' ,', irregular figure'),
('/irr',', irregular'),
('/!irr',', remarkable irregular'),
('/L',', large'),
('/pL',', pretty large'), {before F,B,L or S}
('/vvL',', very very large'),
('/vL',', very large'),
('/eL',', extremely large'),
('/cL',', considerably large'),
('/eeL',', most extremely large'),
('/lE',', little elongated'),
('/mE',', much elongated'),
('/vlE',', very little elongated'),
('/vmE',', very much elongated'),
('/pmE',', pretty much elongated'),
('/cE',', considerably elongated'),
('/cRi',', considerably rich'),
('/Ri',', rich'),
('/pRi',', pretty rich'),
('/vRi',', very rich'),
('/eRi',', extremely rich'),
('/R',', round'),
('/rrr' ,', well resolved'),  {note  first rrr then rr for replacement routine}
('/rr'  ,', partially resolved'),
('/r'   ,', not well resolved, mottled'),
('/st_vS'  ,', stars very small '), { or stellar}
('/st'  ,', stars '), { or stellar}
('/S', ', small'),
('/pS',', pretty small'), {before F,B,L or S}
('/vS',', very small'),
('/eS',', extremely small'),
('/cS',', considerably small'),
('/eeS',', most extremely small'),
('/sp',', south preceding '),
('/sf',', south following '),
('/np',', north preceding '),
('/nf',', north following '),
('/sbMN',', suddenly brighter middle nucleus'),
('/sbM',', suddenly brighter middle'),
('/sb',', suddenly brighter'),
('/bM',', brighter middle'),
('/smbM',', suddenly much brighter middle'),
('/smb',', suddenly much brighter'),
('/mbM',', much brighter middle'),
('16m',' 16th magnitude'),
('15m',' 15th magnitude'),
('14m',' 14th magnitude'),
('13m',' 13th magnitude'),
('12m',' 12th magnitude'),
('11m',' 11th magnitude'),
('10m',' 10th magnitude'),
('9m',' 9th magnitude'),
('8m',' 8th magnitude'),
('7m',' 7th magnitude'),
('6m',' 6th magnitude'),
('5m',' 5th magnitude'),
('4m',' 4th magnitude'),
('3m',' 3th magnitude'),
('2m',' 2th magnitude'),
('1m',' 1th magnitude'),
('...10','th to 10th magnitude'),
('...11','th to 11th magnitude'),
('...12','th to 12th magnitude'),
('...13','th to 13th magnitude'),
('...14','th to 14th magnitude'),
('...15','th to 15th magnitude'),
('...16','th to 16th magnitude'),
('...17','th to 17th magnitude'),
('...18','th to 18th magnitude'),
('...19','th to 19th magnitude'),
('...','th magnitude and fainter'),

('/',','),
('_',' ')      );     {make spaces instead}

{
Visual description of the object.  Most of these are from the NGC, some
are from prominent amateurs.  Back issues of Deep Sky Magazine, Astronomy
magazine, Sky and Telescope magazine and Burnham's Celestial Handbook are
used as a source of some of these descriptions.  The descriptions use the
abbreviations from the NGC and Burnham's.  They are given below:

!    remarkable object                 !!   very remarkable object
am   among                             n    north
att  attached                          N    nucleus
bet  between                           neb  nebula, nebulosity
B    bright                            P w  paired with
b    brighter                          p    pretty (before F,B,L or S)
C    compressed                        p    preceding
c    considerably                      P    poor
Cl   cluster                           R    round
D    double                            Ri   rich
def  defined                           r    not well resolved, mottled
deg  degrees                           rr   partially resolved
diam diameter                          rrr  well resolved
dif  diffuse                           S    small
E    elongated                         s    suddenly
e    extremely                         s    south
er   easily resolved                   sc   scattered
F    faint                             susp suspected
f    following                         st   star or stellar
g    gradually                         v    very
iF   irregular figure                  var  variable
inv  involved                          nf   north following
irr  irregular                         np   north preceding
L    large                             sf   south following
l    little                            sp   south preceding
mag  magnitude                         11m  11th magnitude
M    middle                            8... 8th magnitude and fainter
m    much                              9...13  9th to 13th magnitude

If you have never dealt with the NGC abbreviations before, perhaps
a few examples will help.

NGC#     Description            Decoded descriptions

214   pF, pS, lE, gvlbM   pretty faint, pretty small, little elongated
                          gradually very little brighter in the middle

708   vF, vS, R           very faint, very small, round

891   B, vL, vmE          bright, very large, very much elongated

7009  !, vB, S            remarkable object, very bright, small

7089  !! B, vL, mbM       extremely remarkable object, bright, very
      rrr, stars mags     large, much brighter middle, resolved,
      13.....             stars 13th magnitude and dimmer

2099  !  B, vRi, mC       remarkable object, bright, very rich,
                          much compressed

6643  pB,pL,E50,2 st p    pretty bright, pretty large,
                          elongated in position angle 50 degrees,
                          two stars preceding
}

{convert short IC and NGC  abbreviations to long text}
function convert_Abbreviations(inp : string): string;
var  pos,i : integer;
     output: string;
     abbreviation_mode : boolean;
begin
  abbreviation_mode :=true;{convert abbreviations until ; found}
  output:='';
  if length(inp)>0 then
  begin
    pos:=1; {position}
    repeat
    begin
      if inp[pos]=';' then {stop translating abbreviations, notes reached}
             abbreviation_mode:=false;

      if abbreviation_mode then i:=0
         else i:=abbrevsize; {after ; translate "_" to spaces}

      repeat
        if Abbreviations[i,0]=copy(inp,pos,length(Abbreviations[i,0])) then
           begin {equal}
             output:=output+abbreviations[i,1];
             inc(pos,length(Abbreviations[i,0]));{move pointer pos}
             i:=999;
           end;
       inc(i);
      until i>abbrevsize;

      if i<999 then {not equal}
      begin
        output:=output+inp[pos];{add untranslated char}
        inc(pos,1);{move pointer pos}
      end;

    end;{repeat}
    until pos>length(inp);
  end;
  convert_Abbreviations:=output;
end;


begin
end.
