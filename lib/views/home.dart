import 'package:argaam_app/data.dart';
import 'package:argaam_app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:local_notifications/local_notifications.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeStete();
  }
}

class HomeStete extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  getbody() {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: getDrawerBody(),
      ), // HomeDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Icon(
            Icons.clear_all,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                          color: Colors.blueGrey,
                          onPressed: () {
                            showNotification();
                          },
                          child: Text(
                            "أظهر اشعار جديد",
                            style: TextStyle(color: AppColors.orange),
                          )),
                      RaisedButton(
                          color: Colors.blueGrey,
                          onPressed: () async {
                            await LocalNotifications.removeNotification(0);
                          },
                          child: Text("حذف  الاشعارات",
                              style: TextStyle(color: AppColors.orange)))
                    ],
                  ),
                ),
                duration: Duration(seconds: 5),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          )
        ],
        title: Text(
          "أرقام",
          style: TextStyle(
              fontFamily: "MainLogoFont",
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              decorationStyle: TextDecorationStyle.solid),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: new CarouselSlider(
                items: posts.map((i) {
                  return new Builder(
                    builder: (BuildContext context) {
                      return new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: new EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: new BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(i["url"])),
                              color: Colors.blueGrey.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * .1,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3)),
                                child: Text(
                                  i["header"],
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ));
                    },
                  );
                }).toList(),
                height: MediaQuery.of(context).size.height * 0.28,
                autoPlay: true),
          ),
          Column(
            children: getlistOfNewa(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    initNotification();
    return getbody();
  }

  getDrawerBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        getdrawerHeader(),
        getDrawerItem("الأخبار"),
        getDrawerItem("القطاعات"),
        getDrawerItem("معلومات الشركات"),
        getDrawerItem("البيانات المالية"),
        getDrawerItem("المؤشرات المالية"),
        getDrawerItem("المحللون"),
        getDrawerItem("الاكتتابات"),
      ],
    );
  }

  getDrawerItem(var title) {
    return Column(
      children: <Widget>[
        InkWell(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 30.0,
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 18,
                            fontFamily: "MainLogoFont"),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Divider(
          color: AppColors.orange,
        )
      ],
    );
  }

  getdrawerHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      color: AppColors.orange,
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
          ),
          new Container(
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://avatars3.githubusercontent.com/u/5676934?s=400&u=d903a97c4f17c195eb70a5e5a46cfe293c8fb334&v=4")))),
          Text(
            "Mahmoud Hossam",
            style: TextStyle(fontSize: 22.0, color: Colors.white),
          )
        ],
      ),
    );
  }

  getlistOfNewa() {
    return posts.map((post) {
      return InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(5),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text(
                  post["header"],
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                )),
                Icon(
                  Icons.check_circle,
                  color: AppColors.orange,
                )
              ],
            ),
          ));
    }).toList();
  }

  static const AndroidNotificationChannel channel =
      const AndroidNotificationChannel(
          id: 'default_notification',
          name: 'Default',
          description: 'Grant this app the ability to show notifications',
          importance: AndroidNotificationChannelImportance.HIGH);

  Future showNotification() async {
    await LocalNotifications.createAndroidNotificationChannel(channel: channel);
    await LocalNotifications.createNotification(
        title: "Basic",
        content: "Notification",
        id: 0,
        androidSettings: new AndroidSettings(channel: channel),
        iOSSettings: IOSSettings(presentWhileAppOpen: true));
  }
}
