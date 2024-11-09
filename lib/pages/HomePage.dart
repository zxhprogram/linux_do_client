import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linux_do/main.dart';
import 'package:linux_do/pages/ItemListPage.dart';

class HomePage extends StatelessWidget {
  final Widget secondPart;

  HomePage({super.key, required this.secondPart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationBar(),
          Expanded(child: secondPart),
        ],
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: 0.5,
          fit: BoxFit.fitHeight,
          image: NetworkImage(
              'https://linux.do/user_avatar/linux.do/ggsmida/100/155194_2.png'),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              'https://linux.do/user_avatar/linux.do/ggsmida/50/155194_2.png',
              height: 45,
              width: 45,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {}, icon: Icon(AntDesign.account_book_fill)),
              IconButton(onPressed: () {}, icon: Icon(AntDesign.aim_outline)),
              IconButton(onPressed: () {}, icon: Icon(AntDesign.team_outline)),
              IconButton(onPressed: () {}, icon: Icon(AntDesign.team_outline)),
              IconButton(
                  onPressed: () {}, icon: Icon(AntDesign.aliwangwang_fill)),
              IconButton(onPressed: () {}, icon: Icon(AntDesign.audio_fill)),
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(AntDesign.setting_fill)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class SecondNavigationPart extends StatelessWidget {
  final Widget child;

  SecondNavigationPart(this.child);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 400,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          // child: ItemListPage(),
          child: ItemListPage(),
        ),
        Expanded(child: child)
      ],
    );
  }
}

class ThirdNavigationPart extends StatelessWidget {
  final Widget child;

  ThirdNavigationPart(this.child);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.cyanAccent,
          width: 400,
          // child: ItemListPage(),
          child: Page2(),
        ),
        Expanded(child: child)
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              context.go('/page2');
            },
            child: Text('child page1')),
        ElevatedButton(
            onPressed: () {
              context.go('/childPage2');
            },
            child: Text('child page2')),
      ],
    );
  }
}

// class Page1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//             onPressed: () {
//               context.go('/');
//             },
//             child: Text('child page1')),
//         ElevatedButton(
//             onPressed: () {
//               context.go('/childPage1');
//             },
//             child: Text('child page2')),
//       ],
//     );
//   }
// }
