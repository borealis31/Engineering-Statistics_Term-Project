classdef book
    %Book: contains all properties of book type
    
    properties
        num_words
        mu
        mode
        med
        var
        std
        max
        min
        longest
        shortest
        file_path
        book_title
        author
        word_lens_adj
        %debug
    end
    
    properties (Access = private)
        stored_words
    end
    
    methods
        function obj = book(file_name, title, writer)
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
            text = regexprep(text,{'[_—1234567890]','--','[',']','{','}'},' ');

            
            %Separate into words based on spaces inbetween each word
            words = split(text)';
            clear text;
            
            
            %Remove symbols that are non-impacting
            words = regexprep(words, '[,''''".?!&:;-()`‘’”“*]','');

            
            %Store length of each word in parallel word_lens array
            word_lens = cellfun(@numel, words);

            
            %Remove 0 length words
            obj.word_lens_adj = word_lens(word_lens ~= 0);            
            
            %Store statistical observations of word lengths & words of interest
            obj.num_words = numel(obj.word_lens_adj);
            obj.mu = mean(obj.word_lens_adj);
            obj.mode = mode(obj.word_lens_adj);
            obj.med = median(obj.word_lens_adj,'all');
            obj.std = std(obj.word_lens_adj);
            obj.var = (obj.std)^2;
            obj.max = max(obj.word_lens_adj);
            obj.min = min(obj.word_lens_adj);
            obj.longest = words{word_lens == obj.max};
            obj.shortest = words{word_lens == obj.min};
            obj.file_path = file_name;
            obj.book_title = title;
            obj.author = writer;
            obj.stored_words = words;
            clear words word_lens;
        end
        
        function vis_hist(obj)
            histogram(obj.word_lens_adj)
            title(obj.book_title)
            hold on
            xline(obj.mu,'r','Mean')
            %xline(obj.mode,'y','Mode') unnecessary given the nature of a
            %histogram
            xline(obj.med,'b','Median')
            xlabel('Word Length')
            ylabel('Frequency')
            hold off
        end
        
        function vis_box(obj)
            boxchart(obj.word_lens_adj,'Orientation','horizontal','MarkerStyle','none')
            title(obj.book_title)
            hold on
            %plot(obj.mu,1,'or')
            xlabel('Word Length')
            hold off
        end
        
        function vis_all(obj)
            tiledlayout(2,2)
            nexttile([1 2])
            obj.vis_hist
            nexttile([1 2])
            obj.vis_box
        end
    end
end

