
import 'dart:io';

import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static dynamic result = {'isValid':false};
  static String Orientation = "";


  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var scrollController = ScrollController();
  String faceMatchURL = '';
  double fontsize = 16;

  @override
  void initState() {
    setState((){
      faceMatchURL = ResultScreen.result['face'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Accura Result"),
        backgroundColor: Colors.red[800],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: Column(children: [
                          getImageOnDocument(),
                          getDataWidgets(),
                          getMRZDataWidgets(),
                          getImagesWidgets(),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Code for display face images.
  Widget getImageOnDocument() {
    return Column(
      children: [
        SizedBox(height: 20,),
    ResultScreen.result['face'] != null
      ?  Container(
      height: 150,
      width: 100,
      child: Image.file(
           File(ResultScreen.result['face']
              .toString()
              .replaceAll('file:///', '')),
          fit: BoxFit.cover
      ),
    ) : Container(),
        SizedBox(height: 20,)
      ],
    );
  }

  //Code for display document image for front & back.
  Widget getImagesWidgets() {
    return Column(
        children: ["front_img", "back_img"]
            .map(
              (e) => (ResultScreen.result[e] != null && ResultScreen.result[e].length != 0
              ? Column(
            children: [
              Container(
                color: Colors.grey.withOpacity(0.5),
                width: MediaQuery.of(context).size.width,
                padding:
                EdgeInsets.only(top: 15, bottom: 15, left: 10),
                child: Text(
                  e == 'front_img' ? 'FRONT SIDE' : 'BACK SIDE',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Image.file(
                File(ResultScreen.result[e]
                    .toString()
                    .replaceAll('file:///', '')),
              ),
            ],
          )
              : Container()),
        ).toList());
  }

  //Code for display MRZ, OCR, Barcode, BankCard data
  Widget getDataWidgets() {
    return Column(
        children: ["front_data", "back_data"]
            .map(
              (e) => (ResultScreen.result[e] != null && ResultScreen.result[e].length != 0
              ? Column(
            children: [
              Container(
                color: Colors.grey.withOpacity(0.5),
                width: MediaQuery.of(context).size.width,
                padding:
                EdgeInsets.only(top: 15, bottom: 15, left: 10),
                child: Text(
                  e == 'front_data'
                      ? getResultType(ResultScreen.result['type'])
                      : 'OCR Back',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              getSubDataWidgets(e)
            ],
          )
              : Container()),
        )
            .toList());
  }

  Widget getSubDataWidgets(key) {
    List<Widget> list = [];

    if (ResultScreen.result[key] != null) {
      ResultScreen.result[key].forEach((k, v) => {
        if (!k.toString().contains('_img'))
          {
            list.add(Table(
              border: TableBorder.symmetric(
                  inside: const BorderSide(color: Colors.red, width: 1),
                  outside: const BorderSide(color: Colors.red, width: 0.5)),
              children: [
                TableRow(children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(k.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontsize)),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: k != "signature"
                            ? Text(v.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontsize))
                            : Image.file(
                          File(v
                              .toString()
                              .replaceAll('file:///', '')),
                        ),
                      ),
                    ),
                  )
                ]),
              ],
            ))
          }
      });
    }
    return Column(children: list);
  }

  Widget getMRZDataWidgets() {
    List<Widget> list = [];

    if (ResultScreen.result['mrz_data'] != null) {
      ResultScreen.result['mrz_data'].forEach((k, v) => {
        if (!k.toString().contains('_img'))
          {
            list.add(Table(
              border: TableBorder.all(color: Color(0xFFD32D39)),
              children: [
                TableRow(children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(k.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontsize)),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: k != "signature"
                            ? Text(v.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontsize))
                            : Image.file(
                          File(v
                              .toString()
                              .replaceAll('file:///', '')),
                        ),
                      ),
                    ),
                  )
                ]),
              ],
            ))
          }
      });
    }
    return Column(children: list);
  }

  String getResultType(type) {
    switch (type) {
      case "BANKCARD":
        return "Bank Card Data";
      case "DL_PLATE":
        return "Vehicle Plate";
      case "OCR":
        return "OCR Front";
      case "MRZ":
        return "MRZ";
      default:
        return "Front Side";
    }
  }
}