class Reservation {
  String id;
  dynamic movie;
  int nbr;

  Reservation({required this.id, required this.movie, required this.nbr});

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
        id: json['_id'], movie: json['idMovie'], nbr: json['nbr']);
  }
}
