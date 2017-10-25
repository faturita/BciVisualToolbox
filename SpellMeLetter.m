function Letter = SpellMeLetter(row,col)
%
% Returns the selected keystrokes based on binary classification selected
% predictions (on SC(channel).predicted) on a channel-by-channel basis.

SPELLERMATRIX = { { 'A','B','C','D','E','F'},
                { 'G','H','I','J','K','L'},
                { 'M','N','O','P','Q','R'},
                { 'S','T','U','V','W','X'},
                { 'Y','Z','1','2','3','4'},
                { '5','6','7','8','9','_'}};


%%
Letter= SPELLERMATRIX{row}{col-6};

end