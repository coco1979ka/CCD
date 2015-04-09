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
  {TODO: Implement}
end;

end.
