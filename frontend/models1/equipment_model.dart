class Equipment {
  final String name;
  final String image;


  Equipment({required this.name, required this.image});

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return new Equipment(
      name: json['name'],
      image: json['image'],
    );
  }
}
