import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/profile/domain/entities/profile_entity.dart';
import '../../modules/profile/domain/usecases/usecases.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return _showProfile();
  }
}

Widget _showProfile() {
  final usecase = Modular.get<IProfileUseCase>();

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 32,
    ),
    child: Column(
      children: [
        const Text(
          "Perfil",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 130,
          child: Card(
            color: const Color(0xffEAEAEA),
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color(0x40404026),
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<ProfileEntity>(
                  initialData: null,
                  future: usecase.getProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                      final profileData = snapshot.data;

                      return Row(
                        children: [
                          CircleAvatar(
                            minRadius: 30,
                            maxRadius: 30,
                            backgroundImage: NetworkImage(profileData!.imgProfile),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            profileData.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Color(0xff5B4DA7),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();

              prefs.remove('authToken');

              Modular.to.navigate('/signin');
            },
            style: ElevatedButton.styleFrom(
                primary: const Color(0xffEAEAEA),
                side: const BorderSide(
                  color: Color(0x40404026),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text(
              "Fazer logout",
              style: TextStyle(color: Color(0xff5B4DA7), fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    ),
  );
}
