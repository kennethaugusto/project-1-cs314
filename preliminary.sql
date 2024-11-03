DROP TABLE IF EXISTS preliminary;

CREATE TABLE preliminary (
    as_of_year INTEGER,
    respondent_id VARCHAR(10),
    agency_name VARCHAR(50),
    agency_abbr VARCHAR(5),
    agency_code VARCHAR(1),
    loan_type_name VARCHAR(30),
    loan_type INTEGER,
    property_type_name VARCHAR(65),
    property_type VARCHAR(1),
    loan_purpose_name VARCHAR(20),
    loan_purpose INTEGER,
    owner_occupancy_name VARCHAR(50),
    owner_occupancy INTEGER,
    loan_amount_000s INTEGER,
    preapproval_name VARCHAR(30),
    preapproval VARCHAR(1),
    action_taken_name VARCHAR(55),
    action_taken INTEGER,
    msamd_name VARCHAR(50),
    msamd VARCHAR(5),
    state_name VARCHAR(15),
    state_abbr CHAR(2),
    state_code VARCHAR(2),
    county_name VARCHAR(20),
    county_code VARCHAR(3),
    census_tract_number VARCHAR(7),
    applicant_ethnicity_name VARCHAR(90),
    applicant_ethnicity VARCHAR(1),
    co_applicant_ethnicity_name VARCHAR(90),
    co_applicant_ethnicity VARCHAR(1),
    applicant_race_name_1 VARCHAR(90),
    applicant_race_1 VARCHAR(1),
    applicant_race_name_2 VARCHAR(50),
    applicant_race_2 VARCHAR(1),
    applicant_race_name_3 VARCHAR(50),
    applicant_race_3 VARCHAR(1),
    applicant_race_name_4 VARCHAR(50),
    applicant_race_4 VARCHAR(1),
    applicant_race_name_5 VARCHAR(50),
    applicant_race_5 VARCHAR(1),
    co_applicant_race_name_1 VARCHAR(90),
    co_applicant_race_1 VARCHAR(1),
    co_applicant_race_name_2 VARCHAR(50),
    co_applicant_race_2 VARCHAR(1),
    co_applicant_race_name_3 VARCHAR(50),
    co_applicant_race_3 VARCHAR(1),
    co_applicant_race_name_4 VARCHAR(50),
    co_applicant_race_4 VARCHAR(1),
    co_applicant_race_name_5 VARCHAR(50),
    co_applicant_race_5 VARCHAR(1),
    applicant_sex_name VARCHAR(90),
    applicant_sex INTEGER,
    co_applicant_sex_name VARCHAR(90),
    co_applicant_sex INTEGER,
    applicant_income_000s VARCHAR(8),
    purchaser_type_name VARCHAR(80),
    purchaser_type VARCHAR(1),
    denial_reason_name_1 VARCHAR(50),
    denial_reason_1 VARCHAR(1),
    denial_reason_name_2 VARCHAR(50),
    denial_reason_2 VARCHAR(1),
    denial_reason_name_3 VARCHAR(50),
    denial_reason_3 VARCHAR(1),
    rate_spread VARCHAR(5),
    hoepa_status_name VARCHAR(20),
    hoepa_status VARCHAR(1),
    lien_status_name VARCHAR(35),
    lien_status VARCHAR(1),
    edit_status_name VARCHAR(50),
    edit_status VARCHAR(1),
    sequence_number VARCHAR(7),
    population VARCHAR(8),
    minority_population VARCHAR(20),
    hud_median_family_income INTEGER, 
    tract_to_msamd_income VARCHAR(20),
    number_of_owner_occupied_units VARCHAR(8),
    number_of_1_to_4_family_units VARCHAR(8),
    application_date_indicator INTEGER
);

COPY preliminary FROM 'C:\Program Files\PostgreSQL\17\import\hmda_2017_nj_all-records_labels.csv' (FORMAT csv, HEADER true, DELIMITER ',', NULL '', FORCE_NULL (application_date_indicator, hud_median_family_income, loan_amount_000s));
-- Used https://www.postgresql.org/docs/17/sql-copy.html

