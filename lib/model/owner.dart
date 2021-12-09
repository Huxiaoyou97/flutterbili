class Owner {
  Owner({
    this.name,
    this.face,
    this.fans,
  });

  String? name;
  String? face;
  int? fans;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        name: json["name"],
        face: json["face"],
        fans: json["fans"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "face": face,
        "fans": fans,
      };
}
