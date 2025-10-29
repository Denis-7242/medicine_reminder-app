import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/medicine_model.dart';
import '../services/hive_service.dart';
import '../services/notification_service.dart';

class MedicineProvider with ChangeNotifier {
  List<Medicine> _medicines = [];
  List<MedicineLog> _todayLogs = [];
  DateTime _selectedDate = DateTime.now();

  List<Medicine> get medicines => _medicines;
  List<MedicineLog> get todayLogs => _todayLogs;
  DateTime get selectedDate => _selectedDate;

  MedicineProvider() {
    loadMedicines();
    loadTodayLogs();
  }

  void loadMedicines() {
    _medicines = HiveService.getAllMedicines();
    notifyListeners();
  }

  void loadTodayLogs() {
    _todayLogs = HiveService.getLogsForDate(_selectedDate);
    _generateMissingLogs();
    notifyListeners();
  }

  void _generateMissingLogs() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (var medicine in _medicines) {
      for (var timeStr in medicine.times) {
        final timeParts = timeStr.split(':');
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);

        final scheduledTime = DateTime(
          today.year,
          today.month,
          today.day,
          hour,
          minute,
        );

        // Check if log already exists
        final existingLog = _todayLogs.firstWhere(
          (log) =>
              log.medicineId == medicine.id &&
              log.scheduledTime.hour == scheduledTime.hour &&
              log.scheduledTime.minute == scheduledTime.minute,
          orElse: () => MedicineLog(
            medicineId: '',
            medicineName: '',
            dosage: '',
            scheduledTime: DateTime.now(),
          ),
        );

        if (existingLog.medicineId.isEmpty) {
          final newLog = MedicineLog(
            medicineId: medicine.id,
            medicineName: medicine.name,
            dosage: medicine.dosage,
            scheduledTime: scheduledTime,
          );
          HiveService.addLog(newLog);
          _todayLogs.add(newLog);
        }
      }
    }

    _todayLogs.sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
  }

  Future<void> addMedicine(Medicine medicine) async {
    await HiveService.addMedicine(medicine);
    await NotificationService.scheduleMedicineNotifications(medicine);
    loadMedicines();
    loadTodayLogs();
  }

  Future<void> updateMedicine(Medicine medicine) async {
    await HiveService.updateMedicine(medicine);
    await NotificationService.scheduleMedicineNotifications(medicine);
    loadMedicines();
    loadTodayLogs();
  }

  Future<void> deleteMedicine(String id) async {
    await HiveService.deleteMedicine(id);
    await NotificationService.cancelMedicineNotifications(id);
    loadMedicines();
    loadTodayLogs();
  }

  Future<void> markAsTaken(MedicineLog log, bool taken) async {
    log.taken = taken;
    log.takenAt = taken ? DateTime.now() : null;
    await HiveService.updateLog(log);
    loadTodayLogs();
  }

  void changeDate(DateTime date) {
    _selectedDate = date;
    _todayLogs = HiveService.getLogsForDate(date);
    notifyListeners();
  }

  List<MedicineLog> getAllHistory() {
    return HiveService.getAllLogs();
  }

  Map<String, List<MedicineLog>> getGroupedHistory() {
    final allLogs = getAllHistory();
    final Map<String, List<MedicineLog>> grouped = {};

    for (var log in allLogs) {
      final dateKey = DateFormat('yyyy-MM-dd').format(log.scheduledTime);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(log);
    }

    return grouped;
  }
}