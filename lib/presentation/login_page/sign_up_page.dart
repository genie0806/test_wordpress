import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:virtue_test/data/data_source/remote/create_user.dart';
import 'package:virtue_test/domain/model/create_user_model/user_model.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isApiCallProcess = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  UserModel model = UserModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormHelper.inputFieldWidget(
                      context,
                      const Icon(Icons.verified_user),
                      "Email",
                      "Email", (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'Email을 입력해주세요';
                    }
                    return null;
                  }, (onSavedVal) {
                    model.email = onSavedVal;
                  }, initialValue: "", paddingBottom: 20),
                  FormHelper.inputFieldWidget(
                      context,
                      const Icon(Icons.verified_user),
                      "Password",
                      "Password",
                      (onValidateVal) {
                        if (onValidateVal.isEmpty) {
                          return 'Password를 입력해주세요';
                        }
                        return null;
                      },
                      (onSavedVal) {
                        model.password = onSavedVal;
                      },
                      initialValue: "",
                      paddingBottom: 20,
                      obscureText: hidePassword,
                      suffixIcon: IconButton(
                          color: Colors.redAccent.withOpacity(.4),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      onChange: (val) {
                        model.password = val;
                      }),
                  FormHelper.inputFieldWidget(
                      context,
                      const Icon(Icons.verified_user),
                      "Confirm Password",
                      "Confirm Password",
                      (onValidateVal) {
                        if (onValidateVal.isEmpty) {
                          return 'Confirm Password 입력해주세요';
                        }

                        if (model.password != model.confirmPassword) {
                          return 'Password 가 옳지 않습니다.';
                        }
                        return null;
                      },
                      (onSavedVal) {},
                      initialValue: "",
                      paddingBottom: 20,
                      obscureText: hideConfirmPassword,
                      suffixIcon: IconButton(
                          color: Colors.redAccent.withOpacity(.4),
                          onPressed: () {
                            setState(() {
                              hideConfirmPassword = !hideConfirmPassword;
                            });
                          },
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      onChange: (val) {
                        model.confirmPassword = val;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: FormHelper.submitButton(
                      "Register",
                      () {
                        if (validateAndSave()) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          CreateUserAPi.registerUser(model)
                              .then((UserResponseModel responseModel) {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            if (responseModel.code == 200) {
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  "Virtue Register",
                                  responseModel.message ?? '',
                                  "OK", () {
                                Navigator.of(context).pop();
                              });
                            }
                          });
                        }
                      },
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
