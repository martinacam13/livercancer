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
    disp('Nome:');
    disp(data_patients.FirstName);

    disp('Cognome:');
    disp(data_patients.LastName);

    disp('Età:');
    disp(data_patients.Age);

    disp('Genere:');
    disp(data_patients.Gender);

    disp('Codice fiscale:');
    disp(data_patients.FiscalCode);


    % Preleva i dati dalla tabella diagnoses
    data_diagnoses = fetch(conn, query_diagnoses);
    disp('Dati diagnosi:');
    disp(data_diagnoses);

    % Preleva i dati dalla tabella treatments
    data_treatments = fetch(conn, query_treatments);
    disp('Dati trattamenti:');
    disp(data_treatments);

    % Preleva i dati dalla tabella outcomes
    data_outcomes = fetch(conn, query_outcomes);
    disp('Dati esiti:');
    disp(data_outcomes);
catch ME
    disp('Errore durante l''esecuzione delle query:');
    disp(ME.message);  % Mostra il messaggio di errore
end

