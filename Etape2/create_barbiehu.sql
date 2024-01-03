CREATE TABLE PORT (
    PortId CHAR(1) PRIMARY KEY CHECK(PortId IN ('C','Q','S')),
    PortName VARCHAR NOT NULL,
    Country VARCHAR NOT NULL
);

CREATE TABLE PASSENGER (
    PassengerId INT PRIMARY KEY,
    Name VARCHAR NOT NULL,
    Sex VARCHAR NOT NULL,
    Age INT,
    Survived INT NOT NULL CHECK(Survived IN (1,0)),
    PClass INT NOT NULL CHECK(PClass IN (1,2,3)),
    PortId CHAR(1) REFERENCES PORT(PortId)
);

CREATE TABLE OCCUPATION (
    PassengerId INT REFERENCES Passenger(PassengerId),
    CabineCode VARCHAR,
    CONSTRAINT PK_Occupation PRIMARY KEY (PassengerId, CabineCode)
);

CREATE TABLE SERVICE(
    PassengerId_Dom INT REFERENCES Passenger(PassengerId) PRIMARY KEY,
    PassengerId_Emp INT REFERENCES Passenger(PassengerId) NOT NULL,
    Role VARCHAR NOT NULL
);

CREATE TABLE CATEGORY(
    LifeBoatCat VARCHAR PRIMARY KEY CHECK(LifeBoatCat IN ('standard', 'secours', 'radeau')),
    Structure VARCHAR NOT NULL CHECK(Structure IN ('bois', 'bois et toile')),
    Places INT NOT NULL
);

CREATE TABLE LIFEBOAT(
    LifeBoatId VARCHAR PRIMARY KEY,
    LifeBoatCat VARCHAR REFERENCES CATEGORY(LifeBoatCat) NOT NULL,
    Side VARCHAR NOT NULL CHECK(Side IN('tribord','babord')),
    Position VARCHAR NOT NULL CHECK(Position IN('avant','arriere')),
    Location VARCHAR DEFAULT('pont'),
    Launching_Time TIME NOT NULL
);

CREATE TABLE RECOVERY(
    LifeBoatId VARCHAR REFERENCES LIFEBOAT(LifeBoatId) PRIMARY KEY,
    Recovery_Time TIME NOT NULL
);  

CREATE TABLE RESCUE(
    PassengerId INT REFERENCES Passenger(PassengerId) PRIMARY KEY,
    LifeBoatId VARCHAR REFERENCES LIFEBOAT(LifeBoatId) NOT NULL
);