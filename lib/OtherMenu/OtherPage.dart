import 'package:flutter/material.dart';
import 'package:promotion_mrt/HomePage/VDOs/VdoPage.dart';

class OtherPage extends StatelessWidget {
  /*/final String title;
  final int materialIndex;
  final ValueChanged onPush;
  const OtherPage({Key key, this.title, this.materialIndex = 500, this.onPush})
      : super(key: key);*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BANGKOK MRT')),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 380.0,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2.0, color: Colors.black12))),
              child: Column(
                children: <Widget>[
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("Social Media",
                                style: TextStyle(fontSize: 16.0)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Image.asset(
                                            'images/icons/contract/img_icon_more_mrt.png',
                                            scale: 1.2),
                                        Image.asset(
                                            'images/icons/contract/img_icon_more_fb.png',
                                            scale: 1.2),
                                        Image.asset(
                                            'images/icons/contract/img_icon_more_twitter.png',
                                            scale: 1.2),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text("Website"),
                                        Text("Facebook"),
                                        Text("Twitter"),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 5.0,
                          indent: 50.0,
                          endIndent: 50.0,
                          color: Colors.black45,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Image.asset(
                                            'images/icons/contract/img_icon_more_ig.png',
                                            scale: 1.2),
                                        Image.asset(
                                            'images/icons/contract/img_icon_more_youtube.png',
                                            scale: 1.2),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text("Instagram"),
                                        Text("Youtube"),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 160.0,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2.0, color: Colors.black12))),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Contact us',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  'images/icons/contract/img_icon_more_email.png',
                                  scale: 1.3,
                                ),
                                Image.asset(
                                  'images/icons/contract/img_icon_more_call.png',
                                  scale: 1.3,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('Email'),
                                    Text('Support')
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
