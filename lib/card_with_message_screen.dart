import 'package:flutter/material.dart';
import './widgets/product_card.dart';
import 'package:provider/provider.dart';

class CardWithMessageScreen extends StatelessWidget {
  static const routeName = '/card-with-message';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card with message'),
        backgroundColor: firstColor,
      ),
      body: ChangeNotifierProvider<ProductState>(
        create: (context) => ProductState(),
        child: Container(
          margin: EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.center,
            child: Consumer<ProductState>(
              builder: (context, productState, _) => ProductCard(
                  name: "Makanan Terenak Abad Ini",
                  price: "Rp 40.000,-",
                  quantity: productState.quantity,
                  onAddCartTap: () {},
                  onDecTap: () {
                    productState.quantity--;
                  },
                  onIncTap: () {
                    productState.quantity++;
                  },
                  notification:
                      (productState.quantity > 5) ? "Diskon 10%" : null,
                  imageUrl:
                      "https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductState with ChangeNotifier {
  int _quantity = 0;
  int get quantity => _quantity;
  set quantity(int newValue) {
    _quantity = newValue;
    notifyListeners();
  }
}
