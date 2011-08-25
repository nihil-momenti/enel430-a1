function [] = print_table(headings, formats, table)
  heading_lengths = zeros(length(headings));

  for i = 1:length(headings)-1
    heading_lengths(i) = length(headings{i});
    fprintf('  %s  |',headings{i})
  end
  heading_lengths(i+1) = length(headings{i+1});
  fprintf('  %s\n',headings{i+1});

  for i = 1:length(headings)-1
    fprintf(['--' repmat('-',1,heading_lengths(i)) '--+'])
  end
  fprintf(['--' repmat('-',1,heading_lengths(i+1)) '--\n']);

  for i = 1:length(table)
    for j = 1:length(formats)-1
      output_length = length(sprintf(formats{j}, table(i,j)));
      diff = heading_lengths(j) - output_length;
      fprintf(['  ' repmat(' ',1,floor(diff/2)) formats{j} repmat(' ',1,diff-floor(diff/2)) '  |'], table(i,j))
    end
    output_length = length(sprintf(formats{j+1}, table(i,j+1)));
    diff = heading_lengths(j+1) - output_length;
    fprintf(['  ' repmat(' ',1,floor(diff/2)) formats{j+1} repmat(' ',1,diff-floor(diff/2)) '\n'], table(i,j+1))
  end
  fprintf('\n')
