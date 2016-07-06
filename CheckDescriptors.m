function CheckDescriptors(epoch,label,channel,descriptors)

if ( size( descriptors,2) ==0)
    fprintf ('Image e.%d.l.%d.c.%d = %d Empty!\n',epoch,label,channel,size( descriptors,2));
    error('Empty!');
elseif ( size( descriptors,2) <10 ) 
    fprintf ('Image e.%d.l.%d.c.%d = %d low info!\n',epoch,label,channel,size( descriptors,2));
else
    fprintf ('Image e.%d.l.%d.c.%d = %d!\n',epoch,label,channel,size( descriptors,2));
end

end