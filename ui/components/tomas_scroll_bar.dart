import 'package:flutter/material.dart';

class TomasScrollBar extends StatefulWidget {
  final double thickness;
  final Color trackColor;
  final Color thumbColor;
  final ScrollController scrollController;
  final EdgeInsets padding;

  const TomasScrollBar(
      {required this.thickness,
      required this.trackColor,
      required this.thumbColor,
      required this.scrollController,
      required this.padding,
      super.key});

  @override
  State<TomasScrollBar> createState() => _TomasScrollBarState();
}

class _TomasScrollBarState extends State<TomasScrollBar> {
  double thumbWidth = 100;
  double position = 0;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      calculatePosition();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: widget.padding,
          alignment: Alignment.center,
          color: widget.trackColor,
          height: widget.thickness,
          width: MediaQuery.of(context).size.width -
              widget.padding.left -
              widget.padding.right,
        ),
        Positioned(
          left: position,
          child: Container(
            color: widget.thumbColor,
            height: widget.thickness,
            width: thumbWidth,
          ),
        ),
      ],
    );
  }

  void calculatePosition() {
    double maxScrollExtent = widget.scrollController.position.maxScrollExtent;
    double currentOffset = widget.scrollController.offset;
    double screenWidth = MediaQuery.of(context).size.width;
    double leftPadding = widget.padding.left;
    double rightPadding = widget.padding.right;
    double visibleWidth = screenWidth - leftPadding - rightPadding;

    double scrollPercentage = (currentOffset / maxScrollExtent) * 100;

    position = (visibleWidth - thumbWidth) * scrollPercentage / 100;

    setState(() {});
  }
}
