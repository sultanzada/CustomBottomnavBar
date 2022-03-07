import 'package:flutter/material.dart';

class BottomBarActionMenuRow extends StatelessWidget {
  const BottomBarActionMenuRow({
    Key? key,
    required this.topPosition,
    required this.onTap,
  }) : super(key: key);

  final double topPosition;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: (MediaQuery.of(context).size.height - kToolbarHeight),
      // bottom: 80,
      left: 0,
      right: 0,
      bottom: topPosition,
      child: GestureDetector(
        onTap: onTap,
        child: Scaffold(
          backgroundColor: Colors.black26,
          body: Center(
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
