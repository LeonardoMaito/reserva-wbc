import 'package:reserva_wbc/resources/reservation_db_provider.dart';
import '../models/reservation.dart';

class Repository{

  Future<void> insertReservation(Reservation reservation) async {
    await reservationDbProvider.db.insert('Reservation', reservation.toMap());
  }

  Future<List<Reservation>> getAllReservations() async {
    final maps = await  reservationDbProvider.db.query('Reservation');
    return List.generate(maps.length, (i) {
      final reservationMap = maps[i];
      return Reservation.fromMap(reservationMap);
    });
  }

  Future<int> updateReservation(Reservation reservation) async {
    final result = await reservationDbProvider.db.update(
      'Reservation',
      reservation.toMap(),
      where: 'id = ?',
      whereArgs: [reservation.id],
    );
    return result;
  }

  Future<Reservation?> getReservation(int id) async {
    final maps = await reservationDbProvider.db.query(
      'Reservation',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    final reservationMap = maps.first;
    return Reservation.fromMap(reservationMap);
  }

  Future<int> deleteReservation(int id) async {
    final result = await reservationDbProvider.db.delete(
      'Reservation',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<void> reserveReservation(int id) async {
    await reservationDbProvider.db.update('Reservation',
        {
          'reserved': 1
        },
    where: 'id = ?',
    whereArgs: [id],
    );
  }

  Future<void> unreserveReservation(int id) async {
    await reservationDbProvider.db.update('Reservation', {
      'reserved': 0
    },
    where: 'id = ?',
    whereArgs: [id],
    );
  }

}