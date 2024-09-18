import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intern_test_pr/styles/color_style.dart';

class UiModel {
  FaIcon logo;

  UiModel({
    required this.logo,
});
  
  static List<UiModel> dataUiModel() {
    return [
      UiModel(logo: FaIcon(FontAwesomeIcons.github, color: ColorStyle.whiteColor)),
      UiModel(logo: FaIcon(FontAwesomeIcons.google, color: ColorStyle.whiteColor)),
      UiModel(logo: FaIcon(FontAwesomeIcons.twitter, color: ColorStyle.whiteColor)),
      UiModel(logo: FaIcon(FontAwesomeIcons.instagram, color: ColorStyle.whiteColor)),
    ];
  }
}