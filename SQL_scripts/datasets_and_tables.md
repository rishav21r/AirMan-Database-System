## Datasets and Tables

### Person Table

| PersonID | Name              | AddressLine1       | AddressLine2 | PhoneNumber | Email                    | SocialInsuranceNumber | Role     |
|----------|-------------------|--------------------|--------------|-------------|-------------------------|-----------------------|----------|
| 1        | John Doe          | 123 Aviation Way   | NULL         | 555-1234    | johndoe@example.com     | 123-45-6789           | Customer |
| 2        | Alice Smith       | 234 Skyline Blvd   | NULL         | 555-2345    | alicesmith@example.com  | 987-65-4321           | Pilot    |
| 3        | Bob Johnson       | 345 Jetstream St   | NULL         | 555-3456    | bobjohnson@example.com  | 135-79-2468           | Employee |
| 4        | Emma Clark        | 456 Flight Ave     | NULL         | 555-4567    | emmaclark@example.com   | 222-33-4444           | Employee |
| 5        | JetSetters Corp.  | 100 Corporate Way  | NULL         | 555-1010    | contact@jetsetterscorp.com | 999-99-9999      | Customer |
| 6        | Global Air Travel | 200 Global Plaza   | NULL         | 555-2020    | info@globalairtravel.com | 888-88-8888         | Customer |
| 7        | Mia Turner        | 789 Rotor Way      | NULL         | 555-5678    | chris@example.com       | 234-56-7890           | Employee |
| 8        | Alex Reed         | 101 Propeller Rd   | NULL         | 555-6789    | jamie@example.com       | 345-67-8901           | Employee |

### Pilot Table

| PersonID | LicenseNumber | MedicalCertificationDate | FlightReviewDate | OperatingLimitations |
|----------|---------------|--------------------------|------------------|----------------------|
| 2        | PIL123456     | 2022-06-15               | 2022-06-15       | None                 |

### Employee Table

| PersonID | TeamID | Salary   | ShiftWorked | Field |
|----------|--------|----------|-------------|-------|
| 3        | 1      | 35000.00 | Morning     | NULL  |
| 4        | NULL   | 40000.00 | Day         | NULL  |
| 5        | 1      | 45000.00 | Day         | NULL  |
| 6        | 1      | 45000.00 | Day         | NULL  |
| 7        | 1      | 45000.00 | Day         | NULL  |
| 8        | 1      | 45000.00 | Day         | NULL  |

### Customer Table

| PersonID | CustomerCategory | ContactPerson |
|----------|------------------|---------------|
| 1        | Individual       | John Doe      |
| 5        | Corporation      | NULL          |
| 6        | Corporation      | NULL          |

### Team Table

| TeamID | Name               | SupervisorID |
|--------|--------------------|--------------|
| 1      | Maintenance Team   | NULL         |
| 2      | Ground Handling Team | NULL       |

### Skill Set Table

| SkillID | PersonID | AircraftTypeID | SkillDescription                                 |
|---------|----------|----------------|--------------------------------------------------|
| 1       | 3        | 1              | Qualified for routine maintenance and repairs on small jets |
| 2       | 4        | 2              | Experienced with avionic systems of commercial aircraft |
| 3       | 7        | 5              | Qualified for routine maintenance on propeller aircraft |
| 4       | 8        | 6              | Qualified for routine maintenance on helicopters  |
| 8       | 7        | 2              | Qualified for routine maintenance on Jet aircraft |
| 9       | 7        | 5              | Qualified for routine maintenance on Propeller aircraft |
| 10      | 7        | 6              | Qualified for routine maintenance on Helicopters  |
| 11      | 8        | 2              | Qualified for routine maintenance on Jet aircraft |
| 12      | 8        | 5              | Qualified for routine maintenance on Propeller aircraft |
| 13      | 8        | 6              | Qualified for routine maintenance on Helicopters  |

### Lease Agreement Table

| LeaseID | LessorID | LesseeID | AircraftRegistrationNumber | LeaseStartDate | LeaseEndDate | LeaseTerms                                                                                                                             | MonthlyLeaseRate | SecurityDeposit |
|---------|----------|----------|----------------------------|----------------|--------------|----------------------------------------------------------------------------------------------------------------------------------------|------------------|-----------------|
| 4       | 5        | 6        | N12345                     | 2024-05-01     | 2024-11-01   | The lessee shall maintain the aircraft in good working condition and adhere to all maintenance and operational regulations as required by aviation law. The lessee is responsible for all operational costs during the lease period. The aircraft shall be used for private business travel only and shall not be subleased to any third parties without prior written consent of the lessor. | 20000.00         | 50000.00        |

### Air Type Skillset Table

| SkillsetID | PersonID | AircraftTypeID |
|------------|----------|----------------|
| 1          | 3        | 1              |
| 2          | 4        | 2              |

### Aircraft Type Table

