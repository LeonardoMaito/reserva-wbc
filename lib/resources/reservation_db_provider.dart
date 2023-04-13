import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class ReservationDbProvider {
  late Database db;

  ReservationDbProvider()  {
     init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "reservation.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
              CREATE TABLE Reservation
              (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                maxPeople INTEGER,
                title STRING,
                reserved INTEGER
              )
        """);
    });
    final isEmpty = await reservationDbProvider.isReservationTableEmpty();
    if (isEmpty) {
      createReservations();
    }
  }

  Future<bool> isReservationTableEmpty() async {
    final result = await db.rawQuery('SELECT COUNT(*) FROM Reservation');
    int count = Sqflite.firstIntValue(result)!;
    return count == 0;
  }

  Future createReservations() async {
    await db.insert(
      'Reservation',
      {
        'maxPeople': 2,
        'title': 'Reserva 1A',
        'reserved': 0,
      },
    );

    await db.insert(
      'Reservation',
      {
        'maxPeople': 5,
        'title': 'Reserva 2A',
        'reserved': 1,
      },
    );
  }

}

final reservationDbProvider = ReservationDbProvider();
