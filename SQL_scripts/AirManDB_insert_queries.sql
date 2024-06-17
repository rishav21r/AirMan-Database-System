# ------------------------------------------------------
# Databse Selection
# ------------------------------------------------------

USE AirManDB;

# ------------------------------------------------------
# Adding Example Records to AirManDB tables
# ------------------------------------------------------
#
-- Adding PERSON table data
INSERT INTO PERSON (Name, AddressLine1, PhoneNumber, Email, SocialInsuranceNumber, Role)
VALUES
('John Doe', '123 Aviation Way', '555-1234', 'johndoe@example.com', '123-45-6789', 'Customer'),
('Alice Smith', '234 Skyline Blvd', '555-2345', 'alicesmith@example.com', '987-65-4321', 'Pilot'),
('Bob Johnson', '345 Jetstream St', '555-3456', 'bobjohnson@example.com', '135-79-2468', 'Employee');

-- Adding PILOT table data
INSERT INTO PILOT (PersonID, LicenseNumber, MedicalCertificationDate, FlightReviewDate, OperatingLimitations)
VALUES
(2, 'PIL123456', '2022-06-15', '2022-06-15', 'None');

-- Adding CUSTOMER table data
INSERT INTO CUSTOMER (PersonID, CustomerCategory, ContactPerson)
VALUES
(1, 'Individual', 'John Doe');

-- Adding TEAM table data
INSERT INTO TEAM (Name)
VALUES ('Maintenance Team'), ('Ground Handling Team');

-- Adding EMPLOYEE table data
INSERT INTO EMPLOYEE (PersonID, TeamID, Salary, ShiftWorked)
VALUES
(3, 1, 35000.00, 'Morning');

 -- Adding AIRCRAFT_TYPE table data
INSERT INTO AIRCRAFT_TYPE (AircraftType, ModelNumber)
VALUES ('Jet', 'Boeing 737');

 -- Update AIRCRAFT_TYPE table data
UPDATE AIRCRAFT_TYPE
SET SizeID = 2, CapacityID = 3
WHERE AircraftTypeID = 1;

-- Adding AIRCRAFT table data
INSERT INTO AIRCRAFT (AircraftRegistrationNumber, CustomerID, AircraftTypeID, ParkingStorageLocation)
VALUES ('G-BIGG', 1, 1, 'Hangar 3');

-- Adding OWNERSHIP_HISTORY table data
INSERT INTO OWNERSHIP_HISTORY (CustomerID, AircraftRegistrationNumber, SaleDate)
VALUES (1, 'G-BIGG', '2022-01-01');

-- Adding PARKING_SLOT table data
INSERT INTO PARKING_SLOT (Location, SlotType, UsageType, Status)
VALUES ('Hangar 3', 'hangar', 'long_term', 'occupied');

-- Adding PARKING_RESERVATION table data
INSERT INTO PARKING_RESERVATION (CustomerID, PilotID, AircraftRegistrationNumber, ParkingSlotID, StartDate, ReservationType)
VALUES (1, 2, 'G-BIGG', 1, '2023-04-01', 'resident');

-- Inserting an employee who will be a supervisor
INSERT INTO PERSON (Name, AddressLine1, PhoneNumber, Email, SocialInsuranceNumber, Role)
VALUES ('Emma Clark', '456 Flight Ave', '555-4567', 'emmaclark@example.com', '222-33-4444', 'Employee');

-- Assuming Emma Clark is the fourth person entered and thus has PersonID=4
INSERT INTO EMPLOYEE (PersonID, TeamID, Salary, ShiftWorked, Field)
VALUES (4, NULL, 40000.00, 'Day', NULL);

-- Inserting JetSetters Corp. into PERSON table
INSERT INTO PERSON (Name, AddressLine1, PhoneNumber, Email, SocialInsuranceNumber, Role)
VALUES ('JetSetters Corp.', '100 Corporate Way', '555-1010', 'contact@jetsetterscorp.com', '999-99-9999', 'Customer');

-- Inserting the Lessee into PERSON table
-- Assuming this is another company that is leasing the aircraft
INSERT INTO PERSON (Name, AddressLine1, PhoneNumber, Email, SocialInsuranceNumber, Role)
VALUES ('Global Air Travel', '200 Global Plaza', '555-2020', 'info@globalairtravel.com', '888-88-8888', 'Customer');

