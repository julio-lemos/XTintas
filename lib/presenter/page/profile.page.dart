import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xtintas/modules/profile/domain/entities/profile_entity.dart';
import 'package:xtintas/modules/profile/domain/usecases/profile_usecase.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _getBg(constraints),
            _showProfile(),
          ],
        );
      }),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SvgPicture.asset(
                      "assets/images/shop.svg",
                      width: 25,
                      height: 25,
                      color:
                          _selectedIndex == 0 ? const Color(0xff5B4DA7) : const Color(0xffa4a4a4),
                    ),
                  ),
                  label: "Loja"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SvgPicture.asset(
                      "assets/images/cart.svg",
                      width: 25,
                      height: 25,
                      color:
                          _selectedIndex == 1 ? const Color(0xff5B4DA7) : const Color(0xffa4a4a4),
                    ),
                  ),
                  label: "Carrinho"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SvgPicture.asset(
                      "assets/images/person.svg",
                      width: 25,
                      height: 25,
                      color:
                          _selectedIndex == 2 ? const Color(0xff5B4DA7) : const Color(0xffa4a4a4),
                    ),
                  ),
                  label: "Perfil"),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xff5B4DA7),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
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

Widget _getBg(BoxConstraints constraints) => Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-1.8, -0.4), // near the top right
              radius: 0.75,
              colors: <Color>[
                Color(0xFF5B4DA7), // yellow sun
                Color(0xFFF2F2F2), // blue sky
              ],
              stops: <double>[0.0, 1],
            ),
          ),
          width: constraints.maxWidth / 2,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(1.8, 0.4), // near the top right
              radius: 0.75,
              colors: <Color>[
                Color(0xFF5B4DA7), // yellow sun
                Color(0xFFF2F2F2), // blue sky
              ],
              stops: <double>[0.0, 1],
            ),
          ),
          width: constraints.maxWidth / 2,
        ),
      ],
    );
