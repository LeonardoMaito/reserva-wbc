import 'package:flutter/material.dart';
import '../models/reservation.dart';
import '../providers/reservation_provider.dart';

class CardWidget extends StatelessWidget {
  final ReservationProvider reservationProvider;
  final Reservation reservation;

  CardWidget(this.reservationProvider, this.reservation);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5.0,
            spreadRadius: 0,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.only(top: 5.0),
        shadowColor: Colors.orange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                reservation.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Capacidade Máxima: ${reservation.maxPeople}',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.network(
                      'https://clubecirculo.com.br/wp-content/uploads/2022/03/DSC0190.jpg')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (reservation.reserved == false) {
                    await reservationProvider
                        .reserveReservation(reservation);
                  } else {
                    await reservationProvider
                        .unreserveReservation(reservation);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: reservation.reserved == true
                      ? Colors.grey
                      : Colors.orange,
                  fixedSize: const Size(110, 35),
                  textStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                child: Text(reservation.reserved == true
                    ? 'Reservado'
                    : 'Reservar'),
              ),
            ),
          ],
        ),),
    );
  }
}
