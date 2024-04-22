import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/bloc/dropdown_text_bloc.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/tomas_dropdown_text.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/filter/catalog_filter_cubit.dart';
import 'package:tomas_matres/ui/features/catalog/filters/price_range_widget.dart';

class FilterColumnRangeItem extends StatelessWidget {
  final String title;
  const FilterColumnRangeItem({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogFilterCubit, CatalogFilterState>(
      builder: (context, state) {
        if (state is CatalogFilterLoaded || state is CatalogFilterNoProducts) {
          return BlocProvider(
            create: (context) =>
                DropdownTextBloc(isDropdownVisible: isDropdownVisible(state)),
            child: TomasDropdownText(
              textStyle: UiConstants.kTextStyleHeadline4,
              title: title,
              body: TomasRangeWidget(
                minValue: state is CatalogFilterLoaded ? state.minValue : 0,
                maxValue: state is CatalogFilterLoaded ? state.maxValue : 0,
                minCurrentValue:
                    state is CatalogFilterLoaded ? state.minCurrentValue : 0,
                maxCurrentValue:
                    state is CatalogFilterLoaded ? state.maxCurrentValue : 0,
                onChanged: (double minValue, double maxValue) {
                  if (state is CatalogFilterLoaded) {
                    context
                        .read<CatalogFilterCubit>()
                        .updateValue(minValue: minValue, maxValue: maxValue);
                  }
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  bool isDropdownVisible(CatalogFilterState state) {
    if (state is CatalogFilterLoaded) {
      if (state.maxValue != state.maxCurrentValue ||
          state.minValue != state.minCurrentValue) {
        return true;
      }
    }
    return false;
  }
}
