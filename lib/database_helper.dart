import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'orukam.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE settings(
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
    await db.insert('settings', {'key': 'competition_name', 'value': 'Ma Compétition'});
    await db.execute('''
      CREATE TABLE tapis(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE persons(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        type INTEGER,
        tapisId INTEGER,
        isLead INTEGER,
        FOREIGN KEY (tapisId) REFERENCES tapis (id) ON DELETE CASCADE
      )
    ''');
  }

  // Tapis operations
  Future<int> insertTapis(Tapis tapis) async {
    Database db = await database;
    return await db.insert('tapis', tapis.toMap());
  }

  Future<List<Tapis>> getTapisList() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tapis');
    return List.generate(maps.length, (i) => Tapis.fromMap(maps[i]));
  }

  Future<int> deleteTapis(int id) async {
    Database db = await database;
    // Persons associated with this tapis should be deleted too if we want to be clean, 
    // or just their tapisId set to null. Let's delete them.
    await db.delete('persons', where: 'tapisId = ?', whereArgs: [id]);
    return await db.delete('tapis', where: 'id = ?', whereArgs: [id]);
  }

  // Person operations
  Future<int> insertPerson(Person person) async {
    Database db = await database;
    return await db.insert('persons', person.toMap());
  }

  Future<List<Person>> getPersons() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('persons');
    return List.generate(maps.length, (i) => Person.fromMap(maps[i]));
  }

  Future<int> updatePerson(Person person) async {
    Database db = await database;
    return await db.update(
      'persons',
      person.toMap(),
      where: 'id = ?',
      whereArgs: [person.id],
    );
  }

  Future<int> deletePerson(int id) async {
    Database db = await database;
    return await db.delete('persons', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAll() async {
    Database db = await database;
    await db.delete('persons');
    await db.delete('tapis');
    await db.update('settings', {'value': 'Nouvelle Compétition'}, where: 'key = ?', whereArgs: ['competition_name']);
  }

  // Settings operations
  Future<String> getCompetitionName() async {
    Database db = await database;
    // Create table if it doesn't exist (for existing users)
    await db.execute('CREATE TABLE IF NOT EXISTS settings (key TEXT PRIMARY KEY, value TEXT)');
    final List<Map<String, dynamic>> maps = await db.query('settings', where: 'key = ?', whereArgs: ['competition_name']);
    if (maps.isEmpty) {
      await db.insert('settings', {'key': 'competition_name', 'value': 'Ma Compétition'});
      return 'Ma Compétition';
    }
    return maps.first['value'];
  }

  Future<void> updateCompetitionName(String name) async {
    Database db = await database;
    await db.update('settings', {'value': name}, where: 'key = ?', whereArgs: ['competition_name']);
  }
}
