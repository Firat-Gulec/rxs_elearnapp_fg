import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants.dart';

class SupabaseHelper {
  final supaClient = Supabase.instance.client;

// email-password sign up
  Future<GotrueSessionResponse> createNewUser(
      String email, String password) async {
    final res = await supabase.auth.signUp(email, password, options: AuthOptions(
            redirectTo: kIsWeb
                ? null
                : 'io.supabase.flutterquickstart://login-callback/'));
    return res;
  }

// email-password sign in
  Future<GotrueSessionResponse> signinExitingUser(
      String email, String password) async {
    final res = await supaClient.auth.signIn(email: email, password: password);
    return res;
  }


   Future<GotrueJsonResponse> forgottenUserPass(
      String email) async {
    final res = await supaClient.auth.api.resetPasswordForEmail(email,options: AuthOptions( redirectTo: kIsWeb
                ? null : 'io.supabase.flutterquickstart://login-callback/'));
    //const { data, error } = await supabase.auth.api.resetPasswordForEmail(emailInput);
    return res;
  }

// phone auth with password and verification step
  Future<GotrueSessionResponse> createNewPhoneUser(
      String phone, String password) async {
    final res = await supaClient.auth.signUpWithPhone(phone, password);
    return res;
  }

  Future<GotrueSessionResponse> verifyPhoneUser(
      String phone, String token) async {
    final res = await supaClient.auth.verifyOTP(phone, token,
        options: AuthOptions(redirectTo: 'io.supabase.flutterquickstart://login-callback/'));
    return res;
  }
/*
  Future<GotrueSessionResponse> signInUserWithPhone(
      String phone, String password) async {
    final res = await supaClient.auth.signIn(phone: phone, password: password);
    return res;
  }
*/
  
}
