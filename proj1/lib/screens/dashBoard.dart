import 'package:flutter/material.dart';
import 'package:proj1/screens/detailsScreen.dart';
import '../model/stuClass.dart';
import '../db/dBase.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({ Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  TextEditingController name = new TextEditingController();
  TextEditingController clgname = new TextEditingController();
  TextEditingController branch = new TextEditingController();
  TextEditingController year = new TextEditingController();

  List<StuClass> stuList = [];

  @override
  void initState() {
    super.initState();
    Dbase.instance.queryAllRows().then((value) {
      setState(() {
        value?.forEach((element) {
          stuList.add(StuClass(
              id: element['id'], 
              name: element["name"],
              clgname: element["clgname"],
              branch: element["branch"],
              year: element["year"],
            )
          );
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Dash Board")),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: Column(
          children:[
                  // SizedBox(height: 10),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Enter Name"),
                      controller: name,
                    ),
                  ),
                  // SizedBox(height: 8),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Enter College Name"),
                      controller: clgname,
                    ),
                  ),
                  // SizedBox(height: 8),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Enter Branch"),
                      controller: branch,
                   ),
                  ),
                  // SizedBox(height: 8),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Enter Year"),
                      controller: year,
                    ),
                  ),
                  // SizedBox(height: 8),

                  ElevatedButton(
                    onPressed: (){_addToDb;},
                    child: Text("Add"),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      child: stuList.isEmpty
                          ? Container()
                          : ListView.builder(
                            itemCount: stuList.length,
                            itemBuilder: (ctx, index) {
                              if (index == stuList.length) return Container();
                              return ListTile(
                                title: Text(stuList[index].name),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _delete(stuList[index].id),
                                ),
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        stuList[index]
                                      ),
                                    ),
                                  );
                                },
                          );
                        }),
                    ),
                  )            
          ]
        ),
      )
    );
  }

  void _addToDb() async {
    String nam = name.text;
    String clgnam = clgname.text;
    String branc = branch.text;
    String yea = year.text;
    var id = await Dbase.instance.insert(StuClass(name: nam, clgname: clgnam, branch: branc, year: yea));
    setState(() {
      stuList.insert(0, StuClass(id: id, name: nam, clgname: clgnam, branch: branc, year: yea));
    });
  }
    void _delete(int? id) async {
    await Dbase.instance.delete(id!);
    setState(() {
      stuList.removeWhere((element) => element.id == id);
    });
  }
}