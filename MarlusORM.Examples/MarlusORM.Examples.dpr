program MarlusORM.Examples;

uses
  Vcl.Forms,
  Marlus.ORM.Examples.Forms in 'Marlus.ORM.Examples.Forms.pas' {fmMarlusORMExamples},
  Marlus.ORM.Examples.Cities in 'Marlus.ORM.Examples.Cities.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMarlusORMExamples, fmMarlusORMExamples);
  Application.Run;
end.
