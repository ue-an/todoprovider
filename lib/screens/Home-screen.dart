import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprovider/provider/Todo-provider.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController titleCtrl = TextEditingController();
TextEditingController contentCtrl = TextEditingController();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('To-Do'),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Container(
            padding: EdgeInsets.all(60.0),
            child: Column(
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 90.0),
                Text(
                  'Contact',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 90.0),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 90.0),
                Text(
                  'About',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          print(context.read<Todo>().tasklist);
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * .80,
                padding: EdgeInsets.all(36.0),
                child: Column(
                  children: [
                    Text('ADD TASK'),
                    SizedBox(height: 20.0),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titleCtrl,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              labelText: 'Title',
                            ),
                            validator: (val) {
                              if (val.isEmpty)
                                return 'This field is required';
                              else
                                return null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: contentCtrl,
                            maxLines: 6,
                            minLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              labelText: 'Write Content',
                            ),
                            validator: (val) {
                              if (val.isEmpty)
                                return 'This field is required';
                              else
                                return null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                child: Text('Save'),
                                onPressed: () async {
                                  await context.read<Todo>().addToTaskList(
                                      titleCtrl.text, contentCtrl.text);
                                  Navigator.of(context).pop();
                                  titleCtrl.text = '';
                                  contentCtrl.text = '';
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.cyan,
                                ),
                              ),
                              ElevatedButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  titleCtrl.text = '';
                                  contentCtrl.text = '';
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.cyan,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      body: Column(
        children: [
          TopBar(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.cyan[100],
              ),
              child: ListView.builder(
                itemCount: context.watch<Todo>().tasklist.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(context.watch<Todo>().tasklist[index].title),
                      subtitle:
                          Text(context.watch<Todo>().tasklist[index].content),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          context.read<Todo>().removeAtIndex(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'TODO List',
            style: TextStyle(
                color: Colors.cyan, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Text(
            '${context.watch<Todo>().tasklist.length} Tasks',
            //'${task.length} Tasks',
            style: TextStyle(
                color: Colors.cyan, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
