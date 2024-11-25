DROP TABLE IF EXISTS preliminary;

CREATE TABLE preliminary (
     as_of_year SMALLINT,
     respondent_id VARCHAR(10),
     agency_name VARCHAR(43),
     agency_abbr VARCHAR(4),
     agency_code SMALLINT,
     loan_type_name VARCHAR(18),
     loan_type SMALLINT,
     property_type_name VARCHAR(61),
     property_type SMALLINT,
     loan_purpose_name VARCHAR(16),
     loan_purpose SMALLINT,
     owner_occupancy_name VARCHAR(42),
     owner_occupancy SMALLINT,
     loan_amount_000s INTEGER,
     preapproval_name VARCHAR(29),
     preapproval SMALLINT,
     action_taken_name VARCHAR(51),
     action_taken SMALLINT,
     msamd_name VARCHAR(44),
     msamd INTEGER,
     state_name VARCHAR(10),
     state_abbr CHAR(2),
     state_code SMALLINT,
     county_name VARCHAR(17),
     county_code SMALLINT,
     census_tract_number NUMERIC(7,2),
     applicant_ethnicity_name VARCHAR(100),
     applicant_ethnicity SMALLINT,
     co_applicant_ethnicity_name VARCHAR(100),
     co_applicant_ethnicity SMALLINT,
     applicant_race_name_1 VARCHAR(100),
     applicant_race_1 SMALLINT,
     applicant_race_name_2 VARCHAR(41),
     applicant_race_2 SMALLINT,
     applicant_race_name_3 VARCHAR(41),
     applicant_race_3 SMALLINT,
     applicant_race_name_4 VARCHAR(41),
     applicant_race_4 SMALLINT,
     applicant_race_name_5 VARCHAR(5),
     applicant_race_5 SMALLINT,
     co_applicant_race_name_1 VARCHAR(81),
     co_applicant_race_1 SMALLINT,
     co_applicant_race_name_2 VARCHAR(41),
     co_applicant_race_2 SMALLINT,
     co_applicant_race_name_3 VARCHAR(41),
     co_applicant_race_3 SMALLINT,
     co_applicant_race_name_4 VARCHAR(41),
     co_applicant_race_4 SMALLINT,
     co_applicant_race_name_5 VARCHAR(5),
     co_applicant_race_5 SMALLINT,
     applicant_sex_name VARCHAR(100),
     applicant_sex SMALLINT,
     co_applicant_sex_name VARCHAR(100),
     co_applicant_sex SMALLINT,
     applicant_income_000s INTEGER,
     purchaser_type_name VARCHAR(100),
     purchaser_type SMALLINT,
     denial_reason_name_1 VARCHAR(50),
     denial_reason_1 SMALLINT,
     denial_reason_name_2 VARCHAR(50),
     denial_reason_2 SMALLINT,
     denial_reason_name_3 VARCHAR(50),
     denial_reason_3 SMALLINT,
     rate_spread NUMERIC(5,2),
     hoepa_status_name VARCHAR(20),
     hoepa_status SMALLINT,
     lien_status_name VARCHAR(35),
     lien_status SMALLINT,
     edit_status_name VARCHAR(29),
     edit_status SMALLINT,
     sequence_number INTEGER,
     population INTEGER,
     minority_population NUMERIC(15,2),
     hud_median_family_income INTEGER,
     tract_to_msamd_income NUMERIC(16,2),
     number_of_owner_occupied_units INTEGER,
     number_of_1_to_4_family_units INTEGER,
     application_date_indicator SMALLINT
 );
 
 
 COPY preliminary FROM 'C:\Users\cshah\Desktop\hmda_2017_nj_all-records_labels.csv' (FORMAT csv, HEADER true, DELIMITER ',', NULL '', FORCE_NULL(number_of_1_to_4_family_units, number_of_owner_occupied_units, tract_to_msamd_income, minority_population, population, census_tract_number, county_code, msamd, sequence_number, edit_status, applicant_income_000s, denial_reason_1, denial_reason_2, denial_reason_3, applicant_race_1, applicant_race_2, applicant_race_3, applicant_race_4, applicant_race_5, co_applicant_race_1, co_applicant_race_2, co_applicant_race_3, co_applicant_race_4, co_applicant_race_5, as_of_year, agency_code, loan_type, property_type, loan_purpose, owner_occupancy, loan_amount_000s, preapproval, action_taken, applicant_sex, co_applicant_sex, purchaser_type, rate_spread, hoepa_status, lien_status, hud_median_family_income, application_date_indicator));


