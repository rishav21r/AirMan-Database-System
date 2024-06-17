## Data Definitions and Normalizations

### Customers

| Attribute           | Data Type | Constraints          | Description                                                    |
|---------------------|-----------|----------------------|----------------------------------------------------------------|
| `PersonID`          | Int       | PK, FK               | Unique identifier for each customer                            |
| `CustomerCategory`  | ENUM      |                      | Category of the customer                                       |
| `ContactPerson`     | Varchar   |                      | Contact person for the customer                                |

### Pilot

| Attribute                | Data Type | Constraints | Description                                        |
|--------------------------|-----------|-------------|----------------------------------------------------|
| `PersonID`               | Int       | PK, FK      | Unique identifier for each pilot                   |
| `LicenseNumber`          | Varchar   |             | License number of the pilot                        |
| `AircraftTypeRestrictions` | Varchar  |             | Restrictions on aircraft types the pilot can fly   |
| `OperationalStatus`      | Varchar   |             | Operational status of the pilot                    |

### Employee

| Attribute      | Data Type | Constraints | Description                                            |
|----------------|-----------|-------------|--------------------------------------------------------|
| `PersonID`     | Int       | PK, FK      | Unique identifier for each employee                    |
| `TeamID`       | Int       | FK          | Identifier for the team the employee belongs to        |
| `Salary`       | Decimal   |             | Salary of the employee                                 |
| `ShiftWorked`  | Varchar   |             | Shift worked by the employee                           |
| `Field`        | Int       |             | Field identifier for the employee                      |

### Team

| Attribute      | Data Type | Constraints | Description                                             |
|----------------|-----------|-------------|---------------------------------------------------------|
| `TeamID`       | Int       | PK          | Unique identifier for each team                         |
| `Name`         | Varchar   |             | Name of the team                                        |
| `SupervisorID` | Int       | FK          | Identifier for the supervisor of the team               |

### Person

| Attribute              | Data Type | Constraints | Description                                             |
|------------------------|-----------|-------------|---------------------------------------------------------|
| `PersonID`             | Int       | PK          | Unique identifier for each person                       |
| `Name`                 | Varchar   |             | Name of the person                                      |
| `Address`              | Varchar   |             | Address of the person                                   |
| `PhoneNumber`          | Varchar   |             | Phone number of the person                              |
| `Email`                | Varchar   |             | Email address of the person                             |
| `SocialInsuranceNumber`| Varchar   |             | Social insurance number of the person                   |
| `Role`                 | ENUM      |             | Role of the person within the organization              |

### Skill_Set

| Attribute           | Data Type | Constraints | Description                                             |
|---------------------|-----------|-------------|---------------------------------------------------------|
| `SkillID`           | Int       | PK          | Unique identifier for each skill set                    |
| `PersonID`          | Int       | FK          | Identifier for the person possessing the skill set      |
| `AircraftTypeID`    | Int       | FK          | Identifier for the aircraft type related to the skill   |
| `SkillDescription`  | Varchar   |             | Description of the skill                                |

### Lease_Agreement

| Attribute                 | Data Type | Constraints | Description                                             |
|---------------------------|-----------|-------------|---------------------------------------------------------|
| `LeaseID`                 | Int       | PK          | Unique identifier for each lease agreement              |
| `LessorID`                | Int       | FK          | Identifier for the lessor                               |
| `LesseeID`                | Int       | FK          | Identifier for the lessee                               |
| `AircraftRegistrationNumber` | Varchar | FK          | Registration number of the leased aircraft              |
| `LeaseStartDate`          | DATE      |             | Start date of the lease agreement                       |
| `LeaseEndDate`            | DATE      |             | End date of the lease agreement                         |
| `LeaseTerms`              | Text      |             | Terms of the lease agreement                            |
| `MonthlyLeaseRate`        | Decimal   |             | Monthly lease rate                                      |
| `SecurityDeposit`         | Decimal   |             | Security deposit amount                                 |

### Aircraft_Type_Skillset

