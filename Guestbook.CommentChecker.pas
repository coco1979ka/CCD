unit Guestbook.CommentChecker;

interface

uses
  Generics.Collections,
  Guestbook.Comment;

type
  ICheckedAspect = interface
  ['{B8570EB4-1B7F-45D0-AF94-F21D13B9D317}']
    function IsPositiveFor(Comment: TComment): Boolean;
  end;

  TCommentChecker = class
  private
    FChecks: TList<ICheckedAspect>;
    FExistingComments: TList<TComment>;
  public
    constructor Create(ExistingComments: TList<TComment>);
    destructor Destroy; override;
    function IsValid(Comment: TComment): Boolean;
  end;

  TIsDuplicatedCheck = class(TInterfacedObject, ICheckedAspect)
  private
    FExistingComments: TList<TComment>;
  public
    constructor Create(ExistingComments: TList<TComment>);
    function IsPositiveFor(Comment: TComment): Boolean;
  end;

  TIsEmptyCheck = class(TInterfacedObject, ICheckedAspect)
  public
    function IsPositiveFor(Comment: TComment): Boolean;
  end;

  TContainsSpamCheck = class(TInterfacedObject, ICheckedAspect)
  public
    function IsPositiveFor(Comment: TComment): Boolean;
  end;

implementation

var
  Comments: TList<TComment>;
  Aspects: TList<ICheckedAspect>;

{ TCommentChecker }

constructor TCommentChecker.Create(ExistingComments: TList<TComment>);
begin
  FChecks := TList<ICheckedAspect>.Create;
  FChecks.Add(TIsDuplicatedCheck.Create(ExistingComments));
  FChecks.Add(TIsEmptyCheck.Create);
  FChecks.Add(TContainsSpamCheck.Create);
  FExistingComments := ExistingComments;
end;

destructor TCommentChecker.Destroy;
begin
  FChecks.Free;
  inherited;
end;

function TCommentChecker.IsValid(Comment: TComment): Boolean;
var
  Check: ICheckedAspect;
begin
  for Check in FChecks do
    if Check.IsPositiveFor(Comment) then Exit(False);
  Exit(True);
end;

{ TIsDuplicatedCheck }

constructor TIsDuplicatedCheck.Create(ExistingComments: TList<TComment>);
begin
  FExistingComments := ExistingComments;
end;

function TIsDuplicatedCheck.IsPositiveFor(Comment: TComment): Boolean;
begin
  Result := not Comment.IsUnicum(FExistingComments);
end;

{ TIsEmptyCheck }

function TIsEmptyCheck.IsPositiveFor(Comment: TComment): Boolean;
begin
  Result := Comment.IsEmpty;
end;

{ TContainsSpamCheck }

function TContainsSpamCheck.IsPositiveFor(Comment: TComment): Boolean;
begin
  Result := Comment.ContainsSpam;
end;

end.
