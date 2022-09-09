import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/Init/auth/auth_state.dart';
import '../../core/Init/lang/locale_keys.g.dart';
import '../../core/utilities/supabase_helper.dart';
import '../../core/widget/icon/circular_button.dart';
import '../../core/widget/input/normal_input_field.dart';

class ForgottenColumn extends StatefulWidget {
  const ForgottenColumn({Key? key}) : super(key: key);

  @override
  _ForgottenColumnState createState() => _ForgottenColumnState();
}

class _ForgottenColumnState extends AuthState<ForgottenColumn> {
  final String _title = LocaleKeys.login_forgotText.tr();
  TextEditingController emailInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        const Divider(indent: 150, endIndent: 150),
        const Padding(padding: EdgeInsets.all(10)),
        Image.asset(
          'assets/images/rixos_logo.png',
          width: size.width * 0.50,
        ),
        const Padding(padding: EdgeInsets.all(10)),
        NormalInputField(
          data: Theme.of(context),
          title: LocaleKeys.login_username.tr(),
          controller: emailInput,
          onChanged: (text) {},
        ),
        const Padding(padding: EdgeInsets.all(10)),
        CircularButton(
            title: _title,
            onPressed: () async {
              SupabaseHelper().forgottenUserPass(emailInput.text);
            }),
      ],
    );
  }
}
