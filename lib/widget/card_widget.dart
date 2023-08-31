import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final List<Widget> children;
  final Color? backgroundColor;
  final bool enableScroll;
  final BoxBorder? border;
  final EdgeInsetsGeometry padding;
  final BoxShadow? boxShadow;
  final BorderRadius? borderRadius;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  const CardWidget({
    Key? key,
    required this.children,
    required this.padding,
    this.borderRadius,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.boxShadow,
    this.backgroundColor,
    this.border,
    this.enableScroll = true,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // backgroundBlendMode: BlendMode.overlay,
        border: (widget.border == null)
            ? const Border.fromBorderSide(BorderSide.none)
            : widget.border,
        borderRadius: (widget.borderRadius == null)
            ? BorderRadius.circular(8)
            : widget.borderRadius,
        color: (widget.backgroundColor == null)
            ? Colors.white
            : widget.backgroundColor,
        boxShadow: [
          (widget.boxShadow != null)
              ? widget.boxShadow!
              : BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  // color: Theme.of(context).shadowColor,
                  // spreadRadius: 20,
                  blurRadius: 10,
                  blurStyle: BlurStyle.normal,
                ),
        ],
      ),
      padding: widget.padding,
      child: widget.enableScroll
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    widget.mainAxisAlignment ?? MainAxisAlignment.start,
                crossAxisAlignment:
                    widget.crossAxisAlignment ?? CrossAxisAlignment.start,
                children: widget.children,
              ),
            )
          : Column(
              mainAxisAlignment:
                  widget.mainAxisAlignment ?? MainAxisAlignment.start,
              crossAxisAlignment:
                  widget.crossAxisAlignment ?? CrossAxisAlignment.start,
              children: widget.children,
            ),
    );
  }
}
