import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class Scraper {
  Future<List<String>> urlFetcher(String url) async {
    List<String> currentProduct = new List(5);
    http.Response response = await http.get(url);
    print(response.statusCode);

    // TODO: need a try catch here
    if (response.statusCode == 200) {
      currentProduct = productParser(response.body);
      return currentProduct;
    } else {
      String errorText = 'Failed to load link. Check the internet connection.';
      currentProduct[0] = errorText;
      return currentProduct;
    }
  }

  productParser(String responseBody) {
    dom.Document documentBody = parser.parse(responseBody);
    String priceText = '';

    // checking what is the id of the tag displaying the product price
    if (documentBody.getElementById('priceblock_ourprice') != null) {
      priceText = documentBody.getElementById('priceblock_ourprice').innerHtml;
    } else if (documentBody.getElementById('priceblock_dealprice') != null) {
      priceText = documentBody.getElementById('priceblock_dealprice').innerHtml;
    } else if (documentBody.getElementById('priceblock_saleprice') != null) {
      priceText = documentBody.getElementById('priceblock_saleprice').innerHtml;
    }

    String titleText = documentBody.getElementById('productTitle').innerHtml;

    List<String> productDetails = new List(5);

    productDetails[1] = priceText.substring(7);
    productDetails[0] = titleText.trim();

    print(productDetails[0]);

    return productDetails;
  }
}
