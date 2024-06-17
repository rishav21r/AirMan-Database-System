# ------------------------------------------------------------------------------------------------------------------------------------
# Q1. Calculate the landing, service, fuelling, and parking fees for a customer of your choice in February 2024 and indicate if this 
#     customer is a corporation.
# ------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    -- Selecting Customer ID and Category to determine if it is a corporation or an individual
    c.PersonID,
    c.CustomerCategory,

    -- Subquery to calculate the total landing fees for the customer's aircraft
    -- Assuming each landing costs £1000
    (SELECT SUM(1000) FROM FLIGHT_RECORD WHERE AircraftRegistrationNumber IN 
        (SELECT AircraftRegistrationNumber FROM AIRCRAFT WHERE CustomerID = c.PersonID) AND 
        MONTH(LandingDate) = 2 AND YEAR(LandingDate) = 2024) AS LandingFees,

    -- Subquery to calculate the total service fees for the customer's aircraft
    -- Assuming each service takes 2 hours at the rate defined in the service record
    -- This assumes a standard service duration as actual hours worked data is not available
    (SELECT SUM(CostPerHour * 2) FROM MAINTENANCE_SERVICE_RECORD WHERE AircraftRegistrationNumber IN 
        (SELECT AircraftRegistrationNumber FROM AIRCRAFT WHERE CustomerID = c.PersonID) AND 
        MONTH(MaintenanceDate) = 2 AND YEAR(MaintenanceDate) = 2024) AS ServiceFees,

    -- Subquery to calculate the total fuelling fees for the customer's aircraft
    -- Based on the actual amount charged in the fueling records
    (SELECT SUM(Amount) FROM FUELING_RECORD WHERE AircraftRegistrationNumber IN 
        (SELECT AircraftRegistrationNumber FROM AIRCRAFT WHERE CustomerID = c.PersonID) AND 
        MONTH(Date) = 2 AND YEAR(Date) = 2024) AS FuellingFees,

    -- Subquery to calculate the total parking fees for the customer's aircraft
    -- Assuming a daily parking rate of £50
    -- Using the date range within February 2024 or until the end of the month if EndDate is NULL
    (SELECT SUM(DATEDIFF(IFNULL(EndDate, '2024-02-28'), StartDate) * 50) FROM PARKING_RESERVATION WHERE CustomerID = c.PersonID AND 
        MONTH(StartDate) <= 2 AND YEAR(StartDate) = 2024 AND (MONTH(EndDate) >= 2 OR EndDate IS NULL) AND YEAR(EndDate) = 2024) AS ParkingFees

-- The main FROM clause selecting from the CUSTOMER table to get the customer information
FROM CUSTOMER c

-- The WHERE clause to specify the particular customer of interest
WHERE c.PersonID = 1; -- Replace with the actual customer ID of interest

# ----------------------------------------------------------------------------------------------------------------------------------------------
# Q2. List which pilots who are also customers made the most take-offs and landings at the airport in February 2024 and indicate which aircraft 
#     the few by type and registration number.
# ----------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    -- Selecting the pilot's personal and aircraft information
    p.PersonID,
    pe.Name AS PilotName,
    COUNT(*) AS TotalMovements, -- Counting the number of flights for ranking
    at.AircraftType,
    at.ModelNumber,
    fr.AircraftRegistrationNumber

FROM 
    FLIGHT_RECORD fr
    -- Joining with the PILOT table to get pilot-specific details
    INNER JOIN PILOT p ON fr.PilotID = p.PersonID
    -- Joining with the PERSON table to check if the pilot is also a customer
    INNER JOIN PERSON pe ON p.PersonID = pe.PersonID AND pe.Role IN ('Pilot', 'Customer')
    -- Joining with the AIRCRAFT table to get the aircraft type
    INNER JOIN AIRCRAFT ac ON fr.AircraftRegistrationNumber = ac.AircraftRegistrationNumber
    -- Joining with the AIRCRAFT_TYPE table to get the model number and aircraft type
    INNER JOIN AIRCRAFT_TYPE at ON ac.AircraftTypeID = at.AircraftTypeID

