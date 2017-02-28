			
--Select patients with septic shock defined as:
--     - Organ dysfunction = SOFA score >= 2 as a surrogate of SEPSIS III criterion 'acute increase in SOFA score >= 2 points'
--     + Blood lactate levels > 2 AND MAP < 65 OR need of vasopressors as a surrogate of SEPSIS III criterion 'persisting hypotension requiring 
--vasopressors to maintain MAP ???65 mm Hg and having a serum lactate level >2 mmol/L'

set search_path to sepsis; 

		 		 		
DROP MATERIALIZED VIEW IF EXISTS septicshock_patients cascade; 

CREATE MATERIALIZED VIEW septicshock_patients AS
(
select 
 subject_id,
	   hadm_id,
	   troponin_max,
	   heartrate_max, 
	   heartrate_min,
	   SodiumBicarbonate_Min,
	   Lactatedehydrogenase_max,
	   BNatriureticPeptide_Max,
	   CReactiveProtein_Max,
	   Triglycerides_Min,
	   Cholestrol_Min,
	   cholesterolratio_min,
	   HighDensityLipoprotein_Min, 
	   LowDensityLipoprotein_Min
	   ,Temperature_Min
	   ,Temperature_Max
	   ,SysBP_Min
	   ,DiasBP_Min
	   ,MeanBP_Min
	   ,Spontaneous_respiratory_rate_Min
	   ,Spontaneous_respiratory_rate_Max
	   ,MAP_MIN, 
	   CardiacIndex_Min,
	   CardiacIndex_Max,
	   StrokeIndex_Min,
	   SystemicVascularResistancesIndex_Min,
	   SystemicVascularResistancesIndex_Max,
	   CentralVenousPressure_Min,
	   CentralVenousPressure_Max,
	   PeripheralSaturation_Min,
	   CentralVenousOxygenSaturation_Min,
	   CentralVenousOxygenSaturation_Max,
	   PaCO2_Max,
	   PvCO2_Max,
	   fio2_min,
	   Creatinine_Max,
	   WhiteBloodCellCount_Min,
	   WhiteBloodCellCount_Max, 
	   Neutrophils_Min,
	   Neutrophils_Max,
	   Eosinophils_Min,
	   Eosinophils_Max,
	   Lymphocytes_Min,
	   Lymphocytes_Max,
	   AtypicalLeukocytes_Min,
	   AtypicalLeukocytes_Max,
	   Bandforms_Min,
	   Bandforms_Max, 
	   Platelets_Min, 
	   DDimer_Max,
	   INR_Max,
	   PTT_Max,
	   Fibrinogen_Max,
	   Glucose_Min,
	   Glucose_Max,
	   Albumin_Min, 
	   Sodium_Min, 
	    Sodium_Max, 
	    Potassium_Min,
	    Potassium_Max, 
	    Chloride_Min, 
	    Chloride_Max, 
	   Magnesium_Min,
	   Magnesium_Max,
	    Bilirubin_Max, 
	   AST_Max,
	   ALT_Max,
	   Urea_Max,
	   PFRatio,
	   AlkalinePhosphatase,
	   NEUTROPHILS_LYMPHOCYTE_RATIO_MIN,
	   NEUTROPHILS_LYMPHOCYTE_RATIO_Max,
	   CAO2_min,
	   DELTACO2_Max,
	   
	   --Non-clustering variables
	    lactate_max,
	    haemoglobin_Min,
	    ArterialpH_max,
            ArterialpH_min,
            vaso,
            pao2,sao2,
		
		--sofa scores
		sofa, 
		respiration,
		coagulation,
		liver,
		cardiovascular,
		cns,
		renal




		from sepsis.sepsis_vitals_sofa
		where 
		lactate_max is not null and
		lactate_max > 2 and
		sofa >=2 AND
		(MAP_MIN < 65 or Vaso = TRUE)
)