import 'package:flutter/material.dart';

class CustomDetailWidget extends StatelessWidget {
  final String title;
  final double amount;
  const CustomDetailWidget(
      {super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        //color: Colors.red,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,

            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                      ),
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '₹$amount',
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color: Colors.black),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
