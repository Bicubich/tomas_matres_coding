import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';

class ProductDropdownCharacteristicInfo extends StatelessWidget {
  final List<ProductAttributeGroupe> attributes;
  final double fontSize;

  const ProductDropdownCharacteristicInfo(
      {required this.attributes, super.key, this.fontSize = 20});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: generateCharacteristic(),
    );
  }

  List<Widget> generateCharacteristic() {
    const String systemAttributeGroupeName = 'system';
    int systemAttributeIndex = attributes
        .indexWhere((element) => element.name == systemAttributeGroupeName);

    if (systemAttributeIndex != -1) {
      attributes.removeAt(systemAttributeIndex);
    }

    return List<Widget>.generate(attributes.length, (groupeIndex) {
      ProductAttributeGroupe attributeGroupe = attributes[groupeIndex];
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              attributeGroupe.name,
              style: UiConstants.kTextStyleHeadline4.copyWith(
                  color: UiConstants.kColorText01, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(attributeGroupe.attribute.length,
                  (attributeIndex) {
                ProductAttribute attribute =
                    attributeGroupe.attribute[attributeIndex];
                return Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: RichText(
                      text: TextSpan(
                          text: attribute.name.trim(),
                          style: UiConstants.kTextStyleText1.copyWith(
                              color: UiConstants.kColorText02,
                              fontSize: fontSize),
                          children: [
                        TextSpan(
                          text: ': ',
                          style: UiConstants.kTextStyleText1.copyWith(
                              color: UiConstants.kColorText02,
                              fontSize: fontSize),
                        ),
                        TextSpan(
                          text: attribute.text,
                          style: UiConstants.kTextStyleText1.copyWith(
                              color: UiConstants.kColorText03,
                              fontSize: fontSize),
                        ),
                      ])),
                );
              }),
            )
          ]);
    });
  }
}
