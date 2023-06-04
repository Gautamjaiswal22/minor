// import 'dart:ffi';

class Products {
  final String name;
  // final String ID;
  final String Mobile;
  final String address;
  final String gender;

  Products({
    required this.name,
    // required this.ID,
    required this.Mobile,
    required this.address,
    required this.gender,
  });

  // Map<String, dynamic> toJson() => {
  //       'check': check,
  //       'rate': rate,
  //       'id': id,
  //     };
  static Products fromJson(Map<String, dynamic> json) => Products(
        name: json['name'],
        // ID: json['ID'],
        Mobile: json['Mobile'],
        address: json['address'],
        gender: json['gender'],
      );
}
