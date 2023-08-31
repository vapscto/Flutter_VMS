import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatefulWidget {
  final ValueChanged<int>? onTabSelect;
  final TabController tabController;
  final List<CustomTab> tabs;
  const CustomTabBar(
      {this.onTabSelect,
      required this.tabs,
      required this.tabController,
      super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late double width;
  final double height = 45;
  final double shrinkRatio = 0.9;
  late double enlargeRatio;
  final indexNotifier = ValueNotifier<int>(0);
  @override
  void initState() {
    widget.tabController.addListener(() {
      if (indexNotifier.value != widget.tabController.index) {
        indexNotifier.value = widget.tabController.index;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.tabController.removeListener(() {});
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // reload to see tab changes
    enlargeRatio = 1 + ((1.0 - shrinkRatio) * (widget.tabs.length - 1));
    width = (Get.width) / widget.tabs.length;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: ValueListenableBuilder(
          valueListenable: indexNotifier,
          builder: (context, index, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.tabs.length; i++)
                  InkWell(
                    onTap: () {
                      indexNotifier.value = i;
                      widget.tabController.animateTo(i);
                      if (widget.onTabSelect != null) widget.onTabSelect!(i);
                    },
                    child: CustomPaint(
                      painter: TabBarPainter(
                          context: context,
                          left: index == (i - 1),
                          right: index == (i + 1)),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1),
                        decoration: BoxDecoration(
                            color:
                                index == i ? Colors.white : Colors.transparent,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15))),
                        width: index == i
                            ? (width * enlargeRatio)
                            : (width * shrinkRatio),
                        height: height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            index == i
                                ? SvgPicture.asset(
                                    widget.tabs[i].asset,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(width: 8),
                            Text(widget.tabs[i].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.1,
                                    fontSize: 16,
                                    color: index == i
                                        ? Theme.of(context).primaryColor
                                        : Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            );
          }),
    );
  }
}

class TabBarPainter extends CustomPainter {
  final BuildContext context;
  final bool left;
  final bool right;
  TabBarPainter(
      {required this.context, required this.left, required this.right});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Theme.of(context).primaryColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(0, 0, size.width, size.height - 1),
            bottomLeft: left ? const Radius.circular(15) : Radius.zero,
            bottomRight: right ? const Radius.circular(15) : Radius.zero),
        paint);
  }

  @override
  bool shouldRepaint(TabBarPainter oldDelegate) => false;
}

class CustomTab {
  final String name;
  final String asset;
  const CustomTab({required this.name, required this.asset});
}
