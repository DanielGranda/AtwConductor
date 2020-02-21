import 'package:flutter/material.dart';

class UserAdmin {
  UserAdmin(
      {@required this.uid,
      this.nombres,
      this.cedula,
      this.password,
      this.email,
      this.photoUrl});

  final String uid;
  final String nombres;
  final String cedula;
  final String email;
  final String photoUrl;
  final String password;
}
