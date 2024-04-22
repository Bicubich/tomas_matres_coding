import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_add_to_cart_button.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/bloc/dropdown_text_bloc.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/bloc/dropdown_text_state.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/tomas_dropdown_text.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/top_menu_favorite/top_menu_favorite_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/cubit/checkbox/product_info_option_checkbox_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/cubit/error/product_info_option_error_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/cubit/hover/product_info_option_hover_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/cubit/radio/product_info_option_radio_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/product_info_option.dart';
import 'package:tomas_matres/ui/features/product_screen/components/price/cubit/product_info_price_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/price/product_info_price.dart';
import 'package:tomas_matres/ui/features/product_screen/cubit/product_screen_favorite_icon/product_screen_favorite_icon_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/product_info/product_dropdown_characteristic_info.dart';
import 'package:tomas_matres/ui/features/product_screen/product_info/product_dropdown_delivery_info.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  final ScrollController scrollController;

  const ProductInfo(
      {required this.product, required this.scrollController, super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final Map<String, String> selectedRadioOptions = {};
  final Map<String, List<String>> selectedCheckboxOptions = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.name,
            style: UiConstants.kTextStyleHeadline2
                .copyWith(color: UiConstants.kColorText01),
          ),
          if (widget.product.description.isNotEmpty)
            const SizedBox(
              height: 16,
            ),
          if (widget.product.description.isNotEmpty)
            RichText(
              text: HTML.toTextSpan(
                context,
                widget.product.description,
                linksCallback: (link) => Utils.onHtmlDescriptionUrlTap(link),
              ),
            ),
          const SizedBox(
            height: 56,
          ),
          Text(
            "${widget.product.relatedIds.isNotEmpty ? LocaleKeys.kTextCostOfTheSet.tr() : LocaleKeys.kTextCost.tr()}:",
            style: UiConstants.kTextStyleText4
                .copyWith(color: UiConstants.kColorBase04),
          ),
          const SizedBox(
            height: 19,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProductInfoPrice(
                product: widget.product,
              ),
              const Spacer(),
              BlocProvider(
                create: (context) => ProductScreenFavoriteIconCubit(
                    productId: widget.product.id,
                    topMenuFavoriteCubit:
                        BlocProvider.of<TopMenuFavoriteCubit>(context)),
                child: BlocBuilder<ProductScreenFavoriteIconCubit,
                    ProductScreenFavoriteIconState>(
                  builder: (context, state) {
                    return TomasIconButton(
                        onPressed: () {
                          if (state is ProductScreenFavoriteIconActive) {
                            BlocProvider.of<TopMenuFavoriteCubit>(context)
                                .removeFromFavorite(widget.product);
                          } else {
                            BlocProvider.of<TopMenuFavoriteCubit>(context)
                                .addToFavorite(widget.product);
                          }
                        },
                        iconPath: Paths.likeIconPath,
                        width: 30,
                        height: 30,
                        iconColor: state is ProductScreenFavoriteIconActive
                            ? UiConstants.kColorPrimaryActive
                            : null);
                  },
                ),
              ),
            ],
          ),
          if (widget.product.options.isNotEmpty)
            const SizedBox(
              height: 24,
            ),
          if (widget.product.options.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  widget.product.options.length,
                  (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    ProductInfoOptionHoverCubit(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    ProductInfoOptionErrorCubit(
                                        required: widget.product.options[index]
                                                .required ==
                                            '1'),
                              ),
                              if (widget.product.options[index].type == 'radio')
                                BlocProvider(
                                  create: (context) => ProductInfoOptionRadioCubit(
                                      productInfoOptionErrorCubit: BlocProvider
                                          .of<ProductInfoOptionErrorCubit>(
                                              context)),
                                ),
                              if (widget.product.options[index].type ==
                                  'checkbox')
                                BlocProvider(
                                  create: (context) =>
                                      ProductInfoOptionCheckboxCubit(
                                          productInfoOptionErrorCubit: BlocProvider
                                              .of<ProductInfoOptionErrorCubit>(
                                                  context),
                                          productInfoPriceCubit:
                                              BlocProvider
                                                  .of<ProductInfoPriceCubit>(
                                                      context)),
                                ),
                            ],
                            child: ProductInfoOption(
                              option: widget.product.options[index],
                              onRadioOptionSelection: (optionValueId) {
                                selectedRadioOptions[widget
                                    .product
                                    .options[index]
                                    .productOptionId] = optionValueId;
                              },
                              onCheckboxOptionsChange: (optionValueIds) {
                                if (optionValueIds.isEmpty) {
                                  selectedCheckboxOptions.removeWhere(
                                      (key, value) =>
                                          key ==
                                          widget.product.options[index]
                                              .productOptionId);
                                } else {
                                  selectedCheckboxOptions[widget
                                      .product
                                      .options[index]
                                      .productOptionId] = optionValueIds;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      )),
            ),
          SizedBox(
            height: widget.product.options.isNotEmpty ? 24 : 63,
          ),
          TomasAddToCartButton(
            productToAdd: widget.product,
            selectedCheckboxOptions: selectedCheckboxOptions,
            selectedRadioOptions: selectedRadioOptions,
            iconHeight: 32,
            iconWidth: 32,
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          ),
          const SizedBox(
            height: 56,
          ),
          BlocProvider(
            create: (context) =>
                DropdownTextBloc(scrollController: widget.scrollController),
            child: BlocBuilder<DropdownTextBloc, DropdownTextState>(
              builder: (context, state) {
                return TomasDropdownText(
                  title: LocaleKeys.kTextCharacteristics.tr(),
                  body: ProductDropdownCharacteristicInfo(
                    attributes: widget.product.attributes,
                  ),
                  textStyle: UiConstants.kTextStyleHeadline4,
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Divider(
              color: UiConstants.kColorBase03,
              height: 1,
            ),
          ),
          BlocProvider(
            create: (context) =>
                DropdownTextBloc(scrollController: widget.scrollController),
            child: BlocBuilder<DropdownTextBloc, DropdownTextState>(
              builder: (context, state) {
                return TomasDropdownText(
                  title: LocaleKeys.kTextDelivery.tr(),
                  body: const ProductDropdownDeliveryInfo(),
                  textStyle: UiConstants.kTextStyleHeadline4,
                );
              },
            ),
          ),
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
