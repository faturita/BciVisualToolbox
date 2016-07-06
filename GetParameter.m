function  value=GetParameter(parameterName)

switch (parameterName)
    case 'MAXSIZE' 
        value=900;
    case 'verbose'
        value=1;
    case 'cached'
        value = 1;
    case 'experimentRange'
        value=1:2
    case 'subjectRange'
        value=1:10
    case 'channelRange'
        value=1:14
        
     otherwise
        value = 0;
end

end
