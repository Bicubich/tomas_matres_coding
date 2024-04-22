import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/ui/components/tomas_chip_categories/cubit/tomas_category_chip_list_view_cubit.dart';
import 'package:tomas_matres/ui/components/tomas_chip_categories/tomas_category_chip.dart';

typedef IntCallback = Function(int value);

class TomasCategoryChipListView extends StatefulWidget {
  final VoidCallback onChipTap;
  final List<Category> categories;

  const TomasCategoryChipListView(
      {required this.categories, required this.onChipTap, super.key});

  @override
  State<TomasCategoryChipListView> createState() =>
      _TomasCategoryChipListViewState();
}

class _TomasCategoryChipListViewState extends State<TomasCategoryChipListView> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.only(right: 140),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.categories.length,
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            itemBuilder: (context, index) {
              return BlocBuilder<TomasCategoryChipListViewCubit,
                  TomasCategoryChipListViewState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: TomasCategoryChip(
                      title: widget.categories[index].name,
                      onTap: () => state.activeIndex != index
                          ? onTap(index, context)
                          : () {},
                      isActive: state.activeIndex == index,
                    ),
                  );
                },
              );
            }),
      ),
    );
  }

  void onTap(int index, BuildContext context) {
    widget.onChipTap();
    BlocProvider.of<TomasCategoryChipListViewCubit>(context)
        .onChipTap(index: index);
  }
}
