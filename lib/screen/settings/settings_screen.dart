import 'package:activity_tracker/my_flat_button.dart';
import 'package:activity_tracker/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                'Settings',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: MyTheme.whiteColor,
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SetTile(
                      p: 'icons/arrow_left.svg',
                      t: 'Share with friends',
                      onT: () {
                        Share.share(
                            'Welcome to Ativity TrackerPro. Download app - https://apps.apple.com/us/app/the-activity-trackerpro/id6476199146');
                      },
                    ),
                    SetTile(
                      p: 'icons/man.svg',
                      t: 'Write support',
                      onT: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Set(
                              Linxs:
                                  'https://forms.gle/c54MU8d6QBbvtX4x7'),
                        ));
                      },
                    ),
                    SetTile(
                      p: 'icons/shield.svg',
                      t: 'Privacy Policy',
                      onT: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Set(
                              Linxs:
                                  'https://docs.google.com/document/d/1BkXetoJDyo68rYbTM0xwjGUPsWHvDIOYcYzxw-NoTG4/edit?usp=sharing'),
                        ));
                      },
                    ),
                    SetTile(
                      p: 'icons/sheet.svg',
                      t: 'Terms of use',
                      onT: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Set(
                              Linxs:
                                  'https://docs.google.com/document/d/1G8j36FL5BuAxYVvE9-Wwl_uvfuzsmiQ6mLt2sCprNy4/edit?usp=sharing'),
                        ));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 12),
        alignment: Alignment.topCenter,
        color: MyTheme.whiteColor,
        height: 80,
        child: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 16,
            color: MyTheme.blackColor,
          ),
        ),
      ),
    );
  }
}

class SetTile extends StatelessWidget {
  const SetTile(
      {super.key, required this.p, required this.t, required this.onT});
  final String p;
  final String t;
  final VoidCallback onT;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyTheme.scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: FittedBox(
              child: SvgPicture.asset(p),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              t,
              style: const TextStyle(
                color: MyTheme.blackColor,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 32,
            width: 32,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MyTheme.whiteColor,
            ),
            child: FittedBox(
              child: SvgPicture.asset(
                'icons/arrow.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Set extends StatefulWidget {
  const Set({super.key, required this.Linxs});
  final String Linxs;

  @override
  State<Set> createState() => _SetState();
}

class _SetState extends State<Set> {
  var _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            InAppWebView(
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(
                    source:
                        "javascript:(function() { var ele=document.getElementsByClassName('docs-ml-header-item docs-ml-header-drive-link');ele[0].parentNode.removeChild(ele[0]);var footer = document.getelementsbytagname('footer')[0];footer.parentnode.removechild(footer);})()");
              },
              onProgressChanged: (controller, progress) => setState(() {
                _progress = progress;
              }),
              initialUrlRequest: URLRequest(
                url: WebUri(widget.Linxs),
              ),
            ),
            if (_progress != 100)
              Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
