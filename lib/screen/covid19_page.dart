import 'package:covid19/models/covid19_model.dart';
import 'package:covid19/repository/covid19_service.dart';
import 'package:covid19/theme/font.dart';
import 'package:flutter/material.dart';



class Covid19Page extends StatefulWidget {
  const Covid19Page({Key? key}) : super(key: key);

  @override
  _Covid19PageState createState() => _Covid19PageState();
}

class _Covid19PageState extends State<Covid19Page> {


  Future<Covid19Model?>? dataCovid19;

  @override
  void initState() {
    // TODO: implement initState
    dataCovid19 = Covid19Service().getAPICovid19();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text('ยอดผู้ติดเชื้อใน ประเทศไทย'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                color: Colors.white,
                icon: Icon(
                  // Icons.more_horiz,
                  Icons.refresh,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    dataCovid19 = Covid19Service().getAPICovid19();
                  });
                }),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0XFFD55046),
                Color(0XFFE51D12)
              ],
            ),
        ),
        child: FutureBuilder<Covid19Model?>(
          // future: Covid19Service().getAPICovid19(),
          future: Covid19Service().getAPICovid19(),
          builder: (context, snapshot){
            switch(snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 8,
                    ),
                  )
                );
              default:
                if(snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                }else{
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 10
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 350,
                        width: 330,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.yellow[700],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ติดเชื้อสะสม',
                                      style: textH2(Colors.white),
                                    ),
                                    Text(
                                      '${snapshot.data!.cases}',
                                      style: textH1(Colors.white),
                                    ),
                                    Text(
                                      '(+ ${snapshot.data!.todayCases})',
                                      style: textH1(Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.green[800],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'หายแล้ว',
                                            style: textH4(Colors.white),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${snapshot.data!.recovered}',
                                            style: textH3(Colors.white),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '(+ ${snapshot.data!.newRecovered})',
                                            style: textH4(Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.blue,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'รักษาอยู่ใน รพ.',
                                            style: textH4(Colors.white),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${snapshot.data!.active}',
                                            style: textH3(Colors.white),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '(${snapshot.data!.newHospitalized})',
                                            style: textH4(Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey[600],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'เสียชีวิต',
                                            style: textH4(Colors.white),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${snapshot.data!.deaths}',
                                            style: textH3(Colors.white),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '(+ ${snapshot.data!.newDeaths})',
                                            style: textH4(Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            }
          },
        ),
      )
    );
  }
}
