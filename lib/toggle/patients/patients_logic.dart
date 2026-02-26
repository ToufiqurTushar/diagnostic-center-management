import 'dart:math';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../../data/app_data.dart';

class PatientsLogic extends RapidLogic {
  List<Patient> patients = AppData.patients;

  // Form fields
  String? relation;
  String? gender;
  String? bloodGroup;
  String name = '';
  String age = '';

  void setName(String val) {
    name = val;
  }

  void setAge(String val) {
    age = val;
  }

  void setRelation(String? val) {
    relation = val;
    update();
  }

  void setGender(String? val) {
    gender = val;
    update();
  }

  void setBloodGroup(String? val) {
    bloodGroup = val;
    update();
  }

  String _generateUniqueId() {
  final random = Random();
  String id;

  do {
    id = (100000 + random.nextInt(900000)).toString();
  } while (patients.any((p) => p.id == id));

  return id;
}

 void addPatient() {
  if (name.isEmpty ||
      age.isEmpty ||
      relation == null ||
      bloodGroup == null ||
      gender == null) return;

  final id = _generateUniqueId();

  patients.add(
    Patient(
      id: id,
      name: name,
      relation: relation!,
      age: int.tryParse(age) ?? 0,
      bloodGroup: bloodGroup!,
      gender: gender!,
    ),
  );

  // Reset fields
  name = '';
  age = '';
  relation = null;
  gender = null;
  bloodGroup = null;

  update();
}
}