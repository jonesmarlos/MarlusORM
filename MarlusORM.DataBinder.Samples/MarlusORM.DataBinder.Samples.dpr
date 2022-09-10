program MarlusORM.DataBinder.Samples;

uses
  Vcl.Forms,
  MarlusORM.DataBinder.Samples.Form in 'MarlusORM.DataBinder.Samples.Form.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
