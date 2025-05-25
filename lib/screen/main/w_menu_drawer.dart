import 'package:flutter_carrot_market/screen/opensource/s_opensource.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../screen/dialog/d_message.dart';
import '../../common/common.dart';
import '../../common/language/language.dart';
import '../../common/theme/theme_util.dart';
import '../../common/widget/w_mode_switch.dart';

class MenuDrawer extends StatefulWidget {
  static const minHeightForScrollView = 380;
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => closeDrawer(context),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 240,
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: isSmallScreen(context)
                  ? SingleChildScrollView(child: getMenus(context))
                  : getMenus(context),
            ),
          ),
        ),
      ),
    );
  }

  bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.height < MenuDrawer.minHeightForScrollView;

  Widget getMenus(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => closeDrawer(context),
              padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          _MenuWidget(
            'opensource',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OpensourceScreen()),
            ),
          ),
          const Divider(),
          _MenuWidget(
            'clear_cache',
            onTap: () async {
              await DefaultCacheManager().emptyCache();
              if (mounted) {
                MessageDialog('Cache cleared').show();
              }
            },
          ),
          const Divider(),
          if (isSmallScreen(context)) const SizedBox(height: 10),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ModeSwitch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (_) => ThemeUtil.toggleTheme(context),
                height: 30,
                activeThumbImage: Image.asset('$basePath/darkmode/moon.png'),
                inactiveThumbImage: Image.asset('$basePath/darkmode/sun.png'),
                activeThumbColor: Colors.transparent,
                inactiveThumbColor: Colors.transparent,
              ),
            ),
          ),
          const SizedBox(height: 10),
          getLanguageOption(context),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      '© 2023. Bansook Nam. all rights reserved.',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void closeDrawer(BuildContext context) {
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
    }
  }

  Widget getLanguageOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(left: 15, right: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: const [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 2,
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              DropdownButton<String>(
                items: Language.values
                    .map(
                      (lang) => DropdownMenuItem(
                        value: describeEnum(lang),
                        child: Row(
                          children: [
                            flag(lang.flagPath),
                            const SizedBox(width: 8),
                            Text(
                              describeEnum(lang),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) async {
                  if (value == null) return;
                  await context.setLocale(
                    Language.find(value.toLowerCase()).locale,
                  );
                },
                value: describeEnum(currentLanguage),
                underline: const SizedBox.shrink(),
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget flag(String path) {
    return SimpleShadow(
      opacity: 0.5,
      color: Colors.grey,
      offset: const Offset(2, 2),
      sigma: 2,
      child: Image.asset(path, width: 20),
    );
  }
}

class _MenuWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _MenuWidget(this.text, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
