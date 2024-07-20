import 'package:flutter/material.dart';
import 'package:trader_pro/model/calculation_model.dart';

import '../../presenter/pre_trade_calculation_presenter.dart';
import '../../utilities/contants.dart';
import '../../widgets/button.dart';
import '../../widgets/input_field.dart';
import '../../widgets/responsive_widget.dart';
import '../view_contracts/pre_trade_calc_view_contract.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements PreTradeCalViewContract {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController riskController = TextEditingController();
  final TextEditingController slController = TextEditingController();
  final TextEditingController deltaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final PreTradeCalculationPresenter presenter;

  TextFieldType? _selectedOption = TextFieldType.qty;
  bool _isToggled = false;

  @override
  void initState() {
    super.initState();

    // setting the presenter object
    presenter = PreTradeCalculationPresenter(calViewContract: this);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      large: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width * 0.2)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff0642a2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    '${widget.title} $calculator',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        quantityController.clear();
                                        riskController.clear();
                                        slController.clear();
                                        deltaController.clear();
                                      },
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
                                      child: const Text('Reset'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(simple,
                                  style: TextStyle(fontWeight: FontWeight.w500)),
                              Switch(
                                value: _isToggled,
                                onChanged: (bool value) {
                                  presenter.toggleSelection(value);
                                },
                              ),
                              Text(advanced,
                                  style: TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Container(
                              width: double.infinity,
                              height: 1, // 1dp height
                              color: const Color(0xff0642a2), // Line color
                            ),
                          ),
                          const Text(
                            chooseType,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Wrap(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<TextFieldType>(
                                    value: TextFieldType.qty,
                                    groupValue: _selectedOption,
                                    onChanged: (TextFieldType? value) {
                                      presenter.chooseTypeRadio(value);
                                    },
                                  ),
                                  Text(quantity),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<TextFieldType>(
                                    value: TextFieldType.risk,
                                    groupValue: _selectedOption,
                                    onChanged: (TextFieldType? value) {
                                      presenter.chooseTypeRadio(value);
                                    },
                                  ),
                                  Text(risk),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<TextFieldType>(
                                    value: TextFieldType.sl,
                                    groupValue: _selectedOption,
                                    onChanged: (TextFieldType? value) {
                                      presenter.chooseTypeRadio(value);
                                    },
                                  ),
                                  Text(stopLoss),
                                ],
                              ),
                              if (_isToggled)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio<TextFieldType>(
                                      value: TextFieldType.delta,
                                      groupValue: _selectedOption,
                                      onChanged: (TextFieldType? value) {
                                        presenter.chooseTypeRadio(value);
                                      },
                                    ),
                                    Text(delta),
                                  ],
                                )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Container(
                              width: double.infinity,
                              height: 1, // 1dp height
                              color: const Color(0xff0642a2), // Line color
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: NumberTextField(
                                    labelString: quantity,
                                    controller: quantityController,
                                    onChanged: (value) {
                                      print('value :$value');
                                    },
                                    readOnly: _selectedOption == TextFieldType.qty,
                                    isDecimal: false,
                                    isZeroToOne: false,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: NumberTextField(
                                    labelString: risk,
                                    controller: riskController,
                                    onChanged: (value) {},
                                    readOnly: _selectedOption == TextFieldType.risk,
                                    isDecimal: true,
                                    isZeroToOne: false,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: NumberTextField(
                                    labelString: stopLoss,
                                    controller: slController,
                                    onChanged: (value) {},
                                    readOnly: _selectedOption == TextFieldType.sl,
                                    isDecimal: true,
                                    isZeroToOne: false,
                                  ),
                                ),
                                if (_isToggled)
                                  const SizedBox(
                                    width: 16,
                                  ),
                                if (_isToggled)
                                  Expanded(
                                    child: NumberTextField(
                                      labelString: delta,
                                      controller: deltaController,
                                      onChanged: (value) {},
                                      readOnly:
                                      _selectedOption == TextFieldType.delta,
                                      isDecimal: true,
                                      isZeroToOne: true,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      print('no error');
                                      presenter.calculate(
                                          quantityController.text,
                                          riskController.text,
                                          slController.text,
                                          deltaController.text,
                                          _selectedOption!,
                                          _isToggled);
                                    } else {
                                      print('there is an error!!');
                                    }
                                  },
                                  child: Text('Calculate'),
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
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      small: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff0642a2),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  '${widget.title} $calculator',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: MyButton(
                                        onPressed: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          quantityController.clear();
                                          riskController.clear();
                                          slController.clear();
                                          deltaController.clear();
                                        },
                                        title: 'Reset'))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(simple,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            Switch(
                              value: _isToggled,
                              onChanged: (bool value) {
                                presenter.toggleSelection(value);
                              },
                            ),
                            Text(advanced,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Container(
                            width: double.infinity,
                            height: 1, // 1dp height
                            color: const Color(0xff0642a2), // Line color
                          ),
                        ),
                        const Text(
                          chooseType,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Wrap(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<TextFieldType>(
                                  value: TextFieldType.qty,
                                  groupValue: _selectedOption,
                                  onChanged: (TextFieldType? value) {
                                    presenter.chooseTypeRadio(value);
                                  },
                                ),
                                Text(quantity),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<TextFieldType>(
                                  value: TextFieldType.risk,
                                  groupValue: _selectedOption,
                                  onChanged: (TextFieldType? value) {
                                    presenter.chooseTypeRadio(value);
                                  },
                                ),
                                Text(risk),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<TextFieldType>(
                                  value: TextFieldType.sl,
                                  groupValue: _selectedOption,
                                  onChanged: (TextFieldType? value) {
                                    presenter.chooseTypeRadio(value);
                                  },
                                ),
                                Text(stopLoss),
                              ],
                            ),
                            if (_isToggled)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<TextFieldType>(
                                    value: TextFieldType.delta,
                                    groupValue: _selectedOption,
                                    onChanged: (TextFieldType? value) {
                                      presenter.chooseTypeRadio(value);
                                    },
                                  ),
                                  Text(delta),
                                ],
                              )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Container(
                            width: double.infinity,
                            height: 1, // 1dp height
                            color: const Color(0xff0642a2), // Line color
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: NumberTextField(
                                  labelString: quantity,
                                  controller: quantityController,
                                  onChanged: (value) {
                                    print('value :$value');
                                  },
                                  readOnly: _selectedOption == TextFieldType.qty,
                                  isDecimal: false,
                                  isZeroToOne: false,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: NumberTextField(
                                  labelString: risk,
                                  controller: riskController,
                                  onChanged: (value) {},
                                  readOnly: _selectedOption == TextFieldType.risk,
                                  isDecimal: true,
                                  isZeroToOne: false,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: NumberTextField(
                                  labelString: stopLoss,
                                  controller: slController,
                                  onChanged: (value) {},
                                  readOnly: _selectedOption == TextFieldType.sl,
                                  isDecimal: true,
                                  isZeroToOne: false,
                                ),
                              ),
                              if (_isToggled)
                                const SizedBox(
                                  width: 16,
                                ),
                              if (_isToggled)
                                Expanded(
                                  child: NumberTextField(
                                    labelString: delta,
                                    controller: deltaController,
                                    onChanged: (value) {},
                                    readOnly:
                                    _selectedOption == TextFieldType.delta,
                                    isDecimal: true,
                                    isZeroToOne: true,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyButton(
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      print('no error');
                                      presenter.calculate(
                                          quantityController.text,
                                          riskController.text,
                                          slController.text,
                                          deltaController.text,
                                          _selectedOption!,
                                          _isToggled);
                                    } else {
                                      print('there is an error!!');
                                    }
                                  },
                                  title: 'Calculate'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    quantityController.dispose();
    riskController.dispose();
    slController.dispose();
    deltaController.dispose();
    super.dispose();
  }

  @override
  void chooseTypeRadio(TextFieldType? type) {
    if (type == TextFieldType.qty) {
      quantityController.clear();
    } else if (type == TextFieldType.risk) {
      riskController.clear();
    } else if (type == TextFieldType.delta) {
      deltaController.clear();
    } else {
      slController.clear();
    }
    setState(() {
      _selectedOption = type;
    });
  }

  @override
  void calculatedValue(CalculationModel model) {
    if (model.sl < 1) {
      const snackdemo = SnackBar(
        content: Text(slPointLessThan1Message),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    } else {
      setState(() {
        quantityController.text = model.qty.toString();
        riskController.text = model.risk.toString();
        slController.text = model.sl.toString();
        deltaController.text = model.delta.toString();
      });
    }
  }

  @override
  void toggleSelection(bool isToggled) {
    setState(() {
      if (!isToggled) {
        _selectedOption = TextFieldType.qty;
      }
      _isToggled = isToggled;
    });
  }
}
