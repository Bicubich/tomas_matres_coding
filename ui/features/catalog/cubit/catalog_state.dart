import 'package:equatable/equatable.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/catalog/data/color_filter_model.dart';
import 'package:tomas_matres/ui/features/catalog/data/custom_filter_model.dart';

sealed class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object> get props => [];
}

class CatalogLoading extends CatalogState {}

class CatalogError extends CatalogState {}

class CatalogErrorNotFound extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final Category parentCategory;
  final List<Product> allProducts;
  final List<Product> selectedCategoryProducts;
  final List<Product> filteredProducts;
  final int sortedByIndex;
  final String activeCategoryId;
  final int activePage;
  final bool onlyWithSale;
  final List<String> manufacturersCheckedIdsList;
  final List<String> modelsCheckedIdsList;
  final List<CustomFilterGroup> customFilters;
  final List<CustomFilterGroup> selectedCustomFilters;
  final List<CatalogColorFilter> colorFilters;
  final List<String> selectedColorFiltersIds;
  final List<String> models;
  final Map<String, String> manufactures;

  const CatalogLoaded({
    required this.parentCategory,
    required this.allProducts,
    required this.selectedCategoryProducts,
    required this.filteredProducts,
    required this.sortedByIndex,
    required this.activeCategoryId,
    required this.activePage,
    required this.onlyWithSale,
    required this.manufacturersCheckedIdsList,
    required this.modelsCheckedIdsList,
    required this.manufactures,
    required this.models,
    required this.customFilters,
    required this.selectedCustomFilters,
    required this.colorFilters,
    required this.selectedColorFiltersIds,
  });

  CatalogLoaded copyWith({
    Category? parentCategory,
    List<Product>? allProducts,
    List<Product>? filteredProducts,
    List<Product>? selectedCategoryProducts,
    int? sortedByIndex,
    String? activeCategoryId,
    int? activePage,
    bool? onlyWithSale,
    List<String>? manufacturersCheckedIdsList,
    List<String>? modelsCheckedIdsList,
    List<String>? models,
    Map<String, String>? manufactures,
    List<CustomFilterGroup>? customFilters,
    List<CustomFilterGroup>? selectedCustomFilters,
    List<CatalogColorFilter>? colorFilters,
    List<String>? selectedColorFiltersIds,
  }) {
    return CatalogLoaded(
      parentCategory: parentCategory ?? this.parentCategory,
      selectedCategoryProducts:
          selectedCategoryProducts ?? this.selectedCategoryProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      allProducts: allProducts ?? this.allProducts,
      sortedByIndex: sortedByIndex ?? this.sortedByIndex,
      activeCategoryId: activeCategoryId ?? this.activeCategoryId,
      activePage: activePage ?? this.activePage,
      onlyWithSale: onlyWithSale ?? this.onlyWithSale,
      manufacturersCheckedIdsList:
          manufacturersCheckedIdsList ?? this.manufacturersCheckedIdsList,
      modelsCheckedIdsList: modelsCheckedIdsList ?? this.modelsCheckedIdsList,
      manufactures: manufactures ?? this.manufactures,
      models: models ?? this.models,
      customFilters: customFilters ?? this.customFilters,
      selectedCustomFilters:
          selectedCustomFilters ?? this.selectedCustomFilters,
      colorFilters: colorFilters ?? this.colorFilters,
      selectedColorFiltersIds: selectedColorFiltersIds ?? this.selectedColorFiltersIds,
    );
  }

  @override
  List<Object> get props => [
        parentCategory,
        selectedCategoryProducts,
        allProducts,
        filteredProducts,
        sortedByIndex,
        activeCategoryId,
        activePage,
        onlyWithSale,
        manufacturersCheckedIdsList,
        modelsCheckedIdsList,
        manufactures,
        models,
        customFilters,
        selectedCustomFilters,
        colorFilters,
        selectedColorFiltersIds,
      ];
}
