import 'package:bazarmilo/views/pages/login/components/displayprompt.dart';
import 'package:flutter/material.dart';

class forgotPassword extends StatelessWidget {
  const forgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 15, top: 10),
                    child: InkWell(
                      onTap: () {
                        displayPrompt(context, "Forgot Password?",
                            "Please contact the admin.");
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Color(0xffFF8D83),
                            fontSize: 17.25,
                            fontFamily: 'Arbutus Slab'),
                      ),
                    ),
                  ),
                ),
              ],
            );
  }
}