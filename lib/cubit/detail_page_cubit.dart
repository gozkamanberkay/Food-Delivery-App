import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yemek_siparis_uygulamasi/repository/food_in_shoppingcart_dao_repo.dart';

class DetailPageCubit extends Cubit<void> {
  DetailPageCubit() : super(0);

  var repository = FoodInShoppingCardDaoRepository();

  Future<void> addFoodToShoppingCart(
      String orderedFoodName,
      String orderedFoodImageName,
      String orderedFoodPrice,
      String orderQuantity,
      String userName) async {
    await repository.addFoodToShoppingCart(orderedFoodName,
        orderedFoodImageName, orderedFoodPrice, orderQuantity, userName);
  }
}
