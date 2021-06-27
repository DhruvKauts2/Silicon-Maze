import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

List<String> finalTitle = [];
List<String> finalDate = [];
List<String> finalIntroduction = [];
List<String> finalAuthor = [];
List<String?> finalLink = [];
List<String?> finalImage = [];
List<String> title = [];
List<String> date = [];
List<String> introduction = [];
List<String> author = [];
List<String?> link = [];
List<String?> image = [];

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: ListView.builder(
              itemCount: finalTitle.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    String url = 'https://ieee.nitk.ac.in${finalLink[index]}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      await launch(url);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 7.5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 3, color: Colors.white)),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            //the image goes here
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(boxShadow: []),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image(
                                          alignment: Alignment.center,
                                          image: NetworkImage(
                                            'https://ieee.nitk.ac.in${finalImage[index]}',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(
                                          top: 150, left: 20, right: 20),
                                      padding:
                                          EdgeInsets.only(top: 3, bottom: 3),
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text(
                                            finalTitle[index],
                                            style: GoogleFonts.exo2(
                                              textStyle:
                                                  TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          Text(
                                            finalAuthor[index] +
                                                '    |    ' +
                                                finalDate[index],
                                            style: GoogleFonts.exo2(),
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  child: Text(
                                    finalIntroduction[index],
                                    style: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
