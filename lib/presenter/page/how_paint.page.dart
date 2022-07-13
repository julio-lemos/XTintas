import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class HowPaint extends StatelessWidget {
  const HowPaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        title: const Text(
          "Como pintar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff5B4DA7),
            size: 30,
          ),
          onPressed: () {
            Modular.to.navigate("/dashboard/store");
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              _getBg(constraints),
              ListView(
                children: [
                  const SizedBox(height: 32),
                  _lineHowPaint(
                    step: 1,
                    title: "Prepare a tinta",
                    pathAsset: "assets/images/paint.svg",
                    description: "Abra a tinta e coloque na caçamba",
                  ),
                  const SizedBox(height: 48),
                  _lineHowPaint(
                    step: 2,
                    title: "Primeira demão",
                    pathAsset: "assets/images/brush.svg",
                    description:
                        "Aplique a tinta na parede em N como mostrado no vídeo para melhor aproveitamento",
                  ),
                  const SizedBox(height: 32),
                  const Icon(
                    Icons.arrow_downward_rounded,
                    color: Color(0xffDADADA),
                    size: 84,
                  ),
                  const SizedBox(height: 32),
                  _lineHowPaint(
                    step: 3,
                    title: "Repasse a tinta",
                    pathAsset: "assets/images/brush.svg",
                    description:
                        "Passe mais uma camada de tinta por cima da parede para reduzir imperfeições",
                  ),
                  const SizedBox(height: 64),
                  Column(
                    children: [
                      SvgPicture.asset("assets/images/time.svg"),
                      const SizedBox(height: 16),
                      const Text(
                        "Aguarde 2 horas",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      )
                    ],
                  ),
                  const SizedBox(height: 64),
                  _lineHowPaint(
                    step: 5,
                    title: "Segunda demão",
                    pathAsset: "assets/images/brush.svg",
                    description:
                        "Aplique a tinta na parede em N como mostrado no vídeo para melhor aproveitamento",
                  ),
                  const SizedBox(height: 48),
                  _lineHowPaint(
                    step: 6,
                    title: "Repasse a tinta",
                    pathAsset: "assets/images/brush.svg",
                    description:
                        "Passe mais uma camada de tinta por cima da parede para reduzir imperfeições",
                  ),
                  const SizedBox(height: 64),
                  Column(
                    children: [
                      SvgPicture.asset("assets/images/time.svg"),
                      const SizedBox(height: 16),
                      const Text(
                        "Aguarde 2 horas",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      )
                    ],
                  ),
                  const SizedBox(height: 64),
                  _lineHowPaint(
                    step: 7,
                    title: "Acabou",
                    description: "Sua parede está pronta",
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ],
          );
        },
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

Widget _lineHowPaint(
    {required int step, required String title, String? pathAsset, required String description}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              step.toString(),
              style: const TextStyle(
                color: Color(0xff5B4DA7),
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xff161616),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(width: 32),
            if (pathAsset != null) SvgPicture.asset(pathAsset)
          ],
        ),
        const SizedBox(height: 16),
        Text(
          description,
        )
      ],
    ),
  );
}
