import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reserva_wbc/models/reservation.dart';
import 'package:reserva_wbc/widgets/grid_widget.dart';
import '../providers/reservation_provider.dart';

class App extends StatelessWidget {
   App({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

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
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.orange,
        onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<ReservationProvider>(
            builder: (context, reservationProvider, child){
              return AlertDialog(
                title: Text('Nova Reserva'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Título da reserva',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantidade máxima de pessoas',
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('CANCELAR'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('SALVAR'),
                    onPressed: () async {
                      final int quantity = int.tryParse(_quantityController.text) ?? 0;
                      Reservation reservation =  Reservation(null, quantity, _titleController.text, false);
                      await reservationProvider!.insertReservation(reservation);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    },
    child: const Icon(Icons.add),
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
          return GridWidget();
        }
      },
    );
  }
}
