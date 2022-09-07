unit Marlus.ORM.SQLSelectBuilder;

interface

uses
  System.SysUtils,
  Marlus.ORM.SQLBuilder;

type

  TSQLSelectBuilder<T: class, constructor> = class(TSQLBuilder<T>)
  protected
    function AppendFieldList: TStringBuilder; virtual;
  public
    procedure Build; override;
  end;

  TSQLRecordSelectBuilder<T: class, constructor> = class(TSQLSelectBuilder<T>)
  public
    procedure Build; override;
  end;

  TSQLCriteriaSelectBuilder<T: class, constructor> = class(TSQLSelectBuilder<T>)
  protected
    procedure Build; overload; override;
  public
    procedure Build(const ATemplate: T); overload;
  end;

implementation

uses
  System.Rtti,
  Marlus.ORM.Rtti;

{ TSQLSelectBuilder<T> }

function TSQLSelectBuilder<T>.AppendFieldList: TStringBuilder;
var
  LIndex: Integer;
  LField: TRttiField;
  LFieldName: string;
begin
  LIndex := Self.Length;

  for LField in Self.RttiType.GetFields do
    if LField.GetSQLFieldInfo(LFieldName) then
      Self.Append(', ').Append(LFieldName);

  Self.Remove(LIndex, 2);
end;

procedure TSQLSelectBuilder<T>.Build;
var
  LEntityName: string;
begin
  inherited Build;

  Self.RttiType.GetSQLEntityInfo(LEntityName);

  Self.Append('SELECT ');
  Self.AppendFieldList;
  Self.Append(' FROM ').Append(LEntityName);
end;

{ TSQLRecordSelectBuilder<T> }

procedure TSQLRecordSelectBuilder<T>.Build;
var
  LPrimaryKeyName: string;
begin
  inherited Build;

  Self.RttiType.GetSQLFieldPrimaryKey(LPrimaryKeyName);

  Self.Append(' WHERE ').Append(LPrimaryKeyName).Append(' = :').Append(LPrimaryKeyName);
end;

{ TSQLCriteriaSelectBuilder<T> }

procedure TSQLCriteriaSelectBuilder<T>.Build;
begin
  inherited Build;
end;

procedure TSQLCriteriaSelectBuilder<T>.Build(const ATemplate: T);
var
  LIndex: Integer;
  LField: TRttiField;
  LFieldName: string;
begin
  inherited Build;

  LIndex := Self.Length;

  for LField in Self.RttiType.GetFields do
    if LField.IsSQLField and (not LField.IsSQLDefaultValue(Pointer(ATemplate))) then
      if LField.GetSQLFieldInfo(LFieldName) then
        Self.Append(' AND ').Append(LFieldName).Append(' = :').Append(LFieldName);

  if Self.Length > LIndex then
    Self.Remove(LIndex, 5).Insert(LIndex, ' WHERE ');
end;

end.
