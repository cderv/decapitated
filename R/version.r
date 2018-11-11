#' Get Chrome version
#'
#' @md
#' @param quiet if `TRUE`, no messages are displayed
#' @param chrome_bin the path to Chrome (auto-set from `HEADLESS_CHROME` environment variable)
#' @return the Chrome version string (invisibly)
#' @export
#' @examples
#' chrome_version()
chrome_version <- function(quiet = FALSE, chrome_bin=Sys.getenv("HEADLESS_CHROME")) {
  if(.Platform$OS.type == "windows") {
    cmd <- "powershell"
    powershell_cmd <- sprintf("(Get-Item -Path '%s').VersionInfo.ProductVersion", chrome_bin)
    args <- c(
      "-NoLogo",
      "-NoProfile",
      "-Command",
      powershell_cmd
    )
  } else {
    cmd <- chrome_bin
    args <- "--version"
  }
  res <- processx::run(cmd, args)
  if (!quiet) message(res$stdout)
  return(invisible(trimws(res$stdout)))
}