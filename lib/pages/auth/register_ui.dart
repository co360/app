import 'package:flutter/material.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/custom_form.dart';
import 'package:riphahwebresources/components/custom_input.dart';
import 'package:riphahwebresources/data/User.dart';
import 'package:riphahwebresources/pages/auth/login_ui.dart';

class RegisterUi extends StatefulWidget {
  @override
  _RegisterUiState createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sapController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User user = User();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: customAppBar(context, "Register"),
        body: _buildBody(context));
  }

  //@override
  //void dispose() {
  // Clean up the controller when the widget is disposed.
  //fieldController.dispose();
  //super.dispose();
  //}

  void onSuccess(context) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Password reset link has been set to your email."),
        action: SnackBarAction(
          label: "Close",
          onPressed: () => {},
        ),
      ),
    );
  }

  void onError(context, err) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(err.message),
        action: SnackBarAction(
          label: "Close",
          onPressed: () => {},
        ),
      ),
    );
  }

  void onSubmit(context) async {
    setState(() => isLoading = true);
    try {
      await user.signup(emailController.text, passwordController.text,
          nameController.text, sapController.text);
      onSuccess(context);
    } catch (err) {
      onError(context, err);
    }
    setState(() {
      emailController.clear();
      passwordController.clear();
      nameController.clear();
      sapController.clear();
    });
    setState(() => isLoading = false);
  }

  Widget _buildBody(BuildContext context) {
    return CustomForm(
        key: _formKey,
        loading: isLoading,
        imagePath: null,
        children: <Widget>[
          CustomInput(
            controller: nameController,
            label: "Name",
            obscureText: false,
          ),
          CustomInput(
            controller: emailController,
            label: "Email",
            obscureText: false,
          ),
          CustomInput(
            controller: sapController,
            label: "SAP",
            obscureText: false,
          ),
          CustomInput(
            controller: passwordController,
            label: "Password",
            obscureText: true,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginUi(),
                    ),
                  )
                },
                child: Text("Back to login?"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.20),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Register"),
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColor,
                onPressed: () => {onSubmit(context)},
              ),
            ),
          ),
        ]);
  }
}
