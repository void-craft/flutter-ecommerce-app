import 'package:buy_it_app/widgets/appbar/cart_summary_widget.dart';
import 'package:buy_it_app/widgets/appbar/favorite_summary_widget.dart';
import 'package:buy_it_app/widgets/appbar/profile_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isTitleCentered;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isTitleCentered = false,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isTitleCentered,
      backgroundColor: Colors.green,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
        textAlign: isTitleCentered ? TextAlign.center : TextAlign.start,
      ),
      actions: const [
        FavoritesSummary(),
        CartSummary(),
        ProfileWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
