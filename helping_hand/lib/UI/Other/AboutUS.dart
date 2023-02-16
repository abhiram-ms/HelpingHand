import 'package:flutter/material.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(padding: const EdgeInsets.all(16),
          child: Column(
            children:  [
              Text(
                "About US",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 20,),
              const Text("At HelpingHand, we believe that everyone deserves to feel safe and secure in their daily lives. That's why we've created a public safety application that empowers individuals to take control of their safety, no matter where they are or what they're doing"),
              const SizedBox(height: 20),
              const Text("Our mission is simple: to provide peace of mind and a helping hand in emergency situations. Whether you're out for a run, walking home late at night, or traveling in a new city, HelpingHand gives you the tools you need to stay safe and get help quickly."),
              const SizedBox(height: 20),
              const Text("With a single tap, you can alert trusted contacts that you need help and send them your location. Our advanced GPS technology allows your contacts to track your movements in real-time, giving them the information they need to provide assistance or call for help if necessary."),
              const SizedBox(height: 20),
              const Text("In addition to our real-time tracking feature, HelpingHand also includes a variety of safety tools, such as a safety timer, safety check-ins, and a personal safety network. With these tools, you can set up custom alerts and notifications to keep yourself and your loved ones informed and protected."),
              const SizedBox(height: 20),
              const Text("We believe that technology has the power to make a positive impact on people's lives, and we're committed to using it to improve public safety. At HelpingHand, we're dedicated to providing our users with the tools they need to stay safe, no matter where they are or what they're doing."),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width/3,
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset('assets/undraw/profilepicture.png',
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 12,),
                        const Text('Tanmay Parab'),
                        const SizedBox(height: 12,),
                        const Text('tanmay.parab26@gmail.com'),
                        const SizedBox(height: 12,),
                        const Text('+91 9137956710'),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width/3,
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset('assets/undraw/profilepicture.png',
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 12,),
                        const Text('Sakshi Rokade'),
                        const SizedBox(height: 12,),
                        const Text('sakshirokade0528@gmail.com'),
                        const SizedBox(height: 12,),
                        const Text('+91 9967092644'),
                      ],
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
