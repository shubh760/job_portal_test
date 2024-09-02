import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/models/data_model.dart';
import 'package:job_portal/screens/dashboard/home_screen_controller.dart';
import 'package:job_portal/utils/string_util.dart';

class JobDescWidget extends StatelessWidget {
  final int index;
  const JobDescWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeScreenController());
    GetImageData data = controller.dataList[index];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.6,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              extractFirstTwoWords(
                data.title!,
              ),
              style: GoogleFonts.poppins(fontSize: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              '''Lorem Ipsum is simply dummy, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum''',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(
              height: 40,
            ),
            controller.jobIds.value.contains(data.id.toString()) == true
                ? ElevatedButton(
                    onPressed: () {},
                    child: const Center(
                      child: Text(
                        "Applied",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 201, 241, 203),
                        shadowColor: Colors.grey))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        shadowColor: Colors.deepPurpleAccent),
                    onPressed: () {
                      controller.jobIds.value.add(data.id.toString());

                      controller
                          .storeJobIdsInFirestore(controller.jobIds.value)
                          .then((val) => Navigator.pop(context));
                    },
                    child: const Center(
                      child: Text(
                        "Apply",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
