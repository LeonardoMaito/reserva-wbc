import 'package:reserva_wbc/resources/reservation_db_provider.dart';
import '../models/reservation.dart';
import 'package:flutter/material.dart';

import '../resources/repository.dart';

class ReservationProvider with ChangeNotifier{

  final _repository = Repository();
  List<Reservation> _reservations = [];
  Reservation? _selectedReservation;

  List<Reservation> get reservations => _reservations;
  Reservation? get selectedReservation => _selectedReservation;

  Future<void> getAllReservations() async {
    _reservations = await _repository.getAllReservations();
    notifyListeners();
  }

  Future<void> reserveReservation(Reservation reservation) async {
    await _repository.reserveReservation(reservation.id!);
    notifyListeners();
  }

}
