import 'package:flutter/material.dart';
import 'scraper.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PriceChecker(),
    );
  }
}

class PriceChecker extends StatefulWidget {
  PriceChecker({Key key}) : super(key: key);

  @override
  _PriceCheckerState createState() => _PriceCheckerState();
}

class _PriceCheckerState extends State<PriceChecker> {
  final _controller = TextEditingController();

  void initState() {
    _controller.addListener(() {
      final text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    TextField urlTextField = TextField(
      controller: _controller,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Paste the amazon.in link:',
        labelStyle: TextStyle(
          fontSize: 21.0,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'eg. from the browser address bar',
        helperStyle: TextStyle(
          fontSize: 18.0,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Price Checker For Amazon India'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              child: urlTextField,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text(
                'Check Price',
                style: TextStyle(
                  fontSize: 21.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Current Item Price',
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
