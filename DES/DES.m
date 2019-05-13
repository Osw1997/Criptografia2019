% % Algoritmo DES
% Generaci�n de las sub-llaves
clc; clear all;
id = fopen('semilla.txt', 'r');
semilla = upper(fscanf(id, '%c'));
fclose(id);
semilla(semilla == ' ') = [];
% Tabla PC1
T_PC1 = [57 49 41 33 25 17 09 01; ...
         58 50 42 34 26 18 10 02; ...
         59 51 43 35 27 19 11 03; ...
         60 52 44 36 63 55 47 39; ...
         31 23 15 07 62 54 46 38; ...
         30 22 14 06 61 53 45 37; ...
         29 21 13 05 28 20 12 04];
% Tabla PC2
T_PC2 = [14 17 11 24 01 05 03 28; ...
         15 06 21 10 23 19 12 04; ...
         26 08 13 07 27 20 13 02; ...
         41 52 31 37 47 55 30 40; ...
         51 45 33 48 44 49 39 56; ...
         34 53 46 42 50 36 29 32];
% Tabla de rotaciones
T_ROT = [1 1 2 2 2 2 2 2 1 2 2 2 2 2 2 1];
% Se obtiene K+
k_mas = semilla(T_PC1(:,:))';
k_mas = k_mas(:)';
% Se divide a la mitad
C0 = k_mas(1:length(k_mas) / 2);
D0 = k_mas(length(k_mas) / 2 + 1:end);
% N�mero de subllaves
kn = 16;
% Matriz  de subllaves
K = zeros(kn, 48);
% Var. aux. para la concatenaci�n de Ci y Di
kaux = zeros(1, length(C0) + length(D0));
% Se crea matriz de Ci, i = 1,2,...,16
C = zeros(kn,length(C0));
% Se crea matriz de Di, i = 1,2,...,16
D = zeros(kn,length(D0));
% Se obtienen todas las Ci y Di
for n = 1:kn
%     Se inicializa las matrices
    if n == 1 
        C(1,:) = circshift(C0, T_ROT(n));
        D(1,:) = circshift(D0, T_ROT(n));
    else
        C(n,:) = circshift(C(n-1,:), T_ROT(n));
        D(n,:) = circshift(D(n-1,:), T_ROT(n));
    end
%     Se obtiene la llave respectiva
    kaux = [C(n,:) D(n,:)];
%     Se determina Ki
    K(n,:) = reshape(kaux(T_PC2(:,:))', [1, 48]);
end
% Casteo a CHAR
C = char(C);
D = char(D);
K = char(K);

% % Parte 2
% Tabla IP
T_IP = [58 50 42 34 26 18 10 02; ...
        60 52 44 36 28 20 12 04; ...
        62 54 46 38 30 22 14 06; ...
        64 56 48 40 32 24 16 08; ...
        57 49 41 33 25 17 09 01; ...
        59 51 43 35 27 19 11 03; ...
        61 53 45 37 29 21 13 05; ...
        63 55 47 39 31 23 15 07];
    
% Vector 'm'
m = ['1110 1101 1100 0101 0101 1010 0010 1110',...
     '0011 1000 1010 1110 1111 0100 0011 0111'];
m(m == ' ') = [];
% Utilizando la tabla IP, se obtiene el vector 'IP_m'
IP_m = m(reshape(T_IP', [], 64));
% Se obtiene L0 y R0
L0 = IP_m(1:32);
R0 = IP_m(33:end);
% % Se obtiene R1
% Li = R_(i-1)
% Ri = L_(i-1) O+ Feistel(R_(i-1), Ki)
% Se llama a la funci�n Feistel
index = 1;
L1 = R0;
% R1 = bitxor(L0, feistel(R0, K(index,:)));
i = 1;
kf = K(i,:);
Ri = R0;
vector_feistel = feistel(i, kf, Ri);
