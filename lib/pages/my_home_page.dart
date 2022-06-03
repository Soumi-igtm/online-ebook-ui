import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_ebook/detail_audio_page.dart';

import 'package:online_ebook/my_tabs.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
   late List popularBooks;
   late List books;
  late List trendingBooks;

  late ScrollController _scrollController;
  late TabController _tabController;
  ReadData() async {
    await DefaultAssetBundle.of(context).loadString("json/trendingBooks.json").then((s) {
      setState(() {
        trendingBooks= json.decode(s);

      });
    });
    await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s) {
     setState(() {
       popularBooks= json.decode(s);
     });
    });
    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s) {
      setState(() {
        books= json.decode(s);
      });
    });

  }
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();

  }


  @override
  Widget build(BuildContext context) {
    return
 Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu_book),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10),
                        Icon(Icons.notifications)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                      child: Text("Popular Books", style: TextStyle(fontSize: 20)))
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -1,
                      right: 0,
                    child: Container(
                      margin: const EdgeInsets.only( left: 3, top: 10),
                      height: 180,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: PageController(viewportFraction: 1),
                          itemCount: popularBooks==null?0:popularBooks!.length,
                          itemBuilder: (_, i){
                        return Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage(popularBooks![i]["img"]),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ]),
              ),
              Expanded(
                  child: NestedScrollView(
                    controller: _scrollController,
                      headerSliverBuilder: (BuildContext context, bool isScroll ){
                      return[
                        SliverAppBar(
                          pinned: true,
                          backgroundColor: Colors.white,
                          bottom: PreferredSize(
                              preferredSize: Size.fromHeight(50),
                            child: Container(
                              margin: const EdgeInsets.all(0),
                              child: TabBar(
                                indicatorPadding: const EdgeInsets.all(0),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelPadding: const EdgeInsets.only(right: 10),
                                controller: _tabController,
                                isScrollable: true,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 7,
                                      offset: Offset(0, 0)
                                    )
                                  ],
                                ),
                                tabs: [
                                 AppTabs(color: Colors.yellow, text: "New"),
                                  AppTabs(color: Colors.redAccent, text: "Popular"),
                                  AppTabs(color: Colors.blue, text: "Trendin"),
                                ],
                              ),
                            ),
                          ),
                        )
                      ];
                      },
                      body: TabBarView(
                        controller: _tabController,
                          children: [
                          ListView.builder(
                              itemCount: books==null?0:books!.length,
                              itemBuilder: (_, i){
                            return
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                 MaterialPageRoute(builder: (context)=>DetailAudioPage(booksData:books, index:i))
                                );
                              },
                                child:Container(
                                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 18),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white54,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 2,
                                            offset: Offset(0, 0),
                                            color: Colors.white.withOpacity(0.2),
                                          )
                                        ]
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 120,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image:AssetImage(books![i]["img"]),
                                                )
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.star, size: 24, color: Colors.yellow),
                                                  SizedBox(width: 5,),
                                                  Text(books![i]["rating"], style: TextStyle(
                                                    color: Colors.redAccent,
                                                  ),)
                                                ],
                                              ),
                                              Text(books![i]["title"], style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green[800]
                                              ),),
                                              Text(books![i]["text"], style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.blue[800]
                                              ),),
                                              Container(
                                                width: 60,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(3),
                                                  color: Colors.red,
                                                ),
                                                child: Text("love", style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),),
                                                alignment: Alignment.center,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            );

                          }),
                            ListView.builder(
                                itemCount: popularBooks==null?0:popularBooks!.length,
                                itemBuilder: (_, i){
                                  return Container(
                                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 18),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white54,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 2,
                                              offset: Offset(0, 0),
                                              color: Colors.white.withOpacity(0.2),
                                            )
                                          ]
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image:AssetImage(popularBooks![i]["img"]),
                                                  )
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.star, size: 24, color: Colors.yellow),
                                                    SizedBox(width: 5,),
                                                    Text(popularBooks![i]["rating"], style: TextStyle(
                                                      color: Colors.redAccent,
                                                    ),)
                                                  ],
                                                ),
                                                Text(popularBooks![i]["title"], style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green[800]
                                                ),),
                                                Text(popularBooks![i]["text"], style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.blue[800]
                                                ),),
                                                Container(
                                                  width: 60,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Colors.red,
                                                  ),
                                                  child: Text("love", style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),),
                                                  alignment: Alignment.center,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                            ListView.builder(
                                itemCount: trendingBooks==null?0:trendingBooks!.length,
                                itemBuilder: (_, i){
                                  return Container(
                                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 18),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white54,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 2,
                                              offset: Offset(0, 0),
                                              color: Colors.white.withOpacity(0.2),
                                            )
                                          ]
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image:AssetImage(trendingBooks![i]["img"]),
                                                  )
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.star, size: 24, color: Colors.yellow),
                                                    SizedBox(width: 5,),
                                                    Text(trendingBooks![i]["rating"], style: TextStyle(
                                                      color: Colors.redAccent,
                                                    ),)
                                                  ],
                                                ),
                                                Text(trendingBooks![i]["title"], style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green[800]
                                                ),),
                                                Text(trendingBooks![i]["text"], style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.blue[800]
                                                ),),
                                                Container(
                                                  width: 60,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Colors.red,
                                                  ),
                                                  child: Text("love", style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),),
                                                  alignment: Alignment.center,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ])
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
