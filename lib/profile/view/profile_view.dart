import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../core/Init/provider/theme_provider.dart';
import '../../core/widget/appbar_widget.dart';
import '../../core/widget/button_widget.dart';
import '../../core/widget/profile_widget.dart';
import '../../core/widget/textfield_widget.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<void> _changeTheme() async {
    setState(() {});
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
                  ProfileWidget(
                    imagePath: 'imagePath',
                    isEdit: true,
                    onClicked: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image == null) return;
//
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'veli.duman@rixos.com',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextFieldWidget(
                      label: 'User Name',
                      text: 'Veli Duman',
                      onChanged: ((value) {})),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      label: 'About',
                      text: 'user.about',
                      maxLines: 5,
                      onChanged: ((value) {})),
                  const SizedBox(height: 24),
                  ButtonWidget(
                    text: 'Save',
                    onClicked: (() {}),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    text: 'Sign Out',
                    onClicked: (() {}),
                  ),
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
