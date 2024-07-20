

import '../../model/calculation_model.dart';
import '../../presenter/pre_trade_calculation_presenter.dart';

abstract class PreTradeCalViewContract {
  void toggleSelection(bool isToggled);
  void chooseTypeRadio(TextFieldType? type);
  void calculatedValue(CalculationModel model);
}