-- Adding AIRCRAFT_SIZE table data
INSERT INTO AIRCRAFT_SIZE (SizeDescription)
VALUES ('Small'), ('Medium'), ('Large');

-- Adding AIRCRAFT_CAPACITY table data
INSERT INTO AIRCRAFT_CAPACITY (CapacityDescription)
VALUES ('Up to 10 passengers'), ('Up to 100 passengers'), ('Up to 200 passengers');

-- Inserting an aircraft_type into AIRCRAFT table
INSERT INTO AIRCRAFT_TYPE (SizeID, CapacityID, AircraftType, ModelNumber)
VALUES
(2, 2, 'Jet', 'A320');

-- Inserting an aircraft into AIRCRAFT table
-- Assuming AircraftType Jet has AircraftTypeID=2, and JetSetters Corp. has PersonID=10 after insert
INSERT INTO AIRCRAFT (AircraftRegistrationNumber, CustomerID, AircraftTypeID, ParkingStorageLocation)
VALUES ('N12345', 5, 2, 'Corporate Hangar A');

-- Inserting JetSetters Corp. and Global Air Travel into CUSTOMER table
INSERT INTO CUSTOMER (PersonID, CustomerCategory, ContactPerson)
VALUES
(5, 'Corporation', NULL), -- Assuming no specific contact person is designated for JetSetters Corp.
(6, 'Corporation', NULL); -- Assuming no specific contact person is designated for Global Air Travel

-- Adding LEASE_AGREEMENT table data
INSERT INTO LEASE_AGREEMENT (
  LessorID,
  LesseeID,
  AircraftRegistrationNumber,
  LeaseStartDate,
  LeaseEndDate,
  LeaseTerms,
  MonthlyLeaseRate,
  SecurityDeposit
)
VALUES
(
  5, -- PersonID of JetSetters Corp.
  6, -- PersonID of the customer leasing the aircraft
  'N12345', -- Registration number of the aircraft
  '2024-05-01', -- Start date of lease
  '2024-11-01', -- End date of lease
  'The lessee shall maintain the aircraft in good working condition and adhere to all maintenance and operational regulations as required by aviation law. The lessee is responsible for all operational costs during the lease period. The aircraft shall be used for private business travel only and shall not be subleased to any third parties without prior written consent of the lessor.',
  20000.00, -- Monthly lease rate in the assumed currency
  50000.00  -- Security deposit
);

-- Adding OWNERSHIP_HISTORY table data
INSERT INTO OWNERSHIP_HISTORY (CustomerID, AircraftRegistrationNumber, SaleDate)
VALUES (1, 'G-BIGG', '2022-01-01');

-- Adding PARKING_SLOT table data
INSERT INTO PARKING_SLOT (Location, SlotType, UsageType, Status, ExpectedDuration)
VALUES ('Hangar 3', 'hangar', 'long_term', 'occupied', 30);

-- Inserting skill sets for Bob Johnson and Emma Clark
INSERT INTO SKILL_SET (PersonID, AircraftTypeID, SkillDescription)
VALUES
(3, 1, 'Qualified for routine maintenance and repairs on small jets'),
(4, 2, 'Experienced with avionic systems of commercial aircraft');

-- Inserting data into AIRCRAFT_TYPE_SKILLSET table
INSERT INTO AIRCRAFT_TYPE_SKILLSET (SkillsetID, PersonID, AircraftTypeID)
VALUES
(1, 3, 1), -- Bob Johnson has skills for Boeing 737
(2, 4, 2); -- Emma Clark has skills for Airbus A320

-- Inserting data into MAINTENANCE_SCHEDULE table
INSERT INTO MAINTENANCE_SCHEDULE (AircraftTypeID, MaintenanceActivity, IntervalHours, IntervalMonths)
VALUES
(1, 'Routine checkup and maintenance for Boeing 737', 200, 6),
(2, 'Routine checkup and maintenance for Airbus A320', 150, 4);

-- Inserting data into MAINTENANCE_SERVICE_RECORD table
INSERT INTO MAINTENANCE_SERVICE_RECORD (PersonID, ScheduleID, AircraftRegistrationNumber, MaintenanceDate, CostPerHour, MaintenanceType)
VALUES
(3, 1, 'G-BIGG', CURDATE(), 100.00, 'Full system diagnostics and engine tune-up'),
(4, 2, 'N12345', CURDATE(), 150.00, 'Avionics and controls system check');

