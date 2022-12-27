import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'animations.dart';
import 'message.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  String name = 'Like';
  String svgName = 'like_button';
  int color = 0xff4a85d3;
  bool buttonPressed = false;
  bool longPressed = false;
  bool selected = false;
  bool isLikeHover = false; //for windows
  bool isLoveHover = false; //for windows
  bool isAngryHover = false; //for windows
  String animatedSvgName = '';
  bool isAnimationSelected = false;
  bool message = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3E3E3),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: buildMain(context),
      ),
    );
  }

  buildMain(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            longPressed == false
                ?  SizedBox(height: (height*0.42) + 50)
                :  SizedBox(height: height*0.42),
            reactionWidget(),
            const SizedBox(height: 10),
            likeCommentShareWidget(context),
             SizedBox(height: height*0.3),
            message == true ? buildMessage() : Container()
          ],
        ),
        isAnimationSelected
            ? Animations(reactionName: animatedSvgName)
            : Container(),
        const SizedBox(height: 10),
      ],
    );
  }

  reactionWidget() {
    return longPressed
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120),
              color: Colors.white,
            ),
            width: 150,
            height: 50,
            child: reactionWidgetsRow(),
          )
        : Container();
  }

  reactionWidgetsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //For Desktops Only
        MouseRegion(
          onEnter: (f) {
            setState(() {
              isLikeHover = true;
            });
          },
          onExit: (f) {
            setState(() {
              isLikeHover = false;
            });
          },
          child: reaction(
              'Like', 'like_reaction', 'like_button', 0xff4A85D3, isLikeHover),
        ),
        MouseRegion(
          onEnter: (f) {
            setState(() {
              isLoveHover = true;
            });
          },
          onExit: (f) {
            setState(() {
              isLoveHover = false;
            });
          },
          child: reaction(
              'Love', 'love_reaction', 'heart_button', 0xffF94343, isLoveHover),
        ),
        MouseRegion(
            onEnter: (f) {
              setState(() {
                isAngryHover = true;
              });
            },
            onExit: (f) {
              setState(() {
                isAngryHover = false;
              });
            },
            child: InkWell(
              onTap: () {},
              child: reaction('Angry', 'angry_reaction', 'angry_button',
                  0xffF16D24, isAngryHover),
            )),
      ],
    );
  }

  reaction(String reactionName, String gifName, String svgImageName,
      int colorCode, bool hover) {
    return InkWell(
      onTap: () {
        setState(() {
          isAnimationSelected = true;
          name = reactionName;
          svgName = svgImageName;
          color = colorCode;
          selected = true;
          buttonPressed = true;
          animatedSvgName = svgImageName;
          longPressed = !longPressed;
          message = true;
        });
      },
      child: Image(
        image: AssetImage('assets/svg/$gifName.gif'),
        width: hover ? 60 : 50,
        // fit: BoxFit.contain,
      ),
    );
  }



  likeCommentShareWidget(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 28,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFFFFFFF)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          likeButton(),
          customButton(iconName: 'comment_icon', text: 'Comment'),
          customButton(iconName: 'share_icon', text: 'Share'),
        ],
      ),
    );
  }

  likeButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          buttonPressed = !buttonPressed;
          selected = false;
        });
      },
      onLongPress: () {
        setState(() {
          longPressed = !longPressed;
        });
      },
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
      child: likeButtonLogic(),
    );
  }

  likeButtonLogic() {
    if (buttonPressed == true && selected == false) {
      return customButton(
          iconName: "like_button", text: "Like", color: 0xff4a85d3);
    } else if (buttonPressed == false && selected == false) {
      return customButton(
          iconName: "like_icon", text: "Like", color: 0xff000000);
    } else if (buttonPressed == true && selected == true) {
      return customButton(iconName: svgName, text: name, color: color);
    } else if (buttonPressed == false && selected == true) {
      return customButton(iconName: svgName, text: name, color: color);
    } else {
      return customButton(
          iconName: "like_icon", text: "Like", color: 0xff000000);
    }
  }
}
