import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/ui/components/mobile/mobile_product_grid_card.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/favorite_icon/favorite_icon_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/top_menu_favorite/top_menu_favorite_cubit.dart';

class MobileProductsGridView extends StatelessWidget {
  final List<Product> products;

  const MobileProductsGridView({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // Минимальное количество столбцов
          crossAxisCount: getCrossAxisCount(context),
          // Соотношение сторон для каждого элемента
          childAspectRatio: getChildAspectRatio(context),
          // Пространство между столбцами и строками
          mainAxisSpacing: getMainAxisSpacing(context),
          crossAxisSpacing: getCrossAxisSpacing(context),
        ),
        itemBuilder: (context, index) {
          return BlocProvider(
            create: (context) => FavoriteIconCubit(
                productId: products[index].id,
                topMenuFavoriteCubit:
                    BlocProvider.of<TopMenuFavoriteCubit>(context)),
            child: MobileProductsGridCard(product: products[index]),
          );
        });
  }

  double getChildAspectRatio(BuildContext context) {
    if (MediaQuery.of(context).size.width < 485) {
      return linearInterpolation(
          x: MediaQuery.of(context).size.width,
          x1: 330,
          x2: 484,
          y1: 1.1,
          y2: 1.27);
    } else if (MediaQuery.of(context).size.width < 785) {
      return linearInterpolation(
          x: MediaQuery.of(context).size.width,
          x1: 485,
          x2: 784,
          y1: 1,
          y2: 1.19);
    } else {
      return linearInterpolation(
          x: MediaQuery.of(context).size.width,
          x1: 785,
          x2: 1544,
          y1: 0.75,
          y2: 0.9);
    }
  }

  int getCrossAxisCount(BuildContext context) {
    if (MediaQuery.of(context).size.width < 485) {
      return 1;
    } else if (MediaQuery.of(context).size.width < 785) {
      return 2;
    } else {
      return 3;
    }
  }

  double getMainAxisSpacing(BuildContext context) {
    if (MediaQuery.of(context).size.width < 485) {
      return 1;
    } else {
      return 32;
    }
  }

  double getCrossAxisSpacing(BuildContext context) {
    if (MediaQuery.of(context).size.width < 485) {
      return 1;
    } else {
      return 11;
    }
  }

  double linearInterpolation(
      {required double x,
      required double x1,
      required double x2,
      required double y1,
      required double y2}) {
    // Линейная интерполяция
    double y = y1 + (x - x1) * (y2 - y1) / (x2 - x1);

    return y;
  }
}
