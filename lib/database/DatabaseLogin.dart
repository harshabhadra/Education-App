import 'package:hive/hive.dart';
part 'DatabaseLogin.g.dart';
@HiveType(typeId: 3)
class DatabaseLogin {
  @HiveField(0)
  String email;
  @HiveField(1)
  String password;
  DatabaseLogin({
    this.email,
    this.password,
  });
}
