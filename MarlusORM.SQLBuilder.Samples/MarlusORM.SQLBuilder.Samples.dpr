program MarlusORM.SQLBuilder.Samples;

uses
  Vcl.Forms,
  MarlusORM.SQLBuilder.Samples.Form in 'MarlusORM.SQLBuilder.Samples.Form.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
