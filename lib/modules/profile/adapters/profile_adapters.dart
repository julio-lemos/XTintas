import 'package:xtintas/modules/profile/domain/entities/profile_entity.dart';

class ProfileAdapters {
  ProfileEntity fromMap(Map<String, dynamic> map) {
    return ProfileEntity(
      email: map["email"],
      name: map["name"],
      imgProfile: map["avatar"],
    );
  }
}
