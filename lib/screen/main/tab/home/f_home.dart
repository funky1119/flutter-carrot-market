import 'package:flutter_carrot_market/common/common.dart';
import 'package:flutter_carrot_market/common/widget/round_button_theme.dart';
import 'package:flutter_carrot_market/common/widget/w_round_button.dart';
import 'package:flutter_carrot_market/screen/dialog/d_message.dart';
import 'package:flutter/material.dart';

import '../../../dialog/d_color_bottom.dart';
import '../../../dialog/d_confirm.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => openDrawer(context),
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
          const EmptyExpanded(),
          RoundButton(
            text: 'Snackbar 보이기',
            onTap: () => showSnackbar(context),
            theme: RoundButtonTheme.blue,
          ),
          const Height(20),
          RoundButton(
            text: 'Confirm 다이얼로그',
            onTap: () => showConfirmDialog(context),
            theme: RoundButtonTheme.whiteWithBlueBorder,
          ),
          const Height(20),
          RoundButton(
            text: 'Message 다이얼로그',
            onTap: showMessageDialog,
            theme: RoundButtonTheme.whiteWithBlueBorder,
          ),
          const Height(20),
          RoundButton(
            text: '메뉴 보기',
            onTap: () => openDrawer(context),
            theme: RoundButtonTheme.blink,
          ),
          const EmptyExpanded(),
        ],
      ),
    );
  }

  void showSnackbar(BuildContext context) {
    context.showSnackbar(
      'snackbar 입니다.',
      extraButton: GestureDetector(
        onTap: () {
          context.showErrorSnackbar('error');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          alignment: Alignment.center,
          child: const Text(
            '에러 보여주기 버튼',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      ),
    );
  }

  Future<void> showConfirmDialog(BuildContext context) async {
    final confirmDialogResult =
        await ConfirmDialog(
          '오늘 기분이 좋나요?',
          buttonText: "네",
          cancelButtonText: "아니오",
        ).show();
    debugPrint(confirmDialogResult?.isSuccess.toString());

    confirmDialogResult?.runIfSuccess((data) {
      ColorBottomSheet(
        '❤️',
        context: context,
        backgroundColor: Colors.yellow.shade200,
      ).show();
    });

    confirmDialogResult?.runIfFailure((data) {
      ColorBottomSheet(
        '❤️힘내여',
        backgroundColor: Colors.yellow.shade300,
        textColor: Colors.redAccent,
      ).show();
    });
  }

  Future<void> showMessageDialog() async {
    final result = await MessageDialog("안녕하세요").show();
    debugPrint(result.toString());
  }

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
