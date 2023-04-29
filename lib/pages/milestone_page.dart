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
              ToddlersDevelopmentScreen(),
              PreSchoolersDevelopmentScreen(),
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

class ToddlersDevelopmentScreen extends StatelessWidget {
  final List<Map<String, String>> _data = [
    {
      'title': 'Toddler development for 12-15 months',
      'content':
          'Your toddler spends a lot of time working out what things do and what to do with them. Read more about toddler development and delay at 12-15 months.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0024/48048/child-development-12-15-months.jpg"
    },
    {
      'title': 'Toddler development for 15-18 months',
      'content':
          ' Your toddler is curious about everything and keen to play,experiment and explore. Heres how to help toddler development at 15-18 months and spot delay.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0017/48050/child-development-15-18-months.jpg"
    },
    {
      'title': 'Toddler development for 18-24 months',
      'content':
          ' At 18-24 months, your toddler might have strong emotions like frustration,shame and excitement. Here how to boost toddler development and spot delay.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0019/48052/child-development-18-24-months.jpg"
    },
    {
      'title': 'Toddler development for 2-3 years',
      'content':
          'At 2-3 years, your toddler is going through many emotions and learning about other people feelings. Here how to help toddler development and spot delay.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0018/48042/child-development-2-3-years.jpg"
    },
    {
      'title': 'Developmental delay',
      'content':
          ' Developmental delay is when young children are slower than expected to develon ckille. See vor GP or nurse if.',
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

class PreSchoolersDevelopmentScreen extends StatelessWidget {
  final List<Map<String, String>> _data = [
    {
      'title': 'preschooler development for 3-4 years',
      'content':
          'At 3-4 years, your preschooler is interested in playing and making friends with others. Here’s how to help with this and other parts of child development.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0018/48060/child-development-three-to-four-years.jpg"
    },
    {
      'title': 'preschooler development for 4-5 years',
      'content':
          'At 4-5 years, your preschooler is learning to express emotion and likes to be around people. Read how to help child development and spot delay at this age.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0023/48056/child-development-four-to-five-years.jpg"
    },
    {
      'title': 'Developmental delay',
      'content':
          ' Developmental delay is when young children are slower than expected to develop skills. See your GP or nurse if you think your child has developmentaldelay.',
      'image':
          "https://raisingchildren.net.au/__data/assets/image/0029/47693/autism-spectrum-disorder-social-story-example.jpg"
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
