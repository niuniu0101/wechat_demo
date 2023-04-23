import 'package:flutter/material.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "聊不聊鸭",
      home: Fun(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 好友列表页面
class Fun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('好友列表'),
        centerTitle: true,

      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // 跳转到聊天页面
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage()),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                //child: Text('$index'),
                child: Image.network("https://th.bing.com/th/id/R.b2e918c27d7c87f933524a567948c4a4?rik=KzCM4e4CQyYllw&riu=http%3a%2f%2fpic.ntimg.cn%2f20110116%2f6614812_161513252000_2.jpg&ehk=CucnumxpTzAZWP44nihTq%2b3%2b4NEY%2f0aTD6vyFyntpnA%3d&risl=&pid=ImgRaw&r=0"),
              ),
              title: Text('好友 $index'),
              subtitle: Text('最近的消息鸭'),
            ),
          );
        },
      ),
    );
  }
}

// 聊天页面
class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textEditingController = TextEditingController();
  final List<String> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('好友 1'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                // 判断消息是否来自当前用户
                final isMe = index % 2 == 0;
                return Container(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue : Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: isMe ? Radius.circular(20) : Radius.circular(0),
                        bottomRight: isMe ? Radius.circular(0) : Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      _messages[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '输入消息',
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // 发送消息
                  final text = _textEditingController.text;
                  setState(() {
                    _messages.add(text);
                  });
                  _textEditingController.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}