separate_.tbl_HS2 =
  function() {
    stopif(is.integer(sep), "integer separator nor supported yet")
    stopif(
      !remove || convert || extra != "warn" || fill != "warn",
      "additional arguments not supported yet")
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

unite_.tbl_HS2 =
  function(){
    stopif(!remove, "remove not supported yet")
    concat_all = as.call(c(as.name("concat_ws"), as.list(sep), unname(map(from, as.name))))
    mutate_(data, .dots = setNames(list(interp(~z, z = concat_all)), col))}

formals(unite_.tbl_HS2) = formals(tidyr::unite_)
