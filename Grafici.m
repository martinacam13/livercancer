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

graficoTortaEsitiDettagliato(conn);
function graficoTortaEsitiDettagliato(conn)
    % Query per ottenere la distribuzione degli esiti dei trattamenti
    query = 'SELECT TreatmentOutcome, COUNT(*) AS NumTrattamenti FROM Treatments GROUP BY TreatmentOutcome';
    data = fetch(conn, query);

    if isempty(data)
        disp('Nessun dato trovato.');
        return;
    end

    % Estrai i dati per il grafico a torta
    esiti = data.TreatmentOutcome;
    conteggio = data.NumTrattamenti;

    % Crea il grafico a torta con percentuali
    figure;
    p = pie(conteggio);

    % Aggiungi etichette con i nomi degli esiti e le percentuali
    labels = strcat(esiti, ': ', num2str(round((conteggio/sum(conteggio))*100)), '%');
    legend(labels, 'Location', 'bestoutside');
    
    % Imposta il titolo del grafico
    title('Distribuzione degli esiti dei trattamenti');
end

