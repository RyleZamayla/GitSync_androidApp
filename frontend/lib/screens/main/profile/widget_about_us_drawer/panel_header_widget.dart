import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanelHeaderWidget extends StatelessWidget {
  final user;

  const PanelHeaderWidget({
    required this.user,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(user.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          const SizedBox(height: 10),
          Text(user.bio,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          const SizedBox(height: 10),
          Text(user.location,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ],
      );
}
