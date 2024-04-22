import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_grid_view_item_event.dart';
part 'product_grid_view_item_state.dart';

class ProductGridViewItemBloc
    extends Bloc<ProductGridViewItemEvent, ProductGridViewItemState> {
  ProductGridViewItemBloc()
      : super(const ProductGridViewItemCollapsedState(selected: false)) {
    on<ProductGridViewItemShowExpandedEvent>((event, emit) async {
      emit(const ProductGridViewItemExpandedState(selected: false));
    });
    on<ProductGridViewItemShowCollapsedEvent>((event, emit) async {
      emit(const ProductGridViewItemCollapsedState(selected: false));
    });
    on<ProductGridViewItemStartForwardAnimationEvent>((event, emit) async {
      emit(const ProductGridViewItemExpandedState(selected: true));
    });
    on<ProductGridViewItemStartBackwardAnimationEvent>((event, emit) async {
      emit(const ProductGridViewItemExpandedState(selected: false));
    });
  }
}
