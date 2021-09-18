import 'package:equatable/equatable.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';

abstract class PickupEvent extends Equatable {
  List<Object> get props => [];
}

class PickupSumbited extends PickupEvent {
  final Pickup pickup;

  PickupSumbited({this.pickup});
  List<Object> get props => [pickup];
}

class PicupNoteChanged extends PickupEvent {
  final String note;

  PicupNoteChanged({this.note});
  List<Object> get props => [note];
}
