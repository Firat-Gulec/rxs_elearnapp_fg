import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../navigation/navigation_constants.dart';
import '../navigation/navigation_service.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  NavigationService navigation = NavigationService.instance;
  late String navigateString;
  void onUnauthenticated() {
    if (mounted) {
      navigation.navigateToPage(path: NavigationConstants.LOGIN);
    }
  }

  @override
  void onAuthenticated(Session session) {
    if (mounted) {
      navigation.navigateToPage(path: NavigationConstants.PROFILE_VIEW);
    }
  }

  @override
  void onPasswordRecovery(Session session) {
    if (mounted) {
      
    }
  }

  @override
  void onErrorAuthenticating(String message) {
   // context.showErrorSnackBar(message: message);
    print(message);
  }
}
