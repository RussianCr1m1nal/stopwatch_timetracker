import 'package:objectbox/objectbox.dart';

@Entity()
class PauseReason {
  @Id(assignable: true)
  int id;
  String name;
  String discription;

  PauseReason({this.id = 0, required this.name, required this.discription});
}
