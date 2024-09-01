% Grafico 1: Distribuzione dei Pazienti per Età
data = fetch(conn, 'SELECT Age, COUNT(*) as Count FROM Patients GROUP BY Age');
ages = cell2mat(data.Age);
counts = cell2mat(data.Count);
figure;
plot(ages, counts, '-o', 'LineWidth', 2);
title('Distribuzione dei Pazienti per Età');
xlabel('Età');
ylabel('Numero di Pazienti');
grid on;

% Grafico 2: Distribuzione dei Tumori per Tipo
data = fetch(conn, 'SELECT DiagnosisType, COUNT(*) as Count FROM Diagnoses GROUP BY DiagnosisType');
diagnosisTypes = data.DiagnosisType;
counts = cell2mat(data.Count);
x = 1:length(diagnosisTypes);
figure;
plot(x, counts, '-o', 'LineWidth', 2);
set(gca, 'XTick', x, 'XTickLabel', diagnosisTypes);
title('Distribuzione dei Tumori per Tipo');
xlabel('Tipo di Diagnosi');
ylabel('Numero di Pazienti');
grid on;

% Grafico 3: Distribuzione dei Trattamenti per Tipo
data = fetch(conn, 'SELECT TreatmentType, COUNT(*) as Count FROM Treatments GROUP BY TreatmentType');
treatmentTypes = data.TreatmentType;
counts = cell2mat(data.Count);
x = 1:length(treatmentTypes);
figure;
plot(x, counts, '-o', 'LineWidth', 2);
set(gca, 'XTick', x, 'XTickLabel', treatmentTypes);
title('Distribuzione dei Trattamenti per Tipo');
xlabel('Tipo di Trattamento');
ylabel('Numero di Pazienti');
grid on;

% Grafico 4: Progressione di un Paziente
patientID = 1;
query = sprintf('SELECT FollowUpDate, Status FROM Outcomes WHERE PatientID = %d ORDER BY FollowUpDate', patientID);
data = fetch(conn, query);
dates = datetime(data.FollowUpDate, 'InputFormat', 'yyyy-MM-dd');
statuses = categorical(data.Status);
statusValues = double(statuses);
figure;
plot(dates, statusValues, '-o', 'LineWidth', 2);
set(gca, 'YTick', unique(statusValues), 'YTickLabel', categories(statuses));
title(sprintf('Progressione del Paziente %d', patientID));
xlabel('Data di Follow-up');
ylabel('Stato');
grid on;