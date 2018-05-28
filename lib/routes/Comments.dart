import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebasetrychat/Messcreen.dart';

class Comments extends StatefulWidget{
final String value;
final int postid;
//print(Messcreen.a);
Comments ({this.value,this.postid});
  @override
  State createState()=> new _Comments();
}

class _Comments extends State<Comments>{
  

AsyncSnapshot r(AsyncSnapshot s){
  return s;
}
  AsyncSnapshot snap;
  TextEditingController _controller = new TextEditingController();

void newComment(){
  setState(() {
    DocumentReference dr = Firestore.instance.document("jod/$docid");
    List cont=[];
    try {
      snap.data.documents[widget.postid]['comments'].forEach((e){
        cont.add(e);
      print(e);
    });
    } catch (e) {
     // cont.add(_controller.text);
    }

    cont.add(_controller.text);
    dr.updateData({'comments': cont});
    print(cont);
    _controller.clear();
    //cont.clear();
    print(cont);
    });
}
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.indigo,
        title: new Text("Comments"),
      ),
      backgroundColor: Colors.white,
    
      body: new Column(
        children: <Widget>[
          new Container(
            width: 500.0,
            padding: const EdgeInsets.all(25.0),
            margin: const EdgeInsets.only(
              top: 10.0,
              bottom: 20.0,
              left: 2.0,
              right:2.0
            ),
            decoration: new BoxDecoration(
              color: Colors.teal[200],
            ),
            child: new Text("${widget.value}",textScaleFactor: 1.4,),
          ),
          new Flexible(
            child:new StreamBuilder(
              stream: Firestore.instance.collection('jod').snapshots(),
              builder: (context,snapshot){
                try {
                  if (snapshot.hasData){
                    return new ListView.builder(
                  itemCount:snapshot.data.documents[widget.postid]['comments'].length,
                  itemBuilder: (context,index){                  
                    snap =r(snapshot);
                    return new Container(
                      child:new Card(
                        color: Colors.blue[100],
                        child: new Container(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            bottom: 20.0,
                            left: 20.0
                          ),
                          child: new Text("${snapshot.data.documents[widget.postid]['comments'][index]}",textScaleFactor: 1.3,style:  new TextStyle(
                          color: Colors.black
                        ),),
                        )
                      )
                    );

                  },
                );
                  }
                } catch (e) {
                  return new Center(
                    child: new Text("No Comment To Show Here!"),
                  );
                }
              },
            )
      ),
      new Container(
        margin: const EdgeInsets.all(2.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _controller,
        decoration: new InputDecoration(
          hintText: "Please Leave a Comment"
        ),
      ),
            ),
            new IconButton(
              icon: new Icon(Icons.send),
              onPressed:(){newComment();} ,
            )
          ],
        )
      )
        ],
      )

    );
  }
}