import 'package:isar/isar.dart';
part 'reminders.g.dart';

@collection
class Reminders {
  Id id = Isar.autoIncrement;
  String? time;
  String? title;
  String? note;
  String? medId;
}
