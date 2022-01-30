import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:textformfield_example/widget/button_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Registration Form';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primaryColor: Colors.red),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final formKey = GlobalKey<FormState>();
  String Username = '';
  String Password = '';
  String Mobile_Number = '';
  String Email = '';
  String URL = '';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              buildUsername(),
              const SizedBox(height: 16),
              buildPassword(),
              const SizedBox(height: 16),
              buildMobile_Number(),
              const SizedBox(height: 16),
              buildEmail(),
              const SizedBox(height: 16),
              buildURL(),
              const SizedBox(height: 16),
              buildSubmit(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      );

  Widget buildUsername() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Username',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        maxLength: 30,
        onSaved: (value) => setState(() => Username = value),
      );

  Widget buildPassword() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 7) {
            return 'Password must be at least 7 characters long';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => Password = value),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
      );

  Widget buildMobile_Number() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Mobile Number',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 10) {
            return 'Enter at least 10 characters';
          } else {
            return null;
          }
        },
        // maxLength: 30,
        //onSaved: (value) => setState(() => Mobile_Number = value),
      );

  Widget buildEmail() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);

          if (value.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => setState(() => Email = value),
      );

  Widget buildURL() => TextFormField(
        decoration: InputDecoration(
          labelText: 'URL',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          final pattern =
              r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
          final regExp = RegExp(pattern);

          if (value.length == 0) {
            return 'Please enter url';
          } else if (!regExp.hasMatch(value)) {
            return 'Please enter valid url';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => setState(() => Email = value),
      );

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Submit',
          onClicked: () {
            final isValid = formKey.currentState.validate();
            // FocusScope.of(context).unfocus();

            if (isValid) {
              formKey.currentState.save();

              final message =
                  'Username: $Username\nPassword: $Password\nMobile Number: $Mobile_Number'
                  '\nEmail: $Email\nURL:$URL';
              final snackBar = SnackBar(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
      );
}
