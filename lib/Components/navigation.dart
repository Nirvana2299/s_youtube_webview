import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:s_youtube_webview/Screen/settings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});
  final WebViewController webViewController; // Controller required for navigation back and forth and from page refresh
  final Color iconColor = Colors.black; // Icon color changes here
  Color containerBackground(BuildContext context) => Theme.of(context).colorScheme.inversePrimary.withOpacity(1); // the navigation container background Color here

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Container(
          decoration: BoxDecoration(
              color: containerBackground(context),
              borderRadius: BorderRadius.circular(5.0)),
          child: Row(
            children: <Widget>[
              // Works like the browser history api in chromium browsers
              // takes back to the previous page
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: iconColor,
                ),
                onPressed: () async {
                  if (await webViewController.canGoBack()) {
                    await webViewController.goBack();
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No back history item')),
                      );
                    }
                  }
                },
              ),
              // takes back to the Forward page
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: iconColor,
                ),
                onPressed: () async {
                  if (await webViewController.canGoForward()) {
                    await webViewController.goForward();
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('No forward history item')),
                      );
                    }
                  }
                },
              ),
              // Refreshes the current page
              IconButton(
                icon: Icon(
                  Icons.replay,
                  color: iconColor,
                ),
                onPressed: webViewController.reload,
              ),
              // // Clear Cookies
              // IconButton(
              //   icon: Icon(
              //     Icons.delete_forever_rounded,
              //     color: iconColor,
              //   ),
              //   onPressed: () => _showMyDialog(context, webViewController),
              // ),
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: iconColor,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings(webViewController: webViewController,))
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


