book_shelf_female(1) = book('text_files\FEMALE\1. Woolf\reader.txt','The Common Reader','Virginia Woolf');
book_shelf_female(end+1) = book('text_files\FEMALE\1. Woolf\room.txt','Jacobs Room','Virginia Woolf');
book_shelf_female(end+1) = book('text_files\FEMALE\1. Woolf\bond_street.txt','Mrs. Dalloway in Bond Street','Virginia Woolf');
book_shelf_female(end+1) = book('text_files\FEMALE\2. Wharton\moon.txt','The Glimpses of the Moon','Edith Wharton');
book_shelf_female(end+1) = book('text_files\FEMALE\2. Wharton\mirth.txt','The House of Mirth','Edith Wharton');
book_shelf_female(end+1) = book('text_files\FEMALE\2. Wharton\sanctuary.txt','Sanctuary','Edith Wharton');
book_shelf_female(end+1) = book('text_files\FEMALE\3. Richardson\deadlock.txt','Deadlock: Pilgrimage, Volume 6','Dorothy Richardson');
book_shelf_female(end+1) = book('text_files\FEMALE\3. Richardson\honeycomb.txt','Honeycomb: Pilgrimage, Volume 3','Dorothy Richardson');
book_shelf_female(end+1) = book('text_files\FEMALE\3. Richardson\interim.txt','Interim: Pilgrimage, Volume 5','Dorothy Richardson');
book_shelf_female(end+1) = book('text_files\FEMALE\4. Mansfield\bliss.txt','Bliss, and Other Stories','Katherine Mansfield');
book_shelf_female(end+1) = book('text_files\FEMALE\4. Mansfield\garden.txt','The Garden Party, and Other Stories','Katherine Mansfield');
book_shelf_female(end+1) = book('text_files\FEMALE\4. Mansfield\german.txt','In a German Pension','Katherine Mansfield');
book_shelf_female(end+1) = book('text_files\FEMALE\5. Chopin\awakening.txt','The Awakening, and Selected Short Stories','Kate Chopin');
book_shelf_female(end+1) = book('text_files\FEMALE\5. Chopin\bayou.txt','Bayou Folk','Kate Chopin');
book_shelf_female(end+1) = book('text_files\FEMALE\5. Chopin\fault.txt','At Fault','Kate Chopin');
book_shelf_female(end+1) = book('text_files\FEMALE\6. Hall\twixt.txt','Twixt Earth and Stars','Radclyffe Hall');
book_shelf_female(end+1) = book('text_files\FEMALE\6. Hall\countries.txt','Songs of Three Counties','Radclyffe Hall');
book_shelf_female(end+1) = book('text_files\FEMALE\6. Hall\sheaf.txt','A Sheaf of Verses','Radclyffe Hall');
book_shelf_female(end+1) = book('text_files\FEMALE\7. Hurston\poker.txt','Poker!','Zora Neale Hurston');
book_shelf_female(end+1) = book('text_files\FEMALE\7. Hurston\plays.txt','Three Plays','Zora Neale Hurston');
book_shelf_female(end+1) = book('text_files\FEMALE\7. Hurston\turkey.txt','De Turkey and De Law','Zora Neale Hurston');
book_shelf_female(end+1) = book('text_files\FEMALE\8. Lowell\ghosts.txt','Men, Women and Ghosts','Amy Lowell');
book_shelf_female(end+1) = book('text_files\FEMALE\8. Lowell\sword.txt','Sword Blades and Poppy Seed','Amy Lowell');
book_shelf_female(end+1) = book('text_files\FEMALE\8. Lowell\coloured.txt','A Dome of Many-Coloured Glass','Amy Lowell');
book_shelf_female(end+1) = book('text_files\FEMALE\9. Millay\april.txt','Second April','Edna St. Vincent Millay');
book_shelf_female(end+1) = book('text_files\FEMALE\9. Millay\bell.txt','The Lamp and the Bell','Edna St. Vincent Millay');
book_shelf_female(end+1) = book('text_files\FEMALE\9. Millay\renascence.txt','Renascence','Edna St. Vincent Millay');
book_shelf_female(end+1) = book('text_files\FEMALE\10. Doolittle\sea_garden.txt','Sea Garden','Hilda Doolittle');
book_shelf_female(end+1) = book('text_files\FEMALE\10. Doolittle\hymen.txt','Hymen','Hilda Doolittle');
book_shelf_female(end+1) = book('text_files\FEMALE\10. Doolittle\heliodora.txt','Heliodora','Hilda Doolittle');
mass_lens_f = horzcat(book_shelf_female.word_lens_adj);

%Table Column Titles
Variable_Names_f = {'Mean','Median','Mode','Standard Deviation',...
    'Variation','Maximum','Minimum','Longest Word',...
    'Shortest Word','Number of Words'};

%Useful Variables
big_mu_f = [book_shelf_female.mu];
big_words_f = {book_shelf_female.longest};
small_words_f = {book_shelf_female.shortest};


%Table Initialization
Table_Books_f = table(big_mu_f',[book_shelf_female.med]',...
    [book_shelf_female.mode]',[book_shelf_female.std]',...
    [book_shelf_female.var]',[book_shelf_female.max]',...
    [book_shelf_female.min]',big_words_f',...
    small_words_f',[book_shelf_female.num_words]',...
    'VariableNames',Variable_Names_f,...
    'RowNames',{book_shelf_female.book_title});

big_words_f = big_words_f(cellfun(@(x) numel(x),big_words_f)==max(cellfun(@(x) numel(x),big_words_f)));
big_words_f = big_words_f(1);
small_words_f = small_words_f(cellfun(@(x) numel(x),small_words_f)==min(cellfun(@(x) numel(x),small_words_f)));
small_words_f = small_words_f(1);

Table_Overall_f = table(mean(big_mu_f),median(big_mu_f),mode(big_mu_f),...
    std(big_mu_f),(std(big_mu_f))^2,max(big_mu_f),min(big_mu_f),...
    big_words_f,small_words_f,sum([book_shelf_female.num_words]),...
    'VariableNames',Variable_Names_f,'RowNames',{'Overall (wrt Mean)'});


%Tables Write to Excel
writetable(vertcat(Table_Books_f,Table_Overall_f),'text_files\Results.xlsx','Sheet',2,'Range','A1','WriteRowNames',true);


%Author Selection Tools
%authors = regexp(fileread('text_files/modernists_female_ADJ.txt'), '\r?\n', 'split');
%rand_authors = authors(randperm(numel(authors),10));


clear big_words_f small_words_f Table_Books_f Table_Overall_f Variable_Names_f

