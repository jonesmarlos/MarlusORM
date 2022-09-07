unit Marlus.ORM.Examples.Forms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfmMarlusORMExamples = class(TForm)
    mmSQL: TMemo;
    btSelectAll: TButton;
    btSelectRecord: TButton;
    btSelectCriteria: TButton;
    btUpdateAll: TButton;
    btUpdateRecord: TButton;
    btUpdateCriteria: TButton;
    btDeleteAll: TButton;
    btDeleteRecord: TButton;
    btDeleteCriteria: TButton;
    btInsertRecord: TButton;
    btInsertOrUpdate: TButton;
    btUpdateTemplate: TButton;
    btInsertTemplate: TButton;
    procedure btSelectAllClick(Sender: TObject);
    procedure btSelectRecordClick(Sender: TObject);
    procedure btSelectCriteriaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMarlusORMExamples: TfmMarlusORMExamples;

implementation

uses
  Marlus.ORM.SQLBuilder,
  Marlus.ORM.SQLSelectBuilder,
  Marlus.ORM.Examples.Cities;

{$R *.dfm}

procedure TfmMarlusORMExamples.btSelectAllClick(Sender: TObject);
var
  LBuilder: TSQLSelectBuilder<TCity>;
begin
  LBuilder := TSQLSelectBuilder<TCity>.Create;
  try
    LBuilder.Build;

    Self.mmSQL.Lines.Text := LBuilder.ToString;
  finally
    LBuilder.Free;
  end;
end;

procedure TfmMarlusORMExamples.btSelectRecordClick(Sender: TObject);
var
  LBuilder: TSQLRecordSelectBuilder<TCity>;
begin
  LBuilder := TSQLRecordSelectBuilder<TCity>.Create;
  try
    LBuilder.Build;

    Self.mmSQL.Lines.Text := LBuilder.ToString;
  finally
    LBuilder.Free;
  end;
end;

procedure TfmMarlusORMExamples.btSelectCriteriaClick(Sender: TObject);
var
  LCity: TCity;
  LBuilder: TSQLCriteriaSelectBuilder<TCity>;
begin
  LCity := TCity.Create;
  LBuilder := TSQLCriteriaSelectBuilder<TCity>.Create;
  try
    LCity.Name := 'New York';

    LBuilder.Build(LCity);

    Self.mmSQL.Lines.Text := LBuilder.ToString;
  finally
    LBuilder.Free;
  end;
end;

end.
