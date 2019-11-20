import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class Scraper {
  // Gets the URL as input and fetches the amazon.in product page
  Future<List<String>> productScraper(String url) async {
    // List to hold the product details that are parsed from the page
    List<String> productDetails = new List(2);
    // productDetails[0] - product title
    // productDetails[1] - product price
    // to be expanded for more details

    // Getting the actual web page content
    http.Response response = await http.get(url);

    // print(response.statusCode);

    // TODO: need a try catch here
    // If the response code is OK parse the needed details from the web page
    if (response.statusCode == 200) {
      dom.Document documentBody = parser.parse(response.body);

      String productTitle = documentBody.getElementById('productTitle').innerHtml;
      productDetails[0] = productTitle.trim();

      String productPrice = '';
      // Checking for the id of the tag that displays the product price
      if (documentBody.getElementById('priceblock_ourprice') != null) {
        productPrice =
            documentBody.getElementById('priceblock_ourprice').innerHtml;
      } else if (documentBody.getElementById('priceblock_dealprice') != null) {
        productPrice =
            documentBody.getElementById('priceblock_dealprice').innerHtml;
      } else if (documentBody.getElementById('priceblock_saleprice') != null) {
        productPrice =
            documentBody.getElementById('priceblock_saleprice').innerHtml;
      }
      // Price value in amazon.in web page starts at 7th place in the string
      productDetails[1] = productPrice.substring(7);

      // print(productDetails[0]);

      return productDetails;
    } else {
      String errorText = 'Failed to load link. Check the internet connection.';
      productDetails[0] = errorText;
      return productDetails;
    }
  }
}
