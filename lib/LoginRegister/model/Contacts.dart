class Contact {
  final int id;
  final String phoneNumber;

  Contact({
    this.id,
    this.phoneNumber,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
    );
  }
  Map toMap() {
    return {
      'id': id ?? '',
      'phoneNumber': phoneNumber ?? ' ',
    };
  }
}
