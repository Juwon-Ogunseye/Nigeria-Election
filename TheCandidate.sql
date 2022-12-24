 CREATE DATABASE election
CREATE TABLE TheCandidate
(
date [DATE]NULL,
[username] [VARCHAR](250) NULL,
[location] [VARCHAR](100) NULL,
[retweetcount] [VARCHAR](100) NULL,
[likecount] [VARCHAR](100) NULL,
[source] [VARCHAR](250) NULL, 
[cleaned_tweets] [VARCHAR](250) NULL,
[subjectivity] [VARCHAR](250) NULL,
[polarity] [VARCHAR](250) NULL,
[sentiment] [VARCHAR](250) NULL
)

SELECT * FROM dbo.TheCandidate
SELECT '['+SCHEMA_NAME(schema_id)+'].['+name+']'
AS SchemaTable
FROM sys.tables

DROP TABLE TheCandidate

select* into election.dbo.TheCandidate from 
openrowset(bulk 'C:\Users\HP\Desktop\EverSed\DataLeum\fffMasterListObi_tweets.csv', FORMATFILE='C:\Users\HP\Desktop\EverSed\DataLeum\finale.txt',
FIRSTROW=2) as a;

select * from dbo.TheCandidate;

/*below line showing  ‘Conversion Failed when Converting Date and/or Time from Character String’ Error? i will have to use isDate function to check*/
SELECT year(Date) as year,username, location, retweetcount, likecount, source, subjectivity,polarity, sentiment FROM dbo.TheCandidate
group by Date, username,location, retweetcount,likecount,source,cleaned_tweets,subjectivity,polarity,sentiment
order by year asc

/*clean some of the tweets*/
Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, 'Û', '')

Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, 'ä', '')

Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, 'ª', '')

Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, '÷', '')

Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, 'Ô', '')

Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, 'Ü', '')

Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, '?', '')

Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, '[', '')

Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, ']', '')

Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, '(', '')

Update dbo.TheCandidate
SET cleaned_tweets = replace(cleaned_tweets, ')', '')

/*trim empty spaces in tweets*/
Update dbo.TheCandidate set cleaned_tweets = ltrim(rtrim(cleaned_tweets));

Update dbo.TheCandidate 
Set location =replace(location,'abuja','Abuja') Where location LIKE ('%Abuja%');

Update dbo.TheCandidate 
Set location =replace(location,'abuja nigeria','Abuja') Where location LIKE ('%Abuja%')

Update dbo.TheCandidate 
Set location =replace(location,'federal capital territory nig','Abuja') Where location LIKE ('%federal capital territory nig%')

Update dbo.TheCandidate 
Set location =replace(location,'federal capital territory','Abuja') Where location LIKE ('%federal capital territory%')

Update dbo.TheCandidate 
Set location =replace(location,'federal capital territory nigeria','Abuja') Where location LIKE ('%federal capital territory nigeria%')

Update dbo.TheCandidate 
Set location =replace(location,'federal capital territory nigeria','Abuja') Where location LIKE ('%federal capital territory nigeria%')
 
Update dbo.TheCandidate 
Set location =replace(location,'lasgidi',' Lagos') Where location LIKE ('%lasgidi%');

Update dbo.TheCandidate 
Set location =replace(location,'lasgidi city ( b )',' Lagos') Where location LIKE ('%lasgidi%');

Update dbo.TheCandidate 
Set location =replace(location,'lasgidi eko oni baje ooooo',' Lagos') Where location LIKE ('%lasgidi%');

Update dbo.TheCandidate 
Set location =replace(location,'lasqidi','Lagos') Where location LIKE ('%lasqidi%');

Update dbo.TheCandidate 
Set location =replace(location,'lekki lagos','Lagos') Where location LIKE ('%lekki lagos%');

select distinct location, count(location) locationcount from dbo.TheCandidate
group by location
having count (location)>1

select distinct location, count(location) locationcount from dbo.TheCandidate
group by location
order by location asc 

WITH lection AS (
    SELECT location,
        ROW_NUMBER() OVER (
            PARTITION BY 
               location
            ORDER BY 
              location
        ) row_num
     FROM 
        dbo.TheCandidate
)
select * from lection WHERE row_num = 1;

