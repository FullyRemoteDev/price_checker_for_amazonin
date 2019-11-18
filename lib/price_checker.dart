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

  List<String> productList = [];

  void initState() {
    super.initState();
  }

  void dispose() {
    urlTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Price Checker For Amazon.in',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _productListView(),
//        Column(
//          children: <Widget>[
//            Card(
//              child: InkWell(
//                splashColor: Colors.blue.withAlpha(30),
//                onTap: () {
//                  print('Card tapped.');
//                },
//                child: Container(
//                  padding: EdgeInsets.all(12.0),
//                  child: Text(
//                    '${productDetails[0]} - ₹ ${productDetails[1]}',
//                    textAlign: TextAlign.left,
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _productURL(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }


  _productURL(BuildContext context) {

    TextField urlTextField = TextField(
      controller: urlTextController,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Paste here...',
        labelStyle: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Amazon.in Product Link'),
          content: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: urlTextField,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Add'),
              onPressed: () async {
                productDetails =
                await scraper.urlFetcher(urlTextController.text);
                setState(() {
                  productList.add('${productDetails[0]} - ₹ ${productDetails[1]}');
                });
                urlTextController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _productListView() {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final item = productList[index];
        return Card(
          child: ListTile(
            title: Text(item),

            onTap: () { //                                  <-- onTap
              setState(() {
                productList.insert(index, 'Planet');
              });
            },

            onLongPress: () { //                            <-- onLongPress
              setState(() {
                productList.removeAt(index);
              });
            },

          ),
        );
      },
    );
  }
}
