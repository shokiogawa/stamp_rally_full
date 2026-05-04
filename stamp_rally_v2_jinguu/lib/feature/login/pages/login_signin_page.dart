import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/component/text_form_field_decoration.dart';
import 'package:stamp_rally_v2_fvm/core/router/router.dart';
import 'package:stamp_rally_v2_fvm/core/usecase/auth/auth_use_case.dart';
import 'package:stamp_rally_v2_fvm/core/utility/logger.dart';
import 'package:stamp_rally_v2_fvm/feature/login/provider/trigger_login_signin_provider.dart';

import '../../../core/component/button_style.dart';
import '../../../core/usecase/auth/check_login_status_use_case.dart';

class LoginSignInPage extends HookConsumerWidget {
  const LoginSignInPage({super.key});

  // ページをスタック
  static void push(BuildContext context) {
    const LoginSignInPageRoute().go(context);
  }

  // ページを置き換え
  static void go(BuildContext context) {
    const LoginSignInPageRoute().go(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(checkLoginStatusUseCaseProvider, (previous, next) {
      switch (next) {
        case AsyncData(:final value):
          logger.i(value.event);
      }
    });
    final isLoginPage = ref.watch(triggerLoginSignInProvider);
    return Scaffold(
      body: isLoginPage ? const _LoginWidget() : const _SignInWidget(),
    );
  }
}

class _LoginWidget extends HookConsumerWidget {
  const _LoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final pageTriggerNotifier = ref.watch(triggerLoginSignInProvider.notifier);
    return LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ログイン',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 27),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // メールアドレス
                              const Text(
                                'メールアドレス',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'メールアドレスを入力してください。';
                                  }
                                  return null;
                                },
                                decoration: TextFormFieldDecoration.email(),
                                controller: emailController,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // パスワード
                              const Text(
                                'パスワード',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'パスワードを入力してください。';
                                  }
                                  return null;
                                },
                                decoration: TextFormFieldDecoration.normal(),
                                controller: passwordController,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          )),
                      ElevatedButton(
                          style: ButtonStyles.normal(),
                          onPressed: () async {
                            await ref
                                .read(authUseCaseProvider.notifier)
                                .signInAnonymously();
                            if (context.mounted) {
                              // const WorkspaceListPageRoute()
                              //     .pushReplacement(context);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              '匿名ログイン',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          style: ButtonStyles.normal(),
                          onPressed: () async {
                            await ref.read(authUseCaseProvider.notifier).login(
                                passwordController.text, emailController.text);
                            if (context.mounted) {
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'ログイン',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          onTap: pageTriggerNotifier.showSignInPage,
                          child: const Text('アカウントをお持ちでない方',
                              style: TextStyle(color: Colors.blue)))
                    ],
                  ),
                ),
              ),
            ));
  }
}

class _SignInWidget extends HookConsumerWidget {
  const _SignInWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final nameController = useTextEditingController();
    final pageTriggerNotifier = ref.watch(triggerLoginSignInProvider.notifier);
    return LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ユーザー登録',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 27),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'お名前',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // お名前
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'お名前を入力してください。';
                                  }
                                  return null;
                                },
                                decoration: TextFormFieldDecoration.normal(),
                                controller: nameController,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // メールアドレス
                              const Text(
                                'メールアドレス',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // メールアドレス
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'メールアドレスを入力してください。';
                                  }
                                  return null;
                                },
                                decoration: TextFormFieldDecoration.email(),
                                controller: emailController,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // パスワード
                              const Text(
                                'パスワード',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // パスワード
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'パスワードを入力してください。';
                                  }
                                  return null;
                                },
                                decoration: TextFormFieldDecoration.normal(),
                                controller: passwordController,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  style: ButtonStyles.normal(),
                                  onPressed: () async {
                                    await ref
                                        .read(authUseCaseProvider.notifier)
                                        .signIn(
                                            nameController.text,
                                            passwordController.text,
                                            emailController.text);
                                    if (context.mounted) {}
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      'ユーザー登録',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          )),
                      GestureDetector(
                          onTap: pageTriggerNotifier.showLoginPage,
                          child: const Text('アカウントをお持ちの方',
                              style: TextStyle(color: Colors.blue)))
                    ],
                  ),
                ),
              ),
            ));
  }
}
