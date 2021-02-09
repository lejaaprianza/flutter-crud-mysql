import 'package:flutter/material.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;
import 'package:crud/main.dart';

//menit 17.17
// ignore: must_be_immutable
class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    var url = "http://192.168.43.7/my_store/deletedata.php";
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are You sure want to delete '${widget.list[widget.index]['item_name']}'"),
      actions: <Widget>[
        new RaisedButton(
          onPressed: () async {
            deleteData();
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false,
            );
          },
          child: new Text("OKE DELETE!"),
          color: Colors.red,
        ),
        new RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: new Text("CANCEL"),
          color: Colors.green,
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.list[widget.index]['item_name']}"),
      ),
      body: new Container(
        height: 250,
        padding: const EdgeInsets.all(20),
        child: new Card(
          child: new Center(
            child: new Column(
              children: [
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(
                  widget.list[widget.index]['item_name'],
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Code : ${widget.list[widget.index]['item_code']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Price : ${widget.list[widget.index]['price']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Stock : ${widget.list[widget.index]['stock']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new RaisedButton(
                      child: new Text("EDIT"),
                      color: Colors.green,
                      onPressed: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new EditData(
                            list: widget.list,
                            index: widget.index,
                          ),
                        ),
                      ),
                    ),
                    new RaisedButton(
                      child: new Text("DELETE"),
                      color: Colors.red,
                      onPressed: () => confirm(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