SELECT year(Date) as year, location, count(location)  as unknown_positive FROM TheCandidate where location like '%unknown%' and sentiment='positive'
group by date, location
order by location desc

select (select count(location) as unknown_positive FROM TheCandidate where location like '%unknown %' and sentiment='positive') as Unknown_positive,
(select count(location) as unknown_negative FROM TheCandidate where location like '%unknown %' and sentiment='negative')as unknown_negative,
(select count(location) as united_state_positive FROM TheCandidate where location like '%united states%' and sentiment='positive') as united_state_positive,
(select count(location) as united_states_negative FROM TheCandidate where location like '%united states%' and sentiment='negative')as united_states_negative,
(select count(location) as oslo_norway_positive FROM TheCandidate where location like '%oslo norway%' and sentiment='positive') as oslo_norway_positive , 
(select count(location) as oslo_norway_negative FROM TheCandidate where location like '%oslo norway%' and sentiment='negative') as oslo_norway_negative,
(select count(location) as osogbo_positive FROM TheCandidate where location like '%osogbo%' and sentiment='positive') as osogbo_positive,
(select count(location) as osogbo_negative FROM TheCandidate where location like '%osogbo%' and sentiment='negative')as osogbo_negative,
(select count(location) as ontario_positive FROM TheCandidate where location like '%ontario%' and sentiment='positive')as ontario_positive,
(select count(location) as ontario_negative FROM TheCandidate where location like '%ontario%' and sentiment='negative') as ontario_negative, 
(select count(location) as  new_york_positive FROM TheCandidate where location like '%new york%' and sentiment='positive') as new_york_positive,
(select count(location) as  new_york_negative FROM TheCandidate where location like '%new york%' and sentiment='negative') as new_york_negative,
(select count(location) as nan_positive FROM TheCandidate where location like '%nan%' and sentiment='positive') as nan_positive,
(select count(location) as  nan_negative FROM TheCandidate where location like '%nan%' and sentiment='negative') as  nan_negative,
(select count(location) as imo_state_positive FROM TheCandidate where location like '%imo state%' and sentiment='positive')as imo_state_positive,
(select count(location) as  imo_state_negative FROM TheCandidate where location like '%imo state%' and sentiment='negative') as  imo_state_negative,
(select count(location) as manchester_uk_positive FROM TheCandidate where location like '%manchester uk' and sentiment='positive') as manchester_uk_positive,
(select count(location) as manchester_uk_negative FROM TheCandidate where location like '%manchester uk%' and sentiment='negative') as manchester_uk_negative,
(select count(location) as los_angeles_ca_positive FROM TheCandidate where location like '%los angeles ca' and sentiment='positive') as los_angeles_ca_positive,
(select count(location) as los_negative FROM TheCandidate where location like '%los angeles ca%' and sentiment='negative') as los_angeles_ca_negative, 
(select count(location) as lagos_positive FROM TheCandidate where location like '%lagos' and sentiment='positive') as lagos_positive, 
(select count(location) as lagos_negative FROM TheCandidate where location like '%lagos%' and sentiment='negative') as lagos_negative, 
(select count(location) as kaduna_positive FROM TheCandidate where location like '%kaduna%' and sentiment='positive') as kaduna_positive,
(select count(location) as kaduna_negative FROM TheCandidate where location like '%kaduna%' and sentiment='negative') as kaduna_negative,
(select count(location) as ibadan_positive FROM TheCandidate where location like '%ibadan%' and sentiment='positive')  as ibadan_positive,
(select count(location) as ibadan_negative FROM TheCandidate where location like '%ibadan%' and sentiment='negative') as ibadan_negative , 
(select count(location) as canada_positive FROM TheCandidate where location like '%canada%' and sentiment='positive') as canada_positive,
(select count(location) as canada_negative FROM TheCandidate where location like '%canada%' and sentiment='negative') as canada_negative ,
(select count(location) as london_positive FROM TheCandidate where location like '%london%' and sentiment='positive') as london_positive,  
(select count(location) as london_negative FROM TheCandidate where location like '%london%' and sentiment='negative') as london_negative, 
(select count(location) as england_united_kingdom__positive FROM TheCandidate where location like '%england united kingdom%' and sentiment='positive') as england_united_kingdom__positive, 
(select count(location) as england_united_kingdom_negative FROM TheCandidate where location like '%england united kingdom%' and sentiment='negative') as england_united_kingdom_negative, 
(select count(location) as canada_positive FROM TheCandidate where location like '%texas%' and sentiment='positive')as texas_positive,
(select count(location) as canada_negative FROM TheCandidate where location like '%texas%' and sentiment='negative')as texas_negative,
(select count(location) as Acra_positive FROM TheCandidate where location like '%Acra%' and sentiment='positive')as Acra_positive,
(select count(location) as Acra_negative FROM TheCandidate where location like '%Acra Ghana%' and sentiment='negative') as Acra_negative,
(select count(location) as Abuja_positive FROM TheCandidate where location like '%Abuja%' and sentiment='positive')as Abuja_positive,
(select count(location) as Abuja_negative FROM TheCandidate where location like '%Abuja%' and sentiment='negative') as Abuja_negative, 
(select count(location) as Abia_positive FROM TheCandidate where location like '%Abia%' and sentiment='positive') as Abia_positive,
(select count(location) as Abia_negative FROM TheCandidate where location like '%Abia%' and sentiment='negative') as Abia_negative, 
(select count(location) as Adamawa_positive FROM TheCandidate where location like '%Adamawa%' and sentiment='positive')as Adamawa_positive,
(select count(location) as Adamawa_negative FROM TheCandidate where location like '%Adamawa%' and sentiment='negative')as Adamawa_negative,
(select count(location) as AkwaIbom_positive FROM TheCandidate where location like '%Akwa Ibom%' and sentiment='positive') as AkwaIbom_positive,
(select count(location) as AkwaIbom_negative FROM TheCandidate where location like '%Akwa Ibom%' and sentiment='negative') as AkwaIbom_negative, 
(select count(location) as Anambra_positive FROM TheCandidate where location like '%Anambra%' and sentiment='positive') as Anambra_positive,
(select count(location) as Anambra_negative FROM TheCandidate where location like '%Anambra%' and sentiment='negative') as Anambra_negative,
(select count(location) as Anambra_positive FROM TheCandidate where location like '%Bauchi%' and sentiment='positive')as Bauchi_positive,
(select count(location) as Bauchi_negative FROM TheCandidate where location like '%Bauchi%' and sentiment='negative') as Bauchi_negative,
(select count(location) as Bayelsa_positive FROM TheCandidate where location like '%Bayelsa%' and sentiment='positive') as Bayelsa_positive,
(select count(location) as Bayelsa_negative FROM TheCandidate where location like '%Bayelsa%' and sentiment='negative') as Bayelsa_negative, 
(select count(location) as Benue_positive FROM TheCandidate where location like '%Benue%' and sentiment='positive') as Benue_positive, 
(select count(location) as Benue_negative FROM TheCandidate where location like '%Benue%' and sentiment='negative') as Benue_negative;  


