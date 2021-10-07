import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/form_submit_button.dart';
import 'package:time_tracker/services/auth.dart';

enum EmailSignInFormType { sigIn, register }

class EmailSingInForm extends StatefulWidget {
  const EmailSingInForm({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _EmailSingInFormState createState() => _EmailSingInFormState();
}

class _EmailSingInFormState extends State<EmailSingInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.sigIn;
  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.sigIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.sigIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.sigIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.sigIn
        ? "Sing In"
        : "Create an account";
    final secondaryText = _formType == EmailSignInFormType.sigIn
        ? "Don't have an account? Resgister"
        : "Have an account? Sign In";
    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
        ),
      ),
      SizedBox(height: 8.0),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(height: 8.0),
      FormSubmitButton(
        onPressed: _submit,
        text: primaryText,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        onPressed: _toggleFormType,
        child: Text(secondaryText),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
