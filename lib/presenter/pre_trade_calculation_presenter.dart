import 'package:trader_pro/view/view_contracts/pre_trade_calc_view_contract.dart';

import '../model/calculation_model.dart';

enum TextFieldType { qty, risk, sl, delta }

abstract class PreTradeCalPresenterContracts {
  void toggleSelection(bool isToggled);

  void calculate(String qty, String risk, String sl, String delta,
      TextFieldType type, bool isAdvanced);

  void chooseTypeRadio(TextFieldType? type);
}

class PreTradeCalculationPresenter implements PreTradeCalPresenterContracts {
  PreTradeCalViewContract calViewContract;
  late CalculationModel model;

  PreTradeCalculationPresenter({required this.calViewContract}) {
    model = CalculationModel();
  }

  int calculateQty(double r, double s, double d) {
    return r ~/ (s * d);
  }

  double calculateRisk(int q, double s, double d) {
    return q * s * d;
  }

  double calculateSl(int q, double r, double d) {
    return r / (q * d);
  }

  double calculateDelta(int q, double r, double s) {
    return r / (s * q);
  }

  @override
  void toggleSelection(bool isToggled) {
    calViewContract.toggleSelection(isToggled);
  }

  @override
  void calculate(String qty, String risk, String sl, String delta,
      TextFieldType type, bool isAdvanced) {
    switch (type) {
      case TextFieldType.qty:
        var r = double.parse(risk);
        var s = double.parse(sl);
        var d = double.parse(delta.isEmpty ? "1" : delta);
        int calculatedQty = calculateQty(r, s, (isAdvanced ? d : 1));
        model.qty = calculatedQty;
        model.risk = r;
        model.sl = s;
        model.delta = d;
        break;
      case TextFieldType.risk:
        var q = int.parse(qty);
        var s = double.parse(sl);
        var d = double.parse(delta.isEmpty ? "1" : delta);
        double calculatedRisk = calculateRisk(q, s, (isAdvanced ? d : 1));
        model.qty = q;
        model.risk = calculatedRisk;
        model.sl = s;
        model.delta = d;
        break;
      case TextFieldType.sl:
        var q = int.parse(qty);
        var r = double.parse(risk);
        var d = double.parse(delta.isEmpty ? "1" : delta);
        double calculatedSl = calculateSl(q, r, (isAdvanced ? d : 1));
        model.qty = q;
        model.risk = r;
        model.sl = calculatedSl;
        model.delta = d;
        break;
      case TextFieldType.delta:
        var q = int.parse(qty);
        var r = double.parse(risk);
        var s = double.parse(sl);
        double calculatedDelta = calculateDelta(q, r, s);
        model.qty = q;
        model.risk = r;
        model.sl = s;
        model.delta = calculatedDelta;
        break;
    }
    calViewContract.calculatedValue(model);
  }

  @override
  void chooseTypeRadio(TextFieldType? type) {
    calViewContract.chooseTypeRadio(type);
  }
}
