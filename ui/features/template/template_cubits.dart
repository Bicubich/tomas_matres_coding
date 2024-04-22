import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/ui/components/top_menu_background_shading/cubit/background_shading_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/bloc/total_dropdown_item_bloc.dart';
import 'package:tomas_matres/ui/features/common/header/search/cubit/top_menu_search_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/top_menu/cubit/content/top_menu_content_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/top_menu/top_menu_collapsed/cubit/buttons/top_menu_main_buttons_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/top_menu/top_menu_expanded/cubit/animation/top_menu_expanded_animation_cubit.dart';

class TemplateCubits extends StatelessWidget {
  final Widget child;

  const TemplateCubits({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BackgroundShadingCubit(),
        ),
        BlocProvider(
          create: (context) => TopMenuExpandedAnimationCubit(),
        ),
        BlocProvider(
          create: (context) => TopMenuMainButtonsCubit(
              topMenuExpandedCubit:
                  BlocProvider.of<TopMenuContentCubit>(context),
              topMenuExpandedAnimationCubit:
                  BlocProvider.of<TopMenuExpandedAnimationCubit>(context)),
        ),
        BlocProvider(
          create: (context) => TotalPriceBloc(),
        ),
        BlocProvider(
          create: (context) => TopMenuSearchCubit(
            topMenuContentCubit: BlocProvider.of<TopMenuContentCubit>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
