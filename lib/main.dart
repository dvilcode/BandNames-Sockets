import 'package:flutter/material.dart';

import 'package:band_names/pages/home_screen.dart';

void main() => runApp( BandNames() );

class BandNames extends StatelessWidget {
  @override
  Widget build( BuildContext context ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Band Names',
      initialRoute: 'home',
      routes: {
        'home': ( context ) => HomeScreen(),
      },
    );
  }
}