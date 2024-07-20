

import '../../model/calculation_model.dart';
import '../../presenter/on_trade_calculation_presenter.dart';
import '../../presenter/pre_trade_calculation_presenter.dart';

abstract class OnTradeCalViewContract {
  void rrToggleSelection(RR isToggled);
  void enableCustom();
  void calculatedValue(CalculationModel model);
  void error(String msg);
}