-- Inserting data into CLEANING_SERVICE_RECORD table
INSERT INTO CLEANING_SERVICE_RECORD (AircraftRegistrationNumber, PersonID, Date, CostPerHour)
VALUES
('G-BIGG', 3, CURDATE(), 50.00),
('N12345', 4, CURDATE(), 50.00);

-- Inserting data into FUELING_RECORD table
INSERT INTO FUELING_RECORD (AircraftRegistrationNumber, PersonID, Price, Litres, Date, Time, Amount)
VALUES
('G-BIGG', 3, 5.00, 200.00, CURDATE(), CURTIME(), 1000.00),
('N12345', 4, 5.00, 150.00, CURDATE(), CURTIME(), 750.00);

-- Insert 'Very Large' size and 'Up to 500 passengers' capacity in the database
INSERT INTO AIRCRAFT_SIZE (SizeDescription) VALUES ('Very Large') ON DUPLICATE KEY UPDATE SizeID=LAST_INSERT_ID(SizeID);
SET @VeryLargeSizeID = LAST_INSERT_ID();

INSERT INTO AIRCRAFT_CAPACITY (CapacityDescription) VALUES ('Up to 500 passengers') ON DUPLICATE KEY UPDATE CapacityID=LAST_INSERT_ID(CapacityID);
SET @UpTo500PassengerCapacityID = LAST_INSERT_ID();

-- Insert new aircraft type for the Boeing 747 with the references to the appropriate size and capacity
INSERT INTO AIRCRAFT_TYPE (SizeID, CapacityID, AircraftType, ModelNumber)
VALUES (@VeryLargeSizeID, @UpTo500PassengerCapacityID, 'Jet', 'Boeing 747');
SET @Boeing747TypeID = LAST_INSERT_ID();

-- Insert a new record in the AIRCRAFT table for the Boeing 747 aircraft with its newly assigned type
INSERT INTO AIRCRAFT (AircraftRegistrationNumber, CustomerID, AircraftTypeID, ParkingStorageLocation)
VALUES ('G-747BIG', 1, @Boeing747TypeID, 'Corporate Hangar B');

-- Insert specific maintenance schedule for the Boeing 747, let's add that to the database
INSERT INTO MAINTENANCE_SCHEDULE (AircraftTypeID, MaintenanceActivity, IntervalHours, IntervalMonths)
VALUES (@Boeing747TypeID, 'Annual maintenance for Boeing 747', 1000, 12);
SET @Boeing747ScheduleID = LAST_INSERT_ID();

-- Insert an overdue maintenance record for the Boeing 747
INSERT INTO MAINTENANCE_SERVICE_RECORD (PersonID, ScheduleID, AircraftRegistrationNumber, MaintenanceDate, CostPerHour, MaintenanceType)
VALUES (3, @Boeing747ScheduleID, 'G-747BIG', CURDATE() - INTERVAL 14 MONTH, 200.00, 'Annual system overhaul for Boeing 747');


-- Insert data into AIRCRAFT_SIZE table for new size categories if they do not already exist
INSERT INTO AIRCRAFT_SIZE (SizeDescription)
VALUES 
('Very Small'), 
('Small'), 
('Mid-size'), 
('Large'), 
('Very Large') 
AS new_values (SizeDescription)
ON DUPLICATE KEY UPDATE 
SizeDescription = new_values.SizeDescription;

-- Insert data into AIRCRAFT_CAPACITY table for new capacity categories if they do not already exist
INSERT INTO AIRCRAFT_CAPACITY (CapacityDescription)
VALUES 
('Up to 6 passengers'), 
('Up to 8 passengers'), 
('Up to 12 passengers'), 
('Up to 50 passengers'), 
('Up to 200 passengers') 
AS new_values (CapacityDescription)
ON DUPLICATE KEY UPDATE 
CapacityDescription = new_values.CapacityDescription;

-- Insert data into AIRCRAFT_TYPE table for common types of aircraft
-- Aircraft Type IDs are assumed to be auto-incremented
INSERT INTO AIRCRAFT_TYPE (SizeID, CapacityID, AircraftType, ModelNumber)
SELECT SizeID, CapacityID, 'Mid-size Jet', 'Gulfstream G200' FROM (SELECT (SELECT SizeID FROM AIRCRAFT_SIZE WHERE SizeDescription = 'Mid-size') AS SizeID, (SELECT CapacityID FROM AIRCRAFT_CAPACITY WHERE CapacityDescription = 'Up to 12 passengers') AS CapacityID) AS subquery
ON DUPLICATE KEY UPDATE 
AircraftType = VALUES(AircraftType), ModelNumber = VALUES(ModelNumber);

