set search_path to sepsis; 


drop materialized view if exists VitalAndOutcomes_SS cascade;  
create materialized view VitalAndOutcomes_SS as
(

select * 
	from Vitals_SS 
	left join 
	(
	select 
		hadm_id as adm,
		
		case when deathtime is not null then 
				TRUE	
			else FALSE end as dead
		, 
		admittime
		,
		dischtime  - admittime as los
			
	from mimiciiifull.admissions
	) outcomes 
	on Vitals_SS.hadm_id = outcomes.adm
	order by subject_id, hadm_id
	 
)
