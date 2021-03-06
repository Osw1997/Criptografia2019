% Se lee el archivo a descifrar
id = fopen('cod_vig.txt', 'r');
frase = upper(fscanf(id, '%c'));
% Se buscan secuencias de palabras
% lon_frase = length(frase); 
% alfabeto = 'XYZHOLAPERROXYZQKXYZHOLAHOLA';
letra = 'ABCDEFGHIJKLMN�OPQRSTUVWXYZ';
Lalfa = length(letra);
alfabeto = upper(frase);
lon_frase = length(alfabeto);
% for n = 1:floor(lon_frase/2)
%     
% end
l_coin = 3;






factores = [];
for l_coin = 3:8
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
            flag = 1; 
%             disp('Entro');
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
                igual = horzcat(igual, m);
                
                flag_i = 0;
                [f,c] = size(diccio3);
                for i = 1:f
                    if (strcmp( diccio3(i, 1:l_coin ), coinci ))
                        flag_i = 1; 
%                         disp('Entro');
                        break;
                    end
                end                 
    %             Si el n�mero de coincidencias es mayor a 2 (al menos una coincidencia a parte de s� misma)
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
% s_vec = [];
% Vector de distancias
dist = [];
for n = 1:length(frecue3) - 1
    if (frecue3(n) == -1)
        s_vec = [];
%        fprintf('\n'); 
%         frec = horzcat(frec, frecue3);
% Debido al dise�o, se quitan los -1 y n�meros repetidos
        m = n + 1;
        while(1)
            if ( m > length(frecue3) || frecue3(m) == -1 )
                break;
            end
            s_vec = horzcat(s_vec, frecue3(m));
            m = m + 1;
        end
%     pause();
%     Se quitan los repetidos
    s_vec = unique(s_vec);
%     pause();
%     Si se encontr� m�s de 2 coincidencias en el texto
%     diff(combnk(s_vec,2)')
    dist = horzcat( dist, diff(combnk(s_vec,2)') );
%     else
%         fprintf('%d', frecue3(n));
%     pause();
    end
end

% % Una vez entradas las distantcias se encuentras sus 'factores'
% factores = [];
for n = 1:length(dist)
    factor = dist(n) - 1;
    while (factor > 2)
        if ( ~mod(dist(n), factor))
            factores = horzcat(factores, factor);
        end
        factor = factor - 1;
    end
end


end
% Longitud de la contrase�a
Lk = mode(factores); 
Lk = 4;
% Cadena del titulo
titulo = zeros(1,11);
titulo(1:10) = 'Letra no. ';
for m = 1:Lk
    % Vector de �ndices
    ind = m:Lk:length(frase);
    % Subtexto 1 de longitud Lk
    subtxt = frase(ind);
    % % Se miden la frecuencia de cada letra
    % Array de frecuencias de cada letra
    frec = zeros(1,Lalfa);
    for n = 1:Lalfa
        frec(n) = count(subtxt, letra(n));
    end
    % % Se plotea el resultado
    % Eje x
    x = [char('A':'N') '�' char('O':'Z')];
    % x = [('A' - 0 : 'N' - 0) '�' - 0 ('O' - 0 : 'Z' - 0)]
    figure();
    bar(categorical(num2cell(x), num2cell(x)), frec);
%     titulo = 'Letra no.'; 
    titulo(end) = char(m + '0'); 
    titulo = char(titulo);
    title(titulo); ylabel('Frecuencia');
end
% Frecuencia de letras en espa�ol
% frec_letras = [16927,2288,5362,6333,17036,844,1582,1388,7572,748,61,7022,4327,9097,0,11566,3493,1404,9005,9311,5671,5548,1477,27,218,1378,535];
frec_letras = [16927,2288,5362,6333,17036,844,1582,1388,7572,748,61,7022,4327,9097,338,11566,3493,1404,9005,9311,5671,5548,1477,27,218,1378,535];
figure();
bar(categorical(num2cell(x), num2cell(x)), frec_letras);
title('Frecuencia espa�ol'); ylabel('Frecuencia');
