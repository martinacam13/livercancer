% Imposta la connessione al database
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
    return;
end

% Definisci i nomi e i cognomi per i pazienti (puoi personalizzarli)
firstNames = {'Luca', 'Giulia', 'Marco', 'Anna', 'Francesco', 'Laura', 'Alessandro', 'Sara', 'Matteo', 'Chiara'};
lastNames = {'Rossi', 'Bianchi', 'Verdi', 'Russo', 'Ferrari', 'Esposito', 'Colombo', 'Romano', 'Ricci', 'Marino'};

% Array per tenere traccia dei codici fiscali già generati
existingFiscalCodes = {};

% Ciclo per generare e inserire i primi 50 pazienti
for i = 1:50
    % Seleziona un nome e un cognome casualmente
    firstName = firstNames{randi(numel(firstNames))};
    lastName = lastNames{randi(numel(lastNames))};
    
    % Genera un'età casuale tra 18 e 90 anni
    age = randi([18, 90]);
    
    % Seleziona un genere casualmente
    genderOptions = {'M', 'F'};
    gender = genderOptions{randi(2)};
    
    % Genera un codice fiscale unico
    fiscalCode = generateUniqueFiscalCode(existingFiscalCodes);
    
    % Aggiungi il codice fiscale all'array dei codici già esistenti
    existingFiscalCodes{end+1} = fiscalCode;
    
    % Crea la query SQL per inserire il paziente nel database, specificando il PatientID
    sqlquery = sprintf("INSERT INTO Patients (PatientID, FirstName, LastName, Age, Gender, FiscalCode) VALUES (%d, '%s', '%s', %d, '%s', '%s')", i, firstName, lastName, age, gender, fiscalCode);
    
    % Esegui la query
    exec(conn, sqlquery);
end

% Chiude la connessione al database
close(conn);
disp('Inserimento dei pazienti completato.');

function code = generateUniqueFiscalCode(existingCodes)
    % Caratteri possibili per il codice fiscale
    characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    numChars = length(characters);
    
    % Variabile per verificare se il codice fiscale è unico
    isUnique = false;
    
    % Continua a generare un codice fiscale finché non è unico
    while ~isUnique
        % Genera un codice fiscale casuale di 16 caratteri
        code = characters(randi(numChars, 1, 16));
        
        % Verifica se il codice fiscale è unico
        if ~ismember(code, existingCodes)
            isUnique = true;
        end
    end
end



