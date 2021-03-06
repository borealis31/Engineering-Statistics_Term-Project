%DEPRECATED FUNCTION — SEE book.m FOR REVAMPED SET-UP
function Stats = Plain_Text_Parsing(file_name)
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
num_words = numel(word_lens_adj);
mean_len = mean(word_lens_adj);
std_len = std(word_lens_adj);
var_len = std_len^2;
max_len = max(word_lens_adj);
min_len = min(word_lens_adj);

%Spit out longest and shortest word
longest_word = words{word_lens == max_len};
shortest_word = words{word_lens == min_len};
clear words word_lens word_lens_adj;

Stats = {num_words; mean_len; var_len; std_len; max_len; min_len;...
    longest_word; shortest_word};
end