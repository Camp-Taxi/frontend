import 'package:campride/chat_rooms.dart';
import 'package:campride/main_list.dart';
import 'package:campride/mypage.dart';
import 'package:campride/room.dart';
import 'package:campride/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          home: SplashScreen(),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    ChatRoomsPage(),
    CampRiderPage(),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_taxi),
            label: '캠프라이더',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Color(0xFF365B51)),
        selectedLabelStyle: TextStyle(color: Color(0xFF365B51)),
        unselectedIconTheme: IconThemeData(color: Colors.black54),
        onTap: _onItemTapped,
      ),

      floatingActionButton: _selectedIndex == 1
          ? SizedBox(
              width: 95.w,
              height: 40.h,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: ((context) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0).r,
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '4/14일 상록 예비군 출발하실 분 구해요',
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '준행행님',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.orange),
                                      height: 400.h,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent),
                                      height: 400.h,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text('참여'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('닫기'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "방만들기",
                        style:
                            TextStyle(fontSize: 15.sp, color: Colors.black54),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
