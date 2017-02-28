set search_path to sepsis; 
DROP VIEW IF EXISTS VASO_IDs CASCADE; 
CREATE VIEW VASO_IDS AS
(
	select distinct hadm_id from 
		(select distinct hadm_id from mimiciiifull.inputevents_mv
		  where itemid in(5752,30119,30309,30044,221289,3112,221906,30047,30120,30306,30042,221653,5329,30043,30307,221662,6752,221749)
		  and hadm_id in (select distinct hadm_id from mimiciiifull.vitalsfirstday) 
		  
		  UNION 
		  select distinct hadm_id from mimiciiifull.inputevents_cv
		  where itemid in(5752,30119,30309,30044,221289,3112,221906,30047,30120,30306,30042,221653,5329,30043,30307,221662,6752,221749)
		  and hadm_id in (select distinct hadm_id from mimiciiifull.vitalsfirstday) 
		 ) as inputcv
);

drop materialized view if exists dependent_variables1 cascade; 

create materialized view dependent_variables1 as
(
select blood_variables.* 				
	    , case when blood_variables.height is not null then
	    		blood_variables.height
	    		when heights.height is not null then
	    		heights.height
	    		else null end as height_everywhere
	    , case when fio2_min is not null then 
	    		fio2_min 
	    		when fio2_min_everywhere is not null then 
	    		fio2_min_everywhere
	    		else null end as fio2_min_final
	    , case when paco2_max is not null then 
	    		paco2_max
	    		when paco2_max_everywhere is not null then
	    		paco2_max_everywhere
	    		else null end as paco2_max_final
	    
					
	from blood_variables left join heights 
		on blood_variables.subject_id = heights.subject_id
); 

