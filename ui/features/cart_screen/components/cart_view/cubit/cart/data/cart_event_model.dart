import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';

enum CartEventType {
  addItem,
  removeItem,
  removeAll,
}

class CartEvent {
  CartEventType event;
  CartProduct? product;

  CartEvent(this.event, {this.product});
}
