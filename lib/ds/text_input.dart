part of 'ds.dart';


class TopInputField extends StatelessWidget {
  final String? label;
  final bool? obscure;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final Widget? prefix;
  final InputBorder? border;
  final TextAlign? align;
  final String? initialValue;
  final TextStyle? style;
  final int? maxLength;
  final int? maxLines;
  final Widget? suffix;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const TopInputField({super.key, this.suffix,this.controller,this.label, this.initialValue,this.maxLines =1,this.maxLength,this.style,this.align, this.hintText,this.border = const OutlineInputBorder(), this.prefix,this.obscure,this.inputFormatters,this.validator,this.onChanged});

  @override
  Widget build(BuildContext context) {
    final  field =   TextFormField(
      controller: controller,
      initialValue: initialValue,
      textAlign: align ?? TextAlign.start,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: obscure ==true? 1:maxLines,
      obscureText: obscure ?? false,
      validator: validator,
      style: style,
      inputFormatters: inputFormatters,

      decoration:  InputDecoration(
        border: border,
        hintText: hintText,
        suffix: suffix,
        prefix: prefix
      ),
    );
    if(label !=null){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopText(text: label! + (validator != null ? '*' :'')),
          field
        ],
      );
    }
    return field;
  }
}