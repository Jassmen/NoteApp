import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class NoteItem extends StatelessWidget {
  String _itemName;
  String _dateCreated;
  int  _id;

  NoteItem(this._itemName,this._dateCreated);
  NoteItem.map(dynamic obj){
    this._itemName = obj['itemName'];
    this._dateCreated= obj['dateCreated'];
    this._id =obj['id'];
  }

  String get itemName => _itemName;
  String get dateCreated => _dateCreated;
  int  get id => _id;

  Map<String , dynamic> toMap(){
    Map map =new Map<String , dynamic>();
    map['itemName']= _itemName;
    map['dateCreated'] = _dateCreated;

    if(id != null){
      map['id'] = _id;
    }
    return map;
  }

  NoteItem.fromMap(Map<String , dynamic> map){
    this._itemName= map['itemName'];
    this._dateCreated=map['dateCreated'];
    this._id= map['id'];
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_itemName,
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text("Created on: $_dateCreated",
                    style: new TextStyle (
                      color: Colors.white70,
                      textBaseline: TextBaseline.alphabetic,     ///////////////////////////////////////////////////////////////////////////////
                      fontSize:13.9,
                      fontStyle: FontStyle.italic,
                    )),

              )
            ],
          ),


        ],
      ),
    );
  }
}
