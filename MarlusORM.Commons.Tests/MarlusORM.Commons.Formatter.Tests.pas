unit MarlusORM.Commons.Formatter.Tests;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TMarlusORMCommonsFormatterTests = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestRegisterFormatter;

    [Test]
    procedure TestDefaultCase;
  end;

implementation

uses
  System.Classes,
  System.SysUtils,
  DUnitX.Assert,
  DUnitX.Assert.Ex,
  MarlusORM.Commons.Types,
  MarlusORM.Commons.Formatters;

procedure TMarlusORMCommonsFormatterTests.Setup;
begin
  Assert.IgnoreCaseDefault := False;
end;

procedure TMarlusORMCommonsFormatterTests.TearDown;
begin

end;

procedure TMarlusORMCommonsFormatterTests.TestRegisterFormatter;
begin
  Assert.WillRaise(
    procedure
    begin
      TSQLCaseFormatters.RegisterFormatter(TSQLCase.Default, nil);
    end,
    EArgumentNilException);
end;

procedure TMarlusORMCommonsFormatterTests.TestDefaultCase;
var
  LInput: string;
  LExpected: string;
  LOutput: string;
begin
  LInput := 'BirthDate';
  LExpected := LInput;

  LOutput := TSQLCaseFormatters[TSQLCase.Default].Format(LInput);

  Assert.AreEqual(LExpected, LOutput);
end;

initialization
  TDUnitX.RegisterTestFixture(TMarlusORMCommonsFormatterTests);

end.
