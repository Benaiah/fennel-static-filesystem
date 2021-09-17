(require :lfs)

(each [filename (lfs.dir (lfs.currentdir))]
  (print filename))
