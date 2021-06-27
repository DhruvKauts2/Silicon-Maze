import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:silicon/pages/MainPage.dart';

class EntryPoint extends StatefulWidget {
  @override
  _EntryPointState createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  void initState() {
    super.initState();
    getDataFromWeb();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image(
        image: AssetImage('assets/bloglogo.png'),
      ),
    );
  }

  void getDataFromWeb() async {
    final response = await http.get(Uri.parse('https://ieee.nitk.ac.in/blog/'));
    var document = parser.parse(response.body);
    var elements = document.getElementsByClassName('card-deck');

    title = elements
        .map((element) => element.getElementsByTagName("a")[0].innerHtml)
        .toList();
    finalTitle.addAll(title);

    author = elements
        .map((element) => element.getElementsByTagName("span")[1].innerHtml)
        .toList();

    finalAuthor.addAll(author);

    date = elements
        .map((element) => element.getElementsByTagName("span")[2].innerHtml)
        .toList();
    for (int i = 0; i < date.length; i++) {
      date[i] = date[i].replaceAll('<span>', '');
      date[i] = date[i].replaceAll('</span>', '');
    }
    finalDate.addAll(date);

    introduction = elements
        .map((element) => element.getElementsByTagName("p")[1].innerHtml)
        .toList();
    for (int i = 0; i < introduction.length; i++) {
      introduction[i] =
          introduction[i].replaceAll('                              ', '');
    }
    print(introduction[0]);
    finalIntroduction.addAll(introduction);

    link = elements
        .map((element) =>
            element.getElementsByTagName("a")[0].attributes['href'])
        .toList();

    finalLink.addAll(link);

    for (int i = 2; i <= 11; i++) {
      final response =
          await http.get(Uri.parse('https://ieee.nitk.ac.in/blog/page$i/'));
      var document = parser.parse(response.body);
      var elements = document.getElementsByClassName('card-deck');

      title = elements
          .map((element) => element.getElementsByTagName("a")[0].innerHtml)
          .toList();
      finalTitle.addAll(title);

      author = elements
          .map((element) => element.getElementsByTagName("span")[1].innerHtml)
          .toList();

      finalAuthor.addAll(author);

      date = elements
          .map((element) => element.getElementsByTagName("span")[2].innerHtml)
          .toList();
      for (int i = 0; i < date.length; i++) {
        date[i] = date[i].replaceAll('<span>', '');
        date[i] = date[i].replaceAll('</span>', '');
      }
      finalDate.addAll(date);

      introduction = elements
          .map((element) => element.getElementsByTagName("p")[1].innerHtml)
          .toList();
      finalIntroduction.addAll(introduction);

      link = elements
          .map((element) =>
              element.getElementsByTagName("a")[0].attributes['href'])
          .toList();

      finalLink.addAll(link);
    }
    print(finalLink.length);
    for (int i = 0; i < finalLink.length; i++) {
      final ImageResponse =
          await http.get(Uri.parse('https://ieee.nitk.ac.in${finalLink[i]}'));
      var ImageDocument = parser.parse(ImageResponse.body);

      var imageElement = ImageDocument.getElementsByClassName('post-content');

      try {
        image = imageElement
            .map((element) =>
                element.getElementsByTagName("img")[0].attributes['src'])
            .toList();
        print(image);
        finalImage.addAll(image);
      } catch (e) {
        finalImage.add('/blog/assets/img/ieee_nitk.png');
      }
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }
}
