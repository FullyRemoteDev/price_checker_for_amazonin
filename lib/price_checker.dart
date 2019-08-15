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
  TextEditingController urlTextController = TextEditingController();
  Scraper scraper = Scraper();
  List<String> productDetails = new List(5);

  void initState() {
    super.initState();
  }

  void dispose() {
    urlTextController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    TextField urlTextField = TextField(
      controller: urlTextController,
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
          fontSize: 14.0,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Price Checker For Amazon India',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
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
              onPressed: () async {
                productDetails =
                    await scraper.urlFetcher(urlTextController.text);
                setState(() {});
              },
              child: Text(
                'Check Price',
                style: TextStyle(
                  fontSize: 21.0,
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    '${productDetails[0]} - ₹ ${productDetails[1]}',
                    textAlign: TextAlign.left,
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
