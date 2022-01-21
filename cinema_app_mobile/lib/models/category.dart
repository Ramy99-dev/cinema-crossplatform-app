class Category {
  String id, name, description;

  Category({required this.id, required this.name, required this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['_id'], name: json['nom'], description: json['description']);
  }
}
