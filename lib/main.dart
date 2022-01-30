import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yemek_siparis_uygulamasi/cubit/detail_page_cubit.dart';
import 'package:yemek_siparis_uygulamasi/cubit/home_page_cubit.dart';
import 'package:yemek_siparis_uygulamasi/cubit/shoppingcart_page_cubit.dart';
import 'package:yemek_siparis_uygulamasi/views/detail_page.dart';
import 'package:yemek_siparis_uygulamasi/views/home_page.dart';
import 'package:yemek_siparis_uygulamasi/views/notification_page.dart';
import 'package:yemek_siparis_uygulamasi/views/shipping_information_page.dart';
import 'package:yemek_siparis_uygulamasi/views/shoppingcart_page.dart';
import 'package:yemek_siparis_uygulamasi/views/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageCubit()),
        BlocProvider(create: (context) => DetailPageCubit()),
        BlocProvider(create: (context) => ShoppingCartPageCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Delivery App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: WelcomePage.routeName,
        routes: {
          WelcomePage.routeName: (context) => const WelcomePage(),
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => const DetailPage(),
          ShoppingCartPage.routeName: (context) => const ShoppingCartPage(),
          NotificationPage.routeName: (context) => const NotificationPage(),
          ShippingInformationPage.routeName: (context) =>
              const ShippingInformationPage(),
        },
      ),
    );
  }
}
