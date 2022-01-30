class Food {
  String id;
  String name;
  String imageName;
  String price;

  Food({
    required this.id,
    required this.name,
    required this.imageName,
    required this.price,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    String id = json["yemek_id"] as String;
    String name = json["yemek_adi"] as String;
    String imageName = json["yemek_resim_adi"] as String;
    String price = json["yemek_fiyat"] as String;

    return Food(id: id, name: name, imageName: imageName, price: price);
  }
}
