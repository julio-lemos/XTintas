import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../infra/http/http.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../errors/errors.dart';

class RemoteAuthenticationUseCase implements IAuthenticationUseCase {
  final IHttpClient httpClient;

  RemoteAuthenticationUseCase({required this.httpClient});

  @override
  Future<Either<ISignInException, AuthEntity>> auth(AuthParams params) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await httpClient.get(
        "https://62968cc557b625860610144c.mockapi.io/login",
      );

      await prefs.setString('authToken', response["access-token"]);

      return right(AuthEntity(token: response["access-token"]));
    } on HttpError catch (err, stackTrace) {
      return left(
          UnexpectedError("Um erro aconteceu ao logar, tente novamente mais tarde.", stackTrace));
    }
  }
}
