import 'package:equatable/equatable.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';

// abstract class PickupState extends Equatable {
//   List<Object> get props => [];
// }

// ignore: must_be_immutable
class PickupState {
  String note;

  PickupState({this.note});

  List<Object> get props => [note];
  PickupState update({
    String note,
  }) {
    return copyWith(
      note: note,
    );
  }

  PickupState copyWith({
    String note,
  }) {
    return PickupState(
      note: note ?? note,
    );
  }
}

class PickupInitial extends PickupState {}
