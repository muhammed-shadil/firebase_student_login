import 'package:flutter/material.dart';

class Textfield1 extends StatelessWidget {
  const Textfield1({super.key, this.icon1, this.hint, this.controller, required String? Function(dynamic value) validator});
  final Icon? icon1;
  final String? hint;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: icon1,
          suffixIconColor: Colors.black54,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 43, 231, 181))),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color.fromARGB(255, 93, 201, 173))),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 93, 201, 173)))),
    );
  }
}
