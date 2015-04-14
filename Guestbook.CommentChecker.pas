unit Guestbook.CommentChecker;

interface

uses
  Generics.Collections,
  Guestbook.Comment;

type
  TCommentChecker = class
  private
    FExistingComments: TList<TComment>;
  public
    constructor Create(ExistingComments: TList<TComment>);
    function IsValid(Comment: TComment): Boolean;
  end;

implementation

{ TCommentChecker }

constructor TCommentChecker.Create(ExistingComments: TList<TComment>);
begin
  FExistingComments := ExistingComments;
end;

function TCommentChecker.IsValid(Comment: TComment): Boolean;
begin
  if Comment.IsEmpty then
    Exit(False);
  if Comment.ContainsSpam then
    Exit(False);
  if not Comment.IsUnicum(FExistingComments) then
    Exit(False);
  Exit(True);
end;

end.
