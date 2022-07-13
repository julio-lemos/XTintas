class PaintCartEntity {
  int quantity;
  Object paint;
  String id;
  String name;
  String image;
  int price;
  List<dynamic> benefits;

  PaintCartEntity(
      {required this.quantity,
      required this.paint,
      required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.benefits});
}
