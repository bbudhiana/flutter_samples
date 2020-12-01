import 'package:flutter/material.dart';

class SwitchScreen extends StatefulWidget {
  static const routeName = '/switch-sample';
  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  bool isOn = false;
  Widget myWidget = Container(
    width: 200,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.red,
      border: Border.all(
        color: Colors.black,
        width: 3,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              child: myWidget,
              duration: Duration(seconds: 1),
              transitionBuilder: (child, animation) => ScaleTransition(
                //transitionBuilder: (child, animation) => RotationTransition(
                scale: animation,
                //turns: animation,
                child: child,
              ),
            ),
            Switch(
              activeColor: Colors.green,
              activeTrackColor: Colors.green[100],
              inactiveThumbColor: Colors.red,
              inactiveTrackColor: Colors.red[100],
              value: isOn,
              onChanged: (newValue) {
                isOn = newValue;
                setState(() {
                  if (isOn)
                    myWidget = Container(
                      key: ValueKey(1),
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                    );

                  /* myWidget = SizedBox(
                      width: 200,
                      height: 100,
                      child: Center(
                        child: Text(
                          'Switch Me!',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                    ); */
                  else
                    myWidget = Container(
                      key: ValueKey(2),
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                    );
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class TurnTransition {}
