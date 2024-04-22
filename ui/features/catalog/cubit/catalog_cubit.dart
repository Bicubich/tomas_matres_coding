import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/api/api.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_state.dart';
import 'package:tomas_matres/ui/features/catalog/data/color_filter_model.dart';
import 'package:tomas_matres/ui/features/catalog/data/custom_filter_model.dart';
import 'package:tomas_matres/ui/features/catalog/data/filter_data.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final String parentCategoryId;
  final String? subcategoryId;
  final bool withSale;
  CatalogCubit({
    required this.parentCategoryId,
    this.subcategoryId,
    required this.withSale,
  }) : super(
          CatalogLoading(),
        ) {
    _init();
  }

  late final Category category;
  late String activeCategoryId;
  late final List<Product> products;
  late List<Product> selectedCategoryProducts;
  final List<String> models = [];
  final Map<String, String> manufactures = {};
  final List<String> manufacturesCheckedIdsList = [];
  final List<String> modelsCheckedIdsList = [];
  final List<CustomFilterGroup> customFilters = [];
  final List<CustomFilterGroup> selectedCustomFilters = [];
  final List<CatalogColorFilter> colorFilters = [];
  final List<String> selectedColorFiltersIds = [];
  int activePage = 1;
  List<FilterData> filterData = [];
  bool onlyWithSale = false;
  StreamController<List<Product>> streamController =
      StreamController<List<Product>>.broadcast();

  Future<void> _init() async {
    if (subcategoryId != null) {
      activeCategoryId = subcategoryId!;
    } else {
      activeCategoryId = parentCategoryId;
    }

    Category? result = await TomasApi.getCategoryById(parentCategoryId);

    if (result == null) {
      emit(CatalogErrorNotFound());
      return;
    } else {
      category = result;
    }

    products = await TomasApi.getProductsByCategory(parentCategoryId);

    if (subcategoryId != null) {
      selectedCategoryProducts = products
          .where((element) => element.categoryIds.contains(subcategoryId!))
          .toList();
    } else {
      selectedCategoryProducts = products;
    }
    
    _setCustomFilters(products);
    _setModelsAndManufactures(products);

    List<Product>? selectedCategoryProductsWithSale;
    if (withSale) {
      onlyWithSale = true;

      selectedCategoryProductsWithSale = List.from(selectedCategoryProducts
          .where((element) => element.specialPrice != null));
    }

    emit(
      CatalogLoaded(
        parentCategory: category,
        selectedCategoryProducts:
            selectedCategoryProductsWithSale ?? selectedCategoryProducts,
        allProducts: products,
        filteredProducts: selectedCategoryProducts,
        sortedByIndex: 0,
        activeCategoryId: activeCategoryId,
        activePage: activePage,
        onlyWithSale: onlyWithSale,
        manufacturersCheckedIdsList: manufacturesCheckedIdsList,
        modelsCheckedIdsList: modelsCheckedIdsList,
        manufactures: manufactures,
        models: models,
        customFilters: customFilters,
        selectedCustomFilters: selectedCustomFilters,
        colorFilters: colorFilters,
        selectedColorFiltersIds: selectedColorFiltersIds,
      ),
    );
  }

  void _setModelsAndManufactures(List<Product> products) {
    models.clear();
    manufactures.clear();
    modelsCheckedIdsList.clear();
    manufacturesCheckedIdsList.clear();
    for (Product product in products) {
      if (product.model != null) {
        if (!(models.contains(product.model!))) {
          models.add(product.model!);
        }
      }
      if (product.manufacturer != null && product.manufacturerId != null) {
        manufactures[product.manufacturerId!] = product.manufacturer!;
      }
    }
  }

  void _setCustomFilters(List<Product> products) {
    customFilters.clear();
    selectedCustomFilters.clear();
    for (CategoryFilter filter in category.filters) {
      if (filter.filterGroupName == 'Цвет') {
        _setColorFilter(filter, products);
      } else {
        if (products.any((element) => element.filters
            .any((element) => element.filterId == filter.filterId))) {
          int index = customFilters
              .indexWhere((element) => element.id == filter.filterGroupId);
          if (index != -1) {
            customFilters[index].filters.add(
                CustomFilter(id: filter.filterId, name: filter.filterName));
          } else {
            customFilters.add(CustomFilterGroup(
                id: filter.filterGroupId,
                name: filter.filterGroupName,
                filters: [
                  CustomFilter(id: filter.filterId, name: filter.filterName)
                ]));
          }
        }
      }
    }
  }

  void _setColorFilter(CategoryFilter filter, List<Product> products) {
    colorFilters.clear();
    selectedColorFiltersIds.clear();
    RegExp regex = RegExp(r"([^#]+)#([A-Fa-f0-9]+)");
    RegExpMatch? match = regex.firstMatch(filter.filterName);
    if (match != null) {
      String? text = match.group(1); // Получаем текст
      String? colorCode = match.group(2); // Получаем код цвета

      if (text != null && colorCode != null) {
        final String filterName = text;
        final Color filterColor =
            Color(int.parse(colorCode, radix: 16) + 0xFF000000);

        for (Product product in products) {
          if (product.filters
              .any((element) => element.filterId == filter.filterId)) {
            colorFilters.add(CatalogColorFilter(
                id: filter.filterId, name: filterName, color: filterColor));
            return;
          }
        }
      }
    }
  }

  void setFilterData(
      {required FilterType filterType,
      required double minValue,
      required double maxValue}) {
    int index = filterData.indexWhere((element) => element.type == filterType);

    if (index != -1) {
      filterData[index] = filterData[index].copyWith(
          filterDataValues:
              FilterDataValues(minValue: minValue, maxValue: maxValue));
      _applyFilter();
    } else {
      filterData.add(FilterData(
          type: filterType,
          filterDataValues:
              FilterDataValues(minValue: minValue, maxValue: maxValue)));
    }
  }

  void _applyFilter() {
    List<Product> filteredProducts = selectedCategoryProducts;
    if (onlyWithSale) {
      filteredProducts = selectedCategoryProducts
          .where((element) => element.specialPrice != null)
          .toList();
    }

    filteredProducts = _filterByManufacturers(filteredProducts);
    filteredProducts = _filterByModels(filteredProducts);
    filteredProducts = _filterByCustomFilter(filteredProducts);
    filteredProducts = _filterByColors(filteredProducts);

    for (FilterData filter in filterData) {
      filteredProducts = _sortProductsBySmbRange(
          products: filteredProducts,
          filterCharacteristics: filter.type,
          minCurrentValue: filter.filterDataValues.minValue,
          maxCurrentValue: filter.filterDataValues.maxValue);
    }

    _sortedBy(filteredProducts, (state as CatalogLoaded).sortedByIndex);

    activePage = 1;

    emit((state as CatalogLoaded).copyWith(
      filteredProducts: filteredProducts,
      onlyWithSale: onlyWithSale,
      manufactures: manufactures,
      manufacturersCheckedIdsList: manufacturesCheckedIdsList,
      models: models,
      modelsCheckedIdsList: modelsCheckedIdsList,
      selectedCategoryProducts: selectedCategoryProducts,
      activeCategoryId: activeCategoryId,
      activePage: activePage,
      customFilters: customFilters,
      selectedCustomFilters: selectedCustomFilters,
      colorFilters: colorFilters,
      selectedColorFiltersIds: List.from(selectedColorFiltersIds),
    ));
  }

  void setColorFilter(String selectedId) {
    if (selectedColorFiltersIds.contains(selectedId)) {
      selectedColorFiltersIds.remove(selectedId);
    } else {
      selectedColorFiltersIds.add(selectedId);
    }

    _applyFilter();
  }

  void changeCustomFilter(
      {required CustomFilterGroup filterGroup,
      required CustomFilter selectedFilter}) {
    int groupIndex = selectedCustomFilters
        .indexWhere((element) => element.id == filterGroup.id);

    if (groupIndex != -1) {
      int filterIndex = selectedCustomFilters[groupIndex]
          .filters
          .indexWhere((element) => element.id == selectedFilter.id);

      if (filterIndex != -1) {
        selectedCustomFilters[groupIndex].filters.removeAt(filterIndex);
        if (selectedCustomFilters[groupIndex].filters.isEmpty) {
          selectedCustomFilters.removeAt(groupIndex);
        }
      } else {
        selectedCustomFilters[groupIndex].filters.add(selectedFilter);
      }
    } else {
      selectedCustomFilters.add(CustomFilterGroup(
          id: filterGroup.id,
          name: filterGroup.name,
          filters: [selectedFilter]));
    }

    _applyFilter();
  }

  void onSortedByTap({required int index}) {
    List<Product> products = (state as CatalogLoaded).filteredProducts;
    _sortedBy(products, index);
    emit(
      (state as CatalogLoaded).copyWith(
          sortedByIndex: index,
          filteredProducts: products,
          activePage: activePage),
    );
  }

  void onCategoryTap({required String categoryId}) {
    activeCategoryId = categoryId;
    selectedCategoryProducts = products
        .where((element) => element.categoryIds.contains(categoryId))
        .toList();

    streamController.add(selectedCategoryProducts);
    _setModelsAndManufactures(selectedCategoryProducts);
    _setCustomFilters(selectedCategoryProducts);

    _applyFilter();
  }

  void onGoodsWithSalesSwitchTap() {
    onlyWithSale = !onlyWithSale;
    List<Product> products;
    if (onlyWithSale) {
      products = List.from(selectedCategoryProducts.where(
        (element) => element.specialPrice != null,
      ));
    } else {
      products = selectedCategoryProducts;
    }

    streamController.add(List.from(products));
    _setModelsAndManufactures(products);
    _setCustomFilters(products);

    _applyFilter();
  }

  void onManufacturersCheckboxTap({required String manufacturerId}) {
    if (manufacturesCheckedIdsList.contains(manufacturerId)) {
      manufacturesCheckedIdsList.remove(manufacturerId);
    } else {
      manufacturesCheckedIdsList.add(manufacturerId);
    }

    _applyFilter();
  }

  List<Product> _filterByColors(List<Product> products) {
    List<Product> result = [];

    if (selectedColorFiltersIds.isEmpty) {
      return products;
    }

    List<Product> productsWithCustomFilter = List.from(products);
    productsWithCustomFilter.removeWhere((element) => element.filters.isEmpty);

    if (productsWithCustomFilter.isNotEmpty) {
      for (String filterId in selectedColorFiltersIds) {
        result.addAll(productsWithCustomFilter
            .where((product) => product.filters
                .any((productFilter) => productFilter.filterId == filterId))
            .toList());
      }
      return removeDuplicatesById(result);
    }

    return result;
  }

  List<Product> _filterByManufacturers(List<Product> products) {
    List<Product> result = [];

    if (manufacturesCheckedIdsList.isEmpty) {
      return products;
    }

    for (String manufacturerId in manufacturesCheckedIdsList) {
      result.addAll(products
          .where((element) => element.manufacturerId == manufacturerId));
    }

    return result;
  }

  void onCollectionCheckboxTap({required String modelId}) {
    if (modelsCheckedIdsList.contains(modelId)) {
      modelsCheckedIdsList.remove(modelId);
    } else {
      modelsCheckedIdsList.add(modelId);
    }

    _applyFilter();
  }

  List<Product> _filterByModels(List<Product> products) {
    List<Product> result = [];

    if (modelsCheckedIdsList.isEmpty) {
      return products;
    }

    for (String modelId in modelsCheckedIdsList) {
      result.addAll(products.where((element) => element.model == modelId));
    }

    return result;
  }

  List<Product> _filterByCustomFilter(List<Product> products) {
    List<Product> result = [];

    if (selectedCustomFilters.isEmpty) {
      return products;
    }

    List<Product> productsWithCustomFilter = List.from(products);
    productsWithCustomFilter.removeWhere((element) => element.filters.isEmpty);

    if (productsWithCustomFilter.isNotEmpty) {
      for (CustomFilterGroup filterGroup in selectedCustomFilters) {
        for (CustomFilter filter in filterGroup.filters) {
          result.addAll(productsWithCustomFilter
              .where((product) => product.filters
                  .any((productFilter) => productFilter.filterId == filter.id))
              .toList());
        }
      }

      return removeDuplicatesById(result);
    } else {
      return result;
    }
  }

  void onPageSelected({required int index}) {
    emit((state as CatalogLoaded).copyWith(activePage: index));
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

  List<Product> _sortProductsBySmbRange(
      {required List<Product> products,
      required double maxCurrentValue,
      required double minCurrentValue,
      required FilterType filterCharacteristics}) {
    return products.where((element) {
      double value;

      switch (filterCharacteristics) {
        case FilterType.price:
          value = (element.specialPrice ?? element.price).toDouble();
        case FilterType.width:
          value = element.width.toDouble();
        case FilterType.height:
          value = element.height.toDouble();
        case FilterType.length:
          value = element.length.toDouble();
        default:
          value = 0;
      }

      return value <= maxCurrentValue && value >= minCurrentValue;
    }).toList();
  }

  List<Product> removeDuplicatesById(List<Product> products) {
    Set<String> uniqueIds = {};
    List<Product> uniqueElements = [];

    for (Product product in products) {
      if (!uniqueIds.contains(product.id)) {
        uniqueIds.add(product.id);
        uniqueElements.add(product);
      }
    }

    return uniqueElements;
  }

  @override
  Future<void> close() {
    streamController.close();
    return super.close();
  }
}
