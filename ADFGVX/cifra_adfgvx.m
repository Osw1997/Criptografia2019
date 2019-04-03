% % % Cifra ADFGVX
% Se crea la matriz ADFGVX
matriz = ['C' 'Z' 'X' 'M' 'W' 'O'; '1' 'P' 'Q' 'T' '2' '3'; 'B' 'F' 'D' '4' '7' 'N'; '5' 'L' '6' 'K' '8' 'A'; 'E' '9' 'G' '0' 'H' 'Y';'S' 'V' 'I' 'J' 'R' 'U'];
% La famosa cifra 
cifra = 'ADFGVX';
% Texto a cifrar
texto = input('Texto a cifrar: ', 's');
% texto = 'manana en la batalla piensa en mi';
% Texto a mayúsculas
texto = upper(texto);
% Se quitan los espacios
texto(texto == ' ') = [];
% Se quitan los ACENTOS
texto(texto == 'Á') = 'A';
texto(texto == 'É') = 'E';
texto(texto == 'Í') = 'I';
texto(texto == 'Ó') = 'O';
texto(texto == 'Ú') = 'U';
texto(texto == 'Ñ') = 'N';
% Longitud del texto
long_texto = length(texto);
% Se crea un vector que almacena la cadena cifrada
texto_cifrado = zeros(1, 2 * long_texto);
% % Se hace el mapeo de cada letra por un par de la matriz
% Un índice que maneja el índice de la cadena a cifrar (n + 2)
indx_cifra = 1;
for n = 1:long_texto
    [fila, col] = find(matriz == texto(n));
    texto_cifrado(indx_cifra : indx_cifra + 1) = [cifra(fila) cifra(col)];
    indx_cifra = indx_cifra + 2;
end
% Cast a char
texto_cifrado = char(texto_cifrado);
% Longitud del texto parcialmente cifrado
long_cifrado = length(texto_cifrado);
% Clave a usar en la transposición
clave = input('Clave: ', 's');
% clave = 'Taco';
clave = upper(clave);
long_clave = length(clave);
% Se crea una matriz que almacena el texto cifrado dividido
% matriz_clave = zeros( ceil(long_cifrado/long_clave ), long_clave);
% % Se acomoda el texto cifrado en la matriz
% Si el texto cifrado no es mútiplo de 4, se rellena para que lo sea
while(1)
    if(~mod(long_cifrado, long_clave))
        break;
    end
    texto_cifrado = [texto_cifrado 'X'];
    long_cifrado = length(texto_cifrado);
end
% Se redimiensiona el texto
matriz_clave = reshape(texto_cifrado, [long_clave, ceil(long_cifrado/long_clave )])'
% Se acomoda la clave en orden alfabético
clave_ord = sort(clave);
indx_clave = 0;
for n = 1:long_clave
    indx_clave = find(clave == clave_ord(n));
    matriz_final(:,n) = matriz_clave(:,indx_clave(1));
end
texto_cifrado = [];
for n = 1: ceil(long_cifrado/long_clave )
    texto_cifrado =  [texto_cifrado matriz_final(n,:)];
end
fprintf('Texto cifrado: %s\n', texto_cifrado);
% Se Guarda el texto cifrado
id = fopen('cadfgvx_.txt', 'w');
fprintf(id, texto_cifrado);
fclose(id);