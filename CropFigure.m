function CropFigure(scale)
if (nargin<1)
    scale=4;
end

set(gca,'units','pixels'); % set the axes units to pixels
x = get(gca,'position'); % get the position of the axes
set(gcf,'units','pixels'); % set the figure units to pixels
y = get(gcf,'position'); % get the figure position
set(gcf,'position',[y(1)*scale y(2)*scale x(3)*scale x(4)*scale]);% set the position of the figure to the length and width of the axes
set(gca,'units','normalized','position',[0 0 1 1]); % set the axes units to pixel
end