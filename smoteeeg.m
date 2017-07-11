function signals = smoteeeg(signal1, signal2,Fs, nofsignals)

signals=zeros(Fs,nofsignals);
% 
% original_mark=[1;1];
% for j=1:Fs
%     original_features=[signal1(j);signal2(j)];
%     [final_features ~]=smote(original_features, original_mark);
%     for k=1:length(final_features)
%         signals(k,j)=final_features(k);
%     end
% end
% 
% for j=1:Fs
%     original_features=[signals(2,j);signals(3,j)];
%     [final_features ~]=smote(original_features, original_mark);
%     for k=1:length(final_features)
%         signals(k+4,j)=final_features(k);
%     end
% end

u = rand(nofsignals,1);

for j=1:Fs
    for k=1:nofsignals
        signals(j,k)=signal1(j)*u(k)+signal2(j)*(1-u(k));
    end
end


end