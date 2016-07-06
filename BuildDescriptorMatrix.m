% El algoritmo implementado elimina los repetidos incongruentes, los
% descriptores que tiene diferente label y son identicos.
function [M, IX] = BuildDescriptorMatrix(F,channel,labelRange,epochRange)

M = [];
IX = [];

for epoch=epochRange
    DESCRIPTORS = F(channel, labelRange(epoch), epoch).descriptors;
    M = [M DESCRIPTORS];
    
    for id=1:size(DESCRIPTORS,2)
        IX=[IX ;[channel labelRange(epoch) epoch id]];
    end
    
end
%disp('Tamaño de la matriz M');
originalsize = size(M,2);
% El siguiente proceso elimina los descriptores repetidos que PERTENECEN a
% muestras con LABELS diferentes.

% C es la matriz M sin descriptores repetidos.
[C,IM,IC] = unique(M','rows','stable');

% C = M(IM), M = C(IC)

% Busco los índices que fueron eliminados por unique.  Para eso recorro
% todo M y me fijo que índices no están en IM.
NOTinC = [];
for i=1:size(M,2)
    if ~ismember(i,IM)
        NOTinC = [NOTinC i];
    end
end
%disp('De la matrix M hay la siguiente cantidad de elementos que fueron removidos');
%size(NOTinC)
% IC tiene longitud de M (justamente porque sirve para reconstruirla).
% Ahora inC tiene los índices de C que corresponden a los descriptores que
% tenían originalmente repetidos, pero que fueron seleccionados para entrar
% en C.
inC=IC(NOTinC);


TODELETE=[];
for i=1:size(inC,1)
    % find me da la posición en IC del valor de inC(i).  Es decir el índice
    % original a M de cada secuencia de size(T) descriptores repetidos.
    T = find(IC==inC(i))';
    %T
    % Si los labels de los descriptores repetidos son más que uno, marco
    % todos.
    if (size(unique(IX(T,2)),1) > 1)
        for j=1:size(T,2)
                TODELETE = [TODELETE T(j)];
        end
    end
end

%disp('Elementos total que habría que borrar');
%size(TODELETE)
% Dejo sólo una lista de IDs a M sin repeticiones y ordenados de atrás para
% adelante.

TODELETE = unique(TODELETE);
TODELETE = sort(TODELETE,'descend');

%disp('Elementos no repetidos a borrar:');
%size(TODELETE,1)
%size(IX)
% Elimino esos ids de M y de IX.
for i=1:size(TODELETE,1)
    %i
    %size(TODELETE)
    %size(IX)
    %TODELETE(i)
    IX(TODELETE(i),:) = [];
    M(:,TODELETE(i)) = [];
end

% M es la nueva con elementos eliminados, y C era la original.
%[size(M,2) size(C',2)]
assert( size(M,2) >= size(C',2) );

assert( size(M,2) == originalsize );

% UFF
end