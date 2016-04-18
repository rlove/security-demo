unit uSearchForm;
// This demo shows how to use parameters to avoid SQL Injection.

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite;

type
  TfrmMainSQLInjection = class(TForm)
    FDQuery1: TFDQuery;
    Label1: TLabel;
    edtSearchTerm: TEdit;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    btnUnsafeSearch: TButton;
    btnSafeSearch: TButton;
    FDConnection1: TFDConnection;
    Label2: TLabel;
    edtDatabase: TEdit;
    Button3: TButton;
    FileOpenDialog1: TFileOpenDialog;
    btnOpenClose: TButton;
    btnLoadExample: TButton;
    cbxExamples: TComboBox;
    Label3: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure btnOpenCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnUnsafeSearchClick(Sender: TObject);
    procedure btnSafeSearchClick(Sender: TObject);
    procedure btnLoadExampleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenDatabase(DatabaseFileName : String);
    procedure FindDBInDefaultLocation;
  end;

var
  frmMainSQLInjection: TfrmMainSQLInjection;

implementation
uses IOUtils;

{$R *.dfm}

procedure TfrmMainSQLInjection.btnLoadExampleClick(Sender: TObject);
begin
  edtSearchTerm.Text := cbxExamples.Text;
end;

procedure TfrmMainSQLInjection.btnOpenCloseClick(Sender: TObject);
begin
  if Not FDConnection1.Connected then
  begin
    OpenDatabase(edtDatabase.Text);
    btnSafeSearch.Enabled := True;
    btnUnsafeSearch.Enabled := true;
    btnOpenClose.Caption := 'Close';
  end
  else
  begin
    FDConnection1.Connected := false;
    btnSafeSearch.Enabled := False;
    btnUnsafeSearch.Enabled := False;
    btnOpenClose.Caption := 'Open';
  end;

end;

procedure TfrmMainSQLInjection.btnUnsafeSearchClick(Sender: TObject);
begin
  // The unsafe query
  // The problem here is that we are not validating the input.
  // It allows the input to contain a quote to end the string.
  // then union to a different table or command
  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('select * from tbl1 where name like ''' + edtSearchTerm.Text +'%''');
  FDQuery1.Open;
end;

procedure TfrmMainSQLInjection.btnSafeSearchClick(Sender: TObject);
begin
  // Safe query
  // This uses a parameter, regardless of the input it can not modify the SQL statement.
  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('select * from tbl1 where name like :name');
  FDQuery1.ParamByName('name').asString := edtSearchTerm.Text + '%';
  FDQuery1.Open;
end;

procedure TfrmMainSQLInjection.Button3Click(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
  begin
    edtDatabase.Text := FileOpenDialog1.FileName;
  end;
end;

procedure TfrmMainSQLInjection.FindDBInDefaultLocation;
begin
   // This finds the default location based on file placement in GitHub
   // Location would be ..\..\..\db\SqlLite\demo1
   edtDatabase.Text := ExpandFileName( TPath.Combine(ExtractFilePath(ParamStr(0)),'..\..\..\db\SqLite\demo1'));
end;

procedure TfrmMainSQLInjection.FormCreate(Sender: TObject);
begin
   FindDBInDefaultLocation;
end;

procedure TfrmMainSQLInjection.OpenDatabase(DatabaseFileName: String);
begin
   // Validate user input and make sure Database File Name exists.
   // otherwise you could be allowing an injection of other params here.
    if Not FileExists(DatabaseFileName) then
       raise EFileNotFoundException.Create('Database Not Found');

   FDConnection1.Params.Clear;
   FDConnection1.DriverName := 'SQLite';
   FDConnection1.Params.Add('Database=' + DatabaseFileName);
   FDConnection1.Connected := true;
end;

end.
