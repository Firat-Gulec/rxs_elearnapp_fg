import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget? widget;
  const CustomInputField(
      {Key? key,
      required this.title,
      required this.hint,
      required this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Container(
            height: 52,
            margin: const EdgeInsets.only(top: 5.0),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    //cursorColor: ThemeData.dark().focusColor,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hint,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      ),
              ],
            )),
      ],
    );
  }
}
