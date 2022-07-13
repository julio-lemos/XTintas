import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xtintas/modules/cart/domain/usecases/cart_usecase.dart';
import 'package:xtintas/modules/store/domain/entities/store_entity.dart';
import 'package:xtintas/modules/store/domain/usecases/store_usecase.dart';

import '../../modules/store/data/errors/store_errors.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          children: [
            const Text(
              "Opções de tintas",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<Either<IStoreException, StoreEntity>>(
                initialData: null,
                future: Modular.get<IStoreUseCase>().getPaints(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                    return snapshot.data!.fold((l) {
                      return const Text("Error");
                    }, (r) {
                      return CarouselSlider(
                        items: r.paints.map((element) {
                          return Builder(
                            builder: (context) {
                              return ListView(
                                children: [
                                  SizedBox(
                                    height: constrains.maxHeight / 2.2,
                                    child: Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  if (r.paints[0].name != element.name)
                                                    const Icon(
                                                      Icons.arrow_back_outlined,
                                                      color: Color(0xffDADADA),
                                                      size: 30,
                                                    ),
                                                  if (!(r.paints[0].name != element.name))
                                                    const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: Image.network(element.imgUrl),
                                                        ),
                                                        Text(
                                                          element.name,
                                                          style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  if (r.paints[r.paints.length - 1].name !=
                                                      element.name)
                                                    const Icon(
                                                      Icons.arrow_forward_outlined,
                                                      color: Color(0xffDADADA),
                                                      size: 30,
                                                    ),
                                                  if (!(r.paints[r.paints.length - 1].name !=
                                                      element.name))
                                                    const SizedBox(width: 16),
                                                  const SizedBox(height: 16),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xff5B4DA7),
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(100),
                                                        bottomLeft: Radius.circular(100)),
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Modular.to
                                                          .pushReplacementNamed("/store/how_paint");
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: 11.0,
                                                        horizontal: 16,
                                                      ),
                                                      child: Text(
                                                        "Como pintar",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xffA4A4A4),
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(100),
                                                        bottomRight: Radius.circular(100)),
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 11.0,
                                                      horizontal: 16,
                                                    ),
                                                    child: Text(
                                                      "Tirar dúvidas",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Diferenciais"),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              SvgPicture.asset("assets/images/brush.svg"),
                                              const SizedBox(width: 16),
                                              Text(
                                                element.benefits[0]["name"],
                                                style: const TextStyle(fontWeight: FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              SvgPicture.asset("assets/images/wind.svg"),
                                              const SizedBox(width: 16),
                                              Text(
                                                element.benefits[1]["name"],
                                                style: const TextStyle(fontWeight: FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              SvgPicture.asset("assets/images/paint.svg"),
                                              const SizedBox(width: 16),
                                              Text(
                                                element.benefits[2]["name"],
                                                style: const TextStyle(fontWeight: FontWeight.w300),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await Modular.get<ICartUseCases>().addInCart(element);

                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Adicionado ao carrinho com sucesso.",
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color(0xff5B4DA7),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100))),
                                      child: const Text("Adicionar ao carrinho"),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                            height: constrains.maxHeight / 1.24, enableInfiniteScroll: false),
                      );
                    });
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        color: Color(0xff5B4DA7),
                      ),
                    ],
                  );
                })
          ],
        ),
      );
    });
  }
}
