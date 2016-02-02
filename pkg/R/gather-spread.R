
gather_.default =
  function() {
    stopif(
      na.rm || convert || factor_key,
      "Not supported yet")
    reduce(
      map(
        gather_cols,
        function(col)
          transmute_(
            .data = data,
            .dots =
              c(
                setdiff(colnames(data), gather_cols),
                setNames(~col, key_col),
                setNames(col, value_col)))),
      dplyr::union)}

formals(gather_.default) = formals(tidyr::gather_)

spread_.default =
  function() {
    new_cols = unlist(collect(distinct_(select_(data, key_col))))
    reduce(
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
            .dots = setNames(value_col, col))),
      inner_join)}

formals(spread_.default) = formals(tidyr::spread_)
