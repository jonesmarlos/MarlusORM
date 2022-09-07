unit Marlus.ORM.Rtti;

interface

uses
  System.Rtti;

type

  TRttiFieldHelper = class helper for TRttiField
  public
    function IsSQLField: Boolean;
    function IsSQLPrimaryKey: Boolean;
    function IsSQLDefaultValue(AInstance: Pointer): Boolean;
    function GetSQLFieldInfo(out AName: string): Boolean;
  end;

  TRttiTypeHelper = class helper for TRttiType
  public
    function IsSQLEntity: Boolean;
    function GetSQLEntityInfo(out AName: string): Boolean;
    function GetSQLFieldPrimaryKey(out AName: string): Boolean;
  end;

implementation

uses
  System.SysUtils,
  System.Variants,
  Marlus.ORM.Attributes;

{ TRttiFieldHelper }

function TRttiFieldHelper.IsSQLField: Boolean;
var
  LAttribute: TCustomAttribute;
begin
  Result := True;
  for LAttribute in Self.GetAttributes do
    if LAttribute is SQLVirtualFieldAttribute then
      Exit(False);
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
    tkUnknown: Result := False;
    tkInteger: Result := LValue.AsInteger = 0;
    tkChar: Result := LValue.AsString.IsEmpty;
    tkEnumeration: Result := LValue.AsOrdinal = 0;
    tkFloat: Result := LValue.AsExtended = 0;
    tkString: Result := LValue.AsString.IsEmpty;
    tkSet: Result := LValue.IsEmpty;
    tkClass: Result := False;
    tkMethod: Result := False;
    tkWChar: Result := LValue.AsString.IsEmpty;
    tkLString: Result := LValue.AsString.IsEmpty;
    tkWString: Result := LValue.AsString.IsEmpty;
    tkVariant: Result := VarIsClear(LValue.AsVariant);
    tkArray: Result := LValue.GetArrayLength = 0;
    tkRecord: Result := False;
    tkInterface: Result := False;
    tkInt64: Result := LValue.AsInt64 = 0;
    tkDynArray: Result := LValue.GetArrayLength = 0;
    tkUString: Result := LValue.AsString.IsEmpty;
    tkClassRef: Result := False;
    tkPointer: Result := False;
    tkProcedure: Result := False;
  end;
end;

function TRttiFieldHelper.GetSQLFieldInfo(out AName: string): Boolean;
var
  LAttribute: TCustomAttribute;
  LFieldAttr: SQLFieldAttribute;
begin
  Result := Self.IsSQLField;

  if not Result then
    Exit(False);

  AName := Self.Name.Substring(1).ToUpper;

  for LAttribute in Self.GetAttributes do
  begin
    if LAttribute is SQLFieldAttribute then
    begin
      AName := SQLFieldAttribute(LAttribute).Name;
      Break;
    end;
  end;
end;

{ TRttiTypeHelper }

function TRttiTypeHelper.IsSQLEntity: Boolean;
begin
  Result := Self.IsPublicType and (not Self.IsRecord);
end;

function TRttiTypeHelper.GetSQLEntityInfo(out AName: string): Boolean;
var
  LAttribute: TCustomAttribute;
begin
  Result := Self.IsSQLEntity;

  if not Result then
    Exit(False);

  AName := Self.Name.Substring(1).ToUpper;

  for LAttribute in Self.GetAttributes do
  begin
    if LAttribute is SQLEntityAttribute then
    begin
      AName := SQLEntityAttribute(LAttribute).Name;
      Break;
    end;
  end;
end;

function TRttiTypeHelper.GetSQLFieldPrimaryKey(out AName: string): Boolean;
var
  LField: TRttiField;
  LFirst: Boolean;
begin
  Result := Self.IsSQLEntity;

  if not Result then
    Exit(False);

  LFirst := True;
  for LField in Self.GetFields do
  begin
    if LField.IsSQLPrimaryKey then
    begin
      LField.GetSQLFieldInfo(AName);
      Break;
    end;
    if LFirst and LField.IsSQLField then
    begin
      LField.GetSQLFieldInfo(AName);
      LFirst := False;
    end;
  end;
end;

end.
