// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Textfield1 extends StatelessWidget {
  const Textfield1({
    Key? key,
    this.keyboard,
    this.icon1,
    this.hint,
    this.controller,
    required this.validator,
  }) : super(key: key);
  final TextInputType? keyboard;
  final Icon? icon1;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(dynamic value) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      keyboardType: keyboard,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(disabledBorder:OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ), 
        errorMaxLines: 3,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: icon1,
        suffixIconColor: Colors.black54,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 93, 201, 173),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 93, 201, 173),
          ),
        ),
         focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 227, 8, 12),
          ),
        ),

        // border: const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(10),
        //   ),
        //   borderSide: BorderSide(
        //     color: Color.fromARGB(255, 93, 201, 173),
        //   ),
        // ),
      ),
    );
  }
}
