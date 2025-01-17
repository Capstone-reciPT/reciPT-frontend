import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:recipt/Controller/LoginController.dart';
import 'package:recipt/Server/login/SignUpServer.dart';
import 'package:recipt/View/login/Sign_up_screen.dart';
import 'package:recipt/Widget/Custom_Text_Form_field.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';

import '../../Server/login/LoginServer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final LoginController lc = Get.put(LoginController());

  // 비밀번호 표시
  bool obscure = true;
  var _email;
  var _pw;
  // textfield 키
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('안녕하세요!',style: Theme.of(context).textTheme.displayLarge,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('ReciPT 입니다.',style: Theme.of(context).textTheme.bodyLarge,),
                        ),
                        CustomTextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                              return '이메일 형식으로 입력해주세요';
                            // } else if (!value.isEmail){
                            //   return '이메일 형식으로 입력해주세요';
                            } else{
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                            hint: '이메일',
                            prefixIcon: IconlyBroken.message,
                        ),
                        CustomTextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                              return '비밀번호를 입력해주세요';
                            } else{
                              return null;
                            }
                          },
                          obscureText: obscure,
                          hint: '비밀번호',
                          prefixIcon: IconlyBroken.lock,
                          suffixIcon: obscure== true
                              ? IconlyBroken.show
                              : IconlyBroken.hide,
                          onTapSuffixIcon: (){
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _pw = value;
                            });
                          },
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Text('비밀번호를 잊었다면?',style: Theme.of(context).textTheme.bodyMedium,)
                        //   ],
                        // )
                      ],
                    ),
                  )),
                  Obx(() => Container(
                    margin: EdgeInsets.only(top: 30),
                      child: Text(lc.failMessage.value,style: Theme.of(context).textTheme.displayLarge,))),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        onTap: () async {
                          if (key.currentState!.validate()){
                            var code = await loginFunc(_email,_pw);
                            if (code == 200){
                              Get.offAll(MyApp());
                            } else if (code == 400){
                              lc.failMessage.value = "존재하지 않는 사용자입니다.";
                            } else{
                              lc.failMessage.value = "비밀번호가 맞지 않습니다.";
                            }
                          }
                        },
                        text: '로그인',color: Colors.black,
                      ),
                      // Text('또는',
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .bodyMedium!
                      //       .copyWith(color: SecondaryText),
                      // ),
                      // CustomButton(onTap: (){}, text: 'G google',color: Secondary,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('계정이 없다면?',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: mainText)),
                          TextButton(
                            onPressed: (){
                              Get.to(SignUpScreen());
                            },
                            child: Text('회원가입',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: primary)),
                          ),
                        ],
                      )
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
