import 'package:flutter/material.dart';

class WatchlistDetails extends StatefulWidget {
  final int pk;

  const WatchlistDetails({super.key, required this.pk});

  @override
  State<StatefulWidget> createState() => _WatchlistDetailsState();
}

class _WatchlistDetailsState extends State<WatchlistDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Color.fromARGB(31, 244, 239, 239),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Color.fromARGB(255, 255, 255, 255))
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Status: watched',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'rating: ${[widget.pk]}',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'Review',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 45, right: 45, bottom: 35),
        child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: const Text("Back"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}


// import 'dart:io';

// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:counter_7/budget.dart';
// import 'package:counter_7/form.dart';
// import 'package:counter_7/model/mywatchlist.dart';
// import 'package:counter_7/mywatchlist_details.dart';

// List<Watchlists> watchlistdata = [];

// class Watchlist extends StatefulWidget {
//   const Watchlist({super.key});

//   @override
//   State<Watchlist> createState() => _WatchlistState();
// }

// class _WatchlistState extends State<Watchlist> {

//   @override
//   Widget build(BuildContext context) {
    

//     Future<List<Watchlists>> fetchWatchlist() async {
//         var url = Uri.parse('https://pantun-katalog.herokuapp.com/mywatchlist/json/');
//         var response = await http.get(
//           url,
//           headers: {
//               "Access-Control-Allow-Origin": "*",
//               "Content-Type": "application/json",
//           },
//         );

//         // melakukan decode response menjadi bentuk json
//         var data = jsonDecode(utf8.decode(response.bodyBytes));

//         // melakukan konversi data json menjadi object ToDo
//         List<Watchlists> listwatch = [];
//         for (var d in data) {
//           if (d != null) {
//               Watchlists listofmovie = Watchlists.fromJson(d);
//               listwatch.add(Watchlists.fromJson(d));
//               watchlistdata.add(listofmovie);

//           }
//         }

//         return listwatch;
//     }
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Watchlist'),
//       ),
//       body: FutureBuilder(
//         future: fetchWatchlist(),
//         builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.data == null) {
//             return const Center(child: CircularProgressIndicator());
//             } else {
//             if (!snapshot.hasData) {
//                 return Column(
//                 children: const [
//                     Text(
//                     "Tidak ada Watchlist",
//                     style: TextStyle(
//                         color: Color(0xff59A5D8),
//                         fontSize: 20),
//                     ),
//                     SizedBox(height: 8),
//                 ],
//                 );
//             } else {
//                 return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (_, index)=> InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context, MaterialPageRoute(builder: (context) => WatchlistDetails(pk: snapshot.data[index].pk - 1,))
//                         );
//                       },
                      
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         padding: const EdgeInsets.all(20.0),
//                         decoration: BoxDecoration(

//                           color:Colors.white,
//                           borderRadius: BorderRadius.circular(10.0),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Color.fromARGB(255, 120, 110, 110),
//                                 blurRadius: 3.0,
//                                 spreadRadius: -2,
//                                 offset: Offset(0, 2.5),
//                             )
//                           ]
//                         ),
//                         child: Row(

//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                                 "${snapshot.data![index].fields.title}",
//                                 style: const TextStyle(
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                                 ),
                                
//                             ),
//                         ],
//                         ),
//                       ),

                      
                        

//                         // children: [
//                         //   
                          
                          
//                         // ],
                        
                        
                      
//                   ),
//                 );
//               }
//             }
//           }
//         )

     
  
//     );
    
//   }
// }