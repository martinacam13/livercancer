% Parametri per la connessione al database
dsn = 'MySQL_LiverCancer';  % Nome del DSN
username = 'root';          
password = 'Miky2003@';     

% Crea la connessione al database MySQL
conn = database(dsn, username, password);

% Verifica se la connessione è riuscita
if isopen(conn)
    disp('Connessione al database riuscita.');
    
    % Crea la query per creare la tabella 'Patients'
    queryPatients = [
        'CREATE TABLE Patients ( ' ...
        'PatientID INT PRIMARY KEY auto_increment, ' ...
        'FirstName VARCHAR(100) NOT NULL, ' ...
        'LastName VARCHAR(100) NOT NULL, ' ...
        'Age INT NOT NULL, ' ...
        'Gender ENUM(''M'', ''F'') NOT NULL, ' ...
        'FiscalCode VARCHAR(16) UNIQUE NOT NULL);'];

    % Esegui la query per la tabella 'Patients'
    exec(conn, queryPatients);
    disp('Tabella "Patients" creata.');

    % Crea la query per creare la tabella 'Diagnoses'
    queryDiagnoses = [
        'CREATE TABLE Diagnoses ( ' ...
        'DiagnosisID INT PRIMARY KEY AUTO_INCREMENT, ' ...
        'PatientID INT, ' ...
        'DiagnosisDate DATE NOT NULL, ' ...
        'DiagnosisType VARCHAR(100) NOT NULL, ' ...
        'TumorStage ENUM(''I'', ''II'', ''III'', ''IV'') NOT NULL, ' ...
        'FOREIGN KEY (PatientID) REFERENCES Patients(PatientID));'];

    % Esegui la query per la tabella 'Diagnoses'
    exec(conn, queryDiagnoses);
    disp('Tabella "Diagnoses" creata.');

    % Crea la query per creare la tabella 'Treatments'
    queryTreatments = [
        'CREATE TABLE Treatments ( ' ...
        'TreatmentID INT PRIMARY KEY AUTO_INCREMENT, ' ...
        'PatientID INT, ' ...
        'TreatmentType VARCHAR(100) NOT NULL, ' ...
        'StartDate DATE NOT NULL, ' ...
        'EndDate DATE, ' ...
        'TreatmentOutcome ENUM(''In corso'', ''Completato'', ''Fallito'', ''Sospeso'') NOT NULL, ' ...
        'FOREIGN KEY (PatientID) REFERENCES Patients(PatientID));'];

    % Esegui la query per la tabella 'Treatments'
    exec(conn, queryTreatments);
    disp('Tabella "Treatments" creata.');

    % Crea la query per creare la tabella 'Outcomes'
    queryOutcomes = [
        'CREATE TABLE Outcomes ( ' ...
        'OutcomeID INT PRIMARY KEY AUTO_INCREMENT, ' ...
        'PatientID INT, ' ...
        'FollowUpDate DATE NOT NULL, ' ...
        'Status ENUM(''Stable'', ''Progressed'', ''Remission'', ''Deceased''), ' ...
        'Notes TEXT, ' ...
        'FOREIGN KEY (PatientID) REFERENCES Patients(PatientID));'];

    % Esegui la query per la tabella 'Outcomes'
    exec(conn, queryOutcomes);
    disp('Tabella "Outcomes" creata.');
    
else
    disp('Connessione al database fallita.');
    disp(conn.Message);  % Mostra il messaggio di errore
end

% Chiudi la connessione
close(conn);

