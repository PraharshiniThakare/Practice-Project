trigger chatterfeed on FeedItem (after insert)
{

set<string> fbody= new set<string>();
for(feedItem f:trigger.new)
{
fbody.add(f.body);
}
List<FeedItem> feedItems = new List<FeedItem>();
list<account> a=[select id,name,ownerId from account ];

for(FeedItem f:trigger.new)
{

for(account ac:a){
if(f.body.contains(ac.name))
{
string s= f.body;
FeedItem fitem = new FeedItem();
fitem.type = 'LinkPost';
fitem.ParentId = ac.id;
system.debug(fitem.parentId+'IIIIIIIIII');
fitem.linkurl='https://ap1.salesforce.com/_ui/core/userprofile/UserProfilePage?u=00590000000NI6s&fId='+f.id;
fitem.Title = 'view';
fitem.Body=s;
system.debug(fitem.body+'BBBBBBBBB');
feedItems.add(fitem);
system.debug(feedItems+'FFFFFFFFf');
}
}
}

if(feedItems.size() > 0) {
try{
Database.insert(feedItems,false);
system.debug(feedItems+'OOOO');}
catch(exception e){}
}
}