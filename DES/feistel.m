function [feistel_func] = feistel(i_f, kf_f, Ri_f)
S1 = [14 04 13 01 02 15 11 08 03 10 06 12 05 09 00 07; ...
      00 15 07 04 14 02 13 01 10 06 12 11 09 05 03 08; ...
      04 01 14 08 13 06 02 11 15 12 09 07 03 10 05 00; ...
      15 12 08 02 04 09 01 07 05 11 03 14 10 00 06 13];
  
S2 = [15 01 08 14 06 11 03 04 09 07 02 13 12 00 05 10; ...
      03 13 04 07 15 02 08 14 12 00 01 10 06 09 11 05; ...
      00 14 07 11 10 04 13 01 05 08 12 06 09 03 02 15; ...
      13 08 10 01 03 15 04 02 11 06 07 12 00 05 14 09];
  
S3 = [10 00 09 14 06 03 15 05 01 13 12 07 11 04 02 08; ...
      13 07 00 09 03 04 06 10 02 08 05 14 12 11 15 01; ...
      13 06 04 09 08 15 03 00 11 01 02 12 05 10 14 07; ...
      01 10 13 00 06 09 08 07 04 15 14 03 11 05 02 12];
  
S4 = [07 13 14 03 00 06 09 10 01 02 08 05 11 12 04 15; ...
      13 08 11 05 06 15 00 03 04 07 02 12 01 10 14 09; ...
      10 06 09 00 12 11 07 13 15 01 03 14 05 02 08 04; ...
      03 15 00 06 10 01 13 08 09 04 05 11 12 07 02 14];
  
S5 = [02 12 04 01 07 10 11 06 08 05 03 15 13 00 14 09; ...
      14 11 02 12 04 07 13 01 05 00 15 10 03 09 08 06; ...
      04 02 01 11 10 13 07 08 15 09 12 05 06 03 00 14; ...
      11 08 12 07 01 14 02 13 06 15 00 09 10 04 05 03]; 
  
S6 = [12 01 10 15 09 02 06 08 00 13 03 04 14 07 05 11; ...
      10 15 04 02 07 12 09 05 06 01 13 14 00 11 03 08; ...
      09 14 15 05 02 08 12 03 07 00 04 10 01 13 11 06; ...
      04 03 02 12 09 05 15 10 11 14 01 07 06 00 08 13];
  
S7 = [04 11 02 14 15 00 08 13 03 12 09 07 05 10 06 01; ...
      13 00 11 07 04 09 01 10 14 03 05 12 02 15 08 06; ...
      01 04 11 13 12 03 07 14 10 15 06 08 00 05 09 02; ...
      06 11 13 08 01 04 10 07 09 05 00 15 14 02 03 12];
  
S8 = [13 02 08 04 06 15 11 01 10 09 03 14 05 00 12 07; ...
      01 15 13 08 10 03 07 04 12 05 06 11 00 14 09 02; ...
      07 11 04 01 09 12 14 02 00 06 10 13 15 03 05 08; ...
      02 01 14 07 04 10 08 13 15 12 09 00 03 05 06 11];
      
E = [32 01 02 03 04 05; ...
     04 05 06 07 08 09; ...
     08 09 10 11 12 13; ...
     12 13 14 15 16 17; ...
     16 17 18 19 20 21; ...
     20 21 22 23 24 25; ...
     24 25 26 27 28 29; ...
     28 29 30 31 32 01];
 
P = [16 07 20 21 ...
     29 12 28 17 ...
     01 15 23 26 ...
     05 18 31 10 ...
     02 08 24 14 ...
     32 27 03 09 ...
     19 13 30 06 ...
     22 11 04 25];
%  Se expanden los 32 bits de Ri
E_Ri = Ri_f(reshape(E', [], 48))
kf_f
% Operaci�n XOR entre E(Ri) y su respectiva llave (Ki)
xor_ERi = bitxor(str2num(E_Ri'), str2num(kf_f'));
xor_ERi = num2str(xor_ERi');
xor_ERi(xor_ERi == ' ') = []
% % Se hace el descompone la cadena de bits de E(Ri) +o Ki
% % en 8 bloques de 6 bits
% Se inicializan variables auxiliares
Bi = zeros(1,6);
indx = 1;
S = zeros(size(S1));
% Array que concatena los resultados de las salidas de las cajas
S_concat = [];
% Se hace un barrido de cada caja Si, i = 1:8
for n = 1:8
    switch n
        case 1
            S = S1;
        case 2
            S = S2;
        case 3 
            S = S3;
        case 4
            S = S4;
        case 5
            S = S5;
        case 6
            S = S6;
        case 7
            S = S7;
        case 8
            S = S8;
        otherwise
            fprintf('Uy!');
    end
    Bi = xor_ERi(indx:indx + 5);
    indx = indx + 6;
    fila = (Bi(1) - 48) * 2 + Bi(6) - 48;
    columna = (Bi(2) - 48) * 8 + (Bi(3) - 48) * 4 + (Bi(4) - 48) * 2 + Bi(5) - 48;
    valor_caja = S(fila + 1, columna + 1);
    valor_caja = num2str(dec2bin(valor_caja, 4));
    valor_caja(valor_caja == ' ') = [];
    S_concat = [S_concat valor_caja];
end
% Retorna la permutaci�n de la funci�n de Feistel
feistel_func = S_concat(P);
return;