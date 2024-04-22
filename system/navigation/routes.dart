import 'package:tomas_matres/system/data/route_model.dart';

class Routes {
  static const CustomRoute root = CustomRoute(title: 'Главная', path: '/');
  static const CustomRoute aboutCompany =
      CustomRoute(title: 'О компании', path: '/about_company');
  static const CustomRoute deliveryAndPayment =
      CustomRoute(title: 'Доставка и оплата', path: '/delivery_and_payment');
  static const CustomRoute services =
      CustomRoute(title: 'Услуги', path: '/services');
  static const CustomRoute warranty =
      CustomRoute(title: 'Гарантии', path: '/warranty');
  static const CustomRoute reviews =
      CustomRoute(title: 'Отзывы', path: '/reviews');
  static const CustomRoute contacts =
      CustomRoute(title: 'Контакты', path: '/contacts');
  static const CustomRoute catalog =
      CustomRoute(title: 'Каталог', path: '/categories_catalog');
  static const CustomRoute productScreen =
      CustomRoute(title: 'Спальни', path: '/product');
  static const CustomRoute cart =
      CustomRoute(title: 'Оформление заказа', path: '/cart');
  static const CustomRoute search =
      CustomRoute(title: 'Поиск', path: '/search');
  static const CustomRoute notFound =
      CustomRoute(title: 'Не найдено', path: '/not_found');

  static List<CustomRoute> get allRoutes => [
        root,
        aboutCompany,
        deliveryAndPayment,
        services,
        warranty,
        reviews,
        contacts,
        catalog,
        productScreen,
        cart,
        search,
        notFound
      ];
}
