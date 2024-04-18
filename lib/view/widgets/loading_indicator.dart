import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Future<void> loadingsheet(context) async {
//   showModalBottomSheet(
//       backgroundColor: Color.fromARGB(255, 195, 246, 233),
//       context: context,
//       builder: (context) {
//         return Container(
//           height: 90,
//           color: const Color.fromARGB(255, 205, 249, 237),
//           child: const SpinKitFadingCircle(
//             duration: Duration(seconds: 2),
//             color: Colors.black,
//           ),
//         );
//       });
// }

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            color: Colors.transparent,
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
