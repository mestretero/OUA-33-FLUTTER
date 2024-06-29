import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  final String title, subTitle;

  const TopTitle({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subTitle,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
