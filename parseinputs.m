%PARSEINPUTS    Support function for nearestneighbour
function [P, X, fIndexed, userParams] = parseinputs(userParams, varargin)
if length(varargin) == 1 || ~isnumeric(varargin{2})
    P           = varargin{1};
    X           = varargin{1};
    fIndexed    = true;
    varargin(1) = [];
else
    P             = varargin{1};
    X             = varargin{2};
    varargin(1:2) = [];

    % Check the dimensions of X and P
    if size(X, 1) ~= 1
        % Check to see whether P is in fact a vector of indices
        if size(P, 1) == 1
            try
                P = X(:, P);
            catch
                error('NearestNeighbour:InvalidIndexVector', ...
                    'Unable to index matrix using index vector');
            end
            fIndexed = true;
        else
            fIndexed = false;
        end % if size(P, 1) == 1
    else % if size(X, 1) ~= 1
        fIndexed = false;
    end

    if ~fIndexed && size(P, 1) ~= size(X, 1)
        error('NearestNeighbour:DimensionMismatch', ...
            'No. of rows of input arrays doesn''t match');
    end
end
% Parse the Property/Value pairs
if rem(length(varargin), 2) ~= 0
    error('NearestNeighbour:propertyValueNotPair', ...
        'Additional arguments must take the form of Property/Value pairs');
end

propertyNames = {'numberofneighbours', 'delaunaymode', 'triangulation', ...
    'radius'};
while length(varargin) ~= 0
    property = varargin{1};
    value    = varargin{2};

    % If the property has been supplied in a shortened form, lengthen it
    iProperty = find(strncmpi(property, propertyNames, length(property)));
    if isempty(iProperty)
        error('NearestNeighbour:InvalidProperty', 'Invalid Property');
    elseif length(iProperty) > 1
        error('NearestNeighbour:AmbiguousProperty', ...
            'Supplied shortened property name is ambiguous');
    end
    property = propertyNames{iProperty};

    switch property
        case 'numberofneighbours'
            if rem(value, 1) ~= 0 || ...
                    value > length(X) - double(fIndexed) || ...
                    value < 1
                error('NearestNeighbour:InvalidNumberOfNeighbours', ...
                    'Number of Neighbours must be an integer, and smaller than the no. of points in X');
            end
            userParams.NumberOfNeighbours = value;

        case 'delaunaymode'
            fOn = strcmpi(value, 'on');
            if strcmpi(value, 'off')
                userParams.DelaunayMode = 'off';
            elseif fOn || strcmpi(value, 'auto')
                if userParams.NumberOfNeighbours ~= 1
                    if fOn
                        warning('NearestNeighbour:TooMuchForDelaunay', ...
                            'Delaunay Triangulation method works only for one neighbour');
                    end
                    userParams.DelaunayMode = 'off';
                elseif size(X, 2) < size(X, 1) + 1
                    if fOn
                        warning('NearestNeighbour:TooFewDelaunayPoints', ...
                            'Insufficient points to compute Delaunay triangulation');
                    end
                    userParams.DelaunayMode = 'off';

                elseif size(X, 1) == 1
                    if fOn
                        warning('NearestNeighbour:DelaunayDimensionOne', ...
                            'Cannot compute Delaunay triangulation for 1D input');
                    end
                    userParams.DelaunayMode = 'off';
                else
                    userParams.DelaunayMode = value;
                end
            else
                warning('NearestNeighbour:InvalidOption', ...
                    'Invalid Option');
            end % if strcmpi(value, 'off')

        case 'radius'
            if isscalar(value) && isnumeric(value) && isreal(value) && value > 0
                userParams.Radius = value;
                if isempty(userParams.NumberOfNeighbours)
                    userParams.NumberOfNeighbours = size(X, 2) - double(fIndexed);
                end
            else
                error('NearestNeighbour:InvalidRadius', ...
                    'Radius must be a positive real number');
            end
    

        case 'triangulation'
            if isnumeric(value) && size(value, 2) == size(X, 1) + 1 && ...
                    all(ismember(1:size(X, 2), value))
                userParams.Triangulation = value;
            else
                error('NearestNeighbour:InvalidTriangulation', ...
                    'Triangulation not a valid Delaunay Triangulation');
            end
    end % switch property

    varargin(1:2) = [];
end % while
if isempty(userParams.NumberOfNeighbours)
    userParams.NumberOfNeighbours = 1;
end
end %parseinputs