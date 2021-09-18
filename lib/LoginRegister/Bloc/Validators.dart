class Validators {
  static final RegExp _fullNNameRegExp = RegExp(
    r'^[a-z A-Z,.\-]+$',
  );
//+37498998899
  static RegExp get _phoneRegExp => RegExp(
        r'(^(?:[+0]9)?[0-9]{10,12}$)',
      );

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static final RegExp _passwordRegExp = RegExp(
    '^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}',
  );

  static final RegExp _streetNameRegExp = RegExp(
    '^[a-zA-Z0-9]+',
  );

  static final RegExp _bdgRegExp = RegExp(
    '^[a-zA-Z0-9]+',
  );

  static final RegExp _aptRegExp = RegExp(
    '^[a-zA-Z0-9]+',
  );
  static final RegExp _floorRegExp = RegExp(
    '^[a-zA-Z0-9]+',
  );
  static final RegExp _entryRegExp = RegExp(
    '^[a-zA-Z0-9]+',
  );
  static final RegExp _comentRegExp = RegExp(
    '^[a-zA-Z0-9]+',
  );
  static final RegExp _contactPhoneNum = RegExp(
    r'(^(?:[+0]9)?[0-9]{10,12}$)',
  );

  static isValidLongitude(String longitude) {
    return longitude.length > 3;
  }

  static isValidLatitude(String latitude) {
    return latitude.length > 3;
  }

  static isValidContactPhoneNm(String phoneNm) {
    return _contactPhoneNum.hasMatch(phoneNm);
  }

  static isValidStreetName(String streetname) {
    return _streetNameRegExp.hasMatch(streetname);
  }

  static isValidBdg(String bdg) {
    return _bdgRegExp.hasMatch(bdg);
  }

  static isValidapt(String apt) {
    return _aptRegExp.hasMatch(apt);
  }

  static isValidfloor(String floor) {
    return _floorRegExp.hasMatch(floor);
  }

  static isValidEntry(String entry) {
    return _entryRegExp.hasMatch(entry);
  }

  static isValidFullName(String fullName) {
    return _fullNNameRegExp.hasMatch(fullName);
  }

  static isValidPhone(String phone) {
    return _phoneRegExp.hasMatch(phone);
  }

  static isValidComent(String coment) {
    return _comentRegExp.hasMatch(coment);
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidLegalName(String legalName) {
    return _fullNNameRegExp.hasMatch(legalName);
  }

  static isValidTaxCode(String taxCode) {
    return _fullNNameRegExp.hasMatch(taxCode);
  }

  static isValidLegalAddress(String legalAddress) {
    return _fullNNameRegExp.hasMatch(legalAddress);
  }

  static isValidSdn(String sdn) {
    return _fullNNameRegExp.hasMatch(sdn);
  }
}
