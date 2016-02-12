/*
 * Independent tables
 */

CREATE TABLE Manufacturers(
  Manufacturer_ID SERIAL NOT NULL PRIMARY KEY,
  Name VARCHAR(32) NOT NULL
);

CREATE TABLE Staff(
  Staff_ID SERIAL NOT NULL PRIMARY KEY,
  Name VARCHAR(32) NOT NULL,
  Social_Insurance_Number VARCHAR(32)
);

CREATE TABLE Members(
  Member_ID SERIAL NOT NULL PRIMARY KEY,
  Name VARCHAR(32) NOT NULL,
  Address VARCHAR(32) NOT NULL,
  Registration_Date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/*
 * Dependant tables
 */

CREATE TABLE Branches(
  Branch_ID SERIAL NOT NULL PRIMARY KEY,
  Name VARCHAR(32) NOT NULL,
  Address VARCHAR(32) NOT NULL,
  Phone_Number VARCHAR(15),
  Manager_ID INT NOT NULL REFERENCES Staff(Staff_ID)
);

CREATE TABLE Scooters(
  Scooter_ID SERIAL NOT NULL PRIMARY KEY,
  Make_ID INT NOT NULL REFERENCES Manufacturers(Manufacturer_ID),
  Year DATE NOT NULL,
  Rental_Price MONEY NOT NULL,
  Main_Color VARCHAR(32) NOT NULL,
  Battery_Duration INT NOT NULL
);

CREATE TABLE Rentals(
  Rental_ID SERIAL NOT NULL PRIMARY KEY,
  Scooter_ID INT NOT NULL REFERENCES Scooters(Scooter_ID),
  Member_ID INT NOT NULL REFERENCES Members(Member_ID),
  Rental_Date DATE NOT NULL DEFAULT CURRENT_DATE,
  Rate MONEY NOT NULL DEFAULT (SELECT Rental_Price FROM Scooters s WHERE s.Scooter_ID = Rentals.Scooter_ID),
  Rented_Out TIMESTAMP NOT NULL,
  Returned TIMESTAMP NOT NULL,
  Duration INT NOT NULL,
  Avaliable BIT NOT NULL DEFAULT 0,
  CHECK(Duration BETWEEN 1 AND 48)
);

/*
 * Linking tables
 */

CREATE TABLE BranchStaff(
  Branch_ID INT NOT NULL REFERENCES Branches(Branch_ID),
  Staff_ID INT NOT NULL REFERENCES Staff(Staff_ID),
  PRIMARY KEY (Branch_ID, Staff_ID)
);

CREATE TABLE BranchMembers(
  Branch_ID INT NOT NULL REFERENCES Branches(Branch_ID),
  Member_ID INT NOT NULL REFERENCES Members(Member_ID),
  PRIMARY KEY (Branch_ID, Member_ID)
);

CREATE TABLE Catalog(
  Branch_ID INT NOT NULL REFERENCES Branches(Branch_ID),
  Scooter_ID INT NOT NULL REFERENCES Scooters(Scooter_ID)
);