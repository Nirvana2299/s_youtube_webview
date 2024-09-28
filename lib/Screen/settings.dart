import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Settings extends StatelessWidget {
  const Settings({super.key, required this.webViewController});
  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  title: const Text('Reset Cache'),
                  subtitle: const Text('delete all the data'),
                  onTap: () => _showMyDialog(context ,webViewController ),
                  trailing: Icon(Icons.delete_forever_rounded, color: Colors.deepOrange[900]),
                ),
              ],
            ),
            const Text('Made with 💗 by Shoaib')
          ],
        ),
      ),
    );
  }
}

_showMyDialog(BuildContext context, WebViewController webViewController) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Data'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Clear Cache?'),
              Text('All data will be deleted and you will be logged out!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop();
              webViewController.clearLocalStorage();
            },
          ),
        ],
      );
    },
  );
}
