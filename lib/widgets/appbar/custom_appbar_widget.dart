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
      title: isTitleCentered
          ? Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: FavoritesSummary(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: CartSummary(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: ProfileWidget(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
