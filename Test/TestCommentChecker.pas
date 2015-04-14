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
  TestFramework, Guestbook.Comment, Guestbook.CommentChecker;

type
  // Testmethoden für Klasse TCommentChecker

  TestTCommentChecker = class(TTestCase)
  strict private
    FCommentChecker: TCommentChecker;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure EmptyCommentsShouldBeInvalid;
    procedure SpamCommentsShouldBeInvalid;
  end;

implementation

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
  FCommentChecker := TCommentChecker.Create;
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
  FCommentChecker.Free;
  FCommentChecker := nil;
end;

initialization
  // Alle Testfälle beim Testprogramm registrieren
  RegisterTest(TestTCommentChecker.Suite);
end.

