import 'package:flutter/material.dart';

class CircularButton extends StatefulWidget {
  const CircularButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.isCircle = false,
      this.primaryColor})
      : super(key: key);

  final String title;
  final bool isCircle;
  final Color? primaryColor;
  final Future<void> Function() onPressed;

  @override
  _CircularButtonState createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
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
    final Size size = MediaQuery.of(context).size;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(size.width * 0.3, 50),
          primary: Color.fromRGBO(100,81,61,100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // <-- Radius
          ),
        ), //widget.isCircle ? const CircleBorder() : null),
        onPressed: _isLoading ? null : _completeProcess,
        child: _isLoading
            ? const CircularProgressIndicator()
            : Text(widget.title));
  }
}
