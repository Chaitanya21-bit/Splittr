import 'package:flutter/material.dart';
import 'package:splittr/core/designs/color/app_colors.dart';

class QuickSettleOutputArrowCard extends StatelessWidget {
  final String sender;
  final String receiver;
  final String amount;
  const QuickSettleOutputArrowCard({
    super.key,
    required this.sender,
    required this.receiver,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sender,
          ),
          Column(
            children: [
              Text(
                '$amount Rs',
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 120,
                    height: 2,
                    color: Colors.black,
                  ),
                  Transform.translate(
                    offset: const Offset(
                      -4,
                      0,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            receiver,
          ),
        ],
      ),
    );
  }
}
