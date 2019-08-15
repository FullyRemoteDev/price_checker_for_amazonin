import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class Scraper {
  Future<List<String>> urlFetcher(String url) async {
    List<String> currentProduct = new List(5);
    http.Response response = await http.get(url);
    print(response.statusCode);

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
    String priceText =
        documentBody.getElementById('priceblock_dealprice').innerHtml;
    String titleText = documentBody.getElementById('productTitle').innerHtml;

    List<String> productDetails = new List(5);

    productDetails[1] = priceText.substring(7);
    productDetails[0] = titleText.trim();

    print(productDetails[0]);

    return productDetails;
  }
}

// https://www.amazon.in/Test-Exclusive-611/dp/B07HGMLBW1/
// <span id="priceblock_ourprice" class="a-size-medium a-color-price priceBlockBuyingPriceString">₹&nbsp;32,999.00</span>
// <span id="productTitle" class="a-size-large">
//
//
//
//
//
//
//
//
//                        OnePlus 7 (Mirror Blue, 6GB RAM, 128GB Storage)
//
//
//
//
//
//
//
//            </span>
//<title>OnePlus 7 (Mirror Blue, 6GB RAM, 128GB Storage): Amazon.in: Electronics</title>

//<link rel="canonical" href="https://www.amazon.in/Test-Exclusive-611/dp/B07HGMLBW1" />
//<meta name="description" content="OnePlus 7 (Mirror Blue, 6GB RAM, 128GB Storage): Amazon.in: Electronics" />
//<meta name="title" content="OnePlus 7 (Mirror Blue, 6GB RAM, 128GB Storage): Amazon.in: Electronics" />
