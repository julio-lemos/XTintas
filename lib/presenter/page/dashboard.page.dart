import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Modular.to.navigate('/dashboard/store');
        break;
      case 2:
        Modular.to.navigate("/dashboard/profile");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _getBg(constraints),
            const RouterOutlet(),
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
                    color: _selectedIndex == 2 ? const Color(0xff5B4DA7) : const Color(0xffa4a4a4),
                  ),
                ),
                label: "Perfil",
              ),
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
