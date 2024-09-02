%Visualizza info paziente
% DA MODIFICARE CON SPRINTF

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

patient_ID = input('Inserire PatientID: ', 's');

query_patients = sprintf('SELECT * FROM patients WHERE PatientID = %s', patient_ID);
query_diagnoses = sprintf('SELECT * FROM diagnoses WHERE D_PatientID = %s', patient_ID);
query_treatments = sprintf('SELECT * FROM treatments WHERE T_PatientID = %s', patient_ID);
query_outcomes = sprintf('SELECT * FROM outcomes WHERE O_PatientID = %s', patient_ID);

try
    % Preleva i dati dalla tabella patients
    data_patients = fetch(conn, query_patients);
    % Combina i dati in una singola stringa
    patient_info = sprintf('Nome: %s, Cognome: %s, Età: %d, Genere: %s, Codice fiscale: %s', data_patients.FirstName{1}, data_patients.LastName{1}, data_patients.Age(1), data_patients.Gender{1}, data_patients.FiscalCode{1});
    
    % Stampa la stringa combinata
    disp(patient_info);


    % Preleva i dati dalla tabella diagnoses
    data_diagnoses = fetch(conn, query_diagnoses);
    diagnose_info = sprintf('Data e tipo di diagnosi: %s, %s, %s stadio', data_diagnoses.DiagnosisDate{1}, data_diagnoses.DiagnosisType{1}, data_diagnoses.TumorStage{1});

    % Stampa la stringa combinata
    disp(diagnose_info);

    % Preleva i dati dalla tabella treatments
    data_treatments = fetch(conn, query_treatments);
    treatment_info = sprintf('Tipo di trattamento: %s, Duarata: %s - %s, Esito: %s', data_treatments.TreatmentType{1}, data_treatments.StartDate{1}, data_treatments.EndDate{1}, data_treatments.TreatmentOutcome{1});
    
    % Stampa la stringa combinata
    disp(treatment_info);

    % Preleva i dati dalla tabella outcomes
    data_outcomes = fetch(conn, query_outcomes);
    outcome_info = sprintf('Stato paziente: %s', data_outcomes.Status{1});

    % Stampa la stringa combinata
    disp(outcome_info);
catch ME
    disp('Errore durante l''esecuzione delle query:');
    disp(ME.message);  % Mostra il messaggio di errore
end

