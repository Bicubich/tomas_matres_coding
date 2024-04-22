import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/external_links.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/data_models/order/order_model.dart';
import 'package:tomas_matres/data_models/zone/zone_model.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_menu_with_text/data/tomas_dropdown_menu_with_text_data_model.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_menu_with_text/tomas_dropdown_menu_with_text.dart';
import 'package:tomas_matres/ui/components/tomas_error_text.dart';
import 'package:tomas_matres/ui/components/tomas_filled_button.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/components/tomas_text_field_with_text/tomas_text_field_with_text.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_order_dialog/cart_order_dialog.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_order_dialog/cubit/cart_order_dialog_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/cubit/order_information_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/components/receiving_method/bloc/receiving_method_bloc.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/components/receiving_method/receiving_method_view.dart';
import 'package:tomas_matres/ui/features/common/footer/data/footer_data.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderInformationView extends StatefulWidget {
  const OrderInformationView({super.key});

  @override
  State<OrderInformationView> createState() => _OrderInformationViewState();
}

class _OrderInformationViewState extends State<OrderInformationView> {
  late TextEditingController _textEditingNameController;
  late TextEditingController _textEditingSurnameController;
  late TextEditingController _textEditingPhoneController;
  late TextEditingController _textEditingEmailController;
  late TextEditingController _textEditingCityController;
  late TextEditingController _textEditingAddressController;
  late TextEditingController _textEditingCommentController;
  TomasDropdownMenuWithTextData? zone;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegExp phoneRegExp =
      RegExp(r'^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$');
  final RegExp emailRegExp =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  bool isDelivery = false;

