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


% Scrivi la query SQL per ottenere l'età dei pazienti
sqlquery = "Select Age from patients";

% Esegui la query e ottieni i risultati
results = fetch(conn, sqlquery);

% Verifica se ci sono risultati
if isempty(results)
    disp('Nessun risultato trovato.');
else
    disp(results.Age);
end