import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_info_price_state.dart';

class ProductInfoPriceCubit extends Cubit<ProductInfoPriceState> {
  final int price;
  final int? special;
  ProductInfoPriceCubit({required this.price, required this.special})
      : super(ProductInfoPriceState(price: price, special: special)) {
    _init();
  }

  int currentPrice = 0;
  int? currentSpecial;

  void _init() {
    currentPrice = price;
    currentSpecial = special;
  }

  void onAdd({int price = 0}) {
    currentPrice += price;
    if (currentSpecial != null) {
      currentSpecial = currentSpecial! + price;
    }

    emit(ProductInfoPriceState(price: currentPrice, special: currentSpecial));
  }

  void onRemove({int price = 0}) {
    currentPrice -= price;
    if (currentSpecial != null) {
      currentSpecial = currentSpecial! - price;
    }

    emit(ProductInfoPriceState(price: currentPrice, special: currentSpecial));
  }
}
