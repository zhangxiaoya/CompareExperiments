function imageNames = loadImages(folder, forMat)

  files = dir( fullfile(folder, ['*' forMat]) );

  nm = {files.name};
  S = sprintf('%s,', nm{:});
  D = sscanf(S, ['%d' forMat ',']);
  [~, sortIndex] = sort(D);
  sorted_nm = nm(sortIndex);

  imageNames = cell(length(files), 1);

  for it_f = 1 : length(files)
    imageNames{it_f} = fullfile( folder, sorted_nm{it_f} );
  end