| Attribute        | Data Type | Constraints | Description                                             |
|------------------|-----------|-------------|---------------------------------------------------------|
| `SkillsetID`     | Int       | PK          | Unique identifier for each skill set                    |
| `PersonID`       | Int       | FK          | Identifier for the person possessing the skill set      |
| `AircraftTypeID` | Int       | FK          | Identifier for the aircraft type related to the skill   |

### Aircraft_Type

| Attribute        | Data Type | Constraints | Description                                             |
|------------------|-----------|-------------|---------------------------------------------------------|
| `AircraftTypeID` | Int       | PK          | Unique identifier for each aircraft type                |
| `SizeID`         | Int       | FK          | Identifier for the size category of the aircraft        |
| `CapacityID`     | Int       | FK          | Identifier for the capacity category of the aircraft    |
| `AircraftType`   | Varchar   |             | Type of the aircraft                                    |
| `ModelNumber`    | Varchar   |             | Model number of the aircraft                            |

### Aircraft_Size

| Attribute        | Data Type | Constraints | Description                                             |
|------------------|-----------|-------------|---------------------------------------------------------|
| `SizeID`         | Int       | PK          | Unique identifier for each size category                |
| `SizeDescription`| Varchar   |             | Description of the size category                        |

### Aircraft_Capacity

| Attribute              | Data Type | Constraints | Description                                             |
|------------------------|-----------|-------------|---------------------------------------------------------|
| `CapacityID`           | Int       | PK          | Unique identifier for each capacity category            |
| `CapacityDescription`  | Varchar   |             | Description of the capacity category                    |

### Cleaning_Service_Record

| Attribute                 | Data Type | Constraints | Description                                             |
|---------------------------|-----------|-------------|---------------------------------------------------------|
| `CleaningServiceID`       | Int       | PK          | Unique identifier for each cleaning service record      |
| `AircraftRegistrationNumber` | Varchar | FK          | Registration number of the cleaned aircraft             |
| `PersonID`                | Int       | FK          | Identifier for the person performing the cleaning       |
| `Date`                    | Date      |             | Date of the cleaning service                            |
| `CostPerHour`             | Decimal   |             | Cost per hour for the cleaning service                  |

### Aircraft

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `RegistrationNumber`       | Varchar   | PK          | Unique registration number for each aircraft            |
| `CustomerID`               | Int       | FK          | Identifier for the customer owning the aircraft         |
| `AircraftTypeID`           | Int       | FK          | Identifier for the type of the aircraft                 |
| `ParkingStorageLocation`   | Varchar   |             | Parking/storage location of the aircraft                |

### Flight_Record

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `FlightRecordID`           | Int       | PK          | Unique identifier for each flight record                |
| `PilotID`                  | Int       | FK          | Identifier for the pilot responsible for the flight     |
| `AircraftRegistrationNumber` | Varchar | FK          | Registration number of the aircraft involved in the flight |
| `TakeOffDate`              | DATETIME  |             | Take-off date and time of the flight                    |
| `LandingDate`              | DATETIME  |             | Landing date and time of the flight                     |

### Flights_Log

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `LogID`                    | Int       | PK          | Unique identifier for each flight log                   |
| `PilotID`                  | Int       | FK          | Identifier for the pilot involved in the flight operation |
| `AircraftRegistrationNumber` | Varchar | FK          | Registration number of the aircraft involved in the flight operation |
| `OperationType`            | ENUM      |             | Type of operation performed during the flight           |
| `DateTime`                 | DATETIME  |             | Date and time of the flight operation                   |

### Fueling_Record

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `FuelingID`                | Int       | PK          | Unique identifier for each fueling record               |
| `AircraftRegistrationNumber` | Varchar | FK          | Registration number of the fueled aircraft              |
| `PersonID`                 | Int       | FK          | Identifier for the person performing the fueling        |
| `Price`                    | Decimal   |             | Price of the fuel                                       |
| `Gallons`                  | Decimal   |             | Amount of fuel in gallons                               |
| `Liters`                   | Decimal   |             | Amount of fuel in liters                                |
| `Date`                     | Date      |             | Date of the fueling                                     |
| `Time`                     | Time      |             | Time of the fueling                                     |
| `Amount`                   | Decimal   |             | Total amount for the fueling                            |

