import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reserva_wbc/widgets/grid_widget.dart';
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
          return GridWidget();
        }
      },
    );
  }
}
