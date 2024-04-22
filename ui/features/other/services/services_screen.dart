import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_selector/cubit/selector_cubit.dart';
import 'package:tomas_matres/ui/components/tomas_selector/selector/selector.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/common/navigation/navigation_widget.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/components/delivery_info/delivery_info.dart';
import 'package:tomas_matres/ui/features/other/services/components/assembly/service_assembly.dart';
import 'package:tomas_matres/ui/features/other/services/mobile/services_screen_mobile.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

enum SelectorValues { delivery, assembly }

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final ScrollController scrollController = ScrollController();
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);
  SelectorValues currentView = SelectorValues.delivery;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return const ServicesScreenMobile();
    }

    return PageTemplate(
      body: Expanded(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: Utils.calculatePadding(context)),
          controller: scrollController,
          shrinkWrap: true,
          children: [
            const NavigationWidget(),
            Padding(
              padding: padding,
              child: Stack(
                children: [
                  Text(LocaleKeys.kTextServices.tr(),
                      style: UiConstants.kTextStyleHeadline1.copyWith(
                        color: UiConstants.kColorText01,
                      )),
                  Align(
                      alignment: AlignmentDirectional.center,
                      child: Selector(
                        titlesList: [
                          LocaleKeys.kTextDelivery.tr(),
                          LocaleKeys.kTextAssembly.tr()
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            SizedBox(
              child: Padding(
                padding: padding,
                child: BlocBuilder<SelectorCubit, SelectorState>(
                  builder: (context, state) {
                    if (state.selectedIndex == 0) {
                      return const DeliveryInfo();
                    } else {
                      return const ServiceAssembly();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Footer(
              scrollController: scrollController,
            )
          ],
        ),
      ),
    );
  }
}
