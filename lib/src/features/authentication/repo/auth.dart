// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/components/alert_dialogs.dart';
import 'package:kulobal/src/constant/dioconstants.dart';
import 'package:kulobal/src/constant/style.dart';
import 'authctl.dart';

class Authenticationstate extends Authcontroller {
  final GlobalKey<State> authKey = GlobalKey<State>();
  @override
  Future<bool> changepassword(BuildContext context,
      {required String oldpassword,
      required String newpassword,
      required String identifier}) async {
    final dio = Dio();

    showLoadingDialog(
        context: context, key: authKey, label: "Changing password");

    try {
      Response res = await dio.post(Dioconstants.changepasswordUrl,
          data: {
            "identifier": identifier,
            "oldPassword": oldpassword,
            "newPassword": newpassword,
            "confirmPassword": newpassword
          },
          options: Options(validateStatus: (status) => true));
      final response = res.data;

      if (res.statusCode == 200 || res.statusCode == 201) {
        print(res.data.runtimeType);
        print(response);
        Navigator.of(context, rootNavigator: true).pop();

        return true;
      }
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "Password Reset Error",
          exception: response["message"]);

      return false;
    } on DioException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "Password Change Error",
          exception: e.message);

      return false;
    }
  }

  @override
  Future<bool> forgotPassword(BuildContext context,
      {required String phonenumber}) async {
    final dio = Dio();
    showLoadingDialog(
        context: context, key: authKey, label: "Sending reset request.");
    try {
      Response res = await dio.post(Dioconstants.forgotPasswordUrl,
          data: {"phoneNumber": phonenumber},
          options: Options(validateStatus: (status) => true));
      final response = res.data;

      if (res.statusCode == 200 || res.statusCode == 201) {
        print(res.data.runtimeType);
        print(response);
        Navigator.of(context, rootNavigator: true).pop();
        return true;
      }
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "Password Reset Error",
          exception: response["message"]);
      return false;
    } on DioException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "Password Reset Error",
          exception: e.message);
      return false;
    }
  }

  @override
  Future<bool> register(BuildContext context,
      {required String email,
      required String password,
      required String firstname,
      required String lastname,
      required String phonenumber,
      required String location}) async {
    final dio = Dio();
    showLoadingDialog(context: context, key: authKey, label: "Signing you up");
    try {
      Response res = await dio.post(Dioconstants.registerUrl,
          options: Options(validateStatus: (status) => true),
          data: {
            "phoneNumber": phonenumber,
            "password": password,
            "email": email,
            "firstName": firstname,
            "lastName": lastname,
            "location": location
          });
      final response = res.data;
      if (res.statusCode == 200 || res.statusCode == 201) {
        print(res.data.runtimeType);
        print(response);
        Navigator.of(context, rootNavigator: true).pop();
        customToast(context, message: "Sign up successful");
        return true;
      }
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "Sign-up Error",
          exception: response["message"]);

      return false;
    } on DioException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context, title: "Sign-up Error", exception: e.message);
      return false;
    }
  }

  @override
  Future<void> logout() async {
    try {} catch (e) {
      log(e.toString());
    }
  }

  static Future verifyAccount(String phone) async {
    final dio = Dio();
    try {
      Response res = await dio.post(
        Dioconstants.resendOtpUrl,
        options: Options(validateStatus: (status) => true),
        data: {"phoneNumber": "0557466718"},
      );
      final response = res.data;

      if (res.statusCode == 200 || res.statusCode == 201) {
        print(response);
        return true;
      }
      log(response.toString());
      return false;
    } on DioException catch (e) {
      log(e.message.toString());
      return false;
    }
  }

  @override
  Future<bool> resendOtp(BuildContext context,
      {required String phonenumber}) async {
    final dio = Dio();
    showLoadingDialog(context: context, key: authKey, label: "Resending OTP");
    try {
      Response res = await dio.post(
        Dioconstants.resendOtpUrl,
        data: {"phoneNumber": phonenumber},
        options: Options(validateStatus: (status) => true),
      );
      final response = res.data;

      if (res.statusCode == 200 || res.statusCode == 201) {
        print(response);
        Navigator.of(context, rootNavigator: true).pop();
        return true;
      }
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "Otp Error",
          exception: "Could not make request");
      return false;
    } on DioException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context, title: "Otp Error", exception: e.message);
      return false;
    }
  }

  @override
  Future<bool> resetPassword(BuildContext context,
      {required String phonenumber,
      required String newpassword,
      required String otp}) async {
    final dio = Dio();
    try {
      Response res = await dio.post(Dioconstants.loginUrl, data: {
        "phoneNumber": phonenumber,
        "newPassword": newpassword,
        "confirmPassword": newpassword,
        "otp": otp
      });
      final response = res.data;

      if (res.statusCode == 200 || res.statusCode == 201) {
        print(res.data.runtimeType);
        print(response);
        Navigator.of(context, rootNavigator: true).pop();
        customToast(context,
            message: "Password reset successfully", textColor: KGreen);
        return true;
      }
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "Password Reset Error",
          exception: response["message"]);
      return false;
    } on DioException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "Password Reset Error",
          exception: e.message);
      return false;
    }
  }

  @override
  Future<bool> login(BuildContext context,
      {required String phonenumber, required String password}) async {
    final dio = Dio();
    showLoadingDialog(
        context: context, key: authKey, label: "Logging into your account.");

    try {
      Response res = await dio.post(Dioconstants.loginUrl,
          options: Options(validateStatus: (status) => true),
          data: {"phoneNumber": phonenumber, "password": password});
      final response = res.data;

      log(res.statusCode.toString());
      if (res.statusCode == 200 || res.statusCode == 201) {
        print(res.data.runtimeType);

        Navigator.of(context, rootNavigator: true).pop();
        return true;
      } else if (res.statusCode == 403 &&
          response["message"] == "verification-needed") {
        Navigator.of(context, rootNavigator: true).pop();
        log(response["message"]);
        // log(res.statusCode.toString());
        bool value = await verifyAccount(phonenumber);
        log(value.toString());
        if (value) {
          context.push("/otp", extra: phonenumber);
        }
        return false;
      } else if (res.statusCode == 503) {
        Navigator.of(context, rootNavigator: true).pop();

        showExceptionAlertDialog(
            context: context,
            title: "Sign-in Error",
            exception: res.statusMessage.toString());
        return false;
      }
      Navigator.of(context, rootNavigator: true).pop();

      showExceptionAlertDialog(
          context: context,
          title: "Sign-in Error",
          exception: response["message"]);
      log(response.toString());
      return false;
    } on DioException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context, title: "Sign-in Error", exception: e.message);
      return false;
    }
  }

  @override
  Future<bool> verifyOtp(BuildContext context,
      {required String phonenumber, required String otp}) async {
    final dio = Dio();
    showLoadingDialog(context: context, key: authKey, label: "Verifying otp");
    try {
      Response res = await dio.post(Dioconstants.verifyOtpUrl,
          data: {"phoneNumber": phonenumber, "otp": otp});
      final response = res.data;

      if (res.statusCode == 200 || res.statusCode == 201) {
        print(res.data.runtimeType);
        print(response);
        Navigator.of(context, rootNavigator: true).pop();
      }
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    } on DioException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "OTP verification Error",
          exception: e.message);

      return false;
    }
  }

  // static Future<String> gettoken() async => prefs.getString("token") ?? "";

  // static Future<bool> savetoken({required String token}) async =>
  //     prefs.setString(token, token);
}
