% % Descifra ADFGVX
clc; clear all;
id = fopen('cifradoADFGVX.txt','r');
% id = fopen('cadfgvx_.txt','r');
texto_cifrado = upper(fscanf(id, '%c'));
long_frase = length(texto_cifrado);
fclose(id);
% Clave
clave = input('Clave: ', 's');
% clave = 'Taco';
clave = upper(clave);
long_clave = length(clave);
% Se convierte el texto en matriz
cols = long_clave;
filas = long_frase/long_clave;
matriz_clave = reshape(texto_cifrado, [cols, filas])';
% Se reordena según la clave 
clave_ord = sort(clave);
for n = 1:long_clave
    matriz_adfgvx(:,n) = matriz_clave(:,find(clave_ord == clave(n)));
end
% Se convierte en una cadena
texto_cifrado = [];
for n = 1:filas
    texto_cifrado =  [texto_cifrado matriz_adfgvx(n,:)];
end
% Se crea la matriz ADFGVX
matriz = ['C' 'Z' 'X' 'M' 'W' 'O'; '1' 'P' 'Q' 'T' '2' '3'; 'B' 'F' 'D' '4' '7' 'N'; '5' 'L' '6' 'K' '8' 'A'; 'E' '9' 'G' '0' 'H' 'Y';'S' 'V' 'I' 'J' 'R' 'U'];
% La famosa cifra 
cifra = 'ADFGVX';
% Se mapean los caracteres del texto cifrado según la matriz ADFGVX
% Un índice que maneja el índice de la cadena a cifrar (n + 2)
indx_cifra = 1;
original = [];
for n = 1:long_frase/2
%     [fila, col] = find(matriz == texto(n));
    fila = find(cifra == texto_cifrado(indx_cifra));
    columna = find(cifra == texto_cifrado(indx_cifra + 1));
    original = [original matriz(fila, columna)];
    indx_cifra = indx_cifra + 2;
end
original