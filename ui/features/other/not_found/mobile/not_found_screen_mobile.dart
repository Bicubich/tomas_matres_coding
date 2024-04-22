import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_text_field_with_text/tomas_text_field_with_text.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class NotFoundScreenMobile extends StatefulWidget {
  const NotFoundScreenMobile({super.key});

  @override
  State<NotFoundScreenMobile> createState() => _NotFoundScreenMobileState();
}

class _NotFoundScreenMobileState extends State<NotFoundScreenMobile> {
  final TextEditingController searchController = TextEditingController();

  final RegExp searchRegExp = RegExp(r'.{2,}');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileTemplate(
      children: [
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Column(
              crossAxisAlignment: MediaQuery.of(context).size.width >= 600
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MediaQuery.of(context).size.width >= 600
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        if (MediaQuery.of(context).size.width <= 400)
                          const SizedBox(
                            height: 39,
                          ),
                        Image.asset(
                          Paths.notFound404ImagePath,
                          width: 151,
                          height: 53,
                          color: UiConstants.kColorText01,
                        ),
                        const SizedBox(
                          height: 39,
                        ),
                      ],
                    ),
                    MediaQuery.of(context).size.width > 400
                        ? Image.asset(
                            Paths.notFoundChairImagePath,
                            width: 215,
                            height: 231,
                            fit: BoxFit.fitHeight,
                          )
                        : Container()
                  ],
                ),
                Text(
                  LocaleKeys.kTextNotFoundTitle.tr(),
                  style: UiConstants.kTextStyleHeadline3.copyWith(
                    color: UiConstants.kColorText01,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  LocaleKeys.kTextNotFoundContent.tr(),
                  style: UiConstants.kTextStyleText3
                      .copyWith(color: UiConstants.kColorText03, height: 1.75),
                  textAlign: MediaQuery.of(context).size.width >= 600
                      ? TextAlign.center
                      : TextAlign.left,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 600,
                  child: TomasTextFieldWithText(
                    controller: searchController,
                    hintText: LocaleKeys.kTextSearchTextFieldHint.tr(),
                    textStyle: UiConstants.kTextStyleText5,
                    validator: (value) => validateText(value),
                    onFieldSubmitted: (value) => onSearchButtonTap(context),
                    maxLines: 1,
                    regExp: searchRegExp,
                    errorText:
                        LocaleKeys.kTextMoreThanTwoCharactersRequired.tr(),
                    contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 16),
                    borderRadius: 6,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 18, left: 5),
                      child: GestureDetector(
                        onTap: () => onSearchButtonTap(context),
                        child: SvgPicture.asset(
                          Paths.searchIconPath,
                          width: 20,
                          height: 20,
                          semanticsLabel: 'Icon',
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        const FooterMobile()
      ],
    );
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.kTextRequiredField.tr();
    }
    return null;
  }

  String? validateText(String? value) {
    String? result = validate(value);
    if (result == null) {
      bool isNumber = searchRegExp.hasMatch(value!);
      if (isNumber) {
        return null;
      } else {
        return LocaleKeys.kTextMoreThanTwoCharactersRequired.tr();
      }
    }
    return result;
  }

  void onSearchButtonTap(BuildContext context) {
    if (formKey.currentState!.validate()) {
      CustomRoute route = CustomRoute(
          title: Routes.search.title,
          path: '${Routes.search.path}&search_input=${searchController.text}');
      NavigationHelper.replaceRoute(context, route);
    }
  }
}
