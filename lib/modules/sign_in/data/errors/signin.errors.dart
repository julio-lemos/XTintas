abstract class ISignInException {
  final String message;
  final StackTrace? stackTrace;

  ISignInException(this.message, [this.stackTrace]);
}

class UnexpectedError extends ISignInException {
  UnexpectedError(super.message, [super.stackTrace]);
}
