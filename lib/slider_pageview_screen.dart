import 'package:flutter/material.dart';
import './widgets/movie_box.dart';

class SliderPageviewScreen extends StatelessWidget {
  static const routeName = "/slider-pageview";

  @override
  Widget build(BuildContext context) {
    //setting page controller nya, viewportFraction : berapa view page yg diperlihatkan
    PageController controller = PageController(
      initialPage: 0,
      viewportFraction: 0.6,
    );
    //List<Color> colors = [Colors.red, Colors.green, Colors.blue];
    List<String> urls = [
      "https://i.pinimg.com/236x/92/c8/e0/92c8e00b34fcfdeaf605a0647c21adb3.jpg",
      "https://i.pinimg.com/564x/85/e1/d7/85e1d7f2257d2d0b7fa51f4ac8d4e7ec.jpg",
      "https://i.pinimg.com/564x/93/f5/a3/93f5a3a120e7eb07b7ca7a6aafacc75f.jpg",
      "https://i.pinimg.com/564x/c8/0f/35/c80f35ad4c46a48f9fcf7618e47e8399.jpg"
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Slider with Pageview'),
      ),
      //PageView.builder berdasarkan data yg dimiliki, misal dari database
      body: PageView.builder(
        controller: controller,
        itemCount: urls.length,
        itemBuilder: (context, index) => Center(
          child: MovieBox(urls[index]),
        ),
      ),

      //PageView adalah : widget yang menggabungkan widget-widget dalam satu page
      //pindah antar page nya dengan cara di geser
      /* PageView(
        //onPageChange minta parameter integer, merupakan index page
        onPageChanged: (index) {
          //jadi kalo ada proses setiap pindah halaman  maka gunakan ini
          print("halaman " + index.toString());
        },
        children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.yellow,
          ),
        ],
      ), */
    );
  }
}
