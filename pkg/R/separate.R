separate_.tbl_HS2 =
  function() {
    select_(
      mutate_(
        data,
        .dots =
          setNames(
            map(
              seq_along(into), function(i) interp(~split(col, sep)[j], col = as.name(col), j = i -1)),
            into)),
      interp(~-col, col = as.name(col)))}

formals(separate_.tbl_HS2) = formals(tidyr::separate_)

