function f1 = f1_score(true_labels, predicted_labels)

confusion_matrix = confusionmat(true_labels, predicted_labels);

% Extração dos valores da matriz de confusão
tp = confusion_matrix(2, 2); % Verdadeiros positivos
fp = confusion_matrix(1, 2); % Falsos positivos
fn = confusion_matrix(2, 1); % Falsos negativos

% Cálculo de precisão, recall e F1-score
precision = tp / (tp + fp);
recall = tp / (tp + fn);
f1 = 2 * (precision * recall) / (precision + recall);


end