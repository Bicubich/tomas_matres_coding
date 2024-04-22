import 'package:equatable/equatable.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/common/header/search/model/search_hint_model.dart';

sealed class SearchScreenState extends Equatable {
  const SearchScreenState();

  @override
  List<Object> get props => [];
}

class SearchScreenLoading extends SearchScreenState {}

class SearchScreenError extends SearchScreenState {}

class CSearchScreenErrorNotFound extends SearchScreenState {}

class SearchScreenLoaded extends SearchScreenState {
  final List<SearchItem> results;
  final List<Product> resultsProducts;
  final List<Category> resultsCategories;
  final int sortedByIndex;
  final int activePage;

  const SearchScreenLoaded({
    required this.results,
    required this.resultsProducts,
    required this.resultsCategories,
    required this.sortedByIndex,
    required this.activePage,
  });

  SearchScreenLoaded copyWith({
    List<SearchItem>? results,
    List<Product>? resultsProducts,
    List<Category>? resultsCategories,
    int? sortedByIndex,
    int? activePage,
  }) {
    return SearchScreenLoaded(
      results: results ?? this.results,
      resultsProducts: resultsProducts ?? this.resultsProducts,
      resultsCategories: resultsCategories ?? this.resultsCategories,
      sortedByIndex: sortedByIndex ?? this.sortedByIndex,
      activePage: activePage ?? this.activePage,
    );
  }

  @override
  List<Object> get props => [
        results,
        resultsProducts,
        resultsCategories,
        sortedByIndex,
        activePage,
      ];
}
