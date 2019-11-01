import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_final/core/constants.dart/route_path.dart';
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
                GestureDetector(
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.green,
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    RoutePaths.ConfigDevice,
                  ),
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