DROP TABLE IF EXISTS Ethnicity CASCADE;
DROP TABLE IF EXISTS RaceCode CASCADE;
DROP TABLE IF EXISTS Sex CASCADE;
DROP TABLE IF EXISTS Agency CASCADE;
DROP TABLE IF EXISTS PurchaserType CASCADE;
DROP TABLE IF EXISTS PropertyType CASCADE;
DROP TABLE IF EXISTS LoanType CASCADE;
DROP TABLE IF EXISTS LoanPurpose CASCADE;
DROP TABLE IF EXISTS State CASCADE;
DROP TABLE IF EXISTS County CASCADE;
DROP TABLE IF EXISTS MSAMD CASCADE;
DROP TABLE IF EXISTS Preapproval CASCADE;
DROP TABLE IF EXISTS OwnerOccupancy CASCADE;
DROP TABLE IF EXISTS ActionTaken CASCADE;
DROP TABLE IF EXISTS HoepaStatus CASCADE;
DROP TABLE IF EXISTS LienStatus CASCADE;
DROP TABLE IF EXISTS NullTable CASCADE;
DROP TABLE IF EXISTS Applicant CASCADE;
DROP TABLE IF EXISTS ApplicantRace CASCADE;
DROP TABLE IF EXISTS CoapplicantRace CASCADE;
DROP TABLE IF EXISTS Property CASCADE;
DROP TABLE IF EXISTS Location CASCADE;
DROP TABLE IF EXISTS Application CASCADE;
DROP TABLE IF EXISTS DenialCode CASCADE;
DROP TABLE IF EXISTS DenialReasons CASCADE;

ALTER TABLE preliminary ADD COLUMN id SERIAL PRIMARY KEY;
-- tables with no depencies
CREATE TABLE Ethnicity(
    ethnicity VARCHAR(1) PRIMARY KEY,
    ethnicity_name VARCHAR(90)
); -- make sure to select distinct ethnicity + name from coapplicant AND applicant ethnicity data

CREATE TABLE RaceCode(
    race_code VARCHAR(1) PRIMARY KEY,
    race_name VARCHAR(90)
); -- make sure to select distinct race data from coapplicant AND applicant data (all 5!!!)

CREATE TABLE Sex(
    sex INTEGER PRIMARY KEY,
    sex_name VARCHAR(90)
); -- select distinct sex?

CREATE TABLE Agency(
    agency_code INTEGER PRIMARY KEY,
    agency_name VARCHAR(50),
    agency_abbr VARCHAR(5)
);

CREATE TABLE PurchaserType(
    purchaser_type INTEGER PRIMARY KEY,
    purchaser_type_name VARCHAR(80)
);

CREATE TABLE PropertyType(
    property_type INTEGER PRIMARY KEY, 
    property_type_name VARCHAR(65)
);

CREATE TABLE LoanType(
    loan_type INTEGER PRIMARY KEY,
    loan_type_name VARCHAR(30)
);

CREATE TABLE LoanPurpose(
    loan_purpose INTEGER PRIMARY KEY,
    loan_purpose_name VARCHAR(20)
);

CREATE TABLE State(
    state_code VARCHAR(2) PRIMARY KEY,
    state_name VARCHAR(15),
    state_abbr CHAR(2)
);

CREATE TABLE County(
    county_code VARCHAR(3) PRIMARY KEY,
    county_name VARCHAR(20)
);

CREATE TABLE MSAMD(
    msamd VARCHAR(5) PRIMARY KEY,
    msamd_name VARCHAR(50)
);

CREATE TABLE Preapproval(
    preapproval INTEGER PRIMARY KEY,
    preapproval_name VARCHAR(30)
);

CREATE TABLE OwnerOccupancy(
    owner_occupancy INTEGER PRIMARY KEY,
    owner_occupancy_name VARCHAR(50)
);

CREATE TABLE ActionTaken(
    action_taken INTEGER PRIMARY KEY,
    action_taken_name VARCHAR(55)
);

CREATE TABLE HoepaStatus(
    hoepa_status INTEGER PRIMARY KEY,
    hoepa_status_name VARCHAR(20)
);

CREATE TABLE LienStatus(
    lien_status INTEGER PRIMARY KEY,
    lien_status_name VARCHAR(35)
);

CREATE TABLE DenialCode(
    denial_code VARCHAR(1) PRIMARY KEY,
    denial_name VARCHAR(50)
);

-- has dependencies
CREATE TABLE Application(
    application_id SERIAL PRIMARY KEY,
    prelim_id INTEGER,
    as_of_year INTEGER,
    respondent_id VARCHAR(10),
    agency_code INTEGER,
    loan_type INTEGER,
    loan_purpose INTEGER,
    owner_occupancy INTEGER,
    loan_amount_000s INTEGER,
    preapproval INTEGER,
    action_taken INTEGER,
    property_type INTEGER,
    purchaser_type INTEGER,
    rate_spread NUMERIC(5, 2),
    hoepa_status INTEGER,
    lien_status INTEGER,
    FOREIGN KEY (hoepa_status) REFERENCES HoepaStatus(hoepa_status),
    FOREIGN KEY (lien_status) REFERENCES LienStatus(lien_status),
    FOREIGN KEY (action_taken) REFERENCES ActionTaken(action_taken),
    FOREIGN KEY (property_type) REFERENCES PropertyType(property_type),
    FOREIGN KEY (purchaser_type) REFERENCES PurchaserType(purchaser_type),
    FOREIGN KEY (preapproval) REFERENCES Preapproval(preapproval),
    FOREIGN KEY (owner_occupancy) REFERENCES OwnerOccupancy(owner_occupancy),
    FOREIGN KEY (loan_purpose) REFERENCES LoanPurpose(loan_purpose),
    FOREIGN KEY (loan_type) REFERENCES LoanType(loan_type),
    FOREIGN KEY (agency_code) REFERENCES Agency(agency_code)
    
);

