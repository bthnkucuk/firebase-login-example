import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/icons.dart';
import '/core/theme/text_stiles.dart';
import '/features/home/widgets/hobby_border_widget.dart';

class HobbyWidget extends StatelessWidget {
  const HobbyWidget({
    super.key,
    required this.hobbiy,
    this.onDelete,
  });
  final VoidCallback? onDelete;
  final String hobbiy;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: Colors.white24,
              ),
              child: const HobbyBorderWidget(
                backgroundColor: Colors.white10,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hobbiy,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: s14W700,
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
                onTap: onDelete,
                child: AppIcons.trash.toWidget(color: Colors.grey, size: 20))
          ],
        ),
      ),
    );
  }
}
