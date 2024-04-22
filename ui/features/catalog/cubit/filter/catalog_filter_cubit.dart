import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_cubit.dart';
import 'package:tomas_matres/ui/features/catalog/data/filter_data.dart';

part 'catalog_filter_state.dart';

class CatalogFilterCubit extends Cubit<CatalogFilterState> {
  final CatalogCubit catalogCubit;
  final FilterType filterCharacteristics;
  final List<Product> allProducts;

  CatalogFilterCubit(
      {required this.catalogCubit,
      required this.filterCharacteristics,
      required this.allProducts})
      : super(CatalogFilterInitial()) {
    _init();
  }

  StreamSubscription<List<Product>>? streamSubscription;

  void _init({List<Product>? productsBySubcategory}) {
    List<Product> products;
    if (productsBySubcategory != null) {
      products = productsBySubcategory;
    } else {
      products = allProducts;
    }

    if (products.isNotEmpty) {
      double minValue = _getMinValueCharacteristic(products);
      double maxValue = _getMaxValueCharacteristic(products);

      if (catalogCubit.filterData.isNotEmpty && productsBySubcategory == null) {
        int index = catalogCubit.filterData
            .indexWhere((element) => element.type == filterCharacteristics);
        if (index != -1) {
          FilterData filterData = catalogCubit.filterData[index];
          emit(CatalogFilterLoaded(
              minValue: minValue,
              maxValue: maxValue,
              minCurrentValue: filterData.filterDataValues.minValue < minValue
                  ? minValue
                  : filterData.filterDataValues.minValue,
              maxCurrentValue: filterData.filterDataValues.maxValue > maxValue
                  ? maxValue
                  : filterData.filterDataValues.maxValue));

          streamSubscription ??= catalogCubit.streamController.stream
              .listen((categoryWiseProducts) {
            _init(productsBySubcategory: categoryWiseProducts);
          });
          return;
        }
      }

      catalogCubit.setFilterData(
          filterType: filterCharacteristics,
          minValue: minValue,
          maxValue: maxValue);
      emit(CatalogFilterLoaded(
          minValue: minValue,
          maxValue: maxValue,
          minCurrentValue: minValue,
          maxCurrentValue: maxValue));
    } else {
      emit(CatalogFilterNoProducts());
    }

    streamSubscription ??=
        catalogCubit.streamController.stream.listen((categoryWiseProducts) {
      _init(productsBySubcategory: categoryWiseProducts);
    });
  }

  void updateValue({required double minValue, required double maxValue}) {
    catalogCubit.setFilterData(
        filterType: filterCharacteristics,
        minValue: minValue,
        maxValue: maxValue);
    emit((state as CatalogFilterLoaded)
        .copyWith(minCurrentValue: minValue, maxCurrentValue: maxValue));
  }

  double _getMinValueCharacteristic(List<Product> products) {
    double result;

    result = (products.map((product) {
      switch (filterCharacteristics) {
        case FilterType.price:
          return product.specialPrice ?? product.price;
        case FilterType.width:
          return product.width;
        case FilterType.height:
          return product.height;
        case FilterType.length:
          return product.length;
        default:
          return 0;
      }
    }).reduce((value, element) => element < value ? element : value))
        .toDouble();

    return result;
  }

  double _getMaxValueCharacteristic(List<Product> products) {
    double result;

    result = (products.map((product) {
      switch (filterCharacteristics) {
        case FilterType.price:
          if (product.specialPrice != null) {
            return product.specialPrice!;
          } else {
            if (catalogCubit.onlyWithSale) {
              return 0;
            } else {
              return product.price;
            }
          }
        case FilterType.width:
          return product.width;
        case FilterType.height:
          return product.height;
        case FilterType.length:
          return product.length;
        default:
          return 0;
      }
    }).reduce((value, element) => element > value ? element : value))
        .toDouble();

    return result;
  }

  @override
  Future<void> close() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }

    return super.close();
  }
}
