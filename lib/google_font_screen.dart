import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleFontScreen extends StatelessWidget {
  static const routeName = "/google-font";

  @override
  Widget build(BuildContext context) {
    Color fontColor = const Color(0xffffb401);

    /*
      KALO MO SETTING FONT SELURUH APLIKASI MAKA DI MaterialApp, dengan setting theme: ThemeData( textTheme: GoogleFont.srirachaTextTheme())
    */

    return Scaffold(
      backgroundColor: const Color(0xff1e252d),
      appBar: AppBar(
        title: Text("Google Font - Cara Gunakan"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "i will keep learning flutter!",
              //style: TextStyle(color: fontColor),
              style: GoogleFonts.roboto(color: fontColor, fontSize: 25),
            ),
            Text(
              "i will keep learning flutter!",
              style: GoogleFonts.lato(color: fontColor, fontSize: 25),
            ),
            Text(
              "i will keep learning flutter!",
              style: GoogleFonts.sriracha(color: fontColor, fontSize: 25),
            ),
            Text(
              "i will keep learning flutter!",
              style: GoogleFonts.aladin(color: fontColor, fontSize: 30),
            ),
            Text(
              "i will keep learning flutter!",
              style: GoogleFonts.sahitya(color: fontColor, fontSize: 30),
            ),
            Text(
              "i will keep learning flutter!",
              style: Theme.of(context)
                  .textTheme
                  //setting nya di MaterialApp
                  .bodyText1
                  .copyWith(color: fontColor, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
