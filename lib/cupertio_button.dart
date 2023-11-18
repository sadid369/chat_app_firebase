import 'package:flutter/cupertino.dart';

/// Flutter code sample for [CupertinoActionSheet].

void main() => runApp(const ActionSheetApp());

class ActionSheetApp extends StatelessWidget {
  const ActionSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: ActionSheetExample(),
    );
  }
}

class ActionSheetExample extends StatelessWidget {
  const ActionSheetExample({super.key});

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: CupertinoActionSheet(
          cancelButton: Container(
            alignment: Alignment.center,
            width: 10,
            height: 50,
            child: Text(
              'Cancel',
              style:
                  TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          title: const Text('Title'),
          message: const Text('Message'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              /// This parameter indicates the action would be a default
              /// default behavior, turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Default Action'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Action'),
            ),
            CupertinoActionSheetAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as delete or exit and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Destructive Action'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoActionSheet Sample'),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () => _showActionSheet(context),
          child: const Text('CupertinoActionSheet'),
        ),
      ),
    );
  }
}