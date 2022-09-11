unit MarlusORM.Commons.Formatters.Tests;

interface

uses
  System.Classes,
  System.SysUtils,
  DUnitX.Assert,
  DUnitX.Assert.Ex,
  DUnitX.TestFramework,
  MarlusORM.Commons.Types,
  MarlusORM.Commons.Formatters;

type

  [TestFixture]
  TMarlusORMCommonsFormattersTests = class
  protected
    procedure TestCaseFormatter(const AFormatter: TFormatterDefaults; const AInput: string; const AExpected: string);
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestRegisterFormatter;

    [Test]
    procedure TestUnRegisterFormatter;

    [Test]
    procedure TestDefaultCaseFormatter;

    [Test]
    procedure TestLowerCaseFormatter;

    [Test]
    procedure TestUpperCaseFormatter;

    [Test]
    procedure TestCamelCaseFormatter;

    [Test]
    procedure TestPascalCaseFormatter;

    [Test]
    procedure TestSnakeCaseFormatter;

    [Test]
    procedure TestScreamingSnakeCaseFormatter;
  end;

implementation

type
  TTestFormatter = class(TInterfacedObject, IFormatter)
  public
    function Format(const AText: string): string; virtual;
  end;

{ TTestFormatter }

function TTestFormatter.Format(const AText: string): string;
begin
  Result := AText;
end;

{ TMarlusORMCommonsFormattersTests }

procedure TMarlusORMCommonsFormattersTests.Setup;
begin
  Assert.IgnoreCaseDefault := False;
end;

procedure TMarlusORMCommonsFormattersTests.TearDown;
begin

end;

procedure TMarlusORMCommonsFormattersTests.TestCaseFormatter(const AFormatter: TFormatterDefaults; const AInput: string; const AExpected: string);
var
  LOutput: string;
begin
  Assert.WillNotRaiseAny(
    procedure
    begin
      LOutput := TFormatters[AFormatter.Name].Format(AInput);

      Assert.IsNotEmpty(LOutput);
      Assert.AreEqual(AExpected, LOutput);
    end);
end;

procedure TMarlusORMCommonsFormattersTests.TestRegisterFormatter;
var
  LFormatter: IFormatter;
begin
  Assert.WillRaise(
    procedure
    begin
      TFormatters.Register('TestCaseNil', nil);
    end,
    EFormatterNilException);

  Assert.WillNotRaiseAny(
    procedure
    begin
      TFormatters.Register('TestCase', TTestFormatter.Create);
    end);

  Assert.WillNotRaiseAny(
    procedure
    begin
      LFormatter := TFormatters['TestCase'];
      Assert.IsNotNull(LFormatter);
    end);
end;

procedure TMarlusORMCommonsFormattersTests.TestUnRegisterFormatter;
var
  LFormatter: IFormatter;
begin
  Assert.WillNotRaiseAny(
    procedure
    begin
      LFormatter := TFormatters['TestCase'];
      Assert.IsNotNull(LFormatter);
    end);

  Assert.WillNotRaiseAny(
    procedure
    begin
      TFormatters.UnRegister('TestCase');
    end);

  Assert.WillRaise(
    procedure
    begin
      TFormatters.UnRegister('TestCase');
    end,
    EFormatterNotFoundException);

  Assert.WillRaise(
    procedure
    begin
      LFormatter := TFormatters['TestCase'];
    end,
    EFormatterNotFoundException);
end;

procedure TMarlusORMCommonsFormattersTests.TestDefaultCaseFormatter;
begin
  Self.TestCaseFormatter(TFormatterDefaults.Default, 'YearOfFoundation', 'YearOfFoundation');
end;

procedure TMarlusORMCommonsFormattersTests.TestLowerCaseFormatter;
begin
  Self.TestCaseFormatter(TFormatterDefaults.LowerCase, 'YearOfFoundation', 'yearoffoundation');
end;

procedure TMarlusORMCommonsFormattersTests.TestUpperCaseFormatter;
begin
  Self.TestCaseFormatter(TFormatterDefaults.UpperCase, 'YearOfFoundation', 'YEAROFFOUNDATION');
end;

procedure TMarlusORMCommonsFormattersTests.TestCamelCaseFormatter;
begin
  Self.TestCaseFormatter(TFormatterDefaults.CamelCase, 'YearOfFoundation', 'yearOfFoundation');
end;

procedure TMarlusORMCommonsFormattersTests.TestPascalCaseFormatter;
begin
  Self.TestCaseFormatter(TFormatterDefaults.PascalCase, 'YearOfFoundation', 'YearOfFoundation');
end;

procedure TMarlusORMCommonsFormattersTests.TestSnakeCaseFormatter;
begin
  Self.TestCaseFormatter(TFormatterDefaults.SnakeCase, 'YearOfFoundation', 'year_of_foundation');
end;

procedure TMarlusORMCommonsFormattersTests.TestScreamingSnakeCaseFormatter;
begin
  Self.TestCaseFormatter(TFormatterDefaults.ScreamingSnakeCase, 'YearOfFoundation', 'YEAR_OF_FOUNDATION');
end;

end.