WHERE 
    -- Filtering for the month of February 2024
    MONTH(fr.TakeOffDate) = 2 AND YEAR(fr.TakeOffDate) = 2024

GROUP BY 
    -- Grouping by the pilot and the aircraft to get unique counts
    p.PersonID, at.AircraftType, at.ModelNumber, fr.AircraftRegistrationNumber

ORDER BY 
    TotalMovements DESC -- Ordering by the total number of movements to find the most active pilot

-- Limiting to a reasonable number of results, you can remove or adjust this as needed
LIMIT 10;

# -----------------------------------------------------------------------------------------------------------------------------------------------
# Q3. List the employees (by employee number, name, and role) who are qualified service personnel who performed routine services on all aircraft 
#     owned by a specific corporation in February 2024. 
# -----------------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT
    E.PersonID,
    P.Name,
    P.Role
FROM
    MAINTENANCE_SERVICE_RECORD MSR
INNER JOIN EMPLOYEE E ON
    MSR.PersonID = E.PersonID
INNER JOIN PERSON P ON
    E.PersonID = P.PersonID
INNER JOIN AIRCRAFT A ON
    MSR.AircraftRegistrationNumber = A.AircraftRegistrationNumber
INNER JOIN PERSON CP ON
    A.CustomerID = CP.PersonID
WHERE
    MONTH(MSR.MaintenanceDate) = 2
    AND YEAR(MSR.MaintenanceDate) = 2024
    AND CP.Role = 'Customer'
    AND CP.Name = 'JetSetters Corp.'
GROUP BY
    E.PersonID, P.Name, P.Role
HAVING
    COUNT(DISTINCT A.AircraftRegistrationNumber) = (
        SELECT COUNT(DISTINCT AircraftRegistrationNumber) 
        FROM AIRCRAFT 
        WHERE CustomerID IN (
            SELECT PersonID FROM PERSON WHERE Name = 'JetSetters Corp.' AND Role = 'Customer'
        )
    );

# -------------------------------------------------------------------------------------------------------------------------------------------------
# Q4. List the employees (by employee number, name, and role) who are qualified service personnel who performed routine services on all aircraft 
#     owned by a specific corporation in February 2024.
# -------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    AT.AircraftType,
    P.PartNumber,
    P.PartName,
    COUNT(MP.PartID) AS QuantityUsed
FROM 
    MAINTENANCE_PARTS MP
JOIN PARTS P ON 
    MP.PartID = P.PartID
JOIN MAINTENANCE_SERVICE_RECORD MSR ON 
    MP.MaintenanceID = MSR.ServiceID
JOIN AIRCRAFT A ON 
    MSR.AircraftRegistrationNumber = A.AircraftRegistrationNumber
JOIN AIRCRAFT_TYPE AT ON 
    A.AircraftTypeID = AT.AircraftTypeID
GROUP BY 
    AT.AircraftType, P.PartNumber, P.PartName
ORDER BY 
    AT.AircraftType, P.PartNumber;

# -------------------------------------------------------------------------------------------------------------------------------------------------
# Q5. List the employees (by employee number, name, and role) who are qualified service personnel who performed routine services on all aircraft 
#     owned by a specific corporation in February 2024.
# -------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    SUM(COALESCE(FR.Amount, 0) + COALESCE(CSR.CostPerHour * TIMESTAMPDIFF(HOUR, CSR.Date, CSR.Date + INTERVAL 1 DAY), 0)) AS TotalRevenueToBigginHill
FROM 
    FUELING_RECORD FR
JOIN AIRCRAFT A ON 
    FR.AircraftRegistrationNumber = A.AircraftRegistrationNumber
LEFT JOIN CLEANING_SERVICE_RECORD CSR ON 
    A.AircraftRegistrationNumber = CSR.AircraftRegistrationNumber
WHERE 
    MONTH(FR.Date) = 2 AND YEAR(FR.Date) = 2024
    OR MONTH(CSR.Date) = 2 AND YEAR(CSR.Date) = 2024;
