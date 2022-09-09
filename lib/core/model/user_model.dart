import 'package:casbin/casbin.dart';

class UserModel {
  String name;
  String pass;
  Enforcer enForcer;
  UserModel({
    required this.name,
    required this.pass,
    required this.enForcer,
  });
}
