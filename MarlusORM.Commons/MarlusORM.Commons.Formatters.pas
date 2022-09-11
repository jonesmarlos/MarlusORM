unit MarlusORM.Commons.Formatters;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  MarlusORM.Commons.Types;

type

  EFormatterException = class(Exception);
  EFormatterNotFoundException = class(EFormatterException);
  EFormatterNilException = class(EFormatterException);

  IFormatter = interface
    function Format(const AInput: string): string;
  end;

  TFormatter = class(TInterfacedObject, IFormatter)
  public
    function Format(const AText: string): string; virtual; abstract;
  end;

  TFormatterClass = class of TFormatter;

  TDefaultCaseFormatter = class(TFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TLowerCaseFormatter = class(TFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TUpperCaseFormatter = class(TFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TCamelCaseFormatter = class(TFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TPascalCaseFormatter = class(TFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TSnakeCaseFormatter = class(TFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TScreamingSnakeCaseFormatter = class(TFormatter)
  public
    function Format(const AText: string): string; override;
  end;

  TFormatters = class
  private
    class var FFormatters: TDictionary<string, IFormatter>;
  protected
    class function GetFormatter(const AName: string): IFormatter; static;
  public
    class property Items[const AName: string]: IFormatter read GetFormatter; default;

    class procedure Register(const AName: string; const AFormatter: IFormatter); static;
    class procedure UnRegister(const AName: string); static;

    class procedure RegisterDefaults; static;
    class procedure UnRegisterDefaults; static;
  end;

implementation

uses
  System.Character;

{ TDefaultCaseFormatter }

function TDefaultCaseFormatter.Format(const AText: string): string;
begin
  Result := AText.Trim;
end;

{ TLowerCaseFormatter }

function TLowerCaseFormatter.Format(const AText: string): string;
begin
  Result := AText.Trim.ToLower;
end;

{ TUpperCaseFormatter }

function TUpperCaseFormatter.Format(const AText: string): string;
begin
  Result := AText.Trim.ToUpper;
end;

{ TCamelCaseFormatter }

function TCamelCaseFormatter.Format(const AText: string): string;
begin
  Result := AText.Trim;

  if (not Result.IsEmpty) and (CharInSet(Result.Chars[0], ['A'..'Z'])) then
    Result := Result.Substring(0, 1).ToLower + Result.Substring(1);
end;

{ TPascalCaseFormatter }

function TPascalCaseFormatter.Format(const AText: string): string;
begin
  Result := AText.Trim;
  if (not Result.IsEmpty) and (CharInSet(Result.Chars[0], ['a'..'z'])) then
    Result := Result.Substring(0, 1).ToUpper + Result.Substring(1);
end;

{ TSnakeCaseFormatter }

function TSnakeCaseFormatter.Format(const AText: string): string;
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
      LResult.Append(LChar.ToLower);
    end;

    if LResult.Chars[0] = '_' then
      Result := LResult.ToString(1, LResult.Length - 1)
    else
      Result := LResult.ToString;
  finally
    LResult.Free;
  end;
end;

{ TScreamingSnakeCaseFormatter }

function TScreamingSnakeCaseFormatter.Format(const AText: string): string;
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
      LResult.Append(LChar.ToUpper);
    end;

    if LResult.Chars[0] = '_' then
      Result := LResult.ToString(1, LResult.Length - 1)
    else
      Result := LResult.ToString;
  finally
    LResult.Free;
  end;
end;

{ TFormatters }

class function TFormatters.GetFormatter(const AName: string): IFormatter;
begin
  if not FFormatters.TryGetValue(AName, Result) then
    raise EFormatterNotFoundException.Create('Formatter not found');
end;

class procedure TFormatters.Register(const AName: string; const AFormatter: IFormatter);
begin
  if AFormatter = nil then
    raise EFormatterNilException.Create('Argument AFormatterClass is required');

  FFormatters.Add(AName, AFormatter);
end;

class procedure TFormatters.UnRegister(const AName: string);
var
  LFormatter: IFormatter;
begin
  if not FFormatters.TryGetValue(AName, LFormatter) then
    raise EFormatterNotFoundException.Create('Formatter not fount');

  FFormatters.Remove(AName);
  LFormatter := nil;
end;

class procedure TFormatters.RegisterDefaults;
begin
  TFormatters.Register(TFormatterDefaults.Default.Name, TDefaultCaseFormatter.Create);
  TFormatters.Register(TFormatterDefaults.LowerCase.Name, TLowerCaseFormatter.Create);
  TFormatters.Register(TFormatterDefaults.UpperCase.Name, TUpperCaseFormatter.Create);
  TFormatters.Register(TFormatterDefaults.CamelCase.Name, TCamelCaseFormatter.Create);
  TFormatters.Register(TFormatterDefaults.PascalCase.Name, TPascalCaseFormatter.Create);
  TFormatters.Register(TFormatterDefaults.SnakeCase.Name, TSnakeCaseFormatter.Create);
  TFormatters.Register(TFormatterDefaults.ScreamingSnakeCase.Name, TScreamingSnakeCaseFormatter.Create);
end;

class procedure TFormatters.UnRegisterDefaults;
begin
  TFormatters.UnRegister(TFormatterDefaults.Default.Name);
  TFormatters.UnRegister(TFormatterDefaults.LowerCase.Name);
  TFormatters.UnRegister(TFormatterDefaults.UpperCase.Name);
  TFormatters.UnRegister(TFormatterDefaults.CamelCase.Name);
  TFormatters.UnRegister(TFormatterDefaults.PascalCase.Name);
  TFormatters.UnRegister(TFormatterDefaults.SnakeCase.Name);
  TFormatters.UnRegister(TFormatterDefaults.ScreamingSnakeCase.Name);
end;

initialization
  TFormatters.FFormatters := TDictionary<string, IFormatter>.Create;
  TFormatters.RegisterDefaults;

finalization
  TFormatters.UnRegisterDefaults;
  TFormatters.FFormatters.Free;

end.
