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

% % Esempio di chiamata della funzione
% plotTreatmentOutcomeDistribution(conn);
% 
% function plotTreatmentOutcomeDistribution(conn)
%     % Esegui una query per ottenere gli esiti dei trattamenti
%     data = fetch(conn, 'SELECT TreatmentOutcome FROM Treatments');
% 
%     if isempty(data)
%         disp('Nessun dato trovato.');
%         return;
%     end
% 
%     % Conta il numero di trattamenti per ciascun esito
%     outcomeCategories = categorical(data.TreatmentOutcome);
%     [outcomeCounts, outcomeLabels] = histcounts(outcomeCategories, 'Categories', categories(outcomeCategories));
% 
%     % Crea un grafico a barre della distribuzione degli esiti
%     figure;
%     bar(outcomeCounts);
%     set(gca, 'XTickLabel', outcomeLabels);
%     title('Distribuzione degli Esiti dei Trattamenti');
%     xlabel('Esito del Trattamento');
%     ylabel('Numero di Trattamenti');
%     grid on;
% end



% Esegui la funzione per creare il grafico DITRIBUZIONE ETà
% plotAgeDistributionWithPlot(conn);
% 
% function plotAgeDistributionWithPlot(conn)
%     % Query per estrarre le età dei pazienti
%     query = 'SELECT Age FROM Patients';
% 
%     % Esecuzione della query
%     data = fetch(conn, query);
% 
%     % Controlla se ci sono risultati
%     if isempty(data)
%         disp('Nessun dato trovato nella tabella Patients.');
%         return;
%     end
% 
%     % Visualizza i dati estratti per il debug
%     disp('Dati estratti dalla tabella Patients:');
%     disp(data.Age);
% 
%     % Estrai le età dalla tabella
%     ages = data.Age;
% 
%     % % Controlla il tipo dei dati
%     % disp('Tipo di dati estratti:');
%     % disp(class(ages));
%     % 
%     % % Converti le età in numerico se necessario (anche se dovrebbero essere già numerici)
%     % if iscell(ages)
%     %     ages = str2double(ages);
%     % end
%     % 
%     % % Visualizza le età convertite
%     % disp('Età convertite:');
%     % disp(ages);
%     % 
%     % Rimuove eventuali NaN risultanti dalla conversione
%     ages = ages(~isnan(ages));
% 
%     % Verifica se ci sono dati validi
%     if isempty(ages)
%         disp('Nessun dato valido per l''età.');
%         return;
%     end
% 
%     % Determina il range delle età
%     minAge = min(ages);
%     maxAge = max(ages);
% 
%     % Crea un vettore per tutte le età nel range
%     ageRange = minAge:maxAge;
% 
%     % Conta il numero di pazienti per ogni età
%     patientCount = zeros(size(ageRange));
%     for i = 1:length(ageRange)
%         patientCount(i) = sum(ages == ageRange(i));
%     end
% 
%    % Crea un grafico a linee con stili diversi
%     % Crea un grafico a torta
%     % Crea un grafico a linee con etichette e legenda
%     % Crea il grafico a dispersione
%     figure;
%     scatter(ageRange, patientCount, 'filled');
%     xlabel('Età');
%     ylabel('Numero di Pazienti');
%     title('Distribuzione dell''età dei pazienti');
%     grid on;
% end

%%GRAFICO PERFETTO DA INSERIRE NEL PROGRAMMA

plotCancerTypeDistribution(conn)

function plotCancerTypeDistribution(conn)
    % Query per estrarre i tipi di diagnosi
    query = 'SELECT DiagnosisType FROM Diagnoses';
    
    % Esecuzione della query
    data = fetch(conn, query);
    
    % Controlla se ci sono risultati
    if isempty(data)
        disp('Nessun dato trovato nella tabella Diagnoses.');
        return;
    end
    
    % Estrai i tipi di diagnosi dalla tabella
    diagnosisTypes = data.DiagnosisType;
    
    % Verifica il tipo dei dati
    disp('Tipo di dati estratti:');
    disp(class(diagnosisTypes));
    
    % Conta il numero di diagnosi per ciascun tipo
    if iscell(diagnosisTypes)
        diagnosisCategories = categorical(diagnosisTypes);
    else
        disp('I dati non sono in formato cella, quindi potrebbe essere necessario convertirli.');
        diagnosisCategories = categorical(cellstr(num2str(diagnosisTypes)));
    end
    
    % Conta il numero di diagnosi per ciascun tipo
    [typeCounts, typeLabels] = histcounts(diagnosisCategories, 'Categories', categories(diagnosisCategories));
    
    % Crea il grafico a barre
    figure;
    hBar = bar(typeCounts);
    
    % Definisci una mappa di colori
    numBars = length(typeCounts);
    colors = lines(numBars); % Usa la mappa di colori predefinita "lines" per generare colori
    % colors = [1 0 0; 0 1 0; 0 0 1; 1 1 0; ... ]; % Definisci manualmente se preferisci
    
    % Assegna i colori alle barre
    for i = 1:numBars
        hBar.FaceColor = 'flat';
        hBar.CData(i, :) = colors(i, :);
    end
    
    set(gca, 'XTickLabel', typeLabels);
    xlabel('Tipo di Cancro al Fegato');
    ylabel('Numero di Diagnosi');
    title('Distribuzione dei Tipi di Cancro al Fegato');
    grid on;
end