-- Insert data into AIRCRAFT table for specific aircraft with their registration numbers
-- Aircraft Type IDs should match the IDs from the previous inserts
INSERT INTO AIRCRAFT (AircraftRegistrationNumber, CustomerID, AircraftTypeID, ParkingStorageLocation)
VALUES 
('N123XX', 1, 1, 'Hangar 1'), -- Small business jet, belongs to CustomerID 1
('N456XX', 2, 2, 'Hangar 2'), -- Large business jet, belongs to CustomerID 2
('N789XX', 3, 3, 'Hangar 3'); -- Very Large business jet, belongs to CustomerID 3

-- Assuming the PRICE per litre of fuel is £1.5 and we're inserting historical prices
-- The fuel prices would normally be retrieved from a table or an external source, here we're using a fixed value for simplicity
INSERT INTO FUELING_RECORD (AircraftRegistrationNumber, PersonID, Price, Litres, Date, Time, Amount)
VALUES 
('N123XX', 3, 1.5, 1400, '2022-08-01', '10:00:00', 2100.00), -- Refueling a mid-size business jet
('N456XX', 3, 1.5, 2800, '2022-08-02', '11:00:00', 4200.00), -- Refueling a large business jet
('N789XX', 3, 1.5, 7000, '2022-08-03', '12:00:00', 10500.00); -- Refueling a very large business jet

-- Insert data for cleaning service records, assuming a flat fee of £500
INSERT INTO CLEANING_SERVICE_RECORD (AircraftRegistrationNumber, PersonID, Date, CostPerHour)
VALUES 
('N123XX', 4, '2022-08-01', 500.00),
('N456XX', 4, '2022-08-02', 500.00),
('N789XX', 4, '2022-08-03', 500.00);

-- Insert data for maintenance service records, assuming a cost range of £5000 to £10000
-- ScheduleID would be related to the ID from the MAINTENANCE_SCHEDULE table
-- For the sake of example, we're using fixed values and not referring to a specific schedule
INSERT INTO MAINTENANCE_SERVICE_RECORD (PersonID, ScheduleID, AircraftRegistrationNumber, MaintenanceDate, CostPerHour, MaintenanceType)
VALUES 
(4, 1, 'N123XX', '2022-08-01', 5000.00, 'Routine service'),
(4, 2, 'N456XX', '2022-08-02', 7500.00, 'Routine service'),
(4, 3, 'N789XX', '2022-08-03', 10000.00, 'Routine service');

-- Example: Insert a parking reservation for February
INSERT INTO PARKING_RESERVATION (CustomerID, PilotID, AircraftRegistrationNumber, ParkingSlotID, StartDate, EndDate, ReservationType)
VALUES (1, 2, 'G-BIGG', 1, '2024-02-01', '2024-02-28', 'resident');

-- Example: Insert a fuelling record for February
INSERT INTO FUELING_RECORD (AircraftRegistrationNumber, PersonID, Price, Litres, Date, Time, Amount)
VALUES ('G-BIGG', 3, 1.50, 1000, '2024-02-15', '12:00:00', 1500);

-- Example: Insert a maintenance service record for February
INSERT INTO MAINTENANCE_SERVICE_RECORD (PersonID, ScheduleID, AircraftRegistrationNumber, MaintenanceDate, CostPerHour, MaintenanceType)
VALUES (3, 1, 'G-BIGG', '2024-02-10', 100, 'Routine Checkup');

INSERT INTO CLEANING_SERVICE_RECORD (AircraftRegistrationNumber, PersonID, Date, CostPerHour)
VALUES ('G-BIGG', 3, '2024-02-05', 500);

-- Inserting flight records for February 2024
-- Assuming that we already have a set of `PilotID` and `AircraftRegistrationNumber` that are valid.
INSERT INTO FLIGHT_RECORD (PilotID, AircraftRegistrationNumber, TakeOffDate, LandingDate)
VALUES 
  ((SELECT PersonID FROM PILOT WHERE LicenseNumber = 'PIL123456'), 'G-BIGG', '2024-02-01 08:00:00', '2024-02-01 10:00:00'),
  ((SELECT PersonID FROM PILOT WHERE LicenseNumber = 'PIL123456'), 'G-BIGG', '2024-02-02 08:00:00', '2024-02-02 10:00:00')
