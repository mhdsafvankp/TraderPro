
import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onPressed, required this.title});


  final Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(
              const Color(0xff0642a2)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              // Change your radius here
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          elevation: MaterialStateProperty.all(10)),
      child: Text(title , style: TextStyle(color: Colors.white),),
    );
  }
}
