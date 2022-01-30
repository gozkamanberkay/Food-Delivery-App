class FoodInShoppingCart {
  String id;
  String orderedFoodName;
  String orderedFoodImageName;
  String orderedFoodPrice;
  String orderedQuantity;
  String userName;

  FoodInShoppingCart({
    required this.id,
    required this.orderedFoodName,
    required this.orderedFoodImageName,
    required this.orderedFoodPrice,
    required this.orderedQuantity,
    required this.userName,
  });

  factory FoodInShoppingCart.fromJson(Map<String, dynamic> json) {
    String id = json["sepet_yemek_id"] as String;
    String orderedFoodName = json["yemek_adi"] as String;
    String orderedFoodImageName = json["yemek_resim_adi"] as String;
    String orderedFoodPrice = json["yemek_fiyat"] as String;
    String orderedQuantity = json["yemek_siparis_adet"] as String;
    String userName = json["kullanici_adi"] as String;

    return FoodInShoppingCart(
      id: id,
      orderedFoodName: orderedFoodName,
      orderedFoodImageName: orderedFoodImageName,
      orderedFoodPrice: orderedFoodPrice,
      orderedQuantity: orderedQuantity,
      userName: userName,
    );
  }
}
