import 'dart:io';

import 'package:drug_dictionary/config/size_config.dart';
import 'package:drug_dictionary/src/screens/favourite_drugs.dart';
import 'package:drug_dictionary/src/screens/history_list.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    _showAbout() {
      return showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return Center(
              child: Container(
                width: SizeConfig.screenWidth - 30,
                height: SizeConfig.screenHeight - 70,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      color: Theme.of(context).primaryColor,
                      height: (SizeConfig.screenHeight - 10) / 3,
                      width: SizeConfig.screenWidth - 30,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 25.0,
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 15,
                            width: SizeConfig.blockSizeVertical * 15,
                            child: Image(
                                image:
                                    AssetImage('assets/icons/dictionary.png')),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Drug Dictinary - Pharmacy Helper",
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                          Text(
                            "Version 1.0.0",
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        style: Theme.of(context).textTheme.body1,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).accentColor,
                    )
                  ],
                ),
              ),
            );
          });
    }

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Drug Dictinary - Pharmacy Helper',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            accountEmail: Text("Version 1.0.0"),
            currentAccountPicture:
                Image(image: AssetImage('assets/icons/dictionary.png')),
          ),
          ListTile(
            title: Text(
              'Favourites',
              style: Theme.of(context).textTheme.display1,
            ),
            leading: Icon(Icons.favorite),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavouriteDrugs(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'History',
              style: Theme.of(context).textTheme.display1,
            ),
            leading: Icon(Icons.history),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryDrugs(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'About',
              style: Theme.of(context).textTheme.display1,
            ),
            leading: Icon(Icons.info),
            onTap: _showAbout,
          ),
          Divider(
            height: 10.0,
          ),
          ListTile(
            title: Text(
              'Exit',
              style: Theme.of(context).textTheme.display1,
            ),
            leading: Icon(Icons.exit_to_app),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}
