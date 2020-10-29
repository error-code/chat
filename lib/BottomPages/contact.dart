import 'package:chat/components/home_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lpinyin/lpinyin.dart';

void main(){
    runApp(contact());
}

class contact extends StatefulWidget {
    @override
    _contactState createState() => _contactState();
}

class _contactState extends State<contact> with AutomaticKeepAliveClientMixin {

    @override
    bool get wantKeepAlive => true;

    List<ContactInfo> contactList = List();
    List<ContactInfo> topList = List();

    @override
    void initState() {
        super.initState();
        topList.add(ContactInfo(
                name: '新的朋友',
                tagIndex: '↑',
                bgColor: Color(0xfffa9e3b),
                icon: 'assets/svg/icons_filled_add_friends.svg',
                type:'bar'
            )
        );
        topList.add(ContactInfo(
                name: '群聊',
                tagIndex: '↑',
                bgColor: Color(0xff07c160),
                icon: 'assets/svg/icons_filled_group_detail.svg',
                type:'bar'
            )
        );
        topList.add(ContactInfo(
                name: '标签',
                tagIndex: '↑',
                bgColor: Color(0xff2781d7),
                icon: 'assets/svg/icons_filled_tag.svg',
                type:'bar'
            )
        );
        topList.add(ContactInfo(
                name: '公众号',
                tagIndex: '↑',
                bgColor: Color(0xff2781d7),
                icon: 'assets/svg/icons_filled_me.svg',
                type:'bar'
            )
        );
        // topList.add(ContactInfo(
        //     name: '标签',
        //     tagIndex: '↑',
        //     bgColor: Colors.blue,
        //     iconData: Icons.local_offer));
        // topList.add(ContactInfo(
        //     name: '公众号',
        //     tagIndex: '↑',
        //     bgColor: Colors.blueAccent,
        //     iconData: Icons.person));
        loadData();
    }

    void loadData() async {
        //加载联系人列表
        rootBundle.loadString('assets/data/contacts.json').then((value) {
            List list = json.decode(value);
            list.forEach((v) {
                contactList.add(ContactInfo.fromJson(v));
            });
            _handleList(contactList);
        });
    }

    void _handleList(List<ContactInfo> list) {
        if (list == null || list.isEmpty) return;
        for (int i = 0, length = list.length; i < length; i++) {
            String pinyin = PinyinHelper.getPinyinE(list[i].name);
            String tag = pinyin.substring(0, 1).toUpperCase();
            list[i].namePinyin = pinyin;
            if (RegExp("[A-Z]").hasMatch(tag)) {
                list[i].tagIndex = tag;
            } else {
                list[i].tagIndex = "#";
            }
        }
        // A-Z sort.
        SuspensionUtil.sortListBySuspensionTag(contactList);

        // show sus tag.
        SuspensionUtil.setShowSuspensionStatus(contactList);

        // add topList.
        contactList.insertAll(0, topList);

        setState(() {});
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            appBar: new HomeNavBar(title: '通讯录'),
            body: AzListView(
                data: contactList,
                itemCount: contactList.length,
                itemBuilder: (BuildContext context, int index) {
                    ContactInfo model = contactList[index];
                    return Utils.getWeChatListItem(
                        context,
                        model,
                        defHeaderBgColor: Color(0xFFE5E5E5),
                    );
                },
                // physics: BouncingScrollPhysics(),
                susItemBuilder: (BuildContext context, int index) {
                    ContactInfo model = contactList[index];
                    if ('↑' == model.getSuspensionTag()) {
                        return Container();
                    }
                    return Utils.getSusItem(context, model.getSuspensionTag());
                },
                indexBarData: ['↑', '☆', ...kIndexBarData],
                indexBarOptions: IndexBarOptions(
                    needRebuild: true,
                    ignoreDragCancel: true,
                    downTextStyle: TextStyle(fontSize: 12, color: Colors.white),
                    downItemDecoration:
                        BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                    indexHintWidth: 120 / 2,
                    indexHintHeight: 100 / 2,
                    indexHintDecoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Utils.getImgPath('ic_index_bar_bubble_gray')),
                            fit: BoxFit.contain,
                        ),
                    ),
                    indexHintAlignment: Alignment.centerRight,
                    indexHintChildAlignment: Alignment(-0.25, 0.0),
                    indexHintOffset: Offset(-20, 0),
                ),
            ),
        );
    }
}

