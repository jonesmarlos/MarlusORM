unit MarlusORM.Commons.Types;

{$SCOPEDENUMS ON}

interface

type

  TFormatterDefaults = (
    Default,
    LowerCase,
    UpperCase,
    CamelCase,
    PascalCase,
    SnakeCase,
    ScreamingSnakeCase
  );

  TFormatterDefaultsHelper = record helper for TFormatterDefaults
  public
    function Name: string; inline;
  end;

const
  FormatterDefaults: array[TFormatterDefaults] of string = (
    'Default',
    'LowerCase',
    'UpperCase',
    'CamelCase',
    'PascalCase',
    'SnakeCase',
    'ScreamingSnakeCase'
  );

implementation

{ TFormatterDefaultsHelper }

function TFormatterDefaultsHelper.Name: string;
begin
  Result := FormatterDefaults[Self];
end;

end.
