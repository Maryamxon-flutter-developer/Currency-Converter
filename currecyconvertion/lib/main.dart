import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListScreen(),
  ));
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Map<String, dynamic>> data = [];
  dynamic nom = "";

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        "https://cbu.uz/uz/arkhiv-kursov-valyut/json/"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      for (var item in jsonData) {
        data.add(Map<String, dynamic>.from(item));
      }
      setState(() {});
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Currency Conversion",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 213, 146, 239),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    content: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 248, 247, 249),
                      ),
                    
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 194, 247),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                               Text("${data[index]["Date"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ],
                            ),
                          ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(  
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,                 
                              children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Row(                           
                                          children: [
                                         Text("${data[index]["Ccy"]}",style: TextStyle(color: Color.fromARGB(255, 79, 5, 82),fontWeight: FontWeight.bold,fontSize: 16),),
                                         Text("${data[index]["Nominal"]}",style: TextStyle(color: Color.fromARGB(255, 79, 5, 82),fontWeight: FontWeight.bold,fontSize: 16),)
                                          ],
                                      ),
                                  ),
                                    Column(
                                    children: [
                                           Row(
                                           children: [
                                             Text("${data[index]["Code"]}",style: TextStyle(color: Color.fromARGB(255, 94, 5, 73),fontWeight: FontWeight.bold,fontSize: 16),),
                                             Text("${data[index]["CcyNm_UZ"]}",style: TextStyle(color: Color.fromARGB(255, 113, 6, 109),fontWeight: FontWeight.bold,fontSize: 16),),
                                           ],
                                         ),
                                          Text("${data[index]["Rate"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                                       ],
                                     ),
                              
                                     Padding(
                                       padding: const EdgeInsets.only(top: 30),
                                       child: Text("${data[index]["Diff"]}",style: TextStyle(color: Color.fromARGB(255, 79, 5, 82),fontWeight: FontWeight.bold,fontSize: 16),),
                                     )
                                 
                              ],
                                                        ),
                            ),
                         
                        ],
                      ),
                    ),
                  ),
                
                 
                ],
              ),
             
            ),
          );
        },
      ),
    );
  }
}

