import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xtintas/modules/sign_in/domain/usecases/usecases.dart';

import '../../modules/sign_in/data/errors/errors.dart';
import '../ui/ui.dart';

class SignInPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();

  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usecase = Modular.get<IAuthenticationUseCase>();

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                  const Color(0xFF5B4DA7).withOpacity(0.8),
                  const Color(0xFF5B4DA7),
                ]),
              ),
            ),
            Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/bucket.svg"),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "XTintas",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            )
                          ],
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 64),
                          child: Container(
                            height: double.infinity,
                          ),
                        ),
                        const Text(
                          "Entrar na plataforma",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 32),
                        XTextFieldWidget(
                          labelText: "E-mail",
                          hintText: "fernandasilva@onu.com.br",
                          controller: emailInput,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }

                            if (!EmailValidator.validate(value)) {
                              return 'Email Inválido';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        XPasswordField(
                          labelText: "Senha",
                          hintText: "********",
                          controller: passwordInput,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 46),
                          child: Container(
                            height: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.1),
                          child: XButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final account = AuthParams(
                                  email: emailInput.text,
                                  password: passwordInput.text,
                                );

                                final register = await usecase.auth(account);

                                register.fold((l) {
                                  if (l is UnexpectedError) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text(
                                      "Houve um problema ao entrar.\nTente novamente mais tarde.",
                                    )));
                                  }
                                }, (r) {
                                  Modular.to.navigate("/dashboard");
                                });
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Color(0xFF5B4DA7),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => Modular.to.pushNamed("/signup"),
                          child: Text(
                            "Criar conta",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.61),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
