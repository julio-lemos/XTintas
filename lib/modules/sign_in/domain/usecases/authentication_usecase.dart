import 'package:dartz/dartz.dart';
import 'package:xtintas/modules/sign_in/domain/entities/auth_entity.dart';

import '../../data/errors/errors.dart';

abstract class IAuthenticationUseCase {
  Future<Either<ISignInException, AuthEntity>> auth(AuthParams params);
}

class AuthParams {
  final String email;
  final String password;

  AuthParams({required this.email, required this.password});
}