;

-- Inserting parts data
INSERT INTO PARTS (PartNumber, PartName, Price)
VALUES 
  ('PART001', 'Oil Filter', 35.00),
  ('PART002', 'Fuel Pump', 250.00)
;

-- First, let's capture the ServiceID for the most recent maintenance record for 'G-BIGG' into a variable
SET @ServiceID_G_BIGG = (SELECT ServiceID FROM MAINTENANCE_SERVICE_RECORD WHERE AircraftRegistrationNumber = 'G-BIGG' ORDER BY MaintenanceDate DESC LIMIT 1);

-- Capture the PartIDs for PART001 and PART002 into variables
SET @PartID_PART001 = (SELECT PartID FROM PARTS WHERE PartNumber = 'PART001');
SET @PartID_PART002 = (SELECT PartID FROM PARTS WHERE PartNumber = 'PART002');

-- Insert the maintenance parts data using the captured variables, while checking for duplicates
INSERT INTO MAINTENANCE_PARTS (MaintenanceID, PartID, Quantity)
VALUES 
  (@ServiceID_G_BIGG, @PartID_PART001, 1),
  (@ServiceID_G_BIGG, @PartID_PART002, 2)
ON DUPLICATE KEY UPDATE Quantity = VALUES(Quantity);


-- Inserting flight logs for February 2024
-- Assuming that `PilotID` and `AircraftRegistrationNumber` are already known.
INSERT INTO FLIGHT_LOGS (PilotID, AircraftRegistrationNumber, OperationType, DateTime)
VALUES 
  ((SELECT PersonID FROM PILOT WHERE LicenseNumber = 'PIL123456'), 'G-BIGG', 'take-off', '2024-02-01 08:00:00'),
  ((SELECT PersonID FROM PILOT WHERE LicenseNumber = 'PIL123456'), 'G-BIGG', 'landing', '2024-02-01 10:00:00')
;

INSERT INTO FLIGHT_RECORD (PilotID, AircraftRegistrationNumber, TakeOffDate, LandingDate) 
VALUES  
  ((SELECT PersonID FROM PILOT ORDER BY PersonID LIMIT 1), 
  (SELECT AircraftRegistrationNumber FROM AIRCRAFT ORDER BY AircraftRegistrationNumber LIMIT 1), 
  '2024-02-01 09:00:00', '2024-02-01 11:00:00'),
  ((SELECT PersonID FROM PILOT ORDER BY PersonID LIMIT 1), 
  (SELECT AircraftRegistrationNumber FROM AIRCRAFT ORDER BY AircraftRegistrationNumber LIMIT 1), 
  '2024-02-02 09:00:00', '2024-02-02 11:00:00');

-- Inserting additional aircraft types
INSERT INTO AIRCRAFT_TYPE (AircraftType, ModelNumber) VALUES ('Propeller', 'King Air B200');
SET @PropellerAircraftTypeID = LAST_INSERT_ID();

INSERT INTO AIRCRAFT_TYPE (AircraftType, ModelNumber) VALUES ('Helicopter', 'Sikorsky S-76');
SET @HelicopterAircraftTypeID = LAST_INSERT_ID();

-- Inserting aircraft owned by "JetSetters Corp." with different types
INSERT INTO AIRCRAFT (AircraftRegistrationNumber, CustomerID, AircraftTypeID, ParkingStorageLocation) VALUES ('JS-PROP', 5, @PropellerAircraftTypeID, 'Hangar 1');
INSERT INTO AIRCRAFT (AircraftRegistrationNumber, CustomerID, AircraftTypeID, ParkingStorageLocation) VALUES ('JS-HELI', 5, @HelicopterAircraftTypeID, 'Hangar 2');

-- Inserting employees with skills for the new aircraft types
INSERT INTO EMPLOYEE (PersonID, TeamID, Salary, ShiftWorked, Field) VALUES (5, 1, 45000, 'Day', NULL), (6, 1, 45000, 'Day', NULL);
INSERT INTO PERSON (Name, AddressLine1, PhoneNumber, Email, SocialInsuranceNumber, Role) VALUES ('Chris Turner', '789 Rotor Way', '555-5678', 'chris@example.com', '234-56-7890', 'Employee'), ('Jamie Lopez', '101 Propeller Rd', '555-6789', 'jamie@example.com', '345-67-8901', 'Employee');

