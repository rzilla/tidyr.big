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
                  setNames(list(interp(~col, col = col)), key_col),
                  setNames(
                    list(interp(~col, col = as.name(col))), value_col)))),
        dplyr::union)
    if(na.rm)
      filter_(tmp, interp(~!is.null(value_col), value_col = as.name(value_col)))
    else
      tmp}

formals(gather_.tbl_HS2) = formals(tidyr::gather_)

# we don't support tbl_sql quite yet, but this doesn't need special UDFs so
# I am going to keep it around
spread_.tbl_sql =
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
            data %>%
            filter_(
              .dots = interp(~key_col == col, key_col = as.name(key_col), col = col)) %>%
            select_(.dots = interp(~-key_col, key_col = as.name(key_col))) %>%
            rename_(
              .dots = setNames(value_col, col)))),
      left_join)}

# this needs the brickouse UDFs
spread_.tbl_HS2 =
  function() {
    other_cols = setdiff(colnames(data), c(key_col, value_col))
    new_cols = unlist(collect(distinct_(select_(data, key_col))))
    data %>%
      group_by_(.dots = other_cols) %>%
      summarize_(
        .dots =
            list(
              valuemap =
                interp(
                  ~collect(key_col, value_col),
                  key_col = as.name(key_col),
                  value_col = as.name(value_col)))) %>%
      transmute_(
        .dots =
          c(other_cols,
            setNames(
              map(
                new_cols,
                function(col)
                  interp(~valuemap[col], col = col)),
              new_cols)))}

formals(spread_.tbl_HS2) = formals(tidyr::spread_)
