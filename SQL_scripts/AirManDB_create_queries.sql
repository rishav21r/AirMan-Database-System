# -----------------------------------------------------
# Databse Selection
# -----------------------------------------------------

CREATE DATABaSE AirManDB;

# -----------------------------------------------------
# Databse Selection
# -----------------------------------------------------

USE AirManDB;

# -----------------------------------------------------
# Table Creation
# -----------------------------------------------------
-- Creating the PERSON table
CREATE TABLE PERSON (
  PersonID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  AddressLine1 VARCHAR(255) NOT NULL,
  AddressLine2 VARCHAR(255),
  PhoneNumber VARCHAR(15) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  SocialInsuranceNumber VARCHAR(15) UNIQUE,
  Role ENUM('Customer', 'Pilot', 'Employee') NOT NULL
);
-- Creating the PILOT table that inherits from PERSON
CREATE TABLE PILOT (
  PersonID INT,
  LicenseNumber VARCHAR(255) NOT NULL UNIQUE,
  MedicalCertificationDate DATE NOT NULL,
  FlightReviewDate DATE NOT NULL,
  OperatingLimitations VARCHAR(255),
  PRIMARY KEY (PersonID),
  CONSTRAINT fk_pilot_person FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
);
-- Creating the CUSTOMER table that inherits from PERSON
CREATE TABLE CUSTOMER (
  PersonID INT,
  CustomerCategory ENUM('Individual', 'Corporation') NOT NULL,
  ContactPerson VARCHAR(255),
  PRIMARY KEY (PersonID),
  CONSTRAINT fk_customer_person FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
);
-- Creating the TEAM table
CREATE TABLE TEAM (
  TeamID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL
  -- Removed SupervisorID for now, will re-add after EMPLOYEE table is updated
);
-- Creating the EMPLOYEE table
CREATE TABLE EMPLOYEE (
  PersonID INT AUTO_INCREMENT PRIMARY KEY,
  TeamID INT,
  Salary DECIMAL(10, 2) NOT NULL,
  ShiftWorked VARCHAR(100),
  Field INT,
  CONSTRAINT fk_employee_person FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID),
  CONSTRAINT fk_employee_team FOREIGN KEY (TeamID) REFERENCES TEAM(TeamID)
);
-- Adding SupervisorID back to TEAM table now that EMPLOYEE table has been created
ALTER TABLE TEAM
ADD SupervisorID INT,
ADD CONSTRAINT fk_team_supervisor FOREIGN KEY (SupervisorID) REFERENCES EMPLOYEE(PersonID);

