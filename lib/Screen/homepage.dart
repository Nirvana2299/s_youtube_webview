import 'package:flutter/material.dart';
import 'package:s_youtube_webview/Components/navigation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController _controller;


  double _progress = 0;
  @override
  void initState() {
    super.initState();
    // late final PlatformWebViewControllerCreationParams params;
    //  if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //     params = WebKitWebViewControllerCreationParams(
    //       allowsInlineMediaPlayback: true,
    //       mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    //     );
    //   } else {
    //     params = const PlatformWebViewControllerCreationParams();
    //   }
    // final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            setState(() {
              _progress = progress / 100;

              if (_progress == 1) {
                _progress = 0.0;
              }
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _progress = 0.0;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://flutter.dev')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.youtube.com/'));

    // #docregion platform_features
    // if (controller.platform is AndroidWebViewController) {
    //   AndroidWebViewController.enableDebugging(true);
    //   (controller.platform as AndroidWebViewController)
    //       .setMediaPlaybackRequiresUserGesture(false);
    // }
    // #enddocregion platform_features

    // _controller = controller;
    // TODO: implement initState

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          NavigationControls(
            webViewController: _controller,
          ),
        ],
        // Progress Indicator
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary),
            value: _progress,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
        ],
      ),
    );
  }
}