-- Assuming Chris Turner is PersonID=7 and Jamie Lopez is PersonID=8 after insert
INSERT INTO SKILL_SET (PersonID, AircraftTypeID, SkillDescription) VALUES (7, @PropellerAircraftTypeID, 'Qualified for routine maintenance on propeller aircraft'), (8, @HelicopterAircraftTypeID, 'Qualified for routine maintenance on helicopters');

-- Inserting maintenance schedule for the new aircraft types
INSERT INTO MAINTENANCE_SCHEDULE (AircraftTypeID, MaintenanceActivity, IntervalHours, IntervalMonths) VALUES (@PropellerAircraftTypeID, 'Routine maintenance for King Air B200', 150, 6), (@HelicopterAircraftTypeID, 'Routine maintenance for Sikorsky S-76', 100, 12);

-- Inserting parts used during maintenance
INSERT INTO PARTS (PartNumber, PartName, Price) VALUES ('PART003', 'Propeller Blade', 1000.00), ('PART004', 'Helicopter Rotor Blade', 5000.00);

-- Inserting flight records for February 2024 for "JetSetters Corp." aircraft
INSERT INTO FLIGHT_RECORD (PilotID, AircraftRegistrationNumber, TakeOffDate, LandingDate) VALUES ((SELECT PersonID FROM PILOT WHERE LicenseNumber = 'PIL123456'), 'JS-PROP', '2024-02-01 09:00:00', '2024-02-01 11:00:00'), ((SELECT PersonID FROM PILOT WHERE LicenseNumber = 'PIL123456'), 'JS-HELI', '2024-02-02 09:00:00', '2024-02-02 11:00:00');

-- Inserting fuelling records for February 2024 for "JetSetters Corp." aircraft
INSERT INTO FUELING_RECORD (AircraftRegistrationNumber, PersonID, Price, Litres, Date, Time, Amount) VALUES ('JS-PROP', 3, 1.5, 800, '2024-02-01', '10:00:00', 1200.00), ('JS-HELI', 3, 1.5, 600, '2024-02-02', '11:00:00', 900.00);

-- Inserting cleaning service records for February 2024 for "JetSetters Corp." aircraft
INSERT INTO CLEANING_SERVICE_RECORD (AircraftRegistrationNumber, PersonID, Date, CostPerHour) VALUES ('JS-PROP', 4, '2024-02-03', 500.00), ('JS-HELI', 4, '2024-02-04', 500.00);

-- Inserting Mia Turner into PERSON
INSERT INTO PERSON (Name, AddressLine1, PhoneNumber, Email, SocialInsuranceNumber, Role)
VALUES ('Mia Turner', '789 Maintenance Blvd', '555-5678', 'miaturner@example.com', '234-56-7890', 'Employee')
ON DUPLICATE KEY UPDATE Name = VALUES(Name);

-- Inserting Alex Reed into PERSON
INSERT INTO PERSON (Name, AddressLine1, PhoneNumber, Email, SocialInsuranceNumber, Role)
VALUES ('Alex Reed', '101 Propeller Rd', '555-6789', 'alexreed@example.com', '345-67-8901', 'Employee')
ON DUPLICATE KEY UPDATE Name = VALUES(Name);

-- Inserting Mia Turner into EMPLOYEE
INSERT INTO EMPLOYEE (PersonID, TeamID, Salary, ShiftWorked, Field)
SELECT PersonID, 1, 45000, 'Day', NULL FROM PERSON WHERE SocialInsuranceNumber = '234-56-7890';

-- Inserting Alex Reed into EMPLOYEE
INSERT INTO EMPLOYEE (PersonID, TeamID, Salary, ShiftWorked, Field)
SELECT PersonID, 1, 45000, 'Day', NULL FROM PERSON WHERE SocialInsuranceNumber = '345-67-8901';

-- Assigning skills to Mia Turner based on her SocialInsuranceNumber
INSERT INTO SKILL_SET (PersonID, AircraftTypeID, SkillDescription)
SELECT p.PersonID, 2, 'Qualified for routine maintenance on Jet aircraft' FROM PERSON p WHERE p.SocialInsuranceNumber = '234-56-7890'
UNION ALL
SELECT p.PersonID, 5, 'Qualified for routine maintenance on Propeller aircraft' FROM PERSON p WHERE p.SocialInsuranceNumber = '234-56-7890'
UNION ALL
SELECT p.PersonID, 6, 'Qualified for routine maintenance on Helicopters' FROM PERSON p WHERE p.SocialInsuranceNumber = '234-56-7890';

