import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rxs_elearnapp_fg/profile/view/profile_view.dart';

import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import '../../core/Init/auth/auth_state.dart';
import '../../core/Init/lang/locale_keys.g.dart';
import '../../core/constants.dart';
import '../../core/utilities/supabase_helper.dart';
import '../../core/widget/appbar_custom.dart';
import '../../core/widget/header_widget.dart';
import '../../core/widget/icon/circular_button.dart';
import '../../core/widget/input/normal_input_field.dart';
import '../../core/widget/input/password_input_field.dart';
import '../../core/widget/padding/custom_padding.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends AuthState<RegisterForm> {
  TextEditingController usernameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  TextEditingController repasswordInput = TextEditingController();
  bool hidePassword = true;
  bool _isLoading = false;

  Future<void> signInWithEmail() async {
    await supabase.auth
        .signIn(email: usernameInput.text, password: passwordInput.text);
  }

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });

    final res = await SupabaseHelper()
        .createNewUser(usernameInput.text, passwordInput.text);
    final user = res.data?.user;
    final error = res.error;
    if (res.error?.message != null) {
      await ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.error!.message),
        ),
      );
      usernameInput.text = '';
      passwordInput.text = '';
      repasswordInput.text = '';
    } else {
      print('verify account');

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const ProfileView();
        },
      ));
    }

    print(user?.id);
    print(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarCustom(title: LocaleKeys.signup_signup.tr(), context: context),
      body: SingleChildScrollView(
        //  padding: CustomPadding.normalHorizontal(),
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 150,
              width: size.width,
              child: const HeaderWidget(
                  150, false, Icons.person_add_alt_1_rounded),
            ),
            SingleChildScrollView(
                padding: CustomPadding.normalHorizontal(),
                child: Column(children: <Widget>[
                  Padding(padding: CustomPadding()),
                  Image.asset(
                    'assets/images/rixos_logo.png',
                    width: size.width * 0.50,
                  ),
                  Padding(padding: CustomPadding()),
                  NormalInputField(
                    data: Theme.of(context),
                    title: LocaleKeys.signup_username.tr(),
                    controller: usernameInput,
                    onChanged: (text) {},
                  ),
                  Padding(padding: CustomPadding()),
                  PasswordInputField(
                      controller: passwordInput,
                      title: LocaleKeys.signup_repassword.tr(),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: Icon(
                          hidePassword == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                        ),
                      ),
                      data: Theme.of(context),
                      obscureText: hidePassword),
                  Padding(padding: CustomPadding()),
                  PasswordInputField(
                      controller: repasswordInput,
                      title: LocaleKeys.login_password.tr(),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: Icon(
                          hidePassword == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                        ),
                      ),
                      data: Theme.of(context),
                      obscureText: hidePassword),
                  Padding(padding: CustomPadding()),
                  CircularButton(
                    title: LocaleKeys.signup_signup.tr(),
                    onPressed: () async {
                      _signUp();
                    },
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
