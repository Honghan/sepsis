set search_path to mimiciiifull; 
drop  materialized view if exists sepsis.allevents cascade;

create materialized view sepsis.allevents as

select 	chartevents.subject_id, 
		chartevents.hadm_id, 
		chartevents.itemid,
		chartevents.charttime as time, 
		chartevents.value as value,
		chartevents.valuenum, 
		chartevents.valueuom

		from chartevents left join icustays 
				on (chartevents.hadm_id = icustays.hadm_id and chartevents.subject_id = icustays.subject_id)
				where chartevents.itemid in(select distinct itemid from sepsis.all_items)
						and chartevents.charttime between icustays.intime and icustays.intime + interval '1' day 
						and chartevents.error IS DISTINCT FROM 1
						

union 

--the height, no time constraints, just get height from everywhere
select 	chartevents.subject_id, 
		chartevents.hadm_id, 
		chartevents.itemid,
		chartevents.charttime as time, 
		chartevents.value as value,
		chartevents.valuenum, 
		chartevents.valueuom

		from chartevents left join icustays 
				on (chartevents.hadm_id = icustays.hadm_id and chartevents.subject_id = icustays.subject_id)
				where chartevents.itemid in(920,1394,226707)
						and chartevents.error IS DISTINCT FROM 1
								
union 
select 	inputevents_cv.subject_id, 
		inputevents_cv.hadm_id, 
		inputevents_cv.itemid,
		inputevents_cv.charttime as time, 
		cast(inputevents_cv.amount as character varying) as value,
		inputevents_cv.amount as valuenum, 
		inputevents_cv.amountuom as valueuom


		from inputevents_cv left join icustays 
				on (inputevents_cv.hadm_id = icustays.hadm_id and inputevents_cv.subject_id = icustays.subject_id)

				where inputevents_cv.itemid in(select distinct itemid from sepsis.all_items)
				and inputevents_cv.charttime between icustays.intime and icustays.intime + interval '1' day 

union 
select 	inputevents_mv.subject_id, 
		inputevents_mv.hadm_id, 
		inputevents_mv.itemid,
		inputevents_mv.starttime as time, 
		cast(inputevents_mv.amount as character varying) as value,
		inputevents_mv.amount as valuenum, 
		inputevents_mv.amountuom as valueuom

		from inputevents_mv left join icustays 
				on (inputevents_mv.hadm_id = icustays.hadm_id and inputevents_mv.subject_id = icustays.subject_id)

				where inputevents_mv.itemid in(select distinct itemid from sepsis.all_items)
				and inputevents_mv.starttime between icustays.intime and icustays.intime + interval '1' day 
			
union 

select 	outputevents.subject_id, 
		outputevents.hadm_id, 
		outputevents.itemid,
		outputevents.charttime as time, 
		cast(outputevents.value as character varying) as value,
		-1 as valuenum,
		outputevents.valueuom

		from outputevents left join icustays 
				on (outputevents.hadm_id = icustays.hadm_id and outputevents.subject_id = icustays.subject_id)

				where outputevents.itemid in(select distinct itemid from sepsis.all_items)
				and outputevents.charttime between icustays.intime and icustays.intime + interval '1' day 

	union


select 	procedureevents_mv.subject_id, 
		procedureevents_mv.hadm_id, 
		procedureevents_mv.itemid,
		procedureevents_mv.starttime as time, 
		cast(procedureevents_mv.value as character varying) as value,
		-5 as valuenum,
		--procedureevents_mv.orderid as valuenum, 
		procedureevents_mv.valueuom

		from procedureevents_mv left join icustays 
				on (procedureevents_mv.hadm_id = icustays.hadm_id and procedureevents_mv.subject_id = icustays.subject_id)

				where procedureevents_mv.itemid in(select distinct itemid from sepsis.all_items)
				and procedureevents_mv.starttime between icustays.intime and icustays.intime + interval '1' day 

union
select 	labevents.subject_id, 
		labevents.hadm_id, 
		labevents.itemid,
		labevents.charttime as time, 
		labevents.value,
		labevents.valuenum, 
		labevents.valueuom

		from labevents left join icustays 
				on (labevents.hadm_id = icustays.hadm_id and labevents.subject_id = icustays.subject_id)

				where labevents.itemid in(select distinct itemid from sepsis.all_items)
				and labevents.charttime between icustays.intime and icustays.intime + interval '1' day 