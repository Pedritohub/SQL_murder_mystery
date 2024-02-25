--Getting details from the crime_scene_report
select * 
from crime_scene_report
where city = 'SQL City' and type = 'murder' and date = '20180115';

--Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave

--FIRST WITHNESS CODE
select * 
from person
where address_street_name = 'Northwestern Dr'
order by address_number Desc;

--14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949

--2ND WITNESS
select * 
from person
where address_street_name = 'Franklin Ave'
order by name asc

  --6371 Annabel Miller	490173	103	Franklin Ave	318771143

--FIRST WITNESS INTERVIEW
select *   
from interview
where person_id = '14887';

--I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".

--following a lead from the first witness statement
select * 
from get_fit_now_member
where membership_status ='gold';

select * 
from drivers_license
where plate_number like '%H42W%';

--FIRST SUSPECT
select * 
from person
where license_id = '183779';


--SECOND SUSPECT
select * 
from person
where license_id = '423327';

--2nd SUS GYM DETAILS
select * 
from get_fit_now_member
where membership_status = 'gold' and person_id = '67318';


--SECOND SUSPECT INTERVIEW
select * 
from interview
where person_id = '67318';

--person_id	transcript
--67318		I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.


--SUSPECT MURDERER DVLA DETAILS
select * 
from drivers_license
where hair_color = 'red' and gender = 'female' and car_make = 'Tesla' and height = '65';


  --MURDERER DETAILS
WITH CTE AS
(SELECT p.id, p.name, p.license_id, d.*
  FROM drivers_license d
  JOIN person p on d.id=p.license_id
  WHERE gender = 'female'
  AND car_make = 'Tesla'
  AND car_model = 'Model S'
  AND hair_color = 'red'
)
SELECT fb.*,p.id,p.name, count(person_id) AS attendance
  FROM facebook_event_checkin fb
  JOIN CTE p on p.id=fb.person_id
  where event_name like '%symphony%'
  AND date between 20171131 and 20180101
  GROUP BY person_id
  HAVING attendance =3
  ORDER BY attendance desc










	




