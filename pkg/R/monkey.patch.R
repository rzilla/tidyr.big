patched.spread_ =
  function (data, key_col, value_col, fill = NA, convert = FALSE,
            drop = TRUE)
  {
    if (!(key_col %in% colnames(data))) {
      stop("Key column '", key_col, "' does not exist in input.",
           call. = FALSE)
    }
    if (!(value_col %in% colnames(data))) {
      stop("Value column '", value_col, "' does not exist in input.",
           call. = FALSE)
    }
    UseMethod("spread_")
  }

.onLoad = function(lib, pkg) {
  utils::assignInNamespace(
    x = "spread_",
    ns = "tidyr",
    value = patched.spread_)}
