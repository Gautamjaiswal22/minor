// import 'dart:ffi';

class Products {
  final String name;
  final String PT_name;
  // final String ID;
  // final String patient_id;
  // final String createdAt;
  final String url;

  Products(
      {required this.name,
      // required this.ID,
      // required this.patient_id,
      // required this.createdAt,
      required this.url,
      required this.PT_name});

  // Map<String, dynamic> toJson() => {
  //       'check': check,
  //       'rate': rate,
  //       'id': id,
  //     };
  static Products fromJson(Map<String, dynamic> json) => Products(
      name: json['name'],
      // ID: json['ID'],
      // patient_id: json['[patient_id]'],
      // createdAt: json['createdAt'],
      url: json['url'],
      PT_name: json['patient_name']);
}
