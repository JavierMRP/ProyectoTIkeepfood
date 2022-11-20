import 'package:keepfood/controllers/MenuController.dart';
import 'package:keepfood/responsive.dart';
import 'package:keepfood/screens/dashboard/dashboard_screen.dart';
import 'package:keepfood/screens/main/components/Notifications.dart';
import 'package:keepfood/screens/main/components/Reports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var nav = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset("../assets/images/logo.png"),
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                setState(() {
                  nav = 0;
                });
              },
            ),
            DrawerListTile(
              title: "Reportes",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                setState(() {
                  nav = 1;
                });
              },
            ),
            DrawerListTile(
              title: "Notificaciones",
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {
                setState(() {
                  nav = 2;
                });
              },
            ),
            DrawerListTile(
              title: "Perfil",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {
                setState(() {
                  nav = 3;
                });
              },
            ),
            DrawerListTile(
              title: "Configuración",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {
                setState(() {
                  nav = 4;
                });
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: Drawer(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: Image.asset("../assets/images/logo.png"),
                      ),
                      DrawerListTile(
                        title: "Dashboard",
                        svgSrc: "assets/icons/menu_dashbord.svg",
                        press: () {
                          setState(() {
                            nav = 0;
                          });
                        },
                      ),
                      DrawerListTile(
                        title: "Reportes",
                        svgSrc: "assets/icons/menu_tran.svg",
                        press: () {
                          setState(() {
                            nav = 1;
                          });
                        },
                      ),
                      DrawerListTile(
                        title: "Notificaciones",
                        svgSrc: "assets/icons/menu_notification.svg",
                        press: () {
                          setState(() {
                            nav = 2;
                          });
                        },
                      ),
                      DrawerListTile(
                        title: "Perfil",
                        svgSrc: "assets/icons/menu_profile.svg",
                        press: () {
                          setState(() {
                            nav = 3;
                          });
                        },
                      ),
                      DrawerListTile(
                        title: "Configuración",
                        svgSrc: "assets/icons/menu_setting.svg",
                        press: () {
                          setState(() {
                            nav = 4;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            if (nav == 0)
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: DashboardScreen(),
              ),
            if (nav == 1)
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: Reports(),
              ),
            if (nav == 2)
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: Notifications(),
              ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
