import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final String title;
  final VoidCallback? onDelete;

  const TodoItem({super.key, required this.title, this.onDelete});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.deepPurple, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
              activeColor: Colors.deepPurple,
            ),
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                  color: isChecked ? Colors.grey : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              onPressed: widget.onDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarExample extends StatefulWidget {
  const AppBarExample({super.key});

  @override
  State<AppBarExample> createState() => _AppBarExampleState();
}

class _AppBarExampleState extends State<AppBarExample> {
  int _selectedIndex = 0;

  static const List<String> titles = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD0A9F5), // Màu tím nhạt
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30), // Bo góc dưới
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'ToDo List App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey.shade600,
                    indicatorColor: Colors.deepPurple,
                    tabs: <Widget>[
                      Tab(text: titles[0]),
                      Tab(text: titles[1]),
                      Tab(text: titles[2]),
                      Tab(text: titles[3]),
                      Tab(text: titles[4]),
                      Tab(text: titles[5]),
                      Tab(text: titles[6]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(7, (index) {
            // Giả lập danh sách task tĩnh cho mỗi ngày
            final List<String> tasks = [
              'Task 1 for ${titles[index]}',
              'Task 2 for ${titles[index]}',
              'Task 3 for ${titles[index]}',
            ];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, taskIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TodoItem(
                      title: tasks[taskIndex],
                      onDelete: () {
                        // Không xoá được vì đang dùng List.generate tĩnh
                        // Nếu cần xoá thật, ta cần quản lý tasks bằng List trong State
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Xoá tạm giả lập - chưa xử lý logic xoá',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }),
        ),

        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFFD0A9F5), // tím nhạt
            selectedItemColor: const Color(0xFF8A2BE2), // tím đậm
            unselectedItemColor: Colors.black,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          ),
        ),
        floatingActionButton: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a new task...',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(Icons.edit, color: Colors.deepPurple),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
