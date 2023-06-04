import 'dart:ffi';

class Products {
  final String name;
  final int ratee;
  final String id;
  final int INDEX;
  final int Mrp;

  Products(
      {required this.name,
      required this.id,
      required this.ratee,
      required this.INDEX,
      required this.Mrp});

  // Map<String, dynamic> toJson() => {
  //       'check': check,
  //       'rate': rate,
  //       'id': id,
  //     };
  static Products fromJson(Map<String, dynamic> json) => Products(
      name: json['name'],
      ratee: json['rate'],
      id: json['id'],
      INDEX: json["NO"],
      Mrp: json["Mrp"]);
}
