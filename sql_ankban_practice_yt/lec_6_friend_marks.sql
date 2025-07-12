-- Create the Person table
CREATE TABLE yt.Person (
    PersonID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Email NVARCHAR(100),
    Score INT
);

-- Create the Friend table
CREATE TABLE yt.Friend (
    PersonID INT,
    FriendID INT,
    --FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    --FOREIGN KEY (FriendID) REFERENCES Person(PersonID)
);

-- Insert data into Person table
INSERT INTO yt.Person (PersonID, Name, Email, Score) VALUES
(1, 'Alice', 'alice2018@hotmail.com', 88),
(2, 'Bob', 'bob2018@hotmail.com', 11),
(3, 'Davis', 'davis2018@hotmail.com', 27),
(4, 'Tara', 'tara2018@hotmail.com', 45),
(5, 'John', 'john2018@hotmail.com', 63);

-- Insert data into Friend table
INSERT INTO yt.Friend (PersonID, FriendID) VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 5),
(4, 2),
(4, 3),
(4, 5);


with cte as (select f.PersonID, count(f.FriendID) as total_friend, sum(p.Score) as friend_score
from yt.friend f
inner join yt.person p on f.FriendID=p.PersonID
group by f.PersonID
having sum(p.score) > 100
)
select c.personid, p.name, c.total_friend, c.friend_score 
from cte c
inner join yt.person p on p.personid=c.personid

select * from yt.person;
select * from yt.Friend;