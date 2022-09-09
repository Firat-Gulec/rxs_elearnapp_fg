import 'package:flutter/material.dart';

import '../../../login/view/forgottenpass_view.dart';
import '../padding/custom_padding.dart';



class UserSelectSheet extends StatelessWidget {
  const UserSelectSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.normalHorizontal(),
      child: const ForgottenColumn(),
    );
  }
}

extension UserSelectSheetExtension on UserSelectSheet {
  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      isDismissible: false,
      builder: (context) {
        return this;
      },
    );
  }
}
