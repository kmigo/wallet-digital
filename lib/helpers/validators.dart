class HelperValidator {
  static bool email(String? text){
    if(text == null) return false;
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(text);
  }
  static bool password(String? text){
    if(text ==null) return false;
    if(text.length < 6 ) return false;
    return true;
  }

  static bool required(String? text){
    return text?.isNotEmpty == true;
  }
}