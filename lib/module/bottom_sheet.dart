import 'package:flutter/material.dart';

class EditBottomSheet extends StatefulWidget {
  const EditBottomSheet({super.key});

  @override
  State<EditBottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<EditBottomSheet> {
  String text = "";

  Future<void> _openEditBottomSheet() async {
    final newText = await _showEditBottomSheet(
      context: context,
      initialText: text,
      title: "Edit your note",
      hintText: "I love Emilia",
      maxLine: 5,
    );

    if (newText != null && newText.trim() != text) {
      setState(() => text = newText.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.grey.shade200;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 1, 10, 14),
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 227, 237, 244),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 238, 243, 246),
              Color.fromARGB(255, 232, 242, 250),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "About me",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 78, 78, 78),
                      letterSpacing: .2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  iconSize: 16,
                  color: Colors.grey.shade600,
                  onPressed: _openEditBottomSheet,
                  tooltip: "Edit",
                  splashRadius: 22,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                ),
              ],
            ),
            Divider(height: 1, thickness: 1, color: borderColor),
            SizedBox(height: 15),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
                height: 1.35,
              ),
            ),
            SizedBox(height: 15),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: Text(
            //         "Date joined: ",
            //         style: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.bold,
            //           color: const Color.fromARGB(255, 78, 78, 78),
            //           letterSpacing: .2,
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Text(
            //         "27/08/2025",
            //         style: TextStyle(
            //           fontSize: 14,
            //           color: Colors.black54,
            //           letterSpacing: .2,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

Future<String?> _showEditBottomSheet({
  required BuildContext context,
  required String initialText,
  String title = "Edit your note",
  String hintText = "I love Emilia",
  int maxLine = 5,
}) {
  final controller = TextEditingController(text: initialText);
  final borderColor = Colors.grey.shade300;

  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      final bottomInset = MediaQuery.of(context).viewInsets.bottom;
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          bottom: bottomInset + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  splashRadius: 22,
                  tooltip: "Close",
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              autofocus: true,
              maxLines: maxLine,
              minLines: 3,
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.black45,
                    width: 1.2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: borderColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Discard"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, controller.text),
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
