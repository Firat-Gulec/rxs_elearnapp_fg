import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:widget_loading/widget_loading.dart';
import '../../core/Init/cache/cache_manager.dart';
import '../../core/Init/lang/locale_keys.g.dart';
import '../../core/Init/provider/theme_provider.dart';
import '../../core/constants.dart';
import '../../core/widget/appbar_widget.dart';

import '../../core/widget/input/normal_input_field.dart';
import '../../core/widget/profile_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/widget/textfield_widget.dart';
import 'package:rxs_elearnapp_fg/core/Init/auth/auth_require_state.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends AuthRequiredState<ProfileView>
    with CacheManager {
  Future<void> _changeTheme() async {
    setState(() {});
  }

  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();
  var _loading = true;
  late String imagePath =
      'https://sgulfrkzsmagewgaqqhe.supabase.co/storage/v1/object/public/avatars/avatar1.png';
  late XFile _profileImage;

  late File _pickedImage;
  late String _imagepath;

  /// Called once a user id is received within `onAuthenticated()`
  Future<void> _getProfile(String userId) async {
    setState(() {
      _loading = true;
    });

    final storageResponse =
        await supabase.storage.from('avatars').getPublicUrl('avatar1.png');
    final storageError = storageResponse.error;
    if (storageError != null) {
      context.showErrorSnackBar(message: storageError.message);
    }
    final storageData = storageResponse.data;
    if (storageData != null) {
      print(storageResponse.data.toString());
      print('object');
      //  imagePath = storageResponse.data.toString();
    }

    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single()
        .execute();

    final error = response.error;
    if (error != null && response.status != 406) {
      context.showErrorSnackBar(message: error.message);
    }
    final data = response.data;
    if (data != null) {
      _usernameController.text = (data['username'] ?? '') as String;
      _websiteController.text = (data['user_role'] ?? '') as String;
      //imagePath = (data['avatar_url'] ?? '') as String;
    }

    setState(() {
      imagePath = storageData.toString();
      _loading = false;
      print(imagePath);
      print('atama eğer');
      //_imageFile = ImagePicker.pickImage(source: imagePath)
    });
  }

  /// Called when user taps `Update` button
  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
//print(imagePath);

    final avatarFile = imagePath;

    final userName = _usernameController.text;
    final website = _websiteController.text;
    final user = supabase.auth.currentUser;

    /* final responseAvatar = await supabase.storage.from('avatars').upload(
        '${user?.id}/avatar1.png', avatarFile,
        fileOptions: FileOptions(cacheControl: '3600', upsert: false));
*/

    //print(user);
    final updates = {
      'id': user!.id,
      'username': userName,
      'user_role': website,
      //'avatar_url': imagePath,
      'updated_at': DateTime.now().toIso8601String(),
    };

    final response = await supabase.from('profiles').upsert(updates).execute();
    final error = response.error;
    print(error);
    if (error != null) {
      context.showErrorSnackBar(message: error.message);
    } else {
      context.showSnackBar(message: 'Successfully updated profile!');
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _signOut() async {
    final response = await supabase.auth.signOut();
    clearCache();
    final error = response.error;
    if (error != null) {
      context.showErrorSnackBar(message: error.message);
    }
  }

  @override
  void onAuthenticated(Session session) {
    final user = session.user;
    if (user != null) {
      _getProfile(user.id);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  WiperLoading(
                    interval: Duration(milliseconds: 750),
                    loading: _loading,
                    child: Center(
                        child: ImagePickerWidget(
                      diameter: 180,
                      initialImage: imagePath,
                      shape: ImagePickerWidgetShape.circle,
                      isEditable: true,
                      shouldCrop: true,
                      imagePickerOptions: ImagePickerOptions(imageQuality: 65),
                      onChange: (file) {
                        print("I changed the file to: ${file.path}");
                        setState(() {
                          // imagePath = file.path;
                        });
                      },
                    )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _usernameController.text,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  NormalInputField(
                      data: Theme.of(context),
                      controller: _usernameController,
                      onChanged: (text) {},
                      title: LocaleKeys.login_username.tr()),
                  const SizedBox(
                    height: 10,
                  ),
                  NormalInputField(
                      data: Theme.of(context),
                      controller: _websiteController,
                      onChanged: (text) {},
                      title: 'User Role'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                      onPressed: _updateProfile,
                      child: Text(_loading ? 'Saving...' : 'Update')),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: _signOut, child: const Text('Sign Out')),
                  ElevatedButton(
                      onPressed: () {
                        print(imagePath);
                      },
                      child: const Text('Change')),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

_BuildM(String imagepath) async {
  return ImagePickerWidget(
    diameter: 180,
    initialImage: imagepath,
    shape: ImagePickerWidgetShape.circle,
    isEditable: true,
    shouldCrop: true,
    imagePickerOptions: ImagePickerOptions(imageQuality: 65),
    onChange: (file) {
      print("I changed the file to: ${file.path}");
    },
  );
}
