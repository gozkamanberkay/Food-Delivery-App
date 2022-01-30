import 'package:yemek_siparis_uygulamasi/entities/food_in_shoppingcart.dart';

class FoodInShoppingCardResponse {
  List<FoodInShoppingCart> foodsInShoppingCard;
  int success;

  FoodInShoppingCardResponse({
    required this.foodsInShoppingCard,
    required this.success,
  });

  factory FoodInShoppingCardResponse.fromJson(Map<String, dynamic> json) {
    var jsonDataObjectArray = json["sepet_yemekler"] as List;

    List<FoodInShoppingCart> foodsInShoppingCard = jsonDataObjectArray
        .map((jsonDataObject) => FoodInShoppingCart.fromJson(jsonDataObject))
        .toList();
    int success = json["success"] as int;

    return FoodInShoppingCardResponse(
      foodsInShoppingCard: foodsInShoppingCard,
      success: success,
    );
  }
}
