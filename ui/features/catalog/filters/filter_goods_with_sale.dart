import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_cubit.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_state.dart';

class FilterGoodsWithSale extends StatelessWidget {
  const FilterGoodsWithSale({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        if (state is CatalogLoaded) {
          return Row(
            children: [
              Text(
                LocaleKeys.kTextGoodsWithSale.tr(),
                style: UiConstants.kTextStyleHeadline4.copyWith(
                  color: UiConstants.kColorBase05,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Switch(
                value: state.onlyWithSale,
                onChanged: (_) {
                  context.read<CatalogCubit>().onGoodsWithSalesSwitchTap();
                },
                activeColor: UiConstants.kColorPrimary,
                inactiveThumbColor: UiConstants.kColorBase01,
                inactiveTrackColor: UiConstants.kColorText06,
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
