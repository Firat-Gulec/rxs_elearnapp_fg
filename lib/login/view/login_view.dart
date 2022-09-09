import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rxs_elearnapp_fg/login/view/signup_view.dart';

import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import '../../core/Init/auth/auth_state.dart';
import '../../core/Init/cache/cache_manager.dart';
import '../../core/Init/lang/locale_keys.g.dart';
import '../../core/utilities/supabase_helper.dart';
import '../../core/widget/appbar_widget.dart';
import '../../core/widget/icon/circular_button.dart';
import '../../core/widget/icon/social_icon.dart';
import '../../core/widget/input/normal_input_field.dart';
import '../../core/widget/input/password_input_field.dart';
import '../../core/widget/padding/custom_padding.dart';
import '../../core/widget/padding/or_divider.dart';
import '../../core/widget/sheet/select_sheet.dart';
import '../service/login_service.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends AuthState<LoginView>
    with CacheManager, SingleTickerProviderStateMixin {

  // final ISocialLogin _twitterLogin = TwitterLogin();

  Future<void> _checknamepassControl(String name, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (password == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(LocaleKeys.login_incorrect.tr()),
      ));
    } else {
      final res = await SupabaseHelper().signinExitingUser(name, password);
      if (res.error?.message != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res.error!.message)));
      } else {
        navigation.navigateToPage(path: '/profile_view');
      }
    }
  }

  final TextEditingController usernameInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  bool hidePassword = true;
  bool hideLogin = false;
 

//Animation Controller ...
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> sizeAnimation;
  int currentState = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0, end: 60).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    sizeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 200)),
            Image.asset(
              'assets/images/rixos_logo.png',
              width: size.width * 0.60,
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            //Social Login Buttons(Google and Facebook)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                    //  text: '',
                    iconSrc: 'assets/images/facebook.png',
                    onPressed: (() async {
                      setState(() {});
                    })),
                Padding(padding: CustomPadding()),
                SocialIcon(
                    //   text: '',
                    iconSrc: 'assets/images/google.png',
                    onPressed: (() async {
                      setState(() {});
                    })),
                Padding(padding: CustomPadding()),
                SocialIcon(
                    //  text: '',
                    iconSrc: 'assets/images/twitter.png',
                    onPressed: (() async {
                      setState(() {});
                    })),
                Padding(padding: CustomPadding()),
                SocialIcon(
                    //  text: '',
                    iconSrc: 'assets/images/finger.png',
                    onPressed: (() async {
                      setState(() {});
                    })),
              ],
            ),
            //Input Login
            GestureDetector(
              child: OrDivider(
                customColor: Colors.brown,
              ),
              onTap: () {
                setState(() {
                  hideLogin = !hideLogin;
                  if (hideLogin == false) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                });
              },
            ),
            Padding(padding: CustomPadding()),

            Positioned(
              bottom: 0,
              child: Transform.scale(
                scale: sizeAnimation.value,
                child: SizedBox(
                  width: size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NormalInputField(
                          data: Theme.of(context),
                          controller: usernameInput,
                          onChanged: (text) {},
                          title: LocaleKeys.login_username.tr()),
                      Padding(padding: CustomPadding()),
                      PasswordInputField(
                          controller: passwordInput,
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
                      const Padding(padding: EdgeInsets.all(5)),
                   GestureDetector(
                        child: Container(
                          width: size.width * 0.6,
                          child: Text(LocaleKeys.login_forgotText.tr(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown)),
                        ),
                        onTap: () {
                          const UserSelectSheet().show(context);
                        },
                      ),
                      Padding(padding: CustomPadding()),
                      CircularButton(
                        title: LocaleKeys.login_sign.tr(),
                        onPressed: () async {
                          setState(() {
                            _checknamepassControl(
                                usernameInput.text, passwordInput.text);
                            LoginService().setLoginUser(
                                usernameInput.text, passwordInput.text);
                          });
                        },
                      ),
                      Padding(padding: CustomPadding()),
                      //Don't have an Account? Singup
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.login_dontAccount.tr()),
                          const Padding(padding: EdgeInsets.all(5)),
                          GestureDetector(
                            child: Text(LocaleKeys.login_signup.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return RegisterForm();
                                }),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
