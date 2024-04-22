import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/bloc/dropdown_text_bloc.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/tomas_dropdown_text.dart';
import 'package:tomas_matres/ui/features/catalog/components/filter_checkbox.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/filter/catalog_filter_cubit.dart';
import 'package:tomas_matres/ui/features/catalog/data/color_filter_model.dart';
import 'package:tomas_matres/ui/features/catalog/data/custom_filter_model.dart';
import 'package:tomas_matres/ui/features/catalog/data/filter_data.dart';
import 'package:tomas_matres/ui/features/catalog/filters/category_section_view.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_cubit.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_state.dart';
import 'package:tomas_matres/ui/features/catalog/filters/filter_column_range_item.dart';
import 'package:tomas_matres/ui/features/catalog/filters/filter_goods_with_sale.dart';

class FilterColumn extends StatelessWidget {
  final List<Product> products;
  const FilterColumn({
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 350, minWidth: 250),
      padding: EdgeInsets.only(right: 40.w),
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: UiConstants.kColorBase03))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategorySectionView(),
          const SizedBox(
            height: 40,
          ),
          const FilterGoodsWithSale(),
          const SizedBox(
            height: 40,
          ),
          BlocProvider(
            create: (context) => CatalogFilterCubit(
                catalogCubit: BlocProvider.of<CatalogCubit>(context),
                filterCharacteristics: FilterType.width,
                allProducts: products),
            child: FilterColumnRangeItem(
                title: LocaleKeys.kTextWideWithUnits.tr()),
          ),
          const SizedBox(
            height: 40,
          ),
          BlocProvider(
            create: (context) => CatalogFilterCubit(
                catalogCubit: BlocProvider.of<CatalogCubit>(context),
                filterCharacteristics: FilterType.height,
                allProducts: products),
            child: FilterColumnRangeItem(
                title: LocaleKeys.kTextHeightWithUnits.tr()),
          ),
          const SizedBox(
            height: 40,
          ),
          BlocProvider(
            create: (context) => CatalogFilterCubit(
                catalogCubit: BlocProvider.of<CatalogCubit>(context),
                filterCharacteristics: FilterType.length,
                allProducts: products),
            child: FilterColumnRangeItem(
                title: LocaleKeys.kTextLengthWithUnits.tr()),
          ),
          const SizedBox(
            height: 40,
          ),
          BlocProvider(
            create: (context) => CatalogFilterCubit(
                catalogCubit: BlocProvider.of<CatalogCubit>(context),
                filterCharacteristics: FilterType.price,
                allProducts: products),
            child: FilterColumnRangeItem(
                title: LocaleKeys.kTextPriceWithUnits.tr()),
          ),
          const SizedBox(
            height: 40,
          ),
          BlocBuilder<CatalogCubit, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoaded) {
                if (state.colorFilters.isNotEmpty) {
                  return BlocProvider(
                    create: (context) => DropdownTextBloc(),
                    child: TomasDropdownText(
                      textStyle: UiConstants.kTextStyleHeadline4,
                      title: LocaleKeys.kTextColor.tr(),
                      body: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.colorFilters.length,
                        separatorBuilder: (context, index) => const SizedBox(
                            height: 20), // Отступ между элементами
                        itemBuilder: (context, index) {
                          final CatalogColorFilter colorFilter =
                              state.colorFilters[index];
                          return FilterCheckbox(
                              id: colorFilter.id,
                              text: colorFilter.name,
                              textPrefix: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                    color: colorFilter.color,
                                    border: colorFilter.color ==
                                            UiConstants.kColorBase01
                                        ? Border.all(
                                            color: UiConstants.kColorBase03)
                                        : null,
                                    shape: BoxShape.circle),
                              ),
                              isChecked: state.selectedColorFiltersIds
                                  .contains(colorFilter.id),
                              onTap: (index) {
                                context
                                    .read<CatalogCubit>()
                                    .setColorFilter(colorFilter.id);
                              });
                        },
                      ),
                      bodyPadding: const EdgeInsets.only(top: 24),
                    ),
                  );
                }
              }

              return Container();
            },
          ),
          BlocBuilder<CatalogCubit, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoaded && state.colorFilters.isNotEmpty) {
                return const SizedBox(
                  height: 40,
                );
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<CatalogCubit, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoaded) {
                if (state.customFilters.isNotEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children:
                        List.generate(state.customFilters.length, (groupIndex) {
                      final CustomFilterGroup filterGroup =
                          state.customFilters[groupIndex];
                      int selectedFilterGroupIndex = state.selectedCustomFilters
                          .indexWhere(
                              (element) => element.id == filterGroup.id);

                      CustomFilterGroup? selectedCustomFilterGroup;

                      if (selectedFilterGroupIndex != -1) {
                        selectedCustomFilterGroup = state
                            .selectedCustomFilters[selectedFilterGroupIndex];
                      }

                      return BlocProvider(
                        create: (context) => DropdownTextBloc(),
                        child: TomasDropdownText(
                          textStyle: UiConstants.kTextStyleHeadline4,
                          title: filterGroup.name,
                          body: ListView.separated(
                            shrinkWrap: true,
                            itemCount: filterGroup.filters.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                    height: 20), // Отступ между элементами
                            itemBuilder: (context, filterIndex) {
                              final CustomFilter filter =
                                  filterGroup.filters[filterIndex];

                              bool isSelected = false;

                              if (selectedCustomFilterGroup != null &&
                                  selectedCustomFilterGroup
                                      .filters.isNotEmpty) {
                                for (CustomFilter selectedCustomFilter
                                    in selectedCustomFilterGroup.filters) {
                                  if (selectedCustomFilter.id == filter.id) {
                                    isSelected = true;
                                    break;
                                  }
                                }
                              }

                              return FilterCheckbox(
                                  id: filter.id,
                                  text: filter.name,
                                  isChecked: isSelected,
                                  onTap: (index) {
                                    context
                                        .read<CatalogCubit>()
                                        .changeCustomFilter(
                                            filterGroup: filterGroup,
                                            selectedFilter: filter);
                                  });
                            },
                          ),
                          bodyPadding: const EdgeInsets.only(top: 24),
                        ),
                      );
                    }),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<CatalogCubit, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoaded && state.customFilters.isNotEmpty) {
                return const SizedBox(
                  height: 40,
                );
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<CatalogCubit, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoaded) {
                return BlocProvider(
                  create: (context) => DropdownTextBloc(),
                  child: TomasDropdownText(
                    textStyle: UiConstants.kTextStyleHeadline4,
                    title: LocaleKeys.kTextCollection.tr(),
                    body: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.models.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20), // Отступ между элементами
                      itemBuilder: (context, index) {
                        return FilterCheckbox(
                            id: index.toString(),
                            text: state.models[index],
                            isChecked: state.modelsCheckedIdsList
                                .contains(state.models[index]),
                            onTap: (index) {
                              context
                                  .read<CatalogCubit>()
                                  .onCollectionCheckboxTap(
                                      modelId: state.models[int.parse(index)]);
                            });
                      },
                    ),
                    bodyPadding: const EdgeInsets.only(top: 24),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(
            height: 40,
          ),
          BlocBuilder<CatalogCubit, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoaded) {
                return BlocProvider(
                  create: (context) => DropdownTextBloc(),
                  child: TomasDropdownText(
                    textStyle: UiConstants.kTextStyleHeadline4,
                    title: LocaleKeys.kTextFactory.tr(),
                    body: Column(
                      children: _generateManufactures(
                          context,
                          state.manufactures,
                          state.manufacturersCheckedIdsList),
                    ),
                    bodyPadding: const EdgeInsets.only(top: 24),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _generateManufactures(BuildContext context,
      Map<String, String> manufactures, List<String> factoryCheckedIdsList) {
    List<Widget> result = [];
    bool isFirst = true;

    manufactures.forEach((key, value) {
      result.addAll([
        if (!isFirst) const SizedBox(height: 20), // Отступ между элементами
        FilterCheckbox(
            id: key,
            text: value,
            isChecked: factoryCheckedIdsList.contains(key),
            onTap: (selectedCategoryId) {
              context.read<CatalogCubit>().onManufacturersCheckboxTap(
                  manufacturerId: selectedCategoryId);
            })
      ]);
      isFirst = false;
    });

    return result;
  }
}
