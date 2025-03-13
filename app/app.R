library(shiny)

# Panggil file UI dan server dari folder app
source("www/ui.R")
source("www/server.R")

# Jalankan aplikasi
shinyApp(ui = ui, server = server)