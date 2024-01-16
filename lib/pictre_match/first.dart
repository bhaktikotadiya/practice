import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/pictre_match/second.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()
{
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: first(),
    ));
}
class first extends StatefulWidget {
  // const first({super.key});
  static SharedPreferences ?prefs;

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  int level_no=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  get()
  async {
    first.prefs = await SharedPreferences.getInstance();
    level_no = first.prefs!.getInt("levelno") ?? 0;
    print("LevelNO:$level_no");
    // t1=true;
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SELECT LEVEL"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.teal.shade100,
        child: Column(children: [
          Expanded(flex: 7,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder:  (context, myindex) {
                return Container(
                  height: double.infinity,
                  width: 200,
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    border: Border.all(color: Colors.teal,width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(children: [
                    Expanded(flex: 1,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text("MATCH ${myindex+1}"),
                      ),
                    ),
                    Divider(height: 2,color: Colors.teal,),
                    Expanded(flex: 10,
                      child:  ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          int l_no = (myindex*10)+index+1;
                          int l_no1 = (myindex*10)+index;
                          return (l_no1<=level_no)?InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                if(l_no1<level_no)
                                {
                                  return second(l_no1);
                                }
                                else
                                {
                                  return second();
                                }
                              },));
                          },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              color: Colors.teal,
                              child: Wrap(
                                children: [
                                  (l_no1<level_no) ? Text("LEVEL ${l_no} - ${first.prefs!.getInt("level_time${l_no1+1}") ?? ""}",style: TextStyle(fontSize: 20,color: Colors.white))
                                      :Text("LEVEL ${l_no}",style: TextStyle(fontSize: 20,color: Colors.white)),
                                  (l_no1<level_no)?Text(" s",style: TextStyle(fontSize: 20,color: Colors.white)):Text(""),
                                ],
                              )
                            ),
                          ):Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            color: Colors.teal.shade100,
                            child: Text("LEVEL ${l_no}"),
                          );
                        },
                      ),
                    ),
                  ]),
                );
              },
            ),
          ),
        ],)
      ),
    );
  }
}
