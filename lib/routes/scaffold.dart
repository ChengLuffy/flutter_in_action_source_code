import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  late TabController _tabController;
  List _tabStrings = ["新闻", "历史", "图片"];
  int _bottomBarState = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabStrings.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _generateBottomBar() {
    if (_bottomBarState == 1) {
      return BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                _onItemTapped(1);
              },
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              ),
            ),
            SizedBox(),
            IconButton(
              onPressed: () {
                _onItemTapped(2);
              },
              icon: Icon(
                Icons.business,
                color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      );
    } else if (_bottomBarState == 2) {
      return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.signal_cellular_null,
                color: Colors.white,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: 'Business'),
        ],
        currentIndex: _selectedIndex - 1,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      );
    } else {
      return BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                _onItemTapped(1);
              },
              child: Container(
                height: 60,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      size: 30,
                      color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                          color:
                              _selectedIndex == 1 ? Colors.blue : Colors.grey,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(),
            GestureDetector(
              onTap: () {
                _onItemTapped(2);
              },
              child: Container(
                height: 60,
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.business,
                      size: 30,
                      color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Business",
                      style: TextStyle(
                          color:
                              _selectedIndex == 2 ? Colors.blue : Colors.grey,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Page Title'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (_bottomBarState == 3) _bottomBarState = 0;
                  _bottomBarState++;
                });
              },
              icon: Icon(Icons.change_circle))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabStrings
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      ),
      drawer: new MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: _tabStrings
            .map((e) => Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      e,
                      textScaleFactor: 5,
                    ),
                    Text('点击右上角切换 bottomNavigationBar 实现')
                  ],
                )))
            .toList(),
      ),
      bottomNavigationBar: _generateBottomBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("add");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(top: 38),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ClipOval(
                  child: Image.asset(
                    "imgs/avatar.png",
                    width: 80,
                  ),
                ),
              ),
              Text(
                "Wendux",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Expanded(
          child: Flex(direction: Axis.vertical, children: [
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) {
                      return route.settings.name == "/";
                    });
                  },
                  icon: Icon(Icons.backpack),
                  label: Text("Login out")),
            )
          ]),
        )
      ]),
    ));
  }
}
