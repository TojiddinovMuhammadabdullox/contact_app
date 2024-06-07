import 'dart:math';
import 'package:contact_app/controller/contact_controller.dart';
import 'package:contact_app/model/contact.dart';
import 'package:contact_app/views/widget/contact_dialog.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Contact> contacts = [];
  ContactController contactController = ContactController();
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  void _fetchContacts() async {
    final allContacts = await contactController.getContacts();
    setState(() {
      contacts = allContacts;
    });
  }

  void _addOrEditContact({Contact? contact}) async {
    final result = await showDialog<Contact>(
      context: context,
      builder: (context) => ContactDialog(contact: contact),
    );
    if (result != null) {
      if (contact == null) {
        await contactController.addContact(result);
      } else {
        await contactController.updateContact(result);
      }
      _fetchContacts();
    }
  }

  void _deleteContact(int id) async {
    await contactController.deleteContact(id);
    _fetchContacts();
  }

  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          final avatarColor = _getRandomColor();
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: avatarColor,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(contact.name),
                            const SizedBox(height: 3),
                            Text(contact.phone),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () => _addOrEditContact(contact: contact),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => _deleteContact(contact.id!),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addOrEditContact(),
      ),
    );
  }
}
