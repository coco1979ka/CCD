unit TestCommentChecker;
{

  Delphi DUnit-Testfall
  ----------------------
  Diese Unit enthält ein Skeleton einer Testfallklasse, das vom Experten für Testfälle erzeugt wurde.
  Ändern Sie den erzeugten Code so, dass er die Methoden korrekt einrichtet und aus der 
  getesteten Unit aufruft.

}

interface

uses
  TestFramework,
  Generics.Collections,
  Guestbook.Comment,
  Guestbook.CommentChecker;

type
  // Testmethoden für Klasse TCommentChecker

  TestTCommentChecker = class(TTestCase)
  strict private
    FExistingComments: TObjectList<TComment>;
    FCommentChecker: TCommentChecker;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure EmptyCommentsShouldBeInvalid;
    procedure SpamCommentsShouldBeInvalid;
    procedure DuplicatedCommentsShouldBeInvalid;
    procedure ValidCommentShouldBeAccepted;
  end;

implementation

const
  ExistingCommentContent = 'Hallo Welt!';

procedure TestTCommentChecker.DuplicatedCommentsShouldBeInvalid;
var
  Comment: TComment;
  IsValid: Boolean;
begin
  Comment := TComment.Create(ExistingCommentContent);
  IsValid := FCommentChecker.IsValid(Comment);
  CheckEquals(False, IsValid);
end;

procedure TestTCommentChecker.EmptyCommentsShouldBeInvalid;
var
  Comment: TComment;
  IsValid: Boolean;
begin
  Comment := TComment.Create('');
  IsValid := FCommentChecker.IsValid(Comment);
  CheckEquals(False, IsValid);
end;

procedure TestTCommentChecker.SetUp;
begin
  FExistingComments := TObjectList<TComment>.Create;
  FExistingComments.Add(TComment.Create(ExistingCommentContent));
  FCommentChecker := TCommentChecker.Create(FExistingComments);
end;

procedure TestTCommentChecker.SpamCommentsShouldBeInvalid;
var
  Comment: TComment;
  IsValid: Boolean;
begin
  Comment := TComment.Create('New Viagra in the House!');
  IsValid := FCommentChecker.IsValid(Comment);
  CheckEquals(False, IsValid);
end;

procedure TestTCommentChecker.TearDown;
begin
  FExistingComments.Free;
  FCommentChecker.Free;
  FCommentChecker := nil;
end;

procedure TestTCommentChecker.ValidCommentShouldBeAccepted;
var
  Comment: TComment;
  IsValid: Boolean;
begin
  Comment := TComment.Create('Ein gültiger Kommentar');
  IsValid := FCommentChecker.IsValid(Comment);
  CheckEquals(True, IsValid);
end;

initialization
  // Alle Testfälle beim Testprogramm registrieren
  RegisterTest(TestTCommentChecker.Suite);
end.

