import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab/verify.dart';

var uid = uidData();

afterPayment(var patientname, var Patient_ID) async {
  late CollectionReference _collectionRef = FirebaseFirestore.instance
      .collection('Customers')
      .doc(uid)
      .collection("PATIENTS")
      .doc(Patient_ID)
      .collection("test");
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();
  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  print("allData");
  print(allData);

  var z = allData;
  print("z");
  print(z);
  var data = new List.filled(allData.length, "a");
  print("data");
  print(data);
  for (var i = 0; i < z.length; i++) {
    data[i] = allData[i].toString();
  }
  var data1 = new List.filled(allData.length, []);
  print("data1");
  print(data1);
  for (var i = 0; i < z.length; i++) {
    data[i] = data[i].substring(1, data[i].length - 1);
    var j = data[i].split(",");
    data1[i] = j;
    data1[i].sort();
  }
  print("data1");
  print(data1);

  for (var i = 0; i < z.length; i++) {
    var a = {
      "id": data1[i][0].substring(
        5,
      ),
      "name": data1[i][1].substring(
        7,
      ),
      "rate": int.parse(data1[i][2].substring(
        6,
      )),
    };
    print("a");
    print(a);

    FirebaseFirestore.instance
        .collection('uncollected_samples')
        .doc(uid)
        .collection("order")
        .doc(Patient_ID)
        .collection("test")
        .doc("${a['id']}")
        .set(a);
  }

  var b = {
    'Patient_ID': Patient_ID,
    "Customer_ID": uid,
    "Patient_Name": patientname
  };
  FirebaseFirestore.instance
      .collection('uncollected_samples')
      .doc(uid)
      .collection("order")
      .doc(Patient_ID)
      .set(b);

  print("all done");

  //------------ uid name-----

  var collection = FirebaseFirestore.instance
      .collection('Customers')
      .where('ID', isEqualTo: uid);
  var uidname = await collection.get();
  for (var queryDocumentSnapshot in uidname.docs) {
    Map<String, dynamic> data = queryDocumentSnapshot.data();
    var customer_name = data['name'];
    print("-----------------------------");
    print("customer name");
    print(customer_name);
    var c = {
      "Customer_ID": uid,
      'Customer_Name': customer_name,
      'Assign_Status': false,
      "latitude": "22.788178",
      "longitude": "75.917450"
    };
    FirebaseFirestore.instance
        .collection('uncollected_samples')
        .doc(uid)
        .set(c);
        
  }
  print("after payment process completed");
  return 1;
}

getid() async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('lab').get();
  List docs = snapshot.docs;
  List product = [];
  docs.forEach((doc) {
    print(doc.id);
    product.add(doc.id);
  });
  print(product);
  var document = await FirebaseFirestore.instance
      .collection('COLLECTION_NAME')
      .doc('TESTID1');
// document.get() => then(function(document) {
//     print(document("name"));
// });
  return product;
}

getTotal(patient, Patient_ID) async {
  var uid = uidData();
  late CollectionReference _collectionRef = FirebaseFirestore.instance
      .collection('Customers')
      .doc(uid)
      .collection("PATIENTS")
      .doc(Patient_ID)
      .collection("test");
  QuerySnapshot querySnapshot = await _collectionRef.get();
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  var z = allData;
  print(allData);
  var data = new List.filled(allData.length, "a");
  for (var i = 0; i < z.length; i++) {
    data[i] = allData[i].toString();
  }
  var data1 = new List.filled(allData.length, []);
  for (var i = 0; i < z.length; i++) {
    data[i] = data[i].substring(1, data[i].length - 1);
    var j = data[i].split(",");
    data1[i] = j;
    data1[i].sort();
  }
  print(data1);
  int total = 0;
  for (var i = 0; i < z.length; i++) {
    var rate = int.parse(data1[i][2].substring(
      6,
    ));
    total = total + rate;
  }
  print("total cost");
  print(total);
  return total;
}


// TOTAL() async {
//   //   var collection = FirebaseFirestore.instance
//   //       .collection('Customers')
//   //       .doc(widget.uid)
//   //       .collection("BFBBFB")
//   //       .doc("detail")
//   //       .collection("test");

//   //   var uidname = await collection.get();
//   //   for (var queryDocumentSnapshot in uidname.docs) {
//   //     Map<String, dynamic> data = queryDocumentSnapshot.data();
//   //     var test_rate = data['rate'];
//   //     var test_name = data['name'];
//   //     print("customer name");
//   //     print(test_name);
//   //     print(test_rate);
//   //   }
//   // }