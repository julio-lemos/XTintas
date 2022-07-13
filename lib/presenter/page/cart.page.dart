import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:xtintas/modules/cart/domain/usecases/cart_usecase.dart';

import '../../modules/cart/domain/entities/entities.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text(
              "Carrinho",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FutureBuilder<List<PaintCartEntity>>(
              initialData: null,
              future: Modular.get<ICartUseCases>().getCart(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                  if (snapshot.data!.isEmpty) {
                    return const Text(
                      "Carrinho vazio! Visite nossa loja e adquira alguns produtos.",
                      textAlign: TextAlign.center,
                    );
                  }

                  return SizedBox(
                    height: constrains.maxHeight,
                    child: Column(
                      children: [
                        SizedBox(
                          height: constrains.maxHeight / 1.47,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data;

                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 70,
                                        child: Image.network(data![index].image),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index].name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 8, vertical: 2),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(0xffA4A4A4))),
                                                  child: Text(
                                                    '${data[index].quantity} un.',
                                                    style: const TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                                Text(
                                                  NumberFormat.currency(
                                                          locale: "pt_BR", symbol: "R\$")
                                                      .format(data[index].price),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff5B4DA7),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100))),
                              onPressed: () async {
                                await Modular.get<ICartUseCases>()
                                    .deleteInCart(snapshot.data!.length);

                                setState(() {});
                              },
                              child: Text("Confirmar compra")),
                        )
                      ],
                    ),
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
              },
            ),
          ],
        ),
      );
    });
  }
}