-- Creating the SKILL_SET table
CREATE TABLE SKILL_SET (
  SkillID INT AUTO_INCREMENT PRIMARY KEY,
  PersonID INT NOT NULL,
  AircraftTypeID INT NOT NULL,
  SkillDescription VARCHAR(255),
  CONSTRAINT fk_skillset_person FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
);
-- Creating the AIRCRAFT_TYPE table
CREATE TABLE AIRCRAFT_TYPE (
  AircraftTypeID INT AUTO_INCREMENT PRIMARY KEY,
  SizeID INT,
  CapacityID INT,
  AircraftType VARCHAR(50),
  ModelNumber VARCHAR(50)
);
-- Creating the AIRCRAFT table
CREATE TABLE AIRCRAFT (
  AircraftRegistrationNumber VARCHAR(20) NOT NULL,
  CustomerID INT,
  AircraftTypeID INT,
  ParkingStorageLocation VARCHAR(255),
  PRIMARY KEY (AircraftRegistrationNumber),
  CONSTRAINT fk_aircraft_customer FOREIGN KEY (CustomerID) REFERENCES PERSON(PersonID),
  CONSTRAINT fk_aircraft_type FOREIGN KEY (AircraftTypeID) REFERENCES AIRCRAFT_TYPE(AircraftTypeID)
);
-- Adding FK reference to from SKILL_SET table to AIRCRAFT table
ALTER TABLE SKILL_SET
ADD CONSTRAINT fk_skillset_aircrafttype FOREIGN KEY (AircraftTypeID) REFERENCES AIRCRAFT(AircraftTypeID);
-- Creating the OWNERSHIP_HISTORY table
CREATE TABLE OWNERSHIP_HISTORY (
  OwnershipHistoryID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT NOT NULL,
  AircraftRegistrationNumber VARCHAR(20) NOT NULL,
  SaleDate DATE,
  CONSTRAINT fk_ownershiphistory_customer FOREIGN KEY (CustomerID) REFERENCES PERSON(PersonID),
  CONSTRAINT fk_ownershiphistory_aircraft FOREIGN KEY (AircraftRegistrationNumber) REFERENCES AIRCRAFT(AircraftRegistrationNumber)
);
-- Creating the PARKING_SLOT table
CREATE TABLE PARKING_SLOT (
  ParkingSlotID INT AUTO_INCREMENT PRIMARY KEY,
  Location VARCHAR(255) NOT NULL,
  SlotType ENUM('hangar', 'ground') NOT NULL,
  UsageType ENUM('short_term', 'long_term') NOT NULL,
  Status ENUM('occupied', 'available') NOT NULL,
  ExpectedDuration INT
);
-- Creating the PARKING_RESERVATION table
CREATE TABLE PARKING_RESERVATION (
  ReservationID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT, -- Can be NULL if not all customers need to make a reservation
  PilotID INT, -- Can be NULL if the reservation does not need to be linked to a pilot
  AircraftRegistrationNumber VARCHAR(20) NOT NULL,
  ParkingSlotID INT NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE,
  ReservationType ENUM('resident', 'visiting') NOT NULL,
  CONSTRAINT fk_parkingreservation_customer FOREIGN KEY (CustomerID) REFERENCES PERSON(PersonID) ON DELETE SET NULL,
  CONSTRAINT fk_parkingreservation_pilot FOREIGN KEY (PilotID) REFERENCES PILOT(PersonID) ON DELETE SET NULL,
  CONSTRAINT fk_parkingreservation_aircraft FOREIGN KEY (AircraftRegistrationNumber) REFERENCES AIRCRAFT(AircraftRegistrationNumber),
  CONSTRAINT fk_parkingreservation_slot FOREIGN KEY (ParkingSlotID) REFERENCES PARKING_SLOT(ParkingSlotID)
);
-- Creating the LEASE_AGREEMENT table
CREATE TABLE LEASE_AGREEMENT (
  LeaseID INT AUTO_INCREMENT PRIMARY KEY,
  LessorID INT NOT NULL,
  LesseeID INT NOT NULL,
  AircraftRegistrationNumber VARCHAR(20) NOT NULL,
  LeaseStartDate DATE NOT NULL,
  LeaseEndDate DATE NOT NULL,
  LeaseTerms TEXT,
  MonthlyLeaseRate DECIMAL(10,2),
  SecurityDeposit DECIMAL(10,2),
  CONSTRAINT fk_leaseagreement_lessor FOREIGN KEY (LessorID) REFERENCES CUSTOMER(PersonID),
  CONSTRAINT fk_leaseagreement_lessee FOREIGN KEY (LesseeID) REFERENCES CUSTOMER(PersonID),
  CONSTRAINT fk_leaseagreement_aircraft FOREIGN KEY (AircraftRegistrationNumber) REFERENCES AIRCRAFT(AircraftRegistrationNumber)
);
-- Creating the LEASE_AGREEMENT table
CREATE TABLE AIRCRAFT_TYPE_SKILLSET (
  SkillsetID INT AUTO_INCREMENT PRIMARY KEY,
  PersonID INT NOT NULL,
  AircraftTypeID INT NOT NULL,
  CONSTRAINT fk_employee_skillset FOREIGN KEY (PersonID) REFERENCES EMPLOYEE(PersonID),
  CONSTRAINT fk_aircrafttype_skillset FOREIGN KEY (AircraftTypeID) REFERENCES AIRCRAFT_TYPE(AircraftTypeID)
);
-- Creating the AIRCRAFT_SIZE table
CREATE TABLE AIRCRAFT_SIZE (
  SizeID INT AUTO_INCREMENT PRIMARY KEY,
  SizeDescription VARCHAR(255) NOT NULL
);
-- Creating the AIRCRAFT_CAPACITY table
CREATE TABLE AIRCRAFT_CAPACITY (
  CapacityID INT AUTO_INCREMENT PRIMARY KEY,
  CapacityDescription VARCHAR(255) NOT NULL
);
-- Adding foreign key constraints to AIRCRAFT_TYPE table
ALTER TABLE AIRCRAFT_TYPE
ADD CONSTRAINT fk_aircrafttype_size FOREIGN KEY (SizeID) REFERENCES AIRCRAFT_SIZE(SizeID),
ADD CONSTRAINT fk_aircrafttype_capacity FOREIGN KEY (CapacityID) REFERENCES AIRCRAFT_CAPACITY(CapacityID);
-- Creating the MAINTENANCE_SCHEDULE table
CREATE TABLE MAINTENANCE_SCHEDULE (
  ScheduleID INT AUTO_INCREMENT PRIMARY KEY,
  AircraftTypeID INT NOT NULL,
  MaintenanceActivity VARCHAR(255) NOT NULL,
  IntervalHours INT,
  IntervalMonths INT,
  CONSTRAINT fk_maintenanceschedule_aircrafttype FOREIGN KEY (AircraftTypeID) REFERENCES AIRCRAFT_TYPE(AircraftTypeID)
);
-- Creating the MAINTENANCE_SERVICE_RECORD table
CREATE TABLE MAINTENANCE_SERVICE_RECORD (
  ServiceID INT AUTO_INCREMENT PRIMARY KEY,
  PersonID INT NOT NULL,
  ScheduleID INT NOT NULL,
  AircraftRegistrationNumber VARCHAR(20) NOT NULL,
  MaintenanceDate DATE NOT NULL,
  CostPerHour DECIMAL(10,2),
  MaintenanceType VARCHAR(255) NOT NULL,
  CONSTRAINT fk_maintenance_employee FOREIGN KEY (PersonID) REFERENCES EMPLOYEE(PersonID),
  CONSTRAINT fk_maintenance_schedule FOREIGN KEY (ScheduleID) REFERENCES MAINTENANCE_SCHEDULE(ScheduleID),
  CONSTRAINT fk_maintenance_aircraft FOREIGN KEY (AircraftRegistrationNumber) REFERENCES AIRCRAFT(AircraftRegistrationNumber)
);
-- Creating the CLEANING_SERVICE_RECORD table
CREATE TABLE CLEANING_SERVICE_RECORD (
  CleaningServiceID INT AUTO_INCREMENT PRIMARY KEY,
  AircraftRegistrationNumber VARCHAR(20) NOT NULL,
  PersonID INT NOT NULL,
  Date DATE NOT NULL,
  CostPerHour DECIMAL(10,2),
  CONSTRAINT fk_cleaning_employee FOREIGN KEY (PersonID) REFERENCES EMPLOYEE(PersonID),
  CONSTRAINT fk_cleaning_aircraft FOREIGN KEY (AircraftRegistrationNumber) REFERENCES AIRCRAFT(AircraftRegistrationNumber)
);
-- Creating the FUELING_RECORD table
CREATE TABLE FUELING_RECORD (
  FuelingID INT AUTO_INCREMENT PRIMARY KEY,
  AircraftRegistrationNumber VARCHAR(20) NOT NULL,
  PersonID INT NOT NULL,
  Price DECIMAL(10,2),
  Litres DECIMAL(10,2),
  Date DATE NOT NULL,
  Time TIME NOT NULL,
  Amount DECIMAL(10,2),
  CONSTRAINT fk_fueling_employee FOREIGN KEY (PersonID) REFERENCES EMPLOYEE(PersonID),
  CONSTRAINT fk_fueling_aircraft FOREIGN KEY (AircraftRegistrationNumber) REFERENCES AIRCRAFT(AircraftRegistrationNumber)
);
-- Creating the FLIGHT_RECORD table
CREATE TABLE FLIGHT_RECORD (
  FlightRecordID INT AUTO_INCREMENT PRIMARY KEY,
  PilotID INT NOT NULL,
  AircraftRegistrationNumber VARCHAR(20) NOT NULL,
  TakeOffDate DATETIME NOT NULL,
  LandingDate DATETIME NOT NULL,
  CONSTRAINT fk_flightrecord_pilot FOREIGN KEY (PilotID) REFERENCES PILOT(PersonID),
  CONSTRAINT fk_flightrecord_aircraft FOREIGN KEY (AircraftRegistrationNumber) REFERENCES AIRCRAFT(AircraftRegistrationNumber)
);
-- Creating the PARTS table
CREATE TABLE PARTS (
  PartID INT AUTO_INCREMENT PRIMARY KEY,
  PartNumber VARCHAR(50) NOT NULL,
  PartName VARCHAR(255) NOT NULL,
  Price DECIMAL(10, 2)
);
-- Creating the MAINTENANCE_PARTS table
CREATE TABLE MAINTENANCE_PARTS (
  MaintenanceID INT NOT NULL,
  PartID INT NOT NULL,
  Quantity INT NOT NULL,
  CONSTRAINT fk_maintenanceparts_maintenance FOREIGN KEY (MaintenanceID) REFERENCES MAINTENANCE_SERVICE_RECORD(ServiceID),
  CONSTRAINT fk_maintenanceparts_parts FOREIGN KEY (PartID) REFERENCES PARTS(PartID),
  PRIMARY KEY (MaintenanceID, PartID)
);
-- Creating the FLIGHT_LOGS table
CREATE TABLE FLIGHT_LOGS (
  LogID INT AUTO_INCREMENT PRIMARY KEY,
  PilotID INT NOT NULL,
  AircraftRegistrationNumber VARCHAR(20) NOT NULL,
  OperationType ENUM('take-off', 'landing') NOT NULL,
  DateTime DATETIME NOT NULL,
  CONSTRAINT fk_flightlogs_pilot FOREIGN KEY (PilotID) REFERENCES PILOT(PersonID),
  CONSTRAINT fk_flightlogs_aircraft FOREIGN KEY (AircraftRegistrationNumber) REFERENCES AIRCRAFT(AircraftRegistrationNumber)
);

SELECT * FROM FUELING_RECORD;
SELECT * FROM AIRCRAFT_SIZE;
SELECT * FROM AIRCRAFT_CAPACITY;
SELECT * FROM AIRCRAFT_TYPE;
SELECT * FROM AIRCRAFT;
SELECT * FROM MAINTENANCE_SERVICE_RECORD;
SELECT * FROM FUELING_RECORD;
SELECT * FROM FUELING_RECORD;
SELECT * FROM CLEANING_SERVICE_RECORD;

SELECT * FROM PERSON;
SELECT * FROM CUSTOMER;
SELECT * FROM AIRCRAFT_TYPE;
SELECT * FROM AIRCRAFT;
SELECT * FROM SKILL_SET;
SELECT * FROM MAINTENANCE_SERVICE_RECORD;
