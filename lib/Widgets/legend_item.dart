import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String amount;
  final String? price;

  const LegendItem({
    super.key,
    required this.color,
    required this.amount,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
          ),
        ),
        SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              amount,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            if (price != null)
              Text(
                price!,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
          ],
        ),
      ],
    );
  }
}