import 'package:dartz/dartz.dart';

import '../../../../infra/http/http.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../errors/errors.dart';

class RemoteAuthenticationUseCase implements IAuthenticationUseCase {
  final IHttpClient httpClient;
  final String url;

  RemoteAuthenticationUseCase({required this.httpClient, required this.url});

  @override
  Future<Either<ISignInException, AuthEntity>> auth(AuthParams params) async {
    try {
      final response = await httpClient.get(url);
      return right(AuthEntity(token: response["access_token"]));
    } on HttpError catch (err, stackTrace) {
      return left(
          UnexpectedError("Um erro aconteceu ao logar, tente novamente mais tarde.", stackTrace));
    }
  }
}
