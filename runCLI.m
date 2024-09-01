% Funzione principale per la CLI
menu();

function menu()
    % Messaggio di benvenuto
    disp('Archivio');
    
    % Menu delle opzioni
    while true
        disp("Seleziona un'opzione: ");
        disp("1. Inserisci un paziente")
        disp('2. Visualizza info paziente');
        disp('99. Esci');
        
        % Richiedi l'opzione all'utente
        option = input('Inserisci il numero dell''opzione scelta: ', 's');
        
        % Verifica l'opzione e esegui il codice corrispondente
        switch option
            case '1'
                % Inserisci pazienete
                run("AddPatient.m");
                
            case '2'
                % Visualizza info paziente
                disp("info paziente");
                
            case '99'
                % Esci dal programma
                disp('Uscita dal programma.');
                break;
                
            otherwise
                % Opzione non valida
                disp('Opzione non valida. Per favore, seleziona un numero tra 1 e 5.');
        end
    end
end