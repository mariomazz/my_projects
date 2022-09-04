import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectnotes/ui/theme/theme.dart';

class ShowToast {
  static void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      timeInSecForIosWeb: 3,
      webBgColor:
          "linear-gradient(to right, #${AppTheme.primaryHEX}, #${AppTheme.primaryHEX})",
      webPosition: "center",
      textColor: AppTheme.textPrimary,
    );
  }
}
