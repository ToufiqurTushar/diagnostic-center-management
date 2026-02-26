import 'package:example/config/app_widgets.dart';
import 'package:example/data/app_data.dart';
import 'package:example/toggle/patients/patients_i18n.dart';
import 'package:example/toggle/patients/patients_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:get/get.dart';
import '../../../../config/app_theme.dart';

class PatientsView extends RapidView<PatientsLogic> {
  static const routeName = '/patients';
  const PatientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientsLogic>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Family Members')),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddPatientSheet(context, controller),
            label: const Text('Add Patient'),
            icon: const Icon(Icons.add),
            backgroundColor: AppColors.primary,
          ),
          body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.patients.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) =>
                _patientCard(controller.patients[i]),
          ),
        );
      },
    );
  }

  Widget _patientCard(Patient patient) {
    return AppCard(
      child: Row(children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [AppColors.primary, AppColors.accent]),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              patient.name[0],
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patient.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColors.textDark)),
                const SizedBox(height: 4),
                Row(children: [
                  _chip(patient.relation),
                  const SizedBox(width: 6),
                  _chip('${patient.age} yrs'),
                  const SizedBox(width: 6),
                  _chip(patient.bloodGroup),
                ]),
              ]),
        ),
        const Icon(Icons.more_vert, color: AppColors.textGrey),
      ]),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(6)),
      child: Text(text,
          style: const TextStyle(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w600)),
    );
  }

  void _showAddPatientSheet(
      BuildContext context, PatientsLogic controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Patient',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AppColors.textDark)),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline)),
                onChanged: controller.setName,
              ),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(labelText: 'Relation'),
                    value: controller.relation,
                    items: [
                      'Self',
                      'Wife',
                      'Husband',
                      'Son',
                      'Daughter',
                      'Father',
                      'Mother'
                    ]
                        .map((r) =>
                            DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: controller.setRelation,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'Age'),
                    onChanged: controller.setAge,
                  ),
                ),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(labelText: 'Gender'),
                    value: controller.gender,
                    items: ['Male', 'Female', 'Other']
                        .map((g) =>
                            DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: controller.setGender,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(labelText: 'Blood Group'),
                    value: controller.bloodGroup,
                    items: [
                      'A+',
                      'A-',
                      'B+',
                      'B-',
                      'AB+',
                      'AB-',
                      'O+',
                      'O-'
                    ]
                        .map((g) =>
                            DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: controller.setBloodGroup,
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              FullButton(
                'Add Patient',
                onTap: () {
                  controller.addPatient();
                  Navigator.pop(context);
                },
              ),
            ]),
      ),
    );
  }
  
  @override
  void loadDependentLogics() {
    Get.lazyPut<PatientsLogic>(() => PatientsLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return PatientsI18n.getTranslations();
  }
}