CREATE TABLE NullTable(
    application_id SERIAL,
    application_date_indicator INTEGER,
    sequence_number VARCHAR(7),
    edit_status_name VARCHAR(50),
    edit_status VARCHAR(1),
    FOREIGN KEY (application_id) REFERENCES Application(application_id)
);

CREATE TABLE Applicant(
	application_id INTEGER,
    applicant_ethnicity VARCHAR(1),
    applicant_sex INTEGER,
    coapplicant_ethnicity VARCHAR(1),
    coapplicant_sex INTEGER,
    applicant_income_000s VARCHAR(8),
    FOREIGN KEY (applicant_ethnicity) REFERENCES Ethnicity(ethnicity),
    FOREIGN KEY (coapplicant_ethnicity) REFERENCES Ethnicity(ethnicity),
    FOREIGN KEY (applicant_sex) REFERENCES Sex(sex),
    FOREIGN KEY (coapplicant_sex) REFERENCES Sex(sex),
    FOREIGN KEY (application_id) REFERENCES Application(application_id) 
);

CREATE TABLE DenialReasons(
    denial_num INTEGER,
    application_id INTEGER,
    denial_code VARCHAR(1),
    FOREIGN KEY (application_id) REFERENCES Application(application_id),
    FOREIGN KEY (denial_code) REFERENCES DenialCode(denial_code)
);

CREATE TABLE ApplicantRace(
    race_num INTEGER, -- if there are multiple applicant races, identify if its the first, second, etc
    application_id INTEGER,
    race_code VARCHAR(1),
    FOREIGN KEY (application_id) REFERENCES Application(application_id),
    FOREIGN KEY (race_code) REFERENCES RaceCode(race_code)
);

CREATE TABLE CoapplicantRace(
    race_num INTEGER, -- if there are multiple applicant races, identify if its the first, second, etc
    application_id INTEGER,
    race_code VARCHAR(1),
    FOREIGN KEY (application_id) REFERENCES Application(application_id),
    FOREIGN KEY (race_code) REFERENCES RaceCode(race_code)
);

CREATE TABLE Location(
    application_id INTEGER,
    msamd VARCHAR(5),
    state_code VARCHAR(2),
    county_code VARCHAR(3),
    census_tract_number VARCHAR(7),
    population VARCHAR(8),
    minority_population VARCHAR(20),
    hud_median_family_income INTEGER, 
    tract_to_msamd_income VARCHAR(20),
    number_of_owner_occupied_units VARCHAR(8),
    number_of_1_to_4_family_units VARCHAR(8),
    FOREIGN KEY (application_id) REFERENCES Application(application_id),
    FOREIGN KEY (msamd) REFERENCES MSAMD(msamd),
    FOREIGN KEY (state_code) REFERENCES State(state_code),
    FOREIGN KEY (county_code) REFERENCES County(county_code)
);

-- applicant ethnicities
INSERT INTO Ethnicity(ethnicity, ethnicity_name)
SELECT DISTINCT applicant_ethnicity, applicant_ethnicity_name FROM preliminary
WHERE applicant_ethnicity IS NOT NULL
ON CONFLICT(ethnicity) DO NOTHING;

-- coapplicant ethnicities
INSERT INTO Ethnicity(ethnicity, ethnicity_name)
SELECT DISTINCT co_applicant_ethnicity, co_applicant_ethnicity_name FROM preliminary
WHERE co_applicant_ethnicity IS NOT NULL
ON CONFLICT(ethnicity) DO NOTHING;

-- applicant race 1
INSERT INTO RaceCode(race_code, race_name)
SELECT DISTINCT applicant_race_1, applicant_race_name_1 FROM preliminary
WHERE applicant_race_1 IS NOT NULL
ON CONFLICT(race_code) DO NOTHING;

-- applicant race 2
INSERT INTO RaceCode(race_code, race_name)
SELECT DISTINCT applicant_race_2, applicant_race_name_2 FROM preliminary
WHERE applicant_race_2 IS NOT NULL
ON CONFLICT(race_code) DO NOTHING;

