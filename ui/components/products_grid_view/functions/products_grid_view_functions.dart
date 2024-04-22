import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/utils.dart';

class ProductsGridViewFunctions {
  static double? getTopPosition(
      {required int index, required int countOfElementsPerRow}) {
    // Вычисляем строку элемента
    int row = (index / countOfElementsPerRow).floor();

    return (48 + 408) * row + 48;
  }

  static double? getLeftPosition(
      {required BuildContext context,
      required int index,
      required int countOfElementsPerRow,
      required int maxCountOfElementsPerRow}) {
    double additionalPadding = 40;

    // Получаем индекс в строке. Если это первая строка, то используем переданный индекс
    if (index > countOfElementsPerRow - 1) {
      // Если индекс больше, чем количество элементов в строке, то нужно привести индекс к индексу в строке
      // Вычисляем строку элемента
      int row = (index / countOfElementsPerRow).floor();

      // Вычисляем индекс в строке
      index = index - countOfElementsPerRow * row;
    }

    // Если элементы с правого края, то позиционировать по левому краю не нужно
    if (index >= 2) {
      return null;
    }
    // Если это первый элемент с левого края, то возвращаем доп паддинг в качестве позиции
    if (index == 0) {
      return additionalPadding;
    }

    double availableSpace =
        getAvailableSpace(context, maxCountOfElementsPerRow);

    double availableSpacePerElement;

    if (maxCountOfElementsPerRow < 4) {
      availableSpacePerElement = availableSpace / maxCountOfElementsPerRow;
    } else {
      availableSpacePerElement = availableSpace / 4; //maxCountOfElementsPerRow;
    }

    // Остается только второй элемент его позиция начинается с конца первого элемента
    double result = availableSpacePerElement + additionalPadding;
    return result;
  }

  static double? getRightPosition(
      {required BuildContext context,
      required int index,
      required int countOfElementsPerRow,
      required int maxCountOfElementsPerRow}) {
    double additionalPadding = 40;

    // Получаем индекс в строке. Если это первая строка, то используем переданный индекс
    if (index > countOfElementsPerRow - 1) {
      // Если индекс больше, чем количество элементов в строке, то нужно привести индекс к индексу в строке
      // Вычисляем строку элемента
      int row = (index / countOfElementsPerRow).floor();

      // Вычисляем индекс в строке
      index = index - countOfElementsPerRow * row;
    }

    // Если элементы с левого края, то позиционировать по правому краю не нужно
    if (index < 2) {
      return null;
    }
    // Если это первый элемент с правого края, то возвращаем доп паддинг в качестве позиции
    if (index == 3) {
      return additionalPadding;
    }

    // Если элементов меньше чем 4, то ровняем элемент по правой стороне с доп паддингом
    if (maxCountOfElementsPerRow < 4) {
      return additionalPadding;
    }

    double availableSpace =
        getAvailableSpace(context, maxCountOfElementsPerRow);

    double availableSpacePerElement;

    if (maxCountOfElementsPerRow < 4) {
      availableSpacePerElement = availableSpace / maxCountOfElementsPerRow;
    } else {
      availableSpacePerElement = availableSpace / 4; //maxCountOfElementsPerRow;
    }

    // Остается только третий элемент его позиция начинается с конца последнего элемента
    double result = availableSpacePerElement + additionalPadding;
    return result;
  }

  static double reSize(
      {required BuildContext context, required int maxCountOfElementsPerRow}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double mainPadding = Utils.calculatePadding(context);

    double availableSpace = screenWidth - (mainPadding * 2);
    double availableSpacePerElement =
        availableSpace / 4; //maxCountOfElementsPerRow;

    if (maxCountOfElementsPerRow < 4) {
      availableSpacePerElement = (availableSpace - availableSpacePerElement) /
          maxCountOfElementsPerRow;
    }

    return availableSpacePerElement - 80;
  }

  static double getAvailableSpace(
      BuildContext context, int maxCountOfElementsPerRow) {
    double screenWidth = MediaQuery.of(context).size.width;
    double mainPadding = Utils.calculatePadding(context);

    double availableSpace = screenWidth - (mainPadding * 2);

    if (maxCountOfElementsPerRow < 4) {
      // Если столбцов меньше 4, то берем размер элемента и вычитаем его из доступного места
      double availableSpacePerElement = availableSpace / 4;

      availableSpace = availableSpace -
          (availableSpacePerElement * (4 - maxCountOfElementsPerRow));
    }

    return availableSpace;
  }
}
