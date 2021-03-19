classdef book
    %Book: contains all properties of book type
    %num_words mean_len var_len std_len max_len min_len
    %longest_word shortest_word
    
    properties
        num_words
        mu
        var
        std
        max
        min
        longest
        shortest
        file
    end
    
    methods
        function obj = book(file_name)
            %Parse .txt file into text_lines then combine into a character array
            text_lines = regexp(fileread(file_name), '\r?\n', 'split');
            for idx_line = 1:numel(text_lines)-1
                if ~isempty(text_lines{idx_line})
                    temp = text_lines{idx_line};
                    temp(end+1) = ' ';
                    text_lines{idx_line} = temp;
                end
            end
            text = lower(horzcat(text_lines{:}));
            clear idx_line temp text_lines;
            
            %Detect and replace -- (2 hyphens used in place of an em-dash) with a space
            ems = find(text == '-');
            idxes_ems = [];
            for idx_ems = 1:numel(ems)-1
                if text(ems(idx_ems)+1) == '-'
                    idxes_ems(numel(idxes_ems)+1) = ems(idx_ems);
                end
            end
            text(idxes_ems) = ' ';
            clear idx_ems idxes_ems ems;
            
            %Replace underscores, em-dashes, and all numbers with spaces
            mass_comp = (text == '_')+(text == '—')+(text == '1')+(text == '2') ...
                +(text == '3')+(text == '4')+(text == '5')+(text == '6') ...
                +(text == '7')+(text == '8')+(text == '9')+(text == '0');
            text(logical(mass_comp)) = ' ';
            clear mass_comp;
            
            %Separate into words based on spaces inbetween each word
            words = split(text)';
            clear text;
            
            for idx_words = 1:numel(words)
                temp = words{idx_words};
                %Remove symbols that are non-impacting
                comp = (temp == ',') + (temp == '''') + (temp == '"') + (temp == '.') ...
                    + (temp == '?') + (temp == '!') + (temp == '&') + (temp == ':') ...
                    + (temp == ';') + (temp == '-') + (temp == '(') + (temp == ')');
                temp(logical(comp)) = [];
                words{idx_words} = temp;
            end
            clear idx_words temp comp;
            
            
            %Store length of each word in parallel word_lens array
            word_lens = zeros([1,numel(words)]);
            for idx_txt = 1:numel(words)
                temp = words{idx_txt};
                word_lens(idx_txt) = numel(temp);
            end
            clear idx_txt temp;
            
            %Remove 0 length words
            word_lens_adj = word_lens(word_lens ~= 0);
            
            %Calculate statistical observations of word lengths
            obj.num_words = numel(word_lens_adj);
            obj.mu = mean(word_lens_adj);
            obj.std = std(word_lens_adj);
            obj.var = (obj.std)^2;
            obj.max = max(word_lens_adj);
            obj.min = min(word_lens_adj);
            
            %Spit out longest and shortest word
            obj.longest = words{word_lens == obj.max};
            obj.shortest = words{word_lens == obj.min};
            obj.file = file_name;
            clear words word_lens word_lens_adj;
            
            
            %Stats = {num_words; mean_len; var_len; std_len; max_len; min_len;...
            %    longest_word; shortest_word};
            
            %Store vals from input cell array to properties
            %obj.sample_size = Stats{1};
            %obj.mu = Stats{2};
            %obj.var = Stats{3};
            %obj.std = Stats{4};
            %obj.max = Stats{5};
            %obj.min = Stats{6};
            %obj.longest = Stats{7};
            %obj.shortest = Stats{8};
        end
    end
end

