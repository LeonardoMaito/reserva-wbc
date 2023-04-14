import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reservation.dart';
import '../providers/reservation_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Churrasqueiras')),
      body: FutureBuilder(
        future: Provider.of<ReservationProvider>(context, listen: false).init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao inicializar o banco de dados'),
            );
          } else {
            return Consumer<ReservationProvider>(
              builder: (context, reservationProvider, child) {
                reservationProvider.getAllReservations();
                List<Reservation> reservations =
                    reservationProvider.reservations;

                return ListView.builder(
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    Reservation reservation = reservations[index];

                    return ListTile(
                      title: Text(reservation.title),
                      subtitle:
                          Text('Capacidade Máxima: ${reservation.maxPeople}'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          if (reservation.reserved == 0) {
                            reservationProvider
                                .reserveReservation(reservation);
                            print(reservation.reserved);
                          } else {
                            reservationProvider
                                .unreserveReservation(reservation);
                            print(reservation.reserved);
                          }
                        },
                        child:
                            Text(reservation.reserved == 1 ? 'Reserved' : 'Reserve'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: reservation.reserved == 1 ? Colors.red : Colors.green,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
