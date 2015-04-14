unit Geometry.Line;

interface

uses
  Geometry.Point;

type
  TLine = class
  public
    StartPoint: TPoint;
    EndPoint: TPoint;
    function GetLength: Double;
  end;

implementation

{ TLine }

function TLine.GetLength: Double;
begin
  Result := Sqrt(Sqr(StartPoint.GetX - EndPoint.GetX) + Sqr(StartPoint.GetY - EndPoint.GetY));
end;

end.
