import 'dart:math';

String generatePatientId() {
  // Get current date and time
  DateTime now = DateTime.now();

  // Extract year, month, and day from current date
  String year = now.year.toString().substring(2);
  String month = _formatDateNumber(now.month);
  String day = _formatDateNumber(now.day);

  // Extract hour, minute, and second from current time
  String hour = _formatDateNumber(now.hour);
  String minute = _formatDateNumber(now.minute);
  String second = _formatDateNumber(now.second);
  String milisecond = _formatDateNumber(now.millisecond);
  String microsecond = _formatDateNumber(now.microsecond);
  String nanoosecond = _formatDateNumber(now.hashCode);
  // print(nanoosecond);

  // Generate random two-digit number for the last two digits of patient ID
  int random = Random().nextInt(60);
  // int ch = Random().nextInt(2);
  // if (ch == 0) {
  //   String patientId =
  //       "PT$year$month$day$hour$minute$second$microsecond$random$milisecond";
  // } else if (ch == 1) {
  //   String patientId =
  //       "PT$year$month$day$hour$minute$second$milisecond$microsecond$random";
  // } else {
  //   String patientId =
  //       "PT$year$month$day$hour$minute$second$milisecond$microsecond$random";
  // }

  // Concatenate all the parts to create the patient ID
  // PT 23 05 01 19 53 12 32
  var key = {
    "01": "1",
    "02": "2",
    "03": "3",
    "04": "4",
    "05": "5",
    "06": "6",
    "07": "7",
    "08": "8",
    "09": "9",
    "00": "0",
    "10": "Z",
    "11": "a",
    "12": "b",
    "13": "c",
    "14": "d",
    "15": "e",
    "16": "f",
    "17": "g",
    "18": "h",
    "19": "i",
    "20": "j",
    "21": "k",
    "22": "l",
    "23": "m",
    "24": "n",
    "25": "o",
    "26": "p",
    "27": "q",
    "28": "r",
    "29": "s",
    "30": "t",
    "31": "u",
    "32": "v",
    "33": "w",
    "34": "x",
    "35": "y",
    "36": "z",
    "37": "A",
    "38": "B",
    "39": "C",
    "40": "D",
    "41": "E",
    "42": "F",
    "43": "G",
    "44": "H",
    "45": "I",
    "46": "J",
    "47": "K",
    "48": "L",
    "49": "M",
    "50": "N",
    "51": "O",
    "52": "P",
    "53": "Q",
    "54": "R",
    "55": "S",
    "56": "T",
    "57": "U",
    "58": "V",
    "59": "W",
    "60": "X",
    "61": "Y",
  };

  String patientId =
      "PT$year$month$day$hour$minute$second$milisecond$microsecond$random";
  // print(key[year]);
  String patient =
      "PT${key[year]}${key[month]}${key[day]}${key[hour]}${key[minute]}${key[second]}$milisecond$microsecond${key[random.toString()]}";
  print("patient ID generated using alphabets :");
  print(patient);

  print("patient ID generated :");
  print(patientId);
  // print(reverse("$year$month$day$hour$minute$second$milisecond$random"));
  print(
      "PT year $year month $month day $day hour $hour minute $minute seccond $second milisecond $milisecond microsecond $microsecond random $random");

  return patientId;
}

// Helper function to add leading zero to single-digit numbers
String _formatDateNumber(int number) {
  return number.toString().padLeft(2, '0');
}
