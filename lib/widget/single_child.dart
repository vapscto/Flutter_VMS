import 'package:flutter/material.dart';

class SingleChildCardWidget extends StatefulWidget {
  final Widget child;
  final BoxShadow? boxShadow;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  const SingleChildCardWidget({
    Key? key,
    required this.child,
    this.borderRadius,
    this.border,
    this.boxShadow,
  }) : super(key: key);

  @override
  State<SingleChildCardWidget> createState() => _SingleChildCardWidgetState();
}

class _SingleChildCardWidgetState extends State<SingleChildCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: (widget.border == null)
              ? const Border.fromBorderSide(BorderSide.none)
              : widget.border,
          backgroundBlendMode: BlendMode.overlay,
          borderRadius: (widget.borderRadius == null)
              ? BorderRadius.circular(15)
              : widget.borderRadius,
          color: Theme.of(context).cardTheme.color,
          boxShadow: [
            (widget.boxShadow != null)
                ? widget.boxShadow!
                : BoxShadow(
                    color: Theme.of(context).shadowColor,
                    // offset: const Offset(-5, -5),
                    blurRadius: 5,
                    blurStyle: BlurStyle.normal,
                  ),
            // BoxShadow(
            //   color: Theme.of(context).shadowColor,
            //   // offset: const Offset(5, 5),
            //   blurRadius: 5,
            //   blurStyle: BlurStyle.normal,
            // ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Center(
            child: widget.child,
          ),
        ));
  }
}
