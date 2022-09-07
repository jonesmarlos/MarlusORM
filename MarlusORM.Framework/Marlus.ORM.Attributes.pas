unit Marlus.ORM.Attributes;

interface

type

  { The base class for all SQL custom attributes. }
  SQLCustomAttribute = class(TCustomAttribute)
  strict private
    FName: string;
  public
    property Name: string read FName;

    constructor Create(AName: string); reintroduce;
  end;

  { The attribute indicates a entity with a name. }
  SQLEntityAttribute = class(SQLCustomAttribute);

  { The attribute indicates a field with a name. }
  SQLFieldAttribute = class(SQLCustomAttribute);

  { The attribute indicates a primary key field with a name }
  SQLPrimaryKeyAttribute = class(SQLFieldAttribute);

  { The attribute indicates a field witch never is mapped for entity field }
  SQLVirtualFieldAttribute = class(TCustomAttribute);

implementation

{ SQLCustomAttribute }

constructor SQLCustomAttribute.Create(AName: string);
begin
  inherited Create;
  Self.FName := AName;
end;

end.
