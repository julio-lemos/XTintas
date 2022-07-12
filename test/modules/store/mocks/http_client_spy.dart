import 'package:mocktail/mocktail.dart';
import 'package:xtintas/infra/http/http.dart';

class HttpClientSpy extends Mock implements IHttpClient {
  When mockRequestCall() => when(() => get(any()));

  void mockSuccess() => mockRequestCall().thenAnswer((_) async => {
        "count": 3,
        "data": [
          {
            "name": "Tinta Suvinil Família Protegida",
            "image":
                "https://escolha-mais-facil-images.s3.us-east-1.amazonaws.com/converted-images/Suvinil_Classica_0,8l.jpg",
            "price": 70,
            "benefits": [
              {"name": "Fácil de aplicar", "icon": "paint-brush"},
              {"name": "Não deixa cheiro", "icon": "weather"},
              {"name": "É só abrir, mexer e pintar", "icon": "paint-bucket"}
            ]
          },
          {
            "name": "Tinta Suvinil Máximo Desempenho",
            "image":
                "https://escolha-mais-facil-images.s3.us-east-1.amazonaws.com/converted-images/Suvinil_Brilho_Extra_3,6_1.jpg",
            "price": 80,
            "benefits": [
              {"name": "Pintura perfeita", "icon": "paint-brush"},
              {"name": "Evita fungos e mofo", "icon": "virus"},
              {"name": "É só abrir, mexer e pintar", "icon": "paint-bucket"}
            ]
          },
          {
            "name": "Tinta Suvinil Limpeza Total",
            "image":
                "https://escolha-mais-facil-images.s3.us-east-1.amazonaws.com/converted-images/Suvinil_Textura_Efeito_Rustico_15,873_1.jpg",
            "price": 75,
            "benefits": [
              {"name": "Fácil de limpar", "icon": "drop"},
              {"name": "Não deixa cheiro", "icon": "weather"},
              {"name": "Fácil de aplicar", "icon": "paint-brush"}
            ]
          }
        ]
      });
  void mockFail(HttpError errorCode) => mockRequestCall().thenThrow(errorCode);
}
