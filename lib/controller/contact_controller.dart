import 'package:contact_app/model/contact.dart';
import 'package:contact_app/services/database_service.dart';

class ContactController {
  final DBHelper dbHelper = DBHelper();

  Future<List<Contact>> getContacts() async {
    return await dbHelper.queryAllContacts();
  }

  Future<void> addContact(Contact contact) async {
    await dbHelper.insertContact(contact);
  }

  Future<void> updateContact(Contact contact) async {
    await dbHelper.updateContact(contact);
  }

  Future<void> deleteContact(int id) async {
    await dbHelper.deleteContact(id);
  }
}
