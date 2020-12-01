import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_restful_sample/bloc/counterb_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubit/counterc_cubit.dart';

class ReplayBlocScreen extends StatelessWidget {
  static const routeName = "/replay-bloc";

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
                  BlocBuilder<CounterbBloc, CounterbState>(
                    builder: (_, state) => Text(
                      (state is InitializedCounterb) ? "${state.number}" : "-",
                      style: GoogleFonts.poppins(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      //context.bloc<CounterbBloc>().add(Incement());
                      context.read<CounterbBloc>().add(Incement());
                    },
                    child: Text(
                      "+",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          //context.bloc<CounterbBloc>().undo();
                          context.read<CounterbBloc>().undo();
                        },
                        child: Text(
                          "Undo",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          //context.bloc<CounterbBloc>().redo();
                          context.read<CounterbBloc>().redo();
                        },
                        child: Text(
                          "Redo",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
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
                    /* BlocBuilder<CountercCubit, CountercState>(
                      builder: (_, cubitState) => Text(
                        (cubitState is InitializedCounterc)
                            ? "${cubitState.number}"
                            : "-",
                        style: GoogleFonts.poppins(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ), */
                    BlocBuilder<CountercCubit, CountercState>(
                      builder: (_, cubitState) => Text(
                        (cubitState is CountercInitial)
                            ? "${cubitState.number}"
                            : "-",
                        style: GoogleFonts.poppins(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        //context.bloc<CountercCubit>().increment();
                        context.read<CountercCubit>().increment();
                      },
                      child: Text(
                        "+",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            //context.bloc<CountercCubit>().undo();
                            context.read<CountercCubit>().undo();
                          },
                          child: Text(
                            "Undo",
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          onPressed: () {
                            //context.bloc<CountercCubit>().redo();
                            context.read<CountercCubit>().redo();
                          },
                          child: Text(
                            "Redo",
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
