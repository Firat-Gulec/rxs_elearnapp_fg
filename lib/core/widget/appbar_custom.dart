import 'package:flutter/material.dart';

class AppBarCustom extends AppBar {
  AppBarCustom({Key? key, required String title, required BuildContext context})
      : super(
          key: key,
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0.5,
          // automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Theme.of(context).primaryColor,
                  Theme.of(context).backgroundColor,
                ])),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(
                top: 16,
                right: 16,
              ),
            )
          ],
        );
}
