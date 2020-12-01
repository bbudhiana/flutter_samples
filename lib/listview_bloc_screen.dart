import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './widgets/product_card.dart';

/*
  listview builder :
  - itemCount : jumlah item
  - itemBuilder : fungsi untuk build item nya seperti apa
*/

class ListviewBlocScreen extends StatelessWidget {
  static const routeName = '/listview-bloc-screen';

  final Random r = Random();

  @override
  Widget build(BuildContext context) {
    /*
      The easiest way to read a value is by using the extension methods on [BuildContext]:

    context.watch<T>(), which makes the widget listen to changes on T
    context.read<T>(), which returns T without listening to it
    context.select<T, R>(R cb(T value)), which allows a widget to listen to only a small part of T.

    */
    //ProductBloc bloc = context.bloc<ProductBloc>();
    //ProductBloc bloc = context.read<ProductBloc>();
    //ProductBloc bloc = context.watch<ProductBloc>();
    ProductBloc bloc = context.select((ProductBloc productBloc) => productBloc);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF44336),
        title: Text('Listview Builder with BLoC'),
      ),
      body: Column(
        children: [
          RaisedButton(
            color: Color(0xffF44336),
            child: Text(
              "create products",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              bloc.add(r.nextInt(4) + 2);
            },
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<ProductBloc, List<Product>>(
            builder: (context, products) => Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  //return Text(products[index].name);
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (index == 0)
                          ? SizedBox(
                              width: 20,
                            )
                          : Container(),
                      ProductCard(
                        imageUrl: products[index].imageUrl,
                        name: products[index].name,
                        price: products[index].price.toString(),
                        notification: products[index].notification.toString(),
                        onAddCartTap: () {},
                        onDecTap: () {},
                        onIncTap: () {},
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  String imageUrl;
  String name;
  int price;
  String notification;

  //constructor
  Product({
    this.imageUrl = "",
    this.name = "",
    this.price = 0,
    this.notification,
  });
}

class ProductBloc extends Bloc<int, List<Product>> {
  ProductBloc() : super(initialState);

  static List<Product> get initialState => [];

  @override
  Stream<List<Product>> mapEventToState(int event) async* {
    List<Product> products = [];
    for (int i = 0; i < event; i++) {
      products.add(Product(
        imageUrl:
            "https://www.pantau.com/uploads/news/image/200710113543-aksi-heroik-samsiyah-tewas-selamatkan-anak-saat-mobil-hanyut-di-kalimalang-1024x535.jpg",
        name: "Product " + i.toString(),
        price: (i + 1) * 5000,
        notification: i.isEven ? "discount " + i.toString() : "",
      ));
    }
    yield products;
  }
}
