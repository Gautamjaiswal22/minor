import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

get_account(uid) async {
  var collection = FirebaseFirestore.instance
      .collection('Customers')
      .where('ID', isEqualTo: uid);
  var uidname = await collection.get();
  var name;
  var account_arr = ["uid", "name", "email", "mobile", "address"];
  for (var queryDocumentSnapshot in uidname.docs) {
    Map<String, dynamic> data = queryDocumentSnapshot.data();
    var customer_name = data['name'];
    var customer_mail = data['Email'];
    var Customer_mobile = data["Mobile"];

    account_arr[0] = uid;
    account_arr[1] = data['name'];
    account_arr[2] = data['Email'];
    account_arr[3] = data["Mobile"];
    account_arr[4] = data["address"];

    name = customer_name;
    print("customer name");
    print(customer_name);
  }
  print("name");
  print(name);
  return account_arr;
}
