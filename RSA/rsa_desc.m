% % Descifrado

dicc_let = ['A':'N' '�' 'O':'Z' '0':'9' '����� .,�?�!";�'];
% N�meros para el descifrado proporcionados por el otro sujeto
% Para rsaRafa.txt
% e = 3185163659;
% n =  10617418249;
% Para cif_rsa.txt
e = 5;
n = 55328440151;
% Se leen los n�meros a descifrar
% id = fopen('rsaRafa.txt', 'r');
id = fopen('cif_rsa.txt', 'r');
msj_cif = upper(fscanf(id, '%c'));
fclose(id);
% Se asume que lo n�meros est�n divididos por una coma, as� que se separan
% de coma en coma.
msj = char(strsplit(msj_cif,',')');
msj(end,:) = [];
msj = str2num(msj);
% Arrays auxiliares para el descifrado
array_rsa_des = zeros(1,filas);
% Seg�n lo que el otro sujeto diga, el n�mero de d�gitos por bloque de 5
% letras, ser� representado por la sig. constante. (en clase: 10 d�gitios)
max_digitos = 10;
pre_msj = zeros(filas,max_digitos);
for m = 1:filas
%     array_rsa_des(m) = powermod(array_rsa(m), e, n);
    array_rsa_des(m) = powermod(msj(m), e, n);
%     Si no es un n�mero de 10 d�gitos, se rellena de ceros al inicio.
    if (length(num2str(array_rsa_des(m))) ~= max_digitos)
        pre_msj(m, 1:max_digitos) = [repmat('0', [1, max_digitos - mod(length(num2str(array_rsa_des(m))), max_digitos)]) num2str(array_rsa_des(m))];
%         pre_msj(m, 1:max_digitos) = ['0' num2str(array_rsa_des(m))];
    else
        pre_msj(m, 1:max_digitos) = num2str(array_rsa_des(m));
    end
end
% Se castea los enteros a chars
% char(pre_msj)
% Ya que es una matriz de n filas por 10 d�gitos (max_digitos), se
% convierte a un simple vector de n*max_digitos caracteres.
pre_msj = reshape(char(pre_msj)', [1, max_digitos * filas]);
% Se convierte cada par de d�gitos a su caracter
long_msj = length(pre_msj) / 2;
indx = 1;
msj_final = [];
% Se toman 2 d�gitos por cada letra hasta terminar con el vector.
for m = 1:long_msj
    msj_final = [msj_final dicc_let(str2num(pre_msj(indx : indx + 1)))];
    indx = indx + 2;
end
% Se muestra el mensaje descifrado :D
msj_final = char(msj_final)