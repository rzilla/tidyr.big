replace_na.tbl_HS2 =
  function(){
    mutate_(
      data,
      .dots =
        setNames(
          map(
            names(replace),
            function(var)
            interp(~coalesce(var, val), var = as.name(var), val =replace[[var]])),
          names(replace)))
  }

formals(replace_na.tbl_HS2) = formals(tidyr::replace_na)
