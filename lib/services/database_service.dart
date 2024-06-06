import 'package:contact_app/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT
      )
    ''');
  }

  Future<int> insertContact(Contact contact) async {
    Database db = await database;
    return await db.insert('contacts', contact.toMap());
  }

  Future<List<Contact>> queryAllContacts() async {
    Database db = await database;
    final contacts = await db.query('contacts');
    return contacts.map((row) => Contact.fromMap(row)).toList();
  }

  Future<int> updateContact(Contact contact) async {
    Database db = await database;
    return await db.update('contacts', contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
