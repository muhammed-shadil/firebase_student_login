import 'package:flutter/material.dart';

class button1 extends StatelessWidget {
  const button1({super.key, required this.btntext, this.onpressed});
  final String btntext;
  final Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: const Color.fromARGB(255, 93, 201, 173),
        ),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height * .06,
        child: Center(
            child: Text(
          btntext,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        )),
      ),
    );
  }
}
