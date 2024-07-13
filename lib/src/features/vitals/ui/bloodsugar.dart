import 'package:flutter/material.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:velocity_x/velocity_x.dart';

class Bloodsugar extends StatelessWidget {
  const Bloodsugar({super.key});
  static const String id = "/bloodsugar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBar(
        autolead: true,
        leading: BackButton(
          color: KBlack,
        ),
        title: "Blood Sugar Record",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: Headtext(data: "Add new record",color: KWhite),backgroundColor: KPrimary,),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
              padding: hpadx,
              sliver: SliverList.separated(
                
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side:const BorderSide(width: 0.5, color: KGrey),
                        borderRadius: BorderRadius.circular(15)),
                    clipBehavior: Clip.antiAlias,
                    child: ExpansionTile(

                        childrenPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        expandedAlignment: Alignment.centerLeft,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        leading: Icon(Icons.alarm, size: 25,color: KPrimary),
                        title: Maintext(
                          data: "13:49 pm after breakfast.",
                          fontsize: 14,

                        ),
                        subtitle: Headtext(data: "34.5 mg/l",),
                        children: [
                          Maintext(data: "Blood glucose (mg/l)", color: KGrey),
                          Headtext(
                            data: "19.3",
                          ),
                          10.heightBox,
                          Maintext(
                              data: "Food/carbohydrate intake", color: KGrey),
                          Headtext(
                            data: "rice with stew",
                          ),
                          10.heightBox,
                          Maintext(data: "Medication", color: KGrey),
                          Headtext(
                            data: "Paracetamol",
                          ),
                          10.heightBox,
                          Maintext(data: "Exercise/Activity", color: KGrey),
                          Headtext(
                            data: "Jump squats",
                          ),
                          10.heightBox,
                          Maintext(data: "Comments/Notes", color: KGrey),
                          Headtext(

                            data:
                                "I felt a bit dizzy after my 3rd set of jumpsquats.",
                          ),
                          10.heightBox,
                          const Divider(height: 0),
                          20.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () {},
                                label:
                                    Maintext(data: "Edit", color: Vx.green500),
                                icon: Icon(Icons.edit, color: Vx.green500),
                              )
,
                              TextButton.icon(
                                onPressed: () {},
                                label:
                                Maintext(data: "Delete", color: Vx.red500),
                                icon: Icon(Icons.delete, color: Vx.red500),
                              )
                            ],
                          )
                        ]),
                  );
                },
                separatorBuilder: (context, child) {
                  return gapH8;
                },
              )),
          50.heightBox.sliverToBoxAdapter()

        ],
      ),
    );
  }
}