class CityModel extends ISuspensionBean {
    String name;
    String tagIndex;
    String namePinyin;

    CityModel({
        this.name,
        this.tagIndex,
        this.namePinyin,
    });

    CityModel.fromJson(Map<String, dynamic> json) : name = json['name'];

    Map<String, dynamic> toJson() => {
            'name': name,
    //        'tagIndex': tagIndex,
    //        'namePinyin': namePinyin,
    //        'isShowSuspension': isShowSuspension
        };

    @override
    String getSuspensionTag() => tagIndex;

    @override
    String toString() => json.encode(this);
}

class ContactInfo extends ISuspensionBean {
    String name;
    String tagIndex;
    String namePinyin;

    Color bgColor;
    IconData iconData;

    String img;
    String id;
    String firstletter;
    String icon;
    String type;

    ContactInfo({
        this.name,
        this.tagIndex,
        this.namePinyin,
        this.bgColor,
        this.iconData,
        this.img,
        this.id,
        this.firstletter,
        this.icon,
        this.type
    });

    ContactInfo.fromJson(Map<String, dynamic> json)
        : name = json['name'],
            img = json['img'],
            id = json['id']?.toString(),
            type = json['type'],
            firstletter = json['firstletter'];

    Map<String, dynamic> toJson() => {
        //'id': id,
        'name': name,
        'img': img,
        'type':type
        //'firstletter': firstletter,
        //'tagIndex': tagIndex,
        //'namePinyin': namePinyin,
        //'isShowSuspension': isShowSuspension
    };

    @override
    String getSuspensionTag() => tagIndex;

    @override
    String toString() => json.encode(this);
}

class Utils {
    static String getImgPath(String name, {String format: 'png'}) {
        return 'assets/images/$name.$format';
    }

    static void showSnackBar(BuildContext context, String msg) {
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text(msg),
                duration: Duration(seconds: 2),
            ),
        );
    }

    static Widget getSusItem(BuildContext context, String tag,{double susHeight = 40}) {

        if (tag == '★') {
            tag = '★ 热门城市';
        }
        return Container(
            height: susHeight,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 16.0),
            color: Color(0xFFF3F4F5),
            alignment: Alignment.centerLeft,
            child: Text(
                '$tag',
                softWrap: false,
                style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF666666),
                ),
            ),
        );
    }

    static Widget getListItem(BuildContext context, CityModel model,{double susHeight = 40}) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                Offstage(
                    offstage: !(model.isShowSuspension == true),
                    child: getSusItem(context, model.getSuspensionTag(),susHeight: susHeight),
                ),
                ListTile(
                    title: Text(model.name),
                    onTap: () {
                        //LogUtil.e("onItemClick : $model");
                        Utils.showSnackBar(context, 'onItemClick : ${model.name}');
                    },
                )
            ],
        );
    }

    static Widget getWeChatListItem(BuildContext context,ContactInfo model, {double susHeight = 40,Color defHeaderBgColor,}) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                Offstage(
                    offstage: !(model.isShowSuspension == true),
                    child: getSusItem(context, model.getSuspensionTag(),
                        susHeight: susHeight),
                ),
                getWeChatItem(context, model, defHeaderBgColor: defHeaderBgColor),
            ],
        );
    }

    static Widget getWeChatItem(BuildContext context,ContactInfo model, {Color defHeaderBgColor,}) {
        DecorationImage image;
        if (model.img != null && model.img.isNotEmpty) {
            image = DecorationImage(
                image: NetworkImage(model.img),
                fit: BoxFit.contain,
            );
        }
        if(model.type==null){
            return ListTile(
                leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4.0),
                        color: model.bgColor ?? defHeaderBgColor,
                        image: image,
                    )
                ),
                title: Text(model.name),
                onTap: () {
                    //LogUtil.e("onItemClick : $model");
                    Utils.showSnackBar(context, 'onItemClick : ${model.name}');
                },
            );
        }else{
            return ListTile(
                leading: Container(
                    width: 36,
                    height: 36,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4.0),
                        color: model.bgColor ?? defHeaderBgColor,
                    ),
                    child:Container(
                        child: model.icon==null?null:SvgPicture.asset(model.icon,color: Colors.white,),
                    )
                ),
                title: Text(model.name),
                onTap: () {
                    //LogUtil.e("onItemClick : $model");
                    Utils.showSnackBar(context, 'onItemClick : ${model.name}');
                },
            );
        }
        
    }
}