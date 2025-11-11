import 'package:flutter/material.dart';
import 'package:lamu_salary_app/main.dart';
import 'package:lamu_salary_app/screens/accounts_screen/name_adrees_changeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:lamu_salary_app/screens/name_address_change_screen.dart'; ←本番ではここも有効に

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isDarkMode = false; // bool =　真と偽のみを持つ値

  static final List<Map<String, dynamic>> _accountItems = [
    //dynamicは値の型を自由にしたいときに利用
    {'title': 'ダークモード'},
    {'title': 'ユーザ名・メールアドレス変更', 'screen': const NameAdreesChangescreen()},
    {'title': '2段階認証設定'},
    {'title': '通知'},
    {'title': '言語設定'},
    {'title': '支払い口座情報'},
    {'title': 'ログアウト'},
  ];

  //ダークモードの状態を保持==============================================

  //画面が表示される最初の1回だけ動く
  @override
  void initState() {
    super.initState();
    _loadTheme(); // 保存されてた設定を読み込み
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance(); //少し待つ処理
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }
  //==============================================================

  @override
  Widget build(BuildContext context) {
    final appState = MyApp.of(context); //上位MyAppクラスから今のアプリ全体の状態をもらってくる

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        //リストを呼び起こす
        child: ListView.builder(
          itemCount: _accountItems.length,
          itemBuilder: (context, index) {
            final item = _accountItems[index];
            final title = item['title'];
            // 「ダークモード」だけ特別にSwitch付きで表示
            if (title == 'ダークモード') {
              return ListTile(
                title: Text(title, style: GoogleFonts.notoSansJp(fontSize: 16)),
                trailing: Switch(
                  //(on/off)できるスイッチ
                  value: appState!.isDarkMode, //スイッチの(on/off)を決める
                  onChanged: (value) {
                    appState.toggleTheme(value); //上位valueのテーマを持ってくる
                  },
                ),
              );
            }

            // 通常項目（タップで画面遷移 or 未設定）
            return ListTile(
              title: Text(title, style: GoogleFonts.notoSansJp(fontSize: 16)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                if (title == 'ログアウト') {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      //AlertDialogのほかにも種類ある
                      title: const Text('ログアウト確認'),
                      content: const Text('本当にログアウトしますか？'),
                      backgroundColor: Colors.white,
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text(
                            'いいえ',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            'はい',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (shouldLogout ?? false) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('employeeCode');
                    await prefs.remove('password');
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                } else if (item['screen'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => item['screen']),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('$title はまだ未設定です')));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
