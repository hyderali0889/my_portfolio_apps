// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:objectbox/objectbox.dart";

@Entity()
class User {
  int id;
  String name;
  String address;
  User({
     this.id = 0,
    required this.name,
    required this.address,
  });
}
