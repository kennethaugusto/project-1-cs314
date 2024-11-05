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
    property_type VARCHAR(1) PRIMARY KEY, 
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

CREATE TABLE NullTable(
    application_date_indicator INTEGER,
    sequence_number VARCHAR(7),
    edit_status_name VARCHAR(50),
    edit_status VARCHAR(1)
);

CREATE TABLE Applicant(
    applicant_id SERIAL PRIMARY KEY,
    applicant_ethnicity VARCHAR(1),
    applicant_sex INTEGER,
    coapplicant_ethnicity VARCHAR(1),
    coapplicant_sex INTEGER,
    applicant_income_000s VARCHAR(8),
    FOREIGN KEY (applicant_ethnicity) REFERENCES Ethnicity(ethnicity),
    FOREIGN KEY (coapplicant_ethnicity) REFERENCES Ethnicity(ethnicity),
    FOREIGN KEY (applicant_sex) REFERENCES Sex(sex),
    FOREIGN KEY (coapplicant_sex) REFERENCES Sex(sex)
);


CREATE TABLE ApplicantRace(
    race_num INTEGER, -- if there are multiple applicant races, identify if its the first, second, etc
    applicant_id INTEGER,
    race_code VARCHAR(1),
    FOREIGN KEY (applicant_id) REFERENCES Applicant(applicant_id),
    FOREIGN KEY (race_code) REFERENCES RaceCode(race_code)
);

CREATE TABLE CoapplicantRace(
    race_num INTEGER, -- if there are multiple applicant races, identify if its the first, second, etc
    applicant_id INTEGER,
    race_code VARCHAR(1),
    FOREIGN KEY (applicant_id) REFERENCES Applicant(applicant_id),
    FOREIGN KEY (race_code) REFERENCES RaceCode(race_code)
);

CREATE TABLE Property(
    property_id SERIAL PRIMARY KEY,
    property_type VARCHAR(1),
    FOREIGN KEY (property_type) REFERENCES PropertyType(property_type)
);

CREATE TABLE Location(
    location_id SERIAL PRIMARY KEY,
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
    FOREIGN KEY (msamd) REFERENCES MSAMD(msamd),
    FOREIGN KEY (state_code) REFERENCES State(state_code),
    FOREIGN KEY (county_code) REFERENCES County(county_code)
);

CREATE TABLE Application(
    application_id SERIAL PRIMARY KEY,
    as_of_year INTEGER,
    respondent_id VARCHAR(10),
    agency_code INTEGER,
    loan_type INTEGER,
    loan_purpose INTEGER,
    owner_occupancy INTEGER,
    loan_amount_000s INTEGER,
    preapproval INTEGER,
    action_taken INTEGER,
    applicant_id INTEGER,
    property_id INTEGER,
    location_id INTEGER,
    purchaser_type INTEGER,
    rate_spread NUMERIC(5, 2),
    hoepa_status INTEGER,
    lien_status INTEGER,
    FOREIGN KEY (hoepa_status) REFERENCES HoepaStatus(hoepa_status),
    FOREIGN KEY (lien_status) REFERENCES LienStatus(lien_status),
    FOREIGN KEY (action_taken) REFERENCES ActionTaken(action_taken),
    FOREIGN KEY (applicant_id) REFERENCES Applicant(applicant_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id),
    FOREIGN KEY (purchaser_type) REFERENCES PurchaserType(purchaser_type),
    FOREIGN KEY (preapproval) REFERENCES Preapproval(preapproval),
    FOREIGN KEY (owner_occupancy) REFERENCES OwnerOccupancy(owner_occupancy),
    FOREIGN KEY (loan_purpose) REFERENCES LoanPurpose(loan_purpose),
    FOREIGN KEY (loan_type) REFERENCES LoanType(loan_type),
    FOREIGN KEY (agency_code) REFERENCES Agency(agency_code)
);

CREATE TABLE DenialCode(
    denial_code VARCHAR(1) PRIMARY KEY,
    denial_name VARCHAR(50)
);

CREATE TABLE DenialReasons(
    denial_id SERIAL PRIMARY KEY,
    application_id INTEGER,
    denial_code VARCHAR(1),
    FOREIGN KEY (application_id) REFERENCES Application(application_id),
    FOREIGN KEY (denial_code) REFERENCES DenialCode(denial_code)
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

-- null table
INSERT INTO NullTable(application_date_indicator, sequence_number, edit_status, edit_status_name)
SELECT DISTINCT application_date_indicator, sequence_number, edit_status, edit_status_name FROM preliminary;

-- applicant
INSERT INTO Applicant(applicant_ethnicity, applicant_sex, coapplicant_ethnicity, coapplicant_sex, applicant_income_000s)
SELECT applicant_ethnicity, applicant_sex, co_applicant_ethnicity, co_applicant_sex, applicant_income_000s FROM preliminary;

-- applicant race 1
-- INSERT INTO ApplicantRace(applicant_id)
-- SELECT applicant_id FROM Applicant;
-- UPDATE ApplicantRace SET race_code = (SELECT applicant_race_1 FROM preliminary WHERE );
-- UPDATE ApplicantRace SET race_num = 1 WHERE race_num IS NULL;
