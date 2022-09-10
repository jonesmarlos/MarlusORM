unit MarlusORM.Commons.Attributes;

interface

type

  SQLCustomAttribute = class(TCustomAttribute)
  strict private
    FName: string;
  public
    property Name: string read FName;

    constructor Create(AName: string); reintroduce;
  end;

  SQLEntityAttribute = class(SQLCustomAttribute);

  SQLFieldAttribute = class(SQLCustomAttribute);

  SQLPrimaryKeyAttribute = class(SQLFieldAttribute);

  SQLIgnoreAttribute = class(TCustomAttribute);

implementation

{ SQLCustomAttribute }

constructor SQLCustomAttribute.Create(AName: string);
begin
  inherited Create;
  Self.FName := AName;
end;

end.