| AircraftTypeID | SizeID | CapacityID | AircraftType  | ModelNumber   |
|----------------|--------|------------|---------------|---------------|
| 1              | 2      | 3          | Jet           | Boeing 737    |
| 2              | 2      | 2          | Jet           | A320          |
| 3              | 4      | 4          | Jet           | Boeing 747    |
| 4              | 7      | 7          | Mid-size Jet  | Gulfstream G200 |
| 5              | NULL   | NULL       | Propeller     | King Air B200 |
| 6              | NULL   | NULL       | Helicopter    | Sikorsky S-76 |

### Aircraft Size Table

| SizeID | SizeDescription |
|--------|-----------------|
| 1      | Small           |
| 2      | Medium          |
| 3      | Large           |
| 4      | Very Large      |
| 5      | Very Small      |
| 6      | Small           |
| 7      | Mid-size        |
| 8      | Large           |
| 9      | Very Large      |

### Aircraft Capacity Table

| CapacityID | CapacityDescription  |
|------------|----------------------|
| 1          | Up to 10 passengers  |
| 2          | Up to 100 passengers |
| 3          | Up to 200 passengers |
| 4          | Up to 500 passengers |
| 5          | Up to 6 passengers   |
| 6          | Up to 8 passengers   |
| 7          | Up to 12 passengers  |
| 8          | Up to 50 passengers  |
| 9          | Up to 200 passengers |

### Cleaning Service Record Table

| CleaningServiceID | AircraftRegistrationNumber | PersonID | Date       | CostPerHour |
|-------------------|----------------------------|----------|------------|-------------|
| 1                 | G-BIGG                     | 3        | 2024-04-03 | 50.00       |
| 2                 | N12345                     | 4        | 2024-04-03 | 50.00       |
| 3                 | N123XX                     | 4        | 2022-08-01 | 500.00      |
| 4                 | N456XX                     | 4        | 2022-08-02 | 500.00      |
| 5                 | N789XX                     | 4        | 2022-08-03 | 500.00      |
| 6                 | G-BIGG                     | 3        | 2024-02-05 | 500.00      |
| 7                 | JS-PROP                    | 4        | 2024-02-03 | 500.00      |
| 8                 | JS-HELI                    | 4        | 2024-02-04 | 500.00      |

### Aircraft Table

| AircraftRegistrationNumber | CustomerID | AircraftTypeID | ParkingStorageLocation |
|----------------------------|------------|----------------|------------------------|
| G-747BIG                   | 1          | 3              | Corporate Hangar B     |
| G-BIGG                     | 1          | 1              | Hangar 3               |
| JS-HELI                    | 5          | 6              | Hangar 2               |
| JS-PROP                    | 5          | 5              | Hangar 1               |
| N12345                     | 5          | 2              | Corporate Hangar A     |
| N123XX                     | 1          | 1              | Hangar 1               |
| N456XX                     | 2          | 2              | Hangar 2               |
| N789XX                     | 3          | 3              | Hangar 3               |

### Flight Record Table

| FlightRecordID | PilotID | AircraftRegistrationNumber | TakeOffDate          | LandingDate           |
|----------------|---------|----------------------------|----------------------|-----------------------|
| 1              | 2       | G-BIGG                     | 2024-02-01 08:00:00  | 2024-02-01 10:00:00   |
| 2              | 2       | G-BIGG                     | 2024-02-02 08:00:00  | 2024-02-02 10:00:00   |
| 5              | 2       | G-747BIG                   | 2024-02-01 09:00:00  | 2024-02-01 11:00:00   |
| 6              | 2       | G-747BIG                   | 2024-02-02 09:00:00  | 2024-02-02 11:00:00   |
| 7              | 2       | G-747BIG                   | 2024-02-01 09:00:00  | 2024-02-01 11:00:00   |
| 8              | 2       | G-747BIG                   | 2024-02-02 09:00:00  | 2024-02-02 11:00:00   |
| 9              | 2       | JS-PROP                    | 2024-02-01 09:00:00  | 2024-02-01 11:00:00   |
| 10             | 2       | JS-HELI                    | 2024-02-02 09:00:00  | 2024-02-02 11:00:00   |

### Flight Logs Table

| LogID | PilotID | AircraftRegistrationNumber | OperationType | DateTime            |
|-------|---------|----------------------------|---------------|---------------------|
| 1     | 2       | G-BIGG                     | take-off      | 2024-02-01 08:00:00 |
| 2     | 2       | G-BIGG                     | landing       | 2024-02-01 10:00:00 |
| 3     | 2       | G-BIGG                     | take-off      | 2024-02-01 08:00:00 |
| 4     | 2       | G-BIGG                     | landing       | 2024-02-01 10:00:00 |
| 5     | 2       | G-BIGG                     | take-off      | 2024-02-01 08:00:00 |
| 6     | 2       | G-BIGG                     | landing       | 2024-02-01 10:00:00 |

### Flight Records Table

| FlightRecordID | PilotID | AircraftRegistrationNumber | TakeOffDate          | LandingDate           |
|----------------|---------|----------------------------|----------------------|-----------------------|
| 1              | 2       | G-BIGG                     | 2024-02-01 08:00:00  | 2024-02-01 10:00
