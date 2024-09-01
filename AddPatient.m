% Aggiunge un utente, e genera automaticamente una diagnosi, un
% trattamento e un outcome.



% Specifica il nome del DSN che hai configurato
dsn = 'MySQL_LiverCancer';  % Nome del DSN che hai creato
username = 'root';          % Il tuo nome utente MySQL
password = 'Miky2003@';     % La tua password MySQL

% Crea una connessione al database tramite ODBC
conn = database(dsn, username, password);

% Verifica se la connessione è riuscita 
if isopen(conn)
    disp('Connessione al database riuscita.');
else
    disp('Connessione al database fallita.');
    disp(conn.Message);  % Mostra il messaggio di errore
end

patient_ID = input('Inserire ID: ', 's');
patientFirstName = input('Inserire nome: ', 's');
patientLastName = input('Inserire cognome: ', 's');
patientAge = input('Inserire età: ', 's');
patientGender = input('Inserire genere (M/F): ', 's');
patientFiscalCode = input('Inserire codice fiscale: ', 's');

% Creazione della query SQL
sqlquery = sprintf("INSERT INTO Patients (PatientID, FirstName, LastName, Age, Gender, FiscalCode) VALUES ('%s', '%s', '%s', '%s', '%s', '%s')", patient_ID, patientFirstName, patientLastName, patientAge, patientGender, patientFiscalCode);

% Esegui la query e ottieni i risultati
fetch(conn, sqlquery);

fillDiagnoses(conn, patient_ID);
fillTreatments(conn, patient_ID);
fillOutcomes(conn, patient_ID);

function fillDiagnoses(conn, patient_ID)
    % Funzione per inserire dati casuali nella tabella Diagnoses
    diagnosisTypes = {'Carcinoma', 'Linfoma', 'Sarcoma', 'Melanoma'};
    tumorStages = {'I', 'II', 'III', 'IV'};

    % Generare un PatientID casuale
    D_patientID = patient_ID;
    
    % Generare una data di diagnosi casuale
    diagnosisDate = datestr(datetime('today') - randi([1 365]), 'yyyy-mm-dd');
    
    % Tipo di diagnosi casuale
    diagnosisType = diagnosisTypes{randi(numel(diagnosisTypes))};
    
    % Stadio del tumore casuale
    tumorStage = tumorStages{randi(numel(tumorStages))};
    
    % Inserire i dati
    sqlquery3 = sprintf("INSERT INTO Diagnoses (D_PatientID, DiagnosisDate, DiagnosisType, TumorStage) VALUES ('%s', '%s', '%s', '%s')", D_patientID, diagnosisDate, diagnosisType, tumorStage);  
    fetch(conn, sqlquery3);
    disp('dati inseriti nella tabella Diagnoses');
end

function fillTreatments(conn, patient_ID)
    treatmentTypes = {'Chemioterapia', 'Radioterapia', 'Chirurgia', 'Immunoterapia'};
    treatmentOutcomes = {'In corso', 'Completato', 'Fallito', 'Sospeso'};
    
    T_PatientID = patient_ID;
    startDate = datestr(datetime('today') - randi([30 180]), 'yyyy-mm-dd');
    endDate = datestr(datetime('today') - randi([1 29]), 'yyyy-mm-dd');
    
    % Seleziona Chirurgia per stadi I o II come esempio fittizio
    if rand > 0.5
        treatmentType = 'Chirurgia';
    else
        treatmentType = treatmentTypes{randi(length(treatmentTypes))};
    end
    
    treatmentOutcome = treatmentOutcomes{randi(length(treatmentOutcomes))};
    
    sqlquery4 = sprintf("INSERT INTO Treatments (T_PatientID, TreatmentType, StartDate, EndDate, TreatmentOutcome) VALUES ('%s', '%s', '%s', '%s', '%s')", T_PatientID, treatmentType, startDate, endDate, treatmentOutcome);
    exec(conn, sqlquery4);
    
    disp('Dati inseriti nella tabella Treatments');
   
end


function fillOutcomes(conn, patient_ID)
    % Dati di esempio
    statusTypes = {'Stable', 'Progressed', 'Remission', 'Deceased'};
    
    % Generazione di dati casuali
    O_PatientID = patient_ID;
    followUpDate = datestr(datetime('today') - randi([1 180]), 'yyyy-mm-dd');
    status = statusTypes{randi(length(statusTypes))};
    notes = 'Follow-up periodico';
    
    % Creazione della query SQL
    sqlquery5 = sprintf("INSERT INTO Outcomes (O_PatientID, FollowUpDate, Status, Notes) VALUES ('%s', '%s', '%s', '%s')", O_PatientID, followUpDate, status, notes);
    
    % Esecuzione della query
    exec(conn, sqlquery5);

    disp('Dati inseriti nella tabella Outcomes');
end



