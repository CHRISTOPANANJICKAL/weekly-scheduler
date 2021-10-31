import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler/Providers/buttons_provider.dart';
import 'package:scheduler/Screens/SchedulingPage/scheduling_page.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    context.read<ButtonsProvider>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scheduler"),
      ),
        body: Center(
      child: (context.watch<ButtonsProvider>().dataLoaded)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hii Jose,",style: GoogleFonts.hennyPenny(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
                Text(context.watch<ButtonsProvider>().textViewText,textAlign: TextAlign.center,),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SchedulingPage()));
                  },
                  child: Text(context.watch<ButtonsProvider>().buttonText,style: const TextStyle(color: Colors.white),),
                )
              ],
            )
          : (context.watch<ButtonsProvider>().dataLoading)
              ? const SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                )
              : Text(context.read<ButtonsProvider>().getError()),
    ));
  }
}
