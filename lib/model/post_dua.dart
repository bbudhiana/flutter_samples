import 'dart:convert';

class Postdua {
  Postdua({
    this.id,
    this.title,
    this.body,
  });

  int id;
  String title;
  String body;

  factory Postdua.fromJson(Map<String, dynamic> json) => Postdua(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
      };
}
