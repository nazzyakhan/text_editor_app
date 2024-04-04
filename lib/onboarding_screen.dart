import 'package:flutter/material.dart';
import 'package:text_editor_app/widgets/edit_image_viewmodel.dart';
import 'package:text_editor_app/widgets/image_text.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends EditImageViewModel {
  String selectedFont = 'Roboto';

  List<Widget> pages = [
    Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img4.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img8.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img9.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img7.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img6.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (textHistoryList.isNotEmpty) {
      print(
        "currentTextHistoryListIndex: " +
            currentTextHistoryListIndex.toString() +
            textHistoryList[currentTextHistoryListIndex]
                .last
                .fontSize
                .toString(),
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: _appBar,
        backgroundColor: Colors.transparent,
        floatingActionButton: _addnewTextFab,
        body: PageView(
          children: [
            Stack(
              children: [
                PageView.builder(
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
                if (textHistoryList.isNotEmpty)
                  for (int i = 0;
                      i < textHistoryList[currentTextHistoryListIndex].length;
                      i++)
                    Positioned(
                      left:
                          textHistoryList[currentTextHistoryListIndex][i].left,
                      top: textHistoryList[currentTextHistoryListIndex][i].top,
                      child: GestureDetector(
                        onLongPress: () => addDeleteDialog(context),
                        onTap: () => setCurrentIndex(context, i),
                        child: Draggable(
                          feedback: ImageText(
                            textInfo:
                                textHistoryList[currentTextHistoryListIndex][i],
                          ),
                          child: ImageText(
                            textInfo:
                                textHistoryList[currentTextHistoryListIndex][i],
                          ),
                          onDragEnd: (drag) {
                            final renderBox =
                                context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);
                            setState(
                              () {
                                textHistoryList[currentTextHistoryListIndex][i]
                                    .top = off.dy - 96;
                                textHistoryList[currentTextHistoryListIndex][i]
                                    .left = off.dx;
                              },
                            );
                          },
                          onDraggableCanceled: (velocity, offset) {},
                        ),
                      ),
                    ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.only(left: 10, bottom: 20),
                  child: _alterScreenFab,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get _alterScreenFab => ElevatedButton(
        onPressed: () => alterScreen(context),
        child: Text('Customize Pages'),
      );

  Widget get _addnewTextFab => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        backgroundColor: Colors.white,
        tooltip: 'Add New Text',
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                onPressed: () {
                  print(currentTextHistoryListIndex);
                  if (currentTextHistoryListIndex > 1) {
                    setState(() {
                      currentTextHistoryListIndex =
                          currentTextHistoryListIndex - 1;
                    });
                  }
                },
                icon: Icon(Icons.undo),
              ),
              IconButton(
                onPressed: () {
                  if (currentTextHistoryListIndex <
                      textHistoryList.length - 1) {
                    setState(() {
                      currentTextHistoryListIndex =
                          currentTextHistoryListIndex + 1;
                    });
                  }
                },
                icon: Icon(Icons.redo),
              ),
              DropdownButton<String>(
                value: selectedFont,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      changeFont(newValue);
                    });
                  }
                },
                items: <String>[
                  'Roboto',
                  'Times New Roman',
                  'Courier',
                  'San Francisco Regular',
                  'San Francisco Bold',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () => setState(() {
                  increaseFontSize();
                }),
                tooltip: 'Increase font size',
              ),
              IconButton(
                icon: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                onPressed: () => setState(() {
                  decreaseFontSize();
                }),
                tooltip: 'Decrease font size',
              ),
              IconButton(
                icon: const Icon(
                  Icons.format_align_left,
                  color: Colors.black,
                ),
                onPressed: () => setState(() {
                  alignLeft();
                }),
                tooltip: 'Align left',
              ),
              IconButton(
                icon: const Icon(
                  Icons.format_align_center,
                  color: Colors.black,
                ),
                onPressed: () => alignCenter,
                tooltip: 'Align Center',
              ),
              IconButton(
                icon: const Icon(
                  Icons.format_align_right,
                  color: Colors.black,
                ),
                onPressed: () => alignRight,
                tooltip: 'Align Right',
              ),
              IconButton(
                icon: const Icon(
                  Icons.format_bold,
                  color: Colors.black,
                ),
                onPressed: () => boldText,
                tooltip: 'Bold',
              ),
              IconButton(
                icon: const Icon(
                  Icons.format_italic,
                  color: Colors.black,
                ),
                onPressed: () => italicText,
                tooltip: 'Italic',
              ),
              IconButton(
                icon: const Icon(
                  Icons.space_bar,
                  color: Colors.black,
                ),
                onPressed: () => addLinesToText,
                tooltip: 'Add New Line',
              ),
              Tooltip(
                message: 'Red',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'White',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Black',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Blue',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Yellow',
                child: GestureDetector(
                    onTap: () => changeTextColor(Colors.yellow),
                    child: const CircleAvatar(
                      backgroundColor: Colors.yellow,
                    )),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Green',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Orange',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: const CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Pink',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.pink),
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      );

  void updateMyTiles(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex--;
      }

      final tile = pages.removeAt(oldIndex);
      pages.insert(newIndex, tile);
    });
  }

  alterScreen(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Drag and Arrange the Pages',
          selectionColor: Colors.deepPurple,
          style: TextStyle(fontFamily: 'Times New Roman', fontSize: 20),
        ),
        content: SizedBox(
          height: 300,
          width: 300,
          child: ReorderableListView(
            onReorder: ((oldIndex, newIndex) =>
                updateMyTiles(oldIndex, newIndex)),
            children: [
              for (final tile in pages)
                ListTile(
                  key: ValueKey(tile),
                  title: Row(
                    children: [
                      Icon(Icons.drag_handle),
                      SizedBox(width: 50, height: 80),
                      SizedBox(width: 50, height: 80, child: tile as Widget),
                      SizedBox(width: 20, height: 80),
                      Text('pages'),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: Color.fromARGB(71, 0, 0, 0)),
                  ),
                  tileColor: Colors.grey.shade300,
                )
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
