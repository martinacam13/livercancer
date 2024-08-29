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

insert = true;
while insert
    try
        patient_ID = input('Inserire ID: ', 's');
        patientFirstName = input('Inserire nome: ', 's');
        patientLastName = input('Inserire cognome: ', 's');
        patientAge = input('Inserire età: ');
        patientGender = input('Inserire genere (M/F): ', 's');
        patientFiscalCode = input('Inserire codice fiscale: ', 's');

        % Creazione della query SQL
        sqlquery = sprintf("INSERT INTO Patients (FirstName, LastName, Age, Gender, FiscalCode) VALUES ('%s', '%s', '%s', '%s', '%s')", patientFirstName, patientLastName, patientAge, patientGender, patientFiscalCode);
        
         % Stampa la query generata per il debug
        disp('Query SQL generata:');
        disp(sqlquery);
        
        % Esecuzione della query
        try
            exec(conn, sqlquery);
            commit(conn);  % Applica le modifiche al database
            disp('Dati inseriti con successo!');
        catch ME
            disp("Errore durante l'inserimento dei dati!");
            disp(ME.message);  % Stampa il messaggio di errore dettagliato
        end
        
        % Chiedi all'utente se vuole inserire un altro record
        another = input('Vuoi inserire un altro record? (s/n): ', 's');
        if lower(another) ~= 's'
            insert = false;
        end
    catch ME
        disp("Errore durante l'inserimento. Riprova.");
        disp(ME.message);  % Stampa il messaggio di errore dettagliato
    end
end


numEntries = 50;  % Numero di record da inserire in ciascuna tabella

fillDiagnoses(conn, numEntries);
fillTreatments(conn, numEntries);
fillOutcomes(conn, numEntries);

close(conn);
disp('Connessione al database chiusa.');


% Riempio randomicamente le altre tabelle
function fillDiagnoses(conn, numEntries)
    % Funzione per inserire dati casuali nella tabella Diagnoses
    diagnosisTypes = {'Carcinoma', 'Linfoma', 'Sarcoma', 'Melanoma'};
    tumorStages = {'I', 'II', 'III', 'IV'};

    for i = 1:numEntries
        % Generare un PatientID casuale
        patientID = randi([1 100]); % Assumendo che i PatientID vadano da 1 a 100
        
        % Generare una data di diagnosi casuale
        diagnosisDate = datestr(datetime('today') - randi([1 365]), 'yyyy-mm-dd');
        
        % Tipo di diagnosi casuale
        diagnosisType = diagnosisTypes{randi(numel(diagnosisTypes))};
        
        % Stadio del tumore casuale
        tumorStage = tumorStages{randi(numel(tumorStages))};
        
        % Inserire i dati
        data = {patientID, diagnosisDate, diagnosisType, tumorStage};
        sqlquery = sprintf("INSERT INTO Diagnoses (PatientID, DiagnosisDate, DiagnosisType, TumorStage) VALUES (%d, '%s', '%s', '%s')", patientID, diagnosisDate, diagnosisType, tumorStage);  
        exec(conn, sqlquery, data);
    end
    disp('dati inseriti nella tabella Diagnoses');
end

function fillTreatments(conn, numEntries)
    % Dati di esempio
    treatmentTypes = {'Chemioterapia', 'Radioterapia', 'Chirurgia', 'Immunoterapia'};
    treatmentOutcomes = {'In corso', 'Completato', 'Fallito', 'Sospeso'};
    
    for i = 1:numEntries
        % Generazione di dati casuali
        patientID = randi([1 100]);
        startDate = datestr(datetime('today') - randi([30 180]), 'yyyy-mm-dd');
        endDate = datestr(datetime('today') - randi([1 29]), 'yyyy-mm-dd');
        treatmentType = treatmentTypes{randi(length(treatmentTypes))};
        treatmentOutcome = treatmentOutcomes{randi(length(treatmentOutcomes))};
        
        % Creazione della query SQL
        sqlquery = sprintf("INSERT INTO Treatments (PatientID, TreatmentType, StartDate, EndDate, TreatmentOutcome) VALUES (%d, '%s', '%s', '%s', '%s')", ...
                            patientID, treatmentType, startDate, endDate, treatmentOutcome);
        
        % Esecuzione della query
        exec(conn, sqlquery);
    end
    
    disp('Dati inseriti nella tabella Treatments');
end

function fillOutcomes(conn, numEntries)
    % Dati di esempio
    statusTypes = {'Stable', 'Progressed', 'Remission', 'Deceased'};
    
    for i = 1:numEntries
        % Generazione di dati casuali
        patientID = randi([1 100]);
        followUpDate = datestr(datetime('today') - randi([1 180]), 'yyyy-mm-dd');
        status = statusTypes{randi(length(statusTypes))};
        notes = 'Follow-up periodico';
        
        % Creazione della query SQL
        sqlquery = sprintf("INSERT INTO Outcomes (PatientID, FollowUpDate, Status, Notes) VALUES (%d, '%s', '%s', '%s')", ...
                            patientID, followUpDate, status, notes);
        
        % Esecuzione della query
        exec(conn, sqlquery);
    end
    
    disp('Dati inseriti nella tabella Outcomes');
end
