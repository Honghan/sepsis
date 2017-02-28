set search_path to sepsis; 


drop materialized view if exists Final_SS; 
create materialized view Final_SS as
(

select * ,

	case when cast(date_part('year',age(admittime,dob) ) as double precision) > 299 then 
		90
		else
		cast(date_part('year',age(admittime,dob) ) as double precision) end  as age
 	from Almost_Final_SS	
 	order by subject_id
	 
);


select hadm_id, subject_id, age from final_ss; 
select *  from final_ss where troponin_max is not null and bilirubin_max is not null; 