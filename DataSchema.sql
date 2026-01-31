create table AppUser(
userId serial primary key,
UserName varchar(100) not null,
UserSurname varchar(100) not null,
userStatus varchar(20) check(userStatus in('online','offline'))
);

create table humidityRecord(
humId serial primary key,
userId int,
humLevel smallint check(humLevel>100 or humLevel<0),
measuredAt timestamp not null,
foreign key(userId) references AppUser(userId)
);
