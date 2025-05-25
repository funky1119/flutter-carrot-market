import 'package:flutter_carrot_market/common/common.dart';
import 'package:flutter_carrot_market/screen/opensource/vo_package.dart';
import 'package:flutter/material.dart';

class OpensourceItem extends StatelessWidget {
  final Package package;

  const OpensourceItem(this.package, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 30),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 8),
            child: Text(
              package.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
            child: Text(
              package.description,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          if (package.authors.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 12),
              child: Text(
                package.authors.join(", "),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          if ((package.homepage ?? '').trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Text(package.homepage ?? ''),
            ),
          Container(
            decoration: BoxDecoration(
              color: context.appColors.drawerBg,
              border: Border.all(color: context.appColors.divider),
              borderRadius: BorderRadius.circular(4),
            ),
            margin: const EdgeInsets.only(left: 20, top: 15, right: 20),
            height: 230,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(children: [Text(package.license ?? '')]),
            ),
          ),
        ],
      ),
    );
  }
}
