import 'dart:math';

import 'package:flutter/material.dart';

import 'widgets/movie_box.dart';

class SliderTransitionScreen extends StatefulWidget {
  static const routeName = "/slider-transition";

  @override
  _SliderTransitionScreenState createState() => _SliderTransitionScreenState();
}

class _SliderTransitionScreenState extends State<SliderTransitionScreen> {
  //currentPageValue - Page yang sedang ditampilkan, default index nya 0, ini yg berubah state nya
  double currentPageValue = 0;
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 0.6);

  @override
  void initState() {
    //UNTUK MEMANTAU PERGERAKAN si PAGE, setiap page bergerak maka update state
    super.initState();
    controller.addListener(() {
      //lakukan perubahan state ketika ada perubahan hasiil info dari current
      setState(() {
        currentPageValue = controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //setting page controller nya, viewportFraction : berapa view page yg diperlihatkan

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
          //controller ini yang mendeteksi perubahan di pageview
          controller: controller,
          itemCount: urls.length,
          itemBuilder: (context, index) {
            double difference = index - currentPageValue;
            //hanya perlu perbandingannya bukan minnya, maka dikali -1 agar selalu positif,
            if (difference < 0) {
              difference *= -1;
            }
            //min mengambil nilai minimum, antara 1 - difference,jika difference misal 0.5 maka diambil 0.5, jika difference=1.5 maka diambil 1
            difference = min(1, difference);
            return Center(
              child: MovieBox(
                urls[index],
                //jika misal di index 2, maka difference=0 dengan demikian scale nya 1
                //jika misal di antara index 1 dan 2, maka difference=0.5 (index=1, currentPageValue=1.5) dengan demikian scale nya 1 - (0.3*0.5) = 0.85
                scale: 1 - (difference * 0.3),
              ),
            );
          }),
    );
  }
}
