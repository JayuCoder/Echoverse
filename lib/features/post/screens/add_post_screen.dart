import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({super.key});

  void navigateToType(BuildContext context, String type) {
    Routemaster.of(context).push('/add-post/$type');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double cardHeightWidth = kIsWeb ? 130 : 120;
    double iconSize = kIsWeb ? 60 : 60;
    // final currentTheme = ref.watch(themeNotifierProvider);
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 85),
            GestureDetector(
              onTap: () => navigateToType(context, 'image'),
              child: SizedBox(
                height: cardHeightWidth,
                width: cardHeightWidth,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // color: currentTheme.scaffoldBackgroundColor,
                  elevation: 16,
                  child: Center(
                    child: Icon(Icons.image_outlined, size: iconSize),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => navigateToType(context, 'text'),
              child: SizedBox(
                height: cardHeightWidth,
                width: cardHeightWidth,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // color: currentTheme.scaffoldBackgroundColor,
                  elevation: 16,
                  child: Center(
                    child: Icon(Icons.font_download_outlined, size: iconSize),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => navigateToType(context, 'link'),
              child: SizedBox(
                height: cardHeightWidth,
                width: cardHeightWidth,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // color: currentTheme.scaffoldBackgroundColor,
                  elevation: 16,
                  child: Center(
                    child: Icon(Icons.link_outlined, size: iconSize),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
