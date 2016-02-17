gather_.tbl_HS2 =
  function() {
    stopif(convert || factor_key, "Not supported yet")
    tmp =
      reduce(
        map(
          gather_cols,
          function(col)
            transmute_(
              .data = data,
              .dots =
                c(
                  setdiff(colnames(data), gather_cols),
                  setNames(col, key_col),
                  setNames(
                    list(interp(~col, col = as.name(col))), value_col)))),
        dplyr::union)
    if(na.rm)
      filter_(tmp, interp(~!is.null(value_col), value_col = as.name(value_col)))
    else
      tmp}

formals(gather_.tbl_HS2) = formals(tidyr::gather_)

spread_.tbl_HS2 =
  function() {
    new_cols = unlist(collect(distinct_(select_(data, key_col))))
    reduce(
      c(
        list(
          select_(
            data,
            interp(~-key_col, key_col = as.name(key_col)),
            interp(~-value_col, value_col = as.name(value_col)))),
        map(
          new_cols,
          function(col)
            rename_(
              select_(
                filter_(
                  data,
                  .dots = interp(~key_col == col, key_col = as.name(key_col), col = col)),
                .dots =
                  interp(~-key_col, key_col = as.name(key_col))),
              .dots = setNames(value_col, col)))),
      left_join)}

formals(spread_.tbl_HS2) = formals(tidyr::spread_)
