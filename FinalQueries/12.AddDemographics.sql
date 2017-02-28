set search_path to sepsis; 


drop materialized view if exists Almost_Final_SS; 
create materialized view Almost_Final_SS as
(

select * 
	from VitalAndOutcomes_SS 
	left join 
	(
	select 
		subject_id as sbj
		, gender
--		, date_part('year',age(dob,current_date) )as age
		, dob
			
	from mimiciiifull.patients
	) demographics
	
	on VitalAndOutcomes_SS.subject_id = demographics.sbj
	order by subject_id
	 
)
