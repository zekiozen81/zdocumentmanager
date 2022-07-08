unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons;

type

  { TForm3 }

  TForm3 = class(TForm)
    btnAdd: TBitBtn;
    btnBrowse: TBitBtn;
    cbType: TComboBox;
    DataSource1: TDataSource;
    edtDirectory: TEdit;
    edtTitle: TEdit;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblid: TLabel;
    OpenDialog1: TOpenDialog;
    SQLTransaction1: TSQLTransaction;
    squ: TSQLQuery;
    procedure btnAddClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation
uses main;
{$R *.lfm}

{ TForm3 }

procedure TForm3.btnBrowseClick(Sender: TObject);
begin
    if OpenDialog1.Execute then
  begin
    edtDirectory.Text:= OpenDialog1.FileName;
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin

end;

procedure TForm3.btnAddClick(Sender: TObject);
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
    // sssage('UPDATE docfiles SET name="' + edtTitle.Text  + '" AND directory="' + edtDirectory.Text + '" AND type="' + cbType.Text + '" WHERE ID=' + lblid.Caption);
     squ.Close;
     squ.SQL.Clear;
     squ.SQL.Add('UPDATE docfiles SET name="' + edtTitle.Text  + '" AND directory="' + edtDirectory.Text + '" AND type="' + cbType.Text + '" WHERE ID=' + lblid.Caption);
     squ.ExecSQL;
     SQLTransaction1.Commit;
     form1.lvDocuments.Clear;
     form1.OnShow(sender);
     ShowMessage('File successfully updated!');
end;

end.

