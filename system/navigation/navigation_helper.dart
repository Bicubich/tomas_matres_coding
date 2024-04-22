// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/ui/components/tomas_selector/cubit/selector_cubit.dart';
import 'package:tomas_matres/ui/features/catalog/catalog_screen.dart';
import 'package:tomas_matres/ui/features/catalog_categories/categories_catalog_screen.dart';
import 'package:tomas_matres/ui/features/cart_screen/cart_screen.dart';
import 'package:tomas_matres/ui/features/main_screen/main_screen.dart';
import 'package:tomas_matres/ui/features/other/about_company/about_company_screen.dart';
import 'package:tomas_matres/ui/features/other/contacts/contacts_screen.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/delivery_and_payment_screen.dart';
import 'package:tomas_matres/ui/features/other/not_found/not_found_screen.dart';
import 'package:tomas_matres/ui/features/other/reviews/reviews_screen.dart';
import 'package:tomas_matres/ui/features/other/services/services_screen.dart';
import 'package:tomas_matres/ui/features/other/warranty/warranty_screen.dart';
import 'package:tomas_matres/ui/features/product_screen/product_screen.dart';
import 'package:tomas_matres/ui/features/search_screen/search_screen.dart';

class NavigationHelper {
  static List<CustomRoute> currentRouteAsList = [Routes.root];

