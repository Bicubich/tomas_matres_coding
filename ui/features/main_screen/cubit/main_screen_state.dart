part of 'main_screen_cubit.dart';

sealed class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object> get props => [];
}

final class MainScreenLoading extends MainScreenState {}

final class MainScreenLoaded extends MainScreenState {
  final List<Product> specialProducts;
  final List<PopularCategory> popularCategories;

  const MainScreenLoaded(
      {required this.specialProducts, required this.popularCategories});

  @override
  List<Object> get props => [specialProducts, popularCategories];
}
