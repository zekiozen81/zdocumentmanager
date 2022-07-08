unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, SQLite3Conn, odbcconn, Forms, Controls,
  Graphics, Dialogs, Buttons, ComCtrls, StdCtrls, LCLIntf, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnPdf: TBitBtn;
    btnDelete: TBitBtn;
    btnSearch: TBitBtn;
    btnAddNewDocument: TBitBtn;
    btnOther: TBitBtn;
    btnWord: TBitBtn;
    btnExcel: TBitBtn;
    btnPowerpoint: TBitBtn;
    btnAccess: TBitBtn;
    btnPictures: TBitBtn;
    btnVideos: TBitBtn;
    btnOpen: TBitBtn;
    cbSearch: TComboBox;
    DataSource1: TDataSource;
    edtSearch: TEdit;
    Image1: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    lvDocuments: TListView;
    sqlite: TSQLite3Connection;
    squ: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure btnAccessClick(Sender: TObject);
    procedure btnAddNewDocumentClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnOtherClick(Sender: TObject);
    procedure btnPdfClick(Sender: TObject);
    procedure btnPicturesClick(Sender: TObject);
    procedure btnPowerpointClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnVideosClick(Sender: TObject);
    procedure btnWordClick(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
uses unit1, Unit2;
{$R *.lfm}

{ TForm1 }

procedure TForm1.btnAddNewDocumentClick(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.btnDeleteClick(Sender: TObject);
var
    r : integer;
  li : TListItem;
begin
  if lvDocuments.SelCount > 0 then
     begin
  squ.Close;
  squ.SQL.Clear;
  squ.SQL.Add('DELETE FROM docfiles WHERE ID=' + lvDocuments.Selected.Caption);
  squ.ExecSQL;
  sqltransaction1.Commit;
     end;


  lvDocuments.Clear;
  squ.SQL.Clear;
  squ.SQL.Add('Select * from docfiles Order by id');
  squ.Open;

  for r := 1 to squ.RecordCount do
  begin
     squ.RecNo:= r;
     li := lvDocuments.Items.Add;
     li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
     li.SubItems.Add(squ.FieldByName('name').AsString);
     li.SubItems.Add(squ.FieldByName('directory').AsString);
     li.SubItems.Add(squ.FieldByName('type').AsString);
  end;
end;

procedure TForm1.btnEditClick(Sender: TObject);
begin
     if lvDocuments.SelCount > 0 then
        begin
             form3.lblid.Caption := LvDocuments.Selected.Caption;
             form3.edtTitle.Text := LvDocuments.Selected.SubItems[0];
             form3.edtDirectory.Text := LvDocuments.Selected.SubItems[1];
             form3.cbType.Text := LvDocuments.Selected.SubItems[2];
             form3.Show;
        end;
end;

procedure TForm1.btnExcelClick(Sender: TObject);
var
 sql : string;
 r : integer;
 li : TListItem;
begin
     sql := 'SELECT * FROM docfiles WHERE name LIKE "%' + edtSearch.Text + '%" AND type="Microsoft Excel" ORDER BY name';

  squ.Close;
  squ.SQL.Clear;
  squ.SQL.Add(sql);
  squ.Open;
 lvDocuments.Clear;
for r := 1 to squ.RecordCount do
begin
   squ.RecNo:= r;
   li := lvDocuments.Items.Add;
   li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
   li.SubItems.Add(squ.FieldByName('name').AsString);
   li.SubItems.Add(squ.FieldByName('directory').AsString);
   li.SubItems.Add(squ.FieldByName('type').AsString);
end;
end;

procedure TForm1.btnOpenClick(Sender: TObject);
begin
  OpenDocument(lvDocuments.Selected.SubItems[1]);
end;

procedure TForm1.btnOtherClick(Sender: TObject);
var
 sql : string;
 r : integer;
 li : TListItem;
begin
     sql := 'SELECT * FROM docfiles WHERE name LIKE "%' + edtSearch.Text + '%" AND type="Other" ORDER BY name';

  squ.Close;
  squ.SQL.Clear;
  squ.SQL.Add(sql);
  squ.Open;
 lvDocuments.Clear;
for r := 1 to squ.RecordCount do
begin
   squ.RecNo:= r;
   li := lvDocuments.Items.Add;
   li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
   li.SubItems.Add(squ.FieldByName('name').AsString);
   li.SubItems.Add(squ.FieldByName('directory').AsString);
   li.SubItems.Add(squ.FieldByName('type').AsString);
end;
end;

procedure TForm1.btnAccessClick(Sender: TObject);
var
 sql : string;
 r : integer;
 li : TListItem;
begin
     sql := 'SELECT * FROM docfiles WHERE name LIKE "%' + edtSearch.Text + '%" AND type="Microsoft Access" ORDER BY name';

  squ.Close;
  squ.SQL.Clear;
  squ.SQL.Add(sql);
  squ.Open;
 lvDocuments.Clear;
for r := 1 to squ.RecordCount do
begin
   squ.RecNo:= r;
   li := lvDocuments.Items.Add;
   li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
   li.SubItems.Add(squ.FieldByName('name').AsString);
   li.SubItems.Add(squ.FieldByName('directory').AsString);
   li.SubItems.Add(squ.FieldByName('type').AsString);
end;
end;

procedure TForm1.btnPdfClick(Sender: TObject);
  var
   sql : string;
   r : integer;
   li : TListItem;
begin
       sql := 'SELECT * FROM docfiles WHERE name LIKE "%' + edtSearch.Text + '%" AND type="Acrobat PDF" ORDER BY name';

    squ.Close;
    squ.SQL.Clear;
    squ.SQL.Add(sql);
    squ.Open;
   lvDocuments.Clear;
  for r := 1 to squ.RecordCount do
  begin
     squ.RecNo:= r;
     li := lvDocuments.Items.Add;
     li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
     li.SubItems.Add(squ.FieldByName('name').AsString);
     li.SubItems.Add(squ.FieldByName('directory').AsString);
     li.SubItems.Add(squ.FieldByName('type').AsString);
  end;
end;

procedure TForm1.btnPicturesClick(Sender: TObject);
  var
   sql : string;
   r : integer;
   li : TListItem;
  begin
       sql := 'SELECT * FROM docfiles WHERE name LIKE "%' + edtSearch.Text + '%" AND type="Pictures" ORDER BY name';

    squ.Close;
    squ.SQL.Clear;
    squ.SQL.Add(sql);
    squ.Open;
   lvDocuments.Clear;
  for r := 1 to squ.RecordCount do
  begin
     squ.RecNo:= r;
     li := lvDocuments.Items.Add;
     li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
     li.SubItems.Add(squ.FieldByName('name').AsString);
     li.SubItems.Add(squ.FieldByName('directory').AsString);
     li.SubItems.Add(squ.FieldByName('type').AsString);
  end;
  end;

procedure TForm1.btnPowerpointClick(Sender: TObject);
  var
   sql : string;
   r : integer;
   li : TListItem;
  begin
       sql := 'SELECT * FROM docfiles WHERE name LIKE "%' + edtSearch.Text + '%" AND type="Microsoft Powerpoint" ORDER BY name';

    squ.Close;
    squ.SQL.Clear;
    squ.SQL.Add(sql);
    squ.Open;
   lvDocuments.Clear;
  for r := 1 to squ.RecordCount do
  begin
     squ.RecNo:= r;
     li := lvDocuments.Items.Add;
     li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
     li.SubItems.Add(squ.FieldByName('name').AsString);
     li.SubItems.Add(squ.FieldByName('directory').AsString);
     li.SubItems.Add(squ.FieldByName('type').AsString);
  end;
  end;

procedure TForm1.btnSearchClick(Sender: TObject);
var
   sql : string;
   r : integer;
   li : TListItem;
begin
    if (cbSearch.Text = 'All') then
       sql := 'SELECT * FROM docfiles WHERE name LIKE "%' + edtSearch.Text + '%" ORDER BY name'
    else
       sql := 'SELECT * FROM docfiles WHERE name LIKE "%' + edtSearch.Text + '%" AND type="' + cbSearch.Text +'" ORDER BY name';

    squ.Close;
    squ.SQL.Clear;
    squ.SQL.Add(sql);
    squ.Open;
   lvDocuments.Clear;
  for r := 1 to squ.RecordCount do
  begin
     squ.RecNo:= r;
     li := lvDocuments.Items.Add;
     li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
     li.SubItems.Add(squ.FieldByName('name').AsString);
     li.SubItems.Add(squ.FieldByName('directory').AsString);
     li.SubItems.Add(squ.FieldByName('type').AsString);
  end;
end;

procedure TForm1.btnVideosClick(Sender: TObject);
var
 sql : string;
 r : integer;
 li : TListItem;
begin
     sql := 'SELECT * FROM docfiles WHERE name LIKE "%' + edtSearch.Text + '%" AND type="Microsoft Videos" ORDER BY name';

  squ.Close;
  squ.SQL.Clear;
  squ.SQL.Add(sql);
  squ.Open;
 lvDocuments.Clear;
for r := 1 to squ.RecordCount do
begin
   squ.RecNo:= r;
   li := lvDocuments.Items.Add;
   li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
   li.SubItems.Add(squ.FieldByName('name').AsString);
   li.SubItems.Add(squ.FieldByName('directory').AsString);
   li.SubItems.Add(squ.FieldByName('type').AsString);
end;
end;

procedure TForm1.btnWordClick(Sender: TObject);
var
 sql : string;
 r : integer;
 li : TListItem;
begin
     sql := 'SELECT * FROM docfiles WHERE name LIKE "%' + edtSearch.Text + '%" AND type="Microsoft Word" ORDER BY name';

  squ.Close;
  squ.SQL.Clear;
  squ.SQL.Add(sql);
  squ.Open;
 lvDocuments.Clear;
for r := 1 to squ.RecordCount do
begin
   squ.RecNo:= r;
   li := lvDocuments.Items.Add;
   li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
   li.SubItems.Add(squ.FieldByName('name').AsString);
   li.SubItems.Add(squ.FieldByName('directory').AsString);
   li.SubItems.Add(squ.FieldByName('type').AsString);
end;
end;

procedure TForm1.edtSearchKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
     begin
        btnSearch.Click;
     end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  sqlite.DatabaseName:= ExtractFilePath(Application.ExeName) + 'dm.db';
  sqlite.Connected:= true;
  sqlTransaction1.Active:= true;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  r : integer;
  li : TListItem;
begin
  squ.SQL.Clear;
  squ.SQL.Add('Select * from docfiles Order by id');
  squ.Open;

  for r := 1 to squ.RecordCount do
  begin
     squ.RecNo:= r;
     li := lvDocuments.Items.Add;
     li.Caption:= IntToStr(squ.FieldByName('id').AsInteger);
     li.SubItems.Add(squ.FieldByName('name').AsString);
     li.SubItems.Add(squ.FieldByName('directory').AsString);
     li.SubItems.Add(squ.FieldByName('type').AsString);
  end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

end.

