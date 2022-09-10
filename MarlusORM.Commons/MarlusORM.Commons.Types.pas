unit MarlusORM.Commons.Types;

{$SCOPEDENUMS ON}

interface

type

  TSQLCase = (
    Default,
    Lower,
    Upper,
    Camel,
    Pascal,
    Snake,
    ScreamingSnake
  );

  TSQLDatabase = (
    Default,
    Firebird
  );

  TSQLSort = (
    Default,
    Never,
    Always
  );

  TSQLOrder = (
    Default,
    Up,
    Down
  );

implementation

end.
