import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:yemek_siparis_uygulamasi/entities/food_in_shoppingcart.dart';
import 'package:yemek_siparis_uygulamasi/entities/responses/food_in_shoppingcard_response.dart';
import 'package:yemek_siparis_uygulamasi/repository/endpoints.dart';

class FoodInShoppingCardDaoRepository {
  Future<void> addFoodToShoppingCart(
      String orderedFoodName,
      String orderedFoodImageName,
      String orderedFoodPrice,
      String orderQuantity,
      String userName) async {
    String uri = EndPoints.domain + EndPoints.addFoodToShoppingCart;
    var url = Uri.parse(uri);

    var requestBody = {
      "yemek_adi": orderedFoodName,
      "yemek_resim_adi": orderedFoodImageName,
      "yemek_fiyat": orderedFoodPrice,
      "yemek_siparis_adet": orderQuantity,
      "kullanici_adi": userName
    };
    var response = await http.post(url, body: requestBody);
  }

  Future<List<FoodInShoppingCart>> getAllFoodsInShoppingCart(
      String userName) async {
    String uri = EndPoints.domain + EndPoints.getAllFoodsInShoppingCart;
    var url = Uri.parse(uri);

    var requestBody = {"kullanici_adi": userName};
    var response = await http.post(url, body: requestBody);

    try {
      var responseBody =
          FoodInShoppingCardResponse.fromJson(json.decode(response.body));
      var foodsInShoppingCard = responseBody.foodsInShoppingCard;

      return foodsInShoppingCard;
    } catch (e) {
      return <FoodInShoppingCart>[];
    }
  }

  Future<void> removeFoodFromShoppingCart(String id, String userName) async {
    String uri = EndPoints.domain + EndPoints.removeFoodFromShoppingCart;
    var url = Uri.parse(uri);

    var requestBody = {"sepet_yemek_id": id, "kullanici_adi": userName};
    var response = await http.post(url, body: requestBody);
  }
}
