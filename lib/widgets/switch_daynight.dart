import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SwitchDaynight extends StatefulWidget {
  @override
  _SwitchDaynightState createState() => _SwitchDaynightState();
}

class _SwitchDaynightState extends State<SwitchDaynight> {
  //0 = night
  //1 = night -> day
  //2 = day
  //3 = day -> night

  int state = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: GestureDetector(
        onTap: () {
          if (state == 0) {
            setState(() {
              state = 1;
            });
          } else if (state == 2) {
            setState(() {
              state = 3;
            });
          }
        },
        child: FlareActor(
          "assets/switch_daytime.flr",
          //ini pasang animasi nya
          animation: (state == 0)
              ? "night_idle"
              : (state == 1)
                  ? "switch_day"
                  : (state == 2) ? "day_idle" : "switch_night",
          //callback ini akan dijalankan setelah animasi selesai dilakukan
          callback: (animationName) {
            if (animationName == "switch_day") {
              setState(() {
                //day
                state = 2;
              });
            } else if (animationName == "switch_night") {
              setState(() {
                //night
                state = 0;
              });
            }
          },
        ),
      ),
    );
  }
}
