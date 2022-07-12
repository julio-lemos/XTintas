import '../entities/entities.dart';

abstract class IProfileUseCase {
  Future<ProfileEntity> getProfile();
}
