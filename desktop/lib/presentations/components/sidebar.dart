import 'package:desktop/utils/colors.dart';
import 'package:desktop/utils/icon_set_icons.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class Sidebar extends StatelessWidget {
  final SidebarXController controller;

  Sidebar({
    required this.controller,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: CustomColors.canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: CustomColors.scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: CustomColors.canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: CustomColors.actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [CustomColors.accentCanvasColor, CustomColors.canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 250,
        decoration: BoxDecoration(
          color: CustomColors.canvasColor,
        ),
      ),
      footerDivider: divider,
      items: const [
        SidebarXItem(
          icon: Icons.dashboard,
          label: 'Dashboard',
        ),
        SidebarXItem(
          icon: Icons.share,
          label: 'Nodes',
        ),
        SidebarXItem(
          icon: IconSet.npm,
          label: 'Npm',
        ),
      ],
    );
  }
}

final divider = Divider(color: Colors.white.withOpacity(0.3), height: 1);
