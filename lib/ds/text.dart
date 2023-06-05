
part of 'ds.dart';

class TopText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const TopText({super.key,required this.text, this.style});
  @override
  Widget build(BuildContext context) {
    return Text(text,style: style,);
  }
}