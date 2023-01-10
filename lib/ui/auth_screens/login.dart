import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../components/custom_title.dart';
import '../../route_generator.dart';
import '../../theme/colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String? _dialCode = '+91';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 40,
          child: Column(
            children: const [
              Text('By continuing, you agree to our',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.white)),
              Text('Terms & service and privacy policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.white))
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Stack(fit: StackFit.passthrough, children: [
                      Center(child: Image.asset('assets/login.png')),
                    ]),
                  ),
                  const CustomTitle(text: 'Log in or Sign up'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 5, top: 2, bottom: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white.withOpacity(0.1)),
                        child: CountryCodePicker(
                          onChanged: (CountryCode countryCode) {
                            _dialCode = countryCode.dialCode;
                          },
                          dialogBackgroundColor: CustomColors.dark,

                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: '+91',

                          favorite: const ['+91', 'IN'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: false,
                          // optional. aligns the flag and the Text left
                          alignLeft: false,

                          flagDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Form(
                        key: _formKey,
                        child: Flexible(
                            child: Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: CustomTextField(
                            borderRadius: 30,
                            hint: "Enter Mobile Number",
                            keyboardType: TextInputType.number,
                            controller: _phoneNumberController,
                            style: const TextStyle(color: Colors.white),
                            onChanged: (value) {},
                            validator: (number) {
                              if (number == null ||
                                  number.isEmpty ||
                                  number.length != 10) {
                                return "Enter Correct Mobile Number";
                              }
                              return null;
                            },
                          ),
                        )),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                          text: 'Continue',
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, RouteName.otp,
                                  arguments: [
                                    _dialCode,
                                    _phoneNumberController.text,
                                    false
                                  ]);
                            }
                          },
                          color: HexColor('F37F20'),
                          width: double.maxFinite,
                          height: 43)
                      .use(),
                ],
              ),
            ),
          ),
        ));
  }
}
