unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TForm2 }

  TForm2 = class(TForm)
    btnBrowse: TBitBtn;
    btnAdd: TBitBtn;
    cbType: TComboBox;
    edtTitle: TEdit;
    edtDirectory: TEdit;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    procedure btnAddClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation
 uses main;
{$R *.lfm}

{ TForm2 }

procedure TForm2.btnAddClick(Sender: TObject);
begin
     if Length(edtTitle.Text) < 2 then
     begin
       ShowMessage('You must supply Title!');
       exit;
     end;
     if Length(edtDirectory.Text) < 2 then
     begin
       ShowMessage('You must select Directory!');
       exit;
     end;
     if Length(cbType.Text) < 2 then
     begin
       ShowMessage('You must select Type!');
       exit;
     end;
     form1.SQLTransaction1.Active:= false;
     form1.SQLTransaction1.Active:= true;
     form1.squ.Close;
     form1.squ.SQL.Clear;
     form1.squ.SQL.Add('INSERT INTO docfiles (name, directory, type) VALUES("' + edtTitle.Text  + '","' + edtDirectory.Text + '","' + cbType.Text + '")');
     form1.squ.ExecSQL;
     form1.SQLTransaction1.Commit;
     form1.lvDocuments.Clear;
     form1.OnShow(sender);
     ShowMessage('File successfully added!');
end;

procedure TForm2.btnBrowseClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edtDirectory.Text:= OpenDialog1.FileName;
  end;
end;

end.

