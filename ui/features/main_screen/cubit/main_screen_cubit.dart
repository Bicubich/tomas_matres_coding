import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/api/api.dart';
import 'package:tomas_matres/data_models/banner_model.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/products_with_sale/data/special_product_model.dart';
import 'package:tomas_matres/ui/features/popular_categories/data/popular_category_model.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenLoading()) {
    _init();
  }

  List<Product> specialProducts = [];
  List<TomasBanner> mainBanners = [];
  List<Category> allCategories = [];

  int mainBannerId =
      7; // параметр для api получения баннеров для баннера на гл.странице
  List<TomasBanner> popularCategoriesBanners = [];
  List<PopularCategory> popularCategories = [];
  int popularCategoriesBannerId =
      9; // параметр для api получения баннеров для Популярных категорий на главной странице

  Future<void> _init() async {
    await Future.wait([
      _getSpecialProducts(),
      _getAllBanners(mainBannerId),
      _getPopularCategory(),
      _getAllCategories()
    ]).then((value) {
      specialProducts = value[0] as List<Product>;
      mainBanners = value[1] as List<TomasBanner>;
      popularCategories = value[2] as List<PopularCategory>;
      allCategories = value[3] as List<Category>;
    });

    emit(MainScreenLoaded(
      specialProducts: specialProducts,
      popularCategories: popularCategories,
    ));
  }

  Future<List<PopularCategory>> _getPopularCategory() async {
    List<PopularCategory> result = [];
    popularCategoriesBanners = await _getAllBanners(popularCategoriesBannerId);

    List<Future> futures = [];

    for (TomasBanner popularCategoryBanner in popularCategoriesBanners) {
      futures
          .add(TomasApi.getProductsCountByCategory(popularCategoryBanner.link));
    }

    List<int> listOfCounts = [];
    await Future.wait(futures).then((value) {
      for (var i = 0; i < value.length; i++) {
        listOfCounts.add(value[i] as int);
      }
    });

    for (int i = 0; i < popularCategoriesBanners.length; i++) {
      result.add(PopularCategory(
        categoryId: popularCategoriesBanners[i].link,
        name: popularCategoriesBanners[i].title,
        image: popularCategoriesBanners[i].image,
        countOfProducts: listOfCounts[i],
      ));
    }

    return result;
  }

  Future<List<Product>> _getSpecialProducts() async {
    List<SpecialProduct> specialProductsRow = await TomasApi.getSpecials(
        limit: '40'); //TODO Change to products from category "Sale"

    specialProductsRow
        .removeWhere((specialProductsRow) => specialProductsRow.status == '0');

    List<SpecialProduct> customSpecialProducts = List.of(specialProductsRow);

    customSpecialProducts.shuffle();

    customSpecialProducts.removeRange(8, specialProductsRow.length);

    List<Product> customProducts = [];
    for (SpecialProduct specialProduct in customSpecialProducts) {
      customProducts.add(Product.fromSpecialProduct(specialProduct));
    }

    return customProducts;
  }

  Future<List<TomasBanner>> _getAllBanners(int bannersGroupId) async {
    List<TomasBanner> banners = await TomasApi.getBannersData(bannersGroupId);
    return banners;
  }

  Future<List<Category>> _getAllCategories() async {
    List<Category> allCategories = await TomasApi.getCategories();

    return allCategories;
  }
}
