part of 'product_info_price_cubit.dart';

class ProductInfoPriceState extends Equatable {
  final int price;
  final int? special;

  const ProductInfoPriceState({required this.price, this.special});

  @override
  List<Object?> get props => [price, special];
}
