import 'dart:async';

class ValidationMixin {
  final validatorEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (!email.contains('@')) {
        sink.addError('Plase enter a valid email');
      } else if (email.indexOf('.') == -1) {
        sink.addError('Seriusly');
      } else {
        sink.add(email);
      }
    },
  );

  final validatorPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 8) {
        sink.add(password);
      } else {
        sink.addError('Use better more then 8 charakter!');
      }
    },
  );
}

// class Validators {
//   static final RegExp _emailRegExp = RegExp(
//     r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
//   );
  
//   static final RegExp _passwordRegExp = RegExp(
//     r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
//   );

//   static isValidEmail(String email) {
//     return _emailRegExp.hasMatch(email);
//   }

//   static isValidPassword(String password) {
//     return _passwordRegExp.hasMatch(password);
//   }
// }