### Ownership_History

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `OwnershipHistoryID`       | Int       | PK          | Unique identifier for each ownership history record     |
| `CustomerID`               | Int       | FK          | Identifier for the customer who owned the aircraft      |
| `AircraftRegistrationID`   | Varchar   | FK          | Registration ID of the aircraft                         |
| `SaleDate`                 | Date      | NULL        | Sale date of the aircraft, if applicable                |

### Parking_Reservation

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `ReservationID`            | Int       | PK          | Unique identifier for each parking reservation          |
| `CustomerID`               | Int       | FK          | Identifier for the customer making the reservation      |
| `PilotID`                  | Int       | FK          | Identifier for the pilot associated with the reservation |
| `AircraftRegistrationID`   | Varchar   | FK          | Registration ID of the aircraft                         |
| `ParkingSlotID`            | Int       | FK          | Identifier for the reserved parking slot                |
| `StartDate`                | Date      |             | Start date of the parking reservation                   |
| `EndDate`                  | Date      |             | End date of the parking reservation                     |
| `ReservationType`          | ENUM      |             | Type of the parking reservation                         |

### Parking_Slot

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `ParkingSlotID`            | Int       | PK          | Unique identifier for each parking slot                 |
| `Location`                 | Varchar   |             | Location of the parking slot                            |
| `SlotType`                 | ENUM      |             | Type of the parking slot                                |
| `UsageType`                | ENUM      |             | Usage type of the parking slot                          |
| `Status`                   | ENUM      |             | Status of the parking slot                              |

### Parts

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `PartID`                   | Int       | PK          | Unique identifier for each part                         |
| `PartNumber`               | Varchar   |             | Part number                                             |
| `PartName`                 | Varchar   |             | Part name                                               |
| `Price`                    | Decimal   |             | Price of the part                                       |

### Maintenance_Parts

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `MaintenanceID`            | Int       | PK          | Unique identifier for each maintenance part record      |
| `PartID`                   | Int       | FK          | Identifier for the part used in maintenance             |
| `Quantity`                 | Int       |             | Quantity of the part used                               |

### Maintenance_Service_Record

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `ServiceID`                | Int       | PK          | Unique identifier for each maintenance service record   |
| `AircraftRegistrationID`   | Varchar   | FK          | Registration ID of the aircraft                         |
| `ScheduleID`               | Int       | FK          | Identifier for the maintenance schedule                 |
| `PersonID`                 | Int       | FK          | Identifier for the person performing the maintenance    |
| `MaintenanceDate`          | Date      |             | Date of the maintenance                                 |
| `CostPerHour`              | Decimal   |             | Cost per hour for the maintenance                       |
| `MaintenanceType`          | Varchar   |             | Type of maintenance performed                           |

### Maintenance_Schedule

| Attribute                  | Data Type | Constraints | Description                                             |
|----------------------------|-----------|-------------|---------------------------------------------------------|
| `ScheduleID`               | Int       | PK          | Unique identifier for each maintenance schedule         |
| `AircraftID`               | Int       | FK          | Identifier for the aircraft                             |
| `MaintenanceActivity`      | Varchar   |             | Description of the maintenance activity                 |
| `IntervalHours`            | Int       |             | Interval in hours for the maintenance activity          |
| `IntervalMonths`           | Int       |             | Interval in months for the maintenance activity         |


## Normalization

The database design adheres to the principles of normalization to eliminate redundancy and ensure data integrity.

### First Normal Form (1NF)
- Ensures that each table has a primary key.
- Each column contains atomic values, and each record is unique.

### Second Normal Form (2NF)
- Ensures that all non-key attributes are fully functional and dependent on the primary key.
- Removes partial dependencies, where an attribute is dependent on only a part of the primary key.

### Third Normal Form (3NF)
- Ensures that there are no transitive dependencies.
- All attributes are functionally dependent only on the primary key.
