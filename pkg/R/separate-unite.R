separate_.tbl_HS2 =
  function() {
    stopif(is.integer(sep), "integer separator nor supported yet")
    stopif(
      convert || extra != "warn" || fill != "warn",
      "additional arguments not supported yet")
    tmp =
      collapse(
        mutate_(
          data,
          .dots = setNames(list(interp(~split(col, sep), col = as.name(col))), "pjezgdwlsd")))
    tmp =
      mutate_(
        tmp,
        .dots =
          setNames(
            map(seq_along(into), function(i) interp(~pjezgdwlsd[j], j = i - 1)),
            into))
    .dots = list(~-pjezgdwlsd)
    if(remove)
      .dots = c(.dots, list(interp(~-col, col = as.name(col))))
    select_(tmp,  .dots = .dots)}

formals(separate_.tbl_HS2) = formals(tidyr::separate_)

extract_.tbl_HS2 =
  function() {
      tmp =
        mutate_(
          data,
          .dots =
            setNames(
              map(
                seq_along(into), function(i) interp(~regexp_extract(col, regex, j), col = as.name(col), j = as.integer(i))),
              into))
      if(remove)
        select_(tmp, interp(~-col, col = as.name(col)))
      else
        tmp}

formals(extract_.tbl_HS2) = formals(tidyr::extract_)

unite_.tbl_HS2 =
  function(){
    stopif(!remove, "remove not supported yet")
    concat_all = as.call(c(as.name("concat_ws"), as.list(sep), unname(map(from, as.name))))
    mutate_(data, .dots = setNames(list(interp(~z, z = concat_all)), col))}

formals(unite_.tbl_HS2) = formals(tidyr::unite_)
