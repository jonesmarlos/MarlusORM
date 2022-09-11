unit MarlusORM.Commons.Configurations;

interface

uses
  MarlusORM.Commons.Types,
  MarlusORM.Commons.Formatters;

type

  TSQLConfigurations = class
  private
    class var FDatabase: TSQLDatabase;
    class var FKeywordCase: TSQLCase;
    class var FEntityCase: TSQLCase;
    class var FFieldCase: TSQLCase;

    class var FKeywordFormatter: TSQLCaseFormatter;
    class var FEntityFormatter: TSQLCaseFormatter;
    class var FFieldFormatter: TSQLCaseFormatter;
  private
    {$HINTS OFF}
    constructor Create; reintroduce;
    {$HINTS ON}
  public
    class property Database: TSQLDatabase read FDatabase;

    class property KeywordCase: TSQLCase read FKeywordCase;
    class property EntityCase: TSQLCase read FEntityCase;
    class property FieldCase: TSQLCase read FFieldCase;

    class property KeywordFormatter: TSQLCaseFormatter read FKeywordFormatter;
    class property EntityFormatter: TSQLCaseFormatter read FEntityFormatter;
    class property FieldFormatter: TSQLCaseFormatter read FFieldFormatter;

    class procedure ConfigureDatabase(const ADatabase: TSQLDatabase); static;

    class procedure ConfigureKeywordCase(const ACase: TSQLCase); static;
    class procedure ConfigureEntityCase(const ACase: TSQLCase); static;
    class procedure ConfigureFieldCase(const ACase: TSQLCase); static;
  end;

implementation

{ TSQLConfigurations }

constructor TSQLConfigurations.Create;
begin
  inherited;
end;

class procedure TSQLConfigurations.ConfigureDatabase(const ADatabase: TSQLDatabase);
begin
  FDatabase := ADatabase;
end;

class procedure TSQLConfigurations.ConfigureKeywordCase(const ACase: TSQLCase);
begin
  if FKeywordCase <> ACase then
  begin
    FKeywordCase := ACase;
    FKeywordFormatter := TSQLCaseFormatters[ACase];
  end;
end;

class procedure TSQLConfigurations.ConfigureEntityCase(const ACase: TSQLCase);
begin
  if FEntityCase <> ACase then
  begin
    FEntityCase := ACase;
    FEntityFormatter := TSQLCaseFormatters[ACase];
  end;
end;

class procedure TSQLConfigurations.ConfigureFieldCase(const ACase: TSQLCase);
begin
  if FFieldCase <> ACase then
  begin
    FFieldCase := ACase;
    FFieldFormatter := TSQLCaseFormatters[ACase];
  end;
end;

initialization
  TSQLConfigurations.ConfigureDatabase(TSQLDatabase.Default);
  TSQLConfigurations.ConfigureKeywordCase(TSQLCase.Upper);
  TSQLConfigurations.ConfigureEntityCase(TSQLCase.Upper);
  TSQLConfigurations.ConfigureFieldCase(TSQLCase.Upper);

end.
