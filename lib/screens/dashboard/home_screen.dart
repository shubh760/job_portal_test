import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/models/data_model.dart';
import 'package:job_portal/screens/dashboard/home_screen_controller.dart';
import 'package:job_portal/screens/dashboard/widgets/curve_bottom_sheet.dart';
import 'package:job_portal/screens/dashboard/widgets/job_desc_widget.dart';
import 'package:job_portal/screens/onboarding/onboard_controller.dart';
import 'package:job_portal/utils/string_util.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final authController = Get.put(OnboardingController());
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Container()),
            ListTile(
              onTap: () {
                authController.signOut();
              },
              leading: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: Text(
                "Log Out",
                style: GoogleFonts.poppins(color: Colors.red),
              ),
            )
          ],
        ),
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              icon: Icon(Icons.menu)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.search)),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text("Find your Dream Job today",
                          style: GoogleFonts.karla(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          )),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                // jobBottomSheet(context, controller, index);
                                showCurvedBottomSheet(context, index);
                              },
                              child: JobCard(data: controller.dataList[index]));
                        },
                        itemCount: controller.dataList.length,
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}

class JobCard extends StatelessWidget {
  final GetImageData data;
  const JobCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhysicalModel(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          elevation: 2,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 232, 230, 230)),
                  child: Center(
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(data.thumbnailUrl!),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            extractFirstTwoWords(
                              data.title!,
                            ),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(data.title.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                /* Text(data.albumId.toString(), style: TextStyle(fontSize: 14)),
                  SizedBox(height: 8),
                  Text(data.id.toString(), style: TextStyle(fontSize: 14)), */
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.jobIds.value
                                    .contains(data.id.toString()) ==
                                true
                            ? Colors.green
                            : Colors.deepPurpleAccent),
                    child: Center(
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

void jobBottomSheet(BuildContext context, int index) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    builder: (context) {
      return JobDescWidget(
        index: index,
      );
    },
  );
}
