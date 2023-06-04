afterPayment(var patientname) async {
  final collectionRef = FirebaseFirestore.instance
      .collection('Customers')
      .doc(uid)
      .collection(patientname)
      .doc("detail")
      .collection("test");

  final querySnapshot = await collectionRef.get();
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  final items = allData
      .map((data) => {
            "id": data['ID'].substring(5),
            "name": data['name'].substring(7),
            "rate": int.parse(data['rate'].substring(6)),
          })
      .toList();
  items.sort((a, b) => a['name'].compareTo(b['name']));

  final docData = {
    'name': uid,
    'items': items,
  };
  await FirebaseFirestore.instance
      .collection('uncollected_samples')
      .doc(uid)
      .collection("order")
      .doc(patientname)
      .set(docData);

  final customerRef =
      FirebaseFirestore.instance.collection('Customers').doc(uid);
  final customerSnapshot = await customerRef.get();
  final customerData = customerSnapshot.data();
  final customerName = customerData?['name'];

  final userData = {
    'name': customerName ?? '',
  };
  await FirebaseFirestore.instance
      .collection('uncollected_samples')
      .doc(uid)
      .set(userData);

  print("after payment process completed");
  return 1;
}
