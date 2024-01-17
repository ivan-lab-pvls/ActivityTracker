import 'package:activity_tracker/my_flat_button.dart';
import 'package:activity_tracker/my_theme.dart';
import 'package:activity_tracker/screen/active/active.dart';
import 'package:activity_tracker/screen/main/main_screen.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  String? active;
  @override
  void initState() {
    super.initState();
    _i();
  }

  void _i() async {
    final b = await SharedPreferences.getInstance();
    _pss(b);
    final a = FirebaseRemoteConfig.instance.getString('active');

    if (!a.contains('isActive')) {
      setState(() {
        active = a;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (active != null) {
      return ActiveScreen(a: active!);
    }

    return Boarding();
  }
}

class Boarding extends StatelessWidget {
  const Boarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: MyTheme.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Items(),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Welcome! ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: MyTheme.blackColor,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    'Track your activity in our convenient app!',
                                style: TextStyle(color: MyTheme.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              MyFlatButton(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MainSceen(),
                    ),
                  );
                },
                text: 'Get started',
              ),
              const SizedBox(height: 48),
              const Text(
                'Terms of use  |  Privacy Policy',
                style: TextStyle(color: MyTheme.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ItemType {
  redMan(iconPath: 'icons/activities/walk.svg', color: MyTheme.red),
  orangeBarbell(iconPath: 'icons/activities/barbell.svg', color: MyTheme.orange),
  blueBag(iconPath: 'icons/activities/bag.svg', color: MyTheme.blue),
  yellowBall(iconPath: 'icons/activities/ball.svg', color: MyTheme.yellow),
  greyMoonSolid(iconPath: 'icons/activities/moon_solid.svg', color: MyTheme.grey),
  greenApple(iconPath: 'icons/activities/apple.svg', color: MyTheme.lightGreen);

  const ItemType({required this.iconPath, required this.color});
  final String iconPath;
  final Color color;
}

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late double _itemSide;

  @override
  void didChangeDependencies() {
    _itemSide = (MediaQuery.of(context).size.width - 32 - 32 - 8) / 3;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween(begin: -(_itemSide / 2), end: _itemSide / 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );

    _controller
      ..forward()
      ..addListener(() {
        if (_controller.isCompleted) {
          _controller.reverse();
          return;
        }
        if (_controller.isDismissed) {
          _controller.forward();
          return;
        }
      });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (child == null) {
          return const SizedBox();
        }
        return SizedBox(
          height: _itemSide * 2 + 4,
          child: Stack(
            children: [
              Positioned(
                left: _animation.value,
                child: child,
              ),
            ],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: _itemSide * 3 + 8,
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: ItemType.values
                .map(
                  (e) => Container(
                    width: _itemSide,
                    height: _itemSide,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: MyTheme.lightGreyColor,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      e.iconPath,
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(e.color, BlendMode.srcIn),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

Future<void> _pss(SharedPreferences bd) async {
  final rev = InAppReview.instance;
  bool alreadyRated = bd.getBool('isRated') ?? false;
  if (!alreadyRated) {
    if (await rev.isAvailable()) {
      rev.requestReview();
      await bd.setBool('isRated', true);
    }
  }
}
