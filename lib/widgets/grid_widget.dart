import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reservation.dart';
import '../providers/reservation_provider.dart';
import 'card_widget.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReservationProvider>(
      builder: (context, reservationProvider, child) {
        reservationProvider.getAllReservations();
        List<Reservation> reservations = reservationProvider.reservations;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            Reservation reservation = reservations[index];

            return CardWidget(reservationProvider, reservation);
          },
        );
      },
    );
  }
}
