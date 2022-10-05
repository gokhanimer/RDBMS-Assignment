create database rdbms; 

use rdbms;

create table News(
					NewsId int,
					Title varchar(50) not null,
					Content varchar(400) not null,
					PublishedAt datetime not null,
					CreatedBy varchar(50) not null,
					Url varchar(50),
					UrlToImage varchar(100),
					primary key(newsid)
					);
insert into News values(101, "It industry in 2020", "It industry was facing disrutive changes in 2019. It is expected to have positive growth in 2020", "2019-12-01", "Jack", null, null);
insert into News values(102, "2020 FIFA U-17 Women World Cup", "The tournament will be held in India between 2 and 21 November 2020. It will mark the first time that India has hosted a FIFA women football tournament", "2019-12-05", "Jack", null, null);
insert into News values(103, "chandrayaan2-spacecraft", "The Lander of Chandrayaan-2 was named Vikram after Dr Vikram A Sarabhai, the Father of the Indian Space Programme. It was designed to function for one lunar day", "2019-12-05", "John", null, null);
insert into News values(104, "NEFT transactions to be available24x7", "Bank customers will be able to transfer fund throgh NEFT around the clock on all days including weekends and hoidays from December 16", "2019-12-01", "John", null, null);

create table Reminders(
					ReminderId int not null,
					ScheduledAt datetime(6) not null,
					NewsId int not null,
					foreign key(NewsId) references News(NewsId),
					primary key(ReminderId)
					);
insert into Reminders values(1, "2019-12-04", 101);
insert into Reminders values(2, "2019-12-10", 102);
insert into Reminders values(3, "2019-12-10", 104);

create table UserProfile(
					UserId varchar(50) not null,
					FirstName varchar(40) not null,
					LastName varchar(40) not null,
					Contact varchar(40),
					Email varchar(40),
					CreatedAt datetime(6) not null,
					primary key(UserId)
					);
insert into UserProfile values("Jack", "Jackson", "James", 8899776655, "jack@ymail.com", "2019-12-07");
insert into UserProfile values("John", "Johnsson", "dsouza", 7869543210, "john@gmail.com", "2019-12-25");
insert into UserProfile values("Kevin", "Kevin", "Lloyd", 9878685748, "kevin@gmail.com", "2019-12-01");

create table User(
					UserId varchar(50) not null,
					password varchar(50) not null,
					FOREIGN KEY (UserId) REFERENCES UserProfile(UserId)
					);
insert into User values("Jack", "pass@123");
insert into User values("John", "something#121");
insert into User values("Kevin", "test@123");

/*1. Retreive all the user profiles joined on or after 10-Dec-2019.*/
select * from UserProfile where CreatedAt > '2019-12-10';

/*2. Retreive the details of user 'Jack' along with all the news created by him.*/
select * from UserProfile left join News on News.CreatedBy = UserProfile.UserId where UserProfile.UserId = 'Jack';

/*3. Retreive all details of the user who created the News with newsId=103.*/
select * from UserProfile left join News on News.CreatedBy = UserProfile.UserId where News.NewsId = '103';

/*4. Retreive the details of all the users who have not added any news yet.*/
select * from UserProfile left join News on News.CreatedBy = UserProfile.UserId where News.CreatedBy is null;

/*5. Retreive the newsid and title of all the news having some reminder.*/
select News.Title, News.NewsId from News left join Reminders on Reminders.NewsId = News.NewsId where Reminders.NewsId is not null;

/*6. Retreive the total number of news added by each user.*/
select CreatedBy, count(CreatedBy) from News group by CreatedBy;

/*7. Update the contact number of userId='John' to '9192939495'.*/
update UserProfile set Contact='9192939495' where UserId='John';

/*8. Update the title of the newsId=101 to 'IT industry growth can be seen in 2020'.*/
update News set Title='IT industry growth can be seen in 2020' where newsId='101';

/*9 Remove all the reminders belonging to the news created by Jack.*/
delete reminder from Reminders reminder join News news using (NewsId) where News.CreatedBy = 'Jack';

/*10. Write a query to set a reminder for a particular news (Use Reminder and News tables - insert statement)*/           
insert into Reminders (`ScheduledAt`,`NewsId`,`ReminderID`) values("2020-01-01",(select NewsId from News where NewsId="101"),"4");

