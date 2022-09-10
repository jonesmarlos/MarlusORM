program MarlusORM.DataMapper.Samples;

uses
  Vcl.Forms,
  MarlusORM.DataMapper.Samples.Form in 'MarlusORM.DataMapper.Samples.Form.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
