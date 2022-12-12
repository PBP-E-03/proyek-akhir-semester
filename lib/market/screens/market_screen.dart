import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/market/models/product.dart';
import 'package:pbp_e_03_flutter/shared/service/http_service.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int page = 1;
  int fetchPage = 1;
  late List<Product> listProduct;
  Map<String, int> buyCount = {
    "count1": 1,
    "count2": 1,
    "count3": 1,
    "count4": 1,
    "count5": 1,
    "count6": 1,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: fetchData(fetchPage),
            builder: (context, snapshot) {
              //success, content, message
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Text("tidak ada data");
                } else {
                  listProduct =
                      getProduct(snapshot.data!["content"]["products"]);
                  int halfPageNumber = 6 * ((page - 1) % 2);
                  return Center(
                      child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "Trade Your Reward",
                        style:
                            TextStyle(fontSize: 24, color: Color(0xFF56C969)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(
                        "Because You Deserve a Tremendous Rewards",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        padding: const EdgeInsets.all(7),
                        crossAxisCount: 2,
                        children: [
                          for (int i = halfPageNumber;
                              i < 6 + halfPageNumber;
                              i++)
                            (Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 15,
                                          left: 15,
                                          top: 15,
                                          right: 15),
                                      child: Image(
                                        image: NetworkImage(
                                            listProduct.elementAt(i).image),
                                        height: 125,
                                        width: 175,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: Text(
                                      listProduct.elementAt(i).name,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          listProduct
                                              .elementAt(i)
                                              .stock
                                              .toString(),
                                          style: const TextStyle(
                                              color: Color(0xFF56C969)),
                                        ),
                                        const Text("  Remaining")
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          child: const Text(
                                            "-",
                                            style: TextStyle(
                                                color: Color(0xFF56C969)),
                                          ),
                                          onPressed: () {
                                            if (buyCount["count" +
                                                    (i + 1 - halfPageNumber)
                                                        .toString()]! >
                                                0) {
                                              buyCount.update(
                                                  "count" +
                                                      (i + 1 - halfPageNumber)
                                                          .toString(),
                                                  (value) => value -= 1);
                                              setState(() {});
                                            }
                                          },
                                        ),
                                        Text(buyCount["count" +
                                                (i + 1 - halfPageNumber)
                                                    .toString()]
                                            .toString()),
                                        TextButton(
                                          child: const Text(
                                            "+",
                                            style: TextStyle(
                                                color: Color(0xFF56C969)),
                                          ),
                                          onPressed: () {
                                            if (buyCount["count" +
                                                    (i + 1 - halfPageNumber)
                                                        .toString()]! <
                                                listProduct
                                                    .elementAt(i)
                                                    .stock) {
                                              buyCount.update(
                                                  "count" +
                                                      (i + 1 - halfPageNumber)
                                                          .toString(),
                                                  (value) => value += 1);
                                              setState(() {});
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Image.asset(
                                                  "assets/images/Vector.png"),
                                            ),
                                            Text(listProduct
                                                .elementAt(i)
                                                .price
                                                .toString()),
                                          ],
                                        ),
                                        TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color(0xFF56C969))),
                                          onPressed: () {
                                            Map<String, int> body = {
                                              "product_id":
                                                  listProduct.elementAt(i).id,
                                              "product_amount": buyCount[
                                                  "count" +
                                                      (i + 1 - halfPageNumber)
                                                          .toString()]!
                                            };
                                            dynamic response = HttpService.post(
                                                "market/transaction", body);
                                            setState(() {});
                                          },
                                          child: const Text(
                                            "Buy",
                                            style: TextStyle(
                                                color: Color(0xFFFFFFFF)),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                            onPressed: (!(page == 1))
                                ? () {
                                    page -= 1;
                                    fetchPage = (page / 2).ceil();
                                    buyCount = {
                                      "count1": 1,
                                      "count2": 1,
                                      "count3": 1,
                                      "count4": 1,
                                      "count5": 1,
                                      "count6": 1,
                                    };
                                    const MarketScreen();
                                    setState(() {});
                                  }
                                : null,
                            child: Text("Prev",
                                style: (!(page == 1))
                                    ? const TextStyle(color: Color(0xFF56C969))
                                    : const TextStyle(
                                        color: Color(0xFFFFFFFF)))),
                        const Text("Page "),
                        Text(page.toString(),
                            style: const TextStyle(color: Color(0xFF56C969))),
                        Text(" of " +
                            ((snapshot.data!["content"]["totalPages"] - 1) * 2)
                                .toString()),
                        TextButton(
                            onPressed: (page !=
                                    (snapshot.data!["content"]["totalPages"] -
                                            1) *
                                        2)
                                ? () {
                                    page += 1;
                                    fetchPage = (page / 2).ceil();
                                    buyCount = {
                                      "count1": 1,
                                      "count2": 1,
                                      "count3": 1,
                                      "count4": 1,
                                      "count5": 1,
                                      "count6": 1,
                                    };
                                    const MarketScreen();
                                    setState(() {});
                                  }
                                : null,
                            child: Text("Next",
                                style: (page !=
                                        (snapshot.data!["content"]
                                                    ["totalPages"] -
                                                1) *
                                            2)
                                    ? const TextStyle(color: Color(0xFF56C969))
                                    : const TextStyle(
                                        color: Color(0xFFFFFFFF))))
                      ],
                    ),
                  ]));
                }
              }
            }));
  }
}
