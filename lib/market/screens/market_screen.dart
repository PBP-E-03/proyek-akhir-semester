import 'dart:collection';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/market/models/product.dart';
import 'package:pbp_e_03_flutter/shared/service/http_service.dart';

class MarketScreen extends StatefulWidget{
  const MarketScreen({super.key});

  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int page = 1;
  int fetchPage = 1;
  late List<Product> listProduct;
  Map<String, int> buyCount = {"count1" : 1, "count2" : 1, "count3" : 1, "count4" : 1, "count5" : 1, "count6" : 1,};

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchData(fetchPage),
        builder: (context, snapshot){ //success, content, message
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData){
              return Text("tidak ada data");
            } else {
              listProduct = getProduct(snapshot.data!["content"]["products"]);
              int halfPageNumber = 6*((page-1)%2);
              return Center(
                  child: Column(
                      children: [
                        Padding(
                          child: Text(
                            "Trade Your Reward",
                            style: TextStyle(fontSize: 24, color: const Color(0xFF56C969)),
                          ),
                          padding: EdgeInsets.only(top: 15),
                        ),
                        Padding(
                          child: Text(
                            "Because You Deserve a Tremendous Rewards",
                            style: TextStyle(fontSize: 16),
                          ),
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                        ),
                        Expanded(
                          child: GridView.count(
                            padding: EdgeInsets.all(7),
                            crossAxisCount: 2,
                            children: [
                              for (int i=halfPageNumber;i<6+halfPageNumber;i++)
                                (Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Padding(
                                          child: Image(
                                            image: NetworkImage(listProduct.elementAt(i).image),
                                            height: 125,
                                            width: 175,
                                          ),
                                          padding: EdgeInsets.only(bottom: 15, left: 15, top: 15, right: 15),
                                        ),
                                      ),
                                      Padding(
                                        child: Text(
                                          listProduct.elementAt(i).name,
                                        ),
                                        padding: EdgeInsets.only(left: 10, bottom: 5),
                                      ),
                                      Padding(
                                        child: Row(
                                          children: [
                                            Text(
                                              listProduct.elementAt(i).stock.toString(),
                                              style: TextStyle(color: const Color(0xFF56C969)),
                                            ),
                                            Text("  Remaining")
                                          ],
                                        ),
                                        padding: EdgeInsets.only(left: 10, bottom: 5),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              child: Text("-", style: TextStyle(color: const Color(0xFF56C969)),),
                                              onPressed: (){
                                                if (buyCount["count"+(i+1-halfPageNumber).toString()]!>0){
                                                  buyCount.update("count"+(i+1-halfPageNumber).toString(), (value) => value-=1);
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                            Text(buyCount["count"+(i+1-halfPageNumber).toString()].toString()),
                                            TextButton(
                                              child: Text("+", style: TextStyle(color: const Color(0xFF56C969)),),
                                              onPressed: (){
                                                if (buyCount["count"+(i+1-halfPageNumber).toString()]!<listProduct.elementAt(i).stock){
                                                  buyCount.update("count"+(i+1-halfPageNumber).toString(), (value) => value+=1);
                                                  setState(() {});
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(child: Image.asset("assets/images/Vector.png"),padding: EdgeInsets.only(right: 15),),
                                                Text(listProduct.elementAt(i).price.toString()),
                                              ],
                                            ),
                                            TextButton(
                                              child: Text("Buy", style: TextStyle(color: Color(0xFFFFFFFF)),),
                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF56C969))),
                                              onPressed: () {
                                                Map<String, int> body = {
                                                  "product_id" : listProduct.elementAt(i).id,
                                                  "product_amount" : buyCount["count"+(i+1-halfPageNumber).toString()]!
                                                };
                                                dynamic response = HttpService.post("market/transaction", body);
                                                setState(() {
                                                });
                                              },
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
                              child: Text(
                                  "Prev",
                                  style: (!(page==1)) ? TextStyle(color: const Color(0xFF56C969)) : TextStyle(color: const Color(0xFFFFFFFF))
                              ),
                              onPressed: (!(page==1)) ? (){
                                page-=1;
                                fetchPage = (page/2).ceil();
                                buyCount = {"count1" : 1, "count2" : 1, "count3" : 1, "count4" : 1, "count5" : 1, "count6" : 1,};
                                MarketScreen();
                                setState(() {
                                });
                              }
                              : null
                            ),
                            Text("Page "),
                            Text(page.toString(), style: TextStyle(color: const Color(0xFF56C969))),
                            Text(" of " + ((snapshot.data!["content"]["totalPages"]-1)*2).toString()),
                            TextButton(
                              child: Text(
                                  "Next",
                                  style: (page!=(snapshot.data!["content"]["totalPages"]-1)*2) ? TextStyle(color: const Color(0xFF56C969)) : TextStyle(color: const Color(0xFFFFFFFF))
                              ),
                              onPressed: (page!=(snapshot.data!["content"]["totalPages"]-1)*2) ? (){
                                page+=1;
                                fetchPage = (page/2).ceil();
                                buyCount = {"count1" : 1, "count2" : 1, "count3" : 1, "count4" : 1, "count5" : 1, "count6" : 1,};
                                MarketScreen();
                                setState(() {
                                });
                              }
                              : null
                            )
                          ],
                        ),
                      ]
                  )
              );
            }
          }
        }
      )
    );
  }
}