  static PageRouteBuilder onGenerateRoute(
      BuildContext context, RouteSettings settings) {
    if (settings.name != null && settings.name!.contains('&')) {
      if (settings.name!.substring(0, settings.name!.indexOf("&")) ==
          Routes.catalog.path) {
        RegExp categoryRegex = RegExp(r'&category_id=\d+');
        RegExp subcategoryRegex = RegExp(r'&subcategory_id=\d+');
        RegExp withSaleRegex = RegExp(r'&withSale=\d+');

        if (categoryRegex.hasMatch(settings.name!)) {
          String? categoryMatch = categoryRegex.stringMatch(settings.name!);

          if (categoryMatch != null) {
            String categoryId = categoryMatch.replaceAll('&category_id=', '');

            String? subcategoryMatch =
                subcategoryRegex.stringMatch(settings.name!);

            String? subcategoryId;
            if (subcategoryMatch != null) {
              subcategoryId =
                  subcategoryMatch.replaceAll('&subcategory_id=', '');
            }

            String? withSaleMatch = withSaleRegex.stringMatch(settings.name!);

            bool? withSale;
            if (withSaleMatch != null) {
              String withSaleAsString =
                  withSaleMatch.replaceAll('&withSale=', '');
              if (withSaleAsString == '1') {
                withSale = true;
              }
            }

            return defaultPageRouteBuilder(
                context,
                settings,
                CatalogScreen(
                  categoryId: categoryId,
                  subCategoryId: subcategoryId,
                  withSale: withSale ?? false,
                  routePath: settings.name!,
                ));
          }
        }
      }
      if (settings.name!.substring(0, settings.name!.indexOf("&")) ==
          Routes.productScreen.path) {
        RegExp regex = RegExp(r'&id=\d+');

        if (regex.hasMatch(settings.name!)) {
          String? productId =
              regex.stringMatch(settings.name!)!.replaceAll('&id=', '');
          return defaultPageRouteBuilder(
              context,
              settings,
              ProductScreen(
                productId: productId,
                routePath: settings.name!,
              ));
        }
      }
      if (settings.name!.substring(0, settings.name!.indexOf("&")) ==
          Routes.search.path) {
        _checkForRouteIsAddedToCurrentRouteList(Routes.search);
        RegExp regex = RegExp(r'&search_input=\S+');

        if (regex.hasMatch(settings.name!)) {
          String? searchInput = regex
              .stringMatch(settings.name!)!
              .replaceAll('&search_input=', '');
          return defaultPageRouteBuilder(
              context,
              settings,
              SearchScreen(
                searchInput: searchInput,
              ));
        }
      }
    }

    if (settings.name == Routes.root.path) {
      return defaultPageRouteBuilder(context, settings, const MainScreen());
    }

    if (settings.name == Routes.aboutCompany.path) {
      _checkForRouteIsAddedToCurrentRouteList(Routes.aboutCompany);
      return defaultPageRouteBuilder(
          context, settings, const AboutCompanyScreen());
    }
    if (settings.name == Routes.deliveryAndPayment.path) {
      _checkForRouteIsAddedToCurrentRouteList(Routes.deliveryAndPayment);
      return defaultPageRouteBuilder(
          context, settings, const DeliveryAndPaymentScreen());
    }
    if (settings.name == Routes.warranty.path) {
      _checkForRouteIsAddedToCurrentRouteList(Routes.warranty);
      return defaultPageRouteBuilder(context, settings, const WarrantyScreen());
    }
    if (settings.name == Routes.services.path) {
      _checkForRouteIsAddedToCurrentRouteList(Routes.services);
      return defaultPageRouteBuilder(
          context,
          settings,
          BlocProvider(
            create: (context) => SelectorCubit(),
            child: const ServicesScreen(),
          ));
    }
    if (settings.name == Routes.reviews.path) {
      _checkForRouteIsAddedToCurrentRouteList(Routes.reviews);
      return defaultPageRouteBuilder(context, settings, const ReviewsScreen());
    }
    if (settings.name == Routes.contacts.path) {
      _checkForRouteIsAddedToCurrentRouteList(Routes.contacts);
      return defaultPageRouteBuilder(context, settings, const ContactsScreen());
    }
    if (settings.name == Routes.catalog.path) {
      _checkForRouteIsAddedToCurrentRouteList(Routes.catalog);
      return defaultPageRouteBuilder(
          context,
          settings,
          BlocProvider(
            create: (context) => SelectorCubit(),
            child: CategoriesCatalogScreen(),
          ));
    }

    if (settings.name == Routes.cart.path) {
      _checkForRouteIsAddedToCurrentRouteList(Routes.cart);
      return defaultPageRouteBuilder(context, settings, const CartScreen());
    }

    if (settings.name == Routes.notFound.path) {
      _checkForRouteIsAddedToCurrentRouteList(Routes.notFound);
      return defaultPageRouteBuilder(context, settings, const NotFoundScreen());
    }

    _checkForRouteIsAddedToCurrentRouteList(Routes.notFound);
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation1, animation2) => const NotFoundScreen(),
    );
  }

  static PageRouteBuilder defaultPageRouteBuilder(
      BuildContext context, RouteSettings? settings, Widget destinationWidget) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation1, animation2) => Container(
        color: UiConstants.kColorBase01,
        child: destinationWidget,
      ),
      transitionDuration: Duration.zero,
    );
  }

  static void addRoute(BuildContext context, CustomRoute route) {
    if (route.path.contains(Routes.productScreen.path) &&
        currentRouteAsList.last.path.contains(Routes.productScreen.path)) {
      currentRouteAsList.removeLast();
    }
    currentRouteAsList.remove(route);
    currentRouteAsList.add(route);
    Navigator.of(context).pushNamed(route.path);
  }

  static void addRouteWithoutName(BuildContext context, String path) {
    Navigator.of(context).pushNamed(path);
  }

  /// Принимает несколько маршрутов, но переходит на последний, остальные добавляются в Navigation widget
  static void addMultipleRoutes(
      BuildContext context, List<CustomRoute> routes) {
    currentRouteAsList.clear();
    currentRouteAsList.add(Routes.root);

    currentRouteAsList.addAll(routes);

    Navigator.of(context).pushNamed(routes.last.path);
  }

  static void removeRoute(BuildContext context) {
    if (currentRouteAsList.length > 1) {
      currentRouteAsList.removeLast();
    }

    Navigator.pop(context);
  }

  static void removeRouteUntil(BuildContext context, CustomRoute route) {
    int index =
        currentRouteAsList.indexWhere((element) => element.path == route.path);
    if (index != -1) {
      currentRouteAsList.removeRange(index + 1, currentRouteAsList.length);
      Navigator.pushNamedAndRemoveUntil(context, route.path,
          (flutterRoute) => flutterRoute.settings.name == route.path);
    } else {
      replaceRoute(context, route);
    }
  }

  static void replaceRoute(BuildContext context, CustomRoute route) {
    currentRouteAsList.clear();
    currentRouteAsList.add(Routes.root);
    if (route != Routes.root) {
      currentRouteAsList.add(route);
    }
    Navigator.pushNamedAndRemoveUntil(context, route.path,
        (flutterRoute) => flutterRoute.settings.name == Routes.root.path);
  }

  static void openInNewTab(String route) {
    html.window.open('/#$route', "_blank");
  }

  static void _checkForRouteIsAddedToCurrentRouteList(CustomRoute route) {
    int index = currentRouteAsList
        .indexWhere((element) => element.title == route.title);
    if (index == -1) {
      currentRouteAsList.add(route);
    }
  }
}
