import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:timeago/timeago.dart' as timeago;

class Utils {
  static final _selectedDate = DateTime.now();

  static final _initialTime = TimeOfDay.now();

  static String formatPrice(double price) => '\$${price.toStringAsFixed(1)}';

  static String formatDate(var date) {
    late DateTime _dateTime;
    if (date is String) {
      _dateTime = DateTime.parse(date);
    } else {
      _dateTime = date;
    }
    _dateTime = _dateTime.toLocal();

    return DateFormat.yMMMMd().format(_dateTime);
  }

  static String numberCompact(num number) =>
      NumberFormat.compact().format(number);

  static String timeAgo(String? time) {
    try {
      if (time == null) return '';
      return timeago.format(DateTime.parse(time));
    } catch (e) {
      return '';
    }
  }

  static Future showLoadingDialog(BuildContext context, {String? text}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Row(
              children: [
                const CircularProgressIndicator(color: redColor),
                const SizedBox(
                  width: 40,
                ),
                Text(text!)
              ],
            ),
          ),
        );
      },
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(message, textAlign: TextAlign.center),
    ));
  }

  static Future<DateTime?> selectDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2050),
      );

  static Future<TimeOfDay?> selectTime(BuildContext context) =>
      showTimePicker(context: context, initialTime: _initialTime);

  static Future showCustomDialog(BuildContext context, {Widget? child}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
      },
    );
  }

  void showRatingAppDialog(context) {
    final _ratingDialog = RatingDialog(
      starColor: Colors.amber,
      // ratingColor: Colors.amber,
      title: const Text('Feedback to rider'),

      // onCancelled: () {},
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          Container();
        }
      },
      submitButtonText: 'Submit',
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _ratingDialog,
    );
  }

  static showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Log out?"),
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            CupertinoDialogAction(
                isDefaultAction: false,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            CupertinoDialogAction(
                textStyle: const TextStyle(color: Colors.red),
                isDefaultAction: true,
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: const Text("Log out")),
          ],
        );
      },
    );
  }

  // static void showCustomDialog(BuildContext context, Widget child,
  //     {VoidCallback? onTap}) {
  //   showGeneralDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  //     transitionDuration: const Duration(milliseconds: 200),
  //     pageBuilder: (BuildContext context, Animation first, Animation second) {
  //       return BackdropFilter(
  //         filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  //         child: Container(
  //           height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width,
  //           color: Colors.black26,
  //           child: Stack(
  //             fit: StackFit.expand,
  //             alignment: Alignment.center,
  //             children: [
  //               Positioned(
  //                 top: 32,
  //                 left: 18,
  //                 child: GestureDetector(
  //                   child: Container(
  //                     height: 48,
  //                     width: 48,
  //                     decoration: BoxDecoration(
  //                       color: Colors.black,
  //                       borderRadius: BorderRadius.circular(16),
  //                     ),
  //                     alignment: Alignment.center,
  //                     child: const Icon(
  //                       Icons.close,
  //                       color: Colors.white,
  //                       size: 16,
  //                     ),
  //                   ),
  //                   onTap: onTap,
  //                 ),
  //               ),
  //               child,
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
