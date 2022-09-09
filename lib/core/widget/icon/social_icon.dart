import 'package:flutter/material.dart';

class SocialIcon extends StatefulWidget {
  const SocialIcon({
    Key? key,
    required this.iconSrc,
    // required this.text,
    required this.onPressed,
  }) : super(key: key);

  final Future<void> Function() onPressed;
  final String iconSrc;
  //final String text;

  @override
  _SocialIconState createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon> {
  bool _isLoading = false;
  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _completeProcess() async {
    _changeLoading();
    await widget.onPressed();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading ? null : _completeProcess,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.brown),
          borderRadius: BorderRadius.circular(20),
          //shape: BoxShape.circle,
        ),
        child: Row(
          children: [
            Image.asset(
              widget.iconSrc,
              height: 45,
              width: 45,
            ),
            // const Padding(padding: EdgeInsets.only(left: 20)),
            /* Text(
              widget.text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),*/
          ],
        ),
      ),
    );
  }
}
