
class Reservation {

  int? id;
  int maxPeople;
  String title;
  bool reserved;

  Reservation(this.id, this.maxPeople, this.title, this.reserved);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'maxPeople': maxPeople,
      'title': title,
      'reserved': reserved ? 1 : 0,
    };
  }

   static Reservation fromMap(Map<String, dynamic> map) {
    return Reservation(
      map['id'] as int?,
      map['maxPeople'] as int,
      map['title'] as String,
      map['reserved'] == 1,
    );
  }

}