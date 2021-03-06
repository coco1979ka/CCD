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
  StrUtils,
  SysUtils;

{ TComment }

function TComment.ContainsSpam: Boolean;
begin
  Result := ContainsText(FContent, 'Viagra');
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
  Result := (FContent = '');
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
