import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_state.dart';
import 'package:tomas_matres/ui/features/catalog/filters/category_section_item.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_cubit.dart';

class CategorySectionView extends StatefulWidget {
  const CategorySectionView({
    Key? key,
  }) : super(key: key);

  @override
  State<CategorySectionView> createState() => _CategorySectionViewState();
}

class _CategorySectionViewState extends State<CategorySectionView> {
  Category? parentCategory;
  String? activeCategoryId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        if (state is CatalogLoaded) {
          parentCategory = state.parentCategory;
          activeCategoryId = state.activeCategoryId;
        }

        if (state is CatalogLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.kTextCategories.tr(),
                style: UiConstants.kTextStyleHeadline4.copyWith(
                  color: UiConstants.kColorBase05,
                ),
              ),
              const SizedBox(
                  height:
                      24), // Отступ между заголовком и первым элементом списка
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: parentCategory!.children.length + 1,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12), // Отступ между элементами
                itemBuilder: (context, index) => CategorySectionItem(
                  category: index == 0
                      ? parentCategory!
                      : parentCategory!.children[index - 1],
                  index: index,
                  products: state.allProducts,
                  title: index == 0
                      ? LocaleKeys.kTextAll.tr()
                      : parentCategory!.children[index - 1].name,
                  activeCategoryId: state.activeCategoryId,
                  onTap: (categoryId) {
                    context
                        .read<CatalogCubit>()
                        .onCategoryTap(categoryId: categoryId);
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
