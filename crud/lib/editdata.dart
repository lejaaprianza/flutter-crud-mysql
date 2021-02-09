import 'package:flutter/material.dart';
import './main.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerCode;
  TextEditingController controllerName;
  TextEditingController controllerPrice;
  TextEditingController controllerStock;

  void editData() {
    var url = "http://192.168.43.7/my_store/editdata.php";
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "itemcode": controllerCode.text,
      "itemname": controllerName.text,
      "price": controllerPrice.text,
      "stock": controllerStock.text
    });
  }

  @override
  void initState() {
    controllerCode =
        new TextEditingController(text: widget.list[widget.index]['item_code']);
    controllerName =
        new TextEditingController(text: widget.list[widget.index]['item_name']);
    controllerPrice =
        new TextEditingController(text: widget.list[widget.index]['price']);
    controllerStock =
        new TextEditingController(text: widget.list[widget.index]['stock']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            new Column(
              children: [
                new TextField(
                  controller: controllerCode,
                  decoration: new InputDecoration(
                      hintText: "Item Code", labelText: "Item Code"),
                ),
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      hintText: "Item Name", labelText: "Item Name"),
                ),
                new TextField(
                  controller: controllerPrice,
                  decoration: new InputDecoration(
                      hintText: "Price", labelText: "Price"),
                ),
                new TextField(
                  controller: controllerStock,
                  decoration: new InputDecoration(
                      hintText: "Stock", labelText: "Stock"),
                ),
                new Padding(padding: const EdgeInsets.all(10)),
                new RaisedButton(
                  onPressed: () async {
                    editData();
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (route) => false,
                    );
                    // Navigator.pop(context);
                    // Navigator.pushNamed(context, "Setting");
                  },
                  color: Colors.blueAccent,
                  child: new Text("EDIT DATA"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
