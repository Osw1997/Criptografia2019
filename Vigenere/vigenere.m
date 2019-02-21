% % % Creamos el cuadro Vigenere
alfabeto = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ';
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
frase = fscanf(id, '%c');
% Se quitan los espacios, comas y puntos
frase(frase == ' ') = [];
frase(frase == ',') = [];
frase(frase == '.') = [];
% Contraseña
% pass = input('Contraseña: ', 's');
pass = 'nubes';

indx_pwd = 0;
for n = 1:length(frase)
    if(frase(n) ~= ' ')
        indx_pwd = indx_pwd + 1;
%     Coordenada Y
        if (mod(indx_pwd, length(pass) + 1) == 0)
            indx_pwd = 1;
        end
        y = find(cuadro_vig(:,1) == upper( pass(indx_pwd) ));
%         Coordenada X
        x = find(cuadro_vig(1,:) == upper( frase(n) ));
%         fprintf('%c', cuadro_vig(y,x));
    else
%         fprintf(' ');
    end
end
fprintf('\n'); 

% Se buscan secuencias de palabras
% lon_frase = length(frase); 
alfabeto = 'XYZHOLAPERROXYZQKXYZHOLAHOLA';
lon_frase = length(alfabeto);
% for n = 1:floor(lon_frase/2)
%     
% end
l_coin = 3;
% % Diccionario de coincidencias
% 3 letras
diccio3 = [];
frecue3 = [];

for n = 1:lon_frase - l_coin + 1
    % Bandera que avisa si existe o no la frase
    flag = 0;
    coinci = alfabeto(n : n + l_coin - 1);
%     Se comprueba que la nueva frase a analizar no se haya analizado
    [f,c] = size(diccio3);
    for i = 1:f
        if (strcmp( diccio3(i, 1:l_coin ), coinci ))
            flag = 1; disp('Entro');
            break;
        end
    end 
%     Si NO existe, entonces SI se analiza
    if(~flag)
    %     Se inicializa el vector de coincidencias 
        igual = [];
    %     Se recorre el texto en busca de coincidencias
        for m = 1:lon_frase - l_coin + 1
            if ( strcmp( coinci, alfabeto(m : m + l_coin - 1) ) )
                igual = horzcat(igual, m)
                
                flag_i = 0;
                [f,c] = size(diccio3);
                for i = 1:f
                    if (strcmp( diccio3(i, 1:l_coin ), coinci ))
                        flag_i = 1; disp('Entro');
                        break;
                    end
                end                 
    %             Si el número de coincidencias es mayor a 2 (al menos una coincidencia a parte de sí misma)
                if (length(igual) > 1 )
                    if ( ~flag_i )
                        diccio3 = vertcat(diccio3, coinci);
                        frecue3 = horzcat(frecue3, -1);
                    end                    
                    frecue3 = horzcat(frecue3, igual);
                    flag_i = 0;
%                     pause();
                end                
    %             igual
    %             disp(1)
%                 frecue3 = vertcat(frecue3, igual);
% frecue3 = horzcat(frecue3, -1);
            end
%             frecue3 = horzcat(frecue3, -1);
        end
%         frecue3 = horzcat(frecue3, -1);
    %     break;
    end
end

% Vector de indices 
frec = [];
for n = 1:length(frecue3)
    if (frecue3(n) == -1)
       fprintf('\n'); 
    else
        fprintf('%d', frecue3(n));
    end
end