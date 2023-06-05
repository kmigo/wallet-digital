
part of 'ds.dart';

class TopCard extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final Widget child;
  final Color? color;
  const TopCard({super.key,this.borderRadius,required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? TopColors.greyColor.withOpacity(.5),
      shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(15)),
      child: child,
    );
  }
}