/* using the below select query to know which rows are failing*/
select *
FROM
   dbo.TheCandidate
WHERE
    ISDATE(Date) = 0

/* deleting the failing rows*/
delete
FROM
   dbo.TheCandidate
WHERE
    ISDATE(Date) = 0


/*GO  
BULK INSERT TheCandidate FROM 'C:\Users\HP\Desktop\EverSed\DataLeum\First Project Portfolio\second project\FmasterTweet.csv'
   WITH (  
      DATAFILETYPE = 'char',  
      FIELDTERMINATOR = ',',  
      ROWTERMINATOR = '\n' 
);  
GO*/  
 /* WHENEVER BULK THROWS ERRROS OF ACCESS DENIED THIS IS MOSTLY DUE TO HOW THE EXCEL FILE WAS SAVED GO BACK AND RESAVE IT INO CVS FORMAT. USE THE COMMA TERMINATOR AND CHANGE DATE DATATYPE TO DATE*/

/*Tinubu data analysi*/
CREATE TABLE Tinubu
(
date [DATE]NULL,
[username] [VARCHAR](250) NULL,
[location] [VARCHAR](100) NULL,
[retweetcount] [VARCHAR](100) NULL,
[likecount] [VARCHAR](100) NULL,
[source] [VARCHAR](250) NULL, 
[cleaned_tweets] [VARCHAR](250) NULL,
[subjectivity] [VARCHAR](250) NULL,
[polarity] [VARCHAR](250) NULL,
[sentiment] [VARCHAR](250) NULL
)

