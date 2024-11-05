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

-- first statement for applicant ethnicities
INSERT INTO Ethnicity(ethnicity, ethnicity_name)
SELECT DISTINCT applicant_ethnicity, applicant_ethnicity_name FROM preliminary
WHERE applicant_ethnicity IS NOT NULL AND applicant_ethnicity_name IS NOT NULL
ON CONFLICT(ethnicity) DO NOTHING;

-- second statement for coapplicant ethnicities
INSERT INTO Ethnicity (ethnicity, ethnicity_name)
SELECT DISTINCT co_applicant_ethnicity, co_applicant_ethnicity_name
FROM preliminary
WHERE co_applicant_ethnicity IS NOT NULL AND co_applicant_ethnicity_name IS NOT NULL
ON CONFLICT(ethnicity) DO NOTHING;