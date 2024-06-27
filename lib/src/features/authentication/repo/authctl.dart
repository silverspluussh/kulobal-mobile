import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kulobal/src/features/authentication/repo/auth.dart';

part 'authctl.g.dart';

abstract class Authcontroller {
  Future<bool> register(BuildContext context,
      {required String email,
      required String password,
      required String firstname,
      required String lastname,
      required String phonenumber,
      required String location});
  Future<bool> login(BuildContext context,
      {required String phonenumber, required String password});
  Future<void> logout();
  Future<bool> verifyOtp(BuildContext context,
      {required String phonenumber, required String otp});
  Future<bool> resendOtp(BuildContext context, {required String phonenumber});
  Future<bool> forgotPassword(BuildContext context,
      {required String phonenumber});
  Future<bool> resetPassword(BuildContext context,
      {required String phonenumber,
      required String newpassword,
      required String otp});
  Future<bool> changepassword(BuildContext context,
      {required String oldpassword,
      required String newpassword,
      required String identifier});
}

@Riverpod(keepAlive: true)
Authenticationstate authController(AuthControllerRef ref) =>
    Authenticationstate();
