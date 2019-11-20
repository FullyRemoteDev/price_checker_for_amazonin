import 'package:flutter/material.dart';
import 'scraper.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PriceChecker(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PriceChecker extends StatefulWidget {
  PriceChecker({Key key}) : super(key: key);

  @override
  _PriceCheckerState createState() => _PriceCheckerState();
}

class _PriceCheckerState extends State<PriceChecker> {
  // Handles the input from the product URL Text Box in the Alert Dialog
  TextEditingController urlTextController = TextEditingController();

  // Scraper fetches the amazon.in product web page, parses and returns details
  Scraper scraper = Scraper();

  // List that holds the details that are returned from the scraper
  List<String> productDetails = new List(2);
  // productDetails[0] - product title
  // productDetails[1] - product price
  // to be expanded for more details

  // List that contains the product items to display in ListView
  List<String> productList = [];

  void initState() {
    super.initState();
  }

  void dispose() {
    urlTextController.dispose();
    super.dispose();
  }

  // Main Widget
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _productURL(context); // Displays the alert dialog with text field
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }

  // Alert dialog with a text field for entering product URL
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
      barrierDismissible: false, // false - must select a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Amazon.in Product Link'),
          content: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(2.0),
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
              child: Text('Add Product'),
              onPressed: () async {
                // Sends the URL to the scraper and receives product details
                productDetails =
                    await scraper.productScraper(urlTextController.text);

                setState(() {
                  // Adds the product to the list of products in the ListView
                  productList
                      .add('${productDetails[0]} - ₹ ${productDetails[1]}');
                });

                // Clears the product URL text field after the list is updated
                urlTextController.clear();

                // Closes the alert dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ListView that contains the List of added products
  _productListView() {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final item = productList[index];
        return Card(
          child: ListTile(
            title: Text(item),
            onLongPress: () {
              setState(() {
                // Removes a product on long press action
                productList.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }
}
