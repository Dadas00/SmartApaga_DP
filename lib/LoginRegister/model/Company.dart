class Company {
  final String name;
  final String taxCode;
  final String legalAddress;
  final String signingDirector;
  final String email;
  
  Company({this.name, this.taxCode, this.legalAddress, this.signingDirector, this.email});
  
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      taxCode: json['taxCode'],
      legalAddress: json['legalAddress'],
      signingDirector: json['signingDirector'],
      email: json['email']
    );
  }

  Map toMap() {
    return {
      'name': name,
      'taxCode': taxCode,
      'legalAddress': legalAddress,
      'signingDirector': signingDirector,
      'email': email
    };
  }
}