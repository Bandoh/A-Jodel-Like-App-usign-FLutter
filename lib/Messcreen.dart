

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


String tex;
int postnumber;
String docid;
class Messcreen extends StatefulWidget{
  @override
  State createState() =>  _Messcreen();

}

 

class _Messcreen extends State<Messcreen>{

List<MaterialColor> colours = [Colors.teal,Colors.lime,Colors.yellow];

void voteup(DocumentSnapshot dss){
  setState(() {
      dss.reference.updateData({"votes":dss['votes']+1});
      print("Tapped");
    });
}

void votedown(DocumentSnapshot dss){
  setState(() {
      dss.reference.updateData({"votes":dss['votes']-1,'comments':'Hi'});
      print("Tapped");
      print(dss.reference.documentID);
      
    });
}

void newmessage(){
  setState(() {
      CollectionReference cr = Firestore.instance.collection("jod");
      cr.add({"text":_controller.text,"votes":0}).whenComplete((){
        print("done");
        _controller.clear();
      });
    });
}
TextEditingController _controller = new TextEditingController();





  @override
  Widget build(BuildContext context){
    return new Container( 
    //  margin: const EdgeInsets.all(10.0),
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new StreamBuilder(
        stream:Firestore.instance.collection('jod').snapshots(),
        builder:(context,snapshot){
          return new ListView.builder(
            itemCount:snapshot.data.documents.length,
            itemBuilder: (context,index){
              DocumentSnapshot ds = snapshot.data.documents[index];
              return new Card(
                color: Colors.blue[100],
                elevation: 2.0,
                child: new Container(
                //  color: Colors.purple[100],
                margin: const EdgeInsets.only(
                  //top: 0.1
                ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   new Container(
                   //  height: 120.0,
                     //width: 400.0,
                     padding: const EdgeInsets.only(
                       left: 10.0,
                       top: 20.0,
                       bottom: 10.0
                       
                     ),
                     child:  new Text("${ds['text']}",textScaleFactor: 1.4,style: new TextStyle(
                       color: Colors.black54,
                     ),),
                   ),
                   new Container(
                     margin: const EdgeInsets.only(
                       left: 10.0
                     ),
                     child: new Row(
                     children: <Widget>[
                       new Text("Votes : ${ds['votes']}"),
                       new IconButton(
                         icon: new Icon(Icons.arrow_drop_up,color: Colors.green[500],),
                         onPressed: (){voteup(ds);},
                       ),
                       new IconButton(
                         icon: new Icon(Icons.arrow_drop_down,color: Colors.red[500],),
                         onPressed: (){votedown(ds);},
                       ),
                       new Container(
                         margin: const EdgeInsets.only(
                           left: 90.0
                         ),
                         child: new Icon(Icons.comment,
                         size: 15.0,
                         color: Colors.green,
                         ),
                       ),
                       new FlatButton(
                         onPressed:() {
                           tex = "${ds['text']}";
                           postnumber = index;
                           docid = (ds.reference.documentID);
                           Navigator.of(context).pushNamed("/comments");},
                         child: new Text("Comments",style: new TextStyle(
                           color: Colors.deepPurple,
                         ),),                         
                       ),
                       commen(ds),
                     ],
                   ),
                   )
                  ],
                ),
              ),
             );
            },

          );
          
        },
      ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                new Flexible(
                  child: new TextField(
                    decoration:  new InputDecoration(
                      hintText: "Please Input Message"
                    ),
                    controller: _controller,
                  ),
                ),
                new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: (){newmessage();},
                  color: Colors.blue[200],
                )
              ],
            ),
          )
        ],
      )

    );
  }

  Widget commen(DocumentSnapshot d){
    String m;
    try {
      m= ("${d['comments'].length}");
    } catch (e) {
      m = "0";
    }
    return new Text(m);
  }

}