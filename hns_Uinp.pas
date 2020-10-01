unit hns_Uinp;
{$MODE Delphi}
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

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Menus, ExtCtrls,strutils;

type

  { Tedit_supplement_entry }

  Tedit_supplement_entry = class(TForm)
    help_suppl_edit1: TLabel;
    name_str1: TLabel;
    type_str1: TLabel;
    bright_str1: TLabel;
    length_str1: TLabel;
    width_str1: TLabel;
    pa_str1: TLabel;
    dec_str1: TLabel;
    ra_str1: TLabel;
    edit_name1: TEdit;
    edit_type1: Tmemo;
    edit_brightness1: TEdit;
    edit_length1: TEdit;
    edit_width1: TEdit;
    edit_pa1: TEdit;
    ok_button1: TButton;
    edit_magn1: TEdit;
    magn_str1: TLabel;
    save_button1: TButton;
    cancel_button1: TButton;
    remove_button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure help_suppl_edit1Click(Sender: TObject);
    procedure ok_button1Click(Sender: TObject);
    procedure cancel_button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  edit_supplement_entry: Tedit_supplement_entry;

  new_line1 : string;{contains all names}
  save_butt,ok_butt: boolean;
const
    save_suppl_string: string='Save suppl';


implementation
{$R *.lfm}
uses hns_main, hns_Uast, hns_Unon;


var
  positie6  :integer;{sixt komma in new_line1}

  function remove_komma(inp:string):string;
  begin
    result:=StringReplace(inp, ',', '/',[rfReplaceAll]);
    result:=StringReplace(result, #10, '|',[rfReplaceAll]);
    result:=StringReplace(result, #13, '|',[rfReplaceAll]);
  end;

procedure Tedit_supplement_entry.ok_button1Click(Sender: TObject);
var
  error1: integer;
  value1: double;
  dummy1,dummy2,dummy3,dummy4:string;
begin
  save_butt:=(sender=save_button1);

  val_local(edit_magn1.Text,value1,error1);
  if error1=0 then str(value1*10:0:0,dummy1)
  else             dummy1:='';{keep empthy}

  val_local(edit_brightness1.Text,value1,error1);
  if error1=0 then begin if value1>0 then value1:=value1*10; str(value1:0:0,dummy2); end
  else             dummy2:=remove_komma(edit_brightness1.Text);

  val_local(edit_length1.Text,value1,error1);
  if error1=0 then str(value1*10:0:number_of_decimals_required(value1),dummy3)
  else             dummy3:='';{keep empthy}

  val_local(edit_width1.Text,value1,error1);
  if error1=0 then str(value1*10:0:number_of_decimals_required(value1),dummy4)
  else             dummy4:='';{keep empthy}


  new_line1:=copy(new_line1,1,positie6)+ {copy old position}
             dummy1+','+
             remove_komma(edit_name1.Text)+','+
             remove_komma(edit_type1.Text)+','+
             dummy2+','+
             dummy3+','+
             dummy4+','+
             remove_komma(edit_pa1.Text);{new info}


  if sender=remove_button1 then new_line1:=';$$$ '+ new_line1;{remove entry by making comment}
  ok_butt:=true; {something changed}
  edit_supplement_entry.close;   {normal this form is not loaded}
  mainwindow.setfocus;
end;

procedure Tedit_supplement_entry.cancel_button1Click(Sender: TObject);
begin
  edit_supplement_entry.close;   {normal this form is not loaded}
  mainwindow.setfocus;
end;

procedure Tedit_supplement_entry.FormActivate(Sender: TObject);
begin
end;

procedure Tedit_supplement_entry.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#27 {esc} then {leave form without action, keypreview form should be on}
    edit_supplement_entry.cancel_button1Click(nil)
end;

procedure Tedit_supplement_entry.FormShow(Sender: TObject);
var
  j,positie7,positie8 :  integer;
begin
   if language_mode<>0 then  load_suppl_edit;
   save_butt:=false;{no button pressed indication}
   ok_butt:=false;

   edit_supplement_entry.caption:='✎   '+found_name;

   name_str1.caption:=name_string;
   magn_str1.caption:=magn_string;
   type_str1.caption:=type_string;
   bright_str1.caption:=Brightn_string;
   save_button1.Caption:=save_suppl_string+' '+inttostr(round((found_mode+1)/2));

   ra_str1.caption:=ra_string+#9+prepare_ra(found_ra2);
   dec_str1.caption:=dec_string+#9+prepare_dec(found_dec2);

   positie6:=1;
   for j:=1 to 6 do {find sixt komma}
   begin
      positie6:=posex( ',',new_line1,positie6+1);{where is next komma?}
   end;
   positie7:=posex( ',',new_line1,positie6+1);{where is next komma?}
   positie8:=posex( ',',new_line1,positie7+1);{where is next komma?}
   edit_name1.Text:=copy(new_line1,positie7+1, positie8-positie7-1);{get names}

   edit_type1.Text:=found_type2;
   if found_mag2<999 then edit_magn1.Text:=floattostrF_local(found_mag2/10,0,1) else edit_magn1.Text:='';

   if found_brightn>0 then edit_brightness1.Text:=floattostrF_local(found_brightn/10,0,1)
   else
   if found_brightn=0 then edit_brightness1.Text:=found_descrip2 {star, could contain text}
   else
   edit_brightness1.Text:=floattostrF_local(found_brightn,0,0);{line mode}

   if found_length2<>0 then edit_length1.Text:=floattostrF_local(found_length2/10,0,number_of_decimals_required(found_length2/10)) else edit_length1.Text:='';
   if found_width2<>0 then edit_width1.Text:=floattostrF_local(found_width2/10,0,number_of_decimals_required(found_width2/10)) else edit_width1.Text:='';
   if found_orientation2<999 then  edit_pa1.Text:=floattostrF_local(found_orientation2,0,0) else edit_pa1.Text:='';
end;

procedure Tedit_supplement_entry.help_suppl_edit1Click(Sender: TObject);
begin
  open_file_with_parameters(help_path,'#suppl_edit');
end;

end.
