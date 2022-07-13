import 'package:dartz/dartz.dart';

import '../../../../infra/http/http.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../errors/errors.dart';

class RemoteAddAccountUseCase implements IAddAccountUseCase {
  final IHttpClient httpClient;

  RemoteAddAccountUseCase({
    required this.httpClient,
  });

  @override
  Future<Either<ISignUpException, AddAccountEntity>> createAccount(AddAccountParams params) async {
    if (params.password != params.repeatPassword) {
      return left(DivergentsPasswords("Senhas divergentes, favor conferir"));
    }

    try {
      final response = await httpClient.post("https://62968cc557b625860610144c.mockapi.io/user",
          body: {"name": params.name, "email": params.email, "password": params.password});

      return right(
        AddAccountEntity(
            name: response["name"],
            email: response["email"],
            password: response["password"],
            id: response["id"]),
      );
    } on HttpError catch (err, stackTrace) {
      return left(
        UnexpectedError(
            "Um erro aconteceu ao criar conta, tente novamente mais tarde.", stackTrace),
      );
    }
  }
}
