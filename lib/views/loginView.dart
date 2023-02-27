import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lg_app/views/ErrorView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssh2/ssh2.dart';
import 'dart:ui' as ui;
import '../config/app_theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  Color _iconColor = Color.fromARGB(400, 74, 74, 74);
  bool isLoggedIn = false;
  bool obscurePassword = true;
  bool loaded = false;
  bool isSuccess = false;

  TextEditingController username = TextEditingController();
  TextEditingController ipAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController portNumber = TextEditingController();
  TextEditingController numberofrigs = TextEditingController();

  bool connectionStatus = false;

  connect() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('master_ip', ipAddress.text);
    await preferences.setString('master_username', username.text);
    await preferences.setString('master_password', password.text);
    await preferences.setString('master_portNumber', portNumber.text);
    await preferences.setString('numberofrigs', numberofrigs.text);

    try {
      SSHClient client = SSHClient(
        host: ipAddress.text,
        port: int.tryParse(portNumber.text)!.toInt(),
        username: username.text,
        passwordOrKey: password.text,
      );
      await client.connect();
      // print("Hua...");
      // print('master_ip: ${ipAddress.text}');
      // print('master_password: ${password.text}');
      // print('master_portNumber: ${portNumber.text}');
      // print('numberofrigs: ${numberofrigs.text}');
      setState(() {
        connectionStatus = true;
      });
      // open logos
      // await LGConnection().openDemoLogos();
      await client.disconnect();
    } catch (e) {
      ErrorView();
      // print("nhiHua...");
      // print('master_ip: ${ipAddress.text}');
      // print('master_password: ${password.text}');
      // print('master_portNumber: ${portNumber.text}');
      // print('numberofrigs: ${numberofrigs.text}');
      setState(() {
        connectionStatus = false;
      });
    }
  }

  checkConnectionStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('master_ip', ipAddress.text);
    await preferences.setString('master_password', password.text);
    await preferences.setString('master_portNumber', portNumber.text);
    await preferences.setString('numberofrigs', numberofrigs.text);

    try {
      SSHClient client = SSHClient(
        host: ipAddress.text,
        port: int.tryParse(portNumber.text)!.toInt(),
        username: username.text,
        passwordOrKey: password.text,
      );
      await client.connect();
      setState(() {
        connectionStatus = true;
      });
      await LGConnection().openDemoLogos();
      await client.disconnect();
    } catch (e) {
      ErrorView();
      setState(() {
        connectionStatus = false;
      });
    }
  }

  init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ipAddress.text = preferences.getString('master_ip') ?? '';
    username.text = preferences.getString('master_username') ?? '';
    password.text = preferences.getString('master_password') ?? '';
    portNumber.text = preferences.getString('master_portNumber') ?? '';
    numberofrigs.text = preferences.getString('numberofrigs') ?? '';
    await checkConnectionStatus();
    loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 120.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0, top: 50),
                child: Text(
                  'BUTTONS',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white,
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Status: ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      connectionStatus
                          ? 'Connected '
                          : 'Disconnected ',
                      style: TextStyle(fontSize: 20),
                    ),
                    connectionStatus
                        ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    )
                        : Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  child: SizedBox(
                    width: 100,
                    child: Wrap(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        FittedBox(
                          child: Text('BUTTON 1',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black
                              )),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    shadowColor: selectedAppTheme.isDarkMode
                        ? Colors.black
                        : Colors.grey.withOpacity(0.5),
                    primary: selectedAppTheme.isDarkMode
                        ? ui.Color.fromARGB(255, 30, 30, 30)
                        : Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  child: SizedBox(
                    width: 100,
                    child: Wrap(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        FittedBox(
                          child: Text('BUTTON 2',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black
                              )),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    shadowColor: selectedAppTheme.isDarkMode
                        ? Colors.black
                        : Colors.grey.withOpacity(0.5),
                    primary: selectedAppTheme.isDarkMode
                        ? ui.Color.fromARGB(255, 30, 30, 30)
                        : Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  child: SizedBox(
                    width: 100,
                    child: Wrap(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        FittedBox(
                          child: Text('BUTTON 3',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black
                              )),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    shadowColor: selectedAppTheme.isDarkMode
                        ? Colors.black
                        : Colors.grey.withOpacity(0.5),
                    primary: selectedAppTheme.isDarkMode
                        ? ui.Color.fromARGB(255, 30, 30, 30)
                        : Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  child: SizedBox(
                    width: 100,
                    child: Wrap(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        FittedBox(
                          child: Text('BUTTON 4',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black
                              )),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    shadowColor: selectedAppTheme.isDarkMode
                        ? Colors.black
                        : Colors.grey.withOpacity(0.5),
                    primary: selectedAppTheme.isDarkMode
                        ? ui.Color.fromARGB(255, 30, 30, 30)
                        : Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LGConnection {
  _getCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String ipAddress = preferences.getString('master_ip') ?? '';
    String password = preferences.getString('master_password') ?? '';
    String portNumber = preferences.getString('master_portNumber') ?? '';
    String username = preferences.getString('master_username') ?? '';
    String numberofrigs = preferences.getString('numberofrigs') ?? '';

    return {
      "ip": ipAddress,
      "pass": password,
      "port": portNumber,
      "username": username,
      "numberofrigs": numberofrigs
    };
  }

  Future openDemoLogos() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      host: '${credencials['ip']}',
      port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      passwordOrKey: '${credencials['pass']}',
    );
    int rigs = 4;
    rigs = (int.parse(credencials['numberofrigs']) / 2).floor() + 2;
    try {
      await client.connect();
    } catch (e) {
      return Future.error(e);
    }
  }
}
