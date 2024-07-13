import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/components/textfield.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:velocity_x/velocity_x.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});
  static const String id = "/chat";


  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Vx.gray100,
      appBar: CustomBar(
        title: "Chat Page",
        leading: BackButton(color: KBlack),
        actions: [
          SvgPicture.asset("assets/icons/aibot.png", height: 30, width: 35)
        ],
      ),
      body: ListView.separated(
        padding: hpadx,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Card(
                 color: KWhite,
                 elevation: 0,
                 child: Row(
                   children: [
                     Image.asset("assets/icons/aibot.png", height: 30,width: 30), gapW4,
                     Maintext(
                       weight: FontWeight.bold,
                     data: "Dosage cleanup with starter "
                                    ).p4(),
                   ],
                 ),),
               3.heightBox,
               Card(
                 color: KWhite,
                 elevation: 0,
                 child: Maintext(
                     data: "Dosage cleanup with starter Dosage cleanup with starterDosage cleanup with starterDosage cleanup with starter"
                 ).p4(),),

             ]
            );
          },
          separatorBuilder: (context, _) => 10.heightBox,
          itemCount: 8),
      bottomSheet:SizedBox(

        width:size.width ,height: 70, child: Row(children: [
        SizedBox(
          width: size.width*0.6,
          child: CustomTextField(
              ctx: context,
              hint: "Add a follow up",
              inputType: TextInputType.text),
        ),
        gapW8,
        SizedBox(
            width: 150,
            height: 70,

            child: MainButton(action: () {}, text: "Generate"))
      ],).px8(),) ,
    );
  }
}
