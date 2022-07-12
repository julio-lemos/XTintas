abstract class IStoreException {
  final String message;
  final StackTrace? stackTrace;

  IStoreException(this.message, [this.stackTrace]);
}

class UnexpectedError extends IStoreException {
  UnexpectedError(super.message, [super.stackTrace]);
}
