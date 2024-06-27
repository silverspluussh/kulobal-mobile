// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
part 'medication.g.dart';

@collection
class Medication {
  Id id = Isar.autoIncrement;
  String? medId = const Uuid().v4();
  String? medicine;
  String? strength;
  String? dosage;
  String? age;
  String? instructions;
}
