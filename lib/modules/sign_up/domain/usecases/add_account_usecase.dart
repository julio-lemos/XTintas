import 'package:dartz/dartz.dart';
import 'package:xtintas/modules/sign_up/data/errors/signup_errors.dart';

import '../entities/entities.dart';

abstract class IAddAccountUseCase {
  Future<Either<ISignUpException, AddAccountEntity>> createAccount(AddAccountParams params);
}

class AddAccountParams {
  final String name;
  final String email;
  final String password;
  final String repeatPassword;

  AddAccountParams({
    required this.name,
    required this.email,
    required this.password,
    required this.repeatPassword,
  });
}
