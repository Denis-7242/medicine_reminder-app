import 'package:hive_flutter/hive_flutter.dart';
import '../models/medicine_model.dart';

class HiveService {
  static const String medicineBoxName = 'medicines';
  static const String logBoxName = 'medicineLogs';

  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(MedicineAdapter());
    Hive.registerAdapter(MedicineLogAdapter());
    
    // Open boxes
    await Hive.openBox<Medicine>(medicineBoxName);
    await Hive.openBox<MedicineLog>(logBoxName);
  }

  static Box<Medicine> getMedicineBox() {
    return Hive.box<Medicine>(medicineBoxName);
  }

  static Box<MedicineLog> getLogBox() {
    return Hive.box<MedicineLog>(logBoxName);
  }

  static Future<void> addMedicine(Medicine medicine) async {
    final box = getMedicineBox();
    await box.put(medicine.id, medicine);
  }

  static Future<void> updateMedicine(Medicine medicine) async {
    await medicine.save();
  }

  static Future<void> deleteMedicine(String id) async {
    final box = getMedicineBox();
    await box.delete(id);
  }

  static List<Medicine> getAllMedicines() {
    final box = getMedicineBox();
    return box.values.where((m) => m.isActive).toList();
  }

  static Future<void> addLog(MedicineLog log) async {
    final box = getLogBox();
    await box.add(log);
  }

  static List<MedicineLog> getLogsForDate(DateTime date) {
    final box = getLogBox();
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    
    return box.values
        .where((log) =>
            log.scheduledTime.isAfter(startOfDay) &&
            log.scheduledTime.isBefore(endOfDay))
        .toList();
  }

  static List<MedicineLog> getAllLogs() {
    final box = getLogBox();
    return box.values.toList()..sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));
  }

  static Future<void> updateLog(MedicineLog log) async {
    await log.save();
  }
}