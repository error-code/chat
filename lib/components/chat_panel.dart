import 'package:chat/input/my_extended_text_selection_controls.dart';
import 'package:chat/input/my_special_text_span_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat/config/emojis.dart';
import 'package:extended_text_field/extended_text_field.dart';

import 'event_bus.dart';

/**
 * 聊天输入面板
 */
void main(){
    new ChatPanel();
}

class ChatPanel extends StatefulWidget {

    final ValueChanged<String> handle;
    
    ChatPanel({
        this.handle
    });

    @override
    _ChatPanelState createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {

    String type = 'input';

    @override
    Widget build(BuildContext context) {
        return Container(
            child: Column(
                children: [
                    InputBar(
                        handle:(e){
                            setState(() {
                                type = e;
                            });
                        },
                        send:(e){
                            widget.handle(e);
                        }
                    ),
                    Container(
                        child: this.type=='emoji'?EmojiPanel():null,
                    )
                ],
            ),
        );
    }

    Widget EmojiPanel(){
        return Container(
            height: 200,
            padding: EdgeInsets.all(10),
            child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:8
                ),
                itemCount:emojis.length,
                itemBuilder: (context,index){
                    int key = index+1;
                    return InkWell(
                        child: Image.asset('assets/emoji/Expression_$key.png',scale: 1.5),
                        onTap: (){
                            bus.emit('addEmoji','[${index + 1}]');
                        },
                    );
                }
            ),
        );
    }

}

/**
 * 聊天框
 */
class InputBar extends StatefulWidget {

    //VoidCallback handle;
    final ValueChanged<String> handle;
    final ValueChanged<String> send;
    
    InputBar({
        this.handle,
        this.send
    });

    @override
    _InputBarState createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {

    bool isRecord = false;
    bool showEmoji = false;
    bool showPanel = false;
    bool showSend = false;
    String type = 'input';
    String content = '';
    final GlobalKey _key = GlobalKey();
    final TextEditingController _textEditingController = TextEditingController();
    final MyExtendedMaterialTextSelectionControls _myExtendedMaterialTextSelectionControls =  MyExtendedMaterialTextSelectionControls();
    final FocusNode _focusNode = FocusNode();

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        this.insertEmoji();
    }

    void insertEmoji(){
        bus.on('addEmoji',(arg){
            if(showSend==false){
                setState(() {
                    showSend = true;
                });
            }
            this.insertText(arg);
        });
    }
    
    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.all(10),
            color: Color(0xfff7f7f7),
            child: Row(
                children: [
                    InkWell(
                        child: isRecord==false?SvgPicture.asset('assets/svg/icons_outlined_voice.svg',width: 30):SvgPicture.asset('assets/svg/icons_outlined_keyboard.svg',width: 30),
                        onTap: (){
                            setState(() {
                                isRecord = !isRecord;
                            });
                            if(isRecord==true){
                                FocusScope.of(context).requestFocus(FocusNode());
                            }else{
                                FocusScope.of(context).autofocus(_focusNode);
                            }
                        },
                    ),
                    Expanded(
                        child: Input()
                    ),
                    InkWell(
                        child: showEmoji==false?SvgPicture.asset('assets/svg/icons_outlined_sticker.svg',width: 30):SvgPicture.asset('assets/svg/icons_outlined_keyboard.svg',width: 30),
                        onTap: (){
                            setState(() {
                                showEmoji = !showEmoji;
                                type = showEmoji?'emoji':'input';
                            });
                            widget.handle(type);
                            if(type=='emoji'){
                                FocusScope.of(context).requestFocus(FocusNode());
                            }else{
                                FocusScope.of(context).autofocus(_focusNode);
                            }
                        },
                    ),
                    Container(
                        padding: EdgeInsets.only(left:5),
                        child: showSend==false?InkWell(
                            child: SvgPicture.asset('assets/svg/icons_outlined_add2.svg',width: 30),
                            onTap: (){
                                setState(() {
                                    showPanel = !showPanel;
                                    type = showPanel?'panel':'input';
                                });
                                widget.handle(type);

                            },
                        ):
                        InkWell(
                            child: Container(
                                child:Text('发送',style: TextStyle(color: Colors.white),),
                                width: 50,
                                height: 30,
                                alignment:Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xff07C160),
                                    borderRadius: BorderRadius.circular(2)
                                ),
                            ),
                            onTap: (){
                                this.clear();
                            },
                        )
                    )
                ],
            ),
        );
    }

    void clear(){
        widget.send(_textEditingController.text);
        //sessions.insert(0, _textEditingController.text);
        _textEditingController.value = _textEditingController.value.copyWith(
            text: '',
            selection:const TextSelection.collapsed(offset: 0),
            composing: TextRange.empty
        );
    }

    void insertText(String text) {

        final TextEditingValue value = _textEditingController.value;
        final int start = value.selection.baseOffset;
        int end = value.selection.extentOffset;
        if (value.selection.isValid) {
            String newText = '';
            if (value.selection.isCollapsed) {
                if (end > 0) {
                    newText += value.text.substring(0, end);
                }
                newText += text;
                if (value.text.length > end) {
                    newText += value.text.substring(end, value.text.length);
                }
            } else {
                newText = value.text.replaceRange(start, end, text);
                end = start;
            }

            _textEditingController.value = value.copyWith(
                text: newText,
                selection: value.selection.copyWith(
                    baseOffset: end + text.length, extentOffset: end + text.length
                )
            );
        } else {
            _textEditingController.value = TextEditingValue(
                text: text,
                selection:TextSelection.fromPosition(
                    TextPosition(offset: text.length)
                )
            );
        }
    }

    Widget Input(){

        return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 40.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color:Colors.white
            ),
            child: ExtendedTextField(
                key: _key,
                specialTextSpanBuilder: MySpecialTextSpanBuilder(
                    showAtBackground: true,
                ),
                controller: _textEditingController,
                textSelectionControls: _myExtendedMaterialTextSelectionControls,
                maxLines: null,
                focusNode: _focusNode,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 10),
                    border:OutlineInputBorder(
                        borderSide:BorderSide.none
                    )
                ),
                onChanged:(e){
                    if(showSend==false){
                        setState(() {
                            showSend = true;
                        });
                    }
                },
                onTap: (){
                    if(showEmoji==true){
                        setState(() {
                            showEmoji = false;
                            type = 'input';
                        });
                    }
                },
                keyboardType: TextInputType.multiline
                //textDirection: TextDirection.rtl,
            )
        );
    }
}