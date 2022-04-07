import 'package:equatable/equatable.dart';

class PauseReason extends Equatable {
  int id;
  String name;
  String discription;

  PauseReason({required this.name, required this.discription, required this.id});

  @override
  List<Object?> get props => [id, name, discription];
}
