import 'package:hive/hive.dart';

part 'medicine_model.g.dart';

@HiveType(typeId: 0)
class Medicine extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String dosage;

  @HiveField(3)
  List<String> times; // Times in HH:mm format

  @HiveField(4)
  String frequency; // Daily, Weekly, etc.

  @HiveField(5)
  bool isActive;

  @HiveField(6)
  DateTime createdAt;

  Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.times,
    required this.frequency,
    this.isActive = true,
    required this.createdAt,
  });
}

@HiveType(typeId: 1)
class MedicineLog extends HiveObject {
  @HiveField(0)
  String medicineId;

  @HiveField(1)
  String medicineName;

  @HiveField(2)
  String dosage;

  @HiveField(3)
  DateTime scheduledTime;

  @HiveField(4)
  bool taken;

  @HiveField(5)
  DateTime? takenAt;

  MedicineLog({
    required this.medicineId,
    required this.medicineName,
    required this.dosage,
    required this.scheduledTime,
    this.taken = false,
    this.takenAt,
  });
}