import 'package:animated_fab/widgets/bottomBarActionMenuRow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const kMainColor = Color(0xFFFF3841);

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final tabs = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Market'),
    ),
    const Center(
      child: Text('Fab Icon'),
    ),
    const Center(
      child: Text('Request'),
    ),
    const Center(
      child: Text('Wallet'),
    ),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBarItem = [
    const BottomNavigationBarItem(
      icon: IconWidget(
        icon: Icons.home,
        label: 'Home',
      ),
      activeIcon: IconWidget(
        icon: Icons.home,
        iconColor: kMainColor,
        label: 'Home',
        labelColor: kMainColor,
      ),
      label: '',
      tooltip: '',
    ),
    const BottomNavigationBarItem(
      icon: IconWidget(
        icon: Icons.equalizer,
        label: 'Market',
      ),
      activeIcon: IconWidget(
        icon: Icons.equalizer,
        label: 'Market',
        iconColor: kMainColor,
        labelColor: kMainColor,
      ),
      label: '',
      tooltip: '',
    ),
    BottomNavigationBarItem(
      icon: Container(),
      label: '',
      tooltip: '',
    ),
    const BottomNavigationBarItem(
      icon: IconWidget(
        icon: Icons.request_page,
        label: 'Request',
      ),
      activeIcon: IconWidget(
        icon: Icons.request_page,
        iconColor: kMainColor,
        label: 'Request',
        labelColor: kMainColor,
      ),
      label: '',
      tooltip: '',
    ),
    const BottomNavigationBarItem(
      icon: IconWidget(
        icon: Icons.account_balance_wallet,
        label: 'Wallet',
      ),
      activeIcon: IconWidget(
        icon: Icons.account_balance_wallet,
        iconColor: kMainColor,
        label: 'Wallet',
        labelColor: kMainColor,
      ),
      label: '',
      tooltip: '',
    ),
  ];

  late AnimationController _controller;
  late Animation<double> _rotationAngle;
  late Animation<Color?> _centerIconBackgroundColor, _centerIconForegroundColor;
  late Animation<double> _bottomBarActionMenuTopPosition;

  final _duration = const Duration(milliseconds: 250);

  _onCenterIconTap() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);
    _rotationAngle = Tween<double>(begin: 1, end: 4).animate(_controller);
    _centerIconBackgroundColor =
        ColorTween(begin: const Color(0xFFFF3841), end: const Color(0xFFEAEAEA))
            .animate(_controller);
    _centerIconForegroundColor =
        ColorTween(begin: Colors.white, end: Colors.black).animate(_controller);
    _bottomBarActionMenuTopPosition =
        Tween<double>(begin: 1000, end: kToolbarHeight).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: tabs[_currentIndex],
              bottomNavigationBar: Stack(
                alignment: Alignment.center,
                children: [
                  child!,
                  Container(
                    color: Colors.white,
                    height: kToolbarHeight,
                    width: 70,
                  ),
                  InkWell(
                    onTap: _onCenterIconTap,
                    child: Transform.rotate(
                      angle: -math.pi / _rotationAngle.value,
                      child: Container(
                        width: 43,
                        height: 43,
                        child: Icon(
                          Icons.add,
                          color: _centerIconForegroundColor.value,
                          size: 24.0,
                        ),
                        decoration: BoxDecoration(
                          color: _centerIconBackgroundColor.value,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BottomBarActionMenuRow(
              topPosition: _bottomBarActionMenuTopPosition.value,
              onTap: _onCenterIconTap,
            ),
          ],
        );
      },
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed
        selectedFontSize: 0,
        unselectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        items: _bottomNavigationBarItem,
        onTap: (index) {
          if (index == 2) {
            return;
          } else {
            setState(() {
              _currentIndex = index;
            });
            if (_controller.isCompleted) {
              _controller.reverse();
            }
          }
        },
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    this.icon,
    this.iconColor,
    this.label,
    this.iconSize = 24,
    this.labelSize = 9.5,
    this.labelColor,
  }) : super(key: key);

  final IconData? icon;
  final Color? iconColor;
  final String? label;
  final double? iconSize;
  final Color? labelColor;
  final double? labelSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        Text(
          label ?? '',
          style: TextStyle(
            color: labelColor,
            fontSize: labelSize,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}