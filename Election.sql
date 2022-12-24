/*Sowore exploration*/

select * from read_csv_auto('c:/Users/HP/Desktop/EverSed\DataLeum\First Project Portfolio\second project\soworemaster.csv');
create table sowore (date int,username varchar,location varchar,retweetcount INT,likecount INT,source varchar,cleaned_tweets varchar, subjectivity varchar, polarity varchar, sentiments varchar);
copy sowore from 'c:/Users/HP/Desktop/EverSed\DataLeum\First Project Portfolio\second project\soworemaster.csv'(DELIMITER ',', HEADER);
select * from sowore;
 
Update sowore
SET cleaned_tweets = replace(cleaned_tweets, 'Û', '');

Update sowore
SET cleaned_tweets = replace(cleaned_tweets, 'ä', '');

Update sowore
SET cleaned_tweets = replace(cleaned_tweets, 'ª', '');

Update sowore
SET cleaned_tweets = replace(cleaned_tweets, '÷', '');

Update sowore
SET cleaned_tweets = replace(cleaned_tweets, 'Ô', '');

Update sowore
SET cleaned_tweets = replace(cleaned_tweets, 'Ü', '');

Update sowore
SET cleaned_tweets = replace(cleaned_tweets, '?', '');

Update sowore
SET cleaned_tweets = replace(cleaned_tweets, '[', '');

Update sowore
SET cleaned_tweets = replace(cleaned_tweets, ']', '');

Update sowore
SET cleaned_tweets = replace(cleaned_tweets, '(', '');

Update sowore
SET cleaned_tweets = replace(cleaned_tweets, ')', '');

Update sowore set cleaned_tweets = ltrim(rtrim(cleaned_tweets));

copy (SELECT date,username, location, retweetcount, likecount, source,cleaned_tweets, subjectivity,polarity, sentiments FROM sowore 
group by date, username,location, retweetcount,likecount,source,cleaned_tweets,subjectivity,polarity,sentiments
order by date asc) to'c:/Users/HP/Desktop/EverSed\DataLeum\First Project Portfolio\second project\Soworemaster.csv'(DELIMITER ',', HEADER);

update sowore
set location=replace(location, 'nan', 'unknown');

Update sowore
SET location = replace(location, 'Lagos, Nigeria', 'Lagos') where location like ('%Lagos%');

Update sowore
SET location = replace(location, 'Lagos Nigeria', 'Lagos') where location like ('%Lasgidi%');

Update sowore
SET location = replace(location, 'Nigeria', 'Unknown') where location like ('%Nigeria%');

Update sowore
SET location = replace(location, 'Abuja, Nigeria', 'Abuja') where location like ('%Abuja%');

Update sowore
SET location = replace(location, 'Anambra, ð³ð¬ ', 'Anambra') where location like ('%Anambra%');

Update sowore
SET location = replace(location, 'London ', 'London') where location like ('%London%');
