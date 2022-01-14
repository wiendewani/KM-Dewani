import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_suitmedia_application/providers/UsersProvider.dart';
import 'package:test_suitmedia_application/theme/theme.dart';
import 'package:test_suitmedia_application/view/SecondScreenPage.dart';

class ThirdScreenPage extends StatefulWidget {
  @override
  State<ThirdScreenPage> createState() => _ThirdScreenPageState();
}

class _ThirdScreenPageState extends State<ThirdScreenPage> {
  @override
  Widget build(BuildContext context) {
    navigateTo(context, target) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => target,
        ),
      );
    }

    PreferredSizeWidget appBar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          // systemOverlayStyle: const SystemUiOverlayStyle(
          //   // Navigation bar
          //   statusBarColor: Colors.white, // Status bar
          // ),
          backgroundColor: bgColor,
          elevation: 0.3,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/Back_press_area.png')),
          centerTitle: true,
          title: Text(
            'Third Screen',
            style:
            primaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
        ),
      );
    }

    Widget userTile(
        {required String linkProfile, @required first_name, @required last_name, @required email}) {
      return GestureDetector(
        onTap: () {
          navigateTo(context,SecondScreenPage(isName: true,nameUser: "$first_name $last_name"));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(linkProfile),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(
                    "$first_name $last_name",
                    style: primaryTextStyle.copyWith(
                        fontWeight: medium, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    email,
                    style: secondTextStyle.copyWith(
                        fontWeight: medium, fontSize: 10),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(),
      body: FutureBuilder(
        future: Future.wait(
            [Provider.of<UsersProvider>(context, listen: false).getUser()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Consumer<UsersProvider>(builder: (context, dataUser, _) {
            return Container(
              margin:
              const EdgeInsets.only(right: defaultMargin, left: defaultMargin),
              child: ListView.separated(
                itemCount: dataUser.responseUser.data!.length,
                itemBuilder: (context, index) {
                  return userTile(
                    linkProfile: dataUser.responseUser.data![index].avatar
                        .toString(),
                    first_name: dataUser.responseUser.data![index].firstName,
                    last_name: dataUser.responseUser.data![index].lastName,
                    email: dataUser.responseUser.data![index].email,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            );
          });
        },
      ),
    );
  }
}
