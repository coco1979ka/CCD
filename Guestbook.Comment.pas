unit Guestbook.Comment;

interface

uses
  Generics.Collections;

type
  TComment = class
  private
    FContent: string;
  public
    constructor Create(Content: string);
    function IsEmpty: Boolean;
    function ContainsSpam: Boolean;
    function IsUnicum(Comments: TList<TComment>): Boolean;
    function GetContent: string;
  end;

implementation

uses
  SysUtils;

{ TComment }

function TComment.ContainsSpam: Boolean;
begin
  Result := Pos('Viagra', FContent) > 0;
end;

constructor TComment.Create(Content: string);
begin
  FContent := Content;
end;

function TComment.GetContent: string;
begin
  Result := FContent;
end;

function TComment.IsEmpty: Boolean;
begin
  Result := Length(FContent) > 0;
end;

function TComment.IsUnicum(Comments: TList<TComment>): Boolean;
var
  Comment: TComment;
begin
  Result := True;
  for Comment in Comments do
  begin
    if CompareText(Comment.GetContent, FContent) = 0 then
      Exit(False);
  end;
end;

end.
