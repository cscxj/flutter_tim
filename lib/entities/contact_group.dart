class ContactGroup {
  bool display;
  int activeCount;
  String groupName;
  List<Contact> contactList;

  ContactGroup({this.display:false, this.activeCount:0, this.groupName:'', this.contactList:const []});

  ContactGroup.fromJson(Map<String, dynamic> json) {
    display = json['display'];
    activeCount = json['activeCount'];
    groupName = json['groupName'];
    if (json['contacts'] != null) {
      contactList = new List<Contact>();
      json['contacts'].forEach((v) {
        contactList.add(new Contact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display'] = this.display;
    data['activeCount'] = this.activeCount;
    data['groupName'] = this.groupName;
    if (this.contactList != null) {
      data['contacts'] = this.contactList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contact {
  String picture;
  String name;
  bool online;

  Contact({this.picture:'', this.name:'', this.online:false});

  Contact.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
    name = json['name'];
    online = json['online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picture'] = this.picture;
    data['name'] = this.name;
    data['online'] = this.online;
    return data;
  }
}