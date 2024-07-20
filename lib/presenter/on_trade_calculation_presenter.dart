import 'package:trader_pro/view/view_contracts/pre_trade_calc_view_contract.dart';

import '../model/calculation_model.dart';
import '../utilities/contants.dart';
import '../view/view_contracts/on_trade_calc_view_contract.dart';

enum RR { one, two, three, four, six, other }

abstract class PreTradeCalPresenterContracts {
  void rrToggleSelection(RR isToggled);
  void calculate(String price, String sl , RR rr , String custom);
  void error(String error);
}

class OnTradeCalculationPresenter implements PreTradeCalPresenterContracts {
  OnTradeCalViewContract calViewContract;
  late CalculationModel model;

  OnTradeCalculationPresenter({required this.calViewContract}) {
    model = CalculationModel();
  }


  double _calculateSl(String sLPoint, String entryPrice){
    return (double.parse(entryPrice) - double.parse(sLPoint));
  }

  double _calculateTarget(String sLPoint, String entryPrice, double rr){
    return (double.parse(entryPrice) + (double.parse(sLPoint) * rr));
  }

  @override
  void calculate(String price, String sl, RR rr, String custom) {
    print('rr: ${rr}');
    if(price.isNotEmpty && sl.isNotEmpty){
      switch (rr){
        case RR.one:
          double slPoint = _calculateSl(sl, price);
          double targetPoint = _calculateTarget(sl, price, 1);
          model.sl = slPoint;
          model.target = targetPoint;
          break;
        case RR.two:
          double slPoint = _calculateSl(sl, price);
          double targetPoint = _calculateTarget(sl, price, 2);
          model.sl = slPoint;
          model.target = targetPoint;
          break;
        case RR.three:
          double slPoint = _calculateSl(sl, price);
          double targetPoint = _calculateTarget(sl, price, 3);
          model.sl = slPoint;
          model.target = targetPoint;
          break;
        case RR.other:
          double slPoint = _calculateSl(sl, price);
          double reward = double.parse(custom);
          print('slPoint: $slPoint, reward: $reward');
          double targetPoint = _calculateTarget(sl, price, reward);
          model.sl = slPoint;
          model.target = targetPoint;
          break;
        case RR.four:
          double slPoint = _calculateSl(sl, price);
          double targetPoint = _calculateTarget(sl, price, 4);
          model.sl = slPoint;
          model.target = targetPoint;
          break;
        case RR.six:
          double slPoint = _calculateSl(sl, price);
          double targetPoint = _calculateTarget(sl, price, 6);
          model.sl = slPoint;
          model.target = targetPoint;
          break;
      }
      calViewContract.calculatedValue(model);
    } else {
      calViewContract.error(fieldsMissingError);
    }
  }

  @override
  void rrToggleSelection(RR toggled) {
    if(toggled == RR.other){
      calViewContract.enableCustom();
    }else {
      calViewContract.rrToggleSelection(toggled);
    }
  }

  @override
  void error(String error) {
    calViewContract.error(error);
  }
}
