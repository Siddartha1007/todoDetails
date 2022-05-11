import 'package:flutter/material.dart';
import 'package:proj1/model/stuClass.dart';

class DetailsScreen extends StatefulWidget {

  StuClass? stuModel;
  DetailsScreen(this.stuModel, {Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.stuModel!.name.toString()),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin: EdgeInsets.only(left: 20.0),
                padding: EdgeInsets.all(10),
                child: Text(widget.stuModel!.name.toString()),
              ),

              Container(
                margin: EdgeInsets.only(left: 20.0),
                 padding: EdgeInsets.all(10),
                child: Text(widget.stuModel!.clgname.toString()),
              ),

              Container(
                margin: EdgeInsets.only(left: 20.0),
                 padding: EdgeInsets.all(10),
                child: Text(widget.stuModel!.branch.toString()),
              ),

              Container(
                margin: EdgeInsets.only(left: 20.0),
                 padding: EdgeInsets.all(10),
                child: Text(widget.stuModel!.year.toString()),
              ),
              
            ],
          ) ,
        )
    );
  }
}