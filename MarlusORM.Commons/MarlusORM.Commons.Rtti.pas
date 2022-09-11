unit MarlusORM.Commons.Rtti;

interface

uses
  System.Rtti;

type

  TRttiFieldHelper = class helper for TRttiField
  public
    function IsSQLField: Boolean; virtual;
    function IsSQLDefaultValue(AInstance: Pointer): Boolean; virtual;
    function IsSQLPrimaryKey: Boolean; virtual;
    function SQLFieldName: string; virtual;
  end;

  TRttiTypeHelper = class helper for TRttiType
  public
    function IsSQLEntity: Boolean; virtual;
    function SQLEntityName: string; virtual;
    function SQLPrimaryKeyName: string; virtual;
  end;

implementation

uses
  System.SysUtils,
  System.Variants,
  MarlusORM.Commons.Attributes,
  MarlusORM.Commons.Configurations;

{ TRttiFieldHelper }

function TRttiFieldHelper.IsSQLField: Boolean;
var
  LAttribute: TCustomAttribute;
begin
  Result := True;
  for LAttribute in Self.GetAttributes do
    if LAttribute is SQLIgnoreAttribute then
      Exit(False);
end;

function TRttiFieldHelper.IsSQLDefaultValue(AInstance: Pointer): Boolean;
var
  LValue: TValue;
begin
  LValue := Self.GetValue(AInstance);

  if LValue.IsEmpty then
    Exit(True);

  if LValue.IsOrdinal then
    Exit(LValue.AsOrdinal = 0);

  if LValue.IsObject then
    Exit(LValue.AsObject = nil);

  if LValue.IsArray then
    Exit(LValue.GetArrayLength = 0);

  case Self.FieldType.TypeKind of
    tkInteger: Result := LValue.AsInteger = 0;
    tkChar: Result := LValue.AsString.IsEmpty;
    tkEnumeration: Result := LValue.AsOrdinal = 0;
    tkFloat: Result := LValue.AsExtended = 0;
    tkString: Result := LValue.AsString.IsEmpty;
    tkSet: Result := LValue.IsEmpty;
    tkWChar: Result := LValue.AsString.IsEmpty;
    tkLString: Result := LValue.AsString.IsEmpty;
    tkWString: Result := LValue.AsString.IsEmpty;
    tkVariant: Result := VarIsClear(LValue.AsVariant);
    tkArray: Result := LValue.GetArrayLength = 0;
    tkInt64: Result := LValue.AsInt64 = 0;
    tkDynArray: Result := LValue.GetArrayLength = 0;
    tkUString: Result := LValue.AsString.IsEmpty;
  else
    Result := False;
  end;
end;

function TRttiFieldHelper.IsSQLPrimaryKey: Boolean;
var
  LAttribute: TCustomAttribute;
begin
  Result := False;
  for LAttribute in Self.GetAttributes do
    if LAttribute is SQLPrimaryKeyAttribute then
      Exit(True);
end;

function TRttiFieldHelper.SQLFieldName: string;
var
  LAttribute: TCustomAttribute;
  LProperty: TRttiProperty;
begin
  if not Self.IsSQLField then
    Exit(EmptyStr);

  Result := TConfigurations.FieldFormatter.Format(Self.Name.Substring(1));

  for LAttribute in Self.GetAttributes do
    if LAttribute is SQLFieldAttribute then
      Exit(TConfigurations.FieldFormatter.Format(SQLFieldAttribute(LAttribute).Name));

  for LProperty in Self.FieldType.GetProperties do
    for LAttribute in LProperty.GetAttributes do
      if LAttribute is SQLFieldAttribute then
        Exit(TConfigurations.FieldFormatter.Format(SQLFieldAttribute(LAttribute).Name));
end;

{ TRttiTypeHelper }

function TRttiTypeHelper.IsSQLEntity: Boolean;
begin
  Result := Self.IsPublicType and (not Self.IsRecord);
end;

function TRttiTypeHelper.SQLEntityName: string;
var
  LAttribute: TCustomAttribute;
begin
  if not Self.IsSQLEntity then
    Exit(EmptyStr);

  Result := TConfigurations.EntityFormatter.Format(Self.Name.Substring(1));

  for LAttribute in Self.GetAttributes do
    if LAttribute is SQLEntityAttribute then
      Exit(TConfigurations.EntityFormatter.Format(SQLEntityAttribute(LAttribute).Name));
end;

function TRttiTypeHelper.SQLPrimaryKeyName: string;
var
  LField: TRttiField;
  LFirst: Boolean;
begin
  if not Self.IsSQLEntity then
    Exit(EmptyStr);

  LFirst := True;
  for LField in Self.GetFields do
  begin
    if LField.IsSQLPrimaryKey then
      Exit(LField.SQLFieldName);

    if LFirst and LField.IsSQLField then
    begin
      Result := LField.SQLFieldName;
      LFirst := False;
    end;
  end;
end;

end.
