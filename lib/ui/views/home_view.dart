import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_final/core/model/user.dart';
import 'package:smart_home_final/ui/share/text_styles.dart';
import 'package:smart_home_final/ui/share/ui_helpers.dart';
import 'package:smart_home_final/ui/views/widget/device_view_widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    //User user = Provider.of<User>(context);
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(null, 80),
      //   child: Container(
      //     width: MediaQuery.of(context).size.width,
      //     height: 80,
      //     child: Container(
      //       // color: Colors.blueAccent,
      //       child: Container(
      //         margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Icon(
      //               Icons.info,
      //               size: 30,
      //               color: Colors.green,
      //             ),
      //             Text(
      //               "KHSmart",
      //               style: TextStyle(fontSize: 24, color: Colors.green),
      //             ),
      //             Icon(
      //               Icons.add,
      //               size: 30,
      //               color: Colors.green,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // drawer: Drawer(
      //   child: Column(
      //     children: <Widget>[
      //       UserAccountsDrawerHeader(
      //         accountName: new Text(
      //           user.userName,
      //           style:
      //               new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      //         ),
      //         accountEmail: new Text(
      //           user.email,
      //           style:
      //               new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      //         ),
      //       ),
      //       // new Column(children: null),
      //     ],
      //   ),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  size: 30,
                  color: Colors.green,
                ),
                Text(
                  "KHSmart",
                  style: TextStyle(fontSize: 24, color: Colors.green),
                ),
                Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          // UIHelper.verticalSpaceLarge,
          // // Padding(
          // //   padding: const EdgeInsets.only(left: 20.0),
          // //   child: Text(
          // //     'Welcome ${user.userName}',
          // //     style: headerStyle,
          // //   ),
          // // ),
          // // Padding(
          // //   padding: const EdgeInsets.only(left: 20.0),
          // //   child:
          // //       Text('Here are all your smart devices', style: subHeaderStyle),
          // // ),
          // UIHelper.verticalSpaceSmall,
          Expanded(
            child: Devices(),
          ),
        ],
      ),
    );
  }
}
