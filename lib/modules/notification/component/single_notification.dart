import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../widgets/custom_image.dart';
import '../model/notification_model.dart';

class SingleNofitication extends StatelessWidget {
  const SingleNofitication({
    Key? key,
    required this.notification,
    this.color,
  }) : super(key: key);
  final NotificationModel notification;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImageCirculer(notification),
          const SizedBox(width: 10),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    notification.text,
                    maxLines: 2,
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xff85959E)),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  notification.time,
                  style: const TextStyle(color: inputColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImageCirculer(NotificationModel item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: CustomImage(
        height: 55,
        width: 55,
        path: item.image,
        fit: BoxFit.contain,
      ),
    );
  }
}
