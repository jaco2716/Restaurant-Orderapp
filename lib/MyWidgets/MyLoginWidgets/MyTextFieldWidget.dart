import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final bool obscureText;
  final String? Function(String?) validate;
  final void Function(String?) setValue;
  final TextInputType textInputType;
  final double horizontalPaddig;

  MyTextFieldWidget({
    required this.hintText,
    required this.icon,
    required this.obscureText,
    required this.setValue,
    required this.validate,
    required this.textInputType,
    this.horizontalPaddig = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: EdgeInsets.only(left: horizontalPaddig, right: horizontalPaddig, top: 7, bottom: 0),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 10, height: 0.1),
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          hintText: hintText,
        ),
        keyboardType: textInputType,
        validator: (value) => validate(value),
        onSaved: (value) => setValue(value),
      ),
    );
  }
}


// TextFormField(
//         controller: textEditingController,
//         decoration: InputDecoration(
//           prefix: prefixText == null ? null : Text(prefixText),
//           border: OutlineInputBorder(),
//           labelText: title,
//           suffixText: suffixText,
//           errorStyle: TextStyle(height: 0.5),
//         ),
//         inputFormatters: allowedInput != null
//             ? <TextInputFormatter>[
//                 FilteringTextInputFormatter.allow(RegExp(allowedInput))
//               ]
//             : null,
//         textCapitalization: TextCapitalization.words,
//         keyboardType: textInputType,
//         validator: (value) => validate(value),
//         onSaved: (value) => setValue(value),
//         readOnly: readOnly,
//         onTap: onTap,
//       ),