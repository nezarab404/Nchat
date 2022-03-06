class Validator {
  static String? emailValidator(String? val) {
    return val!.isEmpty
        ? "this field is required"
        : RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(val)
            ? null
            : "this email is not correct";
  }

  static String? passwordValidator(String? val) {
    return val!.isEmpty
        ? "this field is required"
        : val.length > 7
            ? null
            : "8 characters at least";
  }

  static String? nameValidator(String? val) {
    return val!.isEmpty
        ? "this field is required"
        : val.length > 2
            ? null
            : "3 characters at least";
  }

  static String? phoneValidator(String? val){
    return val!.isEmpty
        ? "this field is required"
        : val.length > 9
            ? null
            : "10 numbers at least";
  }
}
