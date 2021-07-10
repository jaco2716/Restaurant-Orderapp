class ValidateValues {
  //check if string is empty
  String? validateString(String? value) {
    try {
      return value!.isEmpty ? 'Required' : null;
    } catch (e) {
      return "Required";
    }
  }

  // Check if the number value is valid
  String? validateDouble(String value) {
    try {
      value = value.replaceAll(',', '.');
      double.parse(value);
      return null;
    } catch (error) {
      return "Invalid number.";
    }
  }

  // Check if the number value is valid
  String? validateInt(String value, {int? aboveValue, int? bellowValue, bool canBeNull = false}) {
    try {
      if (value == '' && canBeNull) return null;
      int intValue = int.parse(value);
      if (aboveValue != null) {
        if (intValue <= aboveValue) {
          return "Must be greater than $aboveValue";
        }
      }
      if (bellowValue != null) {
        if (intValue >= bellowValue) {
          return "Must be less than $bellowValue";
        }
      }
      return null;
    } catch (error) {
      return "Invalid number.";
    }
  }

  String? validatePassword(String? value) {
    try {
      return value!.length < 6 ? 'Password must be at least 6 characters' : null;
    } catch (e) {
      return "Password must be at least 6 characters";
    }
  }

  String? validateEmail(String? value) {
    try {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      return (!regex.hasMatch(value!)) ? 'Invalid E-mail.' : null;
    } catch (e) {
      return "Password must be at least 6 characters";
    }
  }
}
