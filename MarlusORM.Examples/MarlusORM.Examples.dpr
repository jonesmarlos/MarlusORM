program MarlusORM.Examples;

uses
  Vcl.Forms,
  MarlusORM.Examples.Forms in 'MarlusORM.Examples.Forms.pas' {fmMarlusORMExamples};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMarlusORMExamples, fmMarlusORMExamples);
  Application.Run;
end.