-- applicant race 3
INSERT INTO RaceCode(race_code, race_name)
SELECT DISTINCT applicant_race_3, applicant_race_name_3 FROM preliminary
WHERE applicant_race_3 IS NOT NULL
ON CONFLICT(race_code) DO NOTHING;

-- applicant race 4
INSERT INTO RaceCode(race_code, race_name)
SELECT DISTINCT applicant_race_4, applicant_race_name_4 FROM preliminary
WHERE applicant_race_4 IS NOT NULL
ON CONFLICT(race_code) DO NOTHING;

-- applicant race 5
INSERT INTO RaceCode(race_code, race_name)
SELECT DISTINCT applicant_race_5, applicant_race_name_5 FROM preliminary
WHERE applicant_race_5 IS NOT NULL
ON CONFLICT(race_code) DO NOTHING;

-- coapplicant race 1
INSERT INTO RaceCode(race_code, race_name)
SELECT DISTINCT co_applicant_race_1, co_applicant_race_name_1 FROM preliminary
WHERE co_applicant_race_1 IS NOT NULL
ON CONFLICT(race_code) DO NOTHING;

-- coapplicant race 2
INSERT INTO RaceCode(race_code, race_name)
SELECT DISTINCT co_applicant_race_2, co_applicant_race_name_2 FROM preliminary
WHERE co_applicant_race_2 IS NOT NULL
ON CONFLICT(race_code) DO NOTHING;

-- coapplicant race 3
INSERT INTO RaceCode(race_code, race_name)
SELECT DISTINCT co_applicant_race_3, co_applicant_race_name_3 FROM preliminary
WHERE co_applicant_race_3 IS NOT NULL
ON CONFLICT(race_code) DO NOTHING;

-- coapplicant race 4
INSERT INTO RaceCode(race_code, race_name)
SELECT DISTINCT co_applicant_race_4, co_applicant_race_name_4 FROM preliminary
WHERE co_applicant_race_4 IS NOT NULL
ON CONFLICT(race_code) DO NOTHING;

-- coapplicant race 5
INSERT INTO RaceCode(race_code, race_name)
SELECT DISTINCT co_applicant_race_5, co_applicant_race_name_5 FROM preliminary
WHERE co_applicant_race_5 IS NOT NULL
ON CONFLICT(race_code) DO NOTHING;

-- applicant sex
INSERT INTO Sex(sex, sex_name)
SELECT DISTINCT applicant_sex, applicant_sex_name FROM preliminary
WHERE applicant_sex IS NOT NULL
ON CONFLICT(sex) DO NOTHING;

-- coapplicant sex
INSERT INTO Sex(sex, sex_name)
SELECT DISTINCT co_applicant_sex, co_applicant_sex_name FROM preliminary
WHERE co_applicant_sex IS NOT NULL
ON CONFLICT(sex) DO NOTHING;

-- agency
INSERT INTO Agency(agency_code, agency_name, agency_abbr)
SELECT DISTINCT agency_code, agency_name, agency_abbr FROM preliminary
WHERE agency_code IS NOT NULL;

-- purchaser type
INSERT INTO PurchaserType(purchaser_type, purchaser_type_name)
SELECT DISTINCT purchaser_type, purchaser_type_name FROM preliminary
WHERE purchaser_type IS NOT NULL;

-- property type
INSERT INTO PropertyType(property_type, property_type_name)
SELECT DISTINCT property_type, property_type_name FROM preliminary
WHERE property_type IS NOT NULL;

-- loan type
INSERT INTO LoanType(loan_type, loan_type_name)
SELECT DISTINCT loan_type, loan_type_name FROM preliminary
WHERE loan_type IS NOT NULL;

-- loan purpose
INSERT INTO LoanPurpose(loan_purpose, loan_purpose_name)
SELECT DISTINCT loan_purpose, loan_purpose_name FROM preliminary
WHERE loan_purpose IS NOT NULL;

-- state
INSERT INTO State(state_code, state_name, state_abbr)
SELECT DISTINCT state_code, state_name, state_abbr FROM preliminary
WHERE state_code IS NOT NULL;

-- county
INSERT INTO County(county_code, county_name)
SELECT DISTINCT county_code, county_name FROM preliminary
WHERE county_code IS NOT NULL;

-- msamd
INSERT INTO MSAMD(msamd, msamd_name)
SELECT DISTINCT msamd, msamd_name FROM preliminary
WHERE msamd IS NOT NULL;

-- preapproval
INSERT INTO Preapproval(preapproval, preapproval_name)
SELECT DISTINCT preapproval, preapproval_name FROM preliminary
WHERE preapproval IS NOT NULL;

-- owner occupancy
INSERT INTO OwnerOccupancy(owner_occupancy, owner_occupancy_name)
SELECT DISTINCT owner_occupancy, owner_occupancy_name FROM preliminary
WHERE owner_occupancy IS NOT NULL;

