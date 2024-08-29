% Specifica il nome del DSN che hai configurato
dsn = 'MySQL_LiverCancer';  % Nome del DSN che hai creato
username = 'root';          % Il tuo nome utente MySQL
password = 'Miky2003@';     % La tua password MySQL

% Crea una connessione al database tramite ODBC gggg
conn = database(dsn, username, password);

% Verifica se la connessione è riuscita ciao
if isopen(conn)
    disp('Connessione al database riuscita!');
else
    disp('Connessione al database fallita.');
    disp(conn.Message);  % Mostra il messaggio di errore
end

insert = false;
while insert
    try
        patient_ID = input('Inserire ID: ', 's');
        patientFirstName = input('Inserire nome: ', 's');
        patientLastName = input('Inserire cognome: ', 's');
        patientAge = input('Inserire età: ');
        patientGender = input('Inserire genere (M/F): ', 's');
        patientFiscalCode = input('Inserire codice fiscale: ', 's');

        % Creazione della query SQL
        sqlquery = sprintf("INSERT INTO Patients (FirstName, LastName, Age, Gender, FiscalCode) VALUES ('%s', '%s', '%s', '%s', '%s')", firstName, lastName, age, gender, fiscalCode);
        
        % Esecuzione della query
        try
            exec(conn, sqlquery);
            disp('Dati inseriti con successo!');
        catch
            disp("Errore durante l'inserimento dei dati!");
        end
    end
end

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
        sqlquery = ['INSERT INTO Diagnoses (PatientID, DiagnosisDate, DiagnosisType, TumorStage)''VALUES (?, ?, ?, ?)'];
        exec(conn, sqlquery, data);
    end
end

        