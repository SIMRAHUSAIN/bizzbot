import 'package:flutter/material.dart';
import 'package:mim_whatsup/features/individual_chat/download_file.dart';
import 'package:mim_whatsup/utils/colors.dart';


class ChatMessageWidget extends StatefulWidget {
  final String text;
  final String time;
  final String sendFrom;
  final String filePath;

  const ChatMessageWidget({
    Key? key,
    required this.text,
    required this.time,
    required this.sendFrom,
    required this.filePath
  }) : super(key: key);

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.sendFrom == 'WABA' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 320),
        margin: const EdgeInsets.only(top: 15, left: 5, right: 5),
        decoration: BoxDecoration(
          color: widget.sendFrom == 'WABA' ? cE0E0E0 : cCFE3E1,
          borderRadius: BorderRadius.only(
            topLeft: widget.sendFrom == 'WABA' ? Radius.circular(widget.filePath.isEmpty?30:8) : const Radius.circular(8),
            topRight: widget.sendFrom == 'WABA' ? const Radius.circular(8) : Radius.circular(widget.filePath.isEmpty?30:8),
            bottomLeft: const Radius.circular(8),
            bottomRight: const Radius.circular(8),
          ),
        ),
        padding: EdgeInsets.only(left: widget.filePath.isEmpty?20:10, right: widget.filePath.isEmpty?20:10, top: 10, bottom: 10),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: widget.filePath.isEmpty?Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.3,
                        wordSpacing: 0.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Loto',
                        color: Colors.black
                      ),
                    ): ((widget.filePath.contains(".jpg") || widget.filePath.contains(".jpeg") || widget.filePath.contains(".png")) && widget.filePath.contains("http"))
                    ? Image.network(widget.filePath)
                    : InkWell(
                      onTap: (){
                        DownloadFile().downloadAndOpenFile(widget.filePath);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                        child: Row(
                          children: [
                            Flexible(child: Text(widget.filePath.split("/").last, softWrap: true, overflow: TextOverflow.ellipsis, maxLines: 2)),
                            SizedBox(width: 10),
                            Icon(Icons.download, size: 20),
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                widget.time.split(" ").last.split(":").first + ":" + widget.time.split(" ").last.split(":")[1],
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Loto',
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
