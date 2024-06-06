class Contact {
  int? id;
  String name;
  String phone;

  Contact(
      {this.id,
      required this.name,
      required this.phone,
      required String firstName,
      required String lastName});

  factory Contact.fromMap(Map<String, dynamic> json) => new Contact(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        firstName: '',
        lastName: '',
      );

  String? get firstName => null;

  String? get lastName => null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}
