% % Algoritmo DES
clc; clear all;
% % Generación de las sub-llaves
id = fopen('semilla.txt', 'r');
semilla = upper(fscanf(id, '%c'));
fclose(id);
semilla(semilla == ' ') = [];
% % Tabla PC1
T_PC1 = [57 49 41 33 25 17 09 01 ...
         58 50 42 34 26 18 10 02 ...
         59 51 43 35 27 19 11 03 ...
         60 52 44 36 63 55 47 39 ...
         31 23 15 07 62 54 46 38 ...
         30 22 14 06 61 53 45 37 ...
         29 21 13 05 28 20 12 04];
% Tabla PC2
T_PC2 = [14 17 11 24 01 05 03 28 ...
         15 06 21 10 23 19 12 04 ...
         26 08 16 07 27 20 13 02 ...
         41 52 31 37 47 55 30 40 ...
         51 45 33 48 44 49 39 56 ...
         34 53 46 42 50 36 29 32];

% Tabla de permutación final (PF)
PF = [40 08 48 16 56 24 64 32 ...
      39 07 47 15 55 23 63 31 ...
      38 06 46 14 54 22 62 30 ...
      37 05 45 13 53 21 61 29 ...
      36 04 44 12 52 20 60 28 ...
      35 03 43 11 51 19 59 27 ...
      34 02 42 10 50 18 58 26 ...
      33 01 41 09 49 17 57 25];
% Tabla de rotaciones
T_ROT = [1 1 2 2 2 2 2 2 1 2 2 2 2 2 2 1];
% Se obtiene K+
% k_mas = semilla(T_PC1(:,:))';
k_mas = semilla(T_PC1);
% k_mas = k_mas(:)';
% Se divide a la mitad  
C0 = k_mas(1:length(k_mas) / 2);
D0 = k_mas(length(k_mas) / 2 + 1:end);
% Número de subllaves
kn = 16;
% Matriz  de subllaves
K = zeros(kn, 48);
% Var. aux. para la concatenación de Ci y Di
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
%     K(n,:) = reshape(kaux(T_PC2(:,:))', [1, 48]);
    K(n,:) = kaux(T_PC2);
end
% Casteo a CHAR
C = char(C);
D = char(D);
K = char(K);

% % Parte 2
% % Mensaje a (de)codificar
% Texto plano
% id = fopen('txtplano.txt', 'r');
id = fopen('txtcod.txt', 'r');
texto_plano = fscanf(id, '%c');
fclose(id);
msje = texto_plano;
% % % A binario
% % % msje = dec2bin(texto_plano, 8);
% % % [fila, columna] = size(msje);
% % % msje = reshape(msje', [], fila * columna);
% Se concatena un relleno de ceros para que existan bloques de 64 completos
if (mod(length(msje),64) ~= 0)
    msje = [msje repmat('0', 1, 64 - mod(length(msje),64))];
end
% Tabla IP
T_IP = [58 50 42 34 26 18 10 02; ...
        60 52 44 36 28 20 12 04; ...
        62 54 46 38 30 22 14 06; ...
        64 56 48 40 32 24 16 08; ...
        57 49 41 33 25 17 09 01; ...
        59 51 43 35 27 19 11 03; ...
        61 53 45 37 29 21 13 05; ...
        63 55 47 39 31 23 15 07];
    
% % Vector 'm'
% msj = ['1110 1101 1100 0101 0101 1010 0010 1110',...
%      '0011 1000 1010 1110 1111 0100 0011 0111'];
% msj = '0111000100000101100100010110001101110001001101011101101000110110'

% % msje = '01111100011110110100111111111010100101010100000111101111111111110001011100101001011111001100111001000001011110110100010111010001010100000010101001100000011101101101010010001101111001111001100110001110010110101000110001011001101111110010111011011111100111110010111110101011001001111100011110110100100010011100110110001110010010000111111001010001001010110000011011111001000010011111000101000001000101100000011101110010010000001011011010000101000001111011011010111101000111101000110010001101111011011100011101001011011010001010110110001010110100001010110001011000000010001100100101101001100110110011100101100011111001101100010101110001101011110111000110100111101100101110011110000010110111000111011110011011';
% Longitud del mensaje a (de)codificar
long_msje = length(msje);
% Vector que guarda el resultado final
resultado_final = zeros(1, long_msje);
% Bloque de 64 bits
msj = zeros(1, 64);
% Barrido del mensaje en bloques de 64
for n = 1:64:long_msje
    msj(1:end) = msje(n : n + 63);
    msj = char(msj);
    % msj(msj == ' ') = [];
    % Utilizando la tabla IP, se obtiene el vector 'IP_m'
    IP_msj = msj(reshape(T_IP', [], 64));
    % Se obtiene L0 y R0
    L0 = IP_msj(1:32);
    R0 = IP_msj(33:end);
%     Se inicializa el proceso
    Ri = R0;
    Li = L0;
    for m = 16:-1:1
%     for m = 1:16
        kf = K(m,:);
        vector_feistel = feistel(m, kf, Ri);
        xor_feistel = bitxor(str2num(Li'), str2num(vector_feistel'));
        xor_feistel = num2str(xor_feistel');
        xor_feistel(xor_feistel == ' ') = [];
        Li = Ri;
        Ri = xor_feistel;
    end 
    concat_final = [Ri Li];
    resultado_des = concat_final(PF);
    resultado_final(n : n + 63) = resultado_des;
end
resultado_final = char(resultado_final);
% resultado_final
ascii_final = reshape(resultado_final, [8, long_msje / 8])';
char(bin2dec(ascii_final))'