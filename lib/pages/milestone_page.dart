import 'package:flutter/material.dart';
import 'package:tinyhood/widgets/milestone_image.dart';

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            leading: IconButton(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Theme.of(context).colorScheme.onPrimaryContainer,
              tabs: const [
                Tab(text: "0-3 months"),
                Tab(text: "4-12 months"),
                Tab(text: "13 months - 3 years"),
                Tab(text: "3-5 years"),
              ],
            ),
            title: Text(
              'Mile Stones',
              style: TextStyle(
                  fontFamily: "Lexend",
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          body: TabBarView(
            children: [
              NewbornDevelopmentScreen(),
              BabiesDevelopmentScreen(),
              NewbornDevelopmentScreen(),
              NewbornDevelopmentScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class NewbornDevelopmentScreen extends StatelessWidget {
  final List<Map<String, String>> _data = [
    {
      'title': 'Newborn development at 0-1 month',
      'content':
          'Newborn development at 0-1 month is about cuddling, sleeping, feeding and learning. Get tips for baby development and read how to spot developmental delay.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0022/48019/baby-development-1-month.jpg"
    },
    {
      'title': 'Newborn development at 1-2 months',
      'content':
          'Extra crying is typical in newborn development at 1-2 months, as is more alertness. Get tips to help development and read how to spot developmental delay.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0015/48021/baby-development-2-months.jpg"
    },
    {
      'title': 'Newborn development at 2-3 months',
      'content':
          'At 2-3 months of newborn development, your baby understands that voices and faces go together – especially yours! Read more and get tips for development.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0017/48023/baby-development-3-months.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 8,
          child: ExpansionTile(
            title: Text(_data[index]['title']!),
            children: [
              MyImageLoader(imageUrl: _data[index]['image']!),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _data[index]['content']!,
                  style: TextStyle(
                    fontFamily: "Lexend",
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class BabiesDevelopmentScreen extends StatelessWidget {
  final List<Map<String, String>> _data = [
    {
      'title': '3-4 months: baby development',
      'content':
          'At 3-4 months in baby development, your baby is learning about emotions and communication. Read more about what your baby might be doing and how to help.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0019/48025/3-4-months.jpg"
    },
    {
      'title': '4-5 months: baby development',
      'content':
          'Baby development at 4-5 months is about blowing raspberries, grabbing things and bonding to you. Read how to help development and spot developmental delay.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0021/48027/baby-development-5-months.jpg"
    },
    {
      'title': '5-6 months: baby development',
      'content':
          'At 5-6 months of baby development, your baby is working out who they are and who other people are. Read more and find out how to spot developmental delay.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0023/48029/baby-development-6-months.jpg",
    },
    {
      'title': '6-7 months: baby development',
      'content':
          "Baby development at 6-7 months is an exciting time, as your baby's comes alive. Get development tips and find out how to spot development delay.",
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0016/48031/baby-development-7-months.jpg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 8,
          child: ExpansionTile(
            title: Text(_data[index]['title']!),
            children: [
              MyImageLoader(imageUrl: _data[index]['image']!),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _data[index]['content']!,
                  style: TextStyle(
                    fontFamily: "Lexend",
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
