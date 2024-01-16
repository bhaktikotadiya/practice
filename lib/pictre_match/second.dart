import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice/pictre_match/first.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()
{
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: second(),
    ));
}
class second extends StatefulWidget {
  int ?l_no1;
  second([this.l_no1]);
  // const second({super.key});

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {

  List<bool> temp=[];
  int x=1;
  List pic=[];
  List pic1=[];
  double a=5;
  double a1=0;
  int pos1=0;
  int pos2=0;
  int pos3=0;
  int level_no=0;
  int sec=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("LNO:${widget.l_no1}");
    if(widget.l_no1==null){
      level_no = first.prefs!.getInt("levelno") ?? 0;
    }else
    {
      level_no=widget.l_no1!;
    }

    WidgetsBinding.instance?.addPostFrameCallback((_)
    {
      showDialog(barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.all(0),
              // margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
              alignment: Alignment.center,
              color: Colors.teal,
              child: Text("TIME : NO TIME LIMITS",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            content: Text("YOU HAVE 5 SECONDES TO MEMORIZE ALL IMAGES",
                style: TextStyle(fontSize: 15, color: Colors.black)),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  temp=List.filled(12, true);
                  _initImages();
                  get();
                  share_pref();
                  setState(() { });
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.teal,
                  // padding: EdgeInsets.fromLTRB(40, 10, 40, 15),
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(100, 0, 100, 10),
                  child: Text("GO",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
            ],
          );
        },
      );
    });
    setState(() { });
    // _initImages();
    // get();
    // temp=List.filled(12, true);
  }
  share_pref()
  async {
    // Save an integer value to 'levelNo' key.
    first.prefs=await SharedPreferences.getInstance();
    setState(() { });
  }

  get()  async {
        for(double i=5;i>=0;i--)
        {
            await Future.delayed(Duration(seconds: 1));
            a=i;
            if(a==0)
            {
               temp=List.filled(12, false);
            }
            setState(() { });
        }
        double j=0;
        while(true)
        {
           await Future.delayed(Duration(seconds: 1));
          if(temp[0]==true && temp[1]==true && temp[2]==true && temp[3]==true && temp[4]==true && temp[5]==true &&
              temp[6]==true && temp[7]==true && temp[8]==true && temp[9]==true && temp[10]==true && temp[11]==true)
          {
                break;
          }
            a1=j;
            j++;
            setState(() { });
        }
        setState(() { });
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('myassets/images/match_puzzle/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      pic = imagePaths;
      pic.shuffle();
      for(int i=0;i<6;i++)
      {
        pic1.add(pic[i]);
        pic1.add(pic[i]);
      }
      pic1.shuffle();
      print(pic);
    });
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: (a!=0)?Text("TIME : $a/0"):Text("TIME : $a1/0"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.teal.shade100,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: SliderTheme(
                  child: Slider(
                    value: (a!=0)?a:a1,
                    max: (a!=0)?5:400,
                    min: 0,
                    activeColor: Colors.teal,
                    inactiveColor: Colors.white70,
                    onChanged: (double value) {},
                  ),
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 5,
                    thumbColor: Colors.transparent,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
                  ),
                ),
              ),
            ),
            Expanded(flex: 6,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                // color: Colors.pink,
                margin: EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: pic1.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder:  (context, index) {
                      return InkWell(
                        onTap: () async {
                            if(!temp[index] && x==1)
                            {
                                  temp[index]=true;
                                  pos1=index;
                                  x=3;
                                  Future.delayed(Duration(milliseconds: 200)).then((value){
                                      x=2;
                                      setState(() { });
                                  });
                            }
                            if(!temp[index] && x==2)
                            {
                                temp[index]=true;
                                x=3;
                                pos2=index;
                                  if(pic1[pos1]==pic1[pos2])
                                  {
                                      print("Images are match");
                                      x=1;
                                      if(temp[0]==true && temp[1]==true && temp[2]==true && temp[3]==true && temp[4]==true && temp[5]==true &&
                                          temp[6]==true && temp[7]==true && temp[8]==true && temp[9]==true && temp[10]==true && temp[11]==true)
                                      {
                                        int temp_sec=first.prefs!.getInt("level_time${level_no}") ?? 0;
                                        if(a1<temp_sec)
                                        {
                                              first.prefs!.setInt("level_time${level_no}", a1 as int);
                                        }
                                        if(widget.l_no1==null)
                                        {
                                                level_no++;
                                                first.prefs!.setInt("levelno", level_no);
                                                first.prefs!.setInt("level_time${level_no}", a1 as int);
                                        }

                                            showDialog(barrierDismissible: false,context: context, builder: (context) {
                                                  return AlertDialog(
                                                    title: Container(
                                                      height: 50,
                                                      width: double.infinity,
                                                      padding: EdgeInsets.all(0),
                                                      alignment: Alignment.center,
                                                      color: Colors.teal,
                                                      child: Text("NEW RECORD !",style: TextStyle(fontSize: 20,color: Colors.white)),
                                                    ),
                                                    content: Text("${a1} seconds\n\nNO TIME LIMITS\n\nLEVEL ${level_no+1}\n\nWELL DONE!!!"),
                                                    actions: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                            return first();
                                                          },));
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          width: double.infinity,
                                                          color: Colors.teal,
                                                          padding: EdgeInsets.fromLTRB(40, 10, 40, 15),
                                                          alignment: Alignment.center,
                                                          margin: EdgeInsets.fromLTRB(95, 0, 95, 10),
                                                          child: Text("OK",style: TextStyle(fontSize: 25,color: Colors.white)),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                            );
                                      }
                                  }
                                  else
                                  {
                                      Future.delayed(Duration(milliseconds: 200)).then((value) {
                                          x=1;
                                          temp[pos1] = false;
                                          temp[pos2] = false;
                                          setState(() { });
                                      });
                                  }
                            }
                            setState(() { });
                        },
                        child: Visibility(
                          visible: temp[index],
                          child: Container(
                            // margin: EdgeInsets.all(3),
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("${pic1[index]}")),
                           //   borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                          ),replacement: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.teal,
                            // image: DecorationImage(
                            //     fit: BoxFit.fill,
                            //     image: AssetImage("${pic1[index]}")),
                         //   borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        ),
                      );
                    },
                ),
              ),
            ),
            SizedBox(height: 60,),
            Expanded(flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.teal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
