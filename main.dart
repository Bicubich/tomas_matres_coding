import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/shared_cubits/customer/customer_cubit.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/ui/components/tomas_notification_widget/cubit/tomas_notification_widget_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/top_menu/cubit/content/top_menu_content_cubit.dart';
import 'package:tomas_matres/ui/features/other/about_company/cubit/about_company_cubit.dart';
import 'package:tomas_matres/ui/features/recommended_today/cubit/recommended_today_cubit.dart';
import 'package:tomas_matres/ui/features/reviews/cubit/reviews_cubit.dart';
import 'ui/features/common/header/favorite/cubit/top_menu_favorite/top_menu_favorite_cubit.dart';
import 'ui/features/main_screen/cubit/main_screen_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/data/it_may_suit_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/cubit/order_information_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ru'),
        startLocale: const Locale('ru'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainScreenCubit(),
        ),
        BlocProvider(
          create: (context) => CustomerCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(
            customerCubit: BlocProvider.of<CustomerCubit>(context),
          ),
        ),
        BlocProvider(
          create: (context) => ItMaySuitCubit(
            cartCubit: BlocProvider.of<CartCubit>(context),
            mainScreenCubit: BlocProvider.of<MainScreenCubit>(context),
          ),
        ),
        BlocProvider(
          create: (context) => TopMenuFavoriteCubit(
              customerCubit: BlocProvider.of<CustomerCubit>(context)),
        ),
        BlocProvider(
          create: (context) => TomasNotificationWidgetCubit(),
        ),
        BlocProvider(
          create: (context) => OrderInformationCubit(
              customerCubit: BlocProvider.of<CustomerCubit>(context)),
        ),
        BlocProvider(
          create: (context) => TopMenuContentCubit(),
        ),
        BlocProvider(
          create: (context) => AboutCompanyCubit(),
        ),
        BlocProvider(
          create: (context) => ReviewsCubit(),
        ),
        BlocProvider(
          create: (context) => RecommendedTodayCubit(),
        ),
      ],
      child: MaterialApp(
          title: "Tomas Matres",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primaryColorDark: UiConstants.kColorBase01,
            ).copyWith(background: UiConstants.kColorBase01),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primaryColorDark: UiConstants.kColorBase01,
            ).copyWith(background: UiConstants.kColorBase01),
          ),
          highContrastDarkTheme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primaryColorDark: UiConstants.kColorBase01,
            ).copyWith(background: UiConstants.kColorBase01),
          ),
          highContrastTheme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primaryColorDark: UiConstants.kColorBase01,
            ).copyWith(background: UiConstants.kColorBase01),
          ),
          themeMode: ThemeMode.light,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            );
          },
          initialRoute: '/',
          onGenerateRoute: (settings) =>
              NavigationHelper.onGenerateRoute(context, settings)),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
