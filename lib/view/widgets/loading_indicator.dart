import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> loadingsheet(context) async {
  
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return const SizedBox(height: 100,
          child: SpinKitFadingCircle(
            color: Colors.black,
          ),
        );
      });
}