bcp election.dbo.tinubu format nul -c -fC -T
drop table dbo.Tinubu
select * into election.dbo.tinubu from 
openrowset(bulk 'C:\Users\HP\Desktop\EverSed\DataLeum\TinubuMaster_tweets.csv', formatfile='C:\Users\HP\Desktop\EverSed\DataLeum\tinubu.txt', firstrow=2) as a;
select * from dbo.tinubu

select* into election.dbo.TheCandidate from 
openrowset(bulk 'C:\Users\HP\Desktop\EverSed\DataLeum\fffMasterListObi_tweets.csv', FORMATFILE='C:\Users\HP\Desktop\EverSed\DataLeum\finale.txt',
FIRSTROW=2) as a;

SELECT year(Date) as year,username, location, retweetcount, likecount, source,cleaned_tweets, subjectivity,polarity, sentiment FROM dbo.tinubu
group by Date, username,location, retweetcount,likecount,source,cleaned_tweets,subjectivity,polarity,sentiment
order by year asc

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, 'Û', '')

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, 'ä', '')

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, 'ª', '')

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, '÷', '')

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, 'Ô', '')

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, 'Ü', '')

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, '?', '')

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, '[', '')

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, ']', '')

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, '(', '')

Update dbo.tinubu
SET cleaned_tweets = replace(cleaned_tweets, ')', '')

WITH lection AS (
    SELECT location,
        ROW_NUMBER() OVER (
            PARTITION BY 
               location
            ORDER BY 
              location
        ) row_num
     FROM 
        dbo.tinubu
)
select * from lection WHERE row_num = 1;

select distinct location, count(location) locationcount from dbo.tinubu
group by location
order by location asc 

update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=2) 

update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=3) 

update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=4) 

update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=5) 

update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=6) 

update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=7) 

update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=8)

update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=9) 

update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=13) 
update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=15)

update dbo.tinubu 
set location= 'unknown' where location in (select location from dbo.tinubu group by location having count(*)=44)


select location from dbo.tinubu where location = 'unknown'

update dbo.tinubu 
set location='uknown' where location in (select location from dbo.tinubu  where location !='"Lefkosa, North cyprus"' and location !='"Auckland, New Zealand"' and location !='Ocala & Port Orange Florida'  group by location having count(*)=10) 

update dbo.tinubu 
set location='uknown' where location in (select location from dbo.tinubu  where location !='"South Dublin, Ireland"' and location !='Portharcout' and location !='"Atlanta, Georgia."'  group by location having count(*)=12) 

update dbo.tinubu 
set location='unknown' where location in (select location from dbo.tinubu  where location !='"Bellingham, England"'
and location !='"Las Vegas, NV"' and location !='Winterfell '   and location !='Dublin' and location !='"Harlem, New York"'  and location !='"Vancouver BC, Seattle WA"' and location !='"New Orleans, LA"' group by location having count(*)=14)

update dbo.tinubu 
set location='unknown' where location in (select location from dbo.tinubu  where location !='"Bellingham, England"'
and location !='"Las Vegas, NV"' and location !='Winterfell '   and location !='Dublin' and location !='"Harlem, New York"'  
and location !='"Vancouver BC, Seattle WA"' and location !='"New Orleans, LA"' group by location having count(*)=16)

update dbo.tinubu 
set location='unknown' where location in (select location from dbo.tinubu  where location !='"Wales, United Kingdom"'
and location !='"Las Vegas, NV"' and location !='Winterfell '   and location !='Dublin' and location !='AmsterdamHomeTown'and location !='"Vancouver BC, Seattle WA"' and location !='"Sandton, South Africa"' group by location having count(*)=17)

update dbo.tinubu 
set location='unknown' where location in (select location from dbo.tinubu  where location !='"Wales, United Kingdom"'
and location !='"Las Vegas, NV"' and location !='Winterfell '   and location !='Dublin' and location !='AmsterdamHomeTown'and location !='"Vancouver BC, Seattle WA"' and location !='"Sandton, South Africa"' group by location having count(*)=18)

