

import 'package:flutter/material.dart';

import '../presenter/on_trade_calculation_presenter.dart';

class HorizontalOptions extends StatefulWidget {
  const HorizontalOptions({super.key, required this.onTap});

  final Function(RR) onTap;

  @override
  _HorizontalOptionsState createState() => _HorizontalOptionsState();
}

class _HorizontalOptionsState extends State<HorizontalOptions> {
  final List<String> options = ['1', '2', '3','4','6','custom'];
  String selectedOption = '1';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: options.map((option) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedOption = option;
              RR type = RR.one;
              if(option == "2"){
                type = RR.two;
              } else if(option == "3"){
                type = RR.three;
              } else if(option == "custom"){
                type = RR.other;
              }else if(option == "4"){
                type = RR.four;
              }else if(option == "6"){
                type = RR.six;
              }
              widget.onTap(type);
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: selectedOption == option ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}