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
        backgroundColor: Colors.orangeAccent,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: futureBuilder(context),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
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

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            Reservation reservation = reservations[index];

            return card(reservationProvider, reservation );
          },
        );
      },
    );

  }

  Widget card(ReservationProvider reservationProvider, Reservation reservation){
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: new BoxDecoration(
        boxShadow: [BoxShadow(color:Colors.black.withOpacity(0.5),
          blurRadius: 5.0,
          spreadRadius: 0,
          offset: Offset(5,5),
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
        ),
      ),
    );
  }
}
