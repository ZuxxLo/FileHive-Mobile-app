class Validator {
  // Method to validate if the field is not empty
  static String? validateRequired(
      {required String? input, required String field}) {
    if (input == null || input.isEmpty) {
      return "Please enter a valid $field";
    }

    return null;
  }

  // Method to validate email format
  static String? validateEmail({required String? input}) {
    if (input == null || input.isEmpty) {
      return 'Please enter a valid email ';
    }
    // A simple regex for email validation
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$',
    );
    if (!emailRegExp.hasMatch(input)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Method to validate if the value is a number
  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final num? number = num.tryParse(value);
    if (number == null) {
      return 'Enter a valid number';
    }
    return null;
  }

  static String? validateConfirmPassword(
      {required String? confirmPassword, required String? password}) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
