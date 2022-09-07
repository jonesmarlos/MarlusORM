program MarlusORM.Framework;

uses
  Vcl.Forms,
  Marlus.ORM.Attributes in 'Marlus.ORM.Attributes.pas',
  Marlus.ORM.Rtti in 'Marlus.ORM.Rtti.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Run;
  Application.Terminate;
end.
