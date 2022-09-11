unit MarlusORM.Commons.Configurations;

interface

uses
  MarlusORM.Commons.Types,
  MarlusORM.Commons.Formatters;

type

  TConfigurations = class
  private
    class var FKeywordFormatter: IFormatter;
    class var FEntityFormatter: IFormatter;
    class var FFieldFormatter: IFormatter;
  private
    {$HINTS OFF}
    constructor Create; reintroduce;
    {$HINTS ON}
  public
    class property KeywordFormatter: IFormatter read FKeywordFormatter;
    class property EntityFormatter: IFormatter read FEntityFormatter;
    class property FieldFormatter: IFormatter read FFieldFormatter;

    class procedure ConfigureKeywordFormatter(const AFormatter: IFormatter); overload; static;
    class procedure ConfigureKeywordFormatter(const AFormatterName: string); overload; static;

    class procedure ConfigureEntityFormatter(const AFormatter: IFormatter); overload; static;
    class procedure ConfigureEntityFormatter(const AFormatterName: string); overload; static;

    class procedure ConfigureFieldFormatter(const AFormatter: IFormatter); overload; static;
    class procedure ConfigureFieldFormatter(const AFormatterName: string); overload; static;
  end;

implementation

{ TConfigurations }

constructor TConfigurations.Create;
begin
  inherited;
end;

class procedure TConfigurations.ConfigureKeywordFormatter(const AFormatter: IFormatter);
begin
  if FKeywordFormatter <> AFormatter then
    FKeywordFormatter := AFormatter;
end;

class procedure TConfigurations.ConfigureKeywordFormatter(const AFormatterName: string);
var
  LFormatter: IFormatter;
begin
  LFormatter := TFormatters[AFormatterName];
  TConfigurations.ConfigureKeywordFormatter(LFormatter);
end;

class procedure TConfigurations.ConfigureEntityFormatter(const AFormatter: IFormatter);
begin
  if FEntityFormatter <> AFormatter then
    FEntityFormatter := AFormatter;
end;

class procedure TConfigurations.ConfigureEntityFormatter(const AFormatterName: string);
var
  LFormatter: IFormatter;
begin
  LFormatter := TFormatters[AFormatterName];
  TConfigurations.ConfigureEntityFormatter(LFormatter);
end;

class procedure TConfigurations.ConfigureFieldFormatter(const AFormatter: IFormatter);
begin
  if FFieldFormatter <> AFormatter then
    FFieldFormatter := AFormatter;
end;

class procedure TConfigurations.ConfigureFieldFormatter(const AFormatterName: string);
var
  LFormatter: IFormatter;
begin
  LFormatter := TFormatters[AFormatterName];
  TConfigurations.ConfigureFieldFormatter(LFormatter);
end;

initialization
  TConfigurations.ConfigureKeywordFormatter(TFormatterDefaults.Default.Name);
  TConfigurations.ConfigureEntityFormatter(TFormatterDefaults.Default.Name);
  TConfigurations.ConfigureFieldFormatter(TFormatterDefaults.Default.Name);

end.
