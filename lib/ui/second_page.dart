import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/color_bloc.dart';
import '../bloc/counter_bloc.dart';
import '../ui/draft_page.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ColorBloc colorBloc = context.bloc<ColorBloc>();
    //CounterBloc counterBloc = context.bloc<CounterBloc>();
    //ColorBloc colorBloc = context.read<ColorBloc>();
    //CounterBloc counterBloc = context.read<CounterBloc>();
    ColorBloc colorBloc = context.watch<ColorBloc>();
    CounterBloc counterBloc = context.watch<CounterBloc>();
    return BlocBuilder<ColorBloc, Color>(
      builder: (context, color) => DraftPage(
        backgroundColor: color,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<CounterBloc, int>(
                builder: (context, number) => GestureDetector(
                  onTap: () {
                    counterBloc.add(number + 1);
                  },
                  child: Text(
                    number.toString(),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      colorBloc.add(ColorEvent.toPink);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      shape: (color == Colors.pink)
                          ? CircleBorder(
                              side: BorderSide(color: Colors.black, width: 3),
                            )
                          : CircleBorder(),
                    ),
                    child: Text(''),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      colorBloc.add(ColorEvent.toEmber);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      shape: (color == Colors.amber)
                          ? CircleBorder(
                              side: BorderSide(color: Colors.black, width: 3),
                            )
                          : CircleBorder(),
                    ),
                    child: Text(''),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      colorBloc.add(ColorEvent.toPurple);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: (color == Colors.purple)
                          ? CircleBorder(
                              side: BorderSide(color: Colors.black, width: 3),
                            )
                          : CircleBorder(),
                    ),
                    child: Text(''),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
