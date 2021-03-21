classdef book
    %Book: contains all properties of book type
    
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
        %debug
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
            
            
            %debug = regexprep(text,'[abcdefghijklmnopqrstuvwxyz''''""""`’‘;:,. 1234567890”“?!_--—()]','')
           
            
            %Replace underscores, em-dashes (including faux em-dashes), and all numbers with spaces
            text = regexprep(text,{'[_—1234567890]','--'},' ');

            
            %Separate into words based on spaces inbetween each word
            words = split(text)';
            clear text;
            
            
            %Remove symbols that are non-impacting
            words = regexprep(words, '[,''''".?!&:;-()`‘’”“*]','');

            
            %Store length of each word in parallel word_lens array
            word_lens = cellfun(@numel, words);

            
            %Remove 0 length words
            word_lens_adj = word_lens(word_lens ~= 0);
            
            %Store statistical observations of word lengths & words of interest
            obj.num_words = numel(word_lens_adj);
            obj.mu = mean(word_lens_adj);
            obj.std = std(word_lens_adj);
            obj.var = (obj.std)^2;
            obj.max = max(word_lens_adj);
            obj.min = min(word_lens_adj);
            obj.longest = words{word_lens == obj.max};
            obj.shortest = words{word_lens == obj.min};
            obj.file = file_name;
            clear words word_lens word_lens_adj;
            
        end
    end
end

