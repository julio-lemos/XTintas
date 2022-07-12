// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:xtintas/infra/http/http_client.dart';
import 'package:xtintas/modules/profile/adapters/adapters.dart';
import 'package:xtintas/modules/profile/domain/entities/profile_entity.dart';

import '../../domain/usecases/usecases.dart';

class RemoteProfileUseCase implements IProfileUseCase {
  final IHttpClient httpClient;
  final ProfileAdapters adapter;

  RemoteProfileUseCase({
    required this.httpClient,
    required this.adapter,
  });

  @override
  Future<ProfileEntity> getProfile() async {
    final response = await httpClient
        .get("https://62968cc557b625860610144c.mockapi.io/profile");

    return adapter.fromMap(response);
  }
}
