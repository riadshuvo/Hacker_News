import 'package:flutter/material.dart';
import 'package:hacker_news/screens/news_details.dart';
import 'package:hacker_news/screens/topnews_ui.dart';
import 'package:provider/provider.dart';

import 'blocs/hacker_news_bloc.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes,
      navigatorKey: navigatorKey,
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
         return Provider<HackerNewsBloc>(
            create: (context) => HackerNewsBloc(),
            child: TopNewsUi(),
          );

        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final itemId = int.parse(settings.name.replaceFirst('/', ''));
          print("itemId: $itemId");
          return NewsDetails(itemId: itemId);
        },
      );
    }
  }

}


class LoginThirdpartDialog extends StatefulWidget {
  @override
  _LoginThirdpartDialogState createState() => new _LoginThirdpartDialogState();
}

class _LoginThirdpartDialogState extends State<LoginThirdpartDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    bool _passwordVisible = false;
    return Dialog(
      insetPadding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Welcome to Ali2bd',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.yellow,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      elevation: 4.0,
                      minWidth: 0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
//              size: 24.0,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.blue[800],
                      shape: CircleBorder(),
                      elevation: 4.0,
                      minWidth: 0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
//              size: 24.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.yellow,
                      shape: CircleBorder(),
                      elevation: 4.0,
                      minWidth: 0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
//              size: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Divider(
                    color: Colors.red,
                    thickness: 2,
                    height: 20,
                  ),
                  Text('Or',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  Divider(
                    height: 4,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text('Mobile Number',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 8,
              ),

              SizedBox(
                height: 40,
              ),
              Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                margin: EdgeInsets.only(left: 0, right: 0, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.deepOrange,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Continue'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
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