-- Assigning skills to Alex Reed based on his SocialInsuranceNumber
INSERT INTO SKILL_SET (PersonID, AircraftTypeID, SkillDescription)
SELECT p.PersonID, 2, 'Qualified for routine maintenance on Jet aircraft' FROM PERSON p WHERE p.SocialInsuranceNumber = '345-67-8901'
UNION ALL
SELECT p.PersonID, 5, 'Qualified for routine maintenance on Propeller aircraft' FROM PERSON p WHERE p.SocialInsuranceNumber = '345-67-8901'
UNION ALL
SELECT p.PersonID, 6, 'Qualified for routine maintenance on Helicopters' FROM PERSON p WHERE p.SocialInsuranceNumber = '345-67-8901';

-- Insert maintenance records for Mia Turner
INSERT INTO MAINTENANCE_SERVICE_RECORD (PersonID, ScheduleID, AircraftRegistrationNumber, MaintenanceDate, CostPerHour, MaintenanceType)
SELECT p.PersonID, (SELECT ScheduleID FROM MAINTENANCE_SCHEDULE WHERE AircraftTypeID = 2 LIMIT 1), 'N12345', '2024-02-15', 100, 'Routine Checkup'
FROM PERSON p
WHERE p.SocialInsuranceNumber = '234-56-7890';

INSERT INTO MAINTENANCE_SERVICE_RECORD (PersonID, ScheduleID, AircraftRegistrationNumber, MaintenanceDate, CostPerHour, MaintenanceType)
SELECT p.PersonID, (SELECT ScheduleID FROM MAINTENANCE_SCHEDULE WHERE AircraftTypeID = 5 LIMIT 1), 'JS-PROP', '2024-02-16', 100, 'Routine Propeller Checkup'
FROM PERSON p
WHERE p.SocialInsuranceNumber = '234-56-7890';

INSERT INTO MAINTENANCE_SERVICE_RECORD (PersonID, ScheduleID, AircraftRegistrationNumber, MaintenanceDate, CostPerHour, MaintenanceType)
SELECT p.PersonID, (SELECT ScheduleID FROM MAINTENANCE_SCHEDULE WHERE AircraftTypeID = 6 LIMIT 1), 'JS-HELI', '2024-02-17', 100, 'Routine Helicopter Checkup'
FROM PERSON p
WHERE p.SocialInsuranceNumber = '234-56-7890';

-- Insert maintenance records for Alex Reed
INSERT INTO MAINTENANCE_SERVICE_RECORD (PersonID, ScheduleID, AircraftRegistrationNumber, MaintenanceDate, CostPerHour, MaintenanceType)
SELECT p.PersonID, (SELECT ScheduleID FROM MAINTENANCE_SCHEDULE WHERE AircraftTypeID = 2 LIMIT 1), 'N12345', '2024-02-18', 100, 'Routine Checkup'
FROM PERSON p
WHERE p.SocialInsuranceNumber = '345-67-8901';

INSERT INTO MAINTENANCE_SERVICE_RECORD (PersonID, ScheduleID, AircraftRegistrationNumber, MaintenanceDate, CostPerHour, MaintenanceType)
SELECT p.PersonID, (SELECT ScheduleID FROM MAINTENANCE_SCHEDULE WHERE AircraftTypeID = 5 LIMIT 1), 'JS-PROP', '2024-02-19', 100, 'Routine Propeller Checkup'
FROM PERSON p
WHERE p.SocialInsuranceNumber = '345-67-8901';

INSERT INTO MAINTENANCE_SERVICE_RECORD (PersonID, ScheduleID, AircraftRegistrationNumber, MaintenanceDate, CostPerHour, MaintenanceType)
SELECT p.PersonID, (SELECT ScheduleID FROM MAINTENANCE_SCHEDULE WHERE AircraftTypeID = 6 LIMIT 1), 'JS-HELI', '2024-02-20', 100, 'Routine Helicopter Checkup'
FROM PERSON p
WHERE p.SocialInsuranceNumber = '345-67-8901';


