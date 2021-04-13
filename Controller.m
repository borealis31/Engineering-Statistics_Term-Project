book_shelf(1) = book('text_files\MALE\1. Hesse\siddhartha.txt','Siddhartha','Herman Hesse');
book_shelf(end+1) = book('text_files\MALE\1. Hesse\gertrude.txt','Gertrude','Herman Hesse');
book_shelf(end+1) = book('text_files\MALE\1. Hesse\from_india.txt','From India','Herman Hesse');
book_shelf(end+1) = book('text_files\MALE\2. Powys\visions_and_revisions.txt','Visisons and Revisions','John Cowper Powys');
book_shelf(end+1) = book('text_files\MALE\2. Powys\suspended_judgements.txt','Suspended Judgements','John Cowper Powys');
book_shelf(end+1) = book('text_files\MALE\2. Powys\complex_vision.txt','The Complex Vision','John Cowper Powys');
book_shelf(end+1) = book('text_files\MALE\3. Lawrence\england_my_england.txt','England, My England','D.H. Lawrence');
book_shelf(end+1) = book('text_files\MALE\3. Lawrence\twilight_in_italy.txt','The White Peacock','D.H. Lawrence');
book_shelf(end+1) = book('text_files\MALE\3. Lawrence\white_peacock.txt','Twilight in Italy','D.H. Lawrence');
book_shelf(end+1) = book('text_files\MALE\4. Joyce\dubliners.txt','Dubliners','James Joyce');
book_shelf(end+1) = book('text_files\MALE\4. Joyce\exile.txt','Exiles: A Play in Three Acts','James Joyce');
book_shelf(end+1) = book('text_files\MALE\4. Joyce\ulysses.txt','Ulysses','James Joyce');
book_shelf(end+1) = book('text_files\MALE\5. Conrad\almayers_folly.txt','Almayers Folly','Joseph Conrad');
book_shelf(end+1) = book('text_files\MALE\5. Conrad\falk.txt','Falk','Joseph Conrad');
book_shelf(end+1) = book('text_files\MALE\5. Conrad\the_rover.txt','The Rover','Joseph Conrad');
book_shelf(end+1) = book('text_files\MALE\6. Fitzgerald\great_gatsby.txt','The Great Gatsby','F. Scott Fitzgerald');
book_shelf(end+1) = book('text_files\MALE\6. Fitzgerald\jazz_age.txt','Tales of the Jazz Age','F. Scott Fitzgerald');
book_shelf(end+1) = book('text_files\MALE\6. Fitzgerald\vegetable.txt','The Vegetable: or, From President to Postman','F. Scott Fitzgerald');
book_shelf(end+1) = book('text_files\MALE\7. Forster\room_w_view.txt','A Room With A View','E.M. Forster');
book_shelf(end+1) = book('text_files\MALE\7. Forster\angels.txt','Where Angels Fear to Tread','E.M. Forster');
book_shelf(end+1) = book('text_files\MALE\7. Forster\pharos.txt','Pharos and Pharilon','E.M. Forster');
book_shelf(end+1) = book('text_files\MALE\8. Gide\prom.txt','Le Promethee Mal Enchaine','Andre Gide');
book_shelf(end+1) = book('text_files\MALE\8. Gide\wilde.txt','Oscar Wilde','Andre Gide');
book_shelf(end+1) = book('text_files\MALE\8. Gide\ussr.txt','Return from the U.S.S.R.','Andre Gide');
book_shelf(end+1) = book('text_files\MALE\9. Hamsun\pan.txt','Pan','Knut Hamsun');
book_shelf(end+1) = book('text_files\MALE\9. Hamsun\markens.txt','Markens Grode (Growth of the Soil)','Knut Hamsun');
book_shelf(end+1) = book('text_files\MALE\9. Hamsun\siste.txt','Siste Glaede (Look Back on Happiness)','Knut Hamsun');
book_shelf(end+1) = book('text_files\MALE\10. Passos\initiation.txt','One Mans Initiation—1917','John Dos Passos');
book_shelf(end+1) = book('text_files\MALE\10. Passos\streets.txt','Streets of Night','John Dos Passos');
book_shelf(end+1) = book('text_files\MALE\10. Passos\soldiers.txt','Three Soldiers','John Dos Passos');
mass_lens = horzcat(book_shelf.word_lens_adj);

%Table Column Titles
Variable_Names = {'Mean','Median','Mode','Standard Deviation',...
    'Variation','Maximum','Minimum','Longest Word',...
    'Shortest Word','Number of Words'};

%Useful Variables
big_mu = [book_shelf.mu];
big_words = {book_shelf.longest};
small_words = {book_shelf.shortest};


%Table Initialization
Table_Books = table(big_mu',[book_shelf.med]',...
    [book_shelf.mode]',[book_shelf.std]',...
    [book_shelf.var]',[book_shelf.max]',...
    [book_shelf.min]',big_words',...
    small_words',[book_shelf.num_words]',...
    'VariableNames',Variable_Names,...
    'RowNames',{book_shelf.book_title});

big_words = big_words(cellfun(@(x) numel(x),big_words)==max(cellfun(@(x) numel(x),big_words)));
big_words = big_words(1);
small_words = small_words(cellfun(@(x) numel(x),small_words)==min(cellfun(@(x) numel(x),small_words)));
small_words = small_words(1);

Table_Overall = table(mean(big_mu),median(big_mu),mode(big_mu),...
    std(big_mu),(std(big_mu))^2,max(big_mu),min(big_mu),...
    big_words,small_words,sum([book_shelf.num_words]),...
    'VariableNames',Variable_Names,'RowNames',{'Overall (wrt Mean)'});


%Tables Write to Excel
writetable(vertcat(Table_Books,Table_Overall),'text_files\Results.xlsx','Sheet',1,'Range','A1','WriteRowNames',true);


%Author Selection Tools
%authors = regexp(fileread('text_files/modernists_female_ADJ.txt'), '\r?\n', 'split');
%rand_authors = authors(randperm(numel(authors),10));


clear big_words small_words Table_Books Table_Overall Variable_Names