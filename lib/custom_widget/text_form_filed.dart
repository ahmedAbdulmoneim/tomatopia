import 'package:flutter/material.dart';

Widget textFormField({
  IconData? suffix,
  IconData? prefix,
  String? label,
  onSaved,
  validate,
  suffixFunc,
  TextInputType? keyboardType,
  bool obscureText = false,
  TextEditingController? controller,
}) =>
    TextFormField(
      controller: controller,
      cursorColor: Colors.green,
      onSaved: onSaved,
      obscureText: obscureText,
      validator: validate,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.green,
            )),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixFunc,
                icon: Icon(suffix),
              )
            : null,
        prefixIcon: Icon(prefix),
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        focusColor: Colors.greenAccent,
      ),
    );
