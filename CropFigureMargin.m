f = figure;
plot(rand(4))
 %Make the "page" just big enough to hold the size output I want
f.PaperSize = [2 2];
% Specify that we start at the lower-left corner of the page
f.PaperPosition(3:4) = [2 2];
f.PaperPosition(1:2) = [0 0];
print -dpdf foo2.pdf
