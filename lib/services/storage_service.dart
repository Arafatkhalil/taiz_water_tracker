// lib/services/storage_service.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taiz_water_tracker/models/water_consumption_model.dart';

class StorageService {
  static final StorageService instance = StorageService._init();
  static Database? _database;
  StorageService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tracker.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';
    await db.execute('''
      CREATE TABLE consumption (
        id $idType,
        amount $doubleType,
        date $textType,
        category $textType
      )
    ''');
  }

  Future<WaterConsumptionModel> insertConsumption(
      WaterConsumptionModel consumption) async {
    final db = await instance.database;
    final id = await db.insert('consumption', consumption.toMap());
    return WaterConsumptionModel(
        id: id,
        amount: consumption.amount,
        date: consumption.date,
        category: consumption.category);
  }

  Future<List<WaterConsumptionModel>> getAllConsumption() async {
    final db = await instance.database;
    final result = await db.query('consumption', orderBy: 'date DESC');
    return result.map((json) => WaterConsumptionModel.fromMap(json)).toList();
  }

  Future<double> getTodaysTotalConsumption() async {
    final db = await instance.database;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day).toIso8601String();
    final endOfDay =
        DateTime(now.year, now.month, now.day, 23, 59, 59).toIso8601String();
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM consumption WHERE date >= ? AND date <= ?',
      [startOfDay, endOfDay],
    );
    final total = result.first['total'];
    return (total as double?) ?? 0.0;
  }

  // ✅ --- تم نقل هذه الدالة إلى مكانها الصحيح هنا (داخل الكلاس) ---
  Future<Map<int, double>> getWeeklyConsumption() async {
    final db = await instance.database;
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 6));
    final startDate =
        DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day);

    final result = await db.rawQuery('''
      SELECT SUM(amount) as total, strftime('%w', date) as weekday
      FROM consumption
      WHERE date >= ?
      GROUP BY weekday
      ORDER BY date ASC
    ''', [startDate.toIso8601String()]);

    final Map<int, double> weeklyData = {};
    for (var item in result) {
      final weekday = int.parse(item['weekday'].toString());
      final total = (item['total'] as double?) ?? 0.0;
      weeklyData[weekday] = total;
    }
    return weeklyData;
  }
  // --- نهاية الدالة ---

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
