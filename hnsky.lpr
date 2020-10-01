program hnsky;

uses
  Interfaces,  {lazurus}
  Forms,
  hns_main in 'hns_main.pas' {mainwindow},
  hns_Uset in 'hns_Uset.pas' {Settings},
  hns_Utim in 'hns_Utim.pas' {Settime},
  hns_Ugot in 'hns_Ugot.pas' {move_to},
  hns_Ucen in 'hns_Ucen.pas' {center_on},
  hns_Uobj in 'hns_Uobj.pas' {objectmenu},
  hns_uedi in 'hns_Uedi.pas' {edit2},
  hns_Udrk in 'hns_Udrk.pas' {darkform},
  hns_Usol in 'hns_Usol.pas' {planetform},
  hns_Upol in 'hns_Upol.pas' {Polarscope},
  hns_Uani in 'hns_Uani.pas' {animation},
  hns_Indi in 'hns_Indi.pas' {animation},
  hns_fast in 'hns_fast.pas',
  hns_Usno in 'hns_usno.pas',
  hns_U290 in 'hns_U290.pas',
  hns_unumint in 'hns_Unumint.pas',
  hns_Utxt in 'hns_utxt.pas',
  hns_Userver in 'hns_Userver.pas';

begin
  Application.Scaled:=True;
  Application.Initialize;
  Application.Title := 'HNSKY';
  Application.CreateForm(Tmainwindow, mainwindow);
  Application.CreateForm(TSettime, Settime);
  Application.CreateForm(Tmove_to, move_to);
  Application.CreateForm(Tcenter_on, center_on);
  Application.CreateForm(Tobjectmenu, objectmenu);
  Application.CreateForm(Tform_animation, form_animation);
  Application.CreateForm(Tindi, indi);
  Application.Run;
end.
