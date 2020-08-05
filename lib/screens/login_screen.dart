
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:smart_plate/constants.dart';
import 'package:smart_plate/models/user_model.dart';
import 'package:smart_plate/screens/main_app_screen.dart';
import 'package:smart_plate/utilities/network.dart';
import 'package:smart_plate/utilities/server_handler.dart';
import 'package:smart_plate/utilities/shared_data.dart';
import 'package:smart_plate/widgets/custom_button.dart';
import 'package:smart_plate/widgets/text_field.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var email='', password='';
  bool isActive = false;

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<SharedData>(context);

    return ModalProgressHUD(
      inAsyncCall: isActive,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: CupertinoPageScaffold(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image(image: AssetImage('images/logo.png'), height: 150,),
                  CustomTextField(
                    label: 'Email Address',
                    enable: true,
                    onChange: (value){
                      email = value;
                    },
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    label: 'Password',
                    enable: true,
                    onChange: (value){
                      password = value;
                    },
                  ),
                  SizedBox(height: 20,),
                  CustomButton(onTap: () async{

                    setState(() {
                      isActive = true;
                    });

                    if(email == "" || password == '')
                      {
                        Fluttertoast.showToast(
                          msg: 'Please Fill All Data First',
                          fontSize: 24,
                          backgroundColor: Colors.red,
                          gravity: ToastGravity.CENTER,
                          textColor: Colors.white,
                          toastLength: Toast.LENGTH_LONG,

                        );
                        setState(() {
                          isActive = false;
                        });
                      }

                    else
                      {
                        NetworkHelper helper = NetworkHelper();
                        var response = await helper.getData(SERVER_LINK+ "?email=$email&password=$password");

                        try
                        {
                          User user = User();
                          user.userId = response[0]['user_id'];
                          user.userName = response[0]['user_name'];
                          user.userPassword = response[0]['user_password'];
                          user.userImage = response[0]['user_image'];
                          user.userEmail = response[0]['email'];
                          user.userGender = response[0]['user_gender'];
                          user.userAge = response[0]['user_age'];
                          user.userHeight = response[0]['user_height'];
                          user.userWeight = response[0]['user_weight'];
                          user.userDoctorNotes = response[0]['doctor_notes'];
                          user.calories = response[0]['calories'];
                          user.bodyMassIndex = response[0]['body_mass_index'];
                          user.basalMetabolicRate = response[0]['basal_metabolic_rate'];
                          user.bodyFatPercentage = response[0]['body_fat_persentage'];
                          user.leanBodyMass = response[0]['lean_body_mass'];
                          user.proteinInGrams = response[0]['protien_in_grams'];
                          user.carbInGrams = response[0]['carbs_in_grams'];
                          user.fatInGrams = response[0]['fat_in_grams'];

                          ServerHandler(context: context).getPosts();

                          provider.addToUser(user);

                          setState(() {
                            isActive = false;
                          });

                        }catch(e)
                        {
                          setState(() {
                            isActive = false;
                          });

                          Fluttertoast.showToast(
                            msg: 'Wrong User Name Or Password',
                            fontSize: 24,
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                      }


                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
