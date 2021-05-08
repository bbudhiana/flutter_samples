import 'package:meta/meta.dart';

class Myuser {
  final String name;
  final String email;

  Myuser({@required this.name, @required this.email});

  @override
  String toString() => 'User { name: $name, email: $email}';
}
