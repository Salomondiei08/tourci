import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../helpers/authservice.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Tour',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: AppTheme.orange, fontSize: 33),
                        children: [
                      TextSpan(
                        text: 'CI',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: AppTheme.green, fontSize: 33),
                      ),
                    ])),
                InkWell(
                  onTap: () async {
                    await AuthService().signOut();
                    Navigator.of(context).pushReplacementNamed('/login_screen');
                  },
                  child: googleUser?.photoURL != null
                      ? CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(googleUser!.photoURL!),
                        )
                      : const Icon(
                          Icons.person,
                        ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "PROFILE",
              style:
                  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 25),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            height: 45.h,
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                AssistanceItem(text: "Infos", iconData: Icons.share),
                AssistanceItem(
                  text: "Se déconnecter",
                  iconData: Icons.person_outline,
                ),

                AssistanceItem(
                  text: "En Savoir Plus",
                  iconData: Icons.info_outline,
                ),
                // AssistanceItem(
                //   text: "Parler avec un spécialiste",
                //   iconData: AppIcon.chat,
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => RoomsPage(),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AssistanceItem extends StatelessWidget {
  final String text;

  final IconData iconData;

  void Function()? onPressed;

  AssistanceItem(
      {Key? key, required this.text, required this.iconData, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
      child: ListTile(
        title: Text(text),
        leading: Icon(
          iconData,
          color: AppTheme.green,
        ),
        onTap: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: AppTheme.darkGray,
      ),
    );
  }
}
