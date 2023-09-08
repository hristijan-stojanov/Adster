class Imagee {
  int id;
  String name;
  String location;

  Imagee({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Imagee.fromJson(Map<String, dynamic> json) => Imagee(
    id: json["id"],
    name: json["name"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
  };
}
