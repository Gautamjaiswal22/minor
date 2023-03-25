import 'dart:ffi';

class Products {
  bool box;
  bool check;
  final String name;
  final int ratee;
  final String id;
  final int INDEX;

  Products(
      {this.box = true,
      required this.check,
      required this.name,
      required this.id,
      required this.ratee,
      required this.INDEX});

  // Map<String, dynamic> toJson() => {
  //       'check': check,
  //       'rate': rate,
  //       'id': id,
  //     };
  static Products fromJson(Map<String, dynamic> json) => Products(
      name: json['name'],
      check: json['check'],
      ratee: json['rate'],
      id: json['id'],
      INDEX: json["NO"]);
}
