# Pet-Healthcare-Database


---
🚀This README provides a **detailed overview** of the Pet Healthcare Database System, including its **business rules, database schema, and SQL queries**. 

## Introduction
Our **Pet Healthcare Database System** serves as a centralized digital solution to manage, store, and retrieve comprehensive information related to pets' health and medical records. The system's core entities include:
- Client
- Pet
- Staff
- Appointment
- Treatment
- Billing Information

## Business Rules
Here’s an overview of the **Business Rules** in our system:

1. **Clients** have a unique ID, name, phone number, address, email, and registration date.
2. **Pets** have a unique ID, name, species, date of birth, gender, and weight.
3. **Staff members** have a unique ID, name, role, specialization, phone number, address, email, and hire date.
4. **Appointments** have a unique ID, date, time, reason, room, status, and duration.
5. **Treatment records** have a unique ID, date, details, diagnosis, medications, and cost. They cannot exist independently without an appointment.
6. **Each client** can own one or more pets, but each pet is associated with only one client.
7. **Each pet** can have multiple appointments with staff members, but each appointment is associated with one pet and one staff member.
8. **Each appointment** is linked to one treatment record.
9. **Each treatment record** is added or modified by one staff member.
10. **Billing records** have a unique ID, total amount, payment status, payment method, and due date. They cannot exist independently without an appointment.
11. **Each billing record** is associated with one client and covers one appointment.
12. **Clients** can have multiple billing records associated with them.


## Database Schema & Queries
Below are the **SQL queries** used to create and insert data into the tables:

### 1. Client Table
```sql
CREATE TABLE Client (
    C_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Address TEXT NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    RegistrationDate DATE NOT NULL
);
```

### 2. Pet Table
```sql
CREATE TABLE Pet (
    P_ID INT PRIMARY KEY AUTO_INCREMENT,
    C_ID INT NOT NULL,
    Pname VARCHAR(255) NOT NULL,
    Species VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    Weight DECIMAL(4, 2) NOT NULL,
    FOREIGN KEY (C_ID) REFERENCES Client(C_ID) ON DELETE CASCADE
);
```

### 3. Staff Member Table
```sql
CREATE TABLE StaffMember (
    S_ID INT PRIMARY KEY AUTO_INCREMENT,
    Sname VARCHAR(255) NOT NULL,
    Role VARCHAR(100) NOT NULL,
    Specialization VARCHAR(255),
    PhoneNumber VARCHAR(15) NOT NULL,
    Address TEXT NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    HireDate DATE NOT NULL
);
```

### 4. Appointment Table
```sql
CREATE TABLE Appointment (
    APP_ID INT PRIMARY KEY AUTO_INCREMENT,
    P_ID INT NOT NULL,
    S_ID INT NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Reason TEXT NOT NULL,
    Room VARCHAR(50) NOT NULL,
    Status ENUM('Not Started','In progress','Completed') NOT NULL,
    Duration INT NOT NULL,
    FOREIGN KEY (P_ID) REFERENCES Pet(P_ID) ON DELETE CASCADE,
    FOREIGN KEY (S_ID) REFERENCES StaffMember(S_ID) ON DELETE CASCADE
);
```

### 5. Treatment Record Table
```sql
CREATE TABLE TreatmentRecord (
    TR_ID INT PRIMARY KEY AUTO_INCREMENT,
    APP_ID INT NOT NULL,
    S_ID INT NOT NULL,
    TreatmentDate DATE NOT NULL,
    Details TEXT NOT NULL,
    Diagnosis TEXT,
    Medications TEXT,
    Cost DECIMAL(7, 2) NOT NULL,  
    FOREIGN KEY (APP_ID) REFERENCES Appointment(APP_ID) ON DELETE CASCADE,
    FOREIGN KEY (S_ID) REFERENCES StaffMember(S_ID) ON DELETE CASCADE
);
```

### 6. Billing Record Table
```sql
CREATE TABLE BillingRecord (
    B_ID INT PRIMARY KEY AUTO_INCREMENT,
    APP_ID INT NOT NULL,
    C_ID INT NOT NULL,
    TotalAmount DECIMAL(7, 2) NOT NULL,
    PaymentStatus ENUM('Paid', 'Unpaid') NOT NULL,
    PaymentMethod ENUM ('Cash','Credit Card','Debit Card') NOT NULL,
    DueDate DATE NOT NULL,
    FOREIGN KEY (APP_ID) REFERENCES Appointment(APP_ID) ON DELETE CASCADE,
    FOREIGN KEY (C_ID) REFERENCES Client(C_ID) ON DELETE CASCADE
);
```

## Complex Queries
Below are some **advanced queries** executed in the system:

### 1. Staff Member Efficiency
Find the staff member who handled the highest number of appointments:
```sql
SELECT
    StaffMember.Sname AS StaffName,
    COUNT(Appointment.APP_ID) AS TotalAppointments
FROM
    Appointment
JOIN
    StaffMember ON Appointment.S_ID = StaffMember.S_ID
GROUP BY
    StaffMember.S_ID
ORDER BY
    TotalAppointments DESC
LIMIT 1;
```

### 2. Pets Treated by Each Staff Member
List of staff members and the pets they treated:
```sql
SELECT
    StaffMember.Sname AS StaffName,
    GROUP_CONCAT(DISTINCT Pet.Pname SEPARATOR ', ') AS PetsTreated
FROM
    Appointment
JOIN
    StaffMember ON Appointment.S_ID = StaffMember.S_ID
JOIN
    Pet ON Appointment.P_ID = Pet.P_ID
GROUP BY
    StaffMember.Sname;
```

### 3. Appointments Longer Than Average Duration
Find all appointments that lasted longer than the average duration:
```sql
SELECT
    Appointment.APP_ID,
    Pet.Pname AS PetName,
    StaffMember.Sname AS StaffName,
    Appointment.Date,
    Appointment.Time,
    Appointment.Duration
FROM
    Appointment
JOIN
    Pet ON Appointment.P_ID = Pet.P_ID
JOIN
    StaffMember ON Appointment.S_ID = StaffMember.S_ID
WHERE
    Appointment.Duration > (SELECT AVG(Duration) FROM Appointment);
```

## Contributors
- **Youmna Yasser**
- **Nourhan Hamdy**
- **Mariam Alaa**

## License
This project is licensed under the Apache License - see the LICENSE file for details.



