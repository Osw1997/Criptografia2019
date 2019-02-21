% % % Creamos el cuadro Vigenere
alfabeto = 'ABCDEFGHIJKLMN�OPQRSTUVWXYZ';
long_alfa = length(alfabeto);
cuadro_vig = zeros(long_alfa,long_alfa); 
% Corrimiento del alfabeto
for n = 1:long_alfa + 1
    for m = 1:long_alfa
        cuadro_vig(n,m) = alfabeto(mod(n - 2 + m, long_alfa) + 1);
    end
end
% Se convierte a char
cuadro_vig = char(cuadro_vig);
% Se extrae el texto de un txt
id = fopen('txt.txt', 'r');
frase = upper(fscanf(id, '%c'));

% frase = upper('en lo personal 6');
% frase = 'pasame la tarea de criptografia';
% Se quitan los espacios, comas y puntos
frase(frase == ' ') = [];
frase(frase == ',') = [];
frase(frase == '.') = [];
frase(frase == ':') = [];
frase(frase == ';') = [];
frase(frase == char(13)) = [];
frase(frase == '�') = 'A';
frase(frase == '�') = 'E';
frase(frase == '�') = 'I';
frase(frase == '�') = 'O';
frase(frase == '�') = 'U';


% Contrase�a
% pass = input('Contrase�a: ', 's');
pass = 'se�or';


id = fopen('cod_vig.txt', 'w');
% fprintf(id, txt);
% fclose(id);
indx_pwd = 0;
for n = 1:length(frase)
    if(frase(n) ~= ' ' && frase(n) - 0 > 57)
        indx_pwd = indx_pwd + 1;
%     Coordenada Y
        if (mod(indx_pwd, length(pass) + 1) == 0)
            indx_pwd = 1;
        end
        y = find(cuadro_vig(1 : end - 1, 1) == upper( pass(indx_pwd) ));
%         Coordenada X
        x = find(cuadro_vig(1,:) == upper( frase(n) ));
%         fprintf('[%c - %c]\n', cuadro_vig(y,x), frase(n));
%         pause();
        fprintf(id, cuadro_vig(y,x));
    else
%         fprintf(' ');
        fprintf(id, char(frase(n)));
    end
end
fclose(id);
% pause();
fprintf('\n'); 