update dbo.tinubu 
set location='unknown' where location in (select location from dbo.tinubu  where location !='"Pretoria, South Africa"'
and location !='Georgia' group by location having count(*)=19)

update dbo.tinubu 
set location='unknown' where location in (select location from dbo.tinubu  where location !='"Beverly Hills, California, USA"'
and location !='"Delaware, USA"' group by location having count(*)=20)

update dbo.tinubu 
set location='unknown' where location in (select location from dbo.tinubu  where location !='Portharcout'
and location !='Ogbomoso' group by location having count(*)=22)

update dbo.tinubu 
set location='unknown' where location in (select location from dbo.tinubu  where location !='"Dublin, Ireland"'
and location !='Ogbomoso' group by location having count(*)=23)


update dbo.tinubu 
set location='unknown' where location in (select location from dbo.tinubu  where location !='Kenya'
and location !='Ogbomoso' group by location having count(*)=28)

update dbo.tinubu 
set location='unknown' where location in (select location from dbo.tinubu  where location !='"Alberta, Canada"'
and location !='"Aberdeen, Scotland"' and location!='United  Kingdom' and location !='Maryland | Virginia | DC ' group by location having count(*)=37)


 
/* this will convert all address with a single word of states in Nigeria*/
update dbo.tinubu 
set location= 'lagos' where location in (select location from dbo.tinubu where location like '%#DisturbingGidi%' or location like '%Lasqidi%') 

update dbo.tinubu 
set location= 'lagos' where location in (select location from dbo.tinubu where location like '%Kalakuta %' or location like '%ikotun Lag%') 

update dbo.tinubu 
set location= 'lagos' where location in (select location from dbo.tinubu where location like '%City of possibility:  Las Gidi%' or location like '%Lasgidi%') 

update dbo.tinubu 
set location= 'lagos' where location in (select location from dbo.tinubu where location like '%IKEJA %' or location like '%Sango Ota%') 



update dbo.tinubu 
set location= 'lagos' where location in (select location from dbo.tinubu where location like '%City of "LAS GIDI"%' or location like '%City of "LAS GIDI"%') 
update dbo.tinubu 
set location= 'lagos' where location in (select location from dbo.tinubu where location like '%City of "LAS GIDI"%' or location like '%eKO%') 
update dbo.tinubu 
set location= 'Ghana' where location in (select location from dbo.tinubu where location like '%Ghana"%' or location like '%Accra%') 

update dbo.tinubu
set location= 'New Zealand' where location IN (select location from dbo.tinubu where location like '% Auckland, New Zealand%')

update dbo.tinubu
set location= 'Kaduna' where location IN (select location from dbo.tinubu where location like '%Kadun%')

update dbo.tinubu
set location= 'Texas' where location IN (select location from dbo.tinubu where location like '%Houston, Texas%')


update dbo.tinubu
set location= 'North cyprus' where location IN (select location from dbo.tinubu where location like '%Lefkosa, North cyprus%')

update dbo.tinubu 
set location= 'Abuja' where location in (select location from dbo.tinubu where location like '%Abuja%' or location like '%FCT%')

update dbo.tinubu 
set location= 'Abia' where location in (select location from dbo.tinubu where location like '%Abia%' or location like '%Abia%') 

update dbo.tinubu 
set location= 'Adamawa' where location in (select location from dbo.tinubu where location like '%Maiduguri%') 

update dbo.tinubu 
set location= 'Akwa Ibom' where location in (select location from dbo.tinubu where location like '%Akwa%' or location like '%Ibom%') 

update dbo.tinubu 
set location= 'Anambra' where location in (select location from dbo.tinubu where location like '%Anambra%')

update dbo.tinubu 
set location= 'Bauchi' where location in (select location from dbo.tinubu where location like '%Bauchi%' or location like '%Bauchi%')

update dbo.tinubu 
set location= 'Bayelsa' where location in (select location from dbo.tinubu where location like '%Bayelsa%')

update dbo.tinubu 
set location= 'Benue' where location in (select location from dbo.tinubu where location like '%Benue%')

update dbo.tinubu 
set location= 'Borno' where location in (select location from dbo.tinubu where location like '%Borno%')

update dbo.tinubu 
set location= 'Cross River' where location in (select location from dbo.tinubu where location like '%Cross River%')

update dbo.tinubu 
set location= 'Delta' where location in (select location from dbo.tinubu where location like '%Delta%')

update dbo.tinubu 
set location= 'Ebonyi' where location in (select location from dbo.tinubu where location like '%Ebonyi%')

update dbo.tinubu 
set location= 'Edo' where location in (select location from dbo.tinubu where location like '%Edo%')

update dbo.tinubu 
set location= 'Ekiti' where location in (select location from dbo.tinubu where location like '%Ekiti%')

update dbo.tinubu 
set location= 'Enugu' where location in (select location from dbo.tinubu where location like '%Enugu%')

update dbo.tinubu 
set location= 'Gombe' where location in (select location from dbo.tinubu where location like '%Gombe%')

update dbo.tinubu 
set location= 'Imo' where location in (select location from dbo.tinubu where location like '%Imo%')

update dbo.tinubu 
set location= 'Jigawa' where location in (select location from dbo.tinubu where location like '%Jigawa%')

update dbo.tinubu 
set location= 'Kaduna' where location in (select location from dbo.tinubu where location like '%Kaduna%')

update dbo.tinubu 
set location= 'Kano' where location in (select location from dbo.tinubu where location like '%Kano%')

update dbo.tinubu 
set location= 'Katsina' where location in (select location from dbo.tinubu where location like '%Katsina%')

update dbo.tinubu 
set location= 'Kebbi' where location in (select location from dbo.tinubu where location like '%Kebbi%')

update dbo.tinubu 
set location= 'Kogi' where location in (select location from dbo.tinubu where location like '%Kogi%')

update dbo.tinubu 
set location= 'kwara' where location in (select location from dbo.tinubu where location like '%Ilorin ðŸ‡³ðŸ‡¬%')

update dbo.tinubu 
set location= 'Nasarawa' where location in (select location from dbo.tinubu where location like '%Nasarawa%')

update dbo.tinubu 
set location= 'Niger' where location in (select location from dbo.tinubu where location like '%Niger%')

update dbo.tinubu 
set location= 'Ogun' where location in (select location from dbo.tinubu where location like '%ABEOKUTA%')

update dbo.tinubu 
set location= 'Ondo' where location in (select location from dbo.tinubu where location like '%Ondo%')

update dbo.tinubu 
set location= 'Osun' where location in (select location from dbo.tinubu where location like '%Osun%')

update dbo.tinubu 
set location= 'Oyo' where location in (select location from dbo.tinubu where location like '%Oyo%')
update dbo.tinubu 
set location= 'Oyo' where location in (select location from dbo.tinubu where location like '%Oyo%')
update dbo.tinubu 
set location= 'Oyo' where location in (select location from dbo.tinubu where location like '%Ibadan city%')
update dbo.tinubu 
set location= 'Abuja' where location in (select location from dbo.tinubu where location like '%Abj%')


update dbo.tinubu 
set location= 'Plateau' where location in (select location from dbo.tinubu where location like '%Plateau%')

update dbo.tinubu 
set location= 'Rivers' where location in (select location from dbo.tinubu where location like '%Rivers%')

update dbo.tinubu 
set location= 'Sokoto' where location in (select location from dbo.tinubu where location like '%Sokoto')

update dbo.tinubu 
set location= 'Taraba' where location in (select location from dbo.tinubu where location like '%Taraba%')

update dbo.tinubu 
set location= 'Yobe' where location in (select location from dbo.tinubu where location like '%Yobe%')

update dbo.tinubu 
set location= 'Zamfara' where location in (select location from dbo.tinubu where location like '%Zamfara%')

update dbo.tinubu 
set location= 'Portharcout' where location in (select location from dbo.tinubu where location like '%Port-Harcourt%')

select count(location) from dbo.tinubu where location=''


Update dbo.tinubu 
Set location =replace(location,'','unknown')



update table 
   set valid = -1 
                from table 
               where id = GIVEN_ID
            group by id
              having count(1) >3)

			  select id, count(*) from crime 
group by id
having count(*) > 1;

/*Political analysis of Atiku*/ 


