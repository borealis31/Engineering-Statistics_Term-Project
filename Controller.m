clear
book_shelf(1) = book('text_files/pp.txt','Pride and Prejudice')
book_shelf(2) = book('text_files/staveone.txt','Stave One')
%book_shelf(1).vis_hist
%book_shelf(1).vis_box
book_shelf(2).vis_all
%sum(vertcat(book_shelf.mu))
Table_Column_Labels = {1,numel(book_shelf)};
for idx_cell = numel(book_shelf):-1:1
    Table_Column_Labels{idx_cell} = book_shelf(idx_cell).book_title;
end
clear idx_cell
Table_Books = table(vertcat(book_shelf.mu),vertcat(book_shelf.med),vertcat(book_shelf.mode),...
          'VariableNames',{'Mean','Median','Mode'},'RowNames',Table_Column_Labels)

