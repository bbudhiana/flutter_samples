import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import './cubit/countercubit_cubit.dart';
import './bloc/counter_bloc_5.dart';

//MERUPAKAN BAGIAN KECIL DARI BLOC STATE MANAGEMENT
//BEDANYA BLOC Merupakan EVENT-DRIVER atau berdasarkan event
//CUBIT berdasarkan method, sehingga lebih ringan
class CubitStateScreen extends StatefulWidget {
  static const routeName = "/cubit-state";

  @override
  _CubitStateScreenState createState() => _CubitStateScreenState();
}

class _CubitStateScreenState extends State<CubitStateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cubit State"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.black,
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bloc State Management",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  BlocBuilder<CounterBloc5, CounterState>(
                    builder: (_, state) => Text(
                      (state is CounterBlocState) ? "${state.value}" : "-",
                      style: GoogleFonts.poppins(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //context.bloc<CounterBloc5>().add(CounterBlocIncrement(1));
                      context.read<CounterBloc5>().add(CounterBlocIncrement(1));
                    },
                    child: Text(
                      "+",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cubit State Management",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                    ),
                  ),
                  BlocBuilder<CountercubitCubit, CountercubitState>(
                    builder: (_, cubitState) => Text(
                      (cubitState is CountercubitStateFilled)
                          ? "${cubitState.value}"
                          : "-",
                      style: GoogleFonts.poppins(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //context.bloc<CountercubitCubit>().cubitIncrement(1);
                      context.read<CountercubitCubit>().cubitIncrement(1);
                    },
                    child: Text(
                      "+",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
