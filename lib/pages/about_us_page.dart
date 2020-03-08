import 'dart:io';

import 'package:ap_common/resources/ap_assets.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'open_source_page.dart';

class AboutUsPage extends StatefulWidget {
  static const String routerName = "/aboutus";
  final String assetImage;
  final String fbFanPageUrl;
  final String fbFanPageId;
  final String githubUrl;
  final String githubName;
  final String email;
  final String appLicense;

  const AboutUsPage({
    Key key,
    @required this.assetImage,
    @required this.fbFanPageUrl,
    @required this.fbFanPageId,
    @required this.githubUrl,
    @required this.githubName,
    @required this.email,
    @required this.appLicense,
  }) : super(key: key);

  @override
  AboutUsPageState createState() => AboutUsPageState();
}

class AboutUsPageState extends State<AboutUsPage> {
  ApLocalizations app;

  @override
  void initState() {
//    FA.setCurrentScreen("AboutUsPage", "about_us_page.dart");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    app = ApLocalizations.of(context);
    var expandedHeight = MediaQuery.of(context).size.height * 0.25;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: expandedHeight,
            floating: false,
            pinned: true,
            title: Text(app.about),
            actions: <Widget>[
              IconButton(
                icon: Icon(ApIcon.codeIcon),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => OpenSourcePage(),
                    ),
                  );
                },
              )
            ],
            backgroundColor: ApTheme.of(context).blue,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.assetImage,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            <Widget>[
              _item(app.aboutAuthorTitle, app.aboutAuthorContent),
              _item(app.about, app.aboutUsContent),
              _item(app.aboutRecruitTitle, app.aboutRecruitContent),
              Stack(
                children: <Widget>[
                  _item(app.aboutItcTitle, app.aboutItcContent),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        ApImageAssets.kuasITC,
                        width: 64.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      top: 24.0, left: 16.0, bottom: 16.0, right: 16.0),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        app.aboutContactUsTitle,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset(ApImageAssets.fb),
                              onPressed: () {
                                if (kIsWeb)
                                  launch(widget.fbFanPageUrl);
                                else if (Platform.isAndroid)
                                  launch('fb://page/${widget.fbFanPageId}')
                                      .catchError((onError) =>
                                          launch(widget.fbFanPageUrl));
                                else if (Platform.isIOS)
                                  launch('fb://profile/${widget.fbFanPageId}')
                                      .catchError((onError) =>
                                          launch(widget.fbFanPageUrl));
                                else
                                  launch(widget.fbFanPageUrl).catchError(
                                    (onError) => ApUtils.showToast(
                                      context,
                                      app.platformError,
                                    ),
                                  );
                              },
                              iconSize: 48.0,
                            ),
                            IconButton(
                              icon: Image.asset(ApImageAssets.github),
                              onPressed: () {
                                if (kIsWeb)
                                  launch(widget.githubUrl);
                                else if (Platform.isAndroid)
                                  launch('github://organization/${widget.githubName}')
                                      .catchError((onError) =>
                                          launch(widget.githubUrl));
                                else if (Platform.isIOS)
                                  launch(widget.githubUrl);
                                else
                                  launch(widget.githubUrl).catchError(
                                    (onError) => ApUtils.showToast(
                                      context,
                                      app.platformError,
                                    ),
                                  );
//                              FA.logAction('github', 'click');
                              },
                              iconSize: 48.0,
                            ),
                            IconButton(
                              icon: Image.asset(ApImageAssets.email),
                              onPressed: () {
                                launch('mailto:${widget.email}').catchError(
                                  (onError) => ApUtils.showToast(
                                    context,
                                    app.platformError,
                                  ),
                                );
//                              FA.logAction('email', 'click');
                              },
                              iconSize: 48.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _item(app.aboutOpenSourceTitle, widget.appLicense),
            ],
          )),
        ],
      ),
    );
  }

  _item(String text, String subText) => Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding:
              EdgeInsets.only(top: 24.0, left: 16.0, bottom: 16.0, right: 16.0),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 4.0,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 14.0, color: ApTheme.of(context).grey),
                  text: subText,
                ),
              ),
            ],
          ),
        ),
      );
}