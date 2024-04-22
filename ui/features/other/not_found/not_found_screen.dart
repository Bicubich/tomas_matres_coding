import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_text_field_with_text/tomas_text_field_with_text.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/other/not_found/mobile/not_found_screen_mobile.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key});

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  final ScrollController scrollController = ScrollController();
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);
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
    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return const NotFoundScreenMobile();
    }
    return PageTemplate(
      body: Expanded(
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.calculatePadding(context)),
            controller: scrollController,
            shrinkWrap: true,
            children: [
              Padding(
                padding: padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            Paths.notFound404ImagePath,
                            width: 649,
                            height: 226,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Text(LocaleKeys.kTextNotFoundTitle.tr(),
                            style: UiConstants.kTextStyleHeadline3.copyWith(
                              color: UiConstants.kColorText01,
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          LocaleKeys.kTextNotFoundContent.tr(),
                          style: UiConstants.kTextStyleText2.copyWith(
                            color: UiConstants.kColorText03,
                          ),
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 592),
                          child: TomasTextFieldWithText(
                            controller: searchController,
                            hintText: LocaleKeys.kTextSearchTextFieldHint.tr(),
                            validator: (value) => validateText(value),
                            onFieldSubmitted: (value) => onSearchButtonTap(context),
                            maxLines: 1,
                            regExp: searchRegExp,
                            errorText: LocaleKeys
                                .kTextMoreThanTwoCharactersRequired
                                .tr(),
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(right: 32, left: 5),
                              child: GestureDetector(
                                onTap: () => onSearchButtonTap(context),
                                child: SvgPicture.asset(
                                  Paths.searchIconPath,
                                  width: 32,
                                  height: 32,
                                  semanticsLabel: 'Icon',
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 55,
                    ),
                    MediaQuery.of(context).size.width > 1380
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              Paths.notFoundChairImagePath,
                              width: 593,
                              height: 640,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              Footer(
                scrollController: scrollController,
              )
            ],
          ),
        ),
      ),
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
