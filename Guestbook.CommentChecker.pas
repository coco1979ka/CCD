unit Guestbook.CommentChecker;

interface

uses
  Guestbook.Comment;

type
  TCommentChecker = class
  public
    function IsValid(Comment: TComment): Boolean;
  end;

implementation

{ TCommentChecker }

function TCommentChecker.IsValid(Comment: TComment): Boolean;
begin
  if Comment.IsEmpty then
    Exit(False);
  Exit(True);
end;

end.
