import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reserva_wbc/resources/reservation_db_provider.dart';

import '../models/reservation.dart';
import '../providers/reservation_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Churrasqueiras')),
      body: Consumer<ReservationProvider>(
        builder: (context, reservationProvider, child) {
          reservationProvider.getAllReservations();
          List<Reservation> reservations = reservationProvider.reservations;
          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              Reservation reservation = reservations[index];
              return ListTile(
                title: Text(reservation.title),
                subtitle:
                Text('Capacidade Máxima: ${reservation.maxPeople}'),
                trailing: reservation.reserved == 0
                    ? ElevatedButton(
                  child: const Text('Reservar'),
                  onPressed: () {
                    reservationProvider.reserveReservation(reservation);
                  },
                )
                    : ElevatedButton(
                    onPressed: null, child: const Text('Reservado')),
              );
            },
          );
        },
      ),
    );
    }
  }

  