-- action taken
INSERT INTO ActionTaken(action_taken, action_taken_name)
SELECT DISTINCT action_taken, action_taken_name FROM preliminary
WHERE action_taken IS NOT NULL;

-- hoepa status
INSERT INTO HoepaStatus(hoepa_status, hoepa_status_name)
SELECT DISTINCT hoepa_status, hoepa_status_name FROM preliminary
WHERE hoepa_status IS NOT NULL;

-- lien status
INSERT INTO LienStatus(lien_status, lien_status_name)
SELECT DISTINCT lien_status, lien_status_name FROM preliminary
WHERE lien_status IS NOT NULL;

-- denial code 1
INSERT INTO DenialCode(denial_code, denial_name)
SELECT DISTINCT denial_reason_1, denial_reason_name_1 FROM preliminary
WHERE denial_reason_1 IS NOT NULL
ON CONFLICT(denial_code) DO NOTHING;;

-- denial code 2
INSERT INTO DenialCode(denial_code, denial_name)
SELECT DISTINCT denial_reason_2, denial_reason_name_2 FROM preliminary
WHERE denial_reason_2 IS NOT NULL
ON CONFLICT(denial_code) DO NOTHING;;

-- denial code 3
INSERT INTO DenialCode(denial_code, denial_name)
SELECT DISTINCT denial_reason_3, denial_reason_name_3 FROM preliminary
WHERE denial_reason_3 IS NOT NULL
ON CONFLICT(denial_code) DO NOTHING;;

-- null table
INSERT INTO NullTable(application_id, application_date_indicator, sequence_number, edit_status, edit_status_name)
SELECT
    Application.application_id,
    preliminary.application_date_indicator,
    preliminary.sequence_number,
    preliminary.edit_status,
    preliminary.edit_status_name
FROM preliminary
JOIN Application ON preliminary.id = Application.application_id;

-- application
INSERT INTO Application(prelim_id,as_of_year, respondent_id, agency_code, loan_type, loan_purpose, owner_occupancy, loan_amount_000s, preapproval, action_taken, purchaser_type, rate_spread, hoepa_status, lien_status)
SELECT id, as_of_year, respondent_id, agency_code, loan_type, loan_purpose, owner_occupancy, loan_amount_000s, preapproval, action_taken, purchaser_type, rate_spread, hoepa_status, lien_status FROM preliminary;

-- applicant
INSERT INTO Applicant(application_id, applicant_ethnicity, applicant_sex, coapplicant_ethnicity, coapplicant_sex, applicant_income_000s)
SELECT
    Application.application_id,
    preliminary.applicant_ethnicity,
    preliminary.applicant_sex,
    preliminary.co_applicant_ethnicity,
    preliminary.co_applicant_sex,
    preliminary.applicant_income_000s
FROM preliminary
JOIN Application ON preliminary.id = Application.application_id;

-- temporarily adding a way to link applicant race with the preliminary table
-- ALTER TABLE preliminary ADD COLUMN id SERIAL PRIMARY KEY;

-- applicant race 1
INSERT INTO ApplicantRace(application_id, race_num, race_code)
SELECT id, 1, applicant_race_1 FROM preliminary
WHERE id IS NOT NULL AND applicant_race_1 IS NOT NULL;

-- applicant race 2
INSERT INTO ApplicantRace(application_id, race_num, race_code)
SELECT id, 2, applicant_race_2 FROM preliminary
WHERE id IS NOT NULL AND applicant_race_2 IS NOT NULL;

-- applicant race 3
INSERT INTO ApplicantRace(application_id, race_num, race_code)
SELECT id, 3, applicant_race_3 FROM preliminary
WHERE id IS NOT NULL AND applicant_race_3 IS NOT NULL;

-- applicant race 4
INSERT INTO ApplicantRace(application_id, race_num, race_code)
SELECT id, 4, applicant_race_4 FROM preliminary
WHERE id IS NOT NULL AND applicant_race_4 IS NOT NULL;

-- applicant race 5
INSERT INTO ApplicantRace(application_id, race_num, race_code)
SELECT id, 5, applicant_race_5 FROM preliminary
WHERE id IS NOT NULL AND applicant_race_5 IS NOT NULL;

-- coapplicant race 1
INSERT INTO CoapplicantRace(application_id, race_num, race_code)
SELECT id, 1, co_applicant_race_1 FROM preliminary
WHERE id IS NOT NULL AND co_applicant_race_1 IS NOT NULL;

-- coapplicant race 2
INSERT INTO CoapplicantRace(application_id, race_num, race_code)
SELECT id, 2, co_applicant_race_2 FROM preliminary
WHERE id IS NOT NULL AND co_applicant_race_2 IS NOT NULL;

-- coapplicant race 3
INSERT INTO CoapplicantRace(application_id, race_num, race_code)
SELECT id, 3, co_applicant_race_3 FROM preliminary
WHERE id IS NOT NULL AND co_applicant_race_3 IS NOT NULL;