  @override
  void initState() {
    _textEditingNameController = TextEditingController();
    _textEditingSurnameController = TextEditingController();
    _textEditingPhoneController = TextEditingController();
    _textEditingEmailController = TextEditingController();
    _textEditingCityController = TextEditingController();
    _textEditingAddressController = TextEditingController();
    _textEditingCommentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingNameController.dispose();
    _textEditingSurnameController.dispose();
    _textEditingPhoneController.dispose();
    _textEditingEmailController.dispose();
    _textEditingCityController.dispose();
    _textEditingAddressController.dispose();
    _textEditingCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: UiConstants.kColorBase01),
      child: BlocBuilder<OrderInformationCubit, OrderInformationState>(
        builder: (context, orderInformationState) {
          if (orderInformationState is OrderInformationLoaded) {
            if (orderInformationState.customer != null) {
              _textEditingNameController.text =
                  orderInformationState.customer!.firstname;
              _textEditingSurnameController.text =
                  orderInformationState.customer!.lastname;
              _textEditingEmailController.text =
                  orderInformationState.customer!.email;
              _textEditingPhoneController.text =
                  orderInformationState.customer!.telephone;
            }

            return BlocProvider(
              create: (context) => ReceivingMethodBloc(),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.kTextInformationForTheOrder.tr(),
                                style: UiConstants.kTextStyleHeadline2
                                    .copyWith(color: UiConstants.kColorText01),
                              ),
                              const SizedBox(
                                height: 42,
                              ),
                              TomasTextFieldWithText(
                                  controller: _textEditingNameController,
                                  label: "${LocaleKeys.kTextName.tr()}*",
                                  hintText: LocaleKeys.kTextYourName.tr(),
                                  validator: (value) => validate(value)),
                              const SizedBox(
                                height: 16,
                              ),
                              TomasTextFieldWithText(
                                  controller: _textEditingSurnameController,
                                  label: "${LocaleKeys.kTextSurname.tr()}*",
                                  hintText: LocaleKeys.kTextYourSurname.tr(),
                                  validator: (value) => validate(value)),
                              const SizedBox(
                                height: 16,
                              ),
                              TomasTextFieldWithText(
                                  controller: _textEditingPhoneController,
                                  label: "${LocaleKeys.kTextPhone.tr()}*",
                                  hintText: "+7 (___) ___-__-__",
                                  regExp: phoneRegExp,
                                  errorText:
                                      LocaleKeys.kTextRequiredPhoneNumber.tr(),
                                  validator: (value) => validateNumber(value)),
                              const SizedBox(
                                height: 16,
                              ),
                              TomasTextFieldWithText(
                                controller: _textEditingEmailController,
                                label: "${LocaleKeys.kTextEmail.tr()}*",
                                hintText: LocaleKeys.kTextYourEmail.tr(),
                                regExp: emailRegExp,
                                errorText: LocaleKeys.kTextRequiredEmail.tr(),
                                validator: (value) => validateEmail(value),
                              ),
                              const SizedBox(
                                height: 48,
                              ),
                              const ReceivingMethodView(),
                              BlocBuilder<ReceivingMethodBloc,
                                  ReceivingMethodState>(
                                builder: (context, state) {
                                  isDelivery = state.isDelivery;

                                  Zone rawZone = orderInformationState.zones
                                      .firstWhere((element) =>
                                          element.zoneId ==
                                          "2722"); // Moscow obl
                                  zone = TomasDropdownMenuWithTextData(
                                      id: rawZone.zoneId, title: rawZone.name);

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: state.isDelivery ? 48 : 24,
                                      ),
                                      if (state.isDelivery)
                                        TomasDropdownMenuWithText(
                                          label: LocaleKeys.kTextZone.tr(),
                                          initValue: zone,
                                          data: List.generate(
                                              orderInformationState
                                                  .zones.length, (index) {
                                            return TomasDropdownMenuWithTextData(
                                                id: orderInformationState
                                                    .zones[index].zoneId,
                                                title: orderInformationState
                                                    .zones[index].name);
                                          }),
                                          validator: (value) =>
                                              validateZone(value),
                                          onChanged: (value) => zone = value,
                                        ),
                                      if (state.isDelivery)
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      if (state.isDelivery)
                                        TomasTextFieldWithText(
                                            controller:
                                                _textEditingCityController,
                                            label: LocaleKeys.kTextCity.tr(),
                                            hintText:
                                                LocaleKeys.kTextCityHint.tr(),
                                            validator: (value) =>
                                                validate(value)),
                                      if (state.isDelivery)
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      if (state.isDelivery)
                                        TomasTextFieldWithText(
                                            controller:
                                                _textEditingAddressController,
                                            label: LocaleKeys
                                                .kTextContactsAddress
                                                .tr(),
                                            hintText: LocaleKeys
                                                .kTextCityStreetHouseNumber
                                                .tr(),
                                            validator: (value) =>
                                                validate(value)),
                                      if (!state.isDelivery)
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () => onAddressTap(),
                                            child: Text(
                                              FooterData.addressText,
                                              style: UiConstants.kTextStyleText3
                                                  .copyWith(
                                                      color: UiConstants
                                                          .kColorText02),
                                            ),
                                          ),
                                        ),
                                      SizedBox(
                                        height: state.isDelivery ? 16 : 48,
                                      ),
                                    ],
                                  );
                                },
                              ),
                              TomasTextFieldWithText(
                                controller: _textEditingCommentController,
                                label: LocaleKeys.kTextComment.tr(),
                                hintText:
                                    LocaleKeys.kTextCommentOnTheOrder.tr(),
                                minLines: 3,
                              ),
                              const SizedBox(
                                height: 56,
                              ),
                              TomasFilledButton(
                                width: MediaQuery.of(context).size.width,
                                onPressed: () => onCreateRequestPress(context),
                                text: LocaleKeys.kTextPlaceAnOrder.tr(),
                                borderRadius: 40,
                                textStyle: UiConstants.kTextStyleButtonMedium2
                                    .copyWith(fontWeight: FontWeight.w400),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 24),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: LocaleKeys
                                      .kTextCartOrderInformationNote1
                                      .tr(),
                                  style: UiConstants.kTextStyleText5.copyWith(
                                      color: UiConstants.kColorBase04),
                                  children: [
                                    TextSpan(
                                        text: LocaleKeys
                                            .kTextCartOrderInformationNote2
                                            .tr(),
                                        style: UiConstants.kTextStyleText5
                                            .copyWith(
                                                color:
                                                    UiConstants.kColorPrimary),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => onPrivacyPolicyTap()),
                                    TextSpan(
                                        text: LocaleKeys
                                            .kTextCartOrderInformationNote3
                                            .tr()),
                                    TextSpan(
                                        text: LocaleKeys
                                            .kTextCartOrderInformationNote4
                                            .tr(),
                                        style: UiConstants.kTextStyleText5
                                            .copyWith(
                                                color:
                                                    UiConstants.kColorPrimary),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap =
                                              () {} // TODO: ссылка Согласие на обработку
                                        ),
                                    TextSpan(
                                        text: LocaleKeys
                                            .kTextCartOrderInformationNote5
                                            .tr()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  )),
            );
          }
          if (orderInformationState is OrderInformationLoading) {
            return const SizedBox(height: 100, child: TomasLoadIndicator());
          }

          return SizedBox(
              height: 100,
              child: TomasErrorText(
                  onReloadTap: () =>
                      BlocProvider.of<OrderInformationCubit>(context)
                          .reload()));
        },
      ),
    );
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.kTextRequiredField.tr();
    }
    return null;
  }

  String? validateZone(TomasDropdownMenuWithTextData? value) {
    if (value == null || value.id == "0") {
      return LocaleKeys.kTextRequiredField.tr();
    }
    return null;
  }

  String? validateEmail(String? value) {
    String? result = validate(value);
    if (result == null) {
      bool isEmail = emailRegExp.hasMatch(value!);
      if (isEmail) {
        return null;
      } else {
        return LocaleKeys.kTextRequiredEmail.tr();
      }
    }
    return result;
  }

  String? validateNumber(String? value) {
    String? result = validate(value);
    if (result == null) {
      bool isNumber = phoneRegExp.hasMatch(value!);
      if (isNumber) {
        return null;
      } else {
        return LocaleKeys.kTextRequiredPhoneNumber.tr();
      }
    }
    return result;
  }

  Future<void> onAddressTap() async {
    final Uri url = Uri.parse(ExternalLinks.addressInYandexMapsLink);
    await launchUrl(url);
  }

  Future<void> onPrivacyPolicyTap() async {
    final Uri url = Uri.parse(ExternalLinks.privacyPolicyLink);
    await launchUrl(url);
  }

  void onCreateRequestPress(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (BlocProvider.of<CartCubit>(context).cartProducts.isNotEmpty) {
        Address address = Address(
            firstname: _textEditingNameController.text,
            lastname: _textEditingSurnameController.text,
            address1: isDelivery
                ? _textEditingAddressController.text
                : FooterData.addressText,
            city: isDelivery ? _textEditingCityController.text : 'Химки',
            zone: zone!.title,
            zoneId: zone!.id.toString(),
            country:
                BlocProvider.of<OrderInformationCubit>(context).countryName,
            countryId:
                BlocProvider.of<OrderInformationCubit>(context).countryId);

        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return BlocProvider(
                create: (context) => CartOrderDialogCubit(
                    cartCubit: BlocProvider.of<CartCubit>(context),
                    address: address,
                    comment: _textEditingCommentController.text,
                    email: _textEditingEmailController.text,
                    phone: _textEditingPhoneController.text),
                child: const CartOrderDialog(),
              );
            });
      }
    }
  }
}
