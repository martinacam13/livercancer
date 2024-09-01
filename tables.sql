CREATE TABLE Patients (
	PatientID INT PRIMARY KEY auto_increment,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender ENUM('M', 'F') NOT NULL,
    FiscalCode VARCHAR(16) UNIQUE NOT NULL
);

CREATE TABLE Diagnoses (
	DiagnosisID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DiagnosisDate DATE NOT NULL,
    DiagnosisType VARCHAR(100) NOT NULL,
    TumorStage ENUM('I', 'II', 'III', 'IV') NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Treatments (
	TreatmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    TreatmentType VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    TreatmentOutcome ENUM( 'In corso', 'Completato', 'Fallito', 'Sospeso') NOT NULL,
    FOREIGN KEY (PatientId) REFERENCES Patients(PatientID)
);

CREATE TABLE Outcomes (
	OutcomeID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    FollowUpDate DATE NOT NULL,
    Status ENUM('Stable', 'Progressed', 'Remission', 'Deceased'),
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);
    
	