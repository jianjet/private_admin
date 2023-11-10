import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);
  @override
  ErrorPageState createState() => ErrorPageState();
}

class ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Page'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: const Text("An error has occured. Please kindly inform the admins.\nThank you very much.", style: TextStyle(fontSize: 15)),
      )
    );
  }
}