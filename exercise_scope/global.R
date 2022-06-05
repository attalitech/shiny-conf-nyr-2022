format_custom <- function(x){
  format(x, "%H:%M:%OS2")
}

time_4 <- Sys.time() %>% format_custom()
Sys.sleep(1)
