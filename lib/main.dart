import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reserva_wbc/providers/reservation_provider.dart';
import 'package:reserva_wbc/screens/App.dart';

void main() {
  runApp(
  ChangeNotifierProvider(
    create: (context) => ReservationProvider(),
    child:  MaterialApp(
      home: App(),
    ),
   ),
  );

}
