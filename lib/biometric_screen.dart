import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';

class BiometricScreen extends StatefulWidget {
  static const routeName = "/biometric";

  @override
  _BiometricScreenState createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  //CHECK IF THERE IS BIOMETRIC FEATURE OR NOT
  bool isAvailable = false;
  //CHENCK AUTHENTICATED STATUS
  bool isAuthenticated = false;

  String text = "Please Check Biometric Availability";

  LocalAuthentication localAuthentication = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometric in Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 200,
              margin: EdgeInsets.only(bottom: 6),
              child: RaisedButton(
                //BIOMETRIC CHECK IS A FEATURE
                onPressed: () async {
                  isAvailable = await localAuthentication.canCheckBiometrics;
                  if (isAvailable) {
                    List<BiometricType> types =
                        await localAuthentication.getAvailableBiometrics();
                    text = "Biometrics Available : ";
                    for (var item in types) {
                      text += "\n- $item";
                    }
                    setState(() {});
                  }
                },
                child: Text('Check Biometric',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
            SizedBox(
              width: 200,
              child: RaisedButton(
                onPressed: isAvailable
                    ? () async {
                        isAuthenticated = await localAuthentication
                            .authenticateWithBiometrics(
                          localizedReason: "Please authenticated",
                          stickyAuth: true,
                          useErrorDialogs: true,
                        );
                        setState(() {});
                      }
                    : null,
                child: Text('Authenticated',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isAuthenticated ? Colors.green : Colors.red,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 3, spreadRadius: 2)
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
