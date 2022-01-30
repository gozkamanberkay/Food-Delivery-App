import 'package:yemek_siparis_uygulamasi/entities/food.dart';

class FoodResponse {
  List<Food> foods;
  int success;

  FoodResponse({
    required this.foods,
    required this.success,
  });

  factory FoodResponse.fromJson(Map<String, dynamic> json) {
    var jsonDataObjectArray = json["yemekler"] as List;

    List<Food> foods = jsonDataObjectArray
        .map((jsonDataObject) => Food.fromJson(jsonDataObject))
        .toList();
    int success = json["success"] as int;

    return FoodResponse(
      foods: foods,
      success: success,
    );
  }
}
