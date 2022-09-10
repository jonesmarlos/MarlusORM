unit MarlusORM.Commons.Formatters;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  MarlusORM.Commons.Types;

type

  TSQLCaseFormatter = class
  public
    function Format(const AText: string): string; virtual; abstract;
  end;

  TSQLCaseFormatterClass = class of TSQLCaseFormatter;

  TSQLCaseFormatters = class
  private
    class var FFormatters: TDictionary<TSQLCase, TSQLCaseFormatter>;
  protected
    class function GetSQLCaseFormatter(const ACase: TSQLCase): TSQLCaseFormatter; static;
  public
    class property Items[const ACase: TSQLCase]: TSQLCaseFormatter read GetSQLCaseFormatter; default;

    class procedure RegisterFormatter(const ACase: TSQLCase; const AFormatterClass: TSQLCaseFormatterClass); static;
    class procedure UnRegisterFormatter(const ACase: TSQLCase); static;
  end;

implementation

type

  TSQLDefaultCaseFormatter = class(TSQLCaseFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TSQLLowerCaseFormatter = class(TSQLCaseFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TSQLUpperCaseFormatter = class(TSQLCaseFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TSQLCamelCaseFormatter = class(TSQLCaseFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TSQLPascalCaseFormatter = class(TSQLCaseFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TSQLSnakeCaseFormatter = class(TSQLCaseFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TSQLScreamingSnakeCaseFormatter = class(TSQLCaseFormatter)
  public
    function Format(const AText: string): string; override;
  end;


{ TSQLCaseFormatters }

class function TSQLCaseFormatters.GetSQLCaseFormatter(const ACase: TSQLCase): TSQLCaseFormatter;
begin
  if not FFormatters.TryGetValue(ACase, Result) then
    raise Exception.Create('Case not found');
end;

class procedure TSQLCaseFormatters.RegisterFormatter(const ACase: TSQLCase; const AFormatterClass: TSQLCaseFormatterClass);
var
  LFormatter: TSQLCaseFormatter;
begin
  LFormatter := AFormatterClass.Create;
  FFormatters.Add(ACase, LFormatter);
end;

class procedure TSQLCaseFormatters.UnRegisterFormatter(const ACase: TSQLCase);
var
  LFormatter: TSQLCaseFormatter;
begin
  if FFormatters.TryGetValue(ACase, LFormatter) then
  begin
    FFormatters.Remove(ACase);
    LFormatter.Free;
  end;

end;

{ TSQLDefaultCaseFormatter }

function TSQLDefaultCaseFormatter.Format(const AText: string): string;
begin
  Result := AText.Trim;
end;

{ TSQLLowerCaseFormatter }

function TSQLLowerCaseFormatter.Format(const AText: string): string;
begin
  Result := AText.Trim.ToLower;
end;

{ TSQLUpperCaseFormatter }

function TSQLUpperCaseFormatter.Format(const AText: string): string;
begin
  Result := AText.Trim.ToUpper;
end;

{ TSQLCamelCaseFormatter }

function TSQLCamelCaseFormatter.Format(const AText: string): string;
begin
  Result := AText.Trim;

  if (not Result.IsEmpty) and (CharInSet(Result.Chars[0], ['A'..'Z'])) then
    Result := Result.Substring(0, 1).ToLower + Result.Substring(1);
end;

{ TSQLPascalCaseFormatter }

function TSQLPascalCaseFormatter.Format(const AText: string): string;
begin
  Result := AText.Trim;
  if (not Result.IsEmpty) and (CharInSet(Result.Chars[0], ['a'..'z'])) then
    Result := Result.Substring(0, 1).ToUpper + Result.Substring(1);
end;

{ TSQLSnakeCaseFormatter }

function TSQLSnakeCaseFormatter.Format(const AText: string): string;
var
  LChar: Char;
  LResult: TStringBuilder;
begin
  Result := EmptyStr;

  LResult := TStringBuilder.Create(AText.Length * 2);
  try
    for LChar in AText do
    begin
      if CharInSet(LChar, ['A'..'Z']) then
        LResult.Append('_');
      LResult.Append(LChar);
    end;

    if LResult.Chars[0] = '_' then
      Result := LResult.ToString(1, LResult.Length - 1)
    else
      Result := LResult.ToString;
  finally
    LResult.Free;
  end;
end;

{ TSQLScreamingSnakeCaseFormatter }

function TSQLScreamingSnakeCaseFormatter.Format(const AText: string): string;
var
  LChar: Char;
  LResult: TStringBuilder;
begin
  Result := EmptyStr;

  LResult := TStringBuilder.Create(AText.Length * 2);
  try
    for LChar in AText do
    begin
      if CharInSet(LChar, ['A'..'Z']) then
        LResult.Append('_');
      LResult.Append(UpCase(LChar));
    end;

    if LResult.Chars[0] = '_' then
      Result := LResult.ToString(1, LResult.Length - 1)
    else
      Result := LResult.ToString;
  finally
    LResult.Free;
  end;
end;

initialization
  TSQLCaseFormatters.FFormatters := TDictionary<TSQLCase, TSQLCaseFormatter>.Create;

  TSQLCaseFormatters.RegisterFormatter(TSQLCase.Default, TSQLDefaultCaseFormatter);
  TSQLCaseFormatters.RegisterFormatter(TSQLCase.Lower, TSQLLowerCaseFormatter);
  TSQLCaseFormatters.RegisterFormatter(TSQLCase.Upper, TSQLUpperCaseFormatter);
  TSQLCaseFormatters.RegisterFormatter(TSQLCase.Camel, TSQLCamelCaseFormatter);
  TSQLCaseFormatters.RegisterFormatter(TSQLCase.Pascal, TSQLPascalCaseFormatter);
  TSQLCaseFormatters.RegisterFormatter(TSQLCase.Snake, TSQLSnakeCaseFormatter);
  TSQLCaseFormatters.RegisterFormatter(TSQLCase.ScreamingSnake, TSQLScreamingSnakeCaseFormatter);

finalization
  TSQLCaseFormatters.UnRegisterFormatter(TSQLCase.Default);
  TSQLCaseFormatters.UnRegisterFormatter(TSQLCase.Lower);
  TSQLCaseFormatters.UnRegisterFormatter(TSQLCase.Upper);
  TSQLCaseFormatters.UnRegisterFormatter(TSQLCase.Camel);
  TSQLCaseFormatters.UnRegisterFormatter(TSQLCase.Pascal);
  TSQLCaseFormatters.UnRegisterFormatter(TSQLCase.Snake);
  TSQLCaseFormatters.UnRegisterFormatter(TSQLCase.ScreamingSnake);

  TSQLCaseFormatters.FFormatters.Free;

end.
