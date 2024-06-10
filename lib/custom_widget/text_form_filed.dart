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

Widget bigTextFormFiled(
{
  String? hint,
  validate,
  TextEditingController? controller,
  IconData? prefix,

}
    )=> TextFormField(
  validator: validate,
  maxLines: 8,
  enableInteractiveSelection: true,
  cursorColor: Colors.green,
  controller: controller,
  decoration:  InputDecoration(
    hintText: hint,
    prefixIcon: Icon(prefix),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green)),
    border: const OutlineInputBorder(),
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red)),
    errorStyle: const TextStyle(color: Colors.red),
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
  ),
);
