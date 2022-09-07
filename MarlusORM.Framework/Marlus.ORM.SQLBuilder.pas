unit Marlus.ORM.SQLBuilder;

interface

uses
  System.SysUtils,
  System.Rtti;

type

  TSQLBuilder<T: class, constructor> = class(TStringBuilder)
  protected
    RttiContext: TRttiContext;
    RttiType: TRttiType;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Build; virtual;
  end;

implementation

uses
  Marlus.ORM.Rtti;

{ TSQLBuilder<T> }

constructor TSQLBuilder<T>.Create;
begin
  inherited Create;
  Self.RttiContext := TRttiContext.Create;
  Self.RttiType := Self.RttiContext.GetType(T.ClassInfo);
end;

destructor TSQLBuilder<T>.Destroy;
begin
  Self.RttiType := nil;
  inherited Destroy;
end;

procedure TSQLBuilder<T>.Build;
begin
  Self.Clear;

  if not Self.RttiType.IsSQLEntity then
    raise ENotSupportedException.CreateFmt('Class type "%s" is not supported', [Self.RttiType.QualifiedName]);
end;

end.
