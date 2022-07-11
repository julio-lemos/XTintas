abstract class ISignUpException {
  final String message;
  final StackTrace? stackTrace;

  ISignUpException(this.message, [this.stackTrace]);
}

class DivergentsPasswords extends ISignUpException {
  DivergentsPasswords(super.message);
}

class UnexpectedError extends ISignUpException {
  UnexpectedError(super.message, [super.stackTrace]);
}
