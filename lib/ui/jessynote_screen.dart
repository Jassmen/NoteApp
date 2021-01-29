import 'package:flutter/material.dart';
import 'package:jessynote/model/note_item.dart';
import 'package:jessynote/util/database_client.dart';
import 'package:jessynote/util/date_formatted.dart';

class JessyNoteScreen extends StatefulWidget {

  @override
  _JessyNoteScreenState createState() => _JessyNoteScreenState();
}

class _JessyNoteScreenState extends State<JessyNoteScreen> {
  final TextEditingController   _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();
  final List<NoteItem> _itemList =<NoteItem>[];

  @override
  void initState() {
    super.initState();
    _readNoteItem();
  }
  /********************** SUBMIT ***************/
  void _handleSubmitted(String text)  async{
    _textEditingController.clear();
    NoteItem noteItem=new NoteItem(text, dateFormatted());
    int savedItemId = await db.saveItem(noteItem);
      NoteItem addedItem =await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Column(
        // we will add the list item on the screen
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                  reverse: false,
                  itemCount: _itemList.length,
                  itemBuilder: (_, int index){
                  return new Card(
                    color: Colors.black54,
                    child: new ListTile(
                      title: _itemList[index],
                      onLongPress: () =>
                          _updateItem(_itemList[index],index),
                      trailing: new Listener(
                        key: new Key(_itemList[index].itemName),
                        child: new Icon(Icons.remove_circle,color: Colors.red,),
                        onPointerDown: (pointEvent) =>
                            _deleteNote(_itemList[index].id, index),
                      ),

                    ),
                  );

                  }),
    ),
          new Divider(
            height: 1.0,
          )
        ],
      ),

      floatingActionButton: new FloatingActionButton(
        tooltip: "Add Item",
          backgroundColor: Colors.red,
          child: new ListTile(
            title: Icon(Icons.add),
          ),
          onPressed: _showFormDialog
      ),
    );
  }
  void _showFormDialog() {
    var alert = new AlertDialog(
      backgroundColor: Colors.white10,
      content: new Row(
        children: <Widget>[
          new Expanded(
              child: new TextField(
                style: TextStyle(color: Colors.white),
                controller: _textEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: "Item",
                    hintText: "Typeing ...",
                    hintStyle: TextStyle(color: Colors.white),
                    icon: new Icon(Icons.note_add),
                ),
              ))
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              _handleSubmitted(_textEditingController.text);
              _textEditingController.clear();
              Navigator.pop(context);
            },
            child: Text("Save")),
        new FlatButton(onPressed: () => Navigator.pop(context),
            child: Text("Cancel"))

      ],
    );
    showDialog(context: context,
        builder:(_) {
          return alert;

        });
  }
  /********************** READ FROM DB ***************/
 _readNoteItem() async{
  List items= await db.getItems();
  items.forEach((item){
  //  NoteItem noteItem= NoteItem.fromMap(item);
    setState(() {
      _itemList.add(NoteItem.map(item));
    });
   // print("Db : ${noteItem.itemName}");
  });
 }
  /********************** DELETE ITEM ***************/
  _deleteNote(int id, int index) async {
    debugPrint("Delete item!");
    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }
  /********************** UPDATE ITEM ***************/
  _updateItem(NoteItem item, int index) async{
    var alert= new AlertDialog(
      title: new Text("Update...",
      style: new TextStyle(
        color: Colors.teal
      ),),
      content: new Row(
        children: <Widget>[
         // new Image.asset(name)
          new Expanded(
              child: new TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: "Item",
                  hintText: "update... ",
                  hintStyle: TextStyle(color: Colors.white),
                  icon: new Icon(Icons.update),

                ),
              ))
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: ()async{
              NoteItem newItemUpdate= NoteItem.fromMap({
                "itemName":_textEditingController.text,
                "dateCreated":dateFormatted(),
                "id":item.id
              });
              _handleSubmittedUpdated(index,item);
              await db.updateItem(newItemUpdate);
              setState(() {
                _readNoteItem();
              });
              Navigator.pop(context);
            },
            child: new Text("Update")),
        new FlatButton(
            onPressed: () => Navigator.pop(context),
            child: new Text("Cancle"))
      ],
    );
    showDialog(context: context,builder: (_){
      return alert;
    });

  }

  void _handleSubmittedUpdated(int index, NoteItem item) {
    setState(() {
      _itemList.removeWhere((element){
        _itemList[index].itemName == item.itemName;
      });
    });
  }
/**********************
 * setState func we used it to redraw screen
 * ***************/


}
