class Movie {
  String id, title, director, description, category, img, date;

  int price, nbr;
  String duration;

  Movie(
      {required this.id,
      required this.title,
      required this.director,
      required this.description,
      required this.category,
      required this.img,
      required this.price,
      required this.duration,
      required this.nbr,
      required this.date});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['_id'],
        title: json['titre'],
        director: json['realisateur'],
        description: json['description'],
        category: json['categorie']["nom"],
        img: json['img'],
        price: json['prix'],
        duration: json['duree'],
        nbr: json['nbr'],
        date: json['date']);
  }
}
