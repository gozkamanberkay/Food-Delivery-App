import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yemek_siparis_uygulamasi/cubit/shoppingcart_page_cubit.dart';
import 'package:yemek_siparis_uygulamasi/entities/food_in_shoppingcart.dart';
import 'package:yemek_siparis_uygulamasi/entities/user.dart';
import 'package:yemek_siparis_uygulamasi/repository/endpoints.dart';
import 'package:yemek_siparis_uygulamasi/views/shipping_information_page.dart';

class ShoppingCartPage extends StatefulWidget {
  static const String routeName = '/ShoppingCart';

  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late User user;
  int totalPriceOfFoodsInShoppingCart = 0;

  @override
  void initState() {
    super.initState();
  }

  int getTotalPriceOfFoodsInShoppingCart(
      List<FoodInShoppingCart> foodsInShoppingCard) {
    int subTotal = 0;

    for (var food in foodsInShoppingCard) {
      subTotal = subTotal +
          (int.parse(food.orderedQuantity) * int.parse(food.orderedFoodPrice));
    }
    int totalPriceOfFoodsInShoppingCart = subTotal;

    return totalPriceOfFoodsInShoppingCart;
  }

  @override
  Widget build(BuildContext context) {
    var userArgument = ModalRoute.of(context)!.settings.arguments as User;

    if (ModalRoute.of(context)!.isCurrent) {
      user = userArgument;
    }

    context.read<ShoppingCartPageCubit>().getAllFoodsInShoppingCart(user.name);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "SEPETİM",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
            fontFamily: "Dongle",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 16.0, right: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<ShoppingCartPageCubit, List<FoodInShoppingCart>>(
                  builder: (context, foodsInShoppingCart) {
                if (foodsInShoppingCart.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: foodsInShoppingCart.length,
                      itemBuilder: (context, index) {
                        var foodInShoppingCart = foodsInShoppingCart[index];
                        int orderedQuantity =
                            int.parse(foodInShoppingCart.orderedQuantity);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Card(
                            elevation: 6.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: 0.0,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                      child: Image.network(
                                        EndPoints.domain +
                                            EndPoints.getImageOfFood +
                                            foodInShoppingCart
                                                .orderedFoodImageName,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          foodInShoppingCart.orderedFoodName,
                                          style: const TextStyle(
                                            fontFamily: "Dongle",
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${foodInShoppingCart.orderedFoodPrice}₺  x  ${orderedQuantity.toString()} adet",
                                          style: const TextStyle(
                                            fontFamily: "Dongle",
                                            fontSize: 32,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${int.parse(foodInShoppingCart.orderedQuantity) * int.parse(foodInShoppingCart.orderedFoodPrice)} ₺",
                                          style: const TextStyle(
                                            fontFamily: "Dongle",
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "${foodInShoppingCart.orderedFoodName} silinsin mi?"),
                                                action: SnackBarAction(
                                                  label: "Evet",
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            ShoppingCartPageCubit>()
                                                        .removeFoodFromShoppingCart(
                                                            foodInShoppingCart
                                                                .id,
                                                            user.name);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Expanded(child: Center());
                }
              }),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 32.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Ödenecek Tutar: ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 32.0,
                              fontFamily: "Dongle",
                              fontWeight: FontWeight.bold),
                        ),
                        BlocBuilder<ShoppingCartPageCubit,
                            List<FoodInShoppingCart>>(
                          builder: (context, foodsInShoppingCart) {
                            if (foodsInShoppingCart.isNotEmpty) {
                              totalPriceOfFoodsInShoppingCart =
                                  getTotalPriceOfFoodsInShoppingCart(
                                      foodsInShoppingCart);
                            } else {
                              totalPriceOfFoodsInShoppingCart = 0;
                            }

                            return Text(
                              "$totalPriceOfFoodsInShoppingCart ₺",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 36.0,
                                  fontFamily: "Dongle",
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ],
                    ),
                    BlocBuilder<ShoppingCartPageCubit,
                        List<FoodInShoppingCart>>(
                      builder: (context, foodsInShoppingCart) {
                        if (foodsInShoppingCart.isNotEmpty) {
                          return ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.amber),
                            onPressed: () {
                              for (var foodInShoppingCart
                                  in foodsInShoppingCart) {
                                context
                                    .read<ShoppingCartPageCubit>()
                                    .removeFoodFromShoppingCart(
                                        foodInShoppingCart.id, user.name);
                              }

                              Navigator.pushNamed(
                                context,
                                ShippingInformationPage.routeName,
                              ).then((value) {
                                Navigator.pop(context);
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                "SEPETİ ONAYLA",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26.0,
                                    fontFamily: "Dongle",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        } else {
                          return const Center();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
