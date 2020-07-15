import 'package:flutter/material.dart';

class Margins extends StatelessWidget {
  Margins(
      {@required this.child,
      this.right = 0.0,
      this.left = 0.0,
      this.bottom = 0.0,
      this.top = 0.0,
      this.all,
      this.height,
      this.width});

  final Widget child;
  final double right;
  final double left;
  final double top;
  final double bottom;
  final double all;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        child: child,
        margin: new EdgeInsets.only(
            right: all ?? right,
            left: all ?? left,
            top: all ?? top,
            bottom: all ?? bottom),
      );
}

class Padding extends StatelessWidget {
  Padding(
      {@required this.child,
      this.right = 0.0,
      this.left = 0.0,
      this.bottom = 0.0,
      this.top = 0.0,
      this.all,
      this.height,
      this.width});

  final Widget child;
  final double right;
  final double left;
  final double top;
  final double bottom;
  final double all;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        child: child,
        padding: new EdgeInsets.only(
            right: all ?? right,
            left: all ?? left,
            top: all ?? top,
            bottom: all ?? bottom),
      );
}

/// Creates margins based on the percentage of the
/// width and height of the child area
class PercentMargins extends StatelessWidget {
  PercentMargins(
      {@required this.child,
      this.right = 0.0,
      this.left = 0.0,
      this.bottom = 0.0,
      this.top = 0.0,
      this.all,
      this.height,
      this.width})
      : assert(right >= 0.0 && right <= 100.0),
        assert(left >= 0.0 && left <= 100.0),
        assert(bottom >= 0.0 && bottom <= 100.0),
        assert(top >= 0.0 && top <= 100.0),
        assert(all == null || (all >= 0.0 && all <= 100.0)),
        assert((top != 0.0 || left != 0.0 || right != 0.0 || bottom != 0.0) ||
            all != null);

  final Widget child;
  final double right;
  final double left;
  final double top;
  final double bottom;
  final double all;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraint) => Container(
          child: child,
          width: width,
          height: height,
          margin: new EdgeInsets.only(
            right: all != null
                ? width != null
                    ? width * all / 100.0
                    : constraint.maxWidth * all / 100.0
                : width != null
                    ? width * right / 100.0
                    : constraint.maxWidth * right / 100.0,
            left: all != null
                ? width != null
                    ? width * all / 100.0
                    : constraint.maxWidth * all / 100.0
                : width != null
                    ? width * left / 100.0
                    : constraint.maxWidth * left / 100.0,
            top: all != null
                ? height != null
                    ? height * all / 100.0
                    : constraint.maxHeight * all / 100.0
                : height != null
                    ? height * top / 100.0
                    : constraint.maxHeight * top / 100.0,
            bottom: all != null
                ? height != null
                    ? height * all / 100.0
                    : constraint.maxHeight * all / 100.0
                : height != null
                    ? height * bottom / 100.0
                    : constraint.maxHeight * bottom / 100.0,
          ),
        ),
      );
}
