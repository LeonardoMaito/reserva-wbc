import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reservation.dart';
import '../providers/reservation_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Churrasqueiras'),
        centerTitle: true,
      ),
      body: futureBuilder(context),
    );
  }

  Widget futureBuilder(BuildContext context){
    return  FutureBuilder(
      future: Provider.of<ReservationProvider>(context, listen: false).init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Erro ao inicializar o banco de dados'),
          );
        } else {
          return consumer();
        }
      },
    );
  }

  Widget consumer() {
    return Consumer<ReservationProvider>(
      builder: (context, reservationProvider, child) {
        reservationProvider.getAllReservations();
        List<Reservation> reservations = reservationProvider.reservations;

        return ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            Reservation reservation = reservations[index];

            return ListTile(
              title: Text(reservation.title),
              subtitle: Text('Capacidade Máxima: ${reservation.maxPeople}'),
              trailing: ElevatedButton(
                onPressed: () async {
                  if (reservation.reserved == false) {
                    await reservationProvider.reserveReservation(reservation);
                  } else {
                    await reservationProvider.unreserveReservation(reservation);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      reservation.reserved == true ? Colors.red : Colors.green,
                ),
                child: Text(
                    reservation.reserved == true ? 'Reservado' : 'Reservar'),
              ),
            );
          },
        );
      },
    );
  }
}
