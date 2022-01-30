import 'package:flutter/material.dart';
import 'package:yemek_siparis_uygulamasi/entities/shipping_information.dart';

import 'package:yemek_siparis_uygulamasi/entities/user.dart';
import 'package:yemek_siparis_uygulamasi/views/notification_page.dart';

class ShippingInformationPage extends StatefulWidget {
  static const String routeName = '/ShippingInformation';

  const ShippingInformationPage({Key? key}) : super(key: key);

  @override
  _ShippingInformationPageState createState() =>
      _ShippingInformationPageState();
}

class _ShippingInformationPageState extends State<ShippingInformationPage> {
  late User user;
  var tfShippingInformation = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text("Gönderi Bilgileri"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Lütfen gönderi bilgilerini giriniz.",
                    style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: "Dongle",
                        fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: tfShippingInformation,
                    decoration:
                        const InputDecoration(hintText: "Adres giriniz"),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.amber),
                onPressed: () {
                  ShippingInformation shippingInformation = ShippingInformation(
                      shipAddress: tfShippingInformation.text);

                  Navigator.pushNamed(
                    context,
                    NotificationPage.routeName,
                    arguments: shippingInformation,
                  ).then((value) {
                    Navigator.pop(context);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    "KAYDET",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26.0,
                        fontFamily: "Dongle",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
