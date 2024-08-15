%create a line that displays "left" when there is a left mouse click and
%creates a context menu when there is a right mouse click

p=plot(1:10);
p.ButtonDownFcn = @left;
p.UIContextMenu = right;

function left(src,event)
    f = src.Parent.Parent
    f.SelectionType
    if ~strcmp(f.SelectionType, 'alt')
        disp('left')
    end
end

function cmHandle = right
   cmHandle = uicontextmenu;
   uimenu(cmHandle,'Label','option1');
   uimenu(cmHandle,'Label','option2');
end