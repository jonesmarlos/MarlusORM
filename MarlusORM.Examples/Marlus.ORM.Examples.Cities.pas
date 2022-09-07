unit Marlus.ORM.Examples.Cities;

interface

uses
  System.Classes,
  Marlus.ORM.Attributes;

type

  [SQLEntity('CITIES')]
  TCity = class
  strict private
    FId: Integer;

    FName: string;

    FFoundation: TDate;

    [SQLField('PCI')]
    FPerCapitaIncome: Currency;
  public
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property Foundation: TDate read FFoundation write FFoundation;
    property PerCapitaIncome: Currency read FPerCapitaIncome write FPerCapitaIncome;
  end;

implementation

end.
