import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';

class MyToast extends StatelessWidget {
  const MyToast({super.key});

  static void showErrorTost(
    BuildContext context,
    String message,
  ) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        elevation: 0,
        padding: const EdgeInsets.all(16),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        content: SizedBox(
          width: Scaler.width(1, context),
          child: Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showLoadingToast(
    ScaffoldMessengerState scaffold,
    BuildContext context,
    String message,
  ) {
    if (message.isEmpty) {
      message = "İşleminiz gerçleştiriliyor...";
    }

    scaffold.showSnackBar(
      SnackBar(
        elevation: 0,
        padding: const EdgeInsets.all(16),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Scaler.width(0.6, context),
              child: Text(
                message,
                style: TextStyle(color: Theme.of(context).colorScheme.surface),
              ),
            ),
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.surface,
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void closeToast(ScaffoldMessengerState scaffold) {
    scaffold.hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  static void showInfoBox(
    BuildContext context,
    String message,
  ) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 -
            50, // Center vertically (100 / 2 = 50)
        left: MediaQuery.of(context).size.width / 2 -
            100, // Center horizontally (200 / 2 = 100)
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            height: 75,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Text(
                message,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