-- coapplicant race 4
INSERT INTO CoapplicantRace(application_id, race_num, race_code)
SELECT id, 4, co_applicant_race_4 FROM preliminary
WHERE id IS NOT NULL AND co_applicant_race_4 IS NOT NULL;

-- coapplicant race 5
INSERT INTO CoapplicantRace(application_id, race_num, race_code)
SELECT id, 5, co_applicant_race_5 FROM preliminary
WHERE id IS NOT NULL AND co_applicant_race_5 IS NOT NULL;

-- location
INSERT INTO Location(application_id, msamd, state_code, county_code, census_tract_number, population, minority_population, hud_median_family_income, tract_to_msamd_income, number_of_owner_occupied_units, number_of_1_to_4_family_units)
SELECT
    Application.application_id,
    preliminary.msamd,
    preliminary.state_code,
    preliminary.county_code,
    preliminary.census_tract_number,
    preliminary.population,
    preliminary.minority_population,
    preliminary.hud_median_family_income,
    preliminary.tract_to_msamd_income,
    preliminary.number_of_owner_occupied_units,
    preliminary.number_of_1_to_4_family_units
FROM preliminary
JOIN Application ON preliminary.id = Application.application_id;

-- denial reason 1
INSERT INTO DenialReasons(application_id, denial_num, denial_code)
SELECT id, 1, denial_reason_1 FROM preliminary
WHERE id IS NOT NULL AND denial_reason_1 IS NOT NULL;

-- denial reason 2
INSERT INTO DenialReasons(application_id, denial_num, denial_code)
SELECT id, 2, denial_reason_2 FROM preliminary
WHERE id IS NOT NULL AND denial_reason_2 IS NOT NULL;

-- denial reason 3
INSERT INTO DenialReasons(application_id, denial_num, denial_code)
SELECT id, 3, denial_reason_3 FROM preliminary
WHERE id IS NOT NULL AND denial_reason_3 IS NOT NULL;

SELECT * FROM  Ethnicity ;
SELECT * FROM  RaceCode ;
SELECT * FROM  Sex ;
SELECT * FROM  Agency ;
SELECT * FROM  PurchaserType ;
SELECT * FROM  PropertyType ;
SELECT * FROM  LoanType ;
SELECT * FROM  LoanPurpose ;
SELECT * FROM  State ;
SELECT * FROM  County ;
SELECT * FROM  MSAMD ;
SELECT * FROM  Preapproval ;
SELECT * FROM  OwnerOccupancy ;
SELECT * FROM  ActionTaken ;
SELECT * FROM  HoepaStatus ;
SELECT * FROM  LienStatus ;
SELECT * FROM  NullTable ;
SELECT * FROM  Applicant ;
SELECT * FROM  ApplicantRace ;
SELECT * FROM  CoapplicantRace ;
SELECT * FROM  Location ;
SELECT * FROM  Application ;
SELECT * FROM  DenialCode ;
SELECT * FROM  DenialReasons ;

ALTER TABLE preliminary DROP COLUMN id;

