import 'package:flutter/material.dart';
import 'package:trader_pro/model/calculation_model.dart';
import 'package:trader_pro/widgets/horizontal_list.dart';

import '../../presenter/on_trade_calculation_presenter.dart';
import '../../utilities/contants.dart';
import '../../widgets/button.dart';
import '../../widgets/input_field.dart';
import '../../widgets/responsive_widget.dart';
import '../view_contracts/on_trade_calc_view_contract.dart';

class OnTradeScreen extends StatefulWidget {
  const OnTradeScreen({super.key, required this.title});

  final String title;

  @override
  State<OnTradeScreen> createState() => _OnTradeScreenState();
}

class _OnTradeScreenState extends State<OnTradeScreen>
    implements OnTradeCalViewContract {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController entryController = TextEditingController();
  final TextEditingController customController = TextEditingController();
  final TextEditingController slPointsController = TextEditingController();
  final TextEditingController stopLossController = TextEditingController();
  final TextEditingController targetPriceController = TextEditingController();

  late final OnTradeCalculationPresenter presenter;

  RR rrType = RR.one;
  bool _enableCustom = false;

  @override
  void initState() {
    super.initState();

    presenter = OnTradeCalculationPresenter(calViewContract: this);
  }

  @override
  Widget build(BuildContext context) {
    // return Center(child:  Text('${widget.title} screen coming soon'),);
    return ResponsiveWidget(
      large: GestureDetector(
        onTap: () {
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
                                        entryController.clear();
                                        customController.clear();
                                        slPointsController.clear();
                                        stopLossController.clear();
                                        targetPriceController.clear();
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: NumberTextField(
                                    labelString: enteredPrice,
                                    controller: entryController,
                                    onChanged: (value) {},
                                    readOnly: false,
                                    isDecimal: true,
                                    isZeroToOne: false,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: NumberTextField(
                                    labelString: slPoints,
                                    controller: slPointsController,
                                    onChanged: (value) {},
                                    readOnly: false,
                                    isDecimal: true,
                                    isZeroToOne: false,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Text(
                            rr,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: HorizontalOptions(
                              onTap: (rrType) {
                                presenter.rrToggleSelection(rrType);
                              },
                            ),
                          ),
                          if (_enableCustom)
                            NumberTextField(
                              labelString: enteredReward,
                              controller: customController,
                              onChanged: (value) {},
                              readOnly: false,
                              isDecimal: true,
                              isZeroToOne: false,
                            ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        presenter.calculate(
                                            entryController.text,
                                            slPointsController.text,
                                            rrType,
                                            customController.text);
                                      } else {
                                        presenter.error(fieldsMissingError);
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
                            ),
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
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: NumberTextField(
                                    labelString: stopLoss,
                                    controller: stopLossController,
                                    onChanged: (value) {},
                                    readOnly: true,
                                    isDecimal: false,
                                    isZeroToOne: false,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: NumberTextField(
                                    labelString: targetPrice,
                                    controller: targetPriceController,
                                    onChanged: (value) {},
                                    readOnly: true,
                                    isDecimal: true,
                                    isZeroToOne: false,
                                  ),
                                )
                              ],
                            ),
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
        onTap: () {
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
                                          entryController.clear();
                                          customController.clear();
                                          slPointsController.clear();
                                          stopLossController.clear();
                                          targetPriceController.clear();
                                        },
                                        title: 'Reset'))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: NumberTextField(
                                  labelString: enteredPrice,
                                  controller: entryController,
                                  onChanged: (value) {},
                                  readOnly: false,
                                  isDecimal: true,
                                  isZeroToOne: false,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: NumberTextField(
                                  labelString: slPoints,
                                  controller: slPointsController,
                                  onChanged: (value) {},
                                  readOnly: false,
                                  isDecimal: true,
                                  isZeroToOne: false,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Text(
                          rr,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: HorizontalOptions(
                            onTap: (rrType) {
                              presenter.rrToggleSelection(rrType);
                            },
                          ),
                        ),
                        if (_enableCustom)
                          NumberTextField(
                            labelString: enteredReward,
                            controller: customController,
                            onChanged: (value) {},
                            readOnly: false,
                            isDecimal: true,
                            isZeroToOne: false,
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: MyButton(
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        presenter.calculate(
                                            entryController.text,
                                            slPointsController.text,
                                            rrType,
                                            customController.text);
                                      } else {
                                        presenter.error(fieldsMissingError);
                                      }
                                    },
                                    title: 'Calculate'),
                              ),
                            ],
                          ),
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
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: NumberTextField(
                                  labelString: stopLoss,
                                  controller: stopLossController,
                                  onChanged: (value) {},
                                  readOnly: true,
                                  isDecimal: false,
                                  isZeroToOne: false,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: NumberTextField(
                                  labelString: targetPrice,
                                  controller: targetPriceController,
                                  onChanged: (value) {},
                                  readOnly: true,
                                  isDecimal: true,
                                  isZeroToOne: false,
                                ),
                              )
                            ],
                          ),
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
    super.dispose();

    entryController.dispose();
    stopLossController.dispose();
    targetPriceController.dispose();
  }

  @override
  void calculatedValue(CalculationModel model) {
    stopLossController.text = model.sl.toString();
    targetPriceController.text = model.target.toString();
    setState(() {
    });
  }

  @override
  void enableCustom() {
    setState(() {
      rrType = RR.other;
      _enableCustom = true;
    });
  }

  @override
  void error(String msg) {
    var snackdemo = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }

  @override
  void rrToggleSelection(RR isToggled) {
    setState(() {
      _enableCustom = false;
      rrType = isToggled;
    });
  }
}
