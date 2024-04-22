import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/api/api.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/common/header/search/cubit/top_menu_search_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/search/model/search_hint_model.dart';
import 'package:tomas_matres/ui/features/search_screen/cubit/search_screen_state.dart';

class SearchScreenCubit extends Cubit<SearchScreenState> {
  final TopMenuSearchCubit topMenuSearchCubit;
  final String? notFoundSearchText;
  SearchScreenCubit({required this.topMenuSearchCubit, this.notFoundSearchText})
      : super(
          SearchScreenLoading(),
        ) {
    _init();
  }

  List<SearchItem> results = [];
  List<Category> resultsCategories = [];
  List<Product> resultsProducts = [];

  int activePage = 1;

  Future<void> _init() async {
    if (topMenuSearchCubit.searchResults.isEmpty &&
        notFoundSearchText != null) {
      results = await _getSearchHints(notFoundSearchText!);
    } else {
      results = topMenuSearchCubit.searchResults;
    }

    resultsCategories = await _getCategories(results);
    resultsProducts = await _getProducts(results);
    _sortedBy(resultsProducts, 0);
    emit(
      SearchScreenLoaded(
        results: results,
        resultsProducts: resultsProducts,
        resultsCategories: resultsCategories,
        sortedByIndex: 0,
        activePage: activePage,
      ),
    );
  }

  void onSortedByTap({required int index}) {
    List<Product> products = (state as SearchScreenLoaded).resultsProducts;
    _sortedBy(products, index);
    activePage = 1;
    emit((state as SearchScreenLoaded).copyWith(
        sortedByIndex: index,
        resultsProducts: products,
        activePage: activePage));
  }

  void onPageSelected({required int index}) {
    emit((state as SearchScreenLoaded).copyWith(activePage: index));
  }

  void _sortedBy(List<Product> products, int sortedByIndex) {
    switch (sortedByIndex) {
      case 0:
        products.sort((a, b) {
          // Проверка наличия rating
          if (a.rating != null && b.rating != null) {
            return a.rating!.compareTo(b.rating!);
          } else if (a.rating != null) {
            return -1; // a имеет rating, поэтому оно должно быть выше
          } else if (b.rating != null) {
            return 1; // b имеет rating, поэтому a должно быть ниже
          } else {
            return 0; // оба не имеют rating, порядок не важен
          }
        });
        break;
      case 1:
        products.sort(
          ((a, b) =>
              (a.specialPrice ?? a.price).compareTo(b.specialPrice ?? b.price)),
        );
        break;
      case 2:
        products.sort(
          ((b, a) =>
              (a.specialPrice ?? a.price).compareTo(b.specialPrice ?? b.price)),
        );
        break;
      case 3:
        products.sort((a, b) {
          // Проверка наличия specialPrice
          if (a.specialPrice != null && b.specialPrice != null) {
            return a.specialPrice!.compareTo(b.specialPrice!);
          } else if (a.specialPrice != null) {
            return -1; // a имеет specialPrice, поэтому оно должно быть выше
          } else if (b.specialPrice != null) {
            return 1; // b имеет specialPrice, поэтому a должно быть ниже
          } else {
            return 0; // оба не имеют specialPrice, порядок не важен
          }
        });
        break;
      default:
    }
  }

  Future<List<Category>> _getCategories(List<SearchItem> results) async {
    return results
        .where((e) => e.type == SearchItemCategory.category.name)
        .map(
          (e) => Category(
            categoryId: e.id ?? '',
            children: [],
            dateAdded: DateTime.now(),
            dateModified: DateTime.now(),
            filters: [],
            href: '',
            languageId: '',
            metaTitle: '',
            name: e.name ?? '',
            parentId: '',
            sortOrder: '',
            status: '',
            storeId: '',
            top: '',
          ),
        )
        .toList();
  }

  Future<List<Product>> _getProducts(List<SearchItem> results) async {
    return results.where((e) => e.type == SearchItemCategory.product.name).map(
      (e) {
        return Product(
          id: e.id ?? '',
          name: e.name ?? '',
          description: '',
          attributes: const [],
          price: e.price ?? 0,
          specialPrice: e.specialPrice,
          rating: e.rating,
          image: e.image ?? '',
          additionalImages: const [],
          taxClassId: '',
          options: const [],
          relatedIds: const [],
          categoryIds: const [],
          filters: const [],
          dateAdded: e.dateAdded!,
        );
      },
    ).toList();
  }

  Future<List<SearchItem>> _getSearchHints(String name) async {
    List<SearchItem> hints =
        await TomasApi.getProductsAndCategoriesByByName(name);
    return hints;
  }
}