COPY (
    SELECT
        Application.as_of_year,
        Application.respondent_id,
        Agency.agency_name,
        Agency.agency_abbr,
        Application.agency_code,
        LoanType.loan_type_name,
        Application.loan_type,
        PropertyType.property_type_name,
        Application.property_type,
        LoanPurpose.loan_purpose_name,
        Application.loan_purpose,
        OwnerOccupancy.owner_occupancy_name,
        Application.owner_occupancy,
        Application.loan_amount_000s,
        Preapproval.preapproval_name,
        Application.preapproval,
        ActionTaken.action_taken_name,
        Application.action_taken,
        MSAMD.msamd_name,
        Location.msamd::INTEGER AS msamd,
        State.state_name,
        State.state_abbr,
        Location.state_code::SMALLINT AS state_code,
        County.county_name,
        Location.county_code::SMALLINT AS county_code,
        Location.census_tract_number::NUMERIC(7,2),
        ApplicantEthnicity.ethnicity_name AS applicant_ethnicity_name,
        Applicant.applicant_ethnicity::SMALLINT AS applicant_ethnicity,
        CoApplicantEthnicity.ethnicity_name AS co_applicant_ethnicity_name,
        Applicant.coapplicant_ethnicity::SMALLINT AS co_applicant_ethnicity,
        ApplicantRaceData.applicant_race_name_1,
        ApplicantRaceData.applicant_race_1::SMALLINT AS applicant_race_1,
        ApplicantRaceData.applicant_race_name_2,
        ApplicantRaceData.applicant_race_2::SMALLINT AS applicant_race_2,
        ApplicantRaceData.applicant_race_name_3,
        ApplicantRaceData.applicant_race_3::SMALLINT AS applicant_race_3,
        ApplicantRaceData.applicant_race_name_4,
        ApplicantRaceData.applicant_race_4::SMALLINT AS applicant_race_4,
        ApplicantRaceData.applicant_race_name_5,
        ApplicantRaceData.applicant_race_5::SMALLINT AS applicant_race_5,
        CoApplicantRaceData.co_applicant_race_name_1,
        CoApplicantRaceData.co_applicant_race_1::SMALLINT AS co_applicant_race_1,
        CoApplicantRaceData.co_applicant_race_name_2,
        CoApplicantRaceData.co_applicant_race_2::SMALLINT AS co_applicant_race_2,
        CoApplicantRaceData.co_applicant_race_name_3,
        CoApplicantRaceData.co_applicant_race_3::SMALLINT AS co_applicant_race_3,
        CoApplicantRaceData.co_applicant_race_name_4,
        CoApplicantRaceData.co_applicant_race_4::SMALLINT AS co_applicant_race_4,
        CoApplicantRaceData.co_applicant_race_name_5,
        CoApplicantRaceData.co_applicant_race_5::SMALLINT AS co_applicant_race_5,
        ApplicantSex.sex_name AS applicant_sex_name,
        Applicant.applicant_sex::SMALLINT AS applicant_sex,
        CoApplicantSex.sex_name AS co_applicant_sex_name,
        Applicant.coapplicant_sex::SMALLINT AS co_applicant_sex,
        Applicant.applicant_income_000s::INTEGER AS applicant_income_000s,
        PurchaserType.purchaser_type_name,
        Application.purchaser_type,
        DenialReasonData.denial_reason_name_1,
        DenialReasonData.denial_reason_1::SMALLINT AS denial_reason_1,
        DenialReasonData.denial_reason_name_2,
        DenialReasonData.denial_reason_2::SMALLINT AS denial_reason_2,
        DenialReasonData.denial_reason_name_3,
        DenialReasonData.denial_reason_3::SMALLINT AS denial_reason_3,
        Application.rate_spread,
        HoepaStatus.hoepa_status_name,
        Application.hoepa_status,
        LienStatus.lien_status_name,
        Application.lien_status,
        NullTable.edit_status_name,
        NullTable.edit_status::SMALLINT AS edit_status,
        NullTable.sequence_number::INTEGER AS sequence_number,
        Location.population::INTEGER AS population,
        Location.minority_population::NUMERIC(15,2),
        Location.hud_median_family_income,
        Location.tract_to_msamd_income::NUMERIC(16,2),
        Location.number_of_owner_occupied_units::INTEGER AS number_of_owner_occupied_units,
        Location.number_of_1_to_4_family_units::INTEGER AS number_of_1_to_4_family_units,
        NullTable.application_date_indicator::SMALLINT AS application_date_indicator
    FROM Application
    LEFT JOIN Agency ON Application.agency_code = Agency.agency_code
    LEFT JOIN LoanType ON Application.loan_type = LoanType.loan_type
    LEFT JOIN PropertyType ON Application.property_type = PropertyType.property_type
    LEFT JOIN LoanPurpose ON Application.loan_purpose = LoanPurpose.loan_purpose
    LEFT JOIN OwnerOccupancy ON Application.owner_occupancy = OwnerOccupancy.owner_occupancy
    LEFT JOIN Preapproval ON Application.preapproval = Preapproval.preapproval
    LEFT JOIN ActionTaken ON Application.action_taken = ActionTaken.action_taken
    LEFT JOIN PurchaserType ON Application.purchaser_type = PurchaserType.purchaser_type
    LEFT JOIN HoepaStatus ON Application.hoepa_status = HoepaStatus.hoepa_status
    LEFT JOIN LienStatus ON Application.lien_status = LienStatus.lien_status
    LEFT JOIN Applicant ON Application.application_id = Applicant.application_id
    LEFT JOIN Sex AS ApplicantSex ON Applicant.applicant_sex = ApplicantSex.sex
    LEFT JOIN Sex AS CoApplicantSex ON Applicant.coapplicant_sex = CoApplicantSex.sex
    LEFT JOIN Ethnicity AS ApplicantEthnicity ON Applicant.applicant_ethnicity = ApplicantEthnicity.ethnicity
    LEFT JOIN Ethnicity AS CoApplicantEthnicity ON Applicant.coapplicant_ethnicity = CoApplicantEthnicity.ethnicity
    LEFT JOIN Location ON Application.application_id = Location.application_id
    LEFT JOIN State ON Location.state_code = State.state_code
    LEFT JOIN County ON Location.county_code = County.county_code
    LEFT JOIN MSAMD ON Location.msamd = MSAMD.msamd
    LEFT JOIN (
        SELECT
            ApplicantRace.application_id,
            MAX(CASE WHEN ApplicantRace.race_num = 1 THEN RaceCode.race_name END) AS applicant_race_name_1,
            MAX(CASE WHEN ApplicantRace.race_num = 1 THEN ApplicantRace.race_code END) AS applicant_race_1,
            MAX(CASE WHEN ApplicantRace.race_num = 2 THEN RaceCode.race_name END) AS applicant_race_name_2,
            MAX(CASE WHEN ApplicantRace.race_num = 2 THEN ApplicantRace.race_code END) AS applicant_race_2,
            MAX(CASE WHEN ApplicantRace.race_num = 3 THEN RaceCode.race_name END) AS applicant_race_name_3,
            MAX(CASE WHEN ApplicantRace.race_num = 3 THEN ApplicantRace.race_code END) AS applicant_race_3,
            MAX(CASE WHEN ApplicantRace.race_num = 4 THEN RaceCode.race_name END) AS applicant_race_name_4,
            MAX(CASE WHEN ApplicantRace.race_num = 4 THEN ApplicantRace.race_code END) AS applicant_race_4,
            MAX(CASE WHEN ApplicantRace.race_num = 5 THEN RaceCode.race_name END) AS applicant_race_name_5,
            MAX(CASE WHEN ApplicantRace.race_num = 5 THEN ApplicantRace.race_code END) AS applicant_race_5
        FROM ApplicantRace
        LEFT JOIN RaceCode ON ApplicantRace.race_code = RaceCode.race_code
        GROUP BY ApplicantRace.application_id
    ) AS ApplicantRaceData ON Application.application_id = ApplicantRaceData.application_id
    LEFT JOIN (
        SELECT
            CoapplicantRace.application_id,
            MAX(CASE WHEN CoapplicantRace.race_num = 1 THEN RaceCode.race_name END) AS co_applicant_race_name_1,
            MAX(CASE WHEN CoapplicantRace.race_num = 1 THEN CoapplicantRace.race_code END) AS co_applicant_race_1,
            MAX(CASE WHEN CoapplicantRace.race_num = 2 THEN RaceCode.race_name END) AS co_applicant_race_name_2,
            MAX(CASE WHEN CoapplicantRace.race_num = 2 THEN CoapplicantRace.race_code END) AS co_applicant_race_2,
            MAX(CASE WHEN CoapplicantRace.race_num = 3 THEN RaceCode.race_name END) AS co_applicant_race_name_3,
            MAX(CASE WHEN CoapplicantRace.race_num = 3 THEN CoapplicantRace.race_code END) AS co_applicant_race_3,
            MAX(CASE WHEN CoapplicantRace.race_num = 4 THEN RaceCode.race_name END) AS co_applicant_race_name_4,
            MAX(CASE WHEN CoapplicantRace.race_num = 4 THEN CoapplicantRace.race_code END) AS co_applicant_race_4,
            MAX(CASE WHEN CoapplicantRace.race_num = 5 THEN RaceCode.race_name END) AS co_applicant_race_name_5,
            MAX(CASE WHEN CoapplicantRace.race_num = 5 THEN CoapplicantRace.race_code END) AS co_applicant_race_5
        FROM CoapplicantRace
        LEFT JOIN RaceCode ON CoapplicantRace.race_code = RaceCode.race_code
        GROUP BY CoapplicantRace.application_id
    ) AS CoApplicantRaceData ON Application.application_id = CoApplicantRaceData.application_id
    LEFT JOIN (
        SELECT
            DenialReasons.application_id,
            MAX(CASE WHEN DenialReasons.denial_num = 1 THEN DenialCode.denial_name END) AS denial_reason_name_1,
            MAX(CASE WHEN DenialReasons.denial_num = 1 THEN DenialReasons.denial_code END) AS denial_reason_1,
            MAX(CASE WHEN DenialReasons.denial_num = 2 THEN DenialCode.denial_name END) AS denial_reason_name_2,
            MAX(CASE WHEN DenialReasons.denial_num = 2 THEN DenialReasons.denial_code END) AS denial_reason_2,
            MAX(CASE WHEN DenialReasons.denial_num = 3 THEN DenialCode.denial_name END) AS denial_reason_name_3,
            MAX(CASE WHEN DenialReasons.denial_num = 3 THEN DenialReasons.denial_code END) AS denial_reason_3
        FROM DenialReasons
        LEFT JOIN DenialCode ON DenialReasons.denial_code = DenialCode.denial_code
        GROUP BY DenialReasons.application_id
    ) AS DenialReasonData ON Application.application_id = DenialReasonData.application_id
    LEFT JOIN NullTable ON Application.application_id = NullTable.application_id

) TO 'C:\Users\cshah\Desktop\Report.csv' DELIMITER ',' CSV HEADER;



INSERT INTO PropertyType(property_type, property_type_name)
VALUES ('Error Test 1', 'Fake');

INSERT INTO LienStatus(lien_status, lien_status_name)
VALUES ('Error Test 2', 'Fake');

INSERT INTO Application(application_id,as_of_year)
VALUES(NULL, 